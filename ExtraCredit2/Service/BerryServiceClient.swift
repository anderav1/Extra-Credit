import Foundation

#warning("Problems 1-4")

/*** 1 ***/

struct BerryList: Decodable {
    let items: [URL]              //let results: [NameUrlPair]
    
    // Write CodingKeys and custom init(from decoder: Decoder) here
}

struct Berry: Decodable {
    let id: Int
    let growthTime: Int
    let maxHarvest: Int
    let naturalGiftPower: Int
    let size: Int
    let smoothness: Int
    let soilDryness: Int
    let firmness: String            //NameUrlPair
    let flavors: [BerryFlavorMap]
    let item: String                //NameUrlPair
    let naturalGiftType: String     //NameUrlPair
    
    // Write CodingKeys and custom init(from decoder: Decoder) here
}

struct BerryFlavorMap: Decodable {
    let potency: Int
    let flavor: String              //NameUrlPair
    
    // Write CodingKeys and custom init(from decoder: Decoder) here
}

/*** 2 ***/

// Complete result typealias' here
//typealias BerryListResult =
//typealias BerryResult =

final class BerryServiceClient {
    private let baseServceClient: BaseServiceClient
    private let urlProvider: UrlProvider
    
    init(baseServceClient: BaseServiceClient, urlProvider: UrlProvider) {
        self.baseServceClient = baseServceClient
        self.urlProvider = urlProvider
    }

    /*** 3 ***/
    
    // Complete problem 2 before beginning this section so that the real function signature may be un-commented
    func getBerryList() {//(completion: @escaping (BerryListResult) -> ()) {
        let pathComponents = ["berry"]
        let parameters = ["offset": "\(0)", "limit": "\(64)"]
        let url = urlProvider.url(forPathComponents: pathComponents, parameters: parameters)
        
        // Write function body here
    }
    
    /*** 4 ***/
    
    // Complete problem 2 before beginning this section so that the real function signature may be un-commented
    func getBerry(id: Int) {//(id: Int, completion: @escaping (BerryResult) -> ()) {
        let pathComponents = ["berry", "\(id)"]
        let parameters: [String: String] = [:]
        let url = urlProvider.url(forPathComponents: pathComponents, parameters: parameters)
        
        // Write function body here
    }
}
