class Admin::ContentNodesController < Admin::BaseController
  resource_controller

  before_filter :load_data, :except => [:destroy_image, :image_browser]

  update.response do |wants|
    wants.html { redirect_to params[:continue_editing].nil? ? collection_url : edit_object_url(@content_node) }
  end

  update.after do
    unless @content_node.slug.blank?
      expire_page :controller => 'content_frontend', :action => 'show', :path => @content_node.slug
      Rails.cache.delete('page_not_exist/'+@content_node.slug)
    end
  end

  create.response do |wants|
    wants.html { redirect_to params[:continue_editing].nil? ? collection_url : edit_object_url(@content_node) }
  end

  create.after do
    Rails.cache.delete('page_not_exist/'+@content_node.slug) unless @content_node.slug.blank?
  end


  def destroy_image
    @content_node = ContentNode.find(params[:id])
    @image = Image.find(params[:image_id])
    @content_node.images.delete(@image)
    render :text => 'OK'
  end


  def image_browser_upload
    @content_node = ContentNode.find(params[:id])
    params[:uploaded_images].each do |file|
      @content_node.images.create(file)
    end
    redirect_to :action => :image_browser, :CKEditorFuncNum => params[:CKEditorFuncNum]
  end


  def image_browser
    @content_node = params[:id].nil? ? ContentNode.new : ContentNode.find(params[:id])
    render :layout => false
  end


  private

  def load_data
    @content_categories = ContentCategory.all
  end

  def build_object
    if params[:content_node]
      @object = ContentNode.new(params[:content_node])
    else
      @object = ContentNode.new
      @object.category_id = params[:category] unless params[:category].blank?
    end  
  end

end
