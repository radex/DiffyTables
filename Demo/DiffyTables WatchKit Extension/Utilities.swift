import Foundation

func random(_ n: Int) -> Int {
    return Int(arc4random_uniform(UInt32(n)))
}

extension Array {
    /// Returns first `n` elements of the array
    /// (Less if the array doesn't have that many)
    
    func limit(_ n: Int) -> [Element] {
        precondition(n >= 0)
        if self.count <= n {
            return self
        } else {
            return Array(self[0..<n])
        }
    }
}
