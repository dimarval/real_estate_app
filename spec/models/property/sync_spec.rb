require 'rails_helper'

describe Property::Sync do

  let(:xml) do
    <<-XML
      <?xml version="1.0" encoding="UTF-8"?>
      <real_estate>
        <property>
          <title><![CDATA[ Custom Property ]]></title>
          <description><![CDATA[ Property Description ]]></description>
          <type_code><![CDATA[ house ]]></type_code>
          <operation_type_code><![CDATA[ sale ]]></operation_type_code>
          <floor_area><![CDATA[ 3 ]]></floor_area>
          <floor_area_unit_code><![CDATA[ meters ]]></floor_area_unit_code>
          <plot_area><![CDATA[ 6 ]]></plot_area>
          <plot_area_unit_code><![CDATA[ meters ]]></plot_area_unit_code>
          <rooms><![CDATA[ 2 ]]></rooms>
          <bathrooms><![CDATA[ 3 ]]></bathrooms>
          <parking><![CDATA[ 1 ]]></parking>
          <city><![CDATA[ Cuauhtémoc ]]></city>
          <city_area><![CDATA[ Hipódromo Condesa ]]></city_area>
          <region><![CDATA[ Ciudad de México ]]></region>
          <price><![CDATA[ 5990000.0 ]]></price>
          <price_currency_code><![CDATA[ USD ]]></price_currency_code>
          <date><![CDATA[ 02/02/2017 ]]></date>
          <external_id><![CDATA[ 1483s ]]></external_id>
          <external_agency_name><![CDATA[ Custom Real Estate ]]></external_agency_name>
          <external_url><![CDATA[ https://www.example.com/ ]]></external_url>
          <pictures>
            <picture>
              <url><![CDATA[ https://www.example.com/image/1 ]]></url>
            </picture>
            <picture>
              <url><![CDATA[ https://www.example.com/imgae/2 ]]></url>
            </picture>
          </pictures>
        </property>
      </real_estate>
    XML
  end

  let(:source) { Source.create(code: 'custom', name: 'Custom') }

  let(:source_template) do
    <<-XML
      <?xml version="1.0" encoding="UTF-8"?>
      <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
        <xsl:output method="xml" indent="yes"/>
        <xsl:template match="/">
          <real_estate>
            <xsl:for-each select="trovit/ad">
              <property>
                <title><xsl:value-of select="title"/></title>
                <description><xsl:value-of select="content"/></description>
                <type_code><xsl:value-of select="property_type"/></type_code>
                <operation_type_code><xsl:value-of select="type"/></operation_type_code>
                <city><xsl:value-of select="city"/></city>
                <city_area><xsl:value-of select="city_area"/></city_area>
                <region><xsl:value-of select="region"/></region>
                <date><xsl:value-of select="date"/></date>
              </property>
            </xsl:for-each>
          </real_estate>
        </xsl:template>
      </xsl:stylesheet>
    XML
  end

  describe '#perform' do

    context 'without a source with valid xml' do

      subject(:property_sync) { Property::Sync.new(xml) }

      context 'when the properties not exists' do

        it 'creates a property' do
          expect { property_sync.perform }.to change(Property, :count).by(1)
        end

        it 'ceaate a property with all its attributes' do
          property_sync.perform

          property = Property.last

          expect(property.title).to                eq 'Custom Property'
          expect(property.description).to          eq 'Property Description'
          expect(property.type.code).to            eq 'house'
          expect(property.operation_type.code).to  eq 'sale'
          expect(property.floor_area).to           eq 3
          expect(property.floor_area_unit.code).to eq 'meters'
          expect(property.plot_area).to            eq 6
          expect(property.plot_area_unit.code).to  eq 'meters'
          expect(property.rooms).to                eq 2
          expect(property.bathrooms).to            eq 3
          expect(property.parking).to              eq 1
          expect(property.city).to                 eq 'Cuauhtémoc'
          expect(property.city_area).to            eq 'Hipódromo Condesa'
          expect(property.region).to               eq 'Ciudad de México'
          expect(property.price).to                eq  5990000
          expect(property.price_currency.code).to  eq 'USD'
          expect(property.date).to                 eq Date.new(2017, 2, 2)
          expect(property.external_id).to          eq '1483s'
          expect(property.external_agency.name).to eq 'Custom Real Estate'
          expect(property.published).to            be_truthy
        end

        it 'creates 2 pictues' do
          expect { property_sync.perform }.to change(Picture, :count).by(2)
        end

        it 'returns true' do
          expect(property_sync.perform).to be_truthy
        end

      end

      context 'when the properties already exists' do

        before(:each) do
          @property = FactoryBot.create(:property, external_id: '1483s')
        end

        it 'no creates a property' do
          expect { property_sync.perform }.not_to change(Property, :count)
        end

        it 'updates a property with all its attributes' do
          property_sync.perform

          @property.reload

          expect(@property.title).to                eq 'Custom Property'
          expect(@property.description).to          eq 'Property Description'
          expect(@property.type.code).to            eq 'house'
          expect(@property.operation_type.code).to  eq 'sale'
          expect(@property.floor_area).to           eq 3
          expect(@property.floor_area_unit.code).to eq 'meters'
          expect(@property.plot_area).to            eq 6
          expect(@property.plot_area_unit.code).to  eq 'meters'
          expect(@property.rooms).to                eq 2
          expect(@property.bathrooms).to            eq 3
          expect(@property.parking).to              eq 1
          expect(@property.city).to                 eq 'Cuauhtémoc'
          expect(@property.city_area).to            eq 'Hipódromo Condesa'
          expect(@property.region).to               eq 'Ciudad de México'
          expect(@property.price).to                eq  5990000
          expect(@property.price_currency.code).to  eq 'USD'
          expect(@property.date).to                 eq Date.new(2017, 2, 2)
          expect(@property.external_id).to          eq '1483s'
          expect(@property.external_agency.name).to eq 'Custom Real Estate'
        end

        it 'deletes past pictures and creates 2 new pictures' do
          expect { property_sync.perform }.to change(Picture, :count).by(2)
        end

        it 'returns true' do
          expect(property_sync.perform).to be_truthy
        end

      end

      context 'when the properties not apears anymore in the feed' do

        before(:each) do
          @property = FactoryBot.create(
            :property,
            external_id: '1483s',
            published:   true,
          )
        end

        let(:xml) do
          <<-XML
            <?xml version="1.0" encoding="UTF-8"?>
            <real_estate>
              <property>
                <title><![CDATA[ Custom Property 2 ]]></title>
                <description><![CDATA[ Property Description 2 ]]></description>
                <type_code><![CDATA[ house ]]></type_code>
                <operation_type_code><![CDATA[ sale ]]></operation_type_code>
                <floor_area><![CDATA[ 3 ]]></floor_area>
                <floor_area_unit_code><![CDATA[ meters ]]></floor_area_unit_code>
                <plot_area><![CDATA[ 6 ]]></plot_area>
                <plot_area_unit_code><![CDATA[ meters ]]></plot_area_unit_code>
                <rooms><![CDATA[ 2 ]]></rooms>
                <bathrooms><![CDATA[ 3 ]]></bathrooms>
                <parking><![CDATA[ 1 ]]></parking>
                <city><![CDATA[ Cuauhtémoc ]]></city>
                <city_area><![CDATA[ Hipódromo Condesa ]]></city_area>
                <region><![CDATA[ Ciudad de México ]]></region>
                <price><![CDATA[ 5990000.0 ]]></price>
                <price_currency_code><![CDATA[ USD ]]></price_currency_code>
                <date><![CDATA[ 02/02/2017 ]]></date>
              </property>
            </real_estate>
          XML
        end

        it 'no deletes the properties' do
          property_sync.perform

          expect(Property.count).to eq 2
        end

        it 'unpublish the properties' do
          property_sync.perform

          @property.reload

          expect(@property.published).to be_falsey
        end

      end

    end

    context 'with a source without template and valid xml' do

    end

    context 'with a source with template and valid xml' do


    end

    context 'with a source with template but without valid xml' do

    end

  end

end
