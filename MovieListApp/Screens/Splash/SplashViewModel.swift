import Foundation

protocol APICaller {
    
    func fetchTrendingItems()
    func fetchTopRatedItems()
    func fetchPopularItems()
    func fetchUpcomingItems()
    
    var trendingMovies: [Movie] { get set }
    var topRatedMovies: [Movie] { get set }
    var popularMovies : [Movie] { get set }
    var upcomingMovies: [Movie] { get set }
    var searchingMovies:[Movie] { get set }
    var movieService  : MovieNetworking { get }
    
    var splashScreenOutput: SplashScreenOutput? { get }
    
    func setDelegate(output: SplashScreenOutput)
    
}

class SplashViewModel: APICaller {
   
    var splashScreenOutput: SplashScreenOutput?
    
    var trendingMovies: [Movie] = []
    var topRatedMovies: [Movie] = []
    var popularMovies : [Movie] = []
    var upcomingMovies: [Movie] = []
    var searchingMovies:[Movie] = []
    
    let movieService: MovieNetworking
    
    init() {
        movieService = MovieService()
    }
    
    func setDelegate(output: SplashScreenOutput) {
        splashScreenOutput = output
    }
    
    func fetchTrendingItems() {
        movieService.fetchTrendingMovies { [weak self] (response) in
            self?.trendingMovies = response ?? []
            self?.splashScreenOutput?.trendingData(movies: self?.trendingMovies ?? [])
        }
    }
    
    func fetchTopRatedItems() {
        movieService.fetchTopRatingMovies { [weak self] (response) in
            self?.topRatedMovies = response ?? []
            self?.splashScreenOutput?.topRatedData(movies: self?.topRatedMovies ?? [])
        }
    }
    
    func fetchPopularItems() {
        movieService.fetchPopularMovies { [weak self] (response) in
            self?.popularMovies = response ?? []
            self?.splashScreenOutput?.popularData(movies: self?.popularMovies ?? [])
            
        }
    }
    
    func fetchUpcomingItems() {
        movieService.fetchUpcomingMovies { [weak self] (response) in
            self?.upcomingMovies = response ?? []
            self?.splashScreenOutput?.upcomingData(movies: self?.upcomingMovies ?? [])
        }
    }
}
