/*
 Problem 4: Median of Two Sorted Arrays
 https://leetcode.com/problems/median-of-two-sorted-arrays/
 */

//MARK: Solution

class Solution {
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        let isMedianAtEvenPosition = (nums1.count + nums2.count) % 2 == 0
        
        var medianPosition = (nums1.count + nums2.count) / 2
        // When the number of possible positions is odd, the median position == (n + 1) / 2
        // When it's even, the median position == (n/2) and there will be a "co-median" at (n/2 + 1)
        if isMedianAtEvenPosition {
            medianPosition -= 1
        }
        
        // First, handle trivial cases.
        if nums1.isEmpty && nums2.isEmpty {
            // Trivial case 1: No values were actually passed in.
            return 0.0
        } else if nums1.isEmpty {
            // Trivial case 2: First array is empty, so just find median of second array.
            let medianPosition = nums2.count / 2
            if nums2.count % 2 == 0 {
                return (Double(nums2[medianPosition - 1]) + Double(nums2[medianPosition])) / 2.0
            }
            return Double(nums2[medianPosition])
        } else if nums2.isEmpty {
            // Trivial case 3: Second array is empty, so just find median of first array.
            let medianPosition = nums1.count / 2
            if nums1.count % 2 == 0 {
                return (Double(nums1[medianPosition - 1]) + Double(nums1[medianPosition])) / 2.0
            }
            return Double(nums1[medianPosition])
        } else if nums1.count == 1 && nums2.count == 1 {
            //Trivial case 4: Both arrays have exactly 1 value.
            return (Double(nums1[0]) + Double(nums2[0])) / 2.0
        } else if medianPosition == 1 {
            // Trivial case 5: This is less trivial, but we still don't need to advance pointers here.
            // First, find the second (and third, if necessary) values
            var secondValue = 0
            var thirdValue = 0
            
            if nums1.count > 1 && nums2.count > 1 {
                // Both arrays have at least 2 values
                if nums1[0] < nums2[0] {
                    // nums1[0] is first value
                    if nums1[1] < nums2[0] {
                        // nums1[0] -> nums1[1]
                        secondValue = nums1[1]
                        if nums1.count > 2 {
                            thirdValue = min(nums1[2], nums2[0])
                        } else {
                            thirdValue = nums2[0]
                        }
                    } else {
                        // nums1[0] -> nums2[0]
                        secondValue = nums2[0]
                        thirdValue = min(nums1[1], nums2[1])
                    }
                } else {
                    // nums2[0] is the first value
                    if nums1[0] < nums2[1] {
                        // nums2[0] -> nums1[0]
                        secondValue = nums1[0]
                        thirdValue = min(nums1[1], nums2[1])
                    } else {
                        // nums2[0] -> nums2[1]
                        secondValue = nums2[1]
                        if nums2.count > 2 {
                            thirdValue = min(nums1[0], nums2[2])
                        } else {
                            thirdValue = nums1[0]
                        }
                    }
                }
            } else if nums1.count > 1 {
                // nums2 only has 1 value, but nums1 has more than 1
                if nums1[0] < nums2[0] {
                    // first value is nums1[0]
                    if nums1[1] < nums2[0] {
                        // nums1[0] -> nums1[1]
                        secondValue = nums1[1]
                        if nums1.count > 2 {
                            thirdValue = min(nums1[2], nums2[0])
                        } else {
                            thirdValue = nums2[0]
                        }
                    } else {
                        //nums1[0] -> nums2[0]
                        secondValue = nums2[0]
                        thirdValue = nums1[1]
                    }
                } else {
                    // first value is nums2[0]. Because nums2 only has 1 value, everything else comes from nums1
                    secondValue = nums1[0]
                    thirdValue = nums1[1]
                }
            } else if nums2.count > 1 {
                // nums1 only has 1 value, but nums2 has more than 1
                if nums1[0] < nums2[0] {
                    // First value is nums1[0]. Because nums1 only has 1 value, everything else comes from nums2.
                    secondValue = nums2[0]
                    thirdValue = nums2[1]
                } else {
                    // First value is nums2[0]
                    if nums1[0] < nums2[1] {
                        // nums2[0] -> nums1[0]
                        secondValue = nums1[0]
                        thirdValue = nums2[1]
                    } else {
                        // nums2[0] -> nums2[1]
                        secondValue = nums2[1]
                        if nums2.count > 2 {
                            thirdValue = min(nums1[0], nums2[2])
                        } else {
                            thirdValue = nums1[0]
                        }
                    }
                }
            }
            
            if isMedianAtEvenPosition {
                // We need the average of the 2nd and 3rd values
                return (Double(secondValue) + Double(thirdValue)) / 2.0
            } else {
                return Double(secondValue)
            }
        }
        
