//
//  GuessCountryController.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 16/12/13.
//  Copyright © 2016年 YY. All rights reserved.
//

import UIKit
import GameplayKit

class GuessCountryController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var resultLbl: UILabel!
    
    var countryFlags = [String]()
    var rightAnswer:Int = 0
    var score:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        button1.layer.borderColor = UIColor.lightGray.cgColor
        button1.layer.borderWidth = 0.5
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderWidth = 0.5
        button3.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderWidth = 0.5
        loadImage()
        randomQuestion()
    }
    
    func loadImage() {
        let bundlePath = Bundle.main.path(forResource: "GuessCountry", ofType: "bundle")!
        let fm = FileManager.default
        let imageNames:[String] = (try? fm.contentsOfDirectory(atPath: bundlePath)) ?? [String]()
        for imageName in imageNames {
            if imageName.hasSuffix("png") {
                countryFlags.append(imageName)
            }
        }
    }
    
    func randomQuestion() {
        countryFlags = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: countryFlags) as! [String]
        button1.setImage(UIImage(named:"GuessCountry.bundle/"+countryFlags[0]), for: UIControlState.normal)
        button2.setImage(UIImage(named:"GuessCountry.bundle/"+countryFlags[1]), for: UIControlState.normal)
        button3.setImage(UIImage(named:"GuessCountry.bundle/"+countryFlags[2]), for: UIControlState.normal)
        rightAnswer = GKRandomSource.sharedRandom().nextInt(upperBound: 3)
        var title = countryFlags[rightAnswer]
        title = title.replacingOccurrences(of: ".png", with: "")
        title = title.uppercased()
        self.title = title
    }

    @IBAction func answer(_ sender: UIButton) {
        var answer:Int = 0;
        if sender == button1 {
            answer = 0
        } else if sender == button2 {
            answer = 1
        } else {
            answer = 2
        }
        
        var result:String
        if answer == rightAnswer {
            score += 1
            result = "right"
        } else {
            score -= 1
            result = "wrong"
        }
        
        scoreLbl.text = String(score)
        resultLbl.text = result
        
        randomQuestion()
    }
}
