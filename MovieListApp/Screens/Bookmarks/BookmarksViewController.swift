import UIKit
import SnapKit

final class BookmarksViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsMultipleSelection = true
        return tableView
    }()
    
    private let imageView: UIImageView = {
        let image = UIImage(named: "Movie")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    private var viewModel: DetailViewModel = DetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(imageView)
        configure()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let data = UserDefaults.standard.object(forKey: "bookmark") as? [String] {
            viewModel.bookmarks = data
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func configure() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.bottom.right.left.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(tableView.snp.top)
            make.width.equalToSuperview()
            make.height.equalTo(260)
        }
       
        navigationController?.navigationBar.topItem?.title = "Bookmarks"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        navigationController?.navigationBar.barTintColor = UIColor.systemBackground
    }
}
//MARK: - TABLEVIEW
extension BookmarksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.bookmarks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold)
        cell.textLabel?.text = viewModel.bookmarks[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            viewModel.bookmarks.remove(at: indexPath.row)
            UserDefaults.standard.set(viewModel.bookmarks, forKey: "bookmark")
            self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            self.tableView.reloadData()
        }
    }
}
