//
//  NewAppartmentView.swift
//  RentInDubai
//
//  Created by Гриша Шкробов on 19.08.2024.
//

import SwiftUI

struct NewAppartmentView: View {
    
    @Binding var navigationStack: NavigationPath
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var description = ""
    @State private var address = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    
    @State private var isWaiting = false
    
    var body: some View {
        VStack{
            Text("Добавление аппартаментов")
                .padding()
            TextField("Название", text: $name)
                .padding()
            TextField("Адрес", text: $address)
                .padding()
            TextField("Описание", text: $description)
                .padding()
            TextField("Почта", text: $email)
                .padding()
            TextField("Телефон", text: $phoneNumber)
                .padding()
            Button(action: {
                appendNewAppartment()
            }, label: {
                Text("Добавить")
            }).disabled(isWaiting)
            Button(action: {
                dismiss()
            }, label: {
                Text("Назад")
            })
            if(isWaiting){
                ProgressView()
            }
        }
    }
    
    private func appendNewAppartment(){
        isWaiting.toggle()
        Task{
            let error = await FirebaseService.shared.appendNewAppartment(appartment: Appartment(name: name, description: description, address: address, email: email, phoneNumber: phoneNumber))
            let success = error == nil
            DispatchQueue.main.async {
                NavigationStackManager.shared.showAlert(title: success ? "Успех" : "Неудача", message: success ? "Запись добавлена!" : "Не удалось создать запись(", actionBlock: {
                    isWaiting.toggle()
                    dismiss()
                })
            }
        }
    }
}

struct NewAppartmentView_Previews: PreviewProvider {
    
    @State static var stack = NavigationPath()
    
    static var previews: some View {
        NewAppartmentView(navigationStack: $stack)
    }
}
