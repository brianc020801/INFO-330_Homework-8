<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- The result of this stylesheet should be 384 Pokemon -->
<!-- "Find all Pokemon that have a type of "fire", "water", "flying", or "ground" -->
<!-- SELECT COUNT(*) FROM pokemon_types_view 
     WHERE type2 = ''; = 384 Pokemon -->

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
<xsl:template match="/pokedex">
Single type pokemon: <xsl:value-of select="XPATH-QUERY-GOES-HERE" />:

<xsl:apply-templates select="XPATH-QUERY-GOES-HERE" />
</xsl:template>

<xsl:template match="pokemon">
    <xsl:value-of select="XPATH-QUERY-GOES-HERE" /> (<xsl:value-of select="XPATH-QUERY-GOES-HERE" />): <xsl:value-of select="XPATH-QUERY-GOES-HERE" /> | <xsl:value-of select="XPATH-QUERY-GOES-HERE" /> |
</xsl:template>

<!--
  These rules will generate HTML output rather than text. This is to demonstrate
  the power of using XSLT to create pretty output from XML sources.
  -->
<!-- Select all the pokemon that have only a single type; in the value-of, use the count()
     XPath function to get a total count of the nodes returned by the same query -->
<!--
<xsl:template match="/pokedex">
  <html>
  <body>
  <h2>Single-type Pokemon</h2>
  Count: <xsl:value-of select="XPATH-QUERY-GOES-HERE" />
  <table border="1">
    <tr bgcolor="#9acd32">
      <th>Name</th>
      <th>Classification</th>
      <th>Type</th>
    </tr>
    <xsl:apply-templates select="XPATH-QUERY-GOES-HERE" />
  </table>
  </body>
  </html>
</xsl:template>
-->

<!-- Select the name, Pokedex number, classification and type for each of the value-ofs -->
<!--
<xsl:template match="pokemon">
    <tr>
      <td><xsl:value-of select="XPATH-QUERY-GOES-HERE" />(<xsl:value-of select="XPATH-QUERY-GOES-HERE" />)</td>
      <td><xsl:value-of select="XPATH-QUERY-GOES-HERE" /></td>
      <td><xsl:value-of select="XPATH-QUERY-GOES-HERE" /></td>
    </tr>
</xsl:template>
-->

</xsl:stylesheet>
