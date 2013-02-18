<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template name="head">
		<xsl:param name="title" select="''" />
		<xsl:param name="keywords" select="''" />
		<xsl:param name="description" select="''" />
		<xsl:param name="image" select="''" />
		<xsl:param name="date" select="''" />

		<xsl:variable name="super-title" select="//params/website-name" />

		<xsl:variable name="all-keywords">
			<xsl:call-template name="keywords" />
		</xsl:variable>

		<xsl:variable name="checked-image">
			<xsl:choose>
				<xsl:when test="$image = ''"><xsl:value-of select="concat($workspace, '/img/thumb.jpg')" /></xsl:when>
				<xsl:otherwise><xsl:value-of select="$image" /></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<title><xsl:value-of select="concat($title, $super-title)" /></title>

		<meta name="keywords" content="{$keywords}{$all-keywords}" />
		<meta name="description" content="{$description}" />
		<xsl:if test="$date != ''">
			<meta name="date" content="{$date}" />
		</xsl:if>

		<!-- Facebook -->
		<!--<meta property="og:title" content="{$title}{$super-title}" />
		<meta property="og:type" content="website" />
		<meta property="og:url" content="{//params/current-url}" />
		<meta property="og:description" content="{$description}" />
		<meta property="og:image" content="{$checked-image}" />
		<meta property="og:locale" content="pt_BR" />
		<meta property="og:site_name" content="{//params/website-name}" />-->

		<!-- Twitter -->
		<!--<meta name="twitter:card" content="summary" />
		<meta name="twitter:site" content="@" />
		<meta name="twitter:creator" content="@" />
		<meta name="twitter:url" content="{//params/current-url}" />
		<meta name="twitter:title" content="{$title}{$super-title}" />
		<meta name="twitter:description" content="{$description}" />
		<meta name="twitter:image" content="{$checked-image}" />-->

		<!-- Google Plus -->
		<!--<meta itemprop="description" content="{$description}" />
		<meta itemprop="image" content="{$checked-image}" />
		<meta itemprop="name" content="{$title}{$super-title}" />
		<meta itemprop="url" content="{//params/current-url}" />-->
	</xsl:template>

	<xsl:template name="keywords">
		<xsl:text></xsl:text>
	</xsl:template>
</xsl:stylesheet>