class Tariff < ActiveRecord::Base
  belongs_to :operator
  has_many :tariff_packages
  has_one :option_value

  acts_as_list :scope => :operator
  named_scope :published, :conditions => {:published => true}

  after_save :update_option_values

  validates_presence_of :name, :price, :package_price, :operator_id

  validates_each :package_price do |model, attr, value|
    begin
     model.eval_package_price(1000, 900)
    rescue
      model.errors.add(attr, 'není validní výraz')
    end
  end


  def eval_package_price(*attrs)
    if attrs.first.is_a? Product
      product_price = attrs.first.price
      product_cost_price = attrs.first.cost_price
    else
      product_price = attrs[0]
      product_cost_price = attrs[1]
    end

    eval(package_price.gsub('product_price', product_price.to_s).gsub('tariff_price', price.to_s).gsub('product_cost_price', product_cost_price.to_s))
  end


  def name_with_operator
    "#{operator.name}: #{name}"
  end


  def update_option_values
    tariff_opt_type = OptionType.find_by_name('tariff_package')
    opt_value = OptionValue.find_or_initialize_by_option_type_id_and_tariff_id(tariff_opt_type.id, self.id)
    opt_value.name = opt_value.presentation = name_with_operator
    opt_value.save!
  end
end
