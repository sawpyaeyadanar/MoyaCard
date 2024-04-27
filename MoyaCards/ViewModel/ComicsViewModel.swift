//
//  ComicsViewModel.swift
//  MoyaCards
//
//  Created by Saw Pyae Yadanar on 27/4/2567 BE.
//

import Foundation
import Moya
import RxSwift

class ComicsViewModel {
    
    enum State {
        case idle
        case loading
        //case ready([Comic])
        case error(Error)
    }
    
    var comics = BehaviorSubject(value: [Comic]())
    var state = BehaviorSubject<State>(value: .idle)
    private let provider : MoyaProvider<Marvel>
    
    init(provider: MoyaProvider<Marvel> = MoyaProvider<Marvel>()) {
        self.provider = provider
    }
    
    func fetchComics() {
        state.onNext(.loading)
        provider.request(.comics) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                do {
                    let filterResponse = try response.filterSuccessfulStatusCodes()
                    let data = try filterResponse.map(MarvelResponse<Comic>.self).data.results
                    self.comics.on(.next(data))
                    state.onNext(.idle)
                } catch (let error)  {
                    state.onNext(.error(error))
                }
            case .failure (let error):
                state.onNext(.error(error))
            }
        }
    }
}
