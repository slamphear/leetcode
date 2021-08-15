/*
 Problem 4: Median of Two Sorted Arrays
 https://leetcode.com/problems/median-of-two-sorted-arrays/
 
 This solution is a work in progress.
 An example of where this fails is the following:
 Input: [1] [2,3,4,5]
 Output: 1.00000
 Expected: 3.00000
 */

//MARK: Solution

class Solution {
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        let isMedianAtEvenPosition = (nums1.count + nums2.count) % 2 == 0
        var currentFirstIndex = 0
        var currentSecondIndex = 0
        
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
        } else if medianPosition == 1 {
            // Trivial case 4: This is less trivial, but we don't need to advance pointers here.
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
        for _ in 0..<medianPosition {
            let firstNumber = nums1[currentFirstIndex]
            let secondNumber = nums2[currentSecondIndex]
            
            if (firstNumber < secondNumber) && (currentFirstIndex < nums1.count - 1) {
                currentFirstIndex += 1
            } else if currentSecondIndex < nums2.count - 1  {
                currentSecondIndex += 1
            }
        }
        
        let valueAtMedianPosition = min(nums1[currentFirstIndex], nums2[currentSecondIndex])
        
        // If it's odd, then we don't need to worry about finding a co-median; just return early.
        if !isMedianAtEvenPosition {
            return Double(valueAtMedianPosition)
        }
        
        // If we get here, it's even; find the co-median.
        var coMedian = 0
        
        if (currentFirstIndex == nums1.count - 1) && (currentSecondIndex == nums2.count - 1) {
            // Should only get here if both arrays only have 1 element each. Since we got the min for the valueAtMedianPosition, get the max for the coMedian.
            coMedian = max(nums1[currentFirstIndex], nums2[currentSecondIndex])
        } else if currentFirstIndex == nums1.count - 1 {
            // First array is at its end. We know that median is the min of nums1[currentFirstIndex] and nums2[currentSecondIndex]
            // so we want the next one that would have been selected. This could be one of three things:
            //   1. nums1[currentFirstIndex] (the last element in this array)
            //   2. nums2[currentSecondIndex] (the current pointer in the nums2 array - we'd want this if the median was nums1[currentFirstIndex])
            //   3. nums2[currentSecondIndex + 1] (if the median was nums2[currentSecondIndex] but this value is still smaller than nums1[currentFirstIndex])
            // Basically, we need to choose the median between these three options. We can do this by taking the min of the two maxes between 1 and 2 and between 1 and 3.
            // (don't need to compare 2 and 3 because we know they're in order)
            coMedian = min(max(nums1[currentFirstIndex], nums2[currentSecondIndex]), nums2[currentSecondIndex + 1])
        } else if currentSecondIndex == nums2.count - 1 {
            // Same as above, just flipped because the second array is the one that's at its end.
            coMedian = min(max(nums1[currentFirstIndex], nums2[currentSecondIndex]), nums1[currentFirstIndex + 1])
        } else {
            // Now we're concerned about 4 values: both current indices, plus both next ones. This gets easier if we just figure out which
            // one was already selected as the median; then we can just choose the next-lowest number.
            if nums1[currentFirstIndex] < nums2[currentSecondIndex] {
                // We know nums1[currentFirstIndex] is the median
                coMedian = min(nums1[currentFirstIndex + 1], nums2[currentSecondIndex])
            } else {
                // Either nums2[currentSecondIndex] is the median or nums1[currentFirstIndex] == nums2[currentSecondIndex]
                coMedian = min(nums1[currentFirstIndex], nums2[currentSecondIndex + 1])
            }
        }
        return (Double(valueAtMedianPosition) + Double(coMedian)) / 2.0
    }
}

//MARK: Test Script

struct TestCase {
    let nums1: [Int]
    let nums2: [Int]
    let output: Double
}

func runTests() {
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
        guard solution.findMedianSortedArrays(testCase.nums1, testCase.nums2) == testCase.output else {
            print("FAILURE: Test case with nums1 \(testCase.nums1) and nums2 \(testCase.nums2) returned \(solution.findMedianSortedArrays(testCase.nums1, testCase.nums2)). Expected output was \(testCase.output)")
            continue
        }
        
        print("Test case passed")
    }
}

runTests()
