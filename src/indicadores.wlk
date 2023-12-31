import wollok.game.*
import elementos.*
import personajes.*

object crearNumero{
	
    method imagenNumero(numero){
    	return new Visual(image= "nro" + numero + ".png")
    }
}
class Visual {
	var property image
	var property position = game.origin()
}

object indicadorDeEnergia
	{
	var property image = "energia.png"
		
		method indicar()
		{		
			game.addVisualIn(crearNumero.imagenNumero( personajeSimple.energia().div(10) ),  game.at(13,15))//decena
			game.addVisualIn(crearNumero.imagenNumero( personajeSimple.energia() % 10 ),  game.at(14,15)) //unidad
		}
		method accion(){}
	}
	
object indicadorDeLlaves{
	var property image = "llaves.png"	
	method indicar()
		{	
			game.addVisualIn(crearNumero.imagenNumero( personajeSimple.cantLlaves() ),  game.at(3,15))
		}
		method accion(){}
}