<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="UTF-8" indent="yes"/>
<xsl:include href="icons.xsl" />
<xsl:include href="menu.xsl" />

<xsl:variable name="arvore" select="document('arvore.xml')"/>

<!-- PÁGINA (root)
- <pagina mae="" estado="completa/incompleta/rascunho/invisivel" titulo="" cor="">
	- mae : página antecessora na estrutura do site;
	- estado :
		- completa : página é mostrada normalmente;
		- incompleta : página é exibida com uma mensagem a declarar a sua incompletude;
		- rascunho : a página é exibida mas os links para ela não estão activos;
		- invisivel : a página é exibida mas está ausente da estrutura do site.
	- cor : define a cor de fundo da página; por defeito é branca.
	- titulo : se a página não tiver cabeçalho este é o titulo exibido no topo da página.
- A <pagina> XML é apenas composta por um <cabeçalho> e um <corpo>.
-->
<xsl:template match="/pagina">
	<html>
		<head>
			<title>Algo sobre Catarina Furtado - <xsl:value-of select="@titulo|cabecalho/titulo" /></title>
			<link rel="stylesheet" type="text/css" href="fontes.css" />
			<link rel="stylesheet" type="text/css" href="menu.css" />
			<link rel="stylesheet" type="text/css" href="pagina.css" />
			<script type="text/javascript" src="menu.js"></script>
			<script type="text/javascript" src="pagina.js"></script>
		</head>
		<body onload="inicializaMenu();inicializaCabecalhos();inicializaArvores();fixaMenu();tornaVisivel();" onresize="inicializaCabecalhos();">
			<xsl:choose>
				<xsl:when test="cabecalho">
					<xsl:apply-templates select="cabecalho[1]" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="@cor!=''">
							<xsl:attribute name="style">background-color:<xsl:value-of select="@cor"/>;</xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="style">background-color:FloralWhite;</xsl:attribute>						
						</xsl:otherwise>		
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:call-template name="fazMenu" />
			<xsl:if test="not(cabecalho)">
				<div class="tituloTopo">
					<xsl:value-of select="@titulo"/>
				</div>
			</xsl:if>
			<xsl:apply-templates select="corpo[1]" />
			<!--<div id="debug"></div>-->
		</body>
	</html>
</xsl:template>

<!-- ARVORE
- <arvore poda="" ordem="" />
	- poda : exibe a estrutura do site que se encontra a jusante da página declarada;
	- ordem : Se for declarada 'data' então ordena as páginas por data de realização. Por defeito a ordem é a data de actualização da páginas.
- Tem que estar dentro de <corpo>
-->
<xsl:template match="arvore">
	<xsl:variable name="poda" select="@poda"/>
	<div class="arvore">
		<xsl:choose>
			<xsl:when test="@ordem='data'">
				<xsl:for-each select="$arvore//no[@nome=$poda]//pagina">
					<xsl:sort select="@data" data-type="number" order="descending" />
					<xsl:copy-of select="div"/>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="$arvore//no[@nome=$poda]//pagina">
					<xsl:sort select="@posicao" data-type="number" order="ascending" />
					<xsl:copy-of select="div"/>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
		<div class="mostraMais">
			<xsl:attribute name="onclick">mostraMais(this.parentNode);</xsl:attribute>
			<div>Mostra Mais</div>
		</div>
	</div>
</xsl:template>

<!-- BLOCO
- <bloco titulo=""></bloco>
- O <bloco> pode estar dentro de outro <bloco>, estando a uma profundidade maior que o <bloco> pai.
- Cada <bloco> é escrito depois duma tag <h*> (sendo * a profundidade).
-->
<xsl:template match="bloco">
	<xsl:param name="profundidade" />
	<a name="{generate-id(.)}" />
	<xsl:element name="{concat('h',$profundidade)}">
		<xsl:value-of select="@titulo"/>
	</xsl:element>
	<xsl:apply-templates select="*">
		<xsl:with-param name="profundidade" select ="$profundidade+1" />
	</xsl:apply-templates>
</xsl:template>

<!-- CABEÇALHO 
<cabecalho>
	<titulo></titulo>
	<descricao></descricao>
	<data><ano></ano><mes></mes><dia></dia></data>
	<fundo></fundo>
