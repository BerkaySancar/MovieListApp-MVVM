import UIKit
import SnapKit
import Kingfisher

final class DetailsViewController: UIViewController {
    
    private var viewModel: DetailViewModel = DetailViewModel()
    
    private let moviePosterImage: UIImageView = {
        let imageView = UIImageView()
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

    private let movieOverviewTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .label
        textView.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textView.textAlignment = .justified
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.isUserInteractionEnabled = true
        textView.showsVerticalScrollIndicator = true
        return textView
    }()
    
    private let bookmarksButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setBackgroundImage(UIImage(systemName: "bookmark.circle"), for: UIControl.State.normal)
        button.snp.makeConstraints { make in
            make.width.height.equalTo(36)
        }
        return button
    }()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        view.backgroundColor = .systemBackground
        view.addSubview(movieNameLabel)
        view.addSubview(moviePosterImage)
        view.addSubview(movieVoteAverage)
        view.addSubview(movieOverviewTextView)
        view.addSubview(bookmarksButton)
        configure()
        if let data = defaults.object(forKey: "bookmark") as? [String] {
            viewModel.bookmarks = data
        }
    }
    
    private func configure() {
        
        moviePosterImage.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(360)
            make.top.equalTo(88)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        movieNameLabel.snp.makeConstraints { make in
            make.top.equalTo(moviePosterImage.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-56)

        }
        bookmarksButton.snp.makeConstraints { make in
            make.top.equalTo(movieNameLabel.snp.top)
            make.right.equalToSuperview().offset(-26)
            make.width.height.equalTo(36)
        }
        movieVoteAverage.snp.makeConstraints { make in
            make.top.equalTo(bookmarksButton.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-20)
        }
        movieOverviewTextView.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(movieNameLabel.snp.bottom).offset(30)
            make.left.equalTo(movieNameLabel.snp.left)
            make.right.equalToSuperview().offset(-20)
        }
        bookmarksButton.addTarget(self, action: #selector(bookmarksButtonTapped), for: UIControl.Event.touchUpInside)
    }
    
    func design(with model: DetailViewModel) {

        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.moviePoster)") else {return}
        moviePosterImage.kf.setImage(with: url)
        movieNameLabel.text = model.movieName
        movieOverviewTextView.text = model.movieOverview
        movieVoteAverage.text = String(model.movieVote) + " / 10"

    }
    
    @objc func bookmarksButtonTapped(_ sender: UIButton) {
        
        bookmarksButton.isSelected = !bookmarksButton.isSelected
      
        if movieNameLabel.text != "" {
            viewModel.bookmarks.append(movieNameLabel.text!)
            defaults.set(viewModel.bookmarks, forKey: "bookmark")
        }
        
        if bookmarksButton.isSelected {
            let alert = UIAlertController(title: "SUCCESS", message: "Bookmark added.", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
            bookmarksButton.tintColor = .systemYellow
        } 
    }
}
