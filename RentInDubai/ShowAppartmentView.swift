//
//  NewAppartmentView.swift
//  RentInDubai
//
//  Created by Гриша Шкробов on 19.08.2024.
//

import SwiftUI

struct ShowAppartmentView: View {
    
    @Binding var navigationStack: NavigationPath
    @Environment(\.dismiss) var dismiss
    
    let appartment: Appartment
    
    @State private var isPresented = false
    
    var body: some View {
        ZStack{
            VStack{
                Text("Просмотр аппартаментов")
                    .padding()
                Text(appartment.name)
                    .padding()
                Text(appartment.address)
                    .padding()
                Text(appartment.description)
                    .padding()
                Text(appartment.email)
                    .padding()
                Text(appartment.phoneNumber)
                    .padding()
                Button(action: {
                    isPresented.toggle()
                }, label: {
                    Text("Показать QR код")
                })
                .padding()
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Закрыть")
                })
                .padding()
                Button(action: {
                    
                }, label: {
                    Text("Изменить")
                })
                .padding()
            }
            if(isPresented){
                VStack {
                    Text("QR-код:")
                        .font(.headline)
                    QRCodeView(qrString: appartment.idFirebase!)
                }
                .onTapGesture {
                    isPresented.toggle()
                }
            }
        }
    }
}

struct ShowAppartmentView_Previews: PreviewProvider {
    
    @State static var stack = NavigationPath()
    
    static var previews: some View {
        ShowAppartmentView(navigationStack: $stack, appartment: Appartment(name: "Имя", description: "Описание", address: "Адрес", email: "Почта", phoneNumber: "Номер телефона"))
    }
}
