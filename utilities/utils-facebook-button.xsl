<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
        
    <xsl:template name="facebook-like">
        <xsl:param name="url-to-like"/><!-- Required -->
        <xsl:param name="layout" select="'standard'"/>
        <xsl:param name="show_faces" select="'false'"/>
        <xsl:param name="font" select="'verdana'"/>
        <xsl:param name="width" select="'35'"/>
        <xsl:param name="action" select="'like'"/>
        <xsl:param name="colorscheme" select="'light'"/>
        <xsl:param name="lang" select="'en_US'"/>
        <xsl:param name="send" select="'false'"/>

        <script type="text/javascript">
 		<xsl:comment>
		(function() {
		    document.write('&lt;fb:like  href="<xsl:value-of select="$url-to-like"/>" layout="<xsl:value-of select="$layout"/>" show_faces="<xsl:value-of select="$show_faces"/>" font="<xsl:value-of select="$font"/>" width="<xsl:value-of select="$width"/>" colorscheme="<xsl:value-of select="$colorscheme"/>" send="<xsl:value-of select="$send"/>" &gt;&lt;/fb:like&gt;');
		    var s = document.createElement('SCRIPT'), s1 = document.getElementsByTagName('SCRIPT')[0];
		    s.type = 'text/javascript';
		    s.async = true;
		    s.src = 'http://connect.facebook.net/<xsl:value-of select="$lang"/>/all.js#xfbml=1';
		    s1.parentNode.insertBefore(s, s1);
		})();
		//</xsl:comment>
		</script>  
        
    </xsl:template>
</xsl:stylesheet>