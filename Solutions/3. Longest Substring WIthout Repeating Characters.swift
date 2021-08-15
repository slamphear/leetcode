/*
 Problem 3: Longest Substring Without Repeating Characters
 https://leetcode.com/problems/longest-substring-without-repeating-characters/
 */

//MARK: Solution

class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var currentSubstringLength = 0
        var maxSubstringLength = 0
        var previousCharacters = [Character:Int]() // [character in string : index of that character]
        
        for (index, character) in s.enumerated() {
            if let previousIndex = previousCharacters[character] {
                previousCharacters = previousCharacters.filter { $0.value > previousIndex }
                currentSubstringLength = previousCharacters.count
            }
            
            currentSubstringLength += 1
            
            if currentSubstringLength > maxSubstringLength {
                maxSubstringLength = currentSubstringLength
            }
            
            previousCharacters[character] = index
        }
        
        return maxSubstringLength
    }
}

//MARK: Test Script

struct TestCase {
    let s: String
    let output: Int
}

let solution = Solution()

let testCases = [
    TestCase(s: "abcabcbb", output: 3),
    TestCase(s: "bbbbb", output: 1),
    TestCase(s: "pwwkew", output: 3),
    TestCase(s: "", output: 0),
    TestCase(s: " ", output: 1),
    TestCase(s: "dvdf", output: 3),
    TestCase(s: "pwwkew", output: 3)
]

for testCase in testCases {
    guard solution.lengthOfLongestSubstring(testCase.s) == testCase.output else {
        print("FAILURE: Test case \(testCase.s) returned \(solution.lengthOfLongestSubstring(testCase.s)). Expected output was \(testCase.output)")
        continue
    }
    
    print("Test case passed")
}
