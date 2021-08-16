/*
 Problem 13: Roman to Integer
 https://leetcode.com/problems/roman-to-integer/
 */

//MARK: Solution

extension Character {
    func romanNumeralValue(whenFollowedBy nextValue: Character?) -> Int {
        if self == "I" {
            if let next = nextValue, (next == "V" || next == "X") {
                return -1
            } else {
                return 1
            }
        } else if self == "V" {
            return 5
        } else if self == "X" {
            if let next = nextValue, (next == "L" || next == "C") {
                return -10
            } else {
                return 10
            }
        } else if self == "L" {
            return 50
        } else if self == "C" {
            if let next = nextValue, (next == "D" || next == "M") {
                return -100
            } else {
                return 100
            }
        } else if self == "D" {
            return 500
        } else if self == "M" {
            return 1000
        }
        
        //No other characters are allowed given the problem's constraints.
        return 0
    }
}

class Solution {
    func romanToInt(_ s: String) -> Int {
        //Trivial case: String is empty.
        guard !s.isEmpty else { return 0 }
        
        var total = 0
        
        for index in s.indices {
            let character = s[index]
            let nextValue: Character?
            
            if s.index(after: index) < s.endIndex {
                let nextIndex = s.index(after: index)
                nextValue = s[nextIndex]
            } else {
                nextValue = nil
            }
            
            total += character.romanNumeralValue(whenFollowedBy: nextValue)
        }
        
        return total
    }
}

//MARK: Test Script

struct TestCase {
    let s: String
    let output: Int
}

func runTests() {
    let solution = Solution()
    
    let testCases = [
        TestCase(s: "I", output: 1),
        TestCase(s: "III", output: 3),
        TestCase(s: "IV", output: 4),
        TestCase(s: "V", output: 5),
        TestCase(s: "IX", output: 9),
        TestCase(s: "LVIII", output: 58),
        TestCase(s: "MCMXCIV", output: 1994)
    ]
    
    for testCase in testCases {
        guard solution.romanToInt(testCase.s) == testCase.output else {
            print("FAILURE: Test case \(testCase.s) returned \(solution.romanToInt(testCase.s)). Expected output was \(testCase.output)")
            continue
        }
        
        print("Test case passed")
    }
}

runTests()
