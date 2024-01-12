import personajes.*
import nivel_llaves.*
import nivel_bloques.*
import utilidades.*
import wollok.game.*
import elementos.*
import indicadores.*
import sonidos.*

class ModificadoresPollo{
	var property position = utilidadesParaJuego.unaPositionNoRepetida()
	
	method desaparecerModificador() {utilidadesParaJuego.eliminar(self)}
	method accion(){
		self.asignarModificador()
		self.desaparecerModificador()
		prick.play()
	}
	
	method modificarEnergiaDelPollo(unPollo)
	
	method asignarModificador() {personajeSimple.modificador(self)}	
}

class Duplicador inherits ModificadoresPollo{
	var property image = "duplicador.png"
	override method modificarEnergiaDelPollo(unPollo) {unPollo.energia(unPollo.energia() *2) }

	override method accion(){
		self.asignarModificador()
		self.desaparecerModificador()
		motosierra.play() 
	}
}

class Triplicador inherits ModificadoresPollo{
	var property image = "triplicador.png"
	
	override method modificarEnergiaDelPollo(unPollo){
		if (personajeSimple.energia().even()) {unPollo.energia(unPollo.energia() *3)}
			
		else {unPollo.energia(unPollo.energia() *0)}
	}
}	

class Reforzador inherits ModificadoresPollo{
	var property image = "reforzador.png"
	override method modificarEnergiaDelPollo(unPollo){
		unPollo.energia(unPollo.energia() *2)
		if (personajeSimple.energia() < 10) {personajeSimple.energia(personajeSimple.energia() +20)}	 
	}
}

class CeldaSorpersa{
	var property image = "portal_apagado.png"
	var property position = utilidadesParaJuego.unaPositionNoRepetida()
	var property estado = "activo"
	const property esEnemigo = false
	
	method puedeMoverHacia(unaPosition) = game.getObjectsIn(unaPosition) == []

	method accion(){	

		if(game.getObjectsIn(self.position()).size() > 1 && 
			!game.getObjectsIn(self.position()).first().esEnemigo()){
			if(personajeSimple.vieneDesdeArriba() || 
				personajeSimple.vieneDesdeAbajo() || 
				personajeSimple.vieneDesdeLaIzquierda() || 
				personajeSimple.vieneDesdeLaDerecha()){ 
      	 	if (estado == "activo"){
						personajeSimple.rebote()	
						bit_noise.play()
						estado = "desactivo"
						image = "portal_activado.png"
						personajeSimple.energia(personajeSimple.energia() + (20.randomUpTo(-9).roundUp()))
						indicadorDeEnergia.indicar()
						}
					else{
						game.onTick( 50, "teleport", {self.teleport_sprite()} )
						personajeSimple.position(utilidadesParaJuego.unaPositionNoRepetida())
						teleport.play()
					}
				}
			}
		else if(game.getObjectsIn(self.position()).size() > 1 && estado == "desactivo" &&
						game.getObjectsIn(self.position()).first().esEnemigo()){
							game.getObjectsIn(self.position()).first().position(utilidadesParaJuego.unaPositionNoRepetida())
							game.onTick( 50, "teleport", {self.teleport_sprite()} )
							teleport.play()
				}
			}
		
		method teleport_sprite(){
			if(image == "portal_activado.png"){
				image = "portal_activado2.png"
				}
			else if (image == "portal_activado2.png"){
				image = "portal_activado3.png"
				}
			else if (image == "portal_activado3.png"){
				image = "portal_activado4.png"
				}
			else{
				image = "portal_activado.png"
				game.removeTickEvent("teleport")
				}
		}
}

class CeldaAdyasentesDelCofre{
	var property image = "celdaAzul.jpg"
	var property position
	var property cofre
	
	method accion(){
		keyboard.a().onPressDo( { cofre.convertirCofreEnLlave() personajeSimple.restaEnergiaPatada(2) })
		
	}
}

