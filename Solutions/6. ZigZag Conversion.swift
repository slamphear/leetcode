/*
 Problem 6: ZigZag Conversion
 https://leetcode.com/problems/zigzag-conversion/
 */

//MARK: Solution

class Solution {
    func convert(_ s: String, _ numRows: Int) -> String {
        //Trivial case: numRows is 1
        guard numRows > 1 else { return s }
        
        //Prepare for loop
        var rows = Array(repeating: "", count: numRows)
        var incrementRowIndex = true
        var rowIndex = 0
        
        //Build out the rows
        for character in Array(s) {
            rows[rowIndex] += String(character)
            
            //Prepare for next iteration
            guard incrementRowIndex else {
                if rowIndex == 0 {
                    incrementRowIndex.toggle()
                    rowIndex += 1
                } else {
                    rowIndex -= 1
                }
                continue
            }
            
            guard rowIndex != (numRows - 1) else {
                incrementRowIndex.toggle()
                rowIndex -= 1
                continue
            }
            
            rowIndex += 1
        }
        
        return rows.joined()
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
    TestCase(s: "A", numRows: 1, output: "A"),
    TestCase(s: "AB", numRows: 1, output: "AB")
]

for testCase in testCases {
    let output = solution.convert(testCase.s, testCase.numRows)
    guard output == testCase.output else {
        print("FAILURE: Test case \"\(testCase.s)\" returned \"\(output)\". Expected output was \"\(testCase.output)\".")
        continue
    }
    
    print("Test case passed")
}
