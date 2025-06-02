//
//  RootAPIServiceMock.swift
//  RnMCharacter_Encyclopedia
//
//  Created by Noel Hiram Pat Angulo on 6/2/25.
//

@testable import RnMCharacter_Encyclopedia

final class RootAPIServiceMock: RootAPIServiceProtocol {
    var rootAPIRsponse: RootAPIResponseModel?
    var errorToThrow: RMNetworkError?

      func loadRootURLs() async throws -> RootAPIResponseModel {
          if let error = errorToThrow {
              throw error
          }
          return rootAPIRsponse ?? RootAPIResponseModel.empty
      }
  }
