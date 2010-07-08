# Put your extension routes here.

map.namespace :admin do |admin|
  admin.resources :orders do |orders|
    orders.resource :order_info
  end
end

map.simple_checkout '/checkout/:order_number', :controller => 'simple_checkout', :action => 'contact'
map.simple_checkout_contact_process '/checkout/:order_number/contact_process', :controller => 'simple_checkout', :action => 'contact_process'
map.simple_checkout_summary '/checkout/:order_number/summary', :controller => 'simple_checkout', :action => 'summary'
map.simple_checkout_confirm '/checkout/:order_number/confirm', :controller => 'simple_checkout', :action => 'confirm'