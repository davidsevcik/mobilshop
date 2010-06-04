class Operator < ActiveRecord::Base
  has_many :tariffs
  acts_as_list
end
