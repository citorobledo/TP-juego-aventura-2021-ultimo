import wollok.game.*
import personajes.*
import nivel_llaves.*
import nivel_bloques.*
import utilidades.*
import modificadores_y_celdas.*
import indicadores.*
	
	
class Caja 
{
	var property position = utilidadesParaJuego.unaPositionNoRepetida()
	const property image = "caja.png"
	
	method accion()
	{
        if (personajeSimple.vieneDesdeArriba())
        { 
        	if (self.puedeMoverHacia(position.down(1))) { position = position.down(1)}
	
        	else {personajeSimple.rebote()}
        }
        
        else if (personajeSimple.vieneDesdeAbajo())
        { 
        	if (self.puedeMoverHacia(position.up(1))) { position = position.up(1) }
        		
        	else {personajeSimple.rebote()}
        }
        
        else if (personajeSimple.vieneDesdeLaIzquierda())
        { 
        	if (self.puedeMoverHacia(position.right(1))) { position = position.right(1) }
        		
        	else {personajeSimple.rebote()}
        }
        
        else
        {
        	if (self.puedeMoverHacia(position.left(1))) { position = position.left(1)}
        	else {personajeSimple.rebote()}
       	}
   	}
   	
   	method puedeMoverHacia(unaPosition) = game.getObjectsIn(unaPosition) == []
   	
}

class Llave 
{
	var property position = utilidadesParaJuego.unaPositionNoRepetida()
	var property image = "llave20x20.png"
	
	method accion() 
	{
		if(personajeSimple.cantLlaves() < 2)
		{
			
			personajeSimple.agregarLlave()
			utilidadesParaJuego.eliminar(self)     // reemplaza al game.removeVisual(self)
    		//game.removeVisual(self)
	    }
	    
		else if(personajeSimple.cantLlaves() < 3)
		{
			//game.removeVisual(self)
			personajeSimple.agregarLlave()
			utilidadesParaJuego.eliminar(self)		 // reemplaza al game.removeVisual(self)
	    		game.addVisual(puerta)
	    }
	    else{personajeSimple.agregarLlave() utilidadesParaJuego.eliminar(self) }
     }	
}     


object puerta
{
	const property position = game.center()
	var property image = "puerta_abierta.png"
	
	method accion() 
	{
		image ="puerta_cerrada.png"
		nivelLlaves.ganar()
	}
}


class Pollo
{
	var property position = utilidadesParaJuego.unaPositionNoRepetida()
	var property image = "pollo50x50.png"
	var property energia = 5
	
	method accion()
	{
		personajeSimple.aplicarModificadorSiExiste(self)
		personajeSimple.comerPollo(self)
	    //game.removeVisual(self)
	    utilidadesParaJuego.eliminar(self)    // reemplaza al game.removeVisual(self)
	    game.addVisual(new Pollo())
     }
}

class Cofre
{
	var property position = utilidadesParaJuego.unaPositionNoRepetida()
	var property image = "cofre35x35.png"
	var property estado = "desactivado"
	var property arriba = game.addVisual(new CeldaAdyasentesDelCofre(position = position.up(1), cofre = self))
	var property abajo = game.addVisual(new CeldaAdyasentesDelCofre(position = position.down(1), cofre = self))
	var property izquierda = game.addVisual(new CeldaAdyasentesDelCofre(position = position.left(1), cofre = self))
	var property derecha = game.addVisual(new CeldaAdyasentesDelCofre(position = position.right(1), cofre = self))
	
		
	method convertirCofreEnLlave() 
	{
		self.image("llave20x20.png")
	}
	
	method accion()
	{
		if (estado == "activado")
		{
			if(personajeSimple.cantLlaves() < 2)
			{
				personajeSimple.agregarLlave()
				utilidadesParaJuego.eliminar(self)
	   		 }
			else if (personajeSimple.cantLlaves() < 3)
			{
				personajeSimple.agregarLlave()
				utilidadesParaJuego.eliminar(self)
	    		game.addVisual(puerta)
	    	}
	    	else if(personajeSimple.cantLlaves() >= 3)
	    	{
	    		personajeSimple.agregarLlave()
	    		utilidadesParaJuego.eliminar(self)
	    	}
	    }
	    else { personajeSimple.rebote() }
     }
}


object puertaNivelCajas
{
	const property position = game.at(0,0)
	var property image = "puerta_cerrada.png"
	
	method abrirPuerta() { image = "puerta_abierta.png" }
	method cerrarPuerta() { image = "puerta_cerrada.png" }
	
	method accion()
	{
		if (nivelBloques.todasLasCajasEstanEnElDeposito() and image == "puerta_abierta.png")
		{
			self.cerrarPuerta()
			nivelBloques.terminar()
		}
	}
}
