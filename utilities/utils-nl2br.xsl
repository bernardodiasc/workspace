<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
  Example:

  <xsl:call-template name="nl2br">
    <xsl:with-param name="string" select="body"/>
  </xsl:call-template>
-->

<xsl:template name="nl2br">
  <xsl:param name="string"/>
  <xsl:value-of select="normalize-space(substring-before($string,'&#10;'))"/>
  <xsl:choose>
    <xsl:when test="contains($string,'&#10;')">
      <br />
      <xsl:call-template name="nl2br">
        <xsl:with-param name="string" select="substring-after($string,'&#10;')"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$string"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>