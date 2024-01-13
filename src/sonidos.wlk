import wollok.game.*

object musica{
    const musica = game.sound("temardo.mp3")
    method play(){
      musica.shouldLoop(true)
		  musica.volume(0.3)
		  game.schedule(100, { musica.play() })
    }

    method stop(){
      musica.stop()
    }
		
} 

object musica2{
    const musica = game.sound("random.mp3")
    method play(){
      musica.shouldLoop(true)
      musica.volume(0.2)
      game.schedule(100, { musica.play() })
    }

    method stop(){
      musica.stop()
    }
    
}
object choque_bola {
	
	method play(){
		game.sound("choque_bola.mp3").play()
	}
	
}

object 1up {
	
	method play(){
		game.sound("1up.mp3").play()
	}
	
}

object agarrar_llave{
	
	method play(){
		game.sound("agarrar_llave.mp3").play()
	}
}


object  pasaste_nivel{
	
	method play(){
		game.sound("pasaste_nivel.mp3").play()
	}
}


object need_egg{
	method play(){
		game.sound("need_egg.mp3").play()
		}
}

object  need_key{
  method play(){
    game.sound("need_key.mp3").play()
    }
}

object  agarrar{
  method play(){
    game.sound("agarrar.mp3").play()
    }
}

object  comer{
  method play(){
    game.sound("comer.mp3").play()
    }
}

object  dmg{
  
  method play(){
    const p = game.sound("dmg.mp3")
    p.volume(0.4)
    p.play()
    }
}

object  door_open{
  method play(){
    game.sound("door_open.mp3").play()
    }
}

object door_close{
  method play(){
    game.sound("door_close.mp3").play()
    }
}

object  teleport{
  method play(){
    game.sound("teleport.mp3").play()
    }
}

object  muerte_miusic{
  var m = game.sound("muerte_miusic.mp3")
  method play(){
    m.play()
    }
  
  method stop(){
    m.stop()
    }

  method played(){
    game.sound("muerte_miusic.mp3").played()
    }
}

object  holy{
  method play(){
    game.sound("holy.mp3").play()
    }
}

object  randomMp3{
  method play(){
    game.sound("random-mp3.mp3").play()
    }
}

object  temardo{
  method play(){
    game.sound("temardo.mp3").play()
    }
}

object tiemblen{
  const p = game.sound("tiemblen.mp3")
  method play(){
    p.play()
    }
  method stop(){
    p.stop()
    }
}

object bit_noise{
  method play(){
    game.sound("bit_noise.mp3").play()
    }
  }

object  paso{
  
  method play(){
    const p = game.sound("paso.mp3")
    p.volume(0.1)
    p.play()
    }
}

object  arrastra{
  
  method play(){
    game.sound("arrastra.mp3").play()
    }
}

object  prick{
  method play(){
    game.sound("prick.mp3").play()
    }
}

object  motosierra{
  method play(){
    game.sound("motosierra.mp3").play()
    }
}

object  no_plata{
  method play(){
    game.sound("no_plata.mp3").play()
    }
}