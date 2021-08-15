/*
 Problem 13: Roman to Integer
 https://leetcode.com/problems/roman-to-integer/
 
 This solution is a work in progress. It is currently just a stub.
 */

//MARK: Solution

class Solution {
    func romanToInt(_ s: String) -> Int {
        var total = 0

        for index in Array(s.indices) {
            print("index \(index)")
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
