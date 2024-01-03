import fondo.*
import personajes.*
import elementos.*
import nivel_llaves.*
import utilidades.*
import wollok.game.*
import modificadores_y_celdas.*
import indicadores.*
import sonidos.*


object nivelBloques
{
	const property listaCajas = []
	const property listModificadores = []
	
	method configurate(){
		utilidadesParaJuego.posicionArbitraria()
		
		game.addVisual(new Fondo(image="fondoCompleto.png"))
		game.addVisual(puertaNivelCajas)
		
		// indicadores
		game.addVisualIn( indicadorDeEnergia, game.at(9,15))
		indicadorDeEnergia.indicar()
		game.addVisualIn( indicadorDeLlaves, game.at(0,15))
		indicadorDeLlaves.indicar()

		// elementos del juego
		5.times{x =>  listaCajas.add(new Caja()) }
		listaCajas.forEach{ c => game.addVisual(c)}
		
		listModificadores.addAll([new Duplicador(),new Triplicador(),new Reforzador(),new Duplicador(),new Triplicador(),new Reforzador()])
		listModificadores.forEach{ m => game.addVisual(m)}
		
		const elementos = [new CeldaSorpersa(), new CeldaSorpersa(), new CeldaSorpersa(), new Pollo()]
		elementos.forEach{ e => game.addVisual(e)}
		game.addVisual(personajeSimple)

		// musica
		const musica = game.sound("temardo.mp3")
		musica.shouldLoop(true)
		musica.volume(0.1)
		game.schedule(100, { musica.play() })
		
		keyboard.up().onPressDo({personajeSimple.up()  indicadorDeEnergia.indicar() })
		keyboard.down().onPressDo({personajeSimple.down() indicadorDeEnergia.indicar() })
		keyboard.left().onPressDo({personajeSimple.left() indicadorDeEnergia.indicar() })
		keyboard.right().onPressDo({personajeSimple.right() indicadorDeEnergia.indicar() })
	
		
		game.whenCollideDo(personajeSimple, { a => a.accion()} )
		
		//keyboard.n().onPressDo({ self.abrirPuertaSiEsUltimaCaja() })
		// puertaNivelCajas.
		game.onTick(5000, "puerta",{self.abrirPuertaSiEsUltimaCaja()})
		
		keyboard.e().onPressDo({ self.terminar() })	
	}
	
	method abrirPuertaSiEsUltimaCaja()
	{
		if (self.todasLasCajasEstanEnElDeposito()) { 
			puertaNivelCajas.abrirPuerta() 
			door_open.play()
			}
	}
	
	method todasLasCajasEstanEnElDeposito()
	{
		zonaDeposito.posicionDepositoAncho()
		return listaCajas.all{ c => zonaDeposito.posicionesDeposito().contains(c.position())}
	}
	
	method terminar() 
	{
		pasaste_nivel.play()
		game.clear()
		game.addVisual(new Fondo(image="fondoCompleto.png"))
		game.addVisual(puertaNivelCajas)
		//game.addVisual(personajeSimple)
		game.schedule(2500, 
			{
				game.clear()
				game.addVisual(new Fondo(image="finNivel1.png"))
				game.schedule(3000, 
					{
						game.clear()
						nivelLlaves.configurate()
					})
			})
	}
}

