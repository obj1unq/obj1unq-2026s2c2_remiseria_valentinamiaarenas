import remises.*
class Reserva {
    var property cantidadPersonasALlevar
    var property distanciaDeRecorrido
    var property tiempoDeViajeMax
    var property coloresContraindicados = #{}
    var property necesitaAutoSilencioso 
    var property necesitaLlevarSillaDeRuedas 
    const property kmPorHora = 10

    method laReservaPuedeSerCumplidaPor(vehiculo) {
        return self.elVehiculoCumpleAutonomia(vehiculo) && self.elVehiculoCumpleCapacidad(vehiculo) && self.elVehiculoCumpleNecesidades(vehiculo) && self.elVehiculoCumpleVelocidadMax(vehiculo)
    }

    method elVehiculoCumpleCapacidad(vehiculo) {
        return vehiculo.capacidadDePasajeros() >= cantidadPersonasALlevar
    }

    method elVehiculoCumpleAutonomia(vehiculo) {
        return vehiculo.autonomiaEnKm() >= distanciaDeRecorrido
    }

    method elVehiculoCumpleVelocidadMax(vehiculo) {
        return vehiculo.velocidadMaxima() >= self.velocidadPromedio() + kmPorHora
    }

    method elVehiculoCumpleNecesidades(vehiculo) {
        return self.elVehiculoCumpleColor(vehiculo) && self.elVehiculoCumpleLlevarSilla(vehiculo) && self.elVehiculoCumpleSerSilencioso(vehiculo)
    }

    method velocidadPromedio(){ 
        return distanciaDeRecorrido / tiempoDeViajeMax
    }

    method elVehiculoCumpleColor(vehiculo){
        return not coloresContraindicados.contains(vehiculo.color())
    }

    method elVehiculoCumpleLlevarSilla(vehiculo) {
        return not self.necesitaLlevarSillaDeRuedas() || vehiculo.puedeTrasportarSillaDeRuedas()
    }

    method elVehiculoCumpleSerSilencioso(vehiculo) {
        return not self.necesitaAutoSilencioso() || not vehiculo.esRuidoso()
    }
}