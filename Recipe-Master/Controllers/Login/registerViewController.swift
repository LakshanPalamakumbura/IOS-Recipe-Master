//
//  SignInViewController.swift
//  CardWorkout
//
//  Created by Lakshan Palamakumbura on 2022-12-29.
//


import UIKit

class registerViewController: UIViewController {

    var nav: UINavigationController?

    let TitleLabel = UILabel()
    let usernameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let confirmPasswordTextField = UITextField()
    let signInButton = UIButton(type: .system)


    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

    }

    func configureUI() {
        configureTitleLabel()
        configureUsernameTextField()
        configureEmailTextField()
        configurePasswordTextField()
        configureConfirmPasswordTextField()
        configuresignInButton()
    }

    
    func configureTitleLabel() {
        view.addSubview(TitleLabel)
        TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        TitleLabel.textAlignment = .center
        TitleLabel.textColor = .darkGray
        TitleLabel.font = UIFont.systemFont(ofSize: 28.0, weight: .bold)
        TitleLabel.numberOfLines = 0
        TitleLabel.text = "Recipe App"
//        TitleLabel.alpha = 0

        NSLayoutConstraint.activate([
                TitleLabel.widthAnchor.constraint(equalToConstant: 350),
                TitleLabel.heightAnchor.constraint(equalToConstant: 40),
                TitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                TitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -240)
            
        ])
    }
    
    func configureUsernameTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.placeholder = "Enter User Name Here"
        usernameTextField.backgroundColor = .secondarySystemBackground

        NSLayoutConstraint.activate([
            usernameTextField.widthAnchor.constraint(equalToConstant: 350),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -120)

        ])
    }

    func configureEmailTextField() {
        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.placeholder = "Enter UserEmail Here"
        emailTextField.backgroundColor = .secondarySystemBackground

        NSLayoutConstraint.activate([
            emailTextField.widthAnchor.constraint(equalToConstant: 350),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 30)

        ])
    }


   func configurePasswordTextField() {
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Enter Password Here"
        passwordTextField.backgroundColor = .secondarySystemBackground
        passwordTextField.isSecureTextEntry = true
//        passwordTextField.enablePasswordToggle()

        NSLayoutConstraint.activate([
            passwordTextField.widthAnchor.constraint(equalToConstant: 350),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30)

//            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 30)
        ])
    }

    func configureConfirmPasswordTextField() {
         view.addSubview(confirmPasswordTextField)
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextField.placeholder = "Type Confirm Password"
        confirmPasswordTextField.backgroundColor = .secondarySystemBackground
        confirmPasswordTextField.isSecureTextEntry = true
//        confirmPasswordTextField.enablePasswordToggle()

         NSLayoutConstraint.activate([
            confirmPasswordTextField.widthAnchor.constraint(equalToConstant: 350),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 40),
            confirmPasswordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30)
         ])
     }



    func configuresignInButton() {
        view.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8.0 // for indicator spacing
        signInButton.setTitle("Sign Up", for: [])
        signInButton.addTarget(self, action: #selector(registerTapped), for: .primaryActionTriggered)
        
        NSLayoutConstraint.activate([
            signInButton.widthAnchor.constraint(equalToConstant: 250),
            signInButton.heightAnchor.constraint(equalToConstant: 30),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200)
        ])
    }

    @objc func registerTapped() {

        let parameters = ["name": usernameTextField.text!, "email": emailTextField.text!, "password": passwordTextField.text!, "confirmpassword": confirmPasswordTextField.text!]

           guard let url = URL(string: "http://127.0.0.1:8000/api/register") else { return }
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")

           let session = URLSession.shared
           session.dataTask(with: request){data, response, error in
                   if let error = error {
                       print("Error: \(error)")
                       return
                   }
                   guard let data = data else {
                       print("No data")
                       return
                   }
                   do{
                       let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                       let token = json?["token"] as? String
                       UserDefaults.standard.set(token,forKey: "token")
//                       print(token)
                       if((token) != nil){
                           DispatchQueue.main.async {

                               let vc = HomeViewController()
                               vc.view.backgroundColor = .systemBackground
                               vc.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: nil)
                               self.nav?.pushViewController(vc, animated: true)

                           }
                       }
                   }catch let error{
                       print("Error serializing JSON: \(error)")
                   }
               }.resume()

         }

}





 
 

 
 

