import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
     @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var cityPickerView: UIPickerView!
    @IBOutlet weak var newsletterSwitch: UISwitch!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!


    
    private let cities = ["Львів", "Київ", "Харків", "Одеса", "Дніпро",
                          "Івано-Франківськ", "Тернопіль", "Ужгород"]

    
    private var userProfile: UserProfile?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImage()
        setupTextFields()
        setupPicker()
        setupKeyboardHandling()
        resultLabel.text = ""
    }

  

    private func setupImage() {
        avatarImageView.image = UIImage(named: "avatar")
            ?? UIImage(systemName: "person.crop.circle.fill")
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.tintColor = .systemBlue
    }

    private func setupTextFields() {
        firstNameTextField.placeholder = "Ім'я *"
        lastNameTextField.placeholder = "Прізвище *"
        emailTextField.placeholder = "Email"
        ageTextField.placeholder = "Вік"

        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        ageTextField.keyboardType = .numberPad

        
        [firstNameTextField, lastNameTextField, emailTextField, ageTextField]
            .forEach { $0?.delegate = self }
    }


    private func setupPicker() {
        cityPickerView.dataSource = self
        cityPickerView.delegate = self
    }

  
    private func setupKeyboardHandling() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        NotificationCenter.default.addObserver(self,
            selector: #selector(keyboardWillChange(_:)),
            name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillChange(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }
        let keyboardHeight = view.convert(frame, from: nil).intersection(view.bounds).height
        scrollView.contentInset.bottom = keyboardHeight
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }

    // MARK: - IBAction
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        view.endEditing(true)

        // Обов'язкові поля: прибираємо пробіли та перевіряємо на порожність
        let firstName = firstNameTextField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        let lastName = lastNameTextField.text?.trimmingCharacters(in: .whitespaces) ?? ""

        guard !firstName.isEmpty, !lastName.isEmpty else {
            showResult("Заповніть ім'я та прізвище", isError: true)
            return
        }

       
        let emailText = emailTextField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        let email: String? = emailText.isEmpty ? nil : emailText

      
        let ageText = ageTextField.text ?? ""
        var age: Int? = nil
        if !ageText.isEmpty {
            guard let parsedAge = Int(ageText), (1...120).contains(parsedAge) else {
                showResult("Вік має бути числом від 1 до 120", isError: true)
                return
            }
            age = parsedAge
        }

       
        let city = cities[cityPickerView.selectedRow(inComponent: 0)]
        let wantsNewsletter = newsletterSwitch.isOn

        
        let profile = UserProfile(firstName: firstName,
                                  lastName: lastName,
                                  email: email,
                                  age: age,
                                  city: city,
                                  wantsNewsletter: wantsNewsletter)
        userProfile = profile

        // Вивід у консоль
        profile.printToConsole()
        showResult("Анкету збережено! Дані виведено в консоль.", isError: false)
    }

   
    private func showResult(_ text: String, isError: Bool) {
        resultLabel.text = text
        resultLabel.textColor = isError ? .systemRed : .systemGreen
    }
}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {

  
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
}

// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstNameTextField: lastNameTextField.becomeFirstResponder()
        case lastNameTextField:  emailTextField.becomeFirstResponder()
        case emailTextField:     ageTextField.becomeFirstResponder()
        default:                 textField.resignFirstResponder()
        }
        return true
    }
}
