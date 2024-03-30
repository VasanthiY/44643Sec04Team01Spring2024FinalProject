//
//  ProductModel.swift
//  
//
//  Created by Jameer Babu on 3/29/24.
//

import Foundation

struct FireStoreOperations{
    
    static let db = Firestore.firestore()
    static var products: [ Product] = []
    
    public static func fetchProducts() async{
        
        let db = Firestore.firestore()
        let productsRef = db.collection("products")
        
        
        productsRef.getDocuments { (querySnapshot, error) in
                    if let error = error {
                        print("Error getting documents: \(error)")
                    } else {
                        for document in querySnapshot!.documents {
                            let data = document.data()
                            let title = productData?["title"] as? String ?? "N/A"
                            let url = productData?["URL"] as? String ?? "N/A"
                            let price = productData?["price"] as? Double ?? 0
                            
                            
                            let product = Product(title: title, URL: url, price: price)
                        }
                    }
                }
    }
}
