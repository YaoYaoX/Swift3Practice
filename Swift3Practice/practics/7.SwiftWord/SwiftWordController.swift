//
//  SwiftWordController.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 16/12/23.
//  Copyright © 2016年 YY. All rights reserved.
//

import UIKit
import GameKit

class SwiftWordController: UIViewController {
    
    @IBOutlet weak var lettersView: UIView!
    @IBOutlet weak var currentAnswerTF: UITextField!
    @IBOutlet weak var cluesLbl: UILabel!
    @IBOutlet weak var answerLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    
    var letterBtns = [UIButton]()
    var activitedBtns = [UIButton]()
    var solutions = [String]()
    var level = 1
    var score: Int = 0 {
        didSet{
            scoreLbl.text = "\(score)"
        }
    }
    
    
    class var instanceFromStorybord: SwiftWordController {
        
        let storyboard = UIStoryboard(name: "SwiftWordController", bundle: nil)
        if let sw = storyboard.instantiateInitialViewController() as? SwiftWordController {
            return sw
        }
        return SwiftWordController.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in lettersView.subviews {
            if let subBtn = button as? UIButton {
                subBtn.addTarget(self, action: #selector(letterDidClick), for: .touchUpInside);
            }
        }
        
        loadLevel()
        
        
        // 属性测试
        let propertyTest = subProperty()
        propertyTest.storedVar = 12
        propertyTest.readOnlyVar = 13
        propertyTest.readWriteVar = 14
        propertyTest.observerVar = 15
    }
    
    func loadLevel() {
        
        solutions.removeAll()
        for btn in lettersView.subviews {
            btn.isHidden = false
        }
        
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        var path = Bundle.main.path(forResource: "SwiftWord", ofType: "bundle")!
        path += "/level\(level).txt"
        if let levelContent =  try? String(contentsOfFile: path) {
            var lines = levelContent.components(separatedBy: "\n")
            lines = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: lines) as! [String]
            
            for (index, line) in lines.enumerated() {
                let result = line.components(separatedBy: ":")
                if result.count < 2 {
                    continue
                }
                
                let answer = result[0]
                let clue = result[1]
                
                clueString += "\(index+1). \(clue.trimmingCharacters(in: .whitespacesAndNewlines))\n"
                
                let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                solutionString += "\(solutionWord.characters.count)letters\n"
                solutions.append(solutionWord)
                
                let bits = answer.components(separatedBy: "|")
                letterBits += bits
            }
        }
        
        cluesLbl.text = clueString
        answerLbl.text = solutionString
        letterBits = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: letterBits) as! [String]
        var index = 0
        for button in lettersView.subviews {
            if let subBtn = button as? UIButton {
                subBtn.setTitle(letterBits[index], for: .normal)
                index += 1;
                if index >= letterBits.count {
                    break;
                }
            }
        }
        
    }

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func letterDidClick(sender:UIButton)  {
        currentAnswerTF.text = currentAnswerTF.text! + sender.titleLabel!.text!
        activitedBtns.append(sender)
        sender.isHidden = true
    }
    
    @IBAction func clear(_ sender: UIButton?) {
        currentAnswerTF.text = nil
        for btn in activitedBtns {
            btn.isHidden = false
        }
        activitedBtns.removeAll()
    }
    
    @IBAction func submit(_ sender: UIButton) {
        if let position = solutions.index(of: currentAnswerTF.text!.uppercased()) {

            var answers = answerLbl.text!.components(separatedBy: "\n")
            answers[position] = currentAnswerTF.text!
            answerLbl.text = answers.joined(separator: "\n")
            
            activitedBtns.removeAll()
            currentAnswerTF.text = nil
            score += 1
            
            if score % 7 == 0 {
                let ac = UIAlertController(title: "恭喜过关", message: nil, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "下一关", style: .default, handler:{[unowned self] action in
                    if self.level == 1 {
                        self.level = 2
                    } else {
                        self.level = 1
                    }
                    self.loadLevel()
                }))
                present(ac, animated: true, completion: nil)
            }
        }
    }
    
    
    override var shouldAutorotate: Bool{
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .landscape
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return .landscapeLeft
    }
    
}
