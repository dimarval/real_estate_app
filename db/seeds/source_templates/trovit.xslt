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
          <floor_area><xsl:value-of select="floor_area"/></floor_area>
          <floor_area_unit_code><xsl:value-of select="floor_area/@unit"/></floor_area_unit_code>
          <plot_area><xsl:value-of select="plot_area"/></plot_area>
          <plot_area_unit_code><xsl:value-of select="plot_area/@unit"/></plot_area_unit_code>
          <rooms><xsl:value-of select="rooms"/></rooms>
          <bathrooms><xsl:value-of select="bathrooms"/></bathrooms>
          <parking><xsl:value-of select="parking"/></parking>
          <city><xsl:value-of select="city"/></city>
          <city_area><xsl:value-of select="city_area"/></city_area>
          <region><xsl:value-of select="region"/></region>
          <price><xsl:value-of select="price"/></price>
          <price_currency_code><xsl:value-of select="price/@currency"/></price_currency_code>
          <date><xsl:value-of select="date"/></date>
          <external_id><xsl:value-of select="id"/></external_id>
          <external_agency_name><xsl:value-of select="agency"/></external_agency_name>
          <external_url><xsl:value-of select="url"/></external_url>
          <xsl:if test="pictures">
            <pictures>
              <xsl:for-each select="pictures/picture">
                <picture>
                  <url><xsl:value-of select="picture_url"/></url>
                </picture>
              </xsl:for-each>
            </pictures>
          </xls:if>
        </property>
      </xsl:for-each>
    </real_estate>
  </xsl:template>
</xsl:stylesheet>
