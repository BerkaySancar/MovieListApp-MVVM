//
//  SearchResultsViewController.swift
//  MovieListApp
//
//  Created by Berkay Sancar on 25.06.2022.
//

import UIKit
import SnapKit

class SearchResultsViewController: UIViewController {
    
    public var movie: [Movie] = [Movie]()
    
    public let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.backgroundColor = .systemBackground
       return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
         
    }
    
    private func configure() {
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
}
extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {return UITableViewCell()}
        
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        cell.tintColor = .label
        let name = movie[indexPath.row].original_name ?? movie[indexPath.row].original_title
        let poster = movie[indexPath.row].poster_path
        cell.design(name: name ?? "", poster: poster ?? "")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
