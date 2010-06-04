if Spree::Config.instance
  Spree::Config.set(:default_locale => 'cs-CZ')
  #Spree::Config.set(:allow_locale_switching => false)
end