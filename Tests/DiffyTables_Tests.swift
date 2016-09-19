import XCTest

extension AlignmentDiffChange: Equatable {}

// This is really disappointing, Swift…

public func == (left: AlignmentDiffChange, right: AlignmentDiffChange) -> Bool {
	switch left {
	case .insertion(pos: let a, len: let b):
		switch right {
		case .insertion(pos: let aa, len: let bb): return a == aa && b == bb
		default: return false
		}
	case .deletion(pos: let a, len: let b):
		switch right {
		case .deletion(pos: let aa, len: let bb): return a == aa && b == bb
		default: return false
		}
	}
}

extension AlignmentDiffChange: CustomStringConvertible {
	public var description: String {
		switch self {
		case .insertion(let pos, let len): return "Insertion(\(pos), \(len))"
		case .deletion (let pos, let len): return "Deletion(\(pos), \(len))"
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
		
		a = Array("banana".characters)
		b = Array("atana".characters)
		
		XCTAssertEqual(longestCommonSubsequence(a, b), Array("aana".characters))
		
		a = Array("XMJYAUZ".characters)
		b = Array("MZJAWXU".characters)
		
		XCTAssertEqual(longestCommonSubsequence(a, b), Array("MJAU".characters))
		
		a = Array("nematode knowledge".characters)
		b = Array("empty bottle".characters)
		
		XCTAssertEqual(longestCommonSubsequence(a, b), Array("emt ole".characters))
	}
	
	func testDiff() {
		var a: [Character]
		var b: [Character]
		var c: [AlignmentDiffChange]
		
		a = Array("abcdef".characters)
		b = Array("abcdef".characters)
		c = []
		
		XCTAssertEqual(diffToAlign(a, b), c)
		
		a = Array("abcdef".characters)
		b = Array("xabcdef".characters)
		c = [.insertion(pos: 0, len: 1)]
		
		XCTAssertEqual(diffToAlign(a, b), c)
		
		a = Array("abcdef".characters)
		b = Array("xabcde".characters)
		c = [.insertion(pos: 0, len: 1), .deletion(pos: 6, len: 1)]
		
		XCTAssertEqual(diffToAlign(a, b), c)
		
		a = Array("abcdef".characters)
		b = Array("adef".characters)
		c = [.deletion(pos: 1, len: 2)]
		
		XCTAssertEqual(diffToAlign(a, b), c)
		
		a = Array("abcdef".characters)
		b = Array("acbdef".characters)
		c = [.insertion(pos: 1, len: 1), .deletion(pos: 3, len: 1)]
		
		XCTAssertEqual(diffToAlign(a, b), c)
		
		a = Array("a".characters)
		b = Array("".characters)
		c = [.deletion(pos: 0, len: 1)]
		
		XCTAssertEqual(diffToAlign(a, b), c)
		
		a = Array("ab".characters)
		b = Array("".characters)
		c = [.deletion(pos: 0, len: 2)]
		
		XCTAssertEqual(diffToAlign(a, b), c)
		
		a = Array("".characters)
		b = Array("ab".characters)
		c = [.insertion(pos: 0, len: 2)]
		
		XCTAssertEqual(diffToAlign(a, b), c)
		
		a = Array("banana".characters)
		b = Array("atana".characters)
		c = [.deletion(pos: 0, len: 1)]
		
		XCTAssertEqual(diffToAlign(a, b), c)
		
		a = Array("XMJYAUZ".characters)
		b = Array("MZJAWXU".characters)
		c = [.deletion(pos: 0, len: 1), .insertion(pos: 1, len: 1), .deletion(pos: 3, len: 1),
		     .insertion(pos: 4, len: 2), .deletion(pos: 7, len: 1)]
		
		XCTAssertEqual(diffToAlign(a, b), c)
		
		a = Array("nematode knowledge".characters)
		b = Array("empty bottle".characters)
		c = [.deletion(pos: 0, len: 1), .deletion(pos: 5, len: 2), .deletion(pos: 7, len: 1),
		     .insertion(pos: 9, len: 1), .deletion(pos: 12, len: 3)]
		
		XCTAssertEqual(diffToAlign(a, b), c)
	}
}
