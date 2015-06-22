import Foundation

func random(n: Int) -> Int {
    return Int(arc4random_uniform(UInt32(n)))
}

extension Array {
    /// Returns first `n` elements of the array
    /// (Less if the array doesn't have that many)
    
    func limit(n: Int) -> [Element] {
        precondition(n >= 0)
        if self.count <= n {
            return self
        } else {
            return Array(self[0..<n])
        }
    }
}