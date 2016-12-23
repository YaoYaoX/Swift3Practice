//
//  SpellWordController.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 16/12/19.
//  Copyright © 2016年 YY. All rights reserved.
//

import UIKit
import GameKit

class SpellWordController: UITableViewController {

    var allWords = [String]()
    var usedWorlds = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSpell))
        
        if var filePath = Bundle.main.path(forResource: "SpellWord", ofType: ".bundle") {
            filePath += "/start.txt"
            if let startString = try? String(contentsOfFile: filePath) {
                allWords = startString.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["leiapbnsh"]
        }
        
        startSpell()
        
        blockNote()
    }
    
    func startSpell() {
        allWords = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allWords) as! [String]
        title = allWords[0]
        usedWorlds.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    func addSpell() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAct = UIAlertAction(title: "Submit", style: .default) { [unowned self, ac] action in
            self.submit(newWord: ac.textFields![0].text!)
        }
        
        ac.addAction(submitAct)
        present(ac, animated: true, completion: nil)
    }
    
    func submit(newWord: String) {
        let answer = newWord.lowercased()
        
        var errorTitle = ""
        var errorMsg = ""
        
        if isPossible(word: answer) {
            if isOriginal(word: answer) {
                if isReal(word: answer) {
                    usedWorlds.insert(answer, at: 0)
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    return
                } else {
                    errorTitle = "拼错"
                    errorMsg = "没这个词"
                }
            } else {
                errorTitle = "重复"
                errorMsg = "词已存在"
            }
        } else {
            errorTitle = "不可以"
            errorMsg = "包含未定义字符"
        }
        
        let ac = UIAlertController(title: errorTitle, message: errorMsg, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    func isPossible(word: String) -> Bool {
        // 是否包含不存在的字符
        var tempAnswer = title!
        for letter in word.lowercased().characters {
            if let exist = tempAnswer.range(of: String(letter)) {
                tempAnswer.remove(at: exist.lowerBound)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        // 是否已经存在
        return !usedWorlds.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        // 单词是否存在
        let checker = UITextChecker()
        let range = NSMakeRange(0, word.utf16.count)
        let miss = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return miss.location == NSNotFound
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWorlds.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "SpellWordCell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "SpellWordCell")
        }
        cell?.textLabel?.text = usedWorlds[indexPath.row]
        
        return cell!
    }
    
    func blockNote() {
        
        var array = [3,0,2,5,7,4,6,3,1,8]
        
        // 0. blocks是引用类型
        // 1. 直接传递方法名，方法也即是带名字的block
        array.sort(by: sortFunc)
        
        // 2. 传递block
        // block语法:in用于分隔定义与实现
        // { (parm1: Type1, parm2: Type2...) -> return returnType in
        //    statements
        // }
        array.sort(by: { (num1: Int, num2: Int) -> Bool in
            return num1 > num2
        })
        
        // 3. 从上下文判断类型：省略参数/返回值类型
        array.sort(by: {num1,num2 in return num1 > num2})
        
        // 4. 单行表达式隐含return，可省略
        array.sort(by: {num1,num2 in num1 > num2})
        
        // 5. 简短参数，$0、$1,$2,$3...代替第一个、第二个...参数，只留执行提，其他可省略
        array.sort(by: {$0 > $1})
        
        // 6. 更简短：Operator Methods，全省略，只留一个运算符
        array.sort(by: > )
        
        // 7.Trailing Closures
        // 当方法的最后一个参数为block时，可直接将block参数放在方法体后面
        testBLockParam(num1: 1, num2: 2, block1: sortFunc){ value1 in return value1 > 5 }
        
        // 8. Trailing Closures
        // 当方法的唯一参数是block时，()可省略
        testOneBLockParam{ value1 in return value1 > 5 }
        
        // 9. Escaping Closures
        // 当传入方法的block参数在方法执行完后才会调用时，需要在block类型前添加@escaping
        // 典型使用场景：异步执行后的回调
        // 带@escaping的block引用self的成员时，需明确调用 self.成员，不可省略self;不带@escaping的block则可以
        let instance = SomeClass()
        instance.doSomething()
        print(instance.x)
        // Prints "200"
        
        completionHandlers.first?()
        print(instance.x)
        // Prints "100”
        
        
        
        // 10. Capture list：解决循环强引用
        // 语法: 将会被引用的let、var置于[]中，并用unowned、weak修饰
        // weak对象一定是可选类型，当对象释放时会被自动置为nil
        // { [unowned instance, weak weakInstance = instance] (parm1: Type1, parm2: Type2...) -> return returnType in
        //    statements
        // }
        
        
        
    }
    
    func sortFunc(num1: Int , num2: Int) -> Bool {
        return num1 > num2
    }
    
    
    func testBLockParam(num1: Int , num2: Int, block1: (Int, Int)->Bool, block2: (Int)->Bool) -> Void {
        
    }
    
    func testOneBLockParam(block1: (Int)->Bool) -> Void {
        
    }
}

var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    
    var x = 10
    
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
    
}
