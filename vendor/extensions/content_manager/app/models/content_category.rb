class ContentCategory < ActiveRecord::Base
  has_many :content_nodes, :foreign_key => :content_id
end
