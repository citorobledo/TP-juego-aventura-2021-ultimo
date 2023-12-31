import wollok.game.*

object utilidadesParaJuego 
{
	const property posicionesArbitrarias = #{}
	
	const ancho1 = new Range(start = 1 , end = 13)
	
	const largo1 = new Range(start = 1 , end = 4)
	
	const ancho2 = new Range(start = 1 , end = 13)
	const largo2 = new Range(start = 10 , end = 13)
	
	const ancho3 = new Range(start = 1 , end = 6)
	const largo3 = new Range(start = 5 , end = 9)
	
	const ancho4 = [13]
	const largo4 = new Range(start = 5 , end = 9)
	
	method posicionAleatoriaAncho(unAncho, unlargo) {unAncho.forEach{ n => self.posicionAleatoriaLargo(unlargo, n)}}
	
	method posicionAleatoriaLargo(unlargo, num) {unlargo.forEach{ n => posicionesArbitrarias.add(new Position(x = n, y = num))}}
	
	method posicionArbitraria()
	{
		self.posicionAleatoriaAncho(ancho1, largo1)
		self.posicionAleatoriaAncho(ancho2, largo2)
		self.posicionAleatoriaAncho(ancho3, largo3)
		self.posicionAleatoriaAncho(ancho4, largo4)
	}
	
	method unaPositionNoRepetida()
	{
		posicionesArbitrarias.remove(posicionesArbitrarias.anyOne())
		
		return posicionesArbitrarias.anyOne()
	}
	
	method eliminar(unObjeto)
	{
		posicionesArbitrarias.add(unObjeto.position())
		game.removeVisual(unObjeto)
	}
}

object zonaDeposito
{
	const ancho = new Range(start = 7 , end = 12)
	const largo = new Range(start = 5 , end = 9)
	const property posicionesDeposito = []
	
	method posicionDepositoAncho() {ancho.forEach{ n => self.posicionDepositoLargo(n)}}
	
	method posicionDepositoLargo(num) {largo.forEach{ n => posicionesDeposito.add(new Position(x = n, y = num))}}
}