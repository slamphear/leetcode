/*
 Problem 7: Reverse Integer
 https://leetcode.com/problems/reverse-integer/
 */

import Foundation

class Solution7 {
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

//TODO: Clean up tests

//func runTests() {
//    print(findMedianSortedArrays([], [])) // Trivial case: Median is 0.0
//    print(findMedianSortedArrays([], [1, 2, 3])) // Trivial case (one array is empty), odd version: median is 2.0
//    print(findMedianSortedArrays([], [1, 2, 3, 4])) // Trivial case (one array is empty), even version: median is 2.5
//    print(findMedianSortedArrays([1, 2, 3], [])) // Trivial case (one array is empty), odd version: median is 2.0
//    print(findMedianSortedArrays([1, 2, 3, 4], [])) // Trivial case (one array is empty), even version: median is 2.5
//    print(findMedianSortedArrays([1], [2])) // Median is 1.5
//    print(findMedianSortedArrays([1, 2], [-1, 3])) // Median is 1.5
//    print(findMedianSortedArrays([1], [2, 3])) // Median is 2.0
//    print(findMedianSortedArrays([1, 3], [2])) // Median is 2.0
//    print(findMedianSortedArrays([1, 2], [3, 4])) // Median is 2.5
//    print(findMedianSortedArrays([1000], [1, 2, 3])) // Median is 2.5
//    print(findMedianSortedArrays([1, 2, 7, 8], [3, 4, 5, 6])) // Median is 4.5
//    print(findMedianSortedArrays([1, 1, 1, 1, 1, 1, 13], [1, 1, 1, 1, 1, 1, 578])) // Median is 1.0
//    print(findMedianSortedArrays([1], [2,3,4,5])) // Median is 3.0
    
//    print(reverse(123))
//    print(reverse(-23))
//    print(reverse(0))
//    print(reverse(2158962349875897))
//}
