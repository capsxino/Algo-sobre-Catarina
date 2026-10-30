function inicializaMenu() {
	botoes=document.getElementsByClassName("menuLink");
	for (n=0;n<botoes.length;n++) {
		if (document.URL == botoes[n].href) {
			botoes[n].style.display="none";	
		}
	}
}

function fixaMenu() {
	var almofada=document.createElement("DIV");
	almofada.id="almofada";
	var menu=document.getElementById("menu");
	almofada.style.height=menu.offsetHeight+"px";
	menu.parentNode.insertBefore(almofada,menu);
	var topo=document.getElementsByClassName("cabecalho")[0];
	if (topo) {
		menu.style.top=topo.offsetHeight-window.pageYOffset+"px";
		window.addEventListener("scroll",rola);
		window.addEventListener("resize",rola);
		rola();
	}
	else {
		menu.style.top=0;
	}	
	menu.style.position="fixed";
}

function rola() {		
	var d1=document.getElementsByClassName("cabecalho")[0].offsetHeight-window.pageYOffset;
	if (d1>0) {
		document.getElementById("menu").style.top=d1+"px";
	}
	else {
		document.getElementById("menu").style.top=0+"px";
	}
}