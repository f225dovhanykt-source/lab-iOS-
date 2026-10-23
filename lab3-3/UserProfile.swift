//
//  UserProfile.swift
//  Lab3_Storyboard
//
//  Модель даних анкети користувача.
//  Поля класу відповідають полям форми на екрані.
//

import Foundation

/// Клас, що зберігає дані, введені користувачем в анкету.
class UserProfile {

    // MARK: - Поля анкети

    var firstName: String          // Ім'я (обов'язкове)
    var lastName: String           // Прізвище (обов'язкове)
    var email: String?             // Email (необов'язковий — optional)
    var age: Int?                  // Вік (необов'язковий — optional)
    var city: String               // Місто, обране в PickerView
    var wantsNewsletter: Bool      // Підписка на новини (UISwitch)

    // MARK: - Ініціалізатор

    init(firstName: String,
         lastName: String,
         email: String?,
         age: Int?,
         city: String,
         wantsNewsletter: Bool) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.age = age
        self.city = city
        self.wantsNewsletter = wantsNewsletter
    }

    // MARK: - Вивід даних

    /// Повертає текстовий опис анкети.
    /// Для optional-полів, якщо значення відсутнє, виводиться «не вказано».
    func description() -> String {
        let emailText = email ?? "не вказано"
        let ageText = age.map { "\($0)" } ?? "не вказано"
        let newsletterText = wantsNewsletter ? "так" : "ні"

        return """
        ===== Анкета користувача =====
        Ім'я:              \(firstName)
        Прізвище:          \(lastName)
        Email:             \(emailText)
        Вік:               \(ageText)
        Місто:             \(city)
        Підписка на новини: \(newsletterText)
        ==============================
        """
    }

    /// Виводить анкету в консоль Xcode.
    func printToConsole() {
        print(description())
    }
}
