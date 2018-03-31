module PropertiesHelper

  def property_picture_url(property)
    if property.pictures.any?
      property.pictures.first.url
    else
      image_path('no_picture.png')
    end
  end

  def property_truncated_text(content, format = :default)
    case format.to_sym
    when :default then content
    when :short   then truncate(content, length: 64)
    when :long    then truncate(content, length: 128)
    end
  end

  def property_price_with_currency(property)
    return unless property.price && property.price_currency.code

    "#{number_with_precision(property.price)} #{property.price_currency.code}"
  end

  def property_area_with_unit(area, unit)
    traslation_unit = human_code_name_for(:measurement_unit, unit.code)

    if traslation_unit == 'undefined'
      scope           = 'helpers.property_area_with_unit'
      traslation_unit = t('undefined_unit', scope: scope)
    else
      traslation_unit += '2'
    end

    "#{area} #{traslation_unit}"
  end

  def property_publication_time(property)
    days  = (Date.today - property.date).to_i
    count = days > 30 ? '30+'  : days
    key   = days > 1  ? :other : :one

    t(key, count: count, scope: 'helpers.property_publication_time')
  end

  def property_operation_type(property)
    agency               = property.external_agency
    traslation_operation = human_code_name_for(
      :operation_type,
      property.operation_type.code,
      default: t('undefined', scope: 'helpers.property_operation_type')
    )

    traslation_operation += " (#{agency.name})" if agency
    traslation_operation
  end

end
