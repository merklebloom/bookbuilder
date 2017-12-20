<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">

<xsl:import href="/etc/asciidoc/docbook-xsl/fo.xsl"/>

<!-- Title Page -->

<xsl:template name="book.titlepage.recto">
</xsl:template>

<!-- Header & Footer-->

<xsl:template name="header.content"></xsl:template>

<xsl:param name="region.after.extent">0.4in</xsl:param>
<xsl:param name="region.before.extent">0in</xsl:param>
<xsl:param name="header.rule" select="0"></xsl:param>
<xsl:param name="footer.rule" select="0"></xsl:param>

<!-- Main Font -->

<xsl:param name="body.font.master">10</xsl:param>

<!-- Misc -->

<xsl:param name="ulink.show" select="0"></xsl:param>

<!-- paper size and layout -->

<xsl:param name="page.width">6in</xsl:param>
<xsl:param name="page.height">9in</xsl:param>
<xsl:param name="page.margin.inner">0.625in</xsl:param>
<xsl:param name="page.margin.outer">0.5in</xsl:param>
<xsl:param name="double.sided">1</xsl:param>

<xsl:param name="line-height">normal</xsl:param>

<xsl:param name="force.blank.pages" select="1"></xsl:param>

<!-- TOC and Index -->

<xsl:param name="generate.toc">
book      toc,title,figure,table,example,equation
</xsl:param>
<xsl:param name="toc.section.depth">3</xsl:param>

<xsl:param name="generate.index">1</xsl:param>
<xsl:param name="autolink.index.see" select="1"></xsl:param>

<xsl:param name="local.l10n.xml" select="document('')"/>
<l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0">
  <l:l10n language="en">
    <l:gentext key="TableofContents" text="Table of Contents"/>
  </l:l10n>
</l:i18n>

<xsl:attribute-set name="toc.line.properties">
  <xsl:attribute name="font-weight">
   <xsl:choose>
    <xsl:when test="self::index or self::appendix or self::chapter">bold</xsl:when>
    <xsl:otherwise>normal</xsl:otherwise>
   </xsl:choose>
  </xsl:attribute>
  <xsl:attribute name="font-size">
   <xsl:choose>
    <xsl:when test="self::index or self::appendix or self::chapter">12pt</xsl:when>
    <xsl:otherwise>10pt</xsl:otherwise>
   </xsl:choose>
  </xsl:attribute>
</xsl:attribute-set>

<!-- Heading labels -->

<xsl:param name="part.autolabel">0</xsl:param>
<xsl:param name="chapter.autolabel">0</xsl:param>
<xsl:param name="section.autolabel.max.depth">0</xsl:param>

<!-- Block Quotes -->

<xsl:attribute-set name="blockquote.properties">
<xsl:attribute name="font-size">12</xsl:attribute>
<xsl:attribute name="font-style">italic</xsl:attribute>
<xsl:attribute name="space-before.minimum">0.5em</xsl:attribute>
<xsl:attribute name="space-before.maximum">0.5em</xsl:attribute>
<xsl:attribute name="space-before.optimum">0.5em</xsl:attribute>
<xsl:attribute name="space-after.minimum">0.5em</xsl:attribute>
<xsl:attribute name="space-after.maximum">0.5em</xsl:attribute>
<xsl:attribute name="space-after.optimum">0.5em</xsl:attribute>
<xsl:attribute name="keep-together.within-column">always</xsl:attribute>
<xsl:attribute name="padding">0.2in</xsl:attribute>
</xsl:attribute-set>

<!-- size of section titles -->

  <xsl:attribute-set name="section.title.level1.properties">
  <xsl:attribute name="space-before.minimum">1em</xsl:attribute>
  <xsl:attribute name="font-size">16</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.level2.properties">
  <xsl:attribute name="font-size">14</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.level3.properties">
    <xsl:attribute name="font-size">12</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.level4.properties">
    <xsl:attribute name="font-size">11</xsl:attribute>
    <xsl:attribute name="font-style">italic</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.level5.properties">
    <xsl:attribute name="font-size">11</xsl:attribute>
      <xsl:attribute name="font-style">bold</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.level6.properties">
    <xsl:attribute name="font-size">10</xsl:attribute>
  </xsl:attribute-set>


</xsl:stylesheet>
