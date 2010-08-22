class Document < ActiveRecord::Base

  belongs_to :interview

  has_many :document_patches
  alias :patches :document_patches

  validates_associated :interview
  validates_presence_of :name

  @@dmp = DiffMatchPatch.new

  def apply_from_template(template)
    self.name = template.name
    self.content = ""
    self.patch! nil, template.content

    while Document.find_by_name_and_interview_id(name, interview_id)
      index = index ? index+1 : 2
      self.name = "#{template.name} (#{index})"
    end
  end

  def current!
    self.interview.current_document = self
    self.interview.save!
    self
  end

  def patch!(source_patch, content)
    Document.transaction do
      self.save!
      self.lock!

      next_patch = self.patches.create!

      # Determine source content.
      source_patch = DocumentPatch.find_by_id(source_patch) unless source_patch.kind_of? DocumentPatch
      source_content = source_patch.andand.content.to_s

      # Determine previous content.
      previous_patch = self.patches.where("id < ?", next_patch.id).order(:id).last
      previous_patch.reload until !previous_patch || previous_patch.content
      previous_content = previous_patch.andand.content.to_s

      next_patch.content = @@dmp.merge(source_content, previous_content, content)
      self.content = next_patch.content

      self.save!
      next_patch.save!

      next_patch
    end
  end

  def last_patch
    self.patches.order(:created_at).last || self.patch!(nil, "")
  end

end
