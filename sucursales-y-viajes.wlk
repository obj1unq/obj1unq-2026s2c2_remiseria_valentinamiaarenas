import reservas.*
import remises.*

class Sucursal {
    var property flotaDeVehiculos = #{}
    var property historialViajesRealizados = #{}

    method hacerReserva(reserva, vehiculo){
        self.validarVehiculo(vehiculo)
        self.validarReserva(reserva, vehiculo)
        self.registrarViaje(reserva, vehiculo)
    }

    method validarVehiculo(vehiculo) {
        if (not flotaDeVehiculos.contains(vehiculo)) {
            self.error("Este vehiculo no es parte de la sucursal")
        }
    }

    method validarReserva(reserva, vehiculo) {
        if (not reserva.laReservaPuedeSerCumplidaPor(vehiculo)) {
            self.error("La reserva no puede ser tomada")
        }
    }

    method vehiculosQuePuedenCumplirReserva(reserva){
        return flotaDeVehiculos.filter({vehiculo => reserva.laReservaPuedeSerCumplidaPor(vehiculo)})
    }

    method registrarViaje(reserva, vehiculo) {
        const registroDeViaje = new Viaje(reserva = reserva, vehiculo = vehiculo)

        historialViajesRealizados.add(registroDeViaje)
    }

    method agregarVehiculoALaFlota(vehiculo) {
        flotaDeVehiculos.add(vehiculo)
    }

    method quitarVehiculoDeLaFlota(vehiculo) {
        flotaDeVehiculos.remove(vehiculo)
    }

    method reservasQueElVehiculoCumplio(vehiculo) {
        return self.viajesDondeElVehiculoCumplio(vehiculo).map({ viaje => viaje.reserva() })
    }

    method viajesDondeElVehiculoCumplio(vehiculo) {
        return historialViajesRealizados.filter({ viaje => viaje.vehiculo() == vehiculo })
    }

    method distanciaTotalRecorridaPor(vehiculo) {
        return self.reservasQueElVehiculoCumplio(vehiculo).sum({reserva => reserva.distanciaDeRecorrido()})
    }
}

class Viaje {
    var property reserva
    var property vehiculo
}