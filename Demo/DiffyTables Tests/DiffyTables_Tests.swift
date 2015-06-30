import UIKit
import XCTest

class DiffyTables_Tests: XCTestCase {
    func testLongestCommonSubsequence() {
        var a: [Int]
        var b: [Int]
        
        a = [1, 2, 3, 4]
        b = [1, 2, 3, 4]
        
        XCTAssertEqual(longestCommonSubsequence(a, b), [1, 2, 3, 4])
        
        a = []
        b = []
        
        XCTAssertEqual(longestCommonSubsequence(a, b), [])
        
        a = [1, 2, 3, 4]
        b = []
        
        XCTAssertEqual(longestCommonSubsequence(a, b), [])
        
        a = []
        b = [1, 2, 3, 4]
        
        XCTAssertEqual(longestCommonSubsequence(a, b), [])
        
        a = [1]
        b = [1, 2, 3, 4]
        
        XCTAssertEqual(longestCommonSubsequence(a, b), [1])
        
        a = [2]
        b = [1, 2, 3, 4]
        
        XCTAssertEqual(longestCommonSubsequence(a, b), [2])
        
        a = [1, 2, 3, 4]
        b = [4]
        
        XCTAssertEqual(longestCommonSubsequence(a, b), [4])
        
        a = [1, 2, 3, 4]
        b = [1, 3]
        
        XCTAssertEqual(longestCommonSubsequence(a, b), [1, 3])
        
        a = [1, 2, 3, 4]
        b = [0, 1, 2, 3, 4]
        
        XCTAssertEqual(longestCommonSubsequence(a, b), [1, 2, 3, 4])
        
        a = [5, 3, 2, 1, 8, 6, 4, 3, 2, 1]
        b = [0, 8, 3, 0, 4, 5, 1, 0]
        
        XCTAssertEqual(longestCommonSubsequence(a, b), [3, 4, 1])
    }
    
    func testLongestCommonSubsequence2() {
        var a: [Character]
        var b: [Character]
        
        a = Array("banana")
        b = Array("atana")
        
        XCTAssertEqual(longestCommonSubsequence(a, b), Array("aana"))
        
        a = Array("XMJYAUZ")
        b = Array("MZJAWXU")
        
        XCTAssertEqual(longestCommonSubsequence(a, b), Array("MJAU"))
        
        a = Array("XMJYAUZ")
        b = Array("MZJAWXU")
        
        XCTAssertEqual(longestCommonSubsequence(a, b), Array("MJAU"))
        
        a = Array("nematode knowledge")
        b = Array("empty bottle")
        
        XCTAssertEqual(longestCommonSubsequence(a, b), Array("emt ole"))
    }
}