</cabecalho>
-->
<xsl:template match="cabecalho">
	<div class="cabecalhoFundo">
		<xsl:choose>
			<xsl:when test="not(fundo/text())">
				<xsl:attribute name="style">background-image:url('imagens/wow.jpg');</xsl:attribute>	
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="style">
					<xsl:value-of select="concat('background-image:url(',fundo/text(),');')" />
				</xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
		<div class="cabecalho">
			<div class="cabecalhoLegenda">
				<xsl:value-of select="fundo/@legenda" />
			</div>
			<div class="cabecalhoSobre">
				<div class="cabecalhoFiliacao">
					<xsl:call-template name="filiacao">
						<xsl:with-param name="nome" select="../@mae"/>
					</xsl:call-template>
				</div>
				<div class="cabecalhoTitulo">
					<xsl:value-of select="titulo" />
				</div>
				<table class="cabecalhoData">
					<tr>
						<xsl:for-each select="data">
							<td>
								<xsl:value-of select="ano" />
							</td>
						</xsl:for-each>
					</tr>
					<tr>
						<xsl:for-each select="data">
							<td>
								<xsl:if test="dia/text() and dia">
									<span>
										<xsl:value-of select="dia" />
									</span>	
									<span> de </span>
								</xsl:if>
								<span>
									<xsl:choose>
										<xsl:when test="number(mes)=1">Janeiro</xsl:when>
										<xsl:when test="number(mes)=2">Fevereiro</xsl:when>
										<xsl:when test="number(mes)=3">Março</xsl:when>
										<xsl:when test="number(mes)=4">Abril</xsl:when>
										<xsl:when test="number(mes)=5">Maio</xsl:when>
										<xsl:when test="number(mes)=6">Junho </xsl:when>
										<xsl:when test="number(mes)=7">Julho</xsl:when>
										<xsl:when test="number(mes)=8">Agosto</xsl:when>
										<xsl:when test="number(mes)=9">Setembro</xsl:when>
										<xsl:when test="number(mes)=10">Outubro</xsl:when>
										<xsl:when test="number(mes)=11">Novembro</xsl:when>
										<xsl:when test="number(mes)=12">Dezembro</xsl:when>
										<xsl:otherwise></xsl:otherwise>
									</xsl:choose>
								</span>
							</td>
						</xsl:for-each>
					</tr>
				</table>
				<div class="cabecalhoDescricao">
					<xsl:copy-of select="descricao" />
				</div>
				<xsl:choose>
					<xsl:when test="/pagina/@estado='incompleta'">			
						<div class="cabecalhoEstado">Esta página está incompleta.</div>
					</xsl:when>
					<xsl:when test="/pagina/@estado='rascunho'">			
						<div class="cabecalhoEstado">Esta página é apenas um rascunho.</div>
					</xsl:when>
					<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
			</div>
		</div>
	</div>
</xsl:template>

<!-- CITAÇÃO
<citacao href="" autor="" fonte="" ano=""></citacao>
-->
<xsl:template match="citacao">
	<div class="caixa">
		<div class="esquerda">
			<div>	
				<xsl:choose>
					<xsl:when test="@href">
						<xsl:attribute name="class">citacaoSobre com_link</xsl:attribute>
						<xsl:attribute name="onclick">window.open('<xsl:value-of select="@href" />','_self')</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="class">citacaoSobre</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
				<div class="icon">
					<xsl:value-of select="$icon_balao" />				
				</div>
				<div class="citacaoAutor">
					<xsl:value-of select="@autor" />
				</div>			
				<div class="citacaoFonte"> 
					<xsl:value-of select="@fonte" />			
				</div>							
				<div class="citacaoAno">
					<xsl:value-of select="@ano" />
				</div>				
			</div>
		</div>
		<div class="centro">
			<div>
				<xsl:choose>
					<xsl:when test=".//del">
						<xsl:attribute name="class">citacaoInvisivel</xsl:attribute>
						<xsl:attribute name="onclick">this.className='citacao';</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="class">citacao</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:copy-of select="." />
			</div>
		</div>
		<div class="direita">
			<xsl:if test=".//del">
				<div class="citacaoSobre2">			
					<span class="icon">
						<xsl:value-of select="$icon_dedoEsquerda" />			
					</span>
					<span>&#160;<i>Clique</i> para ver mais</span>		
				</div>
			</xsl:if>	
		</div>
	</div>
</xsl:template>

