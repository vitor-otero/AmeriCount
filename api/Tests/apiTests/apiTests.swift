//
//  apiTests.swift
//
//
//  Created by Vitor Otero on 12/08/2024.
//

import XCTest
@testable import api

final class apiTests: XCTestCase {
    // Test case for NetworkError.notFound
    func testIfGetNationWithoutInternetWillReturnNotFound() async throws {
        let manager = NationManagerMock()
        await XCTAssertThrowsErrorAsync(
            try await manager.getNationData(),
            NetworkError.notFound
        )
    }
    // Test case for NetworkError.authenticationError
    func testIfGetNationWithoutInternetWillReturnAuthenticationError() async throws {
        let manager = NationManagerMock()
        await XCTAssertThrowsErrorAsync(
            try await manager.getStateData(),
            NetworkError.authenticationError
        )
    }
}
