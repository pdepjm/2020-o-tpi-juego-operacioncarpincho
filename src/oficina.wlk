import wollok.game.*
import jugador.*
import tareas.*
import jefe.*
import pantallaJuego.*
import sonidos.*

class Consumible {
	var property position
	var energiaAportada
	const nombre
	
	method image() = "Oficina/" + nombre + ".png"

	method interactuar() {
		jugador.aumentarEnergia(energiaAportada)
		game.say(jugador, "Aumento la energia en " + energiaAportada.toString())
		game.removeVisual(self)
		sonido.reproducir("Burp.mp3")
	} 
	method teEncontro() = true

	method esAtravesable() = true
	
}

object cafeConLeche inherits Consumible (nombre = "Cafe", energiaAportada=25, position = game.at(3,5)) {}

object chocolate inherits Consumible (nombre = "Chocolate", energiaAportada=45, position = game.at(13,7)){}

object hamburguesa inherits Consumible (nombre = "Hamburguesa", energiaAportada=60, position = game.at(11,2)) {}

object pizza inherits Consumible (nombre = "Pizza", energiaAportada = 30, position = game.at(8,8)){}

object bebida inherits Consumible (nombre = "Bebida", energiaAportada = 20, position = game.at(9,4)){}

object rosquilla inherits Consumible (nombre = "Rosquilla", energiaAportada = 50, position = game.at(8,2)){}



// Mochila y Objetos personales
object mochila {
	var property position = game.center()
	
	method image() = "Oficina/Mochila.png"
	
	method interactuar() {
		jugador.agarrarMochila()
	}
}

class ObjetoPersonal {
	//var property position
	const nombre
	
	method image() = "Oficina/" + nombre + ".png"
	
	method esAtravesable() = true
	
	method teEncontro() = true
	
	method interactuar() {
		jugador.guardarObjeto(self)
		game.removeVisual(self)
		//sonido.reproducir("Take.mp3")
	}
}

object billetera inherits ObjetoPersonal (/*position = game.at(),*/nombre = "Billetera"){}

object celular inherits ObjetoPersonal (/*position = game.at(),*/nombre = "Celular"){}

object credencial inherits ObjetoPersonal (/*position = game.at(),*/nombre = "Credencial"){}

object laptop inherits ObjetoPersonal (/*position = game.at(),*/nombre = "Laptop"){}

object llaves inherits ObjetoPersonal (/*position = game.at(),*/nombre = "Llaves"){}



// Plantas
class Planta {
	var property position
	
	method image() = "Oficina/Planta.png"
	
	method teEncontro() = position == jugador.position()
	
	method interactuar() {
		jugador.error("Eto no eh comida papi")
	}
	
	method esAtravesable() = jugador.puedeEsconderse() and not(jefe1.puedeEsconderse())
}

object planta1 inherits Planta(position = game.at(3,6)){}

object planta2 inherits Planta(position = game.at(13,4)){}



// Impresoras
class Impresora {
	var property position
	var tarea
	const color
	const tipo
	
	method image() = "Oficina/Impresora" + tipo + color + ".png"
	
	method esAtravesable() = true
	
	method interactuar() {
		if(self.puedeImprimir()){
			jugador.agregarTarea(tarea)
			game.say(self, "Printer does BRRR BRRR")
			sonido.reproducir("Impresion.mp3")
		}
		else{
			game.say(self, "Hace falta magenta")
		}
	}
	
	method puedeImprimir() = not(jugador.entregoTarea(tarea))
		
	method teEncontro() = true
}

object impresoraAzul inherits Impresora (tipo = "A", color = "Azul", tarea = tareaAzul, position = game.at(3,3)) {}

object impresoraRojo inherits Impresora (tipo = "B", color = "Rojo", tarea = tareaRojo, position = game.center()) {}

object impresoraVerde inherits Impresora (tipo = "A", color = "Verde", tarea = tareaVerde, position = game.at(14,3)) {}


// Comestibles para compañeros
class Maquina {
	//var property position
	const nombre
	
	method image() = "Oficina/" + nombre + ".png"
	
	method interactuar() {}
}

object maquinaCafe inherits Maquina (/*position = game.at(),*/nombre = "MaquinaCafe"){
	
	override method interactuar() {
		jugador.agarrarObjeto(cafe)
	}
}