<!-- CONSTROI INDICE -->
<xsl:template name="constroi_indice">
	<ul>
		<xsl:for-each select="bloco|incorporar">
			<xsl:if test="self::bloco">
				<li>
					<a href="#{generate-id(.)}">
						<xsl:value-of select="@titulo"/>	
					</a>
					<xsl:call-template name="constroi_indice" />	
				</li>	
			</xsl:if>
			<xsl:if test="self::incorporar">
				<xsl:variable name="documento" select="document(text())/pagina" />
				<li>
					<a href="#{generate-id(.)}">
						<xsl:value-of select="$documento/cabecalho/titulo" />	
					</a>
					<xsl:for-each select="$documento/corpo[1]">
						<xsl:call-template name="constroi_indice" />	
					 </xsl:for-each>
				</li>
			</xsl:if>
		</xsl:for-each>
	</ul>
</xsl:template>

<!-- CORPO -->
<xsl:template match="corpo">
	<div id="corpo">
		<xsl:if test="bloco|incorporar">
			<div class="caixa">
				<div class="esquerda">
					<div id="indiceSobre">
						<div class="icon"><xsl:value-of select="$icon_az" /></div>
					</div>										
				</div>
				<div class="centro">
					<div id="indice">	
						<xsl:call-template name="constroi_indice" />
					</div>
				</div>
				<div class="direita"></div>
			</div>
		</xsl:if>
		<xsl:apply-templates select="*">
			<xsl:with-param name="profundidade" select ="1" />
		</xsl:apply-templates>
	</div>
</xsl:template>

<!-- CRÉDITOS
<creditos titulo="">
	<nome titulo=""></nome>
</creditos>
-->
<xsl:template match="creditos">
	<div class="caixa">
		<div class="esquerda">
			<div class="creditosSobre">
				<div class="icon"><xsl:value-of select="$icon_caneta" /></div>
				<div class="creditosTitulo">
					<xsl:value-of select="@titulo" />
				</div>
			</div>		
		</div>
		<div class="centro">
			<div class="creditos">
				<table >
					<xsl:for-each select="nome">
						<tr>
							<td><xsl:value-of select="@titulo"/></td>
							<td><xsl:copy-of select="node()"/></td>
						</tr>
					</xsl:for-each>
				</table>	
			</div>	
		</div>
		<div class="direita"></div>
	</div>
</xsl:template>

<!-- DATA POR EXTENSO -->
<xsl:template name="dataPorExtenso" >
	<xsl:param name="datas" />
	<!-- Encontra a data mais antiga -->
	<xsl:variable name="dataX" select="$datas[not(ano &gt; $datas/ano)]" />
	<xsl:variable name="dataY" select="$dataX[not(mes &gt; $dataX/mes)]" />
	<xsl:variable name="dataZ" select="$dataY[not(dia &gt; $dataY/dia)]" />
	<xsl:variable name="data" select="$dataZ" />
	<xsl:if test="$data/dia/text() and $data/dia">
		<span><xsl:value-of select="$data/dia" /> de </span>
	</xsl:if>
 	<span>
		<xsl:choose>
			<xsl:when test="number($data/mes)=1">Janeiro de </xsl:when>
			<xsl:when test="number($data/mes)=2">Fevereiro de </xsl:when>
			<xsl:when test="number($data/mes)=3">Março de </xsl:when>
			<xsl:when test="number($data/mes)=4">Abril de </xsl:when>
			<xsl:when test="number($data/mes)=5">Maio de </xsl:when>
			<xsl:when test="number($data/mes)=6">Junho de </xsl:when>
			<xsl:when test="number($data/mes)=7">Julho de </xsl:when>
			<xsl:when test="number($data/mes)=8">Agosto de </xsl:when>
			<xsl:when test="number($data/mes)=9">Setembro de </xsl:when>
			<xsl:when test="number($data/mes)=10">Outubro de </xsl:when>
			<xsl:when test="number($data/mes)=11">Novembro de </xsl:when>
			<xsl:when test="number($data/mes)=12">Dezembro de </xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>
	</span>
	<span>
		<xsl:value-of select="$data/ano" />
	</span>
</xsl:template>

