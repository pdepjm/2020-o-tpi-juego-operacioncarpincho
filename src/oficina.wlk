import wollok.game.*

class Consumible {
	//var energiaAportada
	// Todos los consumibles duran X cantidad de tiempo, ej game.onTick(5000, ...) serian 5 segundos
	// o podrian ser X turnos 
	//method potenciar(jugador) {
		//jugador.aumentarEnergia(cantidad)
	//} 
	
}

object cafeConLeche inherits Consumible {
	const energiaAportada = 25
	method image() = "Cafe.png"
	// Ponele que este te reponga la energia
	method position() = game.at(7,7)
	method teEncontro() = true
	method potenciar(jugador) {
		jugador.aumentarEnergia(energiaAportada)
		game.say(jugador, "Aumento la energia en " + energiaAportada)
	}
}

object barritaEnergetica inherits Consumible {
	
	//method image() =
	// Este te hace ir 2 cuadraditos o dos pasos por cada movimiento
	// o podria ser que te de energia infinita por X turnos
}

object llamadaAfip inherits Consumible {
	
	//method image() =
	// Este hace que el jefe se quede bloqueado en su posicion por X turnos/segundos
}



object planta {
	
	var property position = game.at(9,3)
	
	method image() = "pepita.png"
	
	method teEncontro() = true
	// Hacer que el jugador se esconda en la planta por X turnos, y el jefe se aleja a la direccion contraria
	// Cuando ingresa a la planta, se cambia la imagen y el jefe no puede colisionar con el, averiguar como seria
	
	
}



object impresora {
	var property position = game.at(3,5)
	
	method image() = "Impresora.png"
	
	method teEncontro() = true
	
	method esAtravesable() = false
	// 3 impresoras de diferente tipo, no se si conviene que haya una sola clase, e instanciarlas como diferentes
	// o hacer 3 objetos
}


object companieri {
	var property position = game.at(13,5)
	
	method image() = "Companieri.png"
	
	method teEncontro() = true
	// El que te tira las Quest para ir a entregarle una tarea especifica
}


object puerta {
	var property position = game.at(8,9)
	
	method image() = "OtraPuerta.png"
	
	method teEncontro() = true
	
	// cuando colisione, que haya un if donde verifique si tiene las 3 tareas completadas, si no es asi, no sucede nada
	// recien puede terminar el juego cuando tenga las tareas terminadas
}