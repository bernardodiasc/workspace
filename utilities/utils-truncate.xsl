<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://exslt.org/strings">
<!--
  A tolerant truncation utility
-->
  <xsl:template name="truncate">
    <xsl:param name="node" />
    <xsl:param name="limit" />
    
    <!--
      Append this to the end of the value, if we have truncated it.
    -->
    <xsl:param name="suffix" select="' (&#x2026;)'" />
    
    <!--
      Tolerance allows words that fall over the required length be
      appended, as long as they don't go over $length + $tolerance.
    -->
    <xsl:param name="tolerance" select="3" />
    
    <!--
      Treat any of these characters as the end of a word.
    -->
    <xsl:param name="delimiters" select="str:tokenize(' -!?:)(;,.…&#x2013;&#x2014;&#160;', '')" />
    
    <!-- Find actual limit -->
    <xsl:variable name="limit">
      <xsl:choose>
        <xsl:when test="string-length($node) &lt;= $limit">
          <xsl:value-of select="string-length($node)" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="preceding-delimiter">
            <xsl:call-template name="truncate-find-delimiter">
              <xsl:with-param name="value">
                <xsl:for-each select="str:tokenize(substring($node, 1, $limit + 1), '')">
                  <xsl:sort select="position()" data-type="number" order="descending" />
                  
                  <xsl:value-of select="." />
                </xsl:for-each>
              </xsl:with-param>
              <xsl:with-param name="delimiters" select="$delimiters" />
            </xsl:call-template>
          </xsl:variable>
          
          <xsl:variable name="following-delimiter">
            <xsl:call-template name="truncate-find-delimiter">
              <xsl:with-param name="value" select="substring($node, $limit + 1)" />
              <xsl:with-param name="delimiters" select="$delimiters" />
            </xsl:call-template>
          </xsl:variable>
          
          <xsl:choose>
            <xsl:when test="$preceding-delimiter = 0 and $following-delimiter = 0">
              <xsl:value-of select="$limit" />
            </xsl:when>
            <xsl:when test="$following-delimiter &lt;= $tolerance">
              <xsl:value-of select="$limit + $following-delimiter" />
            </xsl:when>
            <xsl:when test="$preceding-delimiter &lt;= $tolerance">
              <xsl:value-of select="$limit - $preceding-delimiter" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$limit" />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <!-- Build output -->
    <xsl:choose>
      <xsl:when test="$limit != string-length($node)">
        <xsl:apply-templates select="($node/* | $node/text())[1]" mode="truncate-search">
          <xsl:with-param name="limit" select="$limit" />
          <xsl:with-param name="suffix" select="$suffix" />
        </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="$node/* | $node/text()" mode="truncate-render" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
<!--
  Search for the node that runs over the limit.
-->
  <xsl:template match="* | text()" mode="truncate-search">
    <xsl:param name="length" select="0" />
    <xsl:param name="limit" select="0" />
    <xsl:param name="position" select="1" />
    <xsl:param name="suffix" />
    
    <xsl:variable name="next" select="(../* | ../text())[$position + 1]" />
    
    <xsl:choose>
      <!-- Limit found -->
      <xsl:when test="$length + string-length(.) &gt;= $limit">
        <xsl:choose>
          <!-- Keep searching children -->
          <xsl:when test="*">
            <xsl:element name="{name()}">
              <xsl:apply-templates select="@*" mode="truncate-render" />
              <xsl:apply-templates select="(./* | ./text())[1]" mode="truncate-search">
                <xsl:with-param name="length" select="$length" />
                <xsl:with-param name="limit" select="$limit" />
                <xsl:with-param name="suffix" select="$suffix" />
              </xsl:apply-templates>
            </xsl:element>
          </xsl:when>
          
          <!-- The node to truncate -->
          <xsl:otherwise>
            <xsl:apply-templates select="(../* | ../text())[position() &lt; $position]" mode="truncate-render" />
            <xsl:apply-templates select="." mode="truncate-apply">
              <xsl:with-param name="limit" select="$limit - $length" />
              <xsl:with-param name="suffix" select="$suffix" />
            </xsl:apply-templates>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      
      <!-- Keep searching at this level -->
      <xsl:when test="$next">
        <xsl:apply-templates select="$next" mode="truncate-search">
          <xsl:with-param name="length" select="$length + string-length(.)" />
          <xsl:with-param name="limit" select="$limit" />
          <xsl:with-param name="position" select="$position + 1" />
          <xsl:with-param name="suffix" select="$suffix" />
        </xsl:apply-templates>
      </xsl:when>
      
      <!-- Nothing to truncate -->
      <xsl:otherwise>
        <xsl:apply-templates select="../* | ../text()" mode="truncate-render" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
<!--
  Apply truncation to node
-->
  <xsl:template match="*" mode="truncate-apply">
    <xsl:param name="limit" />
    <xsl:param name="suffix" />
    
    <xsl:element name="{name()}">
      <xsl:apply-templates select="@*" mode="truncate-render" />
      <xsl:value-of select="substring(., 1, $limit)" disable-output-escaping="yes" />
      <xsl:value-of select="$suffix" />
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="text()" mode="truncate-apply">
    <xsl:param name="limit" />
    <xsl:param name="suffix" />
    
    <xsl:value-of select="substring(., 1, $limit)" disable-output-escaping="yes" />
    <xsl:value-of select="$suffix" />
  </xsl:template>
  
<!--
  Render all nodes
-->
  <xsl:template match="*" mode="truncate-render">
    <xsl:element name="{name()}">
      <xsl:apply-templates select="@*" mode="truncate-render" />
      <xsl:apply-templates select="* | text()" mode="truncate-render" />
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="@*" mode="truncate-render">
    <xsl:attribute name="{name()}">
      <xsl:value-of select="." />
    </xsl:attribute>
  </xsl:template>
  
  <xsl:template match="text()" mode="truncate-render">
    <xsl:value-of select="." />
  </xsl:template>
  
<!--
  Search for a delimiter
-->
  <xsl:template name="truncate-find-delimiter">
    <xsl:param name="value" />
    <xsl:param name="delimiters" />
    <xsl:param name="length" select="0" />
    
    <xsl:choose>
      <xsl:when test="$value != ''">
        <xsl:choose>
          <xsl:when test="$delimiters[starts-with(substring($value, 1, 1), .)]">
            <xsl:value-of select="$length" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="truncate-find-delimiter">
              <xsl:with-param name="value" select="substring($value, 2)" />
              <xsl:with-param name="delimiters" select="$delimiters" />
              <xsl:with-param name="length" select="$length + 1" />
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$length" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>