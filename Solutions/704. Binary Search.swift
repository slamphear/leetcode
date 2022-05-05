/*
 Problem 704: Binary Search
 https://leetcode.com/problems/binary-search/
 */

//MARK: Solution

class Solution {
    // Save off nums and target at the class level so that they don't get recreated at each level of recursion.
    private var nums: [Int] = []
    private var target = 0

    func search(_ nums: [Int], _ target: Int) -> Int {
        // Edge case: nums is empty
        guard !nums.isEmpty else {
            return -1
        }

        // Edge case: nums only has one value
        guard nums.count > 1 else {
            return nums[0] == target ? 0 : -1
        }

        self.nums = nums
        self.target = target
        
        return findTargetRecursively(startIndex: 0, endIndex: nums.count - 1) ?? -1
    }

    func findTargetRecursively(startIndex: Int, endIndex: Int) -> Int? {
        // Base case: start and end are the same
        guard endIndex != startIndex else {
            return nums[endIndex] == target ? endIndex : nil
        }

        // Base case: target is not in range
        guard nums[startIndex] <= target, nums[endIndex] >= target else {
            return nil
        }

        let medianIndex = startIndex + ((endIndex - startIndex) / 2)
        let medianValue = nums[medianIndex]
        
        // Optimization: quit early if the median is the target
        guard medianValue != target else {
            return medianIndex
        }

        // Prepare for next loop
        let nextStartIndex: Int
        let nextEndIndex: Int

        if medianValue > target {
            nextStartIndex = startIndex
            nextEndIndex = medianIndex > 0 ? medianIndex - 1 : medianIndex
        } else {
            nextStartIndex = medianIndex < nums.count - 1 ? medianIndex + 1 : medianIndex
            nextEndIndex = endIndex
        }

        return findTargetRecursively(startIndex: nextStartIndex, endIndex: nextEndIndex)
    }
}

//MARK: Test Script

struct TestCase {
    let nums: [Int]
    let target: Int
    let output: Int
}

let solution = Solution()

let testCases = [
    TestCase(nums: [-1,0,3,5,9,12], target: 9, output: 4),
    TestCase(nums: [-1,0,3,5,9,12], target: 2, output: -1),
    TestCase(nums: [-1], target: -1, output: 0),
    TestCase(nums: [-1,0], target: 0, output: 1),
    TestCase(nums: [], target: 2, output: -1)
]

for testCase in testCases {
    let output = solution.search(testCase.nums, testCase.target)
    guard output == testCase.output else {
        print("FAILURE: Test case with nums \(testCase.nums) and target \(testCase.target) returned \(output). Expected output was \(testCase.output)")
        continue
    }
    
    print("Test case passed")
}
