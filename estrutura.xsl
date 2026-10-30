<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="UTF-8" indent="yes"/>
<xsl:include href="icons.xsl" />
<xsl:include href="menu.xsl" />

<xsl:template match="/pagina">
	<html>
		<head>
			<title>Algo sobre Catarina Furtado - Estrutura</title>
			<link rel="stylesheet" type="text/css" href="fontes.css" />
			<link rel="stylesheet" type="text/css" href="menu.css" />
			<link rel="stylesheet" type="text/css" href="estrutura.css" />
			<script type="text/javascript" src="menu.js"></script>
			<script type="text/javascript" src="estrutura.js"></script>
		</head>
		<body onload="inicializaMenu();">
			<xsl:call-template name="fazMenu"/>
   		<div id="tituloTopo">Estrutura</div>
   		<xsl:call-template name="poeBotoes"/>
   		<xsl:call-template name="desenhaArvore">
				<xsl:with-param name="no" select="document('arvore.xml')//arvore/no[1]"/>
			</xsl:call-template>
			<xsl:call-template name="poeBotoes"/>
			<script type="text/javascript">inicializaEstrutura();</script>
   	</body>
	</html>
</xsl:template>

<xsl:template name="desenhaArvore">
	<xsl:param name="no"/>
	<xsl:choose>
		<xsl:when test="$no/no">
			<xsl:variable name="noId" select="generate-id()"/>
			<table class="no fechado" id="{$noId}">
				<tr>
					<td>
						<div class="mostra mais" id="{concat('mostra',$noId)}" onclick="fechaAbre('{$noId}')"/>
					</td>
					<td>
						<a class="nome">
							<xsl:if test="$no/@estado!='rascunho'">
								<xsl:attribute name="href">
									<xsl:value-of select="$no/@nome"/>
								</xsl:attribute>
							</xsl:if>
							<xsl:value-of select="$no/@titulo"/>
						</a>
					</td>
				</tr>
				<tr>
					<td></td>
					<td>
						<div class="filhos" id="{concat('filhos',$noId)}" style="display:none;">
							<xsl:for-each select="$no/no">
								<xsl:sort select="@titulo"/>
								<xsl:call-template name="desenhaArvore">
									<xsl:with-param name="no" select="."/>
								</xsl:call-template>
							</xsl:for-each>
						</div>
					</td>
				</tr>
			</table>
		</xsl:when>
		<xsl:otherwise>
			<table class="no">
				<tr>
					<td>
						<div class="mostra"/>
					</td>
					<td>
						<a class="nome">
							<xsl:if test="$no/@estado!='rascunho'">
								<xsl:attribute name="href">
									<xsl:value-of select="$no/@nome"/>
								</xsl:attribute>
							</xsl:if>
							<xsl:value-of select="$no/@titulo"/>
						</a>
					</td>
				</tr>
			</table>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="poeBotoes">
	<div class="caixaBotoes">
		<div class="botaoAbreTudo" onclick="abreTudo()" />
  		<div class="botaoFechaTudo" onclick="fechaTudo()" />
  	</div>
</xsl:template>

</xsl:stylesheet>