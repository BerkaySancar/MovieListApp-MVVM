import UIKit
import SnapKit

final class SplashScreenViewController: UIViewController {

    private let activityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    private let logoImage: UIImageView = {
        let image = UIImage(systemName: "list.and.film")
        let imageView = UIImageView(image: image)
        imageView.snp.makeConstraints { make in
            make.height.equalTo(105)
            make.width.equalTo(150)
        }
        imageView.tintColor = .label
        return imageView
    }()
    
    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(266)
        }
        label.text = "Movie List App"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 30)
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1, execute: { self.present() })

        configure()
    }
        
    private func configure() {
        
        view.backgroundColor = .systemBackground
        view.addSubview(logoImage)
        view.addSubview(appNameLabel)
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    
        logoImage.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        appNameLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(30)
            make.centerX.equalTo(logoImage).offset(37.2)
        }
        activityIndicatorView.snp.makeConstraints { make in
            make.top.equalTo(appNameLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
        }
    }
        
    private func present() {
        
        let vc = MainTabBarController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
}

