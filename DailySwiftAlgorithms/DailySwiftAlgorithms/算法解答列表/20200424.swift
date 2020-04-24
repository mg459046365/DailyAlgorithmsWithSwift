//
//  20200424.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/4/25.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

class Solution_20200424 {
    // 题目：输入一个矩阵，按照从外向里以顺时针的顺序依次打印出每一个数字。
//
//    示例 1：
//    输入：matrix = [[1,2,3],[4,5,6],[7,8,9]]
//    输出：[1,2,3,6,9,8,7,4,5]

//    示例 2：
//    输入：matrix = [[1,2,3,4],[5,6,7,8],[9,10,11,12]]
//    输出：[1,2,3,4,8,12,11,10,9,5,6,7]

    /// 使用for循环
    class func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        guard !matrix.isEmpty else { return [] }
        if matrix.count == 1 {
            return matrix[0]
        }
        if matrix.count == 2 {
            return matrix[0] + matrix[1].reversed()
        }
        var list = [Int]()
        var top = 0
        var bottom = matrix.count - 1
        var left = 0
        var right = matrix[0].count - 1
        while top < bottom, left < right {
            // 最上面
            list.append(contentsOf: matrix[top][left ... right])
            // 右边的列
            if top + 2 < bottom {
                for i in top + 1 ..< bottom {
                    list.append(matrix[i][right])
                }
            } else if top + 2 == bottom {
                list.append(matrix[top + 1][right])
            }
            // 底部
            list.append(contentsOf: matrix[bottom][left ... right].reversed())
            if top + 2 < bottom {
                // 左边的列
                for i in (top + 1 ..< bottom).reversed() {
                    list.append(matrix[i][left])
                }
            } else if top + 2 == bottom {
                list.append(matrix[top + 1][left])
            }
            top += 1
            bottom -= 1
            left += 1
            right -= 1
        }
        if left == right, top == bottom {
            list.append(matrix[top][left])
        } else if left == right {
            if top < bottom {
                for i in top ... bottom {
                    list.append(matrix[i][left])
                }
            }
        } else if top == bottom {
            if left < right {
                list.append(contentsOf: matrix[top][left ... right])
            }
        }
        return list
    }

    class func test() {
        // 测试用例
        // [1, 2, 3, 6, 9, 8, 7, 4, 5]
        let list = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

        // [1, 2, 3, 4, 8, 12, 11, 10, 9, 5, 6, 7]
        let list2 = [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]]

        // [1, 2, 3, 6, 9, 12, 11, 10, 7, 4, 5, 8]
        let list3 = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10, 11, 12]]
        // [1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5, 6, 7, 11, 10]
        let list4 = [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16]]
        let res = spiralOrder(list4)
        print("展开结果=\(res)")
    }
}
