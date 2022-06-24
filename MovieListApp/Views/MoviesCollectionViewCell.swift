//
//  MoviesCollectionViewCell.swift
//  MovieListApp
//
//  Created by Berkay Sancar on 22.06.2022.
//

import UIKit
import SnapKit
import Kingfisher

class MoviesCollectionViewCell: UICollectionViewCell {
    
    private let moviesPosterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(200)
        }
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let moviesTitle: UILabel = {
        let label = UILabel()
        label.snp.makeConstraints { make in
            make.width.equalTo(200)
        }
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.numberOfLines = 2
        return label
    }()
    
    private let moviesOverview: UILabel = {
        let label = UILabel()
        label.snp.makeConstraints { make in
            make.width.equalTo(200)
        }
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        label.numberOfLines = 7
        return label
    }()
    
    private let moviesReleaseDate: UILabel = {
        let label = UILabel()
        label.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    static let identifier = "MoviesCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(moviesPosterImage)
        contentView.addSubview(moviesTitle)
        contentView.addSubview(moviesOverview)
        contentView.addSubview(moviesReleaseDate)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        moviesPosterImage.frame = contentView.bounds
//        moviesTitle.frame = contentView.bounds
//        moviesOverview.frame = contentView.bounds
        
      
    }
    private func configure() {
        moviesPosterImage.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).offset(16)
        }
        moviesTitle.snp.makeConstraints { make in
            make.left.equalTo(moviesPosterImage.snp.right).offset(24)
        }
        moviesOverview.snp.makeConstraints { make in
            make.top.equalTo(moviesTitle.snp.bottom).offset(8)
            make.left.equalTo(moviesTitle)
        }
        moviesReleaseDate.snp.makeConstraints { make in
            make.top.equalTo(moviesOverview.snp.bottom).offset(8)
            make.right.equalTo(moviesOverview)
        }
    }
    public func design(poster: String,title: String, overview: String, releaseDate: String) {
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(poster)") else {return}
        moviesPosterImage.kf.setImage(with: url)
        moviesTitle.text = title
        moviesOverview.text = overview
        moviesReleaseDate.text = releaseDate
    }
}
