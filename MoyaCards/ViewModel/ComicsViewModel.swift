//
//  ComicsViewModel.swift
//  MoyaCards
//
//  Created by Saw Pyae Yadanar on 27/4/2567 BE.
//

import Foundation
import Moya
import RxSwift
import RxRelay

class ComicsViewModel {
    
    enum State {
        case idle
        case loading
        //case ready([Comic])
        case error(Error)
    }
    
    var comics = BehaviorSubject(value: [Comic]())
    var state = BehaviorRelay<State>(value: .idle)
    private let provider : MoyaProvider<Marvel>
    
    init(provider: MoyaProvider<Marvel> = MoyaProvider<Marvel>()) {
        self.provider = provider
    }
    
    func fetchComics() {
        state.accept(.loading)
        provider.request(.comics) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                do {
                    let filterResponse = try response.filterSuccessfulStatusCodes()
                    let data = try filterResponse.map(MarvelResponse<Comic>.self).data.results
                    self.comics.on(.next(data))
                    state.accept(.idle)
                } catch (let error)  {
                    state.accept(.error(error))
                }
            case .failure (let error):
                state.accept(.error(error))
            }
        }
    }
}
