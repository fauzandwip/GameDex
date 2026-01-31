//
//  GameRemoteDataSource.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 20/07/25.
//

import Combine
import Core

protocol GameRemoteDataSourceProtocol {
  func getGameList(
    search: String,
    sort: Sort
  ) -> AnyPublisher<GameListResponse, Error>
  
  func getGameDetail(
    id: Int
  ) -> AnyPublisher<GameDetailResponse, Error>
}

final class GameRemoteDataSource: GameRemoteDataSourceProtocol {
  private var service: APIServiceProtocol
  
  init(service: APIServiceProtocol) {
    self.service = service
  }
  
  func getGameList(
    search: String,
    sort: Sort
  ) -> AnyPublisher<GameListResponse, Error> {
    let url = Endpoints.Gets.games.url
    
    let sortValue = sort == .latest ? "-released" : "released"
    let parameters = ["search": search, "ordering": sortValue]
    
    return service.fetch(
      endpoint: url,
      inputParameters: parameters,
      responseType: GameListResponse.self
    )
    .eraseToAnyPublisher()
  }
  
  func getGameDetail(
    id: Int
  ) -> AnyPublisher<GameDetailResponse, Error> {
    let url = Endpoints.Gets.game(id: id).url
    
    return service.fetch(
      endpoint: url,
      inputParameters: [:],
      responseType: GameDetailResponse.self
    )
    .eraseToAnyPublisher()
  }
}
