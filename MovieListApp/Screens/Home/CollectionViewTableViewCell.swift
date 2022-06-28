import UIKit
import SnapKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
    
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: DetailViewModel)
}

class CollectionViewTableViewCell: UITableViewCell {

    
    weak var delegate: CollectionViewTableViewCellDelegate?
    
    static let identifier = "CollectionViewTableViewCell"
    
    private var movies: [Movie] = [Movie]()
    
    private var selectedMovieName: String = ""
    private var selectedMoviePoster: String = ""
    private var selectedMovieVote: Float = 0.0
    private var selectedMovieOverview: String = ""
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 350, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: MoviesCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.collectionView.frame = contentView.bounds
    }
    public func configure(with movies: [Movie]) {
        self.movies = movies
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier, for: indexPath) as? MoviesCollectionViewCell else {return UICollectionViewCell()}
        
        guard let poster = movies[indexPath.row].poster_path else {return UICollectionViewCell()}
        let title = movies[indexPath.row].original_name ?? movies[indexPath.row].original_title 
        let overview = movies[indexPath.row].overview
        let releaseDate = movies[indexPath.row].release_date
        
        cell.design(poster: poster, title: title ?? "", overview: overview ?? "", releaseDate: releaseDate ?? "")
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedMovieName = movies[indexPath.row].original_name ?? movies[indexPath.row].original_title ?? ""
        selectedMoviePoster = movies[indexPath.row].poster_path ?? ""
        selectedMovieVote = movies[indexPath.row].vote_average ?? 0.0
        selectedMovieOverview = movies[indexPath.row].overview ?? ""
        
        let viewModel = DetailViewModel(movieName: selectedMovieName, moviePoster: selectedMoviePoster, movieVote: selectedMovieVote, movieOverview: selectedMovieOverview)

        self.delegate?.collectionViewTableViewCellDidTapCell(self, viewModel: viewModel)
        
    }
}
