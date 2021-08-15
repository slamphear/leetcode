/*
 Problem 2: Add Two Numbers
 https://leetcode.com/problems/add-two-numbers/
 */

class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution2 {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var currentFirstNode = l1
        var currentSecondNode = l2
        var carryOver = 0
        var returnValues = [Int]()
        var returnListNode: ListNode?

        // Loop until both nodes are nil and there's nothing to carry over.
        while currentFirstNode != nil || currentSecondNode != nil || carryOver > 0 {
            var nextVal = (currentFirstNode?.val ?? 0) + (currentSecondNode?.val ?? 0) + carryOver

            currentFirstNode = currentFirstNode?.next
            currentSecondNode = currentSecondNode?.next
            carryOver = 0

            if nextVal >= 10 {
                carryOver = 1
                nextVal -= 10
            }

            returnValues.append(nextVal)
        }

        for value in returnValues.reversed() {
            returnListNode = ListNode(value, returnListNode)
        }

        return returnListNode
    }
}

extension ListNode {
    public init(array: [Int]) {
        
    }
}

//struct AddTwoNumbersExample {
//    let firstList: ListNode
//    let secondList: ListNode
//}
//
//let testCases = [
//    AddTwoNumbersExample(firstList: <#T##ListNode#>, secondList: <#T##ListNode#>),
//    TwoSumExample(nums: [3, 2, 4], target: 6),
//    TwoSumExample(nums: [3, 3], target: 6)
//]
//
//func runTests() {
//    let solution = Solution()
//
//    for x in testCases {
//        print("Numbers: \(x.nums), target: \(x.target), output: \(solution.twoSum(x.nums, x.target))")
//    }
//}
//
//runTests()
