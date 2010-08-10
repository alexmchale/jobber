require 'test_helper'

class DocumentTest < ActiveSupport::TestCase

  should belong_to :interview
  should validate_presence_of :name

  context "a document" do
    setup do
      @document1 = Factory(:document)
      @document2 = Factory(:document)
      @template = Factory(:template)
    end

    should "should have the correct name when loading from a template" do
      @document1.apply_from_template @template
      @document1.save!

      @document2.apply_from_template @template
      @document2.save!

      assert_equal @template.name, @document1.name
      assert_equal "#{@template.name} (2)", @document2.name
    end
  end

end
