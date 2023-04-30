<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- Find all Pokemon that have a type of "fire" -->
<!-- select count(*) from pokemon_types_view where type1 = 'fire' OR type2 = 'fire' = 64 -->

<!-- This generates a comma-separated list for the Pokemon types; 'grass, poison' or 'normal' -->
<xsl:template match="type[position() != last()]"><xsl:value-of select="text()"/>, </xsl:template>
<xsl:template match="type[position() = last()]">
  <xsl:value-of select="text()"/>
</xsl:template>

<!--
  These rules will generate text output rather than text; these are useful for more easily
  figuring out if you got the "select" queries correct. Once you have that figured out,
  then update the HTML version of these rules below (and comment these out!) to see a nicely-
  formatted HTML file.
  -->
<!-- -->
<xsl:template match="/pokedex">
    <xsl:apply-templates select="" />
</xsl:template>

<xsl:template match="pokemon">
    <xsl:value-of select="" /> (<xsl:value-of select="" />): <xsl:apply-templates select="type" /><xsl:text>
</xsl:text>
</xsl:template>

<!--
  These rules will generate HTML output rather than text. This is to demonstrate
  the power of using XSLT to create pretty output from XML sources.
  -->
<!--
<xsl:template match="/pokedex">
  <html>
  <body>
  <h2>All Fire-type Pokemon</h2>
  <table border="1">
    <tr bgcolor="#9acd32">
      <th>Name</th>
      <th>Types</th>
    </tr>
    <xsl:apply-templates select="" />
  </table>
  </body>
  </html>
</xsl:template>

<xsl:template match="pokemon">
    <tr>
      <td><xsl:value-of select="" />(<xsl:value-of select="" />)</td>
      <td><xsl:apply-templates select="type" /></td>
    </tr>
</xsl:template>
-->

</xsl:stylesheet>
