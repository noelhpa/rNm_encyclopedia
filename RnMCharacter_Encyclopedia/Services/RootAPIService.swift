//
//  RootAPIService.swift
//  RnMCharacter_Encyclopedia
//
//  Created by Noel Hiram Pat Angulo on 5/31/25.
//

import Foundation

final class RootAPIService: RootAPIServiceProtocol {
    func loadRootURLs() async throws -> RootAPIResponseModel {
        guard let url = URL(string: rootAPI) else {
            throw URLError(.badURL)
        }

        do{
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }

            switch httpResponse.statusCode {
            case 200:
                break
            case 400:
                throw RMNetworkError.badRequest
            case 401:
                throw RMNetworkError.unauthorized
            case 404:
                throw RMNetworkError.notFound
            case 500...599:
                throw RMNetworkError.serverError(status: httpResponse.statusCode)
            default:
                throw RMNetworkError.unhandled(status: httpResponse.statusCode)
            }

            do {
                let decodifiedResponse = try JSONDecoder()
                    .decode(RootAPIResponseModel.self, from: data)
                return decodifiedResponse
            } catch {
                throw error
            }
        } catch let urlError as URLError {
            if urlError
                .code == .notConnectedToInternet {
                throw RMNetworkError.noInternetConnection
            } else {
                throw urlError
            }
        }
    }
}
