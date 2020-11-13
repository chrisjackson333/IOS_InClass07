//
//  ViewController.swift
//  inClass07
//
//  Created by Stone, Brian on 6/17/19.
//  Copyright © 2019 Stone, Brian. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBAction func addContact(_ sender: Any) {
        performSegue(withIdentifier: "addContact", sender: self)
    }
    var contacts = [String]()
    var contactObjs = [Contact]()
    var strArr = [String]()
    var selectedIndex:Int?
    @IBOutlet weak var contactTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(didEdit), name: NSNotification.Name("editContact"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didCreate), name: NSNotification.Name("createContact"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didDelete), name: NSNotification.Name("deleteContact"), object: nil)
        // Do any additional setup after loading the view, typically from a nib.
        let cellNib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        contactTable.register(cellNib, forCellReuseIdentifier: "myCell")
        self.loadData()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactObjs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CustomTableViewCell
        cell.nameLabel?.text = contactObjs[indexPath.row].name
        cell.emailLabel?.text = contactObjs[indexPath.row].email
        cell.phoneLabel?.text = String(contactObjs[indexPath.row].phone! + "(\(contactObjs[indexPath.row].type!))")
        cell.id = contactObjs[indexPath.row].id

        return cell
    }
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "viewContactSegue", sender: self)
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewContactSegue"{
            let destinationVC = segue.destination as! ViewController2
            destinationVC.contact = contactObjs[selectedIndex!]
        }
    }
    func loadData(){
        AF.request("http://ec2-18-234-222-229.compute-1.amazonaws.com/contacts").responseString {(response ) in
            if response.result.isSuccess{
                print("Success")
                self.contacts = response.result.value!.split(separator: "\n").map(String.init)
                print(response.result.value!)
                print(self.contacts)
                self.contactObjs.removeAll()
                for contact in self.contacts {
                    self.strArr = contact.split(separator: ",").map(String.init)
                    let temp = Contact(id: Int(self.strArr[0])!, name: self.strArr[1], email: self.strArr[2], phone: self.strArr[3], type: self.strArr[4])
                    
                    self.contactObjs.append(temp)
                    self.strArr.removeAll()
                }
                self.contactTable.reloadData()
            }
            else{
                self.contactObjs.removeAll()
                self.contactTable.reloadData()
                print("Error")
            }
            
        }
    }
    @objc func didEdit(sender: NSNotification){
        
        loadData()
        print("didEdit")
        
    }
    @objc func didCreate(sender: NSNotification){
        loadData()
        print("didCreate")
    }
    @objc func didDelete(notification: Notification){
//        AF.request("http://ec2-18-234-222-229.compute-1.amazonaws.com/contact/delete", method: .post, parameters:["id":] , encoding: URLEncoding.default, headers: nil)
        
        let id:Int = notification.object! as! Int
        AF.request("http://ec2-18-234-222-229.compute-1.amazonaws.com/contact/delete", method: .post, parameters: ["id" : id], encoding: URLEncoding.default, headers: nil).responseString { (response) in
            if(response.result.isSuccess){
                print(response.result.value)
            }
            self.loadData()
            print("didDelete")
        }
        
        
    }


}
class Contact{
    var id:Int?
    var name:String?
    var email:String?
    var phone:String?
    var type:String?
    init(){
        
    }
    init(id:Int, name:String, email:String, phone:String, type:String) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
        self.type = type
    }
}

