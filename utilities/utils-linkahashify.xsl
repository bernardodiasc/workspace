<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:str="http://exslt.org/strings"
exclude-element-prefixes="str">
  
  <!--
  Name: Twita@talinkahashifyer (`linkahashify`)
  Description: An XSLT port of Dustin Diaz's Twita@talinkahashifyer JavaScript function to format a tweet a la Twitter.com
  Version: 0.1
  Author: Nick Dunn <http://github.com/nickdunn>
  URL: http://github.com/nickdunn/form-controls/tree/master
  Parameters:
  * `tweet` (string): A single tweet
  
  Original concept and JavaScript Copyright (c) 2009 Dustin Diaz:
  <http://www.dustindiaz.com>
  <http://www.dustindiaz.com/basement/ify.html>
  -->
  <xsl:template name="linkahashify">
    <xsl:param name="tweet"/>
    
    <!-- split tweet into words -->
    <xsl:for-each select="str:tokenize($tweet,' ')">
      
      <xsl:variable name="word" select="."/>
      
      <!-- how many characters from the start of the string to trim to, removes trailing characters -->
      <xsl:variable name="trim">
        <xsl:call-template name="linkahashify-trim">
          <xsl:with-param name="string" select="$word"/>
        </xsl:call-template>
      </xsl:variable>
      
      <xsl:choose>
        
        <!-- @username -->
        <xsl:when test="starts-with($word,'@')">
          <!-- the link and text is the word minus the @ and any trailing characters -->
          <a href="http://twitter.com/{substring-after(substring($word,1,$trim),'@')}">
            <xsl:text>@</xsl:text><xsl:value-of select="substring-after(substring($word,1,$trim),'@')"/>
          </a>
          <!-- add remaining trailing characters -->
          <xsl:value-of select="substring($word,($trim+1),100)"/>
        </xsl:when>
        
        <!-- #hash -->
        <xsl:when test="starts-with($word,'#')">
          <!-- the link and text is the word minus the @ and any trailing characters -->
          <a href="http://search.twitter.com/search?q=#{substring-after(substring($word,1,$trim),'#')}">
            <xsl:text>#</xsl:text><xsl:value-of select="substring-after(substring($word,1,$trim),'#')"/>
          </a>
          <!-- add remaining trailing characters -->
          <xsl:value-of select="substring($word,($trim+1),100)"/>        
        </xsl:when>
        
        <!-- links -->
        <xsl:when test="starts-with($word,'http')">  
          <!-- URL with trailing characters removed -->      
          <xsl:variable name="url">
            <xsl:value-of select="substring($word,1,$trim)"/>
          </xsl:variable>
          
          <a href="{$url}">
            <!-- truncate when URL is longer than 25 characters -->
            <xsl:choose>
              <xsl:when test="string-length($url) &gt; 25">
                <xsl:value-of select="substring($url,0,24)"/>
                <xsl:text>&#8230;</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$url"/>
              </xsl:otherwise>
            </xsl:choose>
          </a>
          <!-- add remaining trailing characters -->
          <xsl:value-of select="substring($word,($trim+1),100)" disable-output-escaping="yes"/>
          
        </xsl:when>
        
        <xsl:otherwise>
          <xsl:value-of select="$word" disable-output-escaping="yes"/>
        </xsl:otherwise>
        
      </xsl:choose>
      
      <!-- rebuild spaces between all but the last words -->
      <xsl:if test="position() != last()">
        <xsl:text> </xsl:text>
      </xsl:if>
      
    </xsl:for-each>
    
  </xsl:template>
  
  <!--
  Name: linkahashify-trim
  Returns: an integer from which the original string should be trimmed using `substring()`
  Description:
  A recursive template to recurse from the end to the beginning of a string until the first non-"trailing" character is found.
  A non-trailing character is defined as a character that appears on the end of a string/URL but does not form part of that string, e.g.
  string: Oh, @nickdunn...
  result: Oh, @nickdunn
  
  string: Visit http://nick-dunn.co.uk/#win!
  result: Visit http://nick-dunn.co.uk/#win
  -->
  <xsl:template name="linkahashify-trim">
    <xsl:param name="string"/>
    <xsl:param name="start" select="string-length($string)"/>
    <xsl:param name="iterations" select="start"/>
    <xsl:param name="count" select="$start"/>
    
    <!-- if we haven't reached the beginning of the string yet -->
    <xsl:if test="$count > 0">    
      <xsl:choose>
        <!-- if current character isn't considered a trailing character, we've reached the end of trailing characters,
        so we will use this position to trim to -->
        <xsl:when test="translate(substring($string,$count,1),'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890#/','')=''">
          <xsl:value-of select="$count" disable-output-escaping="yes" />
        </xsl:when>
        <xsl:otherwise>
          <!-- otherwise we keep rolling -->
          <xsl:call-template name="linkahashify-trim">
            <xsl:with-param name="string" select="$string"/>
            <xsl:with-param name="count" select="$count - 1"/>
            <xsl:with-param name="start" select="$start"/>
            <xsl:with-param name="iterations" select="$iterations"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>    
    </xsl:if>
    
  </xsl:template>
  
  
</xsl:stylesheet>