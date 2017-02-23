//
//  ChatViewController.swift
//  parse-chat
//
//  Created by Robert Mitchell on 2/22/17.
//  Copyright © 2017 Rodrigo Bell. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var messageTableView: UITableView!
    @IBOutlet var chatTextField: UITextField!
    var messageArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageTableView.dataSource = self
        self.messageTableView.delegate = self

        Timer.scheduledTimer(timeInterval: 5, target: self, selector: "onTimer", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ComposeMessage(_ sender: Any) {
        
        var message = PFObject(className:"Message")
        message["text"] = chatTextField.text
        
        
        message.saveInBackground {
            (success: Bool, error: Error?) -> Void in
            if (success) {
                print("success")
                // The object has been saved.
            } else {
                print(error?.localizedDescription)
                // There was a problem, check error.description
            }
        }

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messageTableView.dequeueReusableCell(withIdentifier: "MessageCell")
        
        
        return cell!
    }
    
    func onTimer(){
    var query = PFQuery(className: "Message")
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil {
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        print(object.objectId)
                        self.messageArray.append(object["text"] as! String)
                        print("\(object["text"])")
                    }
                }
            } else {
                // Log details of the failure
                print(error?.localizedDescription)
            }
        }
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
