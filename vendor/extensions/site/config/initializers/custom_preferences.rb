if Spree::Config.instance
  Spree::Config.set(:default_locale => 'cs-CZ')
  Spree::Config.set(:allow_guest_checkout => true)
  Spree::Config.set(:address_requires_state => false)
  #Spree::Config.set(:allow_locale_switching => false)

  Variant.additional_fields = []
end