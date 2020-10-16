import wollok.game.*
import jugador.*
import tareas.*

class Consumible {
	var property position
	var energiaAportada

	method serConsumido() {
		jugador.aumentarEnergia(energiaAportada)
		game.say(jugador, "Aumento la energia en " + energiaAportada)
		game.removeVisual(self)
	} 
	method teEncontro() = true

	method esAtravesable() = true
}


object cafeConLeche inherits Consumible (energiaAportada=20, position = game.at(7,7)) {
	 method image() = "Cafe.png"
}

object chocolate inherits Consumible (energiaAportada=35, position = game.at(13,8)){
	method image() = "Chocolate.png"
}

object hamburguesa inherits Consumible (energiaAportada=50, position = game.at(11,2)) {
	 method image() = "Hamburguesa.png"
}



object planta {
	var property position = game.at(9,3)
	
	method image() = "Planta.png"
	
	method teEncontro() = position == jugador.position()
	
	method serConsumido() {
		jugador.error("Eto no eh comida papi")
	}
	
	method potenciar(){
	}
	
	method esAtravesable() = true
}


class Impresora {
	var property position
	var tarea
	
	method esAtravesable() = true
	
	method darCopia() {
		jugador.agregarTarea(tarea)
		game.say(self, "Printer does BRRR BRRR")
	}
	
	method teEncontro() = true
}

object impresoraAzul inherits Impresora (tarea = tareaAzul, position = game.at(3,5)) {
	method image() = "ImpresoraAAzul.png"
}

object impresoraRojo inherits Impresora (tarea = tareaRojo, position = game.at(8,2)) {
	method image() = "ImpresoraBRojo.png"
}

object impresoraVerde inherits Impresora (tarea = tareaVerde, position = game.center()) {
	method image() = "ImpresoraAVerde.png"
}


class Companieri {
	var property position
	var tareaRequerida
	
	method esAtravesable() = false
	
	method presentarTarea(tarea) {
		if(tareaRequerida == tarea) {
			game.say(self, "Me has salvado! Estoy agradecido")
			jugador.terminarTarea(tarea)
		}
		else{
			game.say(self, "Te equivocaste de tarea, papafrita")
		}
	}
	
	method teEncontro() = true
}

object companieriAzul inherits Companieri (tareaRequerida = tareaAzul, position = game.at(13,5)){
	method image() = "CompanieriAzul.png"
}

object companieriRojo inherits Companieri (tareaRequerida = tareaRojo, position = game.at(6,4)){
	method image() = "CompanieriRojo.png"
}

object companieriVerde inherits Companieri (tareaRequerida = tareaVerde, position = game.at(3,8)){
	method image() = "CompanieriVerde.png"
}



object puerta {
	var property position = game.at(8,9)
	const tareasNecesarias = #{tareaAzul, tareaRojo, tareaVerde}
	
	method escapar() {
		if (tareasNecesarias == jugador.tareasRealizadas()){
			game.say(self, "GOOD ENDING")
			game.schedule(5000, {game.stop()})
		}
		else {
			game.say(self, "TE FALTAN TAREAS BOLUDO")
		}
	}
	
	method image() = "Puerta.png"
	
	method teEncontro() {
		if(position == jugador.position()){
			self.escapar()
		}
	}
	
	method potenciar(){
	}
	
	method esAtravesable() = true
}