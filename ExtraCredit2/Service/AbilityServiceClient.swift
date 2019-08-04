import Foundation

#warning("Problems 5-8")

/*** 5 ***/

struct AbilityList: Decodable {
    let items: [URL]              //let results: [NameUrlPair]
    
    // Write CodingKeys and custom init(from decoder: Decoder) here
    private enum CodingKeys: String, CodingKey {
        case items = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let itemPairs = try values.decode([NameUrlPair].self, forKey: .items)
        items = itemPairs.map { $0.url }
    }
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
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case isMainSeries = "is_main_series"
        case generation
        case names
        case effectEntries = "effect_entries"
        case effectChanges = "effect_changes"
        case flavorTextEntries = "flavor_text_entries"
        case pokemon
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        isMainSeries = try values.decode(Bool.self, forKey: .isMainSeries)

        let generationPair = try values.decode(NameUrlPair.self, forKey: .generation)
        generation = generationPair.name

        names = try values.decode([Name].self, forKey: .names)
        effectEntries = try values.decode([EffectEntry].self, forKey: .effectEntries)
        effectChanges = try values.decode([EffectChange].self, forKey: .effectChanges)
        flavorTextEntries = try values.decode([FlavorTextEntry].self, forKey: .flavorTextEntries)
        pokemon = try values.decode([PokemonForAbility].self, forKey: .pokemon)
    }
}

struct Name: Decodable {
    let language: String            //NameUrlPair
    let value: String               //let name: String
    
    // Write CodingKeys and custom init(from decoder: Decoder) here
    private enum CodingKeys: String, CodingKey {
        case language
        case value = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let languagePair = try values.decode(NameUrlPair.self, forKey: .language)
        language = languagePair.name
        
        value = try values.decode(String.self, forKey: .value)
    }
}

struct EffectEntry: Decodable {
    let effect: String
    let language: String            //NameUrlPair
    let shortEffect: String?        // HINT: - decodeIfPresent
    
    // Write CodingKeys and custom init(from decoder: Decoder) here
    private enum CodingKeys: String, CodingKey {
        case effect
        case language
        case shortEffect = "short_effect"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        effect = try values.decode(String.self, forKey: .effect)
        
        let languagePair = try values.decode(NameUrlPair.self, forKey: .language)
        language = languagePair.name
        
        shortEffect = try values.decodeIfPresent(String.self, forKey: .shortEffect)
    }
}

struct EffectChange: Decodable {
    let effectEntries: [EffectEntry]
    let versionGroup: String        //NameUrlPair
    
    // Write CodingKeys and custom init(from decoder: Decoder) here
    private enum CodingKeys: String, CodingKey {
        case effectEntries = "effect_entries"
        case versionGroup = "version_group"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        effectEntries = try values.decode([EffectEntry].self, forKey: .effectEntries)
        
        let versionGroupPair = try values.decode(NameUrlPair.self, forKey: .versionGroup)
        versionGroup = versionGroupPair.name
    }
}

struct FlavorTextEntry: Decodable {
    let flavorText: String
    let language: String            //NameUrlPair
    let versionGroup: String        //NameUrlPair
    
    // Write CodingKeys and custom init(from decoder: Decoder) here
    private enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language
        case versionGroup = "version_group"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        flavorText = try values.decode(String.self, forKey: .flavorText)
        
        let languagePair = try values.decode(NameUrlPair.self, forKey: .language)
        language = languagePair.name
        
        let versionGroupPair = try values.decode(NameUrlPair.self, forKey: .versionGroup)
        versionGroup = versionGroupPair.name
    }
}

struct PokemonForAbility: Decodable {
    let isHidden: Bool
    let pokemon: String             //NameUrlPair
    let slot: Int
    
    // Write CodingKeys and custom init(from decoder: Decoder) here
    private enum CodingKeys: String, CodingKey {
        case isHidden = "is_hidden"
        case pokemon
        case slot
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        isHidden = try values.decode(Bool.self, forKey: .isHidden)
        
        let pokemonPair = try values.decode(NameUrlPair.self, forKey: .pokemon)
        pokemon = pokemonPair.name
        
        slot = try values.decode(Int.self, forKey: .slot)
    }
}

/*** 6 ***/

// Complete result typealias' here
typealias AbilityListResult = Result<AbilityList, ServiceCallError>
typealias AbilityResult = Result<Ability, ServiceCallError>

final class AbilityServiceClient {
    private let baseServiceClient: BaseServiceClient
    private let urlProvider: UrlProvider
    
    init(baseServiceClient: BaseServiceClient, urlProvider: UrlProvider) {
        self.baseServiceClient = baseServiceClient
        self.urlProvider = urlProvider
    }

    /*** 7 ***/
    
    func getAbilityList(completion: @escaping (AbilityListResult) -> ()) {
        let pathComponents = ["ability"]
        let parameters = ["offset": "\(0)", "limit": "\(293)"]
        let url = urlProvider.url(forPathComponents: pathComponents, parameters: parameters)
        
        // Write function body here
        baseServiceClient.get(from: url) { result in
            switch result {
            case .success(let data):
                guard let abilityList = try? JSONDecoder().decode(AbilityList.self, from: data) else {
                    completion(.failure(ServiceCallError(message: "Failed to parse JSON", code: nil)))
                    return
                }
                completion(.success(abilityList))
                
            case .failure(let error):
                completion(.failure(error))
                return
            }
        }
    }
    
    /*** 8 ***/
    
    func getAbility(id: Int, completion: @escaping (AbilityResult) -> ()) {
        let pathComponents = ["ability", "\(id)"]
        let parameters: [String: String] = [:]
        let url = urlProvider.url(forPathComponents: pathComponents, parameters: parameters)
        
        // Write function body here
        baseServiceClient.get(from: url) { result in
            switch result {
            case .success(let data):
                guard let ability = try? JSONDecoder().decode(Ability.self, from: data) else {
                    completion(.failure(ServiceCallError(message: "Failed to parse JSON", code: nil)))
                    return
                }
                completion(.success(ability))
                
            case .failure(let error):
                completion(.failure(error))
                return
            }
        }
    }
}
