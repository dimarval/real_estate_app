class Property

  class Sync
    require 'Nokogiri'

    class InvalidFormat < ArgumentError ; end

    attr_reader :xml
    attr_reader :source
    attr_reader :modified_properties
    attr_reader :errors

    def initialize(xml, source = nil)
      @xml    = xml
      @source = source
      @modified_properties = []
      @errors              = []
    end

    def perform
      errors.clear

      properties_attr = parse_xml(xml)

      properties_attr.each_with_index do |property_attr, index|
        ActiveRecord::Base.transaction do
          property_attr = normalize_attributes(property_attr)
          property_attr = build_property_attributes(property_attr)
          pictures_attr = normalize_pictures_attributes(
            property_attr.delete(:pictures)
          )

          property = find_or_initialize_property(property_attr)

          if property.update(property_attr)
            sync_property_pictures(property, pictures_attr)
            add_modified_property(property)
          else
            add_error(index, propety.errors.full_messages)
          end
        end
      end

      unpublish_unmodified_properties
      success?
    end

    private

    def published_properties
      Property.where(source: source).published
    end

    def source_template
      source && source.template
    end

    def success?
      errors.empty?
    end

    def add_modified_property(property)
      modified_properties << property
    end

    def add_error(index, messages)
      errors << { row: (index + 1), messages: messages }
    end

    def parse_xml(xml)
      xml = transform_xml(self.xml) if source_template
      hash            = Hash.from_xml(xml)
      properties_attr = Array.wrap(hash['real_estate']['property'])
    rescue
      raise InvalidFormat.new('Document has not a valid format')
    end

    def transform_xml(xml)
      document = Nokogiri::XML  xml
      template = Nokogiri::XSLT source_template.content

      template.transform(document).to_xml
    end

    def normalize_pictures_attributes(pictures_attr)
      return [] unless pictures_attr

      Array.wrap(pictures_attr[:picture])
    end

    # Retrives relationship data
    def build_property_attributes(property_attr)
      type_code            = property_attr.delete(:type_code)
      operation_type_code  = property_attr.delete(:operation_type_code)
      floor_area_unit_code = property_attr.delete(:floor_area_unit_code)
      plot_area_unit_code  = property_attr.delete(:plot_area_unit_code)
      price_currency_code  = property_attr.delete(:price_currency_code)
      external_agency_name = property_attr.delete(:external_agency_name)

      property_attr.merge(
        type:            find_or_create_property_type(type_code),
        operation_type:  find_or_create_operation_type(operation_type_code),
        floor_area_unit: find_or_create_measurement_unit(floor_area_unit_code),
        plot_area_unit:  find_or_create_measurement_unit(plot_area_unit_code),
        price_currency:  find_or_create_currency(price_currency_code),
        external_agency: find_or_create_agency(external_agency_name),
      )
    end

    # Deletes leading and trailing whitespace and unscape HTML entities in depth
    def normalize_attributes(attributes)
      attributes.inject({}) do |hash, (key, value)|
        case value
        when String
          hash[key] = CGI.unescapeHTML(RemoveEmoji::Sanitize.call(value.strip))
        when Hash
          hash[key] = normalize_attributes(value)
        when Array
          hash[key] = []
          value.each { |v| hash[key] << normalize_attributes(v) }
        end

        hash
      end.with_indifferent_access
    end

    def find_or_initialize_property(attributes)
      published_properties
        .find_or_initialize_by(external_id: attributes[:external_id])
    end

    def find_or_create_property_type(code)
      return unless code

      PropertyType.find_or_create_by!(code: code)
    end

    def find_or_create_operation_type(code)
      return unless code

      OperationType.find_or_create_by!(code: code)
    end

    def find_or_create_measurement_unit(code)
      return unless code

      MeasurementUnit.find_or_create_by!(code: code)
    end

    def find_or_create_currency(code)
      return unless code

      Currency.find_or_create_by!(code: code)
    end

    def find_or_create_agency(name)
      return unless name

      Agency.find_or_create_by!(name: name)
    end

    def sync_property_pictures(property, pictures_attr)
      property.pictures.destroy_all

      pictures_attr.each do |picture_attr|
        picture          = Picture.new(picture_attr)
        picture.property = property
        picture.save
      end
    end

    def unpublish_unmodified_properties
      unmodified_properties_ids = published_properties.pluck(:id) -
        modified_properties.map(&:id)

      Property
        .where(id: unmodified_properties_ids)
        .update_all(published: false)
    end

  end

end
