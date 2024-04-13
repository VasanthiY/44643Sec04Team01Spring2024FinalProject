


struct CartItem: Codable {
    let billGenerated: Bool
    let cost: Int
    let email: String
    let image: String
}

struct Item {
    let title: String
    let desc: String
    let category: String
    let documentID: String
    let price:Int
    let imageUrl:String
}
 
