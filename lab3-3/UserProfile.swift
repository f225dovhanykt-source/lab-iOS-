import Foundation


class UserProfile {
    var firstName: String
    var lastName: String
    var age: Int?
    var email: String?
    var specialty: String
    var livesInDormitory: Bool    

    init(firstName: String,
         lastName: String,
         age: Int?,
         email: String?,
         specialty: String,
         livesInDormitory: Bool) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.email = email
        self.specialty = specialty
        self.livesInDormitory = livesInDormitory
    }

  
    func printInfo() {
        print("===== Анкета користувача =====")
        print("Ім'я: \(firstName)")
        print("Прізвище: \(lastName.isEmpty ? "не вказано" : lastName)")
        // Розгортання опціоналів: якщо значення немає — виводимо «не вказано»
        print("Вік: \(age.map { String($0) } ?? "не вказано")")
        print("E-mail: \(email ?? "не вказано")")
        print("Спеціальність: \(specialty)")
        print("Проживає в гуртожитку: \(livesInDormitory ? "так" : "ні")")
        print("==============================")
    }
}
