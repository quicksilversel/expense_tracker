//
//  inputFieldViewController.swift
//  expense_tracker
//
//  Created by Zoe L on 2021/01/21.
//

import UIKit

class inputFieldViewController: UIViewController {
    
    @IBOutlet weak var expenseInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // done button
    @IBAction func finishInput(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // cancel button
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // income expense segmented control
    
    @IBAction func segmentedControl(_ sender: Any) {
    }
    
    
    // send expense amount to main session
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let destVC : ViewController = segue.destination as! ViewController
        destVC.expenseAmount = expenseInput.text!
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
