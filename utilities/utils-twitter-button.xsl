<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="twitter-button">
		<xsl:param name="data-count" select="'none'" /> <!-- 'none', 'horizontal' or 'vertical'  -->
		<xsl:param name="data-url" select="''"/>
		<xsl:param name="data-text" select="''"/>
		<xsl:param name="data-lang" select="''"/>

		<script type="text/javascript">
		<xsl:comment>
			(function() {
			    document.write('&lt;a href="http://twitter.com/share" class="twitter-share-button" data-count="<xsl:value-of select="$data-count"/>"<xsl:if test="$data-url"> data-url="<xsl:value-of select="$data-url"/>"</xsl:if><xsl:if test="$data-text"> data-text="<xsl:value-of select="$data-text"/>"</xsl:if><xsl:if test="$data-lang"> data-lang="<xsl:value-of select="$data-lang"/>"</xsl:if>&gt;Tweet&lt;/a&gt;');
			    var s = document.createElement('SCRIPT'), s1 = document.getElementsByTagName('SCRIPT')[0];
			    s.type = 'text/javascript';
			    s.async = true;
			    s.src = 'http://platform.twitter.com/widgets.js';
			    s1.parentNode.insertBefore(s, s1);
			})();
		//</xsl:comment>
		</script>
		
			
	</xsl:template>
</xsl:stylesheet>