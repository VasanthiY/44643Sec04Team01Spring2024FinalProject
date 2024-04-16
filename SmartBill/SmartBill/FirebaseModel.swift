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

    public static func fetchUserName(emailId: String) async -> String {
        let userCollection = db.collection("userinfo")
        do{
            let userDocuments = try await userCollection.getDocuments().documents
            
            for user in userDocuments{
                print(user)
                if user.exists {
                    let userData = user.data()
                    
                    let email = userData["email"] as? String ?? "N/A"
                    let name = userData["username"] as? String ?? "N/A"
                    
                    if email == emailId {
                        return name
                    }
                }
            }
        } catch {
            print("Error getting document: \(error)")
        }
        return "nil"
    }
}
