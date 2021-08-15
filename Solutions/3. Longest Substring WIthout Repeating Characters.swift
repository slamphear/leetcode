/*
 Problem 3: Longest Substring Without Repeating Characters
 https://leetcode.com/problems/longest-substring-without-repeating-characters/
 */

class Solution3 {
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

//TODO: Clean up tests

//print(lengthOfLongestSubstring(" ")) // print 1
//print(lengthOfLongestSubstring("dvdf")) // print 3
//print(lengthOfLongestSubstring("pwwkew")) // print 3
//print(lengthOfLongestSubstring("abcabcabcdabc"))
