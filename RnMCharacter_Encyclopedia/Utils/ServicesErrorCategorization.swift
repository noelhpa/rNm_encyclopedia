//
//  ServicesErrorCategorization.swift
//  RnMCharacter_Encyclopedia
//
//  Created by Noel Hiram Pat Angulo on 5/31/25.
//

import Foundation

enum RMNetworkError: Error, LocalizedError, Equatable {
    case badRequest
    case unauthorized
    case notFound
    case serverError(status: Int)
    case unhandled(status: Int)
    case noInternetConnection

    var errorDescription: String? {
        switch self {
        case .badRequest:
            return "Peticion invalida"
        case .unauthorized:
            return "No autorizado"
        case .notFound:
            return "No se encuentra"
        case .serverError(let status):
            return "Error del servidor (\(status))"
        case .unhandled(let status):
            return "Error desconocido (\(status))"
        case .noInternetConnection:
            return "Sin conexión a Internet"
        }
    }
}
