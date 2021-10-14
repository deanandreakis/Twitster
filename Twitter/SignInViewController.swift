//
//  SignInViewController.swift
//  Twitter
//
//  Created by Born4Film on 10/12/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if UserDefaults.standard.bool(forKey: "signedIn") == true {
            self.performSegue(withIdentifier: "signInToHome", sender: self)
        }
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        
        let signUrl = "https://api.twitter.com/oauth/request_token"
        
        TwitterAPICaller.client?.login(url: signUrl, success: {
            UserDefaults.standard.set(true, forKey: "signedIn")
            self.performSegue(withIdentifier: "signInToHome", sender: self)
            
        }, failure: { Error in
            print("Could not sign in!")
        })
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
