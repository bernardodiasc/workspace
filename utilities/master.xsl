<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:import href="../utilities/utils-typography.xsl"/>
	<xsl:import href="../utilities/utils-nl2br.xsl"/>
	<xsl:import href="../utilities/utils-pagination.xsl"/>
	<xsl:import href="../utilities/utils-format-date.xsl"/>
	<xsl:import href="../utilities/utils-truncate.xsl"/>

	<xsl:import href="../utilities/html-head-metas.xsl"/>
	
	<xsl:output method="html" encoding="utf-8" omit-xml-declaration="yes" indent="no" />
	
	<xsl:variable name="admin-logged-in" select="/data/logged-in-author/author"/>
	<xsl:variable name="enviroment">
		<xsl:choose>
			<xsl:when test="//params/root = 'xxx'">development</xsl:when> <!-- xxx must have the root value on dev enviroment -->
			<xsl:otherwise>production</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:template match="/">
		<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>

		<xsl:comment><![CDATA[[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="pt-BR"><![endif]]]></xsl:comment>
		<xsl:comment><![CDATA[[if IE 7]><html class="no-js lt-ie9 lt-ie8" lang="pt-BR"><![endif]]]></xsl:comment>
		<xsl:comment><![CDATA[[if IE 8]><html class="no-js lt-ie9" lang="pt-BR"><![endif]]]></xsl:comment>
		<xsl:comment><![CDATA[[if gt IE 8]><!]]></xsl:comment><html lang="pt-BR" prefix="og: http://ogp.me/ns#" itemscope="itemscope" itemtype="http://schema.org/Thing"><xsl:comment><![CDATA[<![endif]]]></xsl:comment>

			<head>
				<!-- This is a hook allowing pages to add metas -->
				<xsl:apply-templates select="/data" mode="add_head_meta" />
				
				<!-- CSS -->
				<link rel="stylesheet" href="{$root}/less/assets/css/styles.less" />
				<!--<link rel="stylesheet" href="{$workspace}/css/styles.css" />-->
				
				<!-- Favicons -->
				<!--<link rel="shortcut icon" href="{$workspace}/assets/img/favicon.ico" />
				<link rel="apple-touch-icon" href="{$workspace}/assets/img/apple-touch-icon.png" />
				<link rel="apple-touch-icon" sizes="72x72" href="{$workspace}/assets/img/apple-touch-icon-72x72.png" />
				<link rel="apple-touch-icon" sizes="114x114" href="{$workspace}/assets/img/apple-touch-icon-114x114.png" />-->
				
				<!-- JS -->
				<xsl:text disable-output-escaping='yes'>&lt;!--[if lt IE 8]&gt;</xsl:text>
				<script src="{$workspace}/assets/js/vendor/selectivizr-min.js"></script>
				<xsl:text disable-output-escaping='yes'>&lt;![endif]--&gt;</xsl:text>
				<script src="{$workspace}/assets/js/vendor/modernizr-2.6.2-respond-1.1.0.min.js"></script>

				<!-- This is a hook allowing pages to add styles -->
				<xsl:apply-templates select="/data" mode="add_head_css"/>
			</head>
			
			<body>
				<xsl:comment>
					<![CDATA[[if lt IE 9]>
						<p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
					<![endif]]]>
				</xsl:comment>

				<!-- Pages @ pages -->
				<xsl:apply-templates />
				
				<!--<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>-->
				<!--<script>window.jQuery || document.write('<script src="{$workspace}/assets/js/vendor/jquery-1.9.0.min.js"><\/script>')</script>-->
				<script src="{$workspace}/assets/js/vendor/jquery-1.9.0.min.js"></script>
				<script src="{$workspace}/assets/js/vendor/jquery.placeholder.min.js"></script>
				<script>
					$(function(){
						$('input, textarea').placeholder();
						$('.chromeframe').on('click', function() {
							$(this).slideUp('fast');
						});
						$('a[data-target*=blank]').click( function() {
							window.open(this.href);
							return false;
						});
					});
				</script>
				<xsl:if test="not($admin-logged-in) and not($enviroment = 'development')">
					<script>
						var _gaq=[['_setAccount','xxxxxxxxxxx'],['_trackPageview']];
						(function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
						g.src=('https:'==location.protocol?'//ssl':'//www')+'.google-analytics.com/ga.js';
						s.parentNode.insertBefore(g,s)}(document,'script'));
					</script>
				</xsl:if>

				<!-- This is a hook allowing pages to add scripts -->
				<xsl:apply-templates select="/data" mode="add_body_js"/>
			</body>
		</html>
	 
	</xsl:template>

  <!-- Add this in pages to add more metas -->
  <xsl:template match="data" mode="add_head_meta">
  </xsl:template>

  <!-- Add this in pages to add more stylesheets -->
  <xsl:template match="data" mode="add_head_css">
  </xsl:template>

  <!-- Add this in pages to add more scripts -->
  <xsl:template match="data" mode="add_body_js">
  </xsl:template>
	 
</xsl:stylesheet>