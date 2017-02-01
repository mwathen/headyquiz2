//
//  ViewController.swift
//  HeadyQuiz2
//
//  Created by Michael Wathen on 1/24/17.
//  Copyright © 2017 Michael Wathen. All rights reserved.
//

import UIKit

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
    
    var QNumber2 = -1
    
    var AnswerNumber = Int()
    
    var CorrectAnswer = String()
    
    var JSONQuestion = String()
    
    var xx = Int()
    
    var questionvalue = String()
    var answer1value = String()
    var answer2value = String()
    var answer3value = String()
    var answer4value = String()
    var correctanswer_real = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //var JSONQuestion2 = String()
        
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
                    //print("\(key2) = \(value2)")
                }
                if (key2 == "Answer 2") {
                    answer2value = value2 as! String
                    //print("\(key2) = \(value2)")
                }
                if (key2 == "Answer 3") {
                    answer3value = value2 as! String
                    //print("\(key2) = \(value2)")
                }
                if (key2 == "Answer 4") {
                    answer4value = value2 as! String
                    //print("\(key2) = \(value2)")
                }
                if (key2 == "Correct Answer") {
                    correctanswer_real = value2 as! Int
                    //print("\(key2) = \(value2)")
                }
            }
            Questions.insert(Question(Question: questionvalue,
                                      Answers: [answer1value,answer2value,answer3value,answer4value], Answer: correctanswer_real), at:xx)
            xx += 1
            //print(xx)
        }
        
        PickQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func PickQuestion() {

        if Questions.count > 0 {
            QNumber = 0
            QNumber2 += 1
            
            self.QuestionLabel.text = Questions[QNumber].Question

            AnswerNumber = Questions[QNumber].Answer
            
            for i in 0..<Buttons.count {
                Buttons[i].setTitle(Questions[QNumber].Answers[i], for: UIControlState.normal)
            }
            
            Questions.remove(at: QNumber)
            AnswerLabel.text = "";
        } else {
            NSLog("Done!")
            AnswerLabel.text = "Quiz Completed";
        }
    }
    
    func RandomQuestions() {
        
        var RandomNumber = arc4random() % 5
        RandomNumber += 1
        
    }

    @IBAction func Button1Action(_ sender: Any) {
        if AnswerNumber == 1 {
            PickQuestion()
        } else {
            NSLog("Wrong!")
            AnswerLabel.text = "Wrong Answer"
        }
    }

    @IBAction func Button2Action(_ sender: Any) {
        if AnswerNumber == 2 {
            PickQuestion()
        } else {
            NSLog("Wrong!")
            AnswerLabel.text = "Wrong Answer"
        }
    }

    @IBAction func Button3Action(_ sender: Any) {
        if AnswerNumber == 3 {
            PickQuestion()
        } else {
            NSLog("Wrong!")
            AnswerLabel.text = "Wrong Answer"
        }
    }

    @IBAction func Button4Action(_ sender: Any) {
        if AnswerNumber == 4 {
            PickQuestion()
        } else {
            NSLog("Wrong Again!")
            AnswerLabel.text = "Wrong Answer"
        }
    }


}

