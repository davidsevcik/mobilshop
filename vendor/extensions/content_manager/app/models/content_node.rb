class ContentNode < ActiveRecord::Base
  belongs_to :category, :class_name => 'ContentCategory', :foreign_key => :category_id
  acts_as_list

  validates_presence_of :title
end
