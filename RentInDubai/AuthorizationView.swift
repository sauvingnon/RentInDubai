//
//  AuthorizationView.swift
//  RentInDubai
//
//  Created by Гриша Шкробов on 19.08.2024.
//

import SwiftUI
import FirebaseAuth

struct AuthorizationView: View {
    
    @Binding var navigationStack: NavigationPath
    
    @State private var login = ""
    @State private var password = ""
    
    var body: some View {
        VStack{
            TextField("Логин", text: $login)
                .padding()
            TextField("Пароль", text: $password)
                .padding()
            Button(action: {
                confirm()
            }, label: {
                Text("OK")
            })
        }
    }
    
    func confirm(){
        Auth.auth().createUser(withEmail: login, password: password) { authResult, error in
            if let error = error {
                            print("Error creating user: \(error.localizedDescription)")
                            return
                        }
            // Пользователь успешно зарегистрирован
            print("User registered: \(authResult?.user.email ?? "")")

        }
    }
    
}

struct AuthorizationView_Previews: PreviewProvider {
    
    @State static var stack = NavigationPath()
    
    static var previews: some View {
        AuthorizationView(navigationStack: $stack)
    }
}
