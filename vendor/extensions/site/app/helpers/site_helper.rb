module SiteHelper           

  def site_breadcrumbs(taxon, product, content_node, separator=" &nbsp; &gt; &nbsp; ")
    return "" if current_page?("/")
    separator = raw(separator)
    crumbs = [link_to('Dotované telefony' , root_path)]
    if taxon
      crumbs << taxon.ancestors[1..-1].collect { |ancestor| link_to(ancestor.name , seo_url(ancestor)) } unless taxon.ancestors.empty?
      crumbs << content_tag(:span, taxon.name, :class => 'here')
    elsif product
      taxon = product.taxons.find_by_taxonomy_id(Spree::Config[:primary_taxonomy_id])
      crumbs << link_to(taxon.name , seo_url(taxon))
      crumbs << content_tag(:span, h(product.name), :class => 'here')
    elsif content_node
      crumbs << content_tag(:span, h(content_node.title), :class => 'here')
    else
      crumbs << content_tag(:span, t(controller.controller_name, :default => controller.controller_name.humanize), :class => 'here')
    end
    crumb_list = crumbs.join(separator)
    content_tag(:div, crumb_list, :id => 'breadcrumbs')
  end


  def site_link_to_cart
    order = Order.find_or_create_by_id(session[:order_id]) unless session[:order_id].blank?
    if order.nil?
      'Košík prázdný'
    else
      item_count = order.line_items.inject(0) { |kount, line_item| kount + line_item.quantity }
      'Košík: &nbsp; ' + content_tag(:strong, "#{order_price(order)}, #{item_count} ks &nbsp; ") + link_to('Vstoupit do košíku', cart_path)
    end

  end

end