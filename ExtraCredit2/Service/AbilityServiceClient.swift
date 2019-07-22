import Foundation

#warning("Problems 5-8")

/*** 5 ***/

struct AbilityList: Decodable {
    let items: [URL]              //let results: [NameUrlPair]
    
    // Write CodingKeys and custom init(from decoder: Decoder) here
}

struct Ability: Decodable {
    let id: Int
    let name: String
    let isMainSeries: Bool
    let generation: String          //NameUrlPair
    let names: [Name]
    let effectEntries: [EffectEntry]
    let effectChanges: [EffectChange]
    let flavorTextEntries: [FlavorTextEntry]
    let pokemon: [PokemonForAbility]
    
    // Write CodingKeys and custom init(from decoder: Decoder) here
}

struct Name: Decodable {
    let language: String            //NameUrlPair
    let value: String               //let name: String
    
    // Write CodingKeys and custom init(from decoder: Decoder) here
}

struct EffectEntry: Decodable {
    let effect: String
    let language: String            //NameUrlPair
    let shortEffect: String?        // HINT: - decodeIfPresent
    
    // Write CodingKeys and custom init(from decoder: Decoder) here
}

struct EffectChange: Decodable {
    let effectEntries: [EffectEntry]
    let versionGroup: String        //NameUrlPair
    
    // Write CodingKeys and custom init(from decoder: Decoder) here
}

struct FlavorTextEntry: Decodable {
    let flavorText: String
    let language: String            //NameUrlPair
    let versionGroup: String        //NameUrlPair
    
    // Write CodingKeys and custom init(from decoder: Decoder) here
}

struct PokemonForAbility: Decodable {
    let isHidden: Bool
    let pokemon: String             //NameUrlPair
    let slot: Int
    
    // Write CodingKeys and custom init(from decoder: Decoder) here
}

/*** 6 ***/

// Complete result typealias' here
//typealias AbilityListResult =
//typealias AbilityResult =

final class AbilityServiceClient {
    private let baseServceClient: BaseServiceClient
    private let urlProvider: UrlProvider
    
    init(baseServceClient: BaseServiceClient, urlProvider: UrlProvider) {
        self.baseServceClient = baseServceClient
        self.urlProvider = urlProvider
    }

    /*** 7 ***/
    
    // Complete problem 6 before beginning this section so that the real function signature may be un-commented
    func getAbilityList() {//(completion: @escaping (AbilityListResult) -> ()) {
        let pathComponents = ["ability"]
        let parameters = ["offset": "\(0)", "limit": "\(293)"]
        let url = urlProvider.url(forPathComponents: pathComponents, parameters: parameters)
        
        // Write function body here
    }
    
    /*** 8 ***/
    
    // Complete problem 6 before beginning this section so that the real function signature may be un-commented
    func getAbility(id: Int) {//(id: Int, completion: @escaping (AbilityResult) -> ()) {
        let pathComponents = ["ability", "\(id)"]
        let parameters: [String: String] = [:]
        let url = urlProvider.url(forPathComponents: pathComponents, parameters: parameters)
        
        // Write function body here
    }
}
