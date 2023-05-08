<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- Find all Pokemon that have a type of "fire", "water", "flying", or "ground" -->
<!-- SELECT COUNT(*) FROM pokemon_types_view 
     WHERE type1 IN ('fire', 'water', 'flying', 'ground') 
        OR type2 IN ('fire', 'water', 'flying', 'ground') = 328 Pokemon -->

<!-- 
  This block creates a comma-separated list for the types, so that we get
  either "grass, poison" if they have two types, or "fighting" if they have
  only one type. 
  -->
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
<!-- In this template, select all the pokemon that are fire, water, flying or ground -->
<!--
<xsl:template match="/pokedex">
    <xsl:apply-templates select="XPATH-QUERY-GOES-HERE" />
</xsl:template>
 -->

<!-- In this template, select the name, pokedexNumber, and type in each of the value-of
     statements, respectively. -->
<!-- 
<xsl:template match="pokemon">
    <xsl:value-of select="XPATH-QUERY-GOES-HERE" /> (<xsl:value-of select="XPATH-QUERY-GOES-HERE" />): <xsl:apply-templates select="XPATH-QUERY-GOES-HERE" /><xsl:text>
</xsl:text>
</xsl:template>
-->

<!--
  These rules will generate HTML output rather than text. This is to demonstrate
  the power of using XSLT to create pretty output from XML sources. Note that in
  this template, I use a "xsl:variable" to hold the results of the query, rather
  than repeating it twice (once to do the query, once to get the count) as happens
  in the other xsl files.
  -->
<!-- In this template, select all the pokemon that are fire, water, flying or ground -->
<xsl:template match="/pokedex">
  <xsl:variable name="pokemonResults" select="XPATH-QUERY-GOES-HERE" />

  <html>
  <body>
  <h2>Elemental Pokemon</h2>
  A total of <xsl:value-of select="count($pokemonResults)" />:
  <table border="1">
    <tr bgcolor="#9acd32">
      <th>Name (Pokedex Number)</th>
      <th>Type(s)</th>
    </tr>
    <xsl:apply-templates select="pokemon[$pokemonResults]" />
  </table>
  </body>
  </html>
</xsl:template>

<!-- In this template, select the name, pokedexNumber, and type in each of the value-of
     statements, respectively. -->
<xsl:template match="pokemon">
    <tr>
      <td><xsl:value-of select=".XPATH-QUERY-GOES-HERE" />(<xsl:value-of select="XPATH-QUERY-GOES-HERE" />)</td>
      <td><xsl:apply-templates select="XPATH-QUERY-GOES-HERE" /></td>
    </tr>
</xsl:template>

</xsl:stylesheet>
