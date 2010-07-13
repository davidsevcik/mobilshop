if Spree::Config.instance
  Spree::Config.set(:default_locale => 'cs-CZ')
  Spree::Config.set(:allow_anonymous_checkout => true)
  Spree::Config.set(:address_requires_state => false)
  #Spree::Config.set(:allow_locale_switching => false)

  Spree::Config.set(:primary_taxonomy_id => 4)
  Spree::Config.set(:package_content_property_id => 1)
end