//
//  LoginViewController.swift
//  CouPlan
//
//  Created by Alexandra Hufnagel on 01.10.21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var emailField: TextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var loginTextField: UITextField!
    var authHandle: AuthStateDidChangeListenerHandle?
    
  //  let ref = Database.database().reference(withPath: "users")
  //  var refObservers: [DatabaseHandle] = []
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()

        
        // MARK: User login check
        authHandle = Auth.auth().addStateDidChangeListener { _, user in
                        
          if user == nil {
              self.emailField.text = nil
              self.passwordField.text = nil
            self.navigationController?.popToRootViewController(animated: true)
          } else {
              print("LOGGEDIN")
            self.performSegue(withIdentifier: "goToOverview", sender: nil)
          //  self.emailField.text = nil
        //    self.passwordField.text = nil
          }
        }
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(authHandle!)
    }
    
    @IBAction func logginTapped(_ sender: Any) {
        
        guard let email = emailField.text, !email.isEmpty, let password = passwordField.text, !password.isEmpty else {
            showAlert(message: "Please enter your email address and your password")
            return
        }
    
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
                        
            if let error = error, user == nil {
                
                print("INERRORCASE")
              let alert = UIAlertController(title: "Sign In Failed", message: error.localizedDescription, preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
              self.present(alert, animated: true)
                
            } else {
                self.performSegue(withIdentifier: "goToOverview", sender: (Any).self)
            }
        }
        
     /*   Auth.auth().signIn(withEmail: email, password: password, completion: { (auth, error) in
            if let x = error {
                let err = x as NSError
                switch err.code {
                case AuthErrorCode.wrongPassword.rawValue:
                    print("wrong password")
                case AuthErrorCode.invalidEmail.rawValue:
                    print("invalued email")
                case AuthErrorCode.accountExistsWithDifferentCredential.rawValue:
                    print("accountExistsWithDifferentCredential")
                default:
                    print("unknown error: \(err.localizedDescription)")
                }
            } else {
                if let _ = auth?.user {
                    print("authd") //user is auth'd proceed to next step
                } else {
                    print("authentication failed - no auth'd user")
                }
            }
        })*/
    }
           
            // user nil Optional(Error Domain=FIRAuthErrorDomain Code=17008 "The email address is badly formatted." UserInfo={NSLocalizedDescription=The email address is badly formatted., FIRAuthErrorUserInfoNameKey=ERROR_INVALID_EMAIL})
            
            
           /* let user = Auth.auth().currentUser
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
        
    
    
    // MARK: Config
    
   /* func configureAuth() {
        let provider: [FUIAuthProvider] = [FUIGoogleAuth()]
        FUIAuth.defaultAuthUI()?.providers = provider
        
        // listen for changes in the authorization state
        _authHandle = Auth.auth().addStateDidChangeListener { (auth: Auth, user: User?) in
            // refresh table data
          //  self.messages.removeAll(keepingCapacity: false)
           // self.messagesTable.reloadData()
            
            // check if there is a current user
            if let activeUser = user {
                // check if the current app user is the current FIRUser
                if self.user != activeUser {
                    self.user = activeUser
                    self.signedInStatus(isSignedIn: true)
                    let name = user!.email!.components(separatedBy: "@")[0]
                    self.displayName = name
                }
            } else {
                // user must sign in
                self.signedInStatus(isSignedIn: false)
                self.loginSession()
            }
        }
    }*/
    
    // MARK: Sign In and Out
    
 /*   func signedInStatus(isSignedIn: Bool) {
        
        if isSignedIn {
            // remove background blur (will use when showing image messages)
          //  subscribeToKeyboardNotifications()
          //  configureDatabase()
            configureStorage()
            configureRemoteConfig()
            fetchConfig()
        }
    }*/
    
  /*  func configureStorage() {
        storageRef = Storage.storage().reference()
    }*/
    
    // MARK: Remote Config
    
   /* func configureRemoteConfig() {
        // create remote config setting to enable developer mode
        let remoteConfigSettings = RemoteConfigSettings()
        remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.configSettings = remoteConfigSettings
    }
    
    func fetchConfig() {
        var expirationDuration: Double = 3600
        // if in developer mode, set cacheExpiration 0 so each fetch will retrieve values from the server
       // if remoteConfig.configSettings.isDeveloperModeEnabled {
            expirationDuration = 0
       // }
        
        // cacheExpirationSeconds is set to cacheExpiration to make fetching faser in developer mode
        remoteConfig.fetch(withExpirationDuration: expirationDuration) { (status, error) in
            if status == .success {
                print("Config fetched!")
                self.remoteConfig.activate()
             //   let friendlyMsgLength = self.remoteConfig["friendly_msg_length"]
              //  if friendlyMsgLength.source != .static {
                //    self.msglength = friendlyMsgLength.numberValue
                //    print("Friendly msg length config: \(self.msglength)")
               // }
           // } else {
           //     print("Config not fetched")
            }
        }
    }
    
    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
        }

    }*/
        
    @IBAction func unwindToLogin(segue:UIStoryboardSegue) {}
    
    
    func showAlert(message: String) {
        unsubscribeFromKeyboardNotifications()
        let alertVC = UIAlertController(title: "no credentials", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated:true)
    }
    
    // MARK: Showing / Hiding the keyboard, height adjustment & keyboard notification
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name:  UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if emailField.isEditing {
            view.frame.origin.y = -(getKeyboardHeight(notification)*0.6)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if emailField.isEditing {
            view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }

    
    
}

extension NSLayoutConstraint {
    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)"
    }
}
