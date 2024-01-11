import fondo.*
import personajes.*
import elementos.*
import nivel_llaves.*
import utilidades.*
import wollok.game.*
import modificadores_y_celdas.*
import indicadores.*
import sonidos.*


object nivelBloques{
	const property listaCajas = []
	const property listModificadores = []
	
	method configurate(){		
		utilidadesParaJuego.posicionArbitraria()
		
		game.addVisual(new Fondo(image="fondoCompleto.png"))
		game.addVisual(puertaNivelCajas)
		
		// indicadores
		game.addVisualIn( indicadorDeEnergia, game.at(8,15))
		indicadorDeEnergia.indicar()
		game.addVisualIn( indicadorDeLlaves, game.at(0,15))
		indicadorDeLlaves.indicar()

		// elementos del juego
		5.times{x =>  listaCajas.add(new Caja()) }
		listaCajas.forEach{ c => game.addVisual(c)}
		
		listModificadores.addAll([new Duplicador(),new Triplicador(),new Reforzador(),new Duplicador(),new Triplicador(),new Reforzador()])
		listModificadores.forEach{ m => game.addVisual(m)}
		
		// enemigo
		var mou = new Monstruo(image="player-grabois.png")
		game.addVisual(mou)
		game.onTick(800, "monstruo",{mou.accion()})

		var mou2 = new Monstruo(image="player-massa.png")
		game.addVisual(mou2)
		game.onTick(550, "monstruo2",{mou2.accion()})

		const elementos = [new CeldaSorpersa(), new CeldaSorpersa(), new CeldaSorpersa(), new Pollo()]
		elementos.forEach{ e => game.addVisual(e)}
		game.addVisual(personajeSimple)

		
		// musica
		musica.play()

		//animacion personaje
		var sprite = [ "player2.png", "player.png", "player3.png", "player.png"]
		var sprite2 = [ "player-h2.png", "player-h.png", "player-h3.png", "player-h.png"]
		
		keyboard.up().onPressDo({personajeSimple.up() indicadorDeEnergia.indicar() personajeSimple.animar(sprite, 40)})
		keyboard.down().onPressDo({personajeSimple.down() indicadorDeEnergia.indicar() personajeSimple.animar(sprite, 40)})
		keyboard.left().onPressDo({personajeSimple.left() indicadorDeEnergia.indicar() personajeSimple.animar(sprite2, 40)})
		keyboard.right().onPressDo({personajeSimple.right() indicadorDeEnergia.indicar() personajeSimple.animar(sprite, 40)})
	
		
		game.whenCollideDo(personajeSimple, { a => a.accion()} )
		game.whenCollideDo(mou, { a => a.accion()} )
		game.whenCollideDo(mou2, { a => a.accion()} )
		
		

		// puertaNivelCajas.
		game.onTick(4500, "puerta",{self.abrirPuertaSiEsUltimaCaja()})
		
		keyboard.e().onPressDo({ self.terminar() })	
		}
	
	method abrirPuertaSiEsUltimaCaja(){
		if (self.todasLasCajasEstanEnElDeposito()) { 
			puertaNivelCajas.abrirPuerta() 
			door_open.play()
			}
		}
	
	method todasLasCajasEstanEnElDeposito(){
		zonaDeposito.posicionDepositoAncho()
		return listaCajas.all{ c => zonaDeposito.posicionesDeposito().contains(c.position())}
		}
	
	method terminar(){
		tiemblen.play()
		game.clear()
		game.addVisual(new Fondo(image="fondoCompleto.png"))
		door_close.play()
		game.addVisual(puertaNivelCajas)
		//game.addVisual(personajeSimple)
		game.schedule(2500, 
			{
				game.clear()
				game.addVisual(new Fondo(image="finNivel1_milei.png", position=game.at(0,3)))
				game.schedule(3000, 
					{
						game.clear()
						nivelLlaves.configurate()
						tiemblen.stop()
						musica.stop()
					})
			})
		}
}

