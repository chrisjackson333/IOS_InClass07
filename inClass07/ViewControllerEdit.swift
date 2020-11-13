//
//  ViewControllerEdit.swift
//  inClass07
//
//  Created by Stone, Brian on 6/17/19.
//  Copyright © 2019 Stone, Brian. All rights reserved.
//

import UIKit
import Alamofire

class ViewControllerEdit: UIViewController {
    var contact:Contact?
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var typeSeg: UISegmentedControl!
    
    @IBAction func submitAction(_ sender: Any) {
        var phoneType:String?
        switch typeSeg.selectedSegmentIndex {
        case 0:
            phoneType = "CELL"
        case 1:
            phoneType = "HOME"
        case 2:
            phoneType = "OFFICE"
        default:
            break
        }
        let parameters = ["id":self.contact!.id!,"name":self.nameField.text!,"email":emailField.text!,"phone":phoneField.text!,"type":phoneType!] as [String : Any]
        print(parameters)
        AF.request("http://ec2-18-234-222-229.compute-1.amazonaws.com/contact/update", method: .post, parameters: parameters as Parameters, encoding: URLEncoding.default, headers: nil).responseString{(response) in
            if response.result.isSuccess{
                
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
                    print("Success")
                    NotificationCenter.default.post(name: NSNotification.Name("editContact"), object: nil)
                    let editedContact = Contact(id: self.contact!.id!, name: self.nameField.text!, email: self.emailField.text!, phone: self.phoneField.text!, type: phoneType!)
                    
                    NotificationCenter.default.post(name: NSNotification.Name("contactEdited"), object: editedContact)
                    self.navigationController?.popViewController(animated: true)
                }
                print(response.result.value!)
                
                
            }
            else{
                print("Error")
            }
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Edit Contact"
        nameField.text = contact?.name
        emailField.text = contact?.email
        phoneField.text = contact?.phone
        switch contact?.type {
        case "CELL":
            typeSeg.selectedSegmentIndex = 0
        case "HOME":
            typeSeg.selectedSegmentIndex = 1
        case "OFFICE":
            typeSeg.selectedSegmentIndex = 2
        default:
            break;
        }
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
