//
//  ApartmentLandlordView.swift
//  RentInDubai
//
//  Created by Гриша Шкробов on 19.08.2024.
//

import SwiftUI

struct ApartmentLandlordView: View {
    
    @Binding var navigationStack: NavigationPath
    
    let userUID: String
    
    @ObservedObject var model = ApartmentLandlordModel.shared
    
    var body: some View {
        VStack{
            Text("Привет, \(userUID)")
                .padding()
            Button(action: {
                appendNewAppartment()
            }, label: {
                Text("Добавить карточку аппартаментов")
            })
            .padding()
            
            Button(action: {
                FirebaseService.shared.logout()
                navigationStack.removeLast(navigationStack.count)
            }, label: {
                Text("Выйти")
            })
            .padding()
            
            if let appartments = model.appartments{
                if(appartments.isEmpty){
                    Text("Нет аппартаментов")
                }else{
                    ForEach(appartments){ item in
                        Text("\(item.name)")
                            .onTapGesture {
                                showAppartment(appartment: item)
                            }
                    }
                }
            }else{
                ProgressView()
            }
            
            
        }
        .onAppear(){
            model.getUserAppartments()
        }
    }
    
    private func showAppartment(appartment: Appartment){
        navigationStack.append(CurrentSelectionView.showAppartment(appartment))
    }
    
    private func appendNewAppartment(){
        navigationStack.append(CurrentSelectionView.appendAppertmentView)
    }
}

struct ApartmentLandlordView_Previews: PreviewProvider {
    
    @State static var stack = NavigationPath()
    
    static var previews: some View {
        ApartmentLandlordView(navigationStack: $stack, userUID: "1234567")
    }
}
