class Solution {
    func romanToInt(_ s: String) -> Int {
        var total = 0

        for index in Array(s.indices) {
            print("index \(index)")
        }
    }
}


let testCases = [
    "I",
    "III",
    "IV",
    "V",
    "IX",
    "LVIII",
    "MCMXCIV"
]

func runTests() {
    let solution = Solution()

    for x in testCases {
        print("\(x) is the Roman numeral for \(solution.romanToInt(x))")
    }
}


runTests()
