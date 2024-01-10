import wollok.game.*
import personajes.*
import nivel_llaves.*
import nivel_bloques.*
import utilidades.*
import modificadores_y_celdas.*
import indicadores.*
import sonidos.*
	
class Caja {
	var property position = utilidadesParaJuego.unaPositionNoRepetida()
	const property image = "caja_voto.png"
	
	method accion(){
        if (personajeSimple.vieneDesdeArriba())
        { 
        	if (self.puedeMoverHacia(position.down(1))) { 
						position = position.down(1)
						arrastra.play()
						}
	
        	else {personajeSimple.rebote()}
        }
        
        else if (personajeSimple.vieneDesdeAbajo())
        { 
        	if (self.puedeMoverHacia(position.up(1))) { position = position.up(1) arrastra.play()}
        		
        	else {personajeSimple.rebote()}
        }
        
        else if (personajeSimple.vieneDesdeLaIzquierda())
        { 
        	if (self.puedeMoverHacia(position.right(1))) { position = position.right(1) arrastra.play()}
        		
        	else {personajeSimple.rebote()}
        }
        
        else
        {
        	if (self.puedeMoverHacia(position.left(1))) { position = position.left(1) arrastra.play()}
        	else {personajeSimple.rebote()}
       	}
   	}
   	
   	method puedeMoverHacia(unaPosition) = game.getObjectsIn(unaPosition) == []
   	
	}

class Llave {
	var property position = utilidadesParaJuego.unaPositionNoRepetida()
	var property image = "llave20x20.png"
	var property esEnemigo = false

	method rebote() {
		//personajeSimple.rebote()
	}
	method accion(){
		if(game.getObjectsIn(self.position()).size() > 1 && 
			!game.getObjectsIn(self.position()).last().esEnemigo()){
			if(personajeSimple.cantLlaves() < 2){
				personajeSimple.agregarLlave()
				game.removeVisual(self)     // reemplaza al game.removeVisual(self)
	  	  }

			else if(personajeSimple.cantLlaves() < 3){
				door_open.play()
				personajeSimple.agregarLlave()
				game.removeVisual(self)		 // reemplaza al game.removeVisual(self)
	  	  game.addVisual(puerta)
	  		}
	  	else{personajeSimple.agregarLlave() game.removeVisual(self) 
				}
			}
		else { game.getObjectsIn(self.position()).last().rebote() }
  	}	
	}     

object puerta{
	const property position = game.center()
	var property image = "puerta_abierta.png"
	
	method accion(){
		door_close.play()
		image ="puerta_cerrada.png"
		nivelLlaves.ganar()
		}
	}

class Pollo{
	var property position = utilidadesParaJuego.unaPositionNoRepetida()
	var property image = "pollo50x50.png"
	var property energia = 5
	
	method accion(){
		personajeSimple.aplicarModificadorSiExiste(self)
		personajeSimple.comerPollo(self)
	  //game.removeVisual(self)
	  utilidadesParaJuego.eliminar(self)    // reemplaza al game.removeVisual(self)
		indicadorDeEnergia.indicar()
	  game.addVisual(new Pollo())
  	}
	}

class Cofre{
	var property position = utilidadesParaJuego.unaPositionNoRepetida()
	var property image = "cofre35x35.png"
	var property estado = "desactivado"
	var property arriba = game.addVisual(new CeldaAdyasentesDelCofre(position = position.up(1), cofre = self))
	var property abajo = game.addVisual(new CeldaAdyasentesDelCofre(position = position.down(1), cofre = self))
	var property izquierda = game.addVisual(new CeldaAdyasentesDelCofre(position = position.left(1), cofre = self))
	var property derecha = game.addVisual(new CeldaAdyasentesDelCofre(position = position.right(1), cofre = self))
	var property esEnemigo = false	
	
	method convertirCofreEnLlave() { 
			game.addVisual(new Llave(position = position))
			holy.play()
			game.removeVisual(self)		
		}

	method accion(){
		 game.getObjectsIn(self.position()).first().rebote()
		 game.getObjectsIn(self.position()).last().rebote()
		}

	method rebote() {
		//personajeSimple.rebote()
		}
	}

object puertaNivelCajas{
	const property position = game.at(0,0)
	var property image = "puerta_cerrada.png"
	
	method abrirPuerta() { image = "puerta_abierta.png" }
	method cerrarPuerta() { image = "puerta_cerrada.png" }
	method accion(){
		if (nivelBloques.todasLasCajasEstanEnElDeposito() and image == "puerta_abierta.png"){
			self.cerrarPuerta()
			nivelBloques.terminar()
			}
		}
	method rebote() {}
	}
