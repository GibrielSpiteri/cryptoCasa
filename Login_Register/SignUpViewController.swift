//
//  SignUpViewController.swift
//  FinalProject
//
//  Created by Rocco Salerno on 4/27/18.
//  Copyright © 2018 Rocco Salerno. All rights reserved.
//

import UIKit
import CoreData
import LocalAuthentication

class SignUpViewController: UIViewController, UITextFieldDelegate, UIApplicationDelegate {

    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var firstNameTxtField: UITextField!
    
    @IBOutlet weak var lastNameTxtField: UITextField!
    
    @IBOutlet weak var emailAddressTxtField: UITextField!
    
    @IBOutlet weak var passwordTxtField: UITextField!
    
    @IBOutlet weak var retypePasswordTxtField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.retypePasswordTxtField.delegate = self;
        self.passwordTxtField.delegate = self;
        self.emailAddressTxtField.delegate = self;
        self.firstNameTxtField.delegate = self;
        self.lastNameTxtField.delegate = self;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitSignupBtn(_ sender: UIButton) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        
        if(firstNameTxtField.text?.isEmpty)! || (lastNameTxtField.text?.isEmpty)! || (emailAddressTxtField.text?.isEmpty)! || (passwordTxtField.text?.isEmpty)! || (retypePasswordTxtField.text?.isEmpty)!
        {
            //display an alert message empty field
            displayAlertMessage(userMessage: "You Are Missing Fields")
            return
        }
        
        if (passwordTxtField.text != retypePasswordTxtField.text)
        {
            //display alert message Nonmatching password
            displayAlertMessage(userMessage: "Your Password Does Not Match")
        }
        else{
            newUser.setValue(firstNameTxtField.text, forKey: "firstName")
            newUser.setValue(lastNameTxtField.text, forKey: "lastName")
            newUser.setValue(emailAddressTxtField.text, forKey: "emailAddress")
            newUser.setValue(passwordTxtField.text, forKey: "password")
            
            do {                        ////////This let statement will save the data to the DataBase DataModel
                try context.save()
            } catch {
                print("Failed saving")
            }
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")  // this let statement will fetch the data
            request.returnsObjectsAsFaults = false
            do {
                let result = try context.fetch(request)
                for data in result as! [NSManagedObject] {
                    print(data.value(forKey: "firstName") as! String)
                    print(data.value(forKey: "lastName") as! String)
                    print(data.value(forKey: "emailAddress") as! String)
                    print(data.value(forKey: "password") as! String)
                }
                
            } catch {
                
                print("Failed")
            }
            
            let signUpComplete = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
            self.present(signUpComplete, animated: true)
        }
    }
    
    @IBAction func cancelSignupBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func displayAlertMessage(userMessage: String)->Void
    {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title:"We have a Problem", message: userMessage, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default)
            {
                (action:UIAlertAction!) in DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
