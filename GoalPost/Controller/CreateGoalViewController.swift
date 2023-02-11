//
//  CreateGoalViewController.swift
//  GoalPost
//
//  Created by Ben Gauger on 2/9/23.
//

import UIKit

class CreateGoalViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermButton: UIButton!
    @IBOutlet weak var longTermButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var userGoalType: GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.bindToKeyboard()
        shortTermButton.setSelectedColor()
        longTermButton.setDeselectedColor()
        print("\(userGoalType)")
        goalTextView.delegate = self
    }
    
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        
        if goalTextView.text != "" && goalTextView.text != "What is your goal?" {
            guard let finishVC = storyboard?.instantiateViewController(withIdentifier: "FinishVC") as? FinishGoalViewController else {return}
            finishVC.initData(description: goalTextView.text!, type: userGoalType)
            print("\(finishVC.goalType.rawValue) after next button pressed")
            finishVC.modalPresentationStyle = .fullScreen
            present(finishVC, animated: true)
        }
    }
    
    @IBAction func longTermButtonPressed(_ sender: Any) {
        userGoalType = .longTerm
        longTermButton.setSelectedColor()
        shortTermButton.setDeselectedColor()
        print("\(userGoalType)")
    }
    
    @IBAction func shortTermButtonPressed(_ sender: Any) {
        userGoalType = .shortTerm
        shortTermButton.setSelectedColor()
        longTermButton.setDeselectedColor()
        print("\(userGoalType)")
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
//        dismissDetail()
        dismiss(animated: true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = ""
        goalTextView.textColor = UIColor(ciColor: .black)
    }
    
}
