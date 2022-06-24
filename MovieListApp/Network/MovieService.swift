import Foundation

protocol MovieNetworking {
    func fetchTrendingMovies(response: @escaping ([Movie]?) -> Void)
    func fetchTopRatingMovies(response: @escaping ([Movie]?) -> Void)
    func fetchPopularMovies(response: @escaping ([Movie]?) -> Void)
    func fetchUpcomingMovies(response: @escaping ([Movie]?) -> Void)
}

struct MovieService: MovieNetworking {
    
    func fetchTrendingMovies(response: @escaping ([Movie]?) -> Void) {
        guard let url = URL(string: "\(Config.BASE_URL)/3/trending/all/day?api_key=\(Config.API_KEY)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in

            guard let data = data, error == nil else {
                response(nil)
                return
            }
            
            do {
                let results = try JSONDecoder().decode(BaseResponse.self, from: data)
                response(results.results)
                print(results)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func fetchTopRatingMovies(response: @escaping ([Movie]?) -> Void) {
        guard let url = URL(string: "\(Config.BASE_URL)/3/movie/top_rated?api_key=\(Config.API_KEY)&language=en-US") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                response(nil)
                return
            }
            
            do {
                let results = try JSONDecoder().decode(BaseResponse.self, from: data)
                response(results.results)
                print(results)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func fetchPopularMovies(response: @escaping ([Movie]?) -> Void) {
        
        guard let url = URL(string: "\(Config.BASE_URL)/3/movie/popular?api_key=\(Config.API_KEY)&language=en-US") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                response(nil)
                return
            }
            
            do {
                let results = try JSONDecoder().decode(BaseResponse.self, from: data)
                print(results)
                response(results.results)
            } catch {
                print(error)
            }
        }
        task.resume()
    }

    func fetchUpcomingMovies(response: @escaping ([Movie]?) -> Void) {
        guard let url = URL(string: "\(Config.BASE_URL)/3/movie/upcoming?api_key=\(Config.API_KEY)&language=en-US") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                response(nil)
                return
            }
            
            do {
                let results = try JSONDecoder().decode(BaseResponse.self, from: data)
                print(results)
                response(results.results)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}

//func getTrendingMovies() {
//
//    guard let url = URL(string: "\(Config.BASE_URL)/3/trending/all/day?api_key=\(Config.API_KEY)") else { return }
//    let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
//
//        guard let data = data, error == nil else { return }
//
//        do {
//            let results = try JSONDecoder().decode(BaseResponse.self, from: data)
//            print(results)
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//    task.resume()
//}
//
//func getTopRatingMovies() {
//
//    guard let url = URL(string: "\(Config.BASE_URL)/3/movie/top_rated?api_key=\(Config.API_KEY)&language=en-US") else { return }
//    let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
//
//        guard let data = data, error == nil else { return }
//
//        do {
//            let results = try JSONDecoder().decode(BaseResponse.self, from: data)
//            print(results)
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//    task.resume()
//}
//
//func getPopularMovies() {
//
//    guard let url = URL(string: "\(Config.BASE_URL)/3/movie/popular?api_key=\(Config.API_KEY)&language=en-US") else { return }
//    let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
//
//        guard let data = data, error == nil else { return }
//
//        do {
//            let results = try JSONDecoder().decode(BaseResponse.self, from: data)
//            print(results)
//        } catch {
//            print(error)
//        }
//    }
//    task.resume()
//}
//
//func getUpcomingMovies() {
//
//    guard let url = URL(string: "\(Config.BASE_URL)/3/movie/upcoming?api_key=\(Config.API_KEY)&language=en-US") else { return }
//    let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
//
//        guard let data = data, error == nil else { return }
//
//        do {
//            let results = try JSONDecoder().decode(BaseResponse.self, from: data)
//            print(results)
//        } catch {
//            print(error)
//        }
//    }
//    task.resume()
//}
