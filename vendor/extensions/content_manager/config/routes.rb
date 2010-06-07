# Put your extension routes here.

map.namespace :admin do |admin|
  admin.resources :content_nodes
  admin.resources :content_categories
end

map.content_node '/content/*path', :controller => 'content_frontend', :action => 'show'