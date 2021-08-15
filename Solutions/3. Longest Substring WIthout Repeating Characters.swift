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
                previousCharacters = previousCharacters.filter { $0.value <= previousIndex }
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

func runTests() {
    let solution = Solution()
    print(solution.lengthOfLongestSubstring(" ")) // print 1
    print(solution.lengthOfLongestSubstring("dvdf")) // print 3
    print(solution.lengthOfLongestSubstring("pwwkew")) // print 3
    print(solution.lengthOfLongestSubstring("abcabcabcdabc"))
}

runTests()
