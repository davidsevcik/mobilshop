class Admin::ContentNodesController < Admin::BaseController
  resource_controller

  update.response do |wants|
    wants.html { redirect_to collection_url }
  end

  update.after do
    unless @content_node.slug.blank?
      expire_page :controller => 'content_frontend', :action => 'show', :path => @content_node.slug
      Rails.cache.delete('page_not_exist/'+@content_node.slug)
    end
  end

  create.response do |wants|
    wants.html { redirect_to collection_url }
  end

  create.after do
    Rails.cache.delete('page_not_exist/'+@content_node.slug) unless @content_node.slug.blank?
  end

end
