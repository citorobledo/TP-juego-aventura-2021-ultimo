import personajes.*
import nivel_llaves.*
import nivel_bloques.*
import utilidades.*
import wollok.game.*
import elementos.*

class ModificadoresPollo
{
	var property position = utilidadesParaJuego.unaPositionNoRepetida()
	
	method desaparecerModificador() {utilidadesParaJuego.eliminar(self)}
	method accion()
	{
		self.asignarModificador()
		self.desaparecerModificador()
	}
	
	method modificarEnergiaDelPollo(unPollo)
	
	method asignarModificador() {personajeSimple.modificador(self)}
	
	
}

class Duplicador inherits ModificadoresPollo
{
	var property image = "duplicador.png"
	
	override method modificarEnergiaDelPollo(unPollo) {unPollo.energia(unPollo.energia() *2)}
}

class Reforzador inherits ModificadoresPollo
{
	var property image = "reforzador.png"
	
	override method modificarEnergiaDelPollo(unPollo)
	{
		unPollo.energia(unPollo.energia() *2)
		if (personajeSimple.energia() < 10) {personajeSimple.energia(personajeSimple.energia() +20)}	 
	}
}


class Triplicador inherits ModificadoresPollo
{
	var property image = "triplicador.png"
	
	override method modificarEnergiaDelPollo(unPollo)
	{
		if (personajeSimple.energia().even()) {unPollo.energia(unPollo.energia() *3)}
			
		else {unPollo.energia(unPollo.energia() *0)}
	}
}
	
	
class CeldaSorpersa
{
	var property image = "celda_sorpresa.png"
	var property position = utilidadesParaJuego.unaPositionNoRepetida()
	var property estado = "desactivado"
	var property arriba = game.addVisual(new CeldaAdyasentesDeLaSorpresa(position = position.up(1), sorpresa = self))
	var property abajo = game.addVisual(new CeldaAdyasentesDeLaSorpresa(position = position.down(1), sorpresa = self))
	var property izquierda = game.addVisual(new CeldaAdyasentesDeLaSorpresa(position = position.left(1), sorpresa = self))
	var property derecha = game.addVisual(new CeldaAdyasentesDeLaSorpresa(position = position.right(1), sorpresa = self))
	
	method accionSorpresa()
	{
		const sorpresaAleatoria = sorpresas.listaDeSorpresas().anyOne()
		sorpresaAleatoria.ejecutar()
	}
	
	method accion()
	{
		if (estado == "activado")
		{	
			estado = "desactivado"
			image = "celdaByN.png"
			self.accionSorpresa()
		}
		
		else {personajeSimple.rebote()}
	}
	
	
}


class CeldaAdyasentesDeLaSorpresa
{
	var property image = "celdaAzul.jpg"
	var property position
	var property sorpresa
	
	
	method accion()
	{
		if (sorpresa.image() == "celda_sorpresa.png")
		{
			sorpresa.estado("activado") 
			sorpresa.accion()
		}

	}

}


object sorpresas
{
	const property listaDeSorpresas = [quitaEnergia, agregaEnergia, teletransportar]
}

object quitaEnergia
{
	method ejecutar()
	{
		personajeSimple.energia(personajeSimple.energia() - 15)
	}
}

object agregaEnergia
{
	method ejecutar()
	{
		personajeSimple.energia(personajeSimple.energia() + 30)
	}
}

object teletransportar
{
	method ejecutar()
	{
		personajeSimple.position(utilidadesParaJuego.unaPositionNoRepetida())
	}
}


class CeldaAdyasentesDelCofre
{
	var property image = "celdaAzul.jpg"
	var property position
	var property cofre
	
	
	method accion()
	{
		keyboard.p().onPressDo( { cofre.estado("activado") cofre.convertirCofreEnLlave() personajeSimple.restaEnergiaPatada() })
	}

}

