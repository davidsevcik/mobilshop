# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class ContentManagerExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/content_manager"

  # Please use content_manager/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate

    Spree::BaseController.class_eval do
      # ProductsHelper needed for seo_url method used when generating
      # taxonomies partial in content/show.html.erb.
      helper :products
      # Use before_filter instead of prepend_before_filter to ensure that
      # ApplicationController filters that the view may require are run.
      before_filter :render_page_if_exists

      # Checks if page is not beeing overriden by static one that starts with /
      #
      # Using request.path allows us to override dynamic pages including
      # the home page, product and taxon pages.
      def render_page_if_exists
        # If we don't know if page exists we assume it's and we query DB.
        # But we realy don't want to query DB on each page we're sure doesn't exist!

        slug = request.path.ends_with?('/') ? request.path[1..-2] : request.path[1..-1]

        return if Rails.cache.fetch('page_not_exist/'+slug)

        if @content_node = ContentNode.find_by_slug(slug)
          render :template => 'content_frontend/show'
        else
          Rails.cache.write('page_not_exist/'+slug, true)
          return(nil)
        end
      end

      # Returns page.title for use in the <title> element.
      def title_with_page_title_check
        return @content_node.title if @content_node && !@content_node.title.blank?
        title_without_page_title_check
      end
      alias_method_chain :title, :page_title_check
    end

    #if not defined?(Spree::ThemeSupport)
    #  Admin::ConfigurationsController.class_eval do
    #    before_filter :add_static_pages_links, :only => :index
    #
    #    def add_static_pages_links
    #      @extension_links << {
    #        :link => admin_pages_path,
    #        :link_text => t('ext_static_content_static_pages'),
    #        :description => t('ext_static_content_static_pages_desc')
    #      }
    #    end
    #  end
    #end
  end
end
