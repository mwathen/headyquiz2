//
//  ViewController.swift
//  HeadyQuiz2
//
//  Created by Michael Wathen on 1/24/17.
//  Copyright © 2017 Michael Wathen. All rights reserved.
//

import UIKit
import QuartzCore

struct Question {
    var Question : String
    var Answers : [String]!
    var Answer : Int!
}

class ViewController: UIViewController {
    
    @IBOutlet var QuestionLabel: UILabel!

    @IBOutlet var AnswerLabel: UILabel!
    
    @IBOutlet var Buttons: [UIButton]!
    
    var Questions = [Question]()
    
    var QNumber = Int()
    
    @IBOutlet weak var NextQuestion: UIButton!
    
    var QNumber2 = -1
    
    var AnswerNumber = Int()
    
    var CorrectAnswer = String()
    
    var JSONQuestion = String()
    
    var NumberRight = 0
    
    var NumberWrong = 0
    
    var xx = Int()
    
    var questionvalue = String()
    var answer1value = String()
    var answer2value = String()
    var answer3value = String()
    var answer4value = String()
    var correctanswer_real = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(frame: self.view.bounds)
        imageView.image = UIImage(named: "sunglasses.jpg")
        self.view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
        
        let rect = UIView(frame: CGRectMake(50, 85, 270, 500))
        rect.backgroundColor = UIColor(red:0.67, green:0.71, blue:0.91, alpha:1.0)
        rect.layer.borderColor = UIColor.white.cgColor
        rect.layer.borderWidth = 2.0
        rect.layer.cornerRadius = 8.0
        rect.clipsToBounds = true
        rect.bounds = view.frame.insetBy(dx: 7.0, dy: 7.0)
        self.view?.addSubview(rect)
        self.view.bringSubview(toFront: rect)
        self.view.bringSubview(toFront: QuestionLabel)
        self.view.bringSubview(toFront: AnswerLabel)
        self.view.bringSubview(toFront: NextQuestion)
        
        self.NextQuestion.alpha = 0
                
        guard let path = Bundle.main.path(forResource: "Records", ofType: "plist") else {
            return
        }
        
        ////If your plist contain root as Dictionary
        guard let dic = NSDictionary(contentsOfFile: path) else {
            return
        }
        
        ////If your plist contain root as Dictionary
        guard let dic2 = dic.object(forKey:"Records") as? [String: Any]  else {
            return
        }
        
        //print(dic)
        
        // Do any additional setup after loading the view, typically from a nib.
        
        xx = 0
        for (key,value) in dic2 {
            print(key)
            //print(type(of: value))
            for (key2,value2) in (value as? [String: Any])! {
                if (key2 == "Question") {
                    //Questions[xx].Question = value2 as! String
                    questionvalue = value2 as! String
                    //print("\(key2) = \(value2)")
                }
                if (key2 == "Answer 1") {
                    //Questions[xx].Answers[0] = value2 as! String
                    answer1value = value2 as! String
                }
                if (key2 == "Answer 2") {
                    answer2value = value2 as! String
                }
                if (key2 == "Answer 3") {
                    answer3value = value2 as! String
                }
                if (key2 == "Answer 4") {
                    answer4value = value2 as! String
                }
                if (key2 == "Correct Answer") {
                    correctanswer_real = value2 as! Int
                    //print("\(key2) = \(value2)")
                }
            }
            Questions.insert(Question(Question: questionvalue,
                                      Answers: [answer1value,answer2value,answer3value,answer4value], Answer: correctanswer_real), at:xx)
            if (Questions.count == 10) {
                break
            }
            xx += 1
        }
        
        PickQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    func PickQuestion() {

        if Questions.count > 0 {
            let QNumber3 = UInt32(Questions.count)
            QNumber = Int(arc4random() % QNumber3)
            QNumber2 += 1
            
            self.QuestionLabel.text = Questions[QNumber].Question

            AnswerNumber = Questions[QNumber].Answer
            
            for i in 0..<Buttons.count {
                Buttons[i].setTitle(Questions[QNumber].Answers[i], for: UIControlState.normal)
                Buttons[i].titleLabel?.numberOfLines = 1
                Buttons[i].titleLabel?.minimumScaleFactor = 0.5
                Buttons[i].titleLabel?.adjustsFontSizeToFitWidth = true
                self.view.bringSubview(toFront: Buttons[i])
            }
            
            Questions.remove(at: QNumber)
            AnswerLabel.text = "";
        } else {
            NSLog("Done!")
            var answer_label = "Quiz Completed\r\n"
            let number_right_string = String(self.NumberRight)
            let number_wrong_string = String(self.NumberWrong)
            answer_label += "Number Right: " + number_right_string + "\r\n" as String
            answer_label += "Number Wrong: " + number_wrong_string + "\r\n" as String
            AnswerLabel.text = answer_label
        }
    }
    
    func RandomQuestions() {
        
        var RandomNumber = arc4random() % 5
        RandomNumber += 1
        
    }
    
    @IBAction func NextQuestionAction(_ sender: Any) {
        NSLog("Next!")
        for i in 0..<Buttons.count {
            Buttons[i].isEnabled = true
            Buttons[i].alpha = 100
        }
        self.NextQuestion.alpha = 0
        PickQuestion()
    }

    @IBAction func Button1Action(_ sender: Any) {
        if AnswerNumber == 1 {
            self.NumberRight += 1
            PickQuestion()
        } else {
            NSLog("Wrong!")
            self.NextQuestion.alpha = 100
            self.NumberWrong += 1
            for i in 0..<Buttons.count {
                Buttons[i].isEnabled = false
                Buttons[i].alpha = 0.5
            }
            AnswerLabel.text = "Wrong Answer"
        }
    }

    @IBAction func Button2Action(_ sender: Any) {
        if AnswerNumber == 2 {
            self.NumberRight += 1
            PickQuestion()
        } else {
            NSLog("Wrong!")
            self.NextQuestion.alpha = 100
            self.NumberWrong += 1
            for i in 0..<Buttons.count {
                Buttons[i].isEnabled = false
                Buttons[i].alpha = 0.5
            }
            AnswerLabel.text = "Wrong Answer"
        }
    }

    @IBAction func Button3Action(_ sender: Any) {
        if AnswerNumber == 3 {
            self.NumberRight += 1
            PickQuestion()
        } else {
            NSLog("Wrong!")
            self.NextQuestion.alpha = 100
            self.NumberWrong += 1
            for i in 0..<Buttons.count {
                Buttons[i].isEnabled = false
                Buttons[i].alpha = 0.5
            }
            AnswerLabel.text = "Wrong Answer"
        }
    }

    @IBAction func Button4Action(_ sender: Any) {
        if AnswerNumber == 4 {
            self.NumberRight += 1
            PickQuestion()
        } else {
            NSLog("Wrong Again!")
            self.NextQuestion.alpha = 100
            self.NumberWrong += 1
            for i in 0..<Buttons.count {
                Buttons[i].isEnabled = false
                Buttons[i].alpha = 0.5
            }
            AnswerLabel.text = "Wrong Answer"
        }
    }


}

