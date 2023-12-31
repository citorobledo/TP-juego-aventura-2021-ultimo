import wollok.game.*
import fondo.*
import personajes.*
import elementos.*
import nivel_bloques.*
import utilidades.*
import modificadores_y_celdas.*
import indicadores.*

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
		game.addVisual(new CeldaSorpersa())
		game.addVisual(new CeldaSorpersa())
		
		//indicadores
		game.addVisualIn( indicadorDeEnergia, game.at(9,15))
		indicadorDeEnergia.indicar()
		game.addVisualIn( indicadorDeLlaves, game.at(0,15))
		indicadorDeLlaves.indicar()
		
		//Llaves, cofres y pollos
		const c1 = new Cofre()
		const c2 = new Cofre()
		const c3 = new Cofre()
		
		const l1 = new Llave()
		const l2 = new Llave()
		const l3 = new Llave()
		
		const p1 = new Pollo()
		
		const m1 = new Duplicador()
		const m2 = new Reforzador()
		const m3 = new Triplicador()	
		const m4 = new Duplicador()
		const m5 = new Reforzador()
		const m6 = new Triplicador()
		
		game.addVisual(c1)
		game.addVisual(c2)
		game.addVisual(c3)
		game.addVisual(l1)
		game.addVisual(l2)
		game.addVisual(l3)
		game.addVisual(p1)
		
		listModificadores.addAll([m1, m2, m3, m4, m5, m6])
		listModificadores.forEach{ m => game.addVisual(m)}

		//Monstruos
		//game.onTick(2000, "movimiento1", { game.addVisual(self.crearMonstruo()) } )
		//game.onTick(2000, "movimiento2", { game.addVisual(self.crearMonstruo()) } )
		//game.onTick(2000, "movimiento3", { game.addVisual(self.crearMonstruo()) } )
		
		// personaje, es importante que sea el último visual que se agregue
		game.addVisual(personajeSimple)
		
		//Restar energia del personaje e informar cuanta energia le queda
		keyboard.up().onPressDo({personajeSimple.up() indicadorDeEnergia.indicar()})
		keyboard.down().onPressDo({personajeSimple.down() indicadorDeEnergia.indicar() })
		keyboard.left().onPressDo({personajeSimple.left() indicadorDeEnergia.indicar()})
		keyboard.right().onPressDo({personajeSimple.right()  indicadorDeEnergia.indicar()})
		
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
			game.addVisual(new Fondo(image="ganamos.png"))
			//Deja pasar un tiempo indicado en milisegundos y fin del juego.
			game.schedule(3000, {game.stop()})
		})
	}
	
	method perder() {
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
