//
//  ViewController2.swift
//  inClass07
//
//  Created by Stone, Brian on 6/17/19.
//  Copyright © 2019 Stone, Brian. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    var contact:Contact?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBAction func editAction(_ sender: Any) {
        performSegue(withIdentifier: "editSegue", sender: self)
    }
    @IBAction func deleteAction(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("deleteContact"), object: contact?.id!)
        self.navigationController?.popViewController(animated: true)
    }
//    @IBAction func backToTable(_ sender: Any) {
//        print("backToTable")
//        self.navigationController?.popViewController(animated: true)
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Details"
        NotificationCenter.default.addObserver(self, selector: #selector(contactEdited), name: NSNotification.Name("contactEdited"), object: nil)
        
        nameLabel.text = contact?.name
        emailLabel.text = contact?.email
        phoneLabel.text = contact?.phone
        typeLabel.text = contact?.type
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue"{
            let destinationVC = segue.destination as! ViewControllerEdit
            destinationVC.contact = self.contact
        }
    }
    @objc func contactEdited(notification: Notification){
        var newContact = notification.object as! Contact
        self.contact = newContact
        viewDidLoad()
        print("contactEdited")
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