<!-- ELO
<elo href="">[descrição]</elo>
-->
<xsl:template match="elo">
	<div class="caixa" style="margin:0;">
		<div class="esquerda">
			<div class="eloSobre">
				<div class="icon">
					<xsl:call-template name="iconizeURL">
						<xsl:with-param name="url" select="@href"/>
					</xsl:call-template>			
				</div>			
			</div>		
		</div>
		<div class="centro">
			<div class="elo">
				<a>
					<xsl:attribute name="href">
						<xsl:value-of select="@href" />
					</xsl:attribute>
					<xsl:choose>
						<xsl:when test="text()">
							<xsl:copy-of select="node()"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="@href" />
						</xsl:otherwise>
					</xsl:choose>			
				</a>
			</div>
		</div>
		<div class="direita">	
				<xsl:if test="@href='' or not(@href and text())">
					<div style="color:red;font-size:1em;" class="icon">
						<xsl:value-of select="$icon_erro"/>			
					</div>
				</xsl:if>		
		</div>
	</div>
</xsl:template>

<!-- GRANDE -->
<xsl:template match="grande">
	<div style="font-size:1.5em;">
		<xsl:apply-templates select="*" />
	</div>
</xsl:template>

<!-- FILIAÇÃO -->
<xsl:template name="filiacao">
	<xsl:param name="nome"/>
	<xsl:if test="$nome">
		<xsl:variable name="no" select="$arvore//no[@nome=$nome]"/>
		<xsl:variable name="mae" select="$arvore//no[@nome=$nome]/../@nome"/>
		<xsl:call-template name="filiacao">
			<xsl:with-param name="nome" select="$mae"/>
		</xsl:call-template>
		<a href="{$nome}">
			<xsl:value-of select="$no/@titulo"/>
		</a>
		<span> > </span>
	</xsl:if>
</xsl:template>

<!-- ICONIZE URL -->
<xsl:template name="iconizeURL">
	<xsl:param name = "url" />
	<xsl:choose>
		<xsl:when test="contains($url,'youtu') or contains($url,'video') or contains($url,'vimeo')">
			<xsl:value-of select="$icon_video" />
		</xsl:when>
		<xsl:when test="contains($url,'picasa')">
			<xsl:value-of select="$icon_fotografia" />
		</xsl:when>
		<xsl:when test="contains($url,'www.publico.pt') or contains($url,'www.cmjornal.xl.pt') or contains($url,'www.jn.pt') or contains($url,'www.dn.pt')">
			<xsl:value-of select="$icon_jornal" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$icon_elo" />
		</xsl:otherwise>				
	</xsl:choose>	
</xsl:template>

<!-- IMAGEM
<imagem href="" legenda="">[url da imagem a exibir]</imagem>
-->
<xsl:template match="imagem">
	<div class="caixa">
		<div class="esquerda"></div>
		<div class="centro">
			<div>
				<xsl:attribute name="style">background-image:url('<xsl:value-of select="text()" />')</xsl:attribute>
				<xsl:choose>
					<xsl:when test="@href">
						<xsl:attribute name="class">imagem com_link</xsl:attribute>
						<xsl:attribute name="onclick">window.open('<xsl:value-of select="@href" />')</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="class">imagem</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
				<img>
					<xsl:attribute name="src">
						<xsl:value-of select="text()" />
					</xsl:attribute>
				</img>
			</div>
		</div>
		<div class="direita">
			<xsl:if test="@legenda">
				<div class="imagemSobre"><xsl:value-of select="@legenda" /></div>
			</xsl:if>
		</div>
	</div>
</xsl:template>

