//
//  ViewControllerCreate.swift
//  inClass07
//
//  Created by Stone, Brian on 6/19/19.
//  Copyright © 2019 Stone, Brian. All rights reserved.
//

import UIKit
import Alamofire

class ViewControllerCreate: UIViewController {

    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var typeSeg: UISegmentedControl!
    @IBAction func submitButton(_ sender: Any) {
        var phoneType:String?
        switch self.typeSeg.selectedSegmentIndex {
        case 0:
            phoneType = "CELL"
        case 1:
            phoneType = "HOME"
        case 2:
            phoneType = "OFFICE"
        default:
            break
        }
        let parameters = ["name":self.nameField!.text!,"email":self.emailField.text!,"phone":self.phoneField!.text!,"type": phoneType!]
        print(parameters)
        AF.request("http://ec2-18-234-222-229.compute-1.amazonaws.com/contact/create", method: .post, parameters: parameters as Parameters, encoding: URLEncoding.default, headers: nil).responseString { (response) in
            
                if response.result.isSuccess {
                    print(response.result.value!)
                    if response.result.value! == "Enter Valid Phone !"{
                        let alert = UIAlertController(title: "Invalid Phone", message: "Please enter a valid Phone number", preferredStyle: .actionSheet)
                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                        
                        
                        print("enter valid phone")
                    }
                    else if response.result.value! == "Enter Valid Name !"{
                        let alert = UIAlertController(title: "Invalid Name", message: "Please enter a valid Name", preferredStyle: .actionSheet)
                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        print("enter valid name")
                    }
                    else if response.result.value! == "Enter Valid Email !"{
                        let alert = UIAlertController(title: "Invalid Email", message: "Please enter a valid Email", preferredStyle: .actionSheet)
                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        print("enter valid email")
                    }
                    else{
                        self.dismiss(animated: true, completion:nil)
                        NotificationCenter.default.post(name: NSNotification.Name("createContact"), object: nil)
                    }
                    
                }
                else{
                    print("error")
                }
            
        }
    }
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
