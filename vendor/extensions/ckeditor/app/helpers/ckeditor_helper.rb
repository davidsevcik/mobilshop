module CkeditorHelper

  def include_ckeditor(config_file='/ckeditor/custom_config.js')
    render :partial => 'admin/shared/ckeditor', :locals => {:config_file => config_file}
  end
end