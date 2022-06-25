//
//  SearchTableViewCell.swift
//  MovieListApp
//
//  Created by Berkay Sancar on 25.06.2022.
//

import UIKit
import SnapKit
import Kingfisher

class SearchTableViewCell: UITableViewCell {

    static let identifier: String = "SearchTableViewCell"
    
    private let searchedMoviePoster: UIImageView = {
        let imageView = UIImageView()
        imageView.snp.makeConstraints { make in
            make.height.equalTo(160)
            make.width.equalTo(100)
        }
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let searchedMovieName: UILabel = {
        let label = UILabel()
        label.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.numberOfLines = 2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(searchedMoviePoster)
        contentView.addSubview(searchedMovieName)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        
        searchedMoviePoster.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            
        }
        searchedMovieName.snp.makeConstraints { make in
            make.left.equalTo(searchedMoviePoster.snp.right).offset(16)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()

        }
    }
    public func design(name: String, poster: String) {
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(poster)") else {return}
        searchedMoviePoster.kf.setImage(with: url)
        searchedMovieName.text = name
    }
}
