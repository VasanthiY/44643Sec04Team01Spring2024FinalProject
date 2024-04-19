//
//  FirebaseModel.swift
//  SmartBill
//
//  Created by Krishna Vasanthi on 4/11/24.
//

import Foundation
import FirebaseFirestore

struct Product: Codable{
    let name: String
    let price: Double
    let pic: String
}

struct Bill: Codable{
    let items: String
    let price: Double
}

struct FireStoreOperations {
    static let db = Firestore.firestore()
    static var products: [Product] = []
    static var productnames: [String] = []
    static var productprices:[String:Double] = [:]
    static var billsinfo:[Bill] = []
    static var emailId: String = ""
    static var userName: String = ""
    static var cartItems:[String:Int] = [:]

    public static func fetchUserName() async {
        let userCollection = db.collection("userinfo")
        do{
            let userDocuments = try await userCollection.getDocuments().documents
            
            for user in userDocuments{
                if user.exists {
                    let userData = user.data()
                    
                    let email = userData["email"] as? String ?? "N/A"
                    let name = userData["username"] as? String ?? "N/A"
                    
                    if email == emailId {
                        userName = name
                    }
                }
            }
        } catch {
            print("Error getting document: \(error)")
        }
    }
    
    public static func saveUserName(data:[String : Any]){
        db.collection("userinfo").addDocument(data: data){ error in
            if let error = error {
                print("Error saving data: \(error.localizedDescription)")
            } else {
                print("Data saved successfully.")
            }
        }
    }
    
    public static func fetchProducts() async{
        
        let productcollection = db.collection("products")
        do{
            let productDocuments = try await productcollection.getDocuments().documents
            
            for product in productDocuments{
                if product.exists {
                    let productData = product.data()
                    
                    let name = productData["name"] as? String ?? "N/A"
                    let pic = productData["pic"] as? String ?? "N/A"
                    let price = productData["price"] as? Double ?? 0
                    let prod = Product(name: name, price: price, pic: pic)
                    products.append(prod)
                } else{
                    print("Document does not exist")
                    
                }
            }
        } catch {
            print("Error getting document: \(error)")
        }
        
    }
    
    public static func getProductNames() async{
        await fetchProducts()
        for product in products{
            productnames.append(product.name.lowercased())
        }
    }
    
    public static func getProductPrice() async{
        await fetchProducts()
        for product in products {
            productprices[product.name.lowercased()] = product.price
        }
    }
    
    public static func saveBill(data:[String : Any]){
        db.collection("bills").addDocument(data: data){ error in
            if let error = error {
                print("Error saving data: \(error.localizedDescription)")
            } else {
                print("Data saved successfully.")
            }
        }
    }
    
    public static func fetchBills() async{
        let billcollection = db.collection("bills")
        do{
            let bills = try await billcollection.getDocuments().documents
            
            for bill in bills{
                if bill.exists {
                    let billData = bill.data()
                    
                    let items = billData["items"] as? String ?? "N/A"
                    let price = billData["totalcost"] as? Double ?? 0
                    let billinfo = Bill(items: items, price: price)
                    billsinfo.append(billinfo)
                } else{
                    print("Document does not exist")
                    
                }
            }
        } catch {
            print("Error getting document: \(error)")
        }
    }
    
    
    public static func deletebill(name:String){
        let collection = "bills"
        
        let col = "items"
        let val = name
        
        db.collection(collection).whereField(col, isEqualTo: val).getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No documents found.")
                    return
                }
                
                // Delete each document that matches the query result
                for document in documents {
                    db.collection(collection).document(document.documentID).delete { error in
                        if let error = error {
                            print("Error deleting document: \(error.localizedDescription)")
                        } else {
                            print("Document deleted successfully.")
                        }
                    }
                }
            }
        


    }
    
    
    public static func updatebill(name:String, price:Double){
            let fieldName = "items"
            let fieldValue = name
            let newFieldData: [String: Any] = [
                "totalcost": 100
            ]

            // Query for documents with the specified field value
            db.collection("bills").whereField(fieldName, isEqualTo: fieldValue).getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No documents found.")
                    return
                }
                
                // Update each document that matches the query result
                for document in documents {
                    db.collection("bills").document(document.documentID).updateData(newFieldData) { error in
                        if let error = error {
                            print("Error updating document: \(error.localizedDescription)")
                        } else {
                            print("Document updated successfully.")
                        }
                    }
                }
            }
    }
}
