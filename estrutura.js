function inicializaEstrutura() {
	no=document.getElementsByClassName("no fechado");
	fechaAbre(no[0].id);
}

function abreTudo() {
	no=document.getElementsByClassName("no fechado");
	if(no.length>0) {
		fechaAbre(no[0].id);
		abreTudo();
	}
}

function fechaTudo() {
	no=document.getElementsByClassName("no aberto");
	if(no.length>0) {
		fechaAbre(no[0].id);
		fechaTudo();
	}
}

function fechaAbre(noId) {
	switch(document.getElementById(noId).className) {
		case "no aberto":
			document.getElementById(noId).className="no fechado";
			document.getElementById("mostra"+noId).className="mostra mais";
			document.getElementById("filhos"+noId).style.display="none";
			break;
		case "no fechado":
			document.getElementById(noId).className="no aberto";
			document.getElementById("mostra"+noId).className="mostra menos";
			document.getElementById("filhos"+noId).style.display="block";
			break;
		default:
			return;
	}
}