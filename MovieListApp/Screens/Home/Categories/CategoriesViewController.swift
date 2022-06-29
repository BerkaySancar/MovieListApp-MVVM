
import UIKit
import SnapKit

final class CategoriesViewController: UIViewController {
    
    init(genreID: Int) {
        self.upcomingGenreID = genreID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var model: [Movie] = [Movie]()
    private var viewModel: APICaller = SplashViewModel()
    
    private var upcomingGenreID: Int = 0
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(CategoriesTableViewCell.self, forCellReuseIdentifier: CategoriesTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configure()
        
        viewModel.fetchPopularItems()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchPopularItems()
        model = viewModel.popularMovies
    }
    
    private func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.identifier, for: indexPath) as? CategoriesTableViewCell else { return UITableViewCell()}
        
        cell.selectionStyle = .none
        
        let movie = model[indexPath.row]
        guard let genres = movie.genre_ids?.first else { return UITableViewCell()}
    
            if genres == upcomingGenreID {
                cell.design(name: model[indexPath.row].original_name ?? model[indexPath.row].original_title ?? "" , poster: model[indexPath.row].poster_path ?? "")
            } else {
                cell.design(name: "-", poster: "kqjL17yufvn9OVLyXYpvtyrFfak.jpg" )
            }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
