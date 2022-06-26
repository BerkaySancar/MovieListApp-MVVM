import UIKit
import SnapKit
import Kingfisher

final class DetailsViewController: UIViewController {
    
    private let moviePosterImage: UIImageView = {
        let image = UIImage(systemName: "list.bullet.circle")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)
        label.numberOfLines = 2
        return label
    }()
    
    private let movieVoteAverage: UILabel = {
        let label = UILabel()
        label.textColor = .systemYellow
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        return label
    }()
    
    private let movieOverview: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        label.numberOfLines = 8
        return label
    }()
    
    private let addBookmarksButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .label
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        view.backgroundColor = .systemBackground
        view.addSubview(movieNameLabel)
        view.addSubview(moviePosterImage)
        view.addSubview(movieVoteAverage)
        view.addSubview(movieOverview)
        view.addSubview(addBookmarksButton)
        configure()
    
    }
    
    private func configure() {
        
        moviePosterImage.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(360)
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        movieNameLabel.snp.makeConstraints { make in
            make.top.equalTo(moviePosterImage.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-40)
            
        }
        addBookmarksButton.snp.makeConstraints { make in
            make.top.equalTo(movieNameLabel.snp.top)
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(36)
        }
        movieVoteAverage.snp.makeConstraints { make in
            make.top.equalTo(addBookmarksButton.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-20)
            
        }
        movieOverview.snp.makeConstraints { make in
            make.top.equalTo(movieNameLabel.snp.bottom).offset(16)
            make.left.equalTo(movieNameLabel.snp.left)
            make.right.equalTo(movieVoteAverage.snp.right)
        }
        
        addBookmarksButton.setBackgroundImage(.init(systemName: "bookmark.circle"), for: UIControl.State.normal)
        
    }
    
    func design(with model: DetailViewModel) {
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.moviePoster)") else {return}
        moviePosterImage.kf.setImage(with: url)
        movieNameLabel.text = model.movieName
        movieOverview.text = model.movieOverview
        movieVoteAverage.text = String(model.movieVote)
        
    }
    @objc func addBookmarksButtonTapped() {
        
        
    }
}

