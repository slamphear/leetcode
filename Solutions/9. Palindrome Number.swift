/*
 Problem 9: Palindrome Number
 https://leetcode.com/problems/palindrome-number/
 */

class Solution9 {
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

    func buildArray(from x: Int) {
        intArray.append(x % 10)
        
        guard x > 9 else { return }
        self.buildArray(from: x / 10)
    }

    func checkForPalindrominess() -> Bool {
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

//let testCases = [
//    0,
//    -1,
//    -9,
//    121,
//    -121,
//    10,
//    -101,
//    123
//]
//
//func runTests() {
//    let solution = Solution()
//
//    for x in testCases {
//        print("Is \(x) a palindrome? \(solution.isPalindrome(x))")
//    }
//}
//
//
//runTests()
