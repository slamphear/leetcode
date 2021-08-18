/*
 Problem 5: Longest Palindromic Substring
 https://leetcode.com/problems/longest-palindromic-substring/
 */

//MARK: Solution

struct IntRange {
    let start: Int
    let end: Int
    let length: Int
    
    init(_ start: Int, to end: Int) {
        self.start = start
        self.end = end
        self.length = end - start
    }
}

extension Array where Element == Character {
    func longestPalindromeWithCenterAtIndex(_ index: Int) -> IntRange {
        guard index < self.count - 1 else {
            return self.longestPalindromeWithCenterIndices(index, and: index)
        }
        
        let oddLengthPalindrome = self.longestPalindromeWithCenterIndices(index, and: index)
        let evenLengthPalindrome = self.longestPalindromeWithCenterIndices(index, and: index + 1)
        
        guard evenLengthPalindrome.length < oddLengthPalindrome.length else {
            return evenLengthPalindrome
        }
        
        return oddLengthPalindrome
    }
    
    private func longestPalindromeWithCenterIndices(_ startIndex: Int, and endIndex: Int) -> IntRange {
        var longestPalindrome = IntRange(startIndex, to: startIndex)
        var start = startIndex
        var end = endIndex
        
        while start >= 0 && end < self.count {
            guard self[start] == self[end] else { break }
            
            longestPalindrome = IntRange(start, to: end)
            
            //Prepare for next iteration.
            start -= 1
            end += 1
        }
        
        return longestPalindrome
    }
}

class Solution {
    func longestPalindrome(_ s: String) -> String {
        let characters = Array(s)
        
        //Trivial case: the given string is empty.
        guard !s.isEmpty else { return "" }
        
        //Declare variables and constants used while looping.
        var longestPalindromicSubstring = IntRange(0, to: 0)
        
        //Outermost loop: move the starting character forward, one character at a time.
        for index in 0..<characters.count {
            let longestPalindromeInThisSubstring = characters.longestPalindromeWithCenterAtIndex(index)
            
            if longestPalindromeInThisSubstring.length > longestPalindromicSubstring.length {
                longestPalindromicSubstring = longestPalindromeInThisSubstring
            }
        }
        
        return String(characters[longestPalindromicSubstring.start...longestPalindromicSubstring.end])
    }
}

//MARK: Test Script

struct TestCase {
    let s: String
    let output: String
}

let solution = Solution()

let testCases = [
    TestCase(s: "babad", output: "bab"),
    TestCase(s: "cbbd", output: "bb"),
    TestCase(s: "a", output: "a"),
    TestCase(s: "ac", output: "a"),
    TestCase(s: "bb", output: "bb"),
    TestCase(s: "aaaaa", output: "aaaaa"),
    TestCase(s: "eeeeeeeee", output: "eeeeeeeee"),
    TestCase(s: "zudfweormatjycujjirzjpyrmaxurectxrtqedmmgergwdvjmjtstdhcihacqnothgttgqfywcpgnuvwglvfiuxteopoyizgehkwuvvkqxbnufkcbodlhdmbqyghkojrgokpwdhtdrwmvdegwycecrgjvuexlguayzcammupgeskrvpthrmwqaqsdcgycdupykppiyhwzwcplivjnnvwhqkkxildtyjltklcokcrgqnnwzzeuqioyahqpuskkpbxhvzvqyhlegmoviogzwuiqahiouhnecjwysmtarjjdjqdrkljawzasriouuiqkcwwqsxifbndjmyprdozhwaoibpqrthpcjphgsfbeqrqqoqiqqdicvybzxhklehzzapbvcyleljawowluqgxxwlrymzojshlwkmzwpixgfjljkmwdtjeabgyrpbqyyykmoaqdambpkyyvukalbrzoyoufjqeftniddsfqnilxlplselqatdgjziphvrbokofvuerpsvqmzakbyzxtxvyanvjpfyvyiivqusfrsufjanmfibgrkwtiuoykiavpbqeyfsuteuxxjiyxvlvgmehycdvxdorpepmsinvmyzeqeiikajopqedyopirmhymozernxzaueljjrhcsofwyddkpnvcvzixdjknikyhzmstvbducjcoyoeoaqruuewclzqqqxzpgykrkygxnmlsrjudoaejxkipkgmcoqtxhelvsizgdwdyjwuumazxfstoaxeqqxoqezakdqjwpkrbldpcbbxexquqrznavcrprnydufsidakvrpuzgfisdxreldbqfizngtrilnbqboxwmwienlkmmiuifrvytukcqcpeqdwwucymgvyrektsnfijdcdoawbcwkkjkqwzffnuqituihjaklvthulmcjrhqcyzvekzqlxgddjoir", output: "gykrkyg")
]

for testCase in testCases {
    guard solution.longestPalindrome(testCase.s) == testCase.output else {
        print("FAILURE: Test case \"\(testCase.s)\" returned \"\(solution.longestPalindrome(testCase.s))\". Expected output was \"\(testCase.output)\".")
        continue
    }
    
    print("Test case passed")
}
