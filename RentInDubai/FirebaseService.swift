//
//  FirebaseService.swift
//  RentInDubai
//
//  Created by Гриша Шкробов on 19.08.2024.
//

import Foundation
import FirebaseDatabaseInternal
import FirebaseAuth

class FirebaseService{
    
    public static let shared = FirebaseService()
    
    private init(){
        
    }
    
    private var ref: DatabaseReference = Database.database().reference(fromURL: "https://rentindubai-8fad7-default-rtdb.firebaseio.com/")
    
    func getUserAppartment() async -> [Appartment]{
        
        var result: [Appartment] = []
        
        do{
            let data = try await self.ref.child("appartments/\(ApartmentLandlordModel.shared.userUID)").getData()
            let dict = data.value as? Dictionary<String, Any>
            dict?.forEach { item in
                if let appartment = item.value as? Dictionary<String, Any>{
                    result.append(Appartment(idFirebase: appartment["id"] as? String, name: appartment["name"] as! String, description: appartment["description"] as! String, address: appartment["address"] as! String, email: appartment["email"] as! String, phoneNumber: appartment["phoneNumber"] as! String))
                }
            }
        }
        catch{
            print(error.localizedDescription)
        }
        
        return result
    }
    
    func appendNewAppartment(appartment: Appartment) async -> Error? {
        
        do{
            
            let id = UUID().uuidString
            
            try await self.ref.child("appartments").child(ApartmentLandlordModel.shared.userUID).child(id)
                .setValue([
                    "name" : appartment.name,
                    "description" : appartment.description,
                    "address" : appartment.address,
                    "email" : appartment.email,
                    "phoneNumber" : appartment.phoneNumber,
                    "id" : id])
        }catch{
            return error
        }
        return nil
    }
    
    func logout(){
        do{
            try Auth.auth().signOut()
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    
}
