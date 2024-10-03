//
//  ApartmentLandlordModel.swift
//  RentInDubai
//
//  Created by Гриша Шкробов on 19.08.2024.
//

import Foundation

class ApartmentLandlordModel: ObservableObject{
    
    public static let shared = ApartmentLandlordModel()
    
    private init(){
    }
    
    var userUID = ""
    
    @Published var appartments: [Appartment]?
    
    func getUserAppartments(){
        Task{
            let appart = await FirebaseService.shared.getUserAppartment()
            DispatchQueue.main.async {
                self.appartments = appart
            }
        }
    }
    
}

struct Appartment: Codable, Identifiable, Hashable{
    var id = UUID()
    let idFirebase: String?
    let name: String
    let description: String
    let address: String
    let email: String
    let phoneNumber: String
    
    init(id: UUID = UUID(), idFirebase: String? = nil, name: String, description: String, address: String, email: String, phoneNumber: String) {
        self.id = id
        self.idFirebase = idFirebase
        self.name = name
        self.description = description
        self.address = address
        self.email = email
        self.phoneNumber = phoneNumber
    }
}
