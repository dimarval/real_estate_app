module ApplicationHelper

  def human_code_name_for(model_name, code, options = {})
    scope           = "activerecord.attributes.#{model_name}.code_value"
    default_options = { scope: scope, default: 'undefined' }

    t(code, default_options.merge(options))
  end

end
