class Admin::TariffsController < Admin::BaseController
  resource_controller

  update.response do |wants|
    wants.html { redirect_to collection_url }
  end

  update.after do
    Rails.cache.delete('tariffs')
  end

  create.response do |wants|
    wants.html { redirect_to collection_url }
  end

  create.after do
    Rails.cache.delete('tariffs')
  end


  private

  def collection
    @collection ||= end_of_association_chain.all(:include => :operator, :order => 'operator_id, name')
  end

end