import Foundation

/*** 1 ***/

struct BerryList: Decodable {
    let items: [URL]              //let results: [NameUrlPair]
    
    private enum CodingKeys: String, CodingKey {
        case items = "results"
    }
    
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

typealias BerryListResult = Result<BerryList, ServiceCallError>
typealias BerryResult = Result<Berry, ServiceCallError>

final class BerryServiceClient {
    private let baseServiceClient: BaseServiceClient
    private let urlProvider: UrlProvider
    
    init(baseServiceClient: BaseServiceClient, urlProvider: UrlProvider) {
        self.baseServiceClient = baseServiceClient
        self.urlProvider = urlProvider
    }

    /*** 3 ***/
    
    func getBerryList(completion: @escaping (BerryListResult) -> ()) {
        let pathComponents = ["berry"]
        let parameters = ["offset": "\(0)", "limit": "\(64)"]
        let url = urlProvider.url(forPathComponents: pathComponents, parameters: parameters)
        
        baseServiceClient.get(from: url) { result in
            switch result {
            case .success(let data):
                guard let berryList = try? JSONDecoder().decode(BerryList.self, from: data) else {
                    completion(.failure(ServiceCallError(message: "Failed to parse JSON", code: nil)))
                    return
                }
                completion(.success(berryList))
                
            case .failure(let error):
                completion(.failure(error))
                return
            }
        }
    }
    
    /*** 4 ***/
    
    func getBerry(id: Int, completion: @escaping (BerryResult) -> ()) {
        let pathComponents = ["berry", "\(id)"]
        let parameters: [String: String] = [:]
        let url = urlProvider.url(forPathComponents: pathComponents, parameters: parameters)
        
        baseServiceClient.get(from: url) { result in
            switch result {
            case .success(let data):
                guard let berry = try? JSONDecoder().decode(Berry.self, from: data) else {
                    completion(.failure(ServiceCallError(message: "Failed to parse JSON", code: nil)))
                    return
                }
                completion(.success(berry))
                
            case .failure(let error):
                completion(.failure(error))
                return
            }
        }
    }
}
