//
//  Model.swift
//  SmartBill
//
//  Created by Jameer Babu on 4/7/24.
//

import Foundation
import Firebase

struct Product: Codable{
    let name: String
    let price: Double
    let pic: String
    
}

struct FireStoreOperations{
    
    static let db = Firestore.firestore()
    static var products: [Product] = []
    static var productnames: [String] = []
    static var productprices:[String:Double] = [:]
    
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
    
}
