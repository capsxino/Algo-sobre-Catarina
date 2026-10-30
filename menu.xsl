<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="fazMenu">
	<xsl:param name="origem"/>
	<div id="menu">
		<a href="../index.html" title="Inicio" class="menuLink">
			<span class="icon">
				<xsl:value-of select="$icon_casa" />		
			</span>	
		</a>
		<a href="estrutura.xml" title="Estrutura" class="menuLink">
			<span class="icon">
				<xsl:value-of select="$icon_lista" />				
			</span>	
		</a>
		<a class="menuLink">
			<xsl:attribute name="href"><xsl:value-of select="/pagina/@mae" /></xsl:attribute>
			<xsl:attribute name="title"><xsl:value-of select="document(/pagina/@mae)/pagina/cabecalho[1]/titulo" /></xsl:attribute>
			<span class="icon">
				<xsl:value-of select="$icon_cima" />				
			</span>	
		</a>
		<a href="contacto.xml" title="Contacto" class="menuLink">
			<span class="icon">
				<xsl:value-of select="$icon_mail" />				
			</span>	
		</a>
<!--
		<xsl:if test="not(/pagina/@titulo='Primeira Página')">
			<a href="../index.html" title="Inicio" class="menuLink">
				<span class="icon">
					<xsl:value-of select="$icon_casa" />		
				</span>	
			</a>
		</xsl:if>
		<xsl:if test="not(/pagina/@titulo='Estrutura')">
			<a href="estrutura.xml" title="Estrutura" class="menuLink">
				<span class="icon">
					<xsl:value-of select="$icon_lista" />				
				</span>	
			</a>
		</xsl:if>
		<xsl:if test="$origem!='trabalhos'">
			<a href="trabalhos.xml" title="Trabalhos" class="menuLink">
				<span class="icon">
					<xsl:value-of select="$icon_ferramenta" />				
				</span>	
			</a>
		</xsl:if>
		<xsl:if test="$origem!='entrevistas'">
			<a href="entrevistas.xml" title="Entrevistas" class="menuLink">
				<span class="icon">
					<xsl:value-of select="$icon_jornal" />				
				</span>	
			</a>
		</xsl:if>
		<xsl:if test="$origem!='cronologia'">
			<a href="cronologia.xml" title="Cronologia" class="menuLink">
				<span class="icon">
					<xsl:value-of select="$icon_relogio" />				
				</span>	
			</a>
		</xsl:if>
		<xsl:for-each select="cabecalho[1]/mae">
			<xsl:if test=". != 'trabalhos.xml' and . != 'entrevistas.xml' and . != 'biografia.xml'">	
				<a class="menuLink">
					<xsl:attribute name="href"><xsl:value-of select="text()" /></xsl:attribute>
					<xsl:attribute name="title"><xsl:value-of select="document(text())/pagina/cabecalho[1]/titulo" /></xsl:attribute>
					<span class="icon">
						<xsl:value-of select="$icon_cima" />				
					</span>
				</a>
			</xsl:if>
		</xsl:for-each>
		<xsl:if test="/pagina/@mae!='inicio.xml'">
			<a class="menuLink">
				<xsl:attribute name="href"><xsl:value-of select="/pagina/@mae" /></xsl:attribute>
				<xsl:attribute name="title"><xsl:value-of select="document(/pagina/@mae)/pagina/cabecalho[1]/titulo" /></xsl:attribute>
				<span class="icon">
					<xsl:value-of select="$icon_cima" />				
				</span>	
			</a>
		</xsl:if>
-->
		<span id="menuTitulo1">Algo Sobre</span>
		<span id="menuTitulo2">Catarina Furtado</span>
		<span id="menuTitulo3"> por Jorge C.</span>

	</div>
</xsl:template>

</xsl:stylesheet>