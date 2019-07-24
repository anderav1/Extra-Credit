import Foundation

#warning("Problems 1-4")

/*** 1 ***/

struct BerryList: Decodable {
    let items: [URL]              //let results: [NameUrlPair]
    
    // Write CodingKeys and custom init(from decoder: Decoder) here
    private enum CodingKeys: String, CodingKey {
        case items = "results"
    }
    
    #warning("Was there a different guard implementation we were supposed to use?")
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let itemPairs = try values.decode([NameUrlPair].self, forKey: .items)
        items = itemPairs.map { return $0.url }
    }
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
    private enum CodingKeys: String, CodingKey {
        case id
        case growthTime = "growth_time"
        case maxHarvest = "max_harvest"
        case naturalGiftPower = "natural_gift_power"
        case size
        case smoothness
        case soilDryness = "soil_dryness"
        case firmness
        case flavors
        case item
        case naturalGiftType = "natural_gift_type"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        growthTime = try values.decode(Int.self, forKey: .growthTime)
        maxHarvest = try values.decode(Int.self, forKey: .maxHarvest)
        naturalGiftPower = try values.decode(Int.self, forKey: .naturalGiftPower)
        size = try values.decode(Int.self, forKey: .size)
        smoothness = try values.decode(Int.self, forKey: .smoothness)
        soilDryness = try values.decode(Int.self, forKey: .soilDryness)
        
        let firmnessPair = try values.decode(NameUrlPair.self, forKey: .firmness)
        firmness = firmnessPair.name
        
        flavors = try values.decode([BerryFlavorMap].self, forKey: .flavors)
        
        let itemPair = try values.decode(NameUrlPair.self, forKey: .item)
        item = itemPair.name
        
        let naturalGiftTypePair = try values.decode(NameUrlPair.self, forKey: .naturalGiftType)
        naturalGiftType = naturalGiftTypePair.name
    }
}

struct BerryFlavorMap: Decodable {
    let potency: Int
    let flavor: String              //NameUrlPair
    
    // Write CodingKeys and custom init(from decoder: Decoder) here
    private enum CodingKeys: String, CodingKey {
        case potency
        case flavor
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        potency = try values.decode(Int.self, forKey: .potency)
        
        let flavorPair = try values.decode(NameUrlPair.self, forKey: .flavor)
        flavor = flavorPair.name
    }
}

/*** 2 ***/

// Complete result typealias' here
typealias BerryListResult = Result<Data, BerryListError>
typealias BerryResult = Result<Data, BerryError>

#warning("Is this error struct correct?")
struct BerryListError: Error {
    let message: String
    let code: Int?
}

struct BerryError: Error {
    let message: String
    let code: Int?
}

final class BerryServiceClient {
    private let baseServiceClient: BaseServiceClient
    private let urlProvider: UrlProvider
    
    init(baseServiceClient: BaseServiceClient, urlProvider: UrlProvider) {
        self.baseServiceClient = baseServiceClient
        self.urlProvider = urlProvider
    }

    /*** 3 ***/
    
    // Complete problem 2 before beginning this section so that the real function signature may be un-commented
    func getBerryList() {//(completion: @escaping (BerryListResult) -> ()) {
        let pathComponents = ["berry"]
        let parameters = ["offset": "\(0)", "limit": "\(64)"]
        let url = urlProvider.url(forPathComponents: pathComponents, parameters: parameters)
        
        // Write function body here (will make service call here)
        // make service call, if no error, parse the data
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
