//
//  HomeViewModel.swift
//  MovieListApp
//
//  Created by Berkay Sancar on 12.08.2022.
//

import Foundation

protocol HomeViewModelDelegate {
    
    func fetchTrendingItems()
    func fetchCategoryMovies()
    
    var trendingMovies: [Movie] { get set }
    var topRatedMovies: [Movie] { get set }
    var popularMovies : [Movie] { get set }
    var upcomingMovies: [Movie] { get set }
    var movieService  : MovieService { get }
    
    var homeScreenOutput: HomeViewControllerOutput? { get }
    
    func setDelegate(output: HomeViewControllerOutput)
    
}

final class HomeViewModel: HomeViewModelDelegate {
   
    var trendingMovies: [Movie] = []
    var topRatedMovies: [Movie] = []
    var popularMovies : [Movie] = []
    var upcomingMovies: [Movie] = []
    
    var movieService: MovieService
    var homeScreenOutput: HomeViewControllerOutput?
    
    
    init() {
        movieService = MovieService()
    }
    
    func setDelegate(output: HomeViewControllerOutput) {
        homeScreenOutput = output
    }
    
    func fetchTrendingItems() {
       
        movieService.fetchTrendingMovies { [weak self] (response) in
            self?.trendingMovies = response?.results ?? []
            self?.homeScreenOutput?.trendingData(movies: self?.trendingMovies ?? [])
        } failure: { error in
            print(error)
        }
    }
    
    func fetchCategoryMovies() {
        movieService.fetchMoviesWithCategory(category: "top_rated") { [weak self] (response) in
            self?.topRatedMovies = response?.results ?? []
            self?.homeScreenOutput?.topRatedData(movies: self?.topRatedMovies ?? [])
        } failure: { error in
            print(error)
        }
        
        movieService.fetchMoviesWithCategory(category: "popular") { [weak self] (response) in
            self?.popularMovies = response?.results ?? []
            self?.homeScreenOutput?.popularData(movies: self?.popularMovies ?? [])
        } failure: { error in
            print(error)
        }
        
        movieService.fetchMoviesWithCategory(category: "upcoming") { [weak self] (response) in
            self?.upcomingMovies = response?.results ?? []
            self?.homeScreenOutput?.upcomingData(movies: self?.upcomingMovies ?? [])
        } failure: { error in
            print(error)
        }
    }
}
