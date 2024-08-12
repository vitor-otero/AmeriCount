//
//  XCTAssertThrowsErrorAsync.swift
//
//
//  Created by Vitor Otero on 12/08/2024.
//

import Foundation
import XCTest

func XCTAssertThrowsErrorAsync<T, R>(
    _ expression: @autoclosure () async throws -> T,
    _ errorThrown: @autoclosure () -> R,
    _ message: @autoclosure () -> String = "This method should fail",
    file: StaticString = #filePath,
    line: UInt = #line
) async where R: Comparable, R: Error {
    do {
        _ = try await expression()
        XCTFail(message(), file: file, line: line)
    } catch {
        guard let thrownError = error as? R else {
            XCTFail("Unexpected error type thrown: \(error)", file: file, line: line)
            return
        }
        XCTAssertEqual(thrownError, errorThrown(), message(), file: file, line: line)
    }
}
