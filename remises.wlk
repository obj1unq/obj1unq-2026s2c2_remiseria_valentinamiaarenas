class Torino {
  var property capacidadDePasajeros = 4
  var property velocidadMaxima
  var property esRuidoso = true 
  var property puedeTrasportarSillaDeRuedas = false
  var property color
  var property autonomiaEnKm
}

class Economico {
  var property esRuidoso = true
  var property color = "beige"
  const adaptaciones = #{}
  const velocidadBase = 120

    method capacidadDePasajeros() {
      return 5 - self.espacioQueOcupaAdaptaciones()
    }

    method espacioQueOcupaAdaptaciones(){
      return adaptaciones.sum({adaptacion => adaptacion.espacioQueOcupa()})
    }

    method velocidadMaxima() {
      return self.velocidadDeAdaptaciones().minIfEmpty({velocidadBase})
    }

    method velocidadDeAdaptaciones(){
      return adaptaciones.map({adaptacion => adaptacion.velocidadMaxima()})
    }

    method puedeTrasportarSillaDeRuedas() {
      return adaptaciones.contains(transportadorDeSillasDeRuedas)
    }

    method esRuidoso() {
      return not (adaptaciones.contains(cañoDeEscape) or adaptaciones.contains(tanqueExtraDeGas))
    }

    method autonomiaEnKm() {
      return 200 + adaptaciones.sum({adaptacion => adaptacion.autonomia()})
    }
}

object transportadorDeSillasDeRuedas {
  method espacioQueOcupa() = 1
  method velocidadMaxima() = 90
  method autonomia() = -20
}

object cañoDeEscape {
  method espacioQueOcupa() = 0
  method velocidadMaxima() = 115
  method autonomia() = -10
}

object tanqueExtraDeGas {
  method espacioQueOcupa() = 1
  method velocidadMaxima() = 80
  method autonomia() = 200
}

object combiAdaptable {
  var property color = "celeste"
  var property interior = accesible
  var property motor = urbano

  method capacidadDePasajeros() {
    return interior.capacidad()
  }

  method puedeTrasportarSillaDeRuedas() {
    return interior.puedeTransportarSilla()
  }

  method autonomiaEnKm() {
    return motor.autonomia()
  }

  method velocidadMaxima() {
    return motor.velocidadMaxima()
  }

  method esRuidoso() {
    return motor.esRuidoso()
  }
}

object espacioso {
  method capacidad() = 7
  method puedeTransportarSilla() = false
}

object accesible {
  method capacidad() = 5
  method puedeTransportarSilla() = true
}

object deportivo {
  method autonomia() = 400
  method velocidadMaxima() = 230
  method esRuidoso() = true
}

object urbano {
  method autonomia() = 1000
  method velocidadMaxima() = 130
  method esRuidoso() = false
}