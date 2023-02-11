//
//  FinishGoalViewController.swift
//  GoalPost
//
//  Created by Ben Gauger on 2/10/23.
//

import UIKit
import CoreData

class FinishGoalViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var pointsTextField: UITextField!
    
    
    var goalDescription: String!
    var goalType: GoalType!
    
    
    func initData(description: String, type: GoalType) {
        self.goalDescription = description
        self.goalType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createButton.bindToKeyboard()
        pointsTextField.delegate = self
    }

    @IBAction func createGoalPressed(_ sender: Any) {
        if pointsTextField.text != ""{
            self.save { finished in
                if finished {
                    performSegue(withIdentifier: "unwind", sender: self)
                }
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        let goalsVC = GoalsViewController()
        dismiss(animated: true, completion: {goalsVC.viewWillAppear(true)})
    }
    
    
    
    
    func save(completion: (_ finished: Bool) -> ()) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0)
        
        
        do{
            try managedContext.save()
            print("successfully saved data")
            completion(true)
        }catch{
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }
    }
}
