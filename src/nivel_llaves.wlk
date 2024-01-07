import wollok.game.*
import fondo.*
import personajes.*
import elementos.*
import nivel_bloques.*
import utilidades.*
import modificadores_y_celdas.*
import indicadores.*
import sonidos.*

object nivelLlaves {
	
	
	const property listModificadores = []
	//Crear llave
	//method crearLlave() = new Llave()
	
	//Crear pollo
	//method crearPollo() = new Pollo()
	
	//Crear monstruo
	//method crearMonstruo() = new Monstruo()
	
	//Crear cofres
	//method crearCofre() = new Cofre()
	
	//Crear de manera aleatoria cofres con llave o llaves solas
	//method crearAleatorio() = [self.crearCofre(), self.crearLlave()].anyOne()
		
	method configurate() {
		utilidadesParaJuego.posicionArbitraria()
		
		// fondo - es importante que sea el primer visual que se agregue
		game.addVisual(new Fondo(image="fondoCompleto.png"))
		//game.addVisual(new CeldaSorpersa())
		//game.addVisual(new CeldaSorpersa())
		
		//indicadores
		game.addVisualIn( indicadorDeEnergia, game.at(9,15))
		indicadorDeEnergia.indicar()
		game.addVisualIn( indicadorDeLlaves, game.at(0,15))
		indicadorDeLlaves.indicar()
		
		//Llaves, cofres y pollos
		const elementos = [new Llave(),new Llave(),new Llave(), new Cofre(),new Cofre(),new Cofre(), new Pollo()]
		
		elementos.forEach{ e => game.addVisual(e)}
		
		listModificadores.addAll([new Duplicador(),new Triplicador(),new Reforzador(),new Duplicador(),new Triplicador(),new Reforzador()])
		listModificadores.forEach{ m => game.addVisual(m)}

		//Monstruos
		
		var mou = new Monstruo()
		game.addVisual(mou)
		game.onTick(550, "monstruo",{mou.accion()})

		var mou2 = new Monstruo()
		game.addVisual(mou2)
		game.onTick(800, "monstruo",{mou2.accion()})

		musica2.play()
		// personaje, es importante que sea el último visual que se agregue
		game.addVisual(personajeSimple)
		
		//Restar energia del personaje e informar cuanta energia le queda
		var sprite = [ "player2.png", "player.png", "player3.png", "player.png"]
		var sprite2 = [ "player-h2.png", "player-h.png", "player-h3.png", "player-h.png"]
		keyboard.n().onPressDo({ personajeSimple.animar(sprite, 100) })
		keyboard.m().onPressDo({ personajeSimple.desanimar(sprite) })
		keyboard.up().onPressDo({personajeSimple.up() indicadorDeEnergia.indicar() personajeSimple.animar(sprite, 40)})
		keyboard.down().onPressDo({personajeSimple.down() indicadorDeEnergia.indicar() personajeSimple.animar(sprite, 40)})
		keyboard.left().onPressDo({personajeSimple.left() indicadorDeEnergia.indicar() personajeSimple.animar(sprite2, 40)})
		keyboard.right().onPressDo({personajeSimple.right() indicadorDeEnergia.indicar() personajeSimple.animar(sprite, 40)})
	
		
		// este es para probar, no es necesario dejarlo
		//keyboard.g().onPressDo({ self.ganar() })

		// colisiones, acá sí hacen falta
		game.onCollideDo(personajeSimple, {a=>a.accion()})
	}

	method ganar()
		{
			//Limpia visuals, teclado, colisiones y acciones
			game.clear()
			//Agregar el fondo, y algún visual para que no quede tan pelado.
			game.addVisual(new Fondo(image="fondoCompleto.png"))
			game.addVisual(puerta)
		  
			//Deja pasar un tiempo indicado en milisegundos y cambia de fondo.
			game.schedule(2500, {game.clear()
			musica2.stop()
			game.addVisual(new Fondo(image="ganamos.png"))
			//Deja pasar un tiempo indicado en milisegundos y fin del juego.
			game.schedule(3000, {game.stop()})
		})
	}
	
	method perder() {
		muerte_miusic.play()
		//Limpia visuals, teclado, colisiones y acciones.
		game.clear()
		//Agregar el fondo, y algún visual para que no quede tan pelado.
		game.addVisual(new Fondo(image="fondoCompleto.png"))
		//Deja pasar un tiempo indicado en milisegundos.
		game.schedule(2500, {
			game.clear()
			//cambio de fondo.
			game.addVisual(new Fondo(image="perdimos750x750.png"))
			//Deja pasar un tiempo indicado en milisegundos.
			game.schedule(3000, {
				//Fin del juego
				game.stop()
			})
		})
	}

	
	
}
