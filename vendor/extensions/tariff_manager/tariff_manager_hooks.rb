class TariffManagerHooks < Spree::ThemeSupport::HookListener

  #
  # In this file you can modify the content of the hooks available in the default templates
  # and avoid overriding a template in many situations. Multiple extensions can modify the
  # same hook, the changes being applied cumulatively based on extension load order
  #
  # Most hooks are defined with blocks so they span a region of the template, allowing content
  # to be replaced or removed as well as added to.
  #
  # Usage
  #
  # The following methods are available
  #
  # * insert_before
  # * insert_after
  # * replace
  # * remove
  #
  # All accept a block name symbol followed either by arguments that would be valid for 'render'
  # or a block which returns the string to be inserted. The block will have access to any methods
  # or instance variables accessible in your views
  #
  # Examples
  # 
  #   insert_before :homepage_products, :text => "<h1>Welcome!</h1>"
  #   insert_after :homepage_products, 'shared/offers' # renders a partial
  #   replace :taxon_sidebar_navigation, 'shared/my_sidebar
  #
  # adding a link below product details:
  #
  #   insert_after :product_description do
  #    '<p>' + link_to('Back to products', products_path) + '</p>'
  #   end
  #
  # adding a new tab to the admin navigation
  #
  insert_after :admin_tabs do
    %(<%=  tab(:tariffs, :operators)  %>)
  end

  #insert_after :admin_product_tabs, 'admin/shared/package_prices_tab'

  insert_after :admin_configurations_sidebar_menu do
    %(<li<%= ' class="active"' if controller.controller_name == 'price_settings' %>><%= link_to 'Nastavení ceny', admin_price_settings_path %></li>)
  end

  insert_after :admin_configurations_menu do
    %(
      <tr>
        <td><%= link_to 'Nastavení ceny', admin_price_settings_path %></td>
        <td>Nastavení výpočtu ceny</td>
      </tr>
    )
  end

  insert_after :admin_product_form_right, 'admin/products/is_tariffable'

end
