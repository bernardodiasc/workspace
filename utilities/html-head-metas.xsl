<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<!--
		HTML Head Metas v0.1
		====================

		1. Add this attributes on <html>
			- prefix="og: http://ogp.me/ns#"
			- itemscope="itemscope"
			- itemtype="http://schema.org/Thing"

		2. Inside the <head> put this apply-templates:
			<xsl:apply-templates select="/data" mode="add_head_meta" />

		3. On your Page xsl add a template that match 'data' in 'add_head_meta' mode, and call 'html-head-metas' template:
			<xsl:template match="data" mode="add_head_meta">
				<xsl:call-template name="html-head-metas" />
			</xsl:template>

		With this, you can customize some Metas per page!

		Example:

			<xsl:template match="data" mode="add_head_meta">
				<xsl:call-template name="html-head-metas">
					<xsl:with-param name="title" select="'Page Title (about 70 characters adding up the website-name) | '" />
					<xsl:with-param name="keywords" select="'key, words, comma, separated, about, 200, characters'" />
					<xsl:with-param name="description" select="'Short description of page content (about 250 characters, 152 for Google snippet)'" />
					<xsl:with-param name="image" select="concat(//params/workspace, '/yourThumbPageImage.jpg')" />
					<xsl:with-param name="date" select="'December 21, 2012'" />
				</xsl:call-template>
			</xsl:template>

		PLEASE see inline comments below for better customization for your website.

		If you like this stuff and know how to improve, contact-me at Twitter @germkaos.
	-->

	<xsl:template name="html-head-metas">
		<xsl:param name="title" select="''" />
		<xsl:param name="keywords" select="''" />
		<xsl:param name="description" select="''" />
		<xsl:param name="image" select="''" />
		<xsl:param name="date" select="''" />

		<xsl:variable name="super-title" select="//params/website-name" />

		<xsl:variable name="checked-image">
			<xsl:choose>
				<xsl:when test="$image = ''"><xsl:value-of select="concat($workspace, '/assets/img/thumb.jpg')" /></xsl:when>
				<xsl:otherwise><xsl:value-of select="$image" /></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta http-equiv="imagetoolbar" content="no" />
		<meta http-equiv="content-language" content="pt-br" /> <!-- Change your content-language -->

		<meta name="viewport" content="width=device-width" />
		<meta name="robots" content="index,follow" />
		<meta name="generator" content="Symphony CMS" /> <!-- I'm proud to announce, aren't you? -->
		<meta name="author" content="{//params/website-name}" />
		<meta name="copyright" content="© {//params/this-year} {//params/website-name}" />
		<meta name="distribution" content="global" />
		<meta name="rating" content="general" />
		<meta name="revisit-after" content="1 day" />
		<meta name="expires" content="never" />

		<title><xsl:value-of select="concat($title, $super-title)" /></title> <!-- See why I put ' | ' at end of $title on call-template -->

		<meta name="keywords" content="{$keywords}" />
		<meta name="description" content="{$description}" />
		<meta name="date" content="{$date}" />

		<!--
			Facebook
			More info at http://ogp.me/
		-->
		<meta property="og:title" content="concat($title, $super-title)" />
		<meta property="og:type" content="website" />
		<meta property="og:url" content="{//params/current-url}" />
		<meta property="og:description" content="{$description}" />
		<meta property="og:image" content="{$checked-image}" />
		<meta property="og:locale" content="pt_BR" /> <!-- Change your locale -->
		<meta property="og:site_name" content="{//params/website-name}" />

		<!--
			Twitter
			More info at https://dev.twitter.com/docs/cards
		-->
		<meta name="twitter:card" content="summary" />
		<meta name="twitter:site" content="@symphonycms" /> <!-- Change your twitter:site -->
		<meta name="twitter:creator" content="@symphonycms" /> <!-- Change your twitter:creator -->
		<meta name="twitter:url" content="{//params/current-url}" />
		<meta name="twitter:title" content="concat($title, $super-title)" />
		<meta name="twitter:description" content="{$description}" />
		<meta name="twitter:image" content="{$checked-image}" />

		<!--
			Google Plus
			More info at http://schema.org/
		-->
		<meta itemprop="description" content="{$description}" />
		<meta itemprop="image" content="{$checked-image}" />
		<meta itemprop="name" content="concat($title, $super-title)" />
		<meta itemprop="url" content="{//params/current-url}" />
	</xsl:template>
</xsl:stylesheet>