        // Second, advance the pointers to the median position.
        var currentFirstIndex = 0
        var currentSecondIndex = 0
        var currentMedianValue = 0
        var nextMedianValue = min(nums1[0], nums2[0])
        
        for _ in 0...medianPosition {
            let firstNumber = nums1[currentFirstIndex]
            let secondNumber = nums2[currentSecondIndex]
            currentMedianValue = nextMedianValue
            let currentMax = max(firstNumber, secondNumber)
            
            if firstNumber <= secondNumber && currentFirstIndex < nums1.count - 1 {
                // The first number is <= the second, and we can advance the pointer.
                currentFirstIndex += 1
                nextMedianValue = min(currentMax, nums1[currentFirstIndex])
            } else if secondNumber <= firstNumber && currentSecondIndex < nums2.count - 1  {
                // The second number is <= the second, and we can advance the pointer.
                currentSecondIndex += 1
                nextMedianValue = min(currentMax, nums2[currentSecondIndex])
            } else if currentFirstIndex < nums1.count - 1 {
                // The first number isn't smaller, but it's the only pointer we can advance.
                currentFirstIndex += 1
                nextMedianValue = min(nums1[currentFirstIndex], currentMax)
            } else if currentSecondIndex < nums2.count - 1 {
                // The second number isn't smaller, but it's the only pointer we can advance.
                currentSecondIndex += 1
                nextMedianValue = min(currentMax, nums2[currentSecondIndex])
            }
        }
        
        // If it's odd, then we don't need to worry about averaging the medians; just return early.
        guard isMedianAtEvenPosition else {
            return Double(currentMedianValue)
        }
        
        return (Double(nextMedianValue) + Double(currentMedianValue)) / 2.0
    }
}

//MARK: Test Script

struct TestCase {
    let nums1: [Int]
    let nums2: [Int]
    let output: Double
}

let solution = Solution()

let testCases = [
    TestCase(nums1: [], nums2: [], output: 0.0),
    TestCase(nums1: [], nums2: [1, 2, 3], output: 2.0),
    TestCase(nums1: [], nums2: [1, 2, 3, 4], output: 2.5),
    TestCase(nums1: [1, 2, 3], nums2: [], output: 2.0),
    TestCase(nums1: [1, 2, 3, 4], nums2: [], output: 2.5),
    TestCase(nums1: [1], nums2: [2], output: 1.5),
    TestCase(nums1: [1, 2], nums2: [-1, 3], output: 1.5),
    TestCase(nums1: [1], nums2: [2, 3], output: 2.0),
    TestCase(nums1: [1, 3], nums2: [2], output: 2.0),
    TestCase(nums1: [1, 2], nums2: [3, 4], output: 2.5),
    TestCase(nums1: [1000], nums2: [1, 2, 3], output: 2.5),
    TestCase(nums1: [1, 2, 7, 8], nums2: [3, 4, 5, 6], output: 4.5),
    TestCase(nums1: [1, 1, 1, 1, 1, 1, 13], nums2: [1, 1, 1, 1, 1, 1, 578], output: 1.0),
    TestCase(nums1: [1], nums2: [2, 3, 4, 5], output: 3.0)
]

for testCase in testCases {
    let output = solution.findMedianSortedArrays(testCase.nums1, testCase.nums2)
    guard output == testCase.output else {
        print("FAILURE: Test case with nums1 \(testCase.nums1) and nums2 \(testCase.nums2) returned \(output). Expected output was \(testCase.output)")
        continue
    }
    
    print("Test case passed")
}
