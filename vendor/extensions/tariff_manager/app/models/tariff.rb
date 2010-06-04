class Tariff < ActiveRecord::Base
  belongs_to :operator
  has_many :tariff_packages
  acts_as_list :scope => :operator
end
