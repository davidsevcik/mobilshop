class Tariff < ActiveRecord::Base
  belongs_to :operator
  has_one :option_value

  acts_as_list :scope => :operator
  named_scope :published, :conditions => {:published => true}

  after_create :create_variants
  after_update :update_variants
  after_destroy :delete_variants

  validates_presence_of :name, :price, :package_price, :operator_id

  validates_each :package_price do |model, attr, value|
    model.errors.add(attr, 'není validní výraz') if model.eval_package_price(1000, 900).nil?
  end


  def eval_package_price(*attrs)
    if attrs.first.is_a? Product
      product_price = attrs.first.price
      product_cost_price = attrs.first.cost_price
    else
      product_price = attrs[0]
      product_cost_price = attrs[1]
    end

    temp_price = package_price.gsub('product_price', product_price.to_s)
    temp_price.gsub!('product_cost_price', product_cost_price.to_s)

    begin
      temp_price = eval(temp_price)
    rescue
      nil
    end

    temp_price =~ /^\d+\.?\d*$/ && BigDecimal.new(temp_price)
  end


  def name_with_operator
    "#{operator.name}: #{name}"
  end


  private

  def create_variants
    tariff_option_type = OptionType.find_by_name('tariff_package')
    option_value = tariff_option_type.option_values.build
    option_value.tariff = self
    option_value.name = option_value.presentation = name_with_operator
    option_value.save!

    Product.tariffable.each do |product|
      variant = product.variants.build(:cost_price => -1)
      variant.tariff = self
      variant.save!
    end
  end


  def update_variants
    if name_changed?
      option_value.name = option_value.presentation = name_with_operator
      option_value.save!
    end

    if package_price_changed?
      option_value.variants.each {|v| v.save! }
    end
  end


  def delete_variants
    option_value = OptionValue.find_by_tariff_id(self.id)

    Product.tariffable.each do |product|
      variant = product.variants.first(:joins => :option_values, :conditions => ['option_values.id = ?', option_value.id])
      variant.destroy
    end

    option_value.destroy
  end
end
