import configuraciones.*
import jugador.*
import tarjetas.*


object arriba {
	method nombre() = "Espalda"
	
	method posicion(posicion) = posicion.up(1)
	
	method puedeIr(personaje) = personaje.position().y() < (altura - 3) and self.posicion(personaje.position()).allElements().all({elemento => elemento.esAtravesable()})
	
	method orientar(personaje, posicion){
	}
}
 
 
object abajo {
	method nombre() = "DeFrente"
	
	method posicion(posicion) = posicion.down(1)
	
	method puedeIr(personaje) = personaje.position().y() > 1 and self.posicion(personaje.position()).allElements().all({elemento => elemento.esAtravesable()})
	
	method orientar(personaje, posicion){
	}
}


object derecha {
	method nombre() = "Derecha"
	
	method posicion(posicion) = posicion.right(1)
	
	method puedeIr(personaje) = personaje.position().x() < (ancho - 5) and self.posicion(personaje.position()).allElements().all({elemento => elemento.esAtravesable()})
	
	method orientar(personaje, posicion) {
		personaje.orientacion(self)
	}	
} 


object izquierda {
	method nombre() = "Izquierda"
	
	method posicion(posicion) = posicion.left(1)
	
	method puedeIr(personaje) = personaje.position().x() > 3 and self.posicion(personaje.position()).allElements().all({elemento => elemento.esAtravesable()})
	
	method orientar(personaje, posicion) {
		personaje.orientacion(self)
	}
}

