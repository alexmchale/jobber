class Document < ActiveRecord::Base

  belongs_to :interview

  validates_associated :interview
  validates_presence_of :name

  def apply_from_template(template)
    self.name = template.name
    self.content = template.content

    while Document.find_by_name_and_interview_id(name, interview_id)
      index = index ? index+1 : 2
      self.name = "#{template.name} (#{index})"
    end
  end

end
