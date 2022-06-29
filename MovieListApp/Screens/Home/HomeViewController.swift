import UIKit

enum Sections: Int {
    case TrendingMovies = 0
    case TopRatedMovies = 1
    case PopularMovies = 2
    case UpcomingMovies = 3
}

final class HomeViewController: UIViewController {
    
    private var viewModel: APICaller = SplashViewModel()
    private var searchingMovies: [Movie] = []
    
    private let topics = ["Trending", "Top Rated", "Popular", "Upcoming"]
    
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
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.topItem?.title = "Movie List App"
        
        categoriesButtonTapped()
    }
// MARK: - CATEGORY OPERATIONS
    private func categoriesButtonTapped() {
        var selectedID: Int = 0
        
        let action = UIAction(title: "Action") { (action) in //28
            selectedID = 28
            self.present(CategoriesViewController(genreID: selectedID), animated: true)
        }
        let adventure = UIAction(title: "Adventure") { (action) in //12
            selectedID = 12
            self.present(CategoriesViewController(genreID: selectedID), animated: true)
        }
        let animation = UIAction(title: "Animation") { (action) in //16
            selectedID = 16
            self.present(CategoriesViewController(genreID: selectedID), animated: true)
        }
        let comedy = UIAction(title: "Comedy") { (action) in //35
            selectedID = 35
            self.present(CategoriesViewController(genreID: selectedID), animated: true)
        }
        let crime = UIAction(title: "Crime") { (action) in //80
            selectedID = 80
            self.present(CategoriesViewController(genreID: selectedID), animated: true)
        }
        let documentary = UIAction(title: "Documentary") { (action) in //99
            selectedID = 99
            self.present(CategoriesViewController(genreID: selectedID), animated: true)
        }
        let drama = UIAction(title: "Drama") { (action) in //18
            selectedID = 18
            self.present(CategoriesViewController(genreID: selectedID), animated: true)
        }
        let family = UIAction(title: "Family") { (action) in //10751
            selectedID = 10751
            self.present(CategoriesViewController(genreID: selectedID), animated: true)
        }
        let fantasy = UIAction(title: "Fantasy") { (action) in //14
            selectedID = 14
            self.present(CategoriesViewController(genreID: selectedID), animated: true)
        }
        let history = UIAction(title: "History") { (action) in //36
            selectedID = 36
            self.present(CategoriesViewController(genreID: selectedID), animated: true)
        }
        let horror = UIAction(title: "Horror") { (action) in //27
            selectedID = 27
            self.present(CategoriesViewController(genreID: selectedID), animated: true)
        }
        let music = UIAction(title: "Music") { (action) in //10402
            selectedID = 10402
            self.present(CategoriesViewController(genreID: selectedID), animated: true)
        }
        let mystery = UIAction(title: "Mystery") { (action) in //9648
            selectedID = 9648
            self.present(CategoriesViewController(genreID: selectedID), animated: true)
        }
        let romance = UIAction(title: "Romance") { (action) in //10749
            selectedID = 10749
            self.present(CategoriesViewController(genreID: selectedID), animated: true)
        }
        let scienceFiction = UIAction(title: "Science Fiction") { (action) in //878
            selectedID = 878
            self.present(CategoriesViewController(genreID: selectedID), animated: true)
        }
        let thriller = UIAction(title: "Thriller") { (action) in //53
            selectedID = 53
            self.present(CategoriesViewController(genreID: selectedID), animated: true)
        }
        let war = UIAction(title: "War") { (action) in //10752
            selectedID = 10752
            self.present(CategoriesViewController(genreID: selectedID), animated: true)
        }
        let western = UIAction(title: "Western") { (action) in //37
            selectedID = 37
            self.present(CategoriesViewController(genreID: selectedID), animated: true)
        }
        let menu = UIMenu(title: "Categories", options: .displayInline, children: [action, adventure, animation,
                                                                                   comedy, crime, documentary,
                                                                                   drama, family, fantasy,
                                                                                   history, horror, music,
                                                                                   mystery, romance, scienceFiction,
                                                                                   thriller, war, western])
        
        let navItems = [UIBarButtonItem(image:  UIImage(systemName: "list.bullet.circle"), menu: menu)]
        self.navigationItem.rightBarButtonItems = navItems
    }
}
// MARK: - TABLEVIEW
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
// MARK: - UISearchResultsUpdating
extension HomeViewController: UISearchResultsUpdating, SearchResultsViewControllerDelegate {
  
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text,
              text.trimmingCharacters(in: CharacterSet.whitespaces).count >= 2  else {return}
        
        guard let resultController = searchController.searchResultsController as? SearchResultsViewController else { return }
        
        MovieService.shared.fetchSearchingMovies(with: text) { [weak self] (response) in
            self?.searchingMovies = response ?? []
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
