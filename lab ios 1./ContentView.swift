import SwiftUI


struct Student {
    let name: String
    let course: Int
    let averageScore: Double
}

struct ContentView: View {
    let universityName: String = "НЛТУ України"
    let totalStudents: Int = 7000
    let ratingScale: Double = 5.0
    
  
    let scholarshipBonus: Double? = 5000.0 //
    let CustomError: String? = nil         //
    
    
    let studentsArray: [Student] = [
        Student(name: "Тарас", course: 3, averageScore: 4.8),
        Student(name: "Олена", course: 2, averageScore: 4.5),
        Student(name: "Андрій", course: 1, averageScore: 3.9)
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Робота з типами даних")
                .font(.title)
                .bold()
                .padding()
            
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Університет: \(universityName)")
                Text("Всього студентів: \(totalStudents)")
                Text("Макс. бал: \(ratingScale, specifier: "%.1f")")
                
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            
            VStack {
                if let bonus = scholarshipBonus {
                    Text("Бонус до стипендії: \(bonus, specifier: "%.2f") грн")
                        .foregroundColor(.green)
                } else {
                    Text("Бонус відсутній")
                }
            }
            
            
            VStack(alignment: .leading) {
                Text("Список студентів (Масив):")
                    .font(.headline)
                    .padding(.bottom, 5)
                
              
                ForEach(studentsArray, id: \.name) { student in
                    HStack {
                        Text("• \(student.name)")
                        Spacer()
                        Text("Курс: \(student.course)")
                        Spacer()
                        Text("Бал: \(student.averageScore, specifier: "%.1f")")
                    }
                    .font(.subheadline)
                    .padding(.vertical, 2)
                }
            }
            .padding()
            .background(Color.blue.opacity(0.05))
            .cornerRadius(10)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

