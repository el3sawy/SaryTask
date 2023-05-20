//
//  Network.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 18/05/2023.
//

import RxSwift

protocol NetworkProtocol {
    func request<T: BaseModel>(_ url: BaseURLRequest) -> Observable<T>
}

final class Network {
    // MARK: - Properties
    static let shared = Network()
    private let responseError: ResponseErrorProtocol
    private let parser: JsonParserProtocol
    private var session: URLSession
    
    // MARK: - Init
    private init(session: URLSession = URLSession(configuration: .default),
                 responseError: ResponseErrorProtocol = NetworkResponseError(),
                 parser: JsonParserProtocol = JsonParser()) {
        self.session = session
        self.responseError = responseError
        self.parser = parser
    }
}

extension Network: NetworkProtocol {
    func request<T: BaseModel>(_ url: BaseURLRequest) -> Observable<T> {
        return Observable.create { [weak self] observer in
            
            self?.requestClient(url) { (result: Result<T, NetworkError>) in
                switch result {
                    
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
        .observe(on: MainScheduler.instance)
    }
    
    func requestClient<T: BaseModel>(_ url: BaseURLRequest, completionHandler:  @escaping (Result<T, NetworkError>) -> Void) {
        let request = url.urlRequest()
        
        session.dataTask(with: request) { [weak self] data, _, error in
            
            guard let self = self else { return }
            
            if let responseError = error { // Response error
                let responseError = self.responseError.filter(error: responseError)
                completionHandler(.failure(responseError))
                
                
            } else if let responseData = data { // Success response
                let result: Result<T, NetworkError> = self.parser.parse(data: responseData)
                completionHandler(result)
            }
        }.resume()
    }
}
