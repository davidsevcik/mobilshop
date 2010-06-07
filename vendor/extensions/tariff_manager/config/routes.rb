# Put your extension routes here.

map.namespace :admin do |admin|
  admin.resources :operators
  admin.resources :tariffs
  admin.resources :products do |product|
    product.resources :tariff_packages, :collection => {:update_all => :post}
  end
  admin.resource :price_settings
end
