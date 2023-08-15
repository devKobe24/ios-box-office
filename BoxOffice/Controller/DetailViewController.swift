//
//  DetailViewController.swift
//  BoxOffice
//
//  Created by Kobe, yyss99 on 2023/08/13.
//

import UIKit

class DetailViewController: UIViewController {
    var movieTitle: String?
    
    let scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let contentView: UIView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    var movieImageView: UIImageView = {
        var movieImageView: UIImageView = UIImageView()
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        return movieImageView
    }()
    
    let networkManager: NetworkManager = NetworkManager()
    var queryParameters: [String: String] = [:]
    
    init(movieTitle: String? = nil) {
        self.movieTitle = movieTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        addSubViews()
        setUpScrollViewConstraints()
        setUpContentViewConstraints()
        setUpMovieImageViewContraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let movieTitle = movieTitle else { return }
        fetchMoviePoster(
            networkManager: networkManager,
            headers: ["Authorization": "KakaoAK 3072c89de6f543ff508009a001ea12d9"],
            queryParameters: ["query": "\(movieTitle)+포스터"]
        ) { imgUrl in
            guard let url = URL(string: imgUrl) else { return }
            do {
                let data: Data = try Data(contentsOf: url)
                DispatchQueue.main.async { [weak self] in
                    guard let moviePoster = UIImage(data: data) else { return }
                    self?.movieImageView.image = moviePoster
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension DetailViewController {
    private func addSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(movieImageView)
    }
    
    private func setUpScrollViewConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setUpContentViewConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
    }
    
    private func setUpMovieImageViewContraints() {
        NSLayoutConstraint.activate([
            movieImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            movieImageView.widthAnchor.constraint(equalToConstant: 300),
            movieImageView.heightAnchor.constraint(equalTo: movieImageView.widthAnchor, multiplier: 2),
        ])
        
    }
}

extension DetailViewController: Fetchable, NetworkConfigurable {
    var headerParameters: [String : String] {
        ["Authorization": "KakaoAK 3072c89de6f543ff508009a001ea12d9"]
    }
    
    var baseURL: String {
        "https://dapi.kakao.com/v2/search/image?"
    }
    
    var queryItems: [String : String]? {
        get {
            return self.queryParameters
        }
        set {
            guard let newValue = newValue else { return }
            return self.queryParameters = newValue
        }
    }
}
