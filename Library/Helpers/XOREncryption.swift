import Foundation

extension Data {
  func decrypt(with key: String) -> String? {
    var data = self
    data.xor(key: key.data(using: .utf8)!)
    return String(data: data, encoding: .utf8)
  }
}

extension Data {
  mutating func xor(key: Data) {
    for i in 0..<self.count {
      self[i] ^= key[i % key.count]
    }
  }
  
  func checkSum() -> Int {
    return self.map { Int($0) }.reduce(0, +) & 0xff
  }
}
