import Foundation

// MARK: - Helper Methods
func makeMatrix(key: String) -> [[Character]] {
    var matrix = [[Character]](repeating: [Character](repeating: "-", count: 5), count: 5)
    var check = Set<Character>()
    var key = Array(key)
    let alphabets = "ABCDEFGHIKLMNOPQRSTUVWXYZ"
    var i = 0
    
    while i < key.count {
        if !check.contains(key[i]) {
            let row = i / 5
            let col = i % 5
            matrix[row][col] = key[i]
            check.insert(key[i])
            i += 1
        } else {
            key.remove(at: i)
        }
    }
    
    while i < 25 {
        for alphabet in alphabets {
            if !check.contains(alphabet) {
                let row = i / 5
                let col = i % 5
                matrix[row][col] = alphabet
                check.insert(alphabet)
                break
            }
        }
        i += 1
    }
    
    return matrix
}

func makePairs(message: String) -> [(Character, Character)] {
    var pairs = [(Character, Character)]()
    var message = Array(message)
    
    var i = 0
    while i < message.count {
        if i+1 == message.count || message[i] == message[i+1] {
            message.insert("Z", at: i+1)
        }
        pairs.append((message[i], message[i+1]))
        i += 2
    }
    
    return pairs
}

func findInMatrix(_ matrix: [[Character]], character: Character) -> (row: Int, col: Int) {
    for r in 0 ..< 5 {
        for c in 0 ..< 5 {
            if character == matrix[r][c] {
                return (r, c)
            }
        }
    }
    return (-1,-1)
}

// MARK: - Cipher / Decipher Methods
func playfairCipher(key: String, message: String) -> String {
    let matrix = makeMatrix(key: key)
    let pairs = makePairs(message: message)
    var encrpytedPairs = [(Character, Character)]()
    var cipherText = ""
    
    for pair in pairs {
        let (row1, col1) = findInMatrix(matrix, character: pair.0)
        let (row2, col2) = findInMatrix(matrix, character: pair.1)
        
        if row1 == row2 {
            encrpytedPairs.append((matrix[row1][(col1 + 1) % 5], matrix[row1][(col2 + 1) % 5]))
        } else if col1 == col2 {
            encrpytedPairs.append((matrix[(row1 + 1) % 5][col1], matrix[(row2 + 1) % 5][col2]))
        } else {
            encrpytedPairs.append((matrix[row1][col2], matrix[row2][col1]))
        }
        
        cipherText.append(encrpytedPairs.last!.0)
        cipherText.append(encrpytedPairs.last!.1)
    }
    
    return cipherText
}

func playfairDecipher(key: String, cipher: String) -> String {
    let matrix = makeMatrix(key: key)
    let pairs = makePairs(message: cipher)
    var decipherPairs = [(Character, Character)]()
    var decipherText = ""
    
    for pair in pairs {
        let (row1, col1) = findInMatrix(matrix, character: pair.0)
        let (row2, col2) = findInMatrix(matrix, character: pair.1)
        
        if row1 == row2 {
            var col1 = col1 - 1; if col1 < 0 { col1 += 5 }
            var col2 = col2 - 1; if col2 < 0 { col2 += 5 }
            decipherPairs.append((matrix[row1][col1], matrix[row1][col2]))
        } else if col1 == col2 {
            var row1 = row1 - 1; if row1 < 0 { row1 += 5 }
            var row2 = row2 - 1; if row2 < 0 { row2 += 5 }
            decipherPairs.append((matrix[row1][col1], matrix[row2][col2]))
        } else {
            decipherPairs.append((matrix[row1][col2], matrix[row2][col1]))
        }
        
        decipherText.append(decipherPairs.last!.0)
        decipherText.append(decipherPairs.last!.1)
    }
    
    return decipherText
}

// MARK: - Usage
let cipher = playfairCipher(key: "CRYPT", message: "MEETATBACK")
print("Cipher Message: \(cipher)")

let decipher = playfairDecipher(key: "CRYPT", cipher: cipher)
print("Decipher Message: \(decipher)")
