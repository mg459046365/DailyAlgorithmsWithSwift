//
//  EnumTest.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/4/9.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

enum TestEnum0 {
    case test
}

enum TestEnum {
    case test
    case test1
}

enum TestEnum1 {
    case test1(Int, Int, Int)
    case test2(Int, Int)
    case test3(Int, String)
    case test4(Bool)
    case test5(String, String)
    case test6(Int, Bool)
    case test7(String, Bool)
    case test8
}

enum TestEnum2 {
    case test(Int, Bool)
    case test1
}

enum TestEnum3 {
    case test(String)
}

class EnumTest {
    // 分别通过MemoryLayout.size(ofValue:t1)实例大小、MemoryLayout.stride(ofValue:t1)实际分配的内存大小
    // MemoryLayout.alignment(ofValue:t1)对齐、UnsafeMutablePointer(&t1)地址，获取相关信息

    // 得到t0的size=0, stride = 1, alignment = 1
    var t0 = TestEnum0.test
    // 得到t0的size=1, stride = 1, alignment = 1
    var tt = TestEnum.test1

    // 得到t1-t8所有的size=33, stride = 40, alignment = 8, 地址均不同
    var t1 = TestEnum1.test1(1, 2, 3)
    var t2 = TestEnum1.test2(4, 5)
    var t3 = TestEnum1.test3(6, "str")
    var t4 = TestEnum1.test4(true)
    var t5 = TestEnum1.test5("hello", "world")
    var t6 = TestEnum1.test6(7, false)
    var t7 = TestEnum1.test7("hello", true)
    var t8 = TestEnum1.test8

    // 得到t9所有的size=9, stride = 16, alignment = 8
    var t9 = TestEnum2.test1
    // 得到t10所有的size=16, stride = 16, alignment = 8
    var t10 = TestEnum3.test("hello")

    // TestEnum0没有关联值，只有一个case,size = 0，由于对齐是1，所以实际分配了1个字节stride=1
    // TestEnum没有关联值，有两个case，size = 1，由于对齐是1，所以实际分配了1个字节stride=1
    // TestEnum1有关联值，关联值占用最大字节为TestEnum1.test5关联了两个字符串,一个字符串16个字节，16+16+1 = 33,size=33,由于对齐是8，则必须是8的倍数，所以实际分配了40个字节，stride=40
    // TestEnum2有关联值，BOOL占1个字节，int占8个字节，所以size=9,由于对齐是8，所以stride=16
    // TestEnum3有关联值，string占16个字节，size=16,对齐是8，所以stride=8

    // 注：
    // 1.枚举所需要的内存就是存储关联值所需要的字节数(取每个位上面占用最多的字节一定是占用最多的那条case，任何一个case 的关连值都共用这几个字节)的和加上成员值(1个字节，有一个字节存储成员值,用于区分哪一个成员值)所需要的字节数。
    // 2.在没有原始值和关联值的情况下，枚举在内存中占1个字节且所占内存的大小不受原始值影响
    // 3.特别说明：关联值(Associated Values)将枚举的成员值跟其他类型的值关联存储在一起
    // 4.原始值(rawValue)不占用枚举变量的内存。原始值以计算属性的方式存在枚举中，调用rawValue属性会通过switch的方式返回相应的原始值。
    // 5.特别注意：如果一个枚举里面只有一个case，并且没有关联值，那么它实际占用的内存为0个字节，系统会分配一个字节，
    // 字节对齐也是一个字节(因为只要有就知道是他，所以不需要浪费额外的内存再去存储了)
    // 6.关联值会保存在枚举的内存中，影响着枚举所占内存的大小。说到这里我们也可以明白为什么枚举不能定义存储属性了，因为枚举中一旦保存存储属性会和枚举的关联值产生歧义。
    // 7.第一个case为内存存储为0，每个case内存存储的值依次累加1(按照case是顺序)，
    // 类似于数组中的索引，每个case对应内存中存储的值是case出现的索引值，第一个case索引为0。
    // 说明枚举范围也就是0x00-0xFF共256个case
    
    // 特别说明第1点和第2点，结合第6第7点，可以借助汇编查看内存存储的数据
    // 根据第一点，TestEnum2的size应该是8(Int所占字节)+1(Bool所占字节)+1(成员值所占字节) = 10，但是输出size却是9。
    // 同TestEnum3，根据第一点结论size应该是16+1=17才对，求出size却是16.
    
    
    //TODO: 待再次研究，确认，先搁置这里。以上结论不全对。
}
