//
//  RegisterViewController.swift


import UIKit
import anim

class RegisterViewController: UIViewController, UITextFieldDelegate
{
    
    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pickColorButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var isUpdateScreen : Bool = false
    
    
    @IBAction func nextButtonClick(_ sender: Any) {
        
        let userData = UserData()
        saveName()
        
        if (userData.avatarId == 0) {
            
            AlertHelper.warn(delegate: self, message: "_alert_choose_avatar".localized)
        }
        else if (userData.name.isEmpty) {
            
            AlertHelper.warn(delegate: self, message: "_alert_enter_name".localized)
        }
        else {
            
            if (isUpdateScreen) {
                
                self.navigationController?.popViewController(animated: true)
            }
            else {
                
                if let target = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController {
                    target.navigationItem.hidesBackButton = true;
                    self.navigationController?.pushViewController(target, animated: true)
                }
            }
        }
    }
    
    
    // MARK: View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let userData = UserData()
        isUpdateScreen = userData.hasAllDataFilled
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        nameTextField.resignFirstResponder()
        saveName()
    }
    
    func saveName() {
        
        var userData = UserData()
        let name : String = nameTextField.text ?? ""
        userData.name = name
        userData.save()
    }
    
    
    
    
    func setupUI() {
        nextButton.layer.cornerRadius = 10
        pickColorButton.layer.cornerRadius = 10
        nameTextField.delegate = self
        pickColorButton.setTitle("_register_pick_color".localized, for: .normal)
        // moves box to 100,100 with default settings
        anim {
            self.pickColorButton.frame.origin = CGPoint(x:0, y:0)
            self.nextButton.frame.origin = CGPoint(x:100, y:100)
            self.avatarButton.frame.origin = CGPoint(x:100, y:100)
            self.nameTextField.frame.origin = CGPoint(x:100, y:100)
            }
            // after that, waits 100 ms
            .wait(0.5)
            // moves box to 0,0 after waiting
            .then {
                self.avatarButton.frame.origin = CGPoint(x:123.5, y:140)
                self.pickColorButton.frame.origin = CGPoint(x:56, y:399)
                self.nextButton.frame.origin = CGPoint(x:56, y:473)
                self.nameTextField.frame.origin = CGPoint(x:56, y:318)
            }
            // displays message after all animations are done
            .callback {
                print("Just finished moving 📦 around.")
        }
    }
    
    func initData() {
        
        let userData = UserData()
        
        self.navigationItem.title = userData.hasAllDataFilled ? "_register_title".localized : "_profile_title".localized
        
        let buttonTitle = userData.hasAllDataFilled ? "_save".localized : "_next".localized
        nextButton.setTitle(buttonTitle, for: .normal)
        
        avatarButton.setImage(UIImage(named: String(format: "%@%d", Constants.kAvatarImagePrefix, userData.avatarId)), for: UIControlState.normal)
        self.view.backgroundColor = Constants.colors[userData.colorId]
        
        nameTextField.text = userData.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        initData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        
        return true
    }
}
