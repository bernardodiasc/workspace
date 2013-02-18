<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:g="http://schemas.google.com/g/2005"
		exclude-result-prefixes="g">
								
	<!-- 
			Name: Google +1 Utility
			Version: 1.0.1
			Author: Brian Zerangue <brian.zerangue@gmail.com>
			
			How to use:
			Call the template name="google-plus-one" like so...
			Required Parameter is url, all the other parameters are optional
			
			EXAMPLE ONE (this will default to standard size)
			===============================================================================
			
			<xsl:call-template name="google-plus-one">
				<xsl:with-param name="url" select="'http://site.com'" />
			</xsl:call-template>
			
			EXAMPLE TWO (defining size, will use select another size other than standard)
			===============================================================================
			
			<xsl:call-template name="google-plus-one">
				<xsl:with-param name="url" select="'http://site.com'" />
				<xsl:with-param name="size" select="'small'" />
			</xsl:call-template>
				
	-->


	<xsl:template name="google-plus-one">
		<xsl:param name="url"/><!-- Required -->
		<xsl:param name="size" select="'standard'"/><!-- Options (standard,small,medium,tall), defaults to Standard (24px) -->
		
		<!-- Place this tag where you want the +1 button to render -->
		<xsl:element name="g:plusone">
			<xsl:attribute name="href">
				<xsl:value-of select="$url" />
			</xsl:attribute>
			<xsl:if test="$size!='standard'">
				<xsl:attribute name="size">
					<xsl:choose>
						<xsl:when test="$size='small'">
							<xsl:text>small</xsl:text>
						</xsl:when>
						<xsl:when test="$size='medium'">
							<xsl:text>medium</xsl:text>
						</xsl:when>
						<xsl:when test="$size='tall'">
							<xsl:text>tall</xsl:text>
						</xsl:when>
					</xsl:choose>
				</xsl:attribute>
			</xsl:if>
			<xsl:comment>Google +1 Button</xsl:comment>
		</xsl:element>

		<!--  Place this tag after the last plusone tag -->
		<script type="text/javascript">
		  <xsl:text>(function() {
		    var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
		    po.src = 'https://apis.google.com/js/plusone.js';
		    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
		  })();</xsl:text>
		</script>
	</xsl:template>
</xsl:stylesheet>