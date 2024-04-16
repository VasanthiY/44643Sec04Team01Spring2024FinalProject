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
}
