import UIKit
import SnapKit

class CategoriesTableViewCell: UITableViewCell {

    static let identifier: String = "CategoriesTableViewCell"
    
    private let moviePoster: UIImageView = {
        let imageView = UIImageView()
        imageView.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.width.equalTo(100)
        }
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let movieName: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.numberOfLines = 2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(moviePoster)
        contentView.addSubview(movieName)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        moviePoster.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            
        }
        movieName.snp.makeConstraints { make in
            make.left.equalTo(moviePoster.snp.right).offset(16)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
    public func design(name: String, poster: String) {
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(poster)") else {return}
        moviePoster.kf.setImage(with: url)
        movieName.text = name
    }
}
