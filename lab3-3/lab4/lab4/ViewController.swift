
import SwiftUI

struct ContentView: View {

    
@State private var email = ""

    var body: some View {
    
        ZStack {
            Color.blue.opacity(0.2)
                .ignoresSafeArea()

           
            VStack(spacing: 20) {

          
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.blue)
                    .shadow(radius: 5)

            
                Text("Довганик Тарас")
                    .font(.largeTitle)
                    .fontWeight(.bold)

              
                HStack {
                    Image(systemName: "graduationcap.fill")
                        .foregroundColor(.purple)
                    Text("Група ІПЗС-21")
                        .font(.title3)
                }
                        
                    Text("Довганик Тарас")
                    .font(.largeTitle)
                                .fontWeight(.bold)
                                    
                                
                  
    
                        
                    
                

                HStack {
                    Image(systemName: "swift")
                        .foregroundColor(.orange)
                    Text("Вивчаю Swift і SwiftUI")
                        .font(.body)
                        .foregroundColor(.gray)
                }

              
                TextField("Ваш email", text: $email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
            }
        }
    }
}

#Preview {
    ContentView()
}
