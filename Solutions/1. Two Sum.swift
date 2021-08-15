/*
 Problem 1: Two Sum
 https://leetcode.com/problems/two-sum/
 */

//MARK: Solution

class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var complements = [Int:Int]()

        for currentIndex in nums.indices {
            let currentNumber = nums[currentIndex]
            let complement = target - currentNumber
            if let indexWhereThisIsAComplement = complements[currentNumber] {
                return [indexWhereThisIsAComplement, currentIndex]
            }
            complements[complement] = currentIndex
        }
        return []
    }
}

//MARK: Test Script

struct TestCase {
    let nums: [Int]
    let target: Int
    let output: [Int]
}

let solution = Solution()

let testCases = [
    TestCase(nums: [2, 7, 11, 15], target: 9, output: [0, 1]),
    TestCase(nums: [3, 2, 4], target: 6, output: [1, 2]),
    TestCase(nums: [3, 3], target: 6, output: [0, 1])
]

for testCase in testCases {
    guard solution.twoSum(testCase.nums, testCase.target) == testCase.output else {
        print("FAILURE: Test case with nums \(testCase.nums) and target \(testCase.target) returned \(solution.twoSum(testCase.nums, testCase.target)). Expected output was \(testCase.output)")
        continue
    }
    
    print("Test case passed")
}
