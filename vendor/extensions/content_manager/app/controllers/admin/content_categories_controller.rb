class Admin::ContentCategoriesController < Admin::BaseController
  resource_controller

  before_filter :load_data, :except => :index

  update.response do |wants|
    wants.html { redirect_to collection_url }
  end

  create.response do |wants|
    wants.html { redirect_to collection_url }
  end



  private

  def load_data
    @content_categories = ContentCategory.all
  end

end
