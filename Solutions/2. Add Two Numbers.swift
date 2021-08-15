/*
 Problem 2: Add Two Numbers
 https://leetcode.com/problems/add-two-numbers/
 */

//MARK: Solution

class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
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

//MARK: Test Script

extension ListNode {
    static func fromIntArray(_ array: [Int]) -> ListNode? {
        var node: ListNode? = nil
        
        for int in array.reversed() {
            node = ListNode(int, node)
        }
        
        return node
    }

    func toIntArray() -> [Int] {
        var array = [Int]()
        var node: ListNode? = self
        
        while let unwrappedNode = node {
            array.append(unwrappedNode.val)
            node = unwrappedNode.next
        }

        return array
    }
}

extension ListNode: Equatable {
    static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        lhs.val == rhs.val && lhs.next == rhs.next
    }
}

struct TestCase {
    let l1: ListNode?
    let l2: ListNode?
    let output: ListNode?
    
    init(l1: [Int], l2: [Int], output: [Int]) {
        self.l1 = ListNode.fromIntArray(l1)
        self.l2 = ListNode.fromIntArray(l2)
        self.output = ListNode.fromIntArray(output)
    }
}

let solution = Solution()

let testCases = [
    TestCase(l1: [2, 4, 3], l2: [5, 6, 4], output: [7, 0, 8]),
    TestCase(l1: [0], l2: [0], output: [0]),
    TestCase(l1: [9, 9, 9, 9, 9, 9, 9], l2: [9, 9, 9, 9], output: [8, 9, 9, 9, 0, 0, 0, 1])
]

for testCase in testCases {
    guard solution.addTwoNumbers(testCase.l1, testCase.l2) == testCase.output else {
        let l1 = testCase.l1?.toIntArray() ?? []
        let l2 = testCase.l2?.toIntArray() ?? []
        let output = solution.addTwoNumbers(testCase.l1, testCase.l2)?.toIntArray() ?? []
        let expectedOutput = testCase.output?.toIntArray() ?? []
        
        print("FAILURE: Test case with l1 \(l1) and l2 \(l2) returned \(output). Expected output was \(expectedOutput)")
        continue
    }
    
    print("Test case passed")
}
