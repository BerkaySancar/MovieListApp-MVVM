import UIKit

enum Sections: Int {
    case TrendingMovies = 0
    case TopRatedMovies = 1
    case PopularMovies = 2
    case UpcomingMovies = 3
}

final class HomeViewController: UIViewController {
   
    private var viewModel: APICaller = SplashViewModel()
    
    private let topics = ["Trending", "Top Rated", "Popular", "Upcoming"]
    private var searchingMovies: [Movie] = []
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        viewModel.fetchTrendingItems()
        viewModel.fetchPopularItems()
        viewModel.fetchUpcomingItems()
        viewModel.fetchTopRatedItems()
       
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet.circle"), style: UIBarButtonItem.Style.done, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.topItem?.title = "Movie List App"
    
    }
    
}
// MARK: - UISearchResultsUpdating
extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text,
              text.trimmingCharacters(in: CharacterSet.whitespaces).count >= 1
                        else {return}
        
        guard let resultController = searchController.searchResultsController as? SearchResultsViewController else { return }
        
        MovieService.shared.fetchSearchingMovies(with: text) { [weak self] (response) in
            self?.searchingMovies = response ?? []
        }
        resultController.movie = searchingMovies
        resultController.tableView.reloadData()
        
    }
}

// MARK: - TableView
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
            cell.configure(with: viewModel.trendingMovies)
        case Sections.TopRatedMovies.rawValue:
            cell.configure(with: viewModel.topRatedMovies)
        case Sections.PopularMovies.rawValue:
            cell.configure(with: viewModel.popularMovies)
        case Sections.UpcomingMovies.rawValue:
            cell.configure(with: viewModel.upcomingMovies)
            
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
extension HomeViewController: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: DetailViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = DetailsViewController()
            vc.design(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
