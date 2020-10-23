import wollok.game.*
import jefe.*
import oficina.*
import jugador.*
import configuraciones.*
import tareas.*
import sonidos.*

object pantallaJuego {
	
	/*
	var nivelActual = nivel1
	
	method nivelActual() = nivelActual
	
	method iniciar() {
		nivelActual.cargarNivel()
	}
	
	method avanzarNivel(unNivel) {
		nivelActual = unNivel
		self.iniciar()
	}
	
	method terminarJuego(){
		game.addVisual(fondoGanador)
		sonido.reproducir("Yodelling.mp3")
		game.schedule(5000, {game.stop()})
	}*/
	
	method iniciar() {
		
		game.addVisual(puerta)	
		game.addVisual(cafeConLeche)	
		game.addVisual(chocolate)	
		game.addVisual(hamburguesa)	
		game.addVisual(companieriAzul)	
		game.addVisual(companieriRojo)	
		game.addVisual(companieriVerde)	
		game.addVisual(planta1)
		game.addVisual(planta2)	
		game.addVisual(impresoraAzul)	
		game.addVisual(impresoraRojo)	
		game.addVisual(impresoraVerde)	
		game.addVisual(cuadrito)	
		game.addVisual(jugador)	
		game.addVisual(jefe1)	
		jefe1.moverse()
		
		game.showAttributes(jugador)	
		game.addVisual(energiaJugador)	
		game.addVisual(tareaAzul)	
		game.addVisual(tareaRojo)	
		game.addVisual(tareaVerde)	
		
		configuraciones.configurarColisiones()	
		configuraciones.cambiarEstado(estadoJuego)
		
	}
}

object fondoPerdioEnergia{
	var property position = game.origin()
	method image() = "Fondos/GameOverEnergia.png"
}

object fondoJefeGano {
	var property position = game.origin()
	method image() = "Fondos/GameOverJefe.png"
}

object fondoGanador{
	var property position = game.origin()
	method image() = "Fondos/Tomorrowland.png"
}


object energiaJugador {
	var property position = game.at(16,1)
	
	method image() = "BarraEnergia/Energia" + self.energia() + ".png"
	
	method energia() = (jugador.energia()/10).roundUp().toString() 
	
}