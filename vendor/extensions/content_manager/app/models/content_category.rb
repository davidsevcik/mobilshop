class ContentCategory < ActiveRecord::Base
  has_many :content_nodes, :foreign_key => :content_id
  validates_presence_of :name
  validates_uniqueness_of :code
end
