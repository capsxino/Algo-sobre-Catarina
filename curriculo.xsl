<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
	<html>
		<head>
			<title>Algo sobre Catarina Furtado - Curriculo</title>
			<link rel="stylesheet" type="text/css" href="curriculo.css" />
		</head>
		<body>
			<table>
				<xsl:for-each select="curriculo/e">
					<tr>
						<td class="ano">
							<xsl:value-of select="ano"/>
						</td>
						<td class="trabalho">
							<xsl:copy-of select="a"/>
						</td>
						<td class="estado">
							<xsl:variable name="estado" select="document(a/@href)/pagina/@estado" />
							<xsl:choose>
								<xsl:when test="$estado='completa'">
									<span style="background-color:green">completa</span>
								</xsl:when>
								<xsl:when test="$estado='incompleta'">
									<span style="background-color:orange">incompleta</span>
								</xsl:when>
								<xsl:when test="$estado='rascunho'">
									<span style="background-color:yellow">rascunho</span>
								</xsl:when>
								<xsl:otherwise>
									<span style="background-color:red">indefinida</span>							
								</xsl:otherwise>
							</xsl:choose>					
						</td>
					</tr>
			</xsl:for-each>
			</table>
		</body>
	</html>
</xsl:template>

</xsl:stylesheet>