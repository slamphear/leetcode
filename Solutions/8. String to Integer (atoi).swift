/*
 Problem 8: String to Integer (atoi)
 https://leetcode.com/problems/string-to-integer-atoi/
 */

//MARK: Solution

import Foundation

extension String {
    func withoutLeadingSpaces() -> String {
        guard let index = firstIndex(where: { $0 != " " }) else {
            return ""
        }
        return String(self[index...])
    }
    
    func withoutLeadingSign() -> String {
        guard !self.isEmpty else { return "" }
        let firstCharacter = self.first
        guard firstCharacter == "-" || firstCharacter == "+" else { return self }
        let secondIndex = self.index(after: self.startIndex)
        guard secondIndex != self.endIndex else { return "" }
        return String(self[secondIndex...])
    }
    
    func trimmedAtFirstNonNumericCharacter() -> String {
        guard !self.isEmpty else { return "" }
        guard let index = firstIndex(where: { !CharacterSet(charactersIn: String($0)).isSubset(of: .decimalDigits) }) else {
            return self
        }
        return String(self.prefix(upTo: index))
    }
}

extension Int {
    func clampedTo32Bit() -> Int {
        let maxInt = 2147483647
        let minInt = -2147483648
        guard self <= maxInt else { return maxInt }
        guard self >= minInt else { return minInt }
        return self
    }
}


class Solution {
    func myAtoi(_ s: String) -> Int {
        let maxInt = 2147483647
        let minInt = -2147483648
        let stringWithoutLeadingWhitespace = s.withoutLeadingSpaces()
        let isNegative = stringWithoutLeadingWhitespace.first == "-"
        let intString = stringWithoutLeadingWhitespace.withoutLeadingSign().trimmedAtFirstNonNumericCharacter()
        
        guard let intValue = Int(intString) else {
            guard intString.count > 0 else { return 0 }
            //At this point, an underflow or overflow has occurred.
            return isNegative ? minInt : maxInt
        }
        
        guard !isNegative else {
            return (intValue * -1).clampedTo32Bit()
        }
        
        return intValue.clampedTo32Bit()
    }
}

//MARK: Test Script

struct TestCase {
    let s: String
    let output: Int
}

let solution = Solution()

let testCases = [
    TestCase(s: "42", output: 42),
    TestCase(s: "   -42", output: -42),
    TestCase(s: "4193 with words", output: 4193),
    TestCase(s: "words and 987", output: 0),
    TestCase(s: "-91283472332", output: -2147483648),
    TestCase(s: "21474836460", output: 2147483647),
    TestCase(s: "20000000000000000000", output: 2147483647)
]

for testCase in testCases {
    let output = solution.myAtoi(testCase.s)
    guard output == testCase.output else {
        print("FAILURE: Test case \"\(testCase.s)\" returned \"\(output)\". Expected output was \"\(testCase.output)\".")
        continue
    }
    
    print("Test case passed")
}
