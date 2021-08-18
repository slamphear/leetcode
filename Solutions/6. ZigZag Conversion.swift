/*
 Problem 6: ZigZag Conversion
 https://leetcode.com/problems/zigzag-conversion/
 This solution is a work in progress. It is currently just a stub.
 */

//MARK: Solution

class Solution {
    func convert(_ s: String, _ numRows: Int) -> String {
        return ""
    }
}

//MARK: Test Script

struct TestCase {
    let s: String
    let numRows: Int
    let output: String
}

let solution = Solution()

let testCases = [
    TestCase(s: "PAYPALISHIRING", numRows: 3, output: "PAHNAPLSIIGYIR"),
    TestCase(s: "PAYPALISHIRING", numRows: 4, output: "PINALSIGYAHRPI"),
    TestCase(s: "A", numRows: 1, output: "A")
]

for testCase in testCases {
    let output = solution.convert(testCase.s, testCase.numRows)
    guard output == testCase.output else {
        print("FAILURE: Test case \"\(testCase.s)\" returned \"\(output)\". Expected output was \"\(testCase.output)\".")
        continue
    }
    
    print("Test case passed")
}
