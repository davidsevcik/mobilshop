# Put your extension routes here.

map.namespace :admin do |admin|
  admin.resources :content_nodes, :member => { :destroy_image => :delete, :image_browser => :get }
  admin.resources :content_categories
end

map.content_node '/content/*path', :controller => 'content_frontend', :action => 'show'