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
		const elementos = [new Llave(), new Cofre(), new Llave(), new Llave()]
		
		elementos.forEach{ e => game.addVisual(e)}
		
		listModificadores.addAll([new Duplicador(),new Triplicador(),new Reforzador(),new Duplicador(),new Triplicador(),new Reforzador()])
		listModificadores.forEach{ m => game.addVisual(m)}

		//enemigos
		
		var mou = new Monstruo(image="player-grabois.png")
		game.addVisual(mou)
		game.onTick(800, "monstruo",{mou.accion()})

		var mou2 = new Monstruo(image="player-massa.png")
		game.addVisual(mou2)
		game.onTick(550, "monstruo2",{mou2.accion()})

		game.whenCollideDo(mou, { a => a.accion()} )
		game.whenCollideDo(mou2, { a => a.accion()} )

		musica2.play()
		// personaje, es importante que sea el último visual que se agregue
		game.addVisual(personajeSimple)
		
		//Restar energia del personaje e informar cuanta energia le queda
		var sprite = [ "player2.png", "player.png", "player3.png", "player.png"]
		var sprite2 = [ "player-h2.png", "player-h.png", "player-h3.png", "player-h.png"]
		
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
			game.addVisual(new Fondo(image="ganamos.png", position=game.at(0,3)))
			//Deja pasar un tiempo indicado en milisegundos y fin del juego.
			game.schedule(4000, {game.stop()})
		})
	}
	
	method perder() {
		musica.stop()
		muerte_miusic.play()
		//Limpia visuals, teclado, colisiones y acciones.
		game.clear()
		//Agregar el fondo, y algún visual para que no quede tan pelado.
		game.addVisual(new Fondo(image="fondoCompleto.png"))
		//Deja pasar un tiempo indicado en milisegundos.
		game.schedule(1500, {
			game.clear()
			//cambio de fondo.
			game.addVisualIn(new Fondo(image="perdiste.png"),  game.at(1,0))
			//Deja pasar un tiempo indicado en milisegundos.
			game.schedule(3000, {
				game.addVisualIn(indicadorEnter, game.at(5,3))
				game.onTick(150, "enter", {indicadorEnter.indicar()})
				
				
				keyboard.enter().onPressDo({
					game.stop()
					})
			})
			
		})
	}

	
	
}