/*
import UIKit

class registerViewController: UIViewController {
    
    var nav: UINavigationController?

    let TitleLabel = UILabel()
//    let TitleInfoLabel = UILabel()
    let usernameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let confirmPasswordTextField = UITextField()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    // animation
    var leadingEdgeOnScreen: CGFloat = 16.0
    var leadingEdgeOffScreen: CGFloat = -1000.0
    
    var titleLeadingAnchor: NSLayoutConstraint?
//    var subtitleLeadingAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false
    }
}
    
extension registerViewController {
    
    private func style() {
        TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        TitleLabel.textAlignment = .center
        TitleLabel.textColor = .darkGray
        TitleLabel.font = UIFont.systemFont(ofSize: 28.0, weight: .bold)
        TitleLabel.numberOfLines = 0
        TitleLabel.text = "Recipe App"
        TitleLabel.alpha = 0
        
//        TitleInfoLabel.translatesAutoresizingMaskIntoConstraints = false
//        TitleInfoLabel.textAlignment = .center
//        TitleInfoLabel.textColor = .gray
//        TitleInfoLabel.numberOfLines = 0
//        TitleInfoLabel.text = "Get Redy for cook with us!"
//        TitleInfoLabel.alpha = 0
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.placeholder = "Enter User Name Here"
        usernameTextField.backgroundColor = .secondarySystemBackground
//        usernameTextField.delegate = self
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.placeholder = "Enter UserEmail Here"
        emailTextField.backgroundColor = .secondarySystemBackground

        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Enter Password Here"
        passwordTextField.backgroundColor = .secondarySystemBackground
        passwordTextField.isSecureTextEntry = true
        passwordTextField.enablePasswordToggle()
        
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextField.placeholder = "Type Confirm Password"
        confirmPasswordTextField.backgroundColor = .secondarySystemBackground
        confirmPasswordTextField.isSecureTextEntry = true
        passwordTextField.enablePasswordToggle()
        
//        signInButton.translatesAutoresizingMaskIntoConstraints = false
//        signInButton.configuration = .filled()
//        signInButton.configuration?.imagePadding = 8.0 // for indicator spacing
//        signInButton.setTitle("Sign In", for: [])
//        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .primaryActionTriggered)
////        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8.0 // for indicator spacing
        signInButton.setTitle("Sign Up", for: [])
        signInButton.addTarget(self, action: #selector(registerTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true
    }
    
    private func layout() {
        view.addSubview(TitleLabel)
//        view.addSubview(TitleInfoLabel)
        view.addSubview(usernameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(passwordTextField)
        
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)


        NSLayoutConstraint.activate([
            TitleLabel.widthAnchor.constraint(equalToConstant: 350),
            TitleLabel.heightAnchor.constraint(equalToConstant: 40),
            TitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            TitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -240)
        ])
        
//        NSLayoutConstraint.activate([
//            TitleInfoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            TitleInfoLabel.topAnchor.constraint(equalTo: TitleLabel.bottomAnchor, constant: 30),
//            TitleInfoLabel.widthAnchor.constraint(equalToConstant: 250),
//            TitleInfoLabel.heightAnchor.constraint(equalToConstant: 30)
//        ])
        
        
        NSLayoutConstraint.activate([
            usernameTextField.widthAnchor.constraint(equalToConstant: 350),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -140)
        ])
        
        NSLayoutConstraint.activate([
            emailTextField.widthAnchor.constraint(equalToConstant: 350),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 30)
        ])
         
        NSLayoutConstraint.activate([
            passwordTextField.widthAnchor.constraint(equalToConstant: 350),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            confirmPasswordTextField.widthAnchor.constraint(equalToConstant: 350),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 40),
            confirmPasswordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30)
        ])

         NSLayoutConstraint.activate([
            signInButton.widthAnchor.constraint(equalToConstant: 250),
            signInButton.heightAnchor.constraint(equalToConstant: 30),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150)
        ])
        
        NSLayoutConstraint.activate([
//            errorMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorMessageLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 30),
//            errorMessageLabel.widthAnchor.constraint(equalToConstant: 250),
//            errorMessageLabel.heightAnchor.constraint(equalToConstant: 15)
            
            errorMessageLabel.widthAnchor.constraint(equalToConstant: 250),
            errorMessageLabel.heightAnchor.constraint(equalToConstant: 10),
            errorMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            errorMessageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150)
        ])
        
      
    }
    

    
}

// MARK: - Actions
extension registerViewController {
//    @objc func signInButtonTapped(sender: UIButton) {
//        errorMessageLabel.isHidden = true
//        signin()
//        }
    
    @objc func registerTapped() {
    
    
            // i want this object func to add the post event of api
    
            let parameters = ["name": usernameTextField.text!, "email": emailTextField.text!, "password": passwordTextField.text!, "confirmpassword": confirmPasswordTextField.text!]
    
               guard let url = URL(string: "http://127.0.0.1:8000/api/register") else { return }
               var request = URLRequest(url: url)
               request.httpMethod = "POST"
               request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
               request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
               let session = URLSession.shared
               session.dataTask(with: request){data, response, error in
                       if let error = error {
                           print("Error: \(error)")
                           return
                       }
                       guard let data = data else {
                           print("No data")
                           return
                       }
                       do{
                           let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                           let token = json?["token"] as? String
                           UserDefaults.standard.set(token,forKey: "token")
    //                       print(token)
                           if((token) != nil){
                               DispatchQueue.main.async {
    
                                   let vc = HomeViewController()
                                   vc.view.backgroundColor = .systemBackground
                                   vc.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: nil)
                                   self.nav?.pushViewController(vc, animated: true)
    
                               }
                           }
                       }catch let error{
                           print("Error serializing JSON: \(error)")
                       }
                   }.resume()
    
             }
    
    
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
//        shakeButton()
    }
}

// MARK: - Animations
private extension registerViewController {
    func animate() {
        
        let duration = 2.0
        
        let animator1 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator1.startAnimation()
        
        let animator2 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
//            self.subtitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator2.startAnimation(afterDelay: 1.0)
        
        let animator3 = UIViewPropertyAnimator(duration: duration * 2, curve: .easeInOut) {
            self.TitleLabel.alpha = 1.0
//            self.TitleInfoLabel.alpha = 1.0
            self.view.layoutIfNeeded()
        }
        animator3.startAnimation(afterDelay: 1.0)
    }
    
//    func shakeButton() {
//        let animation = CAKeyframeAnimation()
//        animation.keyPath = "position.x"
//        animation.values = [0, 10, -10, 10, 0]
//        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
//        animation.duration = 0.4
//
//        animation.isAdditive = true
//        signInButton.layer.add(animation, forKey: "shake")
//    }
    

}

*/


