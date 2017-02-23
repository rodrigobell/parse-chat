//
//  ViewController.swift
//  parse-chat
//
//  Created by Rodrigo Bell on 2/22/17.
//  Copyright © 2017 Rodrigo Bell. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) {
            (user: PFUser?, error: Error?) -> Void in
            if user != nil {
                print("User logged in")
                self.performSegue(withIdentifier: "login-segue", sender: nil)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        var user = PFUser()
        user.username = usernameTextField.text
        user.password = passwordTextField.text
        
        user.signUpInBackground { (success: Bool, error: Error?) in
            if (success) {
                print("User created")
            } else {
                print(error?.localizedDescription)
            }
        }
    }

}

