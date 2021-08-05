//
//  PokemonAPI.swift
//  Pokemon
//
//  Created by July on 4/08/21.
//

import Foundation
import Combine

class PokemonAPI {
    
    static let shared: PokemonAPI = PokemonAPI()
    
    private var cancellables = Set<AnyCancellable>()
    
    func pokemonListRequest(limit: Int, offset: Int, completion: @escaping ([Result]?, Bool) -> Void) {
        
        let queryItems = [URLQueryItem(name: "limit", value: String(limit)), URLQueryItem(name: "offset", value: String(offset))]
        var urlComps = URLComponents(string: EnvironmentConfig.rootURL.absoluteString + "pokemon")!
        urlComps.queryItems = queryItems
        let url = urlComps.url!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (data, response) in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: PokemonResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { response in
                switch response {
                case .failure:
                    completion([], false)
                default:
                    break
                }
            }, receiveValue: { result in
                completion(result.results, true)
            })
            .store(in: &cancellables)
    }
    
    func pokemonInfoRequest(url: String, completion: @escaping (Pokemon?, Bool) -> Void) {
        
        let urlComps = URLComponents(string: url)!
        let url = urlComps.url!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (data, response) in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: Pokemon.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { response in
                switch response {
                case .failure:
                    completion(nil, false)
                default:
                    break
                }
            }, receiveValue: { result in
                completion(result, true)
            })
            .store(in: &cancellables)
    }
}
