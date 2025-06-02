//
//  RooAPIServiceProtocol.swift
//  RnMCharacter_Encyclopedia
//
//  Created by Noel Hiram Pat Angulo on 6/2/25.
//

protocol RootAPIServiceProtocol: AnyObject {
    func loadRootURLs() async throws -> RootAPIResponseModel
}
