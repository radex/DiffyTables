import UIKit
import XCTest

extension AlignmentDiffChange: Equatable {}

// This is really disappointing, Swift…

public func == (left: AlignmentDiffChange, right: AlignmentDiffChange) -> Bool {
    switch left {
    case .Insertion(pos: let a, len: let b):
        switch right {
        case .Insertion(pos: let aa, len: let bb): return a == aa && b == bb
        default: return false
        }
    case .Deletion(pos: let a, len: let b):
        switch right {
        case .Deletion(pos: let aa, len: let bb): return a == aa && b == bb
        default: return false
        }
    }
}

extension AlignmentDiffChange: Printable {
    public var description: String {
        switch self {
        case .Insertion(let pos, let len): return "Insertion(\(pos), \(len))"
        case .Deletion (let pos, let len): return "Deletion(\(pos), \(len))"
        }
    }
}

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
    
    func testDiff() {
        var a: [Character]
        var b: [Character]
        var c: [AlignmentDiffChange]
        
        a = Array("abcdef")
        b = Array("abcdef")
        c = []
        
        XCTAssertEqual(diffToAlign(a, b), c)
        
        a = Array("abcdef")
        b = Array("xabcdef")
        c = [.Insertion(pos: 0, len: 1)]
        
        XCTAssertEqual(diffToAlign(a, b), c)
        
        a = Array("abcdef")
        b = Array("xabcde")
        c = [.Insertion(pos: 0, len: 1), .Deletion(pos: 6, len: 1)]
        
        XCTAssertEqual(diffToAlign(a, b), c)
        
        a = Array("abcdef")
        b = Array("adef")
        c = [.Deletion(pos: 1, len: 2)]
        
        XCTAssertEqual(diffToAlign(a, b), c)
        
        a = Array("abcdef")
        b = Array("acbdef")
        c = [.Insertion(pos: 1, len: 1), .Deletion(pos: 3, len: 1)]
        
        XCTAssertEqual(diffToAlign(a, b), c)
        
        a = Array("a")
        b = Array("")
        c = [.Deletion(pos: 0, len: 1)]
        
        XCTAssertEqual(diffToAlign(a, b), c)
        
        a = Array("ab")
        b = Array("")
        c = [.Deletion(pos: 0, len: 2)]
        
        XCTAssertEqual(diffToAlign(a, b), c)
        
        a = Array("")
        b = Array("ab")
        c = [.Insertion(pos: 0, len: 2)]
        
        XCTAssertEqual(diffToAlign(a, b), c)
    }
}