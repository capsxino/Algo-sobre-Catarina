function inicializaArvores() {
		arvore = document.getElementsByClassName("arvore");
		for (n=0;n<arvore.length;n++) {
			arvore[n].iPagina=0;
			mostraMais(arvore[n]);
		}
}

function mostraMais(arvore) {
	var pagina = arvore.getElementsByClassName("pagina");
	var d=0;
	for (var p=arvore.iPagina;p<arvore.iPagina+11;p++) {
		if (p==pagina.length) {
			arvore.getElementsByClassName("mostraMais")[0].style.display="none";
			arvore.style.maxWidth=Math.floor(Math.sqrt(p+(p!=pagina.length-1?1:0)))*210+"px";
			break;	
		}
		pagina[p].style.backgroundImage="url('"+pagina[p].dataset.fundo+"')";
		/*mostraComAtraso(pagina[p],200*d++);*/
		pagina[p].style.display="block";
	}
	arvore.iPagina=p;
}

function mostraComAtraso(e,t) {
	setTimeout(function () {e.style.display="block"},t);
}

function inicializaCabecalhos() {
	cabecalhos = document.getElementsByClassName("cabecalho");
	for (c=0;c<cabecalhos.length;c++) {
		cabecalhos[c].style.height = window.innerHeight + "px";
	}
}

function tornaVisivel() {
	document.body.style.visibility="visible";
}