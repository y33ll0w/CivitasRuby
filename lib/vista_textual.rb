#encoding:utf-8
require_relative 'operaciones_juego'
require 'io/console'

module Civitas

  class Vista_textual

    def mostrar_estado(estado)
      puts estado
    end

    
    def pausa
      print "Pulsa una tecla"
      STDIN.getch
      print "\n"
    end

    def lee_entero(max,msg1,msg2)
      ok = false
      begin
        print msg1
        cadena = gets.chomp
        begin
          if (cadena =~ /\A\d+\Z/)
            numero = cadena.to_i
            ok = true
          else
            raise IOError
          end
        rescue IOError
          puts msg2
        end
        if (ok)
          if (numero >= max)
            ok = false
          end
        end
      end while (!ok)

      return numero
    end



    def menu(titulo,lista)
      tab = "  "
      puts titulo
      index = 0
      lista.each { |l|
        puts tab+index.to_s+"-"+l
        index += 1
      }

      opcion = lee_entero(lista.length,
                          "\n"+tab+"Elige una opción: ",
                          tab+"Valor erróneo")
      return opcion
    end

    def salirCarcel
      opcion = menu("Elige la forma para intentar salir de la carcel",
        ["Pagando","Tirando el dado"])
  
      return lista_salidas_carcel[opcion]
    end
    
    def comprar
      opcion = menu("¿Quiere comprar la calle?", ["Si", "No"])
      return lista_respuestas[opcion]
    end

    def gestionar
      opcion = menu("Seleccione gestion inmobiliaria", 
        ["Vender", "Hipotecar", "Cancelar hipoteca", "Construir casa", 
          "Construir hotel", "Terminar"])
      
      @iGestion = opcion
      @iPropiedad = 0
    end

    def getGestion
      return @iGestion
    end

    def getPropiedad
      return @iPropiedad
    end

    def mostrarSiguienteOperacion(operacion)
      puts operacion.to_s
    end

    def mostrarEventos
      puts Diario.instance.leer_evento while Diario.instance.eventos_pendientes
    end

    def setCivitasJuego(civitas)
         @juegoModel=civitas
         self.actualizarVista
    end

    def actualizarVista
      puts "-***- Info Jugador -***-\n 
           #{@juegoModel.getJugadorActual.to_s} 
            -***- Casilla Actual -**-\n 
           #{@juegoModel.getCasillaActual.to_s}\n"
    end

    
  end

end