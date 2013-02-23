<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<!--
		HTML Head Metas v0.2
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
					<xsl:with-param name="image" select="concat(//params/workspace, '/assets/img/thumb.jpg')" />
					<xsl:with-param name="date" select="'December 21, 2012'" />
					<xsl:with-param name="language" select="'en'" />
					<xsl:with-param name="twitter-site-id" select="'@symphonycms'" />
					<xsl:with-param name="twitter-creator-id" select="'@germkaos'" />
					<xsl:with-param name="google-plus-id" select="'104419925636557426290'" />
				</xsl:call-template>
			</xsl:template>


		Or, if you don't have any information, just call:

			<xsl:call-template name="html-head-metas" />


		NOTES:
			- ALL PARAMS CAN BE EMPTY;
			- The 'title' param must have a separator in the end (like ' | ', ' - ', ' / ' or any else);
			- The 'language' param can be "en" or "en-GB" or "en_GB" or "en GB" (the 3th character dos not matter);
			- The 'twitter-site-id' param refers to the Website Twitter ID;
			- The 'twitter-creator-id' param refers to the Author Twitter ID (like a article author);
			- The 'google-plus-id' refers to Google Plus numeric ID of the Author;
			- For better use set some default values on Params declarations!

		# If you like this stuff and know how to improve, contact-me at Twitter @germkaos.

	-->

	<xsl:template name="html-head-metas">
		<xsl:param name="title" select="''" />
		<xsl:param name="keywords" select="''" />
		<xsl:param name="description" select="''" />
		<xsl:param name="image" select="''" />
		<xsl:param name="date" select="''" />
		<xsl:param name="language" select="''" />
		<xsl:param name="twitter-site-id" select="''" />
		<xsl:param name="twitter-creator-id" select="''" />
		<xsl:param name="google-plus-id" select="''" />

		<!-- Defining default Title with Website Name -->
		<xsl:variable name="super-title" select="//params/website-name" />
				
		<!-- Defining content-language format -->
		<xsl:variable name="content-language">
			<xsl:choose>
				<xsl:when test="$language = ''"><xsl:value-of select="'en'" /></xsl:when>
				<xsl:when test="string-length($language) = 5">
					<xsl:value-of select="concat(substring($language,1,2), '-', substring($language,4,5))" />
				</xsl:when>
				<xsl:otherwise><xsl:value-of select="$language" /></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!-- Defining locale format -->
		<xsl:variable name="locale">
			<xsl:choose>
				<xsl:when test="string-length($language) = 5">
					<xsl:value-of select="concat(substring($language,1,2), '_', substring($language,4,5))" />
				</xsl:when>
				<xsl:otherwise><xsl:value-of select="$language" /></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>


		<!-- The Metas Output -->

		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta http-equiv="imagetoolbar" content="no" />
		<meta http-equiv="content-language" content="{$content-language}" />

		<meta name="viewport" content="width=device-width" />
		<meta name="robots" content="index,follow" />
		<meta name="generator" content="Symphony CMS" /> <!-- I'm proud to announce, aren't you? -->
		<meta name="author" content="{//params/website-name}" />
		<meta name="copyright" content="© {//params/this-year} {//params/website-name}" />
		<meta name="distribution" content="global" />
		<meta name="rating" content="general" />
		<meta name="revisit-after" content="1 day" />
		<meta name="expires" content="never" />

		<title><xsl:value-of select="concat($title, $super-title)" /></title>

		<xsl:if test="$keywords != ''">
			<meta name="keywords" content="{$keywords}" />
		</xsl:if>
		<xsl:if test="$description != ''">
			<meta name="description" content="{$description}" />
		</xsl:if>
		<xsl:if test="$date != ''">
			<meta name="date" content="{$date}" />
		</xsl:if>

		<!--
			Facebook
			More info at http://ogp.me/
		-->
		<meta property="og:type" content="website" />
		<meta property="og:title" content="{concat($title, $super-title)}" />
		<meta property="og:url" content="{//params/current-url}" />
		<meta property="og:locale" content="{$locale}" />
		<meta property="og:site_name" content="{//params/website-name}" />
		<xsl:if test="$description != ''">
			<meta property="og:description" content="{$description}" />
		</xsl:if>
		<xsl:if test="$image != ''">
			<meta property="og:image" content="{$image}" />
		</xsl:if>

		<!--
			Twitter
			More info at https://dev.twitter.com/docs/cards
		-->
		<meta name="twitter:card" content="summary" />
		<meta name="twitter:title" content="{concat($title, $super-title)}" />
		<meta name="twitter:url" content="{//params/current-url}" />
		<xsl:if test="$description != ''">
			<meta name="twitter:description" content="{$description}" />
		</xsl:if>
		<xsl:if test="$image != ''">
			<meta name="twitter:image" content="{$image}" />
		</xsl:if>
		<xsl:if test="$twitter-site-id != ''">
			<meta name="twitter:site" content="{$twitter-site-id}" />
		</xsl:if>
		<xsl:if test="$twitter-creator-id != ''">
			<meta name="twitter:creator" content="{$twitter-creator-id}" />
		</xsl:if>

		<!--
			Google Plus
			More info at http://schema.org/
		-->
		<meta itemprop="name" content="{concat($title, $super-title)}" />
		<meta itemprop="url" content="{//params/current-url}" />
		<xsl:if test="$description != ''">
			<meta itemprop="description" content="{$description}" />
		</xsl:if>
		<xsl:if test="$image != ''">
			<meta itemprop="image" content="{$image}" />
		</xsl:if>
		
		<!--
			Google Plus Authoring
			More info at http://support.google.com/webmasters/bin/answer.py?hl=en&answer=1408986
			You also can use <a href="https://plus.google.com/{USERID}? rel=author">AUTHOR NAME</a> inside page content.
		-->
		<xsl:if test="$google-plus-id != ''">
			<link rel="author" href="https://plus.google.com/{$google-plus-id}"/>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>