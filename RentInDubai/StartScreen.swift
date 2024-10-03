//
//  ContentView.swift
//  RentInDubai
//
//  Created by Гриша Шкробов on 19.08.2024.
//

import SwiftUI

struct StartScreen: View {
    
    @Binding var navigationStack: NavigationPath
    
    var body: some View {
        VStack {
            Button(action: {
                
            }, label: {
                Text("Я ищу аппартаменты")
            })
            .padding()
            Button(action: {
                navigationStack.append(CurrentSelectionView.authorizationView)
            }, label: {
                Text("Я сдаю аппартаменты")
            })
            .padding()
            Button(action: {
                
            }, label: {
                Text("Панель администратора")
            })
            .padding()
        }
        .padding()
    }
}

struct StartScreen_Previews: PreviewProvider {
    
    @State static var stack = NavigationPath()
    
    static var previews: some View {
        StartScreen(navigationStack: $stack)
    }
}
