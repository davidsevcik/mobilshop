class Admin::OperatorsController < Admin::BaseController
  resource_controller

  update.response do |wants|
    wants.html { redirect_to collection_url }
  end

  update.after do
    Rails.cache.delete('operators')
  end

  create.response do |wants|
    wants.html { redirect_to collection_url }
  end

  create.after do
    Rails.cache.delete('operators')
  end

end
