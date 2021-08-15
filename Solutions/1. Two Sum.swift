/*
 Problem 1: Two Sum
 https://leetcode.com/problems/two-sum/
 */

class Solution1 {
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
