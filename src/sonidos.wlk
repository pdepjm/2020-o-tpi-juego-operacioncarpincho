import wollok.game.*

object sonido{
	var escapeBoss = game
	
	method escapeBoss(elJuego) {
		escapeBoss = elJuego
	}
	
	method sonido(audio) = escapeBoss.sound("Sonidos/" + audio)
	
	method reproducir(audio) {
		self.sonido(audio).play()
	}
}


object mockGame{	
	method sound(ruta) = mockSonido
}
	
object mockSonido {
	method play(){}
}
