//
//  OTPVC.swift
//  Project
//
//  Created by Kiran Nayak on 14/08/23.
//

import UIKit

class OTPVC: UIViewController {

    @IBOutlet weak var vNumber: UIView!
    @IBOutlet weak var txtNumber: UILabel!
    @IBOutlet weak var txtCountDown: UILabel!
    @IBOutlet weak var txtOTP: UITextField!
    weak var delegate: OnOTPDelegate?
    
    var strNumber = ""
    var strCountryCode = ""
    let viewmodel = OTPViewModel()
    var timer: Timer? = nil
    
    var countDown = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        txtNumber.text = "\(strCountryCode) \(strNumber)"
        let tap = UITapGestureRecognizer(target: self, action: #selector(onNumberClicked))
        tap.numberOfTapsRequired = 1
        vNumber.isUserInteractionEnabled = true
        vNumber.addGestureRecognizer(tap)
    }
    
    @objc private func update() {
        countDown -= 1
        txtCountDown.text = "00:\(String(format: "%02d", countDown))"
        if countDown == 0 {
            txtCountDown.isHidden = true
            timer?.invalidate()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    @IBAction func onContinueClicked(_ sender: Any) {
        verifyOTP(num: txtOTP.text ?? "")
    }
    
    private func verifyOTP(num: String) {
        Task {
            do {
                self.view.isUserInteractionEnabled = false
                let data = try await viewmodel.otpResponse(mobileNo: "\(strCountryCode)\(strNumber)", otp: num, repository: RepositoryIMPL())
                self.view.isUserInteractionEnabled = true
                dump(data)
                if let token = data.token, token.isEmpty == false {
                    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc : OTPVC? = storyboard.instantiateViewController(withIdentifier: "OTPVC") as? OTPVC
                    if let _ = vc {
                        UserDefaults.authKey = token
                        delegate?.onSuccess()
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
    }
    
    @objc private func onNumberClicked() {
        self.navigationController?.popViewController(animated: true)
    }

}
