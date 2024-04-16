//
//  FirebaseModel.swift
//  SmartBill
//
//  Created by Krishna Vasanthi on 4/11/24.
//

import Foundation
import FirebaseFirestore


struct FireStoreOperations {
    static let db = Firestore.firestore()

    public static func fetchUserName(emailId: String) -> String async {
        let userCollection = db.collection("userinfo")
        do{
            let userDocuments = try await userCollection.getDocuments().documents
            
            for user in userDocuments{
                if user.exists {
                    let userData = user.data()
                    
                    let email = userData["email"] as? String ?? "N/A"
                    let name = productData["username"] as? String ?? "N/A"
                    
                    if email == emailId {
                        return name
                    }
                }
            }
        } catch {
            print("Error getting document: \(error)")
        }
        
    }
}
