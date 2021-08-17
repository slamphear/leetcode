/*
 Problem 5: Longest Palindromic Substring
 https://leetcode.com/problems/longest-palindromic-substring/
 
 This solution is a work in progress. All known test cases have passed, but this submission exceeded the time limit when given the following input (which has been included below as a test case):
 "zudfweormatjycujjirzjpyrmaxurectxrtqedmmgergwdvjmjtstdhcihacqnothgttgqfywcpgnuvwglvfiuxteopoyizgehkwuvvkqxbnufkcbodlhdmbqyghkojrgokpwdhtdrwmvdegwycecrgjvuexlguayzcammupgeskrvpthrmwqaqsdcgycdupykppiyhwzwcplivjnnvwhqkkxildtyjltklcokcrgqnnwzzeuqioyahqpuskkpbxhvzvqyhlegmoviogzwuiqahiouhnecjwysmtarjjdjqdrkljawzasriouuiqkcwwqsxifbndjmyprdozhwaoibpqrthpcjphgsfbeqrqqoqiqqdicvybzxhklehzzapbvcyleljawowluqgxxwlrymzojshlwkmzwpixgfjljkmwdtjeabgyrpbqyyykmoaqdambpkyyvukalbrzoyoufjqeftniddsfqnilxlplselqatdgjziphvrbokofvuerpsvqmzakbyzxtxvyanvjpfyvyiivqusfrsufjanmfibgrkwtiuoykiavpbqeyfsuteuxxjiyxvlvgmehycdvxdorpepmsinvmyzeqeiikajopqedyopirmhymozernxzaueljjrhcsofwyddkpnvcvzixdjknikyhzmstvbducjcoyoeoaqruuewclzqqqxzpgykrkygxnmlsrjudoaejxkipkgmcoqtxhelvsizgdwdyjwuumazxfstoaxeqqxoqezakdqjwpkrbldpcbbxexquqrznavcrprnydufsidakvrpuzgfisdxreldbqfizngtrilnbqboxwmwienlkmmiuifrvytukcqcpeqdwwucymgvyrektsnfijdcdoawbcwkkjkqwzffnuqituihjaklvthulmcjrhqcyzvekzqlxgddjoir"
 
 I'll need to figure out a way to get this to work in O(1) time. I think the way to do this is to actually reverse the given string and find the longest common subsequence between the given string and the reversed one.
 */

//MARK: Solution

class Solution {
    private var currentSubstring = ""
    
    func longestPalindrome(_ s: String) -> String {
        //Trivial case: the given string is empty.
        guard let firstCharacter = s.first else { return "" }
        
        var longestPalindromicSubstring = String(firstCharacter)
        
        //Outermost loop: move the starting character forward, one character at a time.
        for index in s.indices {
            guard index != s.indices.last else { break }
            
            let substring = String(s.suffix(from: index))
            
            guard substring.count > longestPalindromicSubstring.count else {
                // Optimization: At this point, no substring can be longer than the one we've already found, so quit early.
                break
            }
            
            let longestPalindromeInThisSubstring = self.longestPalindromeStartingFromFirstCharacter(in: substring)
            
            if longestPalindromeInThisSubstring.count > longestPalindromicSubstring.count {
                longestPalindromicSubstring = longestPalindromeInThisSubstring
            }
        }
        
        return longestPalindromicSubstring
    }
    
    private func longestPalindromeStartingFromFirstCharacter(in string: String) -> String {
        //Trivial case 1: the given string is empty.
        guard let firstCharacter = string.first else { return "" }
        
        //Trivial case 2: the entire string is a palindrome.
        self.currentSubstring = string
        guard !self.isCurrentSubstringAPalindrome() else { return string }
        
        //Trivial case 3: the first character never reappears.
        let firstCharacterIndex = string.indices.first
        guard var lastOccurrenceOfFirstCharacter = string.lastIndex(of: firstCharacter), lastOccurrenceOfFirstCharacter != firstCharacterIndex else {
            return String(firstCharacter)
        }
        
        //Now that trivial cases are handled, iterate through the string.
        var longestPalindromicSubstring = String(describing: firstCharacter)
        
        while lastOccurrenceOfFirstCharacter != firstCharacterIndex {
            let substring = String(string.prefix(through: lastOccurrenceOfFirstCharacter))
            self.currentSubstring = substring
            
            guard substring.count > longestPalindromicSubstring.count else {
                break
            }
            
            guard !self.isCurrentSubstringAPalindrome() else {
                longestPalindromicSubstring = substring
                break
            }
            
            //Prepare for next iteration.
            guard let lastOccurrenceInSubstring = substring.dropLast().lastIndex(of: firstCharacter) else {
                fatalError("The first character cannot be found in this substring, even though it's the first character in it!")
            }
            
            lastOccurrenceOfFirstCharacter = lastOccurrenceInSubstring
        }
        
        return longestPalindromicSubstring
    }
    
    private func isCurrentSubstringAPalindrome() -> Bool {
        //Base case: we got all the way to a middle character (or there is no middle character)
        guard self.currentSubstring.count > 1 else { return true }
        
        //Step 1: Extract the first and last digits
        let firstDigit = self.currentSubstring.removeFirst()
        let lastDigit = self.currentSubstring.removeLast()
        
        //Step 2: Return false if the first and last digits don't match
        guard firstDigit == lastDigit else { return false }
        
        //Step 3: Recurse
        return self.isCurrentSubstringAPalindrome()
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
    TestCase(s: "zudfweormatjycujjirzjpyrmaxurectxrtqedmmgergwdvjmjtstdhcihacqnothgttgqfywcpgnuvwglvfiuxteopoyizgehkwuvvkqxbnufkcbodlhdmbqyghkojrgokpwdhtdrwmvdegwycecrgjvuexlguayzcammupgeskrvpthrmwqaqsdcgycdupykppiyhwzwcplivjnnvwhqkkxildtyjltklcokcrgqnnwzzeuqioyahqpuskkpbxhvzvqyhlegmoviogzwuiqahiouhnecjwysmtarjjdjqdrkljawzasriouuiqkcwwqsxifbndjmyprdozhwaoibpqrthpcjphgsfbeqrqqoqiqqdicvybzxhklehzzapbvcyleljawowluqgxxwlrymzojshlwkmzwpixgfjljkmwdtjeabgyrpbqyyykmoaqdambpkyyvukalbrzoyoufjqeftniddsfqnilxlplselqatdgjziphvrbokofvuerpsvqmzakbyzxtxvyanvjpfyvyiivqusfrsufjanmfibgrkwtiuoykiavpbqeyfsuteuxxjiyxvlvgmehycdvxdorpepmsinvmyzeqeiikajopqedyopirmhymozernxzaueljjrhcsofwyddkpnvcvzixdjknikyhzmstvbducjcoyoeoaqruuewclzqqqxzpgykrkygxnmlsrjudoaejxkipkgmcoqtxhelvsizgdwdyjwuumazxfstoaxeqqxoqezakdqjwpkrbldpcbbxexquqrznavcrprnydufsidakvrpuzgfisdxreldbqfizngtrilnbqboxwmwienlkmmiuifrvytukcqcpeqdwwucymgvyrektsnfijdcdoawbcwkkjkqwzffnuqituihjaklvthulmcjrhqcyzvekzqlxgddjoir", output: "gykrkyg")
]

for testCase in testCases {
    guard solution.longestPalindrome(testCase.s) == testCase.output else {
        print("FAILURE: Test case \"\(testCase.s)\" returned \"\(solution.longestPalindrome(testCase.s))\". Expected output was \"\(testCase.output)\".")
        continue
    }
    
    print("Test case passed")
}
