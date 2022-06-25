import Foundation

protocol MovieNetworking {
    func fetchTrendingMovies(response: @escaping ([Movie]?) -> Void)
    func fetchTopRatingMovies(response: @escaping ([Movie]?) -> Void)
    func fetchPopularMovies(response: @escaping ([Movie]?) -> Void)
    func fetchUpcomingMovies(response: @escaping ([Movie]?) -> Void)
    func fetchSearchingMovies(with query: String, response: @escaping ([Movie]?) -> Void)
}

struct MovieService: MovieNetworking {
    
    static let shared = MovieService() 
    
    func fetchTrendingMovies(response: @escaping ([Movie]?) -> Void) {
        guard let url = URL(string: "\(Constants.BASE_URL)/3/trending/all/day?api_key=\(Constants.API_KEY)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in

            guard let data = data, error == nil else {
                response(nil)
                return
            }
            
            do {
                let results = try JSONDecoder().decode(BaseResponse.self, from: data)
                response(results.results)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func fetchTopRatingMovies(response: @escaping ([Movie]?) -> Void) {
        guard let url = URL(string: "\(Constants.BASE_URL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                response(nil)
                return
            }
            
            do {
                let results = try JSONDecoder().decode(BaseResponse.self, from: data)
                response(results.results)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func fetchPopularMovies(response: @escaping ([Movie]?) -> Void) {
        
        guard let url = URL(string: "\(Constants.BASE_URL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                response(nil)
                return
            }
            
            do {
                let results = try JSONDecoder().decode(BaseResponse.self, from: data)
                response(results.results)
            } catch {
                print(error)
            }
        }
        task.resume()
    }

    func fetchUpcomingMovies(response: @escaping ([Movie]?) -> Void) {
        guard let url = URL(string: "\(Constants.BASE_URL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                response(nil)
                return
            }
            
            do {
                let results = try JSONDecoder().decode(BaseResponse.self, from: data)
                response(results.results)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func fetchSearchingMovies(with query: String, response: @escaping ([Movie]?) -> Void) {
        guard let url = URL(string: "\(Constants.BASE_URL)/3/search/movie?api_key=\(Constants.API_KEY)&language=en-US&query=\(query)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                response(nil)
                return
            }
            
            do {
                let results = try JSONDecoder().decode(BaseResponse.self, from: data)
                response(results.results)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
