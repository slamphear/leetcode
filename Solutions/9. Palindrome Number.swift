/*
 Problem 9: Palindrome Number
 https://leetcode.com/problems/palindrome-number/
 */

//MARK: Solution

class Solution {
    var intArray: [Int] = []

    func isPalindrome(_ x: Int) -> Bool {
        //Trivial case 1: x is negative (no negative number can be a palindrome)
        guard x >= 0 else { return false }
        
        //Trivial case 2: we only have one digit!
        guard x > 9 else { return true }
        
        //Step 1: Convert int to array of single digits
        self.intArray = []
        self.buildArray(from: x)
        
        //Step 2: Use recursive function to see if it's a palindrome
        return checkForPalindrominess()
    }

    private func buildArray(from x: Int) {
        intArray.append(x % 10)
        
        guard x > 9 else { return }
        self.buildArray(from: x / 10)
    }

    private func checkForPalindrominess() -> Bool {
        //Base case: we got all the way to a middle digit (or there is no middle digit)
        guard self.intArray.count > 1 else { return true }
        
        //Step 1: Extract the first and last digits
        let firstDigit = self.intArray.removeFirst()
        let lastDigit = self.intArray.removeLast()
        
        //Step 2: Return false if the first and last digits don't match
        guard firstDigit == lastDigit else { return false }
        
        //Step 3: Recurse
        return self.checkForPalindrominess()
    }
}

//MARK: Test Script

struct TestCase {
    let x: Int
    let output: Bool
}

let solution = Solution()

let testCases = [
    TestCase(x: 0, output: true),
    TestCase(x: -1, output: false),
    TestCase(x: -9, output: false),
    TestCase(x: 121, output: true),
    TestCase(x: -121, output: false),
    TestCase(x: 10, output: false),
    TestCase(x: 101, output: true),
    TestCase(x: 123, output: false)
]

for testCase in testCases {
    let output = solution.isPalindrome(testCase.x)
    guard output == testCase.output else {
        print("FAILURE: Test case \(testCase.x) returned \(output). Expected output was \(testCase.output)")
        continue
    }
    
    print("Test case passed")
}
