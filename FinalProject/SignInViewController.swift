//
//  SignInViewController.swift
//  FinalProject
//
//  Created by Rocco Salerno on 4/27/18.
//  Copyright © 2018 Rocco Salerno. All rights reserved.
//

import UIKit
import CoreData
import LocalAuthentication

class SignInViewController: UIViewController {

    @IBOutlet weak var userEmailAddressTxtField: UITextField!
    @IBOutlet weak var userPasswordTxtField: UITextField!
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signinSubmit(_ sender: UIButton) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        let searchUserName = self.userEmailAddressTxtField.text
        let searchPassword = self.userPasswordTxtField.text
        request.predicate = NSPredicate (format: "name == %@", searchUserName!)
        
        do
        {
            let result = try context.fetch(request)
            if result.count > 0
            {
                let   n = (result[0] as AnyObject).value(forKey: "userName") as! String
                let p = (result[0] as AnyObject).value(forKey: "password") as! String
                //  print(" checking")
                
                
                if (searchUserName == n && searchPassword == p)
                {
                    let signInComplete = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
                    self.present(signInComplete, animated: true)
                }
                else if (searchUserName == n || searchPassword == p)
                {
                    // print("password incorrect ")
                    let alertController1 = UIAlertController (title: "no user found ", message: "password incorrect ", preferredStyle: UIAlertControllerStyle.alert)
                    alertController1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alertController1, animated: true, completion: nil)
                }
            }
            else
            {
                let alertController1 = UIAlertController (title: "no user found ", message: "invalid username ", preferredStyle: UIAlertControllerStyle.alert)
                alertController1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController1, animated: true, completion: nil)
                print("no user found")
            }
        }
        catch
        {
            print("error")
        }
        
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func faceIDBtn(_ sender: UIButton) {
        let context: LAContext = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Login with Biometrics", reply: {(wasCorrect, error)in
                if wasCorrect
                {
                    let signUpComplete = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
                    self.present(signUpComplete, animated: true)
                }
                else
                {
                    print("incorrect")
                }
            })
        }
        else{
            print("error")
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
