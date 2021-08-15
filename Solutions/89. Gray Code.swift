/*
 Problem 89: Gray Code
 https://leetcode.com/problems/gray-code/
 
 This solution is a work in progress. The instructions say to
 "return any valid n-bit gray code sequence."
 However, this example is rejected due to the following test case:
 
 Input: 3
 stdout: ["0", "1", "11", "111", "110", "100"]
 Output: [0,1,3,7,6,4]
 Expected: [0,1,3,2,6,7,5,4]
 
 As the stdout above shows, the given output is still a valid gray code sequence; it's
 just not the same gray code sequence as the expected one. Next steps are to take a
 closer look at the expected output and figure out the pattern for what it's expecting.
 */

extension Int {
    var binaryString: String {
        String(self, radix: 2)
    }
}

extension String {
    var intFromBinary: Int? {
        Int(self, radix: 2)
    }
}

extension Character {
    var binaryFlip: Character? {
        if self == "0" { return "1" }
        if self == "1" { return "0" }
        return nil
    }
}

class Solution89 {
    func grayCode(_ n: Int) -> [Int] {
        let startingString = String(repeating: "0", count: n)
        var binaryStrings: [String] = [startingString]
        var currentString = startingString

        for index in startingString.indices.reversed() {
            let characterAtIndex = startingString[index]
            guard let flippedCharacter = characterAtIndex.binaryFlip else { continue }
            currentString.remove(at: index)
            currentString.insert(flippedCharacter, at: index)
            binaryStrings.append(currentString)
        }

        let completelyFlippedString = currentString

        for index in completelyFlippedString.indices.reversed() {
            let characterAtIndex = completelyFlippedString[index]
            guard let flippedCharacter = characterAtIndex.binaryFlip else { continue }
            currentString.remove(at: index)
            currentString.insert(flippedCharacter, at: index)
            binaryStrings.append(currentString)
        }

        var ints = binaryStrings.compactMap {
            $0.intFromBinary
        }

        if ints.count > 1 {
            ints = ints.dropLast()
        }

        print(ints.compactMap {
            $0.binaryString
        })

        return ints
    }
}

//TODO: Write tests

//print(Solution().grayCode(3))
