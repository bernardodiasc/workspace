<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="../utilities/master.xsl"/>
  
<!--
 	MAIN PAGE TEMPLATE
-->
	<xsl:template match="/data">
		<h1><xsl:value-of select="$page-title"/></h1>
	</xsl:template>

<!--
	META IN HEAD
	Add more metas
-->
	<xsl:template match="data" mode="add_head_meta">
		<!-- Head Metas @ utilities html-head-metas -->
		<xsl:call-template name="html-head-metas" />
	</xsl:template>

<!--
	CSS IN HEAD
	Add more stylesheets
-->
	<xsl:template match="data" mode="add_head_css">
	</xsl:template>

<!--
	JS IN BODY
	Add more scripts
-->
	<xsl:template match="data" mode="add_body_js">
	</xsl:template>
</xsl:stylesheet>