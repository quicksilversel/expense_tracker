//
//  inputFieldViewController.swift
//  expense_tracker
//
//  Created by Zoe L on 2021/01/21.
//

import UIKit

protocol MyDataSendingDelegateProtocol {
    func updateExpense(expenseAmount: String)
}

class inputFieldViewController: UIViewController {
    
    @IBOutlet weak var inputAmount: UITextField!
    
    var delegate: MyDataSendingDelegateProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // done button
    @IBAction func finishInput(_ sender: Any) {
        if self.delegate != nil && self.inputAmount.text != nil {
                    let dataToBeSent = self.inputAmount.text
                    self.delegate?.updateExpense(expenseAmount: dataToBeSent!)
                    dismiss(animated: true, completion: nil)
        }
        else {
            let alertController = UIAlertController(title: "Please enter an amount", message: "Hello World", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler: nil))
            present(alertController, animated:true, completion:nil)
        }
    }
    
    // cancel button
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // income expense segmented control
    
    @IBAction func segmentedControl(_ sender: Any) {
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
