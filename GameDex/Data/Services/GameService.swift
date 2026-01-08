//
//  GameService.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 20/07/25.
//

import Combine

class GameService {
    private var service: APIServiceProtocol
    
    init(service: APIServiceProtocol) {
        self.service = service
    }
    
    func getGameList(
        search: String,
        sort: Sort
    ) -> AnyPublisher<[GameItem], APIError> {
        let url = "/games"
        
        let sortValue = sort == .latest ? "-released" : "released"
        let parameters = ["search": search, "ordering": sortValue]

        return service.fetch(
            endpoint: url,
            inputParameters: parameters,
            responseType: GameListResponse.self
        )
        .map { res in res.toModel() }
        .eraseToAnyPublisher()
    }
    
    func getGameDetail(
        id: String
    ) -> AnyPublisher<GameDetail, APIError> {
        let url = "/games/\(id)"

        return service.fetch(
            endpoint: url,
            inputParameters: [:],
            responseType: GameDetailResponse.self
        )
        .map { res in res.toModel() }
        .eraseToAnyPublisher()
    }
}
