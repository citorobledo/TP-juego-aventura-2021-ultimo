import wollok.game.*
import nivel_llaves.*
import utilidades.*
import indicadores.*
import sonidos.*

object personajeSimple {
	var property position = game.at(0,0)
	var property image = "player.png"	
	var property oldPosition = null
	var property cantLlaves = 0
	var property energia = 150
	var property modificador = null
	var index = 0
	
	
	method agregarLlave(){
		cantLlaves +=1
		indicadorDeLlaves.indicar()
		agarrar_llave.play()
		}

  method up(){
		oldPosition = position
    if (self.position().y() != game.height() -2 ){
				paso.play()
        self.position(self.position().up(1))
        self.restarEnergia()
			}
		}
  method down(){
  	oldPosition = position
      if (self.position().y() != 0 ){  

					paso.play()	
          self.position(self.position().down(1)) 
          self.restarEnergia()
        }
  	}
  method left(){
  	oldPosition = position
    if (self.position().x() != 0 ){   
				paso.play()	
        self.position(self.position().left(1))
        self.restarEnergia()
      }
  	}
  method right(){
  	oldPosition = position
    if (self.position().x() != game.width() -1 ){
				paso.play()
        self.position(self.position().right(1))
        self.restarEnergia()
      }
  	}
    
  method restaEnergiaPatada(energ) {(energia -= energ) indicadorDeEnergia.indicar()}
  method vieneDesdeArriba() = oldPosition == position.up(1)
	method vieneDesdeAbajo() = oldPosition == position.down(1)
	method vieneDesdeLaIzquierda() = oldPosition == position.left(1)
	method vieneDesdeLaDerecha() = oldPosition == position.right(1)
	method restarEnergia() { 
		if (energia > 0){
			energia = energia - 1}
		else{self.perder()}
		}
				
	method perder() { nivelLlaves.perder() }	
	method aplicarModificadorSiExiste(unPollo){
		if (not (modificador == null)){
			modificador.modificarEnergiaDelPollo(unPollo)
		}
		}
	
	method comerPollo(unPollo){
		agarrar.play()
		comer.play()
		energia = energia + unPollo.energia()
		}
	
	method rebote(){
		if (self.vieneDesdeArriba()) { 
			self.up()
			}
		else if (self.vieneDesdeAbajo()) { 
			self.down()
			}
    else if (self.vieneDesdeLaIzquierda()) { 
			self.left()
			}
		else {self.right()}
		dmg.play()
		}

	method animar(listaDeImagenes, velocidad){
			game.onTick(velocidad,"animar", {self.setSigImagen(listaDeImagenes)})//listaDeImagenes es una lista de imagenes del personaje
		}
	method desanimar(){
			game.removeTickEvent("animar")
		}
	method setSigImagen(listaDeImagenes){
		if (index < listaDeImagenes.size()){
			image = listaDeImagenes.get(index)
			index += 1
		} else {
			index = 0
			game.removeTickEvent("animar")
			}
		}	


	}
	

class Monstruo {
	var property position = utilidadesParaJuego.unaPositionNoRepetida()
	const property image = "monstruo35x35.png"
	//const property ttl = game.schedule(2010, { utilidadesParaJuego.eliminar(self) } )
		
	method movimiento() {self.position(utilidadesParaJuego.unaPositionNoRepetida())}
	
	method accion(){
		var ubicacionPersonaje = personajeSimple.position()
		self.mover(ubicacionPersonaje)
		}

	method mover(ubicacionPersonaje){
		if (self.position().x() < ubicacionPersonaje.x()){
			self.position(self.position().right(1))
		}
		else if (self.position().x() > ubicacionPersonaje.x()){
			self.position(self.position().left(1))
		}
		else if (self.position().y() < ubicacionPersonaje.y()){
			self.position(self.position().up(1))
		}
		else if (self.position().y() > ubicacionPersonaje.y()){
			self.position(self.position().down(1))
		}
	}
	method desaparecer(){utilidadesParaJuego.eliminar(self)}
}