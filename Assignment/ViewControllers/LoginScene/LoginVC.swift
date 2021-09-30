//
//  LoginVC.swift
//  Assignment
//
//  Created by Deepti Chawla on 28/09/21.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    var loginVM = LoginVM()
    override func viewDidLoad() {
        super.viewDidLoad()

        checkLoginStatus()
    }
    
    func checkLoginStatus(){
        if UserDefaults.standard.bool(forKey: kConstant.constants.kLOGIN_STATUS){
            goToDashboard()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emailTF.text = kConstant.constants.kBlank
        passwordTF.text = kConstant.constants.kBlank
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        if Reachability.init().isConnectedToNetwork(){
            
            if isValidEmail(emailTF.text!) && isValidPassword(passwordTF.text!)   {
                loginVM.callingLoginAPI(apiName: kConstant.constants.kLoginApi, target: self, completion: {loginStatus in
                    if loginStatus{
                        self.goToDashboard()
                    }else{
                        ShowAlert.init().showAlert(self, message: kConstant.constants.kSomethingWrong)
                    }
                })
            }else{
                ShowAlert.init().showAlert(self, message: kConstant.constants.kEnterValid)
            }
        }else{
            ShowAlert.init().showAlert(self, message: kConstant.constants.kCheckInternetConnection)
        }
    }
    
    func goToDashboard(){
        let vc = UIStoryboard.init(name: kConstant.constants.kMain, bundle: Bundle.main).instantiateViewController(withIdentifier: kConstant.constants.kDashboard) as? DashboardVC
        self.navigationController?.pushViewController(vc!, animated: true)
        UserDefaults.standard.set(true, forKey: kConstant.constants.kLOGIN_STATUS)
    }

}
