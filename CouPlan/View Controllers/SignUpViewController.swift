//
//  SignUpViewController.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 07.10.21.
//

import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpButton: Button!
    
    
    @IBAction func createAccount(_ sender: Any) {
        
        guard let email = emailField.text, !email.isEmpty, let password = passwordField.text, !password.isEmpty else {
            showAlert(title: "email/password can't be empty", message: "Please enter an email and a password")
            return
        }
        
        let passwordValidation = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{6,}$")
        if passwordValidation.evaluate(with: passwordField.text) {print("truePW")}
        else {
            showAlert(title: "Not a valid password", message: "Your password has to be 6 characters long")
        }
        
        let emailValidation = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@]).{3,}$")
        if emailValidation.evaluate(with: emailField.text) {print("trueEmail")}
        else {
            showAlert(title: "Not a valid email address", message: "Please enter your Email address")
        }
                
        showMessage(message: "Please login now")
                
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            print("user succesfully created")
        
            if error == nil {
                Auth.auth().signIn(withEmail: email, password: password)
            } else {
                print("Error in createUser: \(error?.localizedDescription ?? "")")
            }
        }
    }
        
    /*    let user = Auth.auth().currentUser
        if let user = user {
          // The user's ID, unique to the Firebase project.
          // Do NOT use this value to authenticate with your backend server,
          // if you have one. Use getTokenWithCompletion:completion: instead.
          let uid = user.uid
          let email = user.email
          let photoURL = user.photoURL
          var multiFactorString = "MultiFactor: "
          for info in user.multiFactor.enrolledFactors {
            multiFactorString += info.displayName ?? "[DispayName]"
            multiFactorString += " "
          }
        }*/
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated:true)
    }
    
   func showMessage(message: String) {
       let alertVC = UIAlertController(title: "You are successfully registered", message: message, preferredStyle: .alert)
       alertVC.addAction(UIAlertAction(title: "Login", style: .default, handler: {
           action in
           DispatchQueue.main.async {
               self.performSegue(withIdentifier: "unwindToLogin", sender: (Any).self)
           }
       }))
       self.present(alertVC, animated:true)
   }
    
}