object heladera inherits Maquina (/*position = game.at(), */nombre = "Heladerita"){
	
	override method interactuar() {
		jugador.agarrarObjeto(helado)
	}
}

class Comestible {
	const nombre
	
	method nombre() = nombre
}

object cafe inherits Comestible (nombre = "Cafe"){}

object helado inherits Comestible (nombre = "Helado"){}

object vacio inherits Comestible (nombre = ""){}



// Compañeros
class Companieri {
	var property position
	var tareaRequerida
	const color
	
	method image() = "Oficina/Companieri" + color + ".png"
	
	method esAtravesable() = true
	
	method interactuar() {
		if(jugador.noTieneNingunaTarea()) {
			// jugador.noTieneNingunObjeto() AGREGAR ESTE CONDICIONAL
			game.say(self, "No me hagas perder el tiempo.")
			return false
		}
		else{
			return self.entregarTarea()
		}
	}
	
	method entregarTarea() {
		const tarea = jugador.tareaEnMano()
		if(tareaRequerida == tarea) {
			game.say(self, "Me has salvado! Estoy agradecido")
			jugador.terminarTarea(tarea)
			tarea.seEntrego()
			sonido.reproducir("Carpeta.mp3")
			return true
		}
		else{
			game.say(self, "Te equivocaste de tarea, papafrita")
			return false
		}
	}
	
	method teEncontro() = true
}

object companieriAzul inherits Companieri (color = "Azul", tareaRequerida = tareaAzul, position = game.at(13,8)){}

object companieriRojo inherits Companieri (color = "Rojo", tareaRequerida = tareaRojo, position = game.at(6,5)){}

object companieriVerde inherits Companieri (color = "Verde", tareaRequerida = tareaVerde, position = game.at(3,8)){}



// Puerta y Ascensor
object puerta {
	var property position = game.at(8,10)
	const tareasNecesarias = #{tareaAzul, tareaVerde, tareaRojo}
	
	method avanzar() {
		if (tareasNecesarias == jugador.tareasRealizadas()){
		//pantallaJuego.nivelActual().finalizarNivel()
			pantallaJuego.terminarJuego()
			return true
		}
		else {
			game.say(self, "Te faltan más tareas, apurate!")
			return false
		}
	}
	
	method image() = "Oficina/puerta.png"
	
	method teEncontro() = self.avanzar()
	
	method esAtravesable() = true
}


// Muros
class Muro {
	var property position
	method esAtravesable() = false
	
	method image() = "Oficina/Vacio.png"
}

object muroHorizontal inherits Muro(position = game.at(6,7)){
	override method image() = "Oficina/MuroHorizontal.png"
	
	method agregarMurosHorizontales() {
		game.addVisual(self)
		game.addVisual(muroHorizontal2)
		game.addVisual(muroHorizontal3)
		game.addVisual(muroHorizontal4)
		game.addVisual(muroHorizontal5)
	}
}

object muroHorizontal2 inherits Muro(position = game.at(7,7)){}
object muroHorizontal3 inherits Muro(position = game.at(8,7)){}
object muroHorizontal4 inherits Muro(position = game.at(9,7)){}
object muroHorizontal5 inherits Muro(position = game.at(10,7)){}


object muroVertical inherits Muro(position = game.at(8,3)){
	override method image() = "Oficina/MuroVertical.png"
	
	method agregarMurosVerticales() {
		game.addVisual(self)
		game.addVisual(muroVertical2)
		game.addVisual(muroVertical3)
		game.addVisual(muroVertical4)
	}
}

object muroVertical2 inherits Muro(position = game.at(8,4)){}
object muroVertical3 inherits Muro(position = game.at(8,5)){}
object muroVertical4 inherits Muro(position = game.at(8,6)){}



// Easter Egg
object cuadrito {
	var property position = game.at(10,10)
	
	method image() = "Oficina/cuadro.png"
	
	method teEncontro() = position == jugador.position()
	
	method interactuar(){
		jefe1.esconderse()
		game.addVisual(carpinchito)
		game.schedule(2000, {game.removeVisual(carpinchito)})
	}
	
	method esAtravesable() = true
}

object carpinchito {
	var property position = game.origin()
	
	method image() = "Fondos/Carpinchito.jpg"
}