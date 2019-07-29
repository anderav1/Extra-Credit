import Foundation

// NOTE: - Consult README for problem instructions

/*
 NOTE: -
 
 - struct NameUrlPair provided for you in Utilities directory
 - BaseServiceClient, UrlProvider, BerryServiceClient, AbilityServiceClient
    provided for you in Service directory, objects defined below
 
 */

//let abilityPath = "/Users/avabc5/Desktop/Extra-Credit/ExtraCredit2/Reference/stench.json"
//let abilityUrl = URL(fileURLWithPath: abilityPath)





let baseServiceClient = BaseServiceClient()
let urlProvider = UrlProvider(baseUrl: URL(string: "https://pokeapi.co/api/v2/")!)

/*** Problems 1-4 ***/

let berryServiceClient = BerryServiceClient(baseServiceClient: baseServiceClient, urlProvider: urlProvider)

//berryServiceClient.getBerryList { result in
//    switch result {
//    case .success(let list): print("count: \(list.items.count)\npokedex: \(list)"); exit(0)
//    case .failure(let error): print(error); exit(1)
//    }
//}

//berryServiceClient.getBerry(id: 3) { result in
//    switch result {
//    case .success(let berry): print(berry); exit(0)
//    case .failure(let error): print(error); exit(1)
//    }
//}

/*** Problems 5-8 ***/

let abilityServiceClient = AbilityServiceClient(baseServiceClient: baseServiceClient, urlProvider: urlProvider)

//abilityServiceClient.getAbilityList { result in
//    switch result {
//    case .success(let list): print("count: \(list.items.count)\npokedex: \(list)"); exit(0)
//    case .failure(let error): print(error); exit(1)
//    }
//}
//
abilityServiceClient.getAbility(id: 3) { result in
    switch result {
    case .success(let ability): print(ability); exit(0)
    case .failure(let error): print(error); exit(1)
    }
}

// WARNING: - DO NOT DELETE THE FOLLOWING LINE
dispatchMain()
