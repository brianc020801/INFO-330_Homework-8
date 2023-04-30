<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- Find all Pokemon that have only one type (that is, their "type 2" is empty) -->

<!--
  These rules will generate text output rather than text; these are useful for more easily
  figuring out if you got the "select" queries correct. Once you have that figured out,
  then update the HTML version of these rules below (and comment these out!) to see a nicely-
  formatted HTML file.
  -->
<xsl:template match="/pokedex">
    <xsl:apply-templates select="" />
</xsl:template>

<xsl:template match="pokemon">
    <xsl:value-of select="" /> (<xsl:value-of select="" />): <xsl:value-of select="" /> | 
</xsl:template>

<!--
  These rules will generate HTML output rather than text. This is to demonstrate
  the power of using XSLT to create pretty output from XML sources.
  -->
<!--
<xsl:template match="/pokedex">
  <html>
  <body>
  <h2>Generation One Pokemon</h2>
  <table border="1">
    <tr bgcolor="#9acd32">
      <th>Name</th>
      <th>Classification</th>
    </tr>
    <xsl:apply-templates select="" />
  </table>
  </body>
  </html>
</xsl:template>

<xsl:template match="pokemon">
    <tr>
      <td><xsl:value-of select="" />(<xsl:value-of select="" />)</td>
      <td><xsl:value-of select="" /></td>
    </tr>
</xsl:template>
-->

</xsl:stylesheet>
