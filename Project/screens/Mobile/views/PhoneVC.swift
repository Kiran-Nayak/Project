//
//  PhoneVC.swift
//  Project
//
//  Created by Kiran Nayak on 14/08/23.
//

import UIKit
import CountryList

class PhoneVC: UIViewController {
    
    /// Creating country list object to get all country code
    var countryList = CountryList()
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var btnCountryCode: UIButton!
    var strCountryCode: String = "+91"
    let viewmodel = PhoneNumberViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryList.delegate = self
        
        /// If user already have authkey no need to relogin.
        if !UserDefaults.authKey.isEmpty {
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc : TabBarVC? = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC
            if let vc = vc {
                self.navigationController?.setViewControllers([vc], animated: true)
            }else {
                let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .cancel))
                self.present(alert, animated: true)
            }
        }
        
    }
    @IBAction func onCountrySelected(_ sender: Any) {
        self.present(countryList, animated: true)
    }
    @IBAction func onContinueClicked(_ sender: Any) {
        verifyNumber(num: txtMobileNumber.text ?? "")
    }
    
    
    /// Check whether the entered number is valid or not. if valid then navigate to next screen
    /// Number will be valid if it's size is 10 otherwise not
    /// - Parameter num: Number that user entered in the UITextField
    private func verifyNumber(num: String) {
        if num.isPhoneNumber {
            Task {
                do {
                    self.view.isUserInteractionEnabled = false
                    let data = try await viewmodel.phoneNumberResponse(mobileNo: "\(strCountryCode)\(num)", repository: RepositoryIMPL())
                    self.view.isUserInteractionEnabled = true
                    if data.status == true {
                        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc : OTPVC? = storyboard.instantiateViewController(withIdentifier: "OTPVC") as? OTPVC
                        if let vc = vc {
                            vc.strCountryCode = strCountryCode
                            vc.strNumber = num
                            vc.delegate = self
                            self.navigationController?.pushViewController(vc, animated: true)
                        }else {
                            let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Okay", style: .cancel))
                            self.present(alert, animated: true)
                        }
                    }else {
                        let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Okay", style: .cancel))
                        self.present(alert, animated: true)
                    }
                } catch {
                    self.view.isUserInteractionEnabled = true
                }
            }
        }else {
            let alert = UIAlertController(title: "Error", message: "Entered Invalid Number", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel))
            self.present(alert, animated: true)
        }
    }
}

/// Creating Extension for CountryListDelegate
extension PhoneVC: CountryListDelegate {
    func selectedCountry(country: Country) {
        strCountryCode = "+\(country.phoneExtension)"
        btnCountryCode.setTitle("+\(country.phoneExtension)", for: .normal)
    }
}

extension PhoneVC: OnOTPDelegate {
    func onSuccess() {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : TabBarVC? = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC
        if let vc = vc {
            self.navigationController?.setViewControllers([vc], animated: true)
        }else {
            let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel))
            self.present(alert, animated: true)
        }
        
    }
}
