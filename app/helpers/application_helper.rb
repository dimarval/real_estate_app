module ApplicationHelper

  def human_code_name_for(model_name, code, options = {})
    scope           = "activerecord.attributes.#{model_name}.code_value"
    default_options = { scope: scope, default: 'undefined' }

    t(code, default_options.merge(options))
  end

  def pagination(collection)
    pagination_resume(collection) + pagination_links(collection)
  end

  def pagination_resume(collection)
    page_entries_info(collection)
  end

  def pagination_links(collection)
    will_paginate(
      collection,
      renderer: WillPaginate::ActionView::BootstrapLinkRenderer
    )
  end

end
