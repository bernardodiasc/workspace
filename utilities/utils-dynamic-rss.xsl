<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:content="http://purl.org/rss/1.0/modules/content/"
    xmlns:wfw="http://wellformedweb.org/CommentAPI/"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:atom="http://www.w3.org/2005/Atom"
    xmlns:sy="http://purl.org/rss/1.0/modules/syndication/"
    xmlns:slash="http://purl.org/rss/1.0/modules/slash/"
    xmlns:dyn="http://exslt.org/dynamic"
    extension-element-prefixes="dyn">

    <!--
        Generate a RSS-feed, dynamicly.

        Dependencies:
            Format Date/Time Advanced   : http://symphony-cms.com/download/xslt-utilities/view/20744/
            EXSLT

        Usage:

        Create an XML page which will be your RSS feed. In this, place the following code for example:

            <xsl:call-template name="rss">
                <xsl:with-param name="title" select="'News feed'" />
                <xsl:with-param name="description" select="'The news feed of the website of John Doe'" />
                <xsl:with-param name="link" select="concat($root, '/news/')" />
                <xsl:with-param name="link-feed" select="concat($root, '/news/feed/')" />
                <xsl:with-param name="language" select="'en-us'" />
                <xsl:with-param name="items" select="data/news-last-3/entry" />
                <xsl:with-param name="item-contentnode" select="'content'" />
                <xsl:with-param name="item-datenode" select="'date'" />
                <xsl:with-param name="item-titlenode" select="'title'" />
                <xsl:with-param name="item-link" select="concat($root, '/news/$/')" />
                <xsl:with-param name="item-link-part" select="'title/@handle'" />
                <xsl:with-param name="timezone" select="'+0100'" />
            </xsl:call-template>

        Please note:
            - for item-contentnode, item-datenode and item-titlenode, enter the name of the node in which these values
              are stored.
            - for item-link, use '$' as a placeholder for the dynamic part of the URL
            - in item-link-part you can put an XPath expression to set this dynamic part. You can also use XSL-functions,
              but make sure to entity your quotes when doing this. For example, for an URL with an ID and a handle:
              <xsl:with-param name="item-link-part" select="'concat(@id, &quot;/&quot;, title/@handle)'" />
    -->

    <xsl:import href="../utilities/date-time.xsl" />

    <xsl:template name="rss">
        <!-- Required: -->
        <xsl:param name="title" />
        <xsl:param name="description" />
        <xsl:param name="items" />
        <xsl:param name="item-titlenode" />
        <xsl:param name="item-link" />
        <xsl:param name="item-link-part" />
        <xsl:param name="item-datenode" />
        <xsl:param name="item-contentnode" />

        <!-- Optional: -->
        <xsl:param name="language" select="'en-us'" />
        <xsl:param name="link-feed" select="concat($root, '/feed/')"/>
        <xsl:param name="link" select="$root" />
        <xsl:param name="timezone" select="'+0000'" />

        <!-- Generate the feed: -->
        <rss version="2.0">
            <channel>
                <title><xsl:value-of select="$title" /></title>
                <atom:link href="{$link-feed}" rel="self" type="application/rss+xml" />
                <link><xsl:value-of select="$link" /></link>
                <description><xsl:value-of select="$description" /></description>
                <lastBuildDate>
                    <xsl:call-template name="format-date">
                        <xsl:with-param name="date" select="$today" />
                        <xsl:with-param name="format" select="'%d-;, %0d; %m-; %y+; 00:00:00'" />
                    </xsl:call-template>
                    <xsl:value-of select="concat(' ', $timezone)" />
                </lastBuildDate>
                <language><xsl:value-of select="$language" /></language>
                <sy:updatePeriod>hourly</sy:updatePeriod>
                <sy:updateFrequency>1</sy:updateFrequency>
                <generator>http://www.symphony-cms.com</generator>
                <!-- The items: -->
                <xsl:for-each select="$items">
                    <item>
                        <!-- Generate the link: -->
                        <xsl:variable name="item-link-processed">
                            <xsl:value-of select="substring-before($item-link, '$')" />
                            <xsl:value-of select="dyn:evaluate($item-link-part)" />
                            <xsl:value-of select="substring-after($item-link, '$')" />
                        </xsl:variable>
                        <title><xsl:value-of select="dyn:evaluate($item-titlenode)" /></title>
                        <link><xsl:value-of select="$item-link-processed" /></link>
                        <pubDate>
                            <xsl:call-template name="format-date">
                                <xsl:with-param name="date" select="dyn:evaluate($item-datenode)" />
                                <xsl:with-param name="format" select="'%d-;, %0d; %m-; %y+; #0H;:#0m;:#0s;'" />
                            </xsl:call-template>
                            <xsl:value-of select="concat(' ', $timezone)" />
                        </pubDate>
                        <guid><xsl:value-of select="$item-link-processed" /></guid>
                        <description><xsl:value-of select="dyn:evaluate($item-contentnode)" /></description>
                    </item>
                </xsl:for-each>
            </channel>
        </rss>
    </xsl:template>

</xsl:stylesheet>