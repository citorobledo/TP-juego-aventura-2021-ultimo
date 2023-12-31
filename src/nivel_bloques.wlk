import fondo.*
import personajes.*
import elementos.*
import nivel_llaves.*
import utilidades.*
import wollok.game.*
import modificadores_y_celdas.*
import indicadores.*


object nivelBloques
{
	const property listaCajas = []
	const property listModificadores = []
	
	method configurate()
	{
		utilidadesParaJuego.posicionArbitraria()
		
		game.addVisual(new Fondo(image="fondoCompleto.png"))
		game.addVisual(puertaNivelCajas)
		
		// indicadores
		game.addVisualIn( indicadorDeEnergia, game.at(9,15))
		indicadorDeEnergia.indicar()
		game.addVisualIn( indicadorDeLlaves, game.at(0,15))
		indicadorDeLlaves.indicar()
		
		//game.addVisual(indicadorDeEnergia)
		
		const c1 = new Caja()
		const c2 = new Caja()
		const c3 = new Caja()
		const c4 = new Caja()
		const c5 = new Caja()
		
		listaCajas.addAll([c1, c2, c3, c4, c5])
		listaCajas.forEach{ c => game.addVisual(c)}
		
		const m1 = new Duplicador()
		const m2 = new Reforzador()
		const m3 = new Triplicador()	
		const m4 = new Duplicador()
		const m5 = new Reforzador()
		const m6 = new Triplicador()
		
		listModificadores.addAll([m1, m2, m3, m4, m5, m6])
		listModificadores.forEach{ m => game.addVisual(m)}
		

		game.addVisual(new CeldaSorpersa())
		game.addVisual(new CeldaSorpersa())
		game.addVisual(new Pollo())
		game.addVisual(personajeSimple)
		
		keyboard.up().onPressDo({personajeSimple.up()  indicadorDeEnergia.indicar() })
		keyboard.down().onPressDo({personajeSimple.down() indicadorDeEnergia.indicar() })
		keyboard.left().onPressDo({personajeSimple.left() indicadorDeEnergia.indicar() })
		keyboard.right().onPressDo({personajeSimple.right() indicadorDeEnergia.indicar() })
	
		
		game.whenCollideDo(personajeSimple, { a => a.accion()} )
		
		keyboard.n().onPressDo({ self.abrirPuertaSiEsUltimaCaja() })
		
		keyboard.e().onPressDo({ self.terminar() })	
	}
	
	method abrirPuertaSiEsUltimaCaja()
	{
		if (self.todasLasCajasEstanEnElDeposito()) { puertaNivelCajas.abrirPuerta() }
		else {game.say(personajeSimple, "NO ESTAN TODAS LAS CAJAS EN EL DEPÓSITO")}
	}
	
	method todasLasCajasEstanEnElDeposito()
	{
		zonaDeposito.posicionDepositoAncho()
		return listaCajas.all{ c => zonaDeposito.posicionesDeposito().contains(c.position())}
	}
	
	method terminar() 
	{
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

