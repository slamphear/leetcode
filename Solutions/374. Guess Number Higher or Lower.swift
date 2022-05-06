/*
 Problem 374: Guess Number Higher or Lower
 https://leetcode.com/problems/guess-number-higher-or-lower/
 */

/** 
 * Forward declaration of guess API.
 * @param  num -> your guess number
 * @return 	     -1 if num is higher than the picked number
 *			      1 if num is lower than the picked number
 *               otherwise return 0 
 * func guess(_ num: Int) -> Int 
 */

class Solution : GuessGame {
    private let tooHigh = -1 // num > pick
    private let tooLow = 1 // num < pick
    private let equal = 0 // num == pick

    func guessNumber(_ n: Int) -> Int {
        guessNumberRecursively(from: 0, to: n)
    }

    func guessNumberRecursively(from rangeStart: Int, to rangeEnd: Int) -> Int {
        let medianValue = rangeStart + ((rangeEnd - rangeStart) / 2)
        let guessResult = guess(medianValue)

        // Edge case: avoid an infinite loop when only two values are left
        if rangeStart+1 == rangeEnd && guessResult == tooLow {
            return rangeEnd
        }

        switch guessResult {
            case tooHigh: return guessNumberRecursively(from: rangeStart, to: medianValue)
            case tooLow: return guessNumberRecursively(from: medianValue, to: rangeEnd)
            case equal: return medianValue
            default: fatalError("Invalid value returned from guess API")
        }
    }
}