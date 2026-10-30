<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="UTF-8" indent="yes"/>
<xsl:include href="icons.xsl" />
<xsl:include href="menu.xsl" />

<xsl:template match="/pagina/cronologia">
	<html>
		<head>
			<title>Algo sobre Catarina Furtado - Cronologia</title>
			<link rel="stylesheet" type="text/css" href="fontes.css" />
			<link rel="stylesheet" type="text/css" href="menu.css" />
			<link rel="stylesheet" type="text/css" href="cronologia.css" />
			<script type="text/javascript" src="menu.js"></script>
		</head>
		<body onload="inicializaMenu();">
			<xsl:call-template name="fazMenu"/>
   		<div id="tituloTopo">Cronologia</div>
			<table id="cronologia">
				<xsl:for-each select="linha">
					<tr>
						<td>
							<xsl:value-of select="dia" />
							<xsl:choose>
								<xsl:when test="number(mes)=1"> Janeiro </xsl:when>
								<xsl:when test="number(mes)=2"> Fevereiro </xsl:when>
								<xsl:when test="number(mes)=3"> Março </xsl:when>
								<xsl:when test="number(mes)=4"> Abril </xsl:when>
								<xsl:when test="number(mes)=5"> Maio </xsl:when>
								<xsl:when test="number(mes)=6"> Junho </xsl:when>
								<xsl:when test="number(mes)=7"> Julho </xsl:when>
								<xsl:when test="number(mes)=8"> Agosto </xsl:when>
								<xsl:when test="number(mes)=9"> Setembro </xsl:when>
								<xsl:when test="number(mes)=10"> Outubro </xsl:when>
								<xsl:when test="number(mes)=11"> Novembro </xsl:when>
								<xsl:when test="number(mes)=12"> Dezembro </xsl:when>
								<xsl:otherwise>---</xsl:otherwise>
							</xsl:choose>
							<xsl:value-of select="ano" />
						</td>
						<td>
							<xsl:value-of select="descricao" />
						</td>
						<td>
							<xsl:for-each select="link[text()]">
								<a targer="_blank">
									<xsl:attribute name="href">
										<xsl:value-of select="text()" />
									</xsl:attribute>
									<span class="icon"><xsl:value-of select="$icon_elo" /></span>
								</a>								
							</xsl:for-each>
						</td>
					</tr>
				</xsl:for-each>
			</table>
		</body>
	</html>
</xsl:template>

</xsl:stylesheet>