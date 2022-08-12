import UIKit

protocol HomeViewControllerOutput {
    
    func trendingData(movies: [Movie])
    func popularData(movies: [Movie])
    func topRatedData(movies: [Movie])
    func upcomingData(movies: [Movie])
}

enum Sections: Int {
    case TrendingMovies = 0
    case TopRatedMovies = 1
    case PopularMovies = 2
    case UpcomingMovies = 3
}

final class HomeViewController: UIViewController {
 
    private let search: UISearchController = {
        let search = UISearchController(searchResultsController: SearchResultsViewController())
        search.obscuresBackgroundDuringPresentation = false //hide background
        search.searchBar.placeholder = "Type Movie name here to search"
        search.searchBar.searchBarStyle = .prominent
        return search
    }()
    
    private let homeTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        tableView.backgroundColor = .systemBackground
        return tableView
    }()
    
    private var movies: [Movie] = [Movie]()
    private var topRated: [Movie] = [Movie]()
    private var popular: [Movie] = [Movie]()
    private var upcoming: [Movie] = [Movie]()
    private var trending: [Movie] = [Movie]()
    private var searchingMovies: [Movie] = [Movie]()
    private let topics = ["Trending", "Top Rated", "Popular", "Upcoming"]
    
    lazy var viewModel: HomeViewModelDelegate = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        
        viewModel.setDelegate(output: self)
        viewModel.fetchTrendingItems()
        viewModel.fetchCategoryMovies()
    }
   
    private func configure() {
        view.backgroundColor = .systemBackground
        view.addSubview(homeTableView)
        homeTableView.delegate = self
        homeTableView.dataSource = self
        search.searchResultsUpdater = self
        
        homeTableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        navigationItem.searchController = search
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.topItem?.title = "Movie List App"
    }
}
// MARK: -  HOME TABLEVIEW
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return topics.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else { return UITableViewCell() }
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            cell.configure(with: trending)
        case Sections.TopRatedMovies.rawValue:
            cell.configure(with: topRated)
        case Sections.PopularMovies.rawValue:
            cell.configure(with: popular)
        case Sections.UpcomingMovies.rawValue:
            cell.configure(with: upcoming)
        default:
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return topics[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        header.textLabel?.textColor = .label
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}
// MARK: - UISearchResultsUpdating
extension HomeViewController: UISearchResultsUpdating, SearchResultsViewControllerDelegate {
  
    func updateSearchResults(for searchController: UISearchController) {
        guard let resultController = searchController.searchResultsController as? SearchResultsViewController else { return }
        
        viewModel.movieService.fetchSearchingMovies(with: searchController.searchBar.text!) { [weak self] (response) in
            self?.searchingMovies = response?.results ?? []
        } failure: { error in
            print(error)
        }

        resultController.movie = searchingMovies
        resultController.tableView.reloadData()
        resultController.delegate = self
    }
    
    func SearchResultsViewControllerDidTapMovie(_ viewModel: DetailViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = DetailsViewController()
            vc.design(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
extension HomeViewController: HomeViewControllerOutput {
    
    func upcomingData(movies: [Movie]) {
        upcoming = movies
        self.homeTableView.reloadData()
    }
    func popularData(movies: [Movie]) {
        popular = movies
    }
    func topRatedData(movies: [Movie]) {
        topRated = movies
    }
    func trendingData(movies: [Movie]) {
        trending = movies
    }
}
//MARK: - CELL ITEM --> DETAILSVIEWCONTROLLER
extension HomeViewController: CollectionViewTableViewCellDelegate {
    
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: DetailViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = DetailsViewController()
            vc.design(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
