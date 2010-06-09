class ContentNode < ActiveRecord::Base
  belongs_to :category, :class_name => 'ContentCategory', :foreign_key => :category_id
  has_many :images, :as => :viewable, :order => :position, :dependent => :destroy

  acts_as_list
  accepts_nested_attributes_for :images, :allow_destroy => true

  validates_presence_of :title, :category_id


end