<!-- INCORPORAR 
- <incorporar>[url da página xml]</incorporar>
- Incorpora na página outra página.
- Se a tag estiver dentro dum bloco não é mostrado o cabeçalho da página incorporada; se estiver fora é.
-->
<xsl:template match="incorporar">
	<xsl:param name="profundidade" />
	<xsl:variable name="documento" select="document(text())/pagina" />
	<a name="{generate-id(.)}" />
	<xsl:choose>
		<xsl:when test="$profundidade=1">
			<xsl:apply-templates select="$documento/cabecalho" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:element name="{concat('h',$profundidade)}">
				<xsl:value-of select="$documento/cabecalho/titulo" />
			</xsl:element>
			<xsl:element name="{concat('h',$profundidade+2)}">
				<xsl:call-template name="dataPorExtenso">
				 <xsl:with-param name="datas" select="$documento/cabecalho/data" />
				</xsl:call-template>
			</xsl:element>
			<xsl:if test="$documento/cabecalho/fundo/text()">
				<div class="caixa">
					<div class="esquerda"></div>
					<div class="centro">
						<div class="imagem">
							<xsl:attribute name="style">background-image:url('<xsl:value-of select="$documento/cabecalho/fundo/text()" />')</xsl:attribute>
							<img>
								<xsl:attribute name="src">
									<xsl:value-of select="$documento/cabecalho/fundo/text()" />
								</xsl:attribute>
							</img>
						</div>	
					</div>
					<div class="direita">
						<xsl:if test="$documento/cabecalho/fundo/@legenda">
							<div class="imagemSobre"><xsl:value-of select="$documento/cabecalho/fundo/@legenda" /></div>
						</xsl:if>	
					</div>
				</div>
			</xsl:if>
		</xsl:otherwise>
	</xsl:choose>
	<xsl:apply-templates select="$documento/corpo/*">
		<xsl:with-param name="profundidade" select ="$profundidade+1" />
	</xsl:apply-templates>
</xsl:template>

<!-- LETRA 
- <letra titulo=""></letra>
- Letras de canções, poemas...
-->
<xsl:template match="letra">
	<div class="caixa">
		<div class="esquerda">
			<div class="letraSobre">
				<div class="icon">
					<xsl:value-of select="$icon_pena" />				
				</div>
				<div class="letraTitulo">
					<xsl:value-of select="@titulo" />
				</div>		
			</div>
		</div>
		<div class="centro">
			<div class="letraPapel">
				<div class="letra">
					<xsl:copy-of select="." />
				</div>
			</div>
		</div>
		<div class="direita"></div>
	</div>
</xsl:template>

<!-- P
- Dentro da tag parágrafo,todo o HTML é permitido.
-->
<xsl:template match="p">
	<div class="caixa">
		<div class="esquerda"></div>
		<div class="centro">
			<div class="paragrafo">
				<xsl:copy-of select="." />
			</div>		
		</div>
		<div class="direita">	
		</div>
	</div>
</xsl:template>

<!-- PEQUENO -->
<xsl:template match="pequeno">
	<div style="font-size:.5em;">
		<xsl:apply-templates select="*" />
	</div>
</xsl:template>

<!-- TABELA
- <tabela titulo=""></tabela>
- Segue de perto a forma da tag HTML <table>
-->
<xsl:template match="tabela">
	<div class="caixa">
		<div class="esquerda">
			<div class="tabelaTitulo">
				<xsl:value-of select="@titulo"/>			
			</div>		
		</div>
		<div class="centro">
			<table class="tabela">
				<xsl:copy-of select="*" />
			</table>
		</div>
		<div class="direita">	
		</div>
	</div>
</xsl:template>

<!-- VIDEO
<video legenda="" imagem="">[URL do video MP4]</video>
- imagem : imagem mostrada até o 'play' do video.
-->
<xsl:template match="video">
	<div class="caixa">
		<div class="esquerda">
			<div class="videoSobre">
				<div class="icon">
					<xsl:value-of select="$icon_video" />		
				</div>	
				<xsl:if test="@legenda">
					<div class="videoLegenda">
						<xsl:value-of select="@legenda"/>
					</div>		
				</xsl:if>	
			</div>	
		</div>
		<div class="centro">
			<div class="video">
				<video>
					<xsl:attribute name="controls"/>
					<xsl:if test="@imagem">
						<xsl:attribute name="poster">
							<xsl:value-of select="@imagem"/>
						</xsl:attribute>						
					</xsl:if>
					<source type="video/mp4">
						<xsl:attribute name="src">
							<xsl:value-of select="text()"/>
						</xsl:attribute>
					</source>
				</video>
			</div>
		</div>
		<div class="direita">	
		</div>
	</div>
</xsl:template>

</xsl:stylesheet>

<!-- APONTAMENTOS:
- Fazer Slide? Por exemplo n'A Minha Geração.
- No incorporar admitir xml e html.
- Tabelas ordenáveis. Argumento true. Ver principes.
- incluir botões de partilhar no facebook / twitter
- em vez de colocar só a setinha para a página mãe, colocar o path completo 
- permitir nós extra na árvores, por exemplo videos nas entrevistas.
- icon: tumbrl / gif;
- escapatória se tag video não estiver disponivel em html
- prevenir incorporações circulares
- <xsl:text>
-->