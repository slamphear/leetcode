/*
 Problem 7: Reverse Integer
 https://leetcode.com/problems/reverse-integer/
 */

//MARK: Solution

import Foundation

class Solution {
    func reverse(_ x: Int) -> Int {
        
        // Trivial case: nothing to reverse.
        if x > -10 && x < 10 {
            return x
        }
        
        var remaining = x
        var reversed = 0
        var unitMultipler = Int(pow(10, floor(log10(Double(abs(x))))))
        
        while remaining < -9 || remaining > 9 {
            let digit = remaining % 10
            reversed += digit * unitMultipler
            
            // Prepare for next loop
            remaining /= 10
            unitMultipler /= 10
        }
        
        reversed += remaining * unitMultipler
        
        if reversed > Int32.max || reversed < Int32.min {
            return 0
        }
        
        return reversed
    }
}

//MARK: Test Script
//TODO: Clean up tests

func runTests() {
    let solution = Solution()
    print(solution.reverse(123))
    print(solution.reverse(-23))
    print(solution.reverse(0))
    print(solution.reverse(2158962349875897))
}
