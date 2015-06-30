import UIKit
import XCTest

class DiffyTables_Tests: XCTestCase {
    func testLongestCommonSubsequence() {
        var a: [Int]
        var b: [Int]
        
        a = [1, 2, 3, 4]
        b = [1, 2, 3, 4]
        
        XCTAssertEqual(longestCommonSubsequence(a, b), [1, 2, 3, 4])
    }
}
