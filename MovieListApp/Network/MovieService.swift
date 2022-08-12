import Foundation

import Alamofire

protocol MovieServiceProtocol {
    func fetchTrendingMovies(success: @escaping (BaseResponse?) -> Void,
                             failure: @escaping (AFError) -> Void)
    func fetchMoviesWithCategory(category: String,
                                 success: @escaping (BaseResponse?) -> Void,
                                 failure: @escaping (AFError) -> Void)
    func fetchSearchingMovies(with query: String,
                              success: @escaping (BaseResponse?) -> Void,
                              failure: @escaping (AFError) -> Void)
}

struct MovieService: MovieServiceProtocol {
    
    func fetchTrendingMovies(success: @escaping (BaseResponse?) -> Void,
                             failure: @escaping (AFError) -> Void) {
        
        let url: String = "\(Constants.BASE_URL)trending/all/day?api_key=\(Constants.API_KEY)&language=en-US"
        ServiceManager.shared.sendRequest(url: url) { response in
            success(response)
        } failure: { error in
            failure(error)
        }

    }
    
    func fetchMoviesWithCategory(category: String,
                                 success: @escaping (BaseResponse?) -> Void,
                                 failure: @escaping (AFError) -> Void) {
        
        let url: String = "\(Constants.BASE_URL)movie/\(category)?api_key=\(Constants.API_KEY)&language=en-US"
        
        ServiceManager.shared.sendRequest(url: url) { response in
            success(response)
        } failure: { error in
            failure(error)
        }
    }

    func fetchSearchingMovies(with query: String,
                              success: @escaping (BaseResponse?) -> Void,
                              failure: @escaping (AFError) -> Void) {
        
        let url: String = "\(Constants.BASE_URL)search/movie?api_key=\(Constants.API_KEY)&language=en-US&query=\(query)"
        
        ServiceManager.shared.sendRequest(url: url) { response in
            success(response)
        } failure: { error in
            failure(error)
        }
    }
}
