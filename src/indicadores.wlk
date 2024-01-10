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
			game.addVisualIn(crearNumero.imagenNumero( personajeSimple.energia().div(100) ),  game.at(12,15))//centena		
			game.addVisualIn(crearNumero.imagenNumero( personajeSimple.energia().div(10) % 10),  game.at(13,15))//decena
			game.addVisualIn(crearNumero.imagenNumero( personajeSimple.energia() % 10 ),  game.at(14,15)) //unidad
		}
		method accion(){}
	}
	
object indicadorDeLlaves{
	var property image = "llaves.png"	
	method indicar(){	
			game.addVisualIn(crearNumero.imagenNumero( personajeSimple.cantLlaves() ),  game.at(3,15))
		}

	method accion(){}
  }

object indicadorEnter{
	var property image = "pres_enter.png"	
	method indicar(){	
			if(image == "pres_enter.png"){
				image = "pres_enter2.png"
				}
			else if (image == "pres_enter2.png"){
				image = "pres_enter3.png"
				}
			else{image = "pres_enter.png"}
		}	
	}