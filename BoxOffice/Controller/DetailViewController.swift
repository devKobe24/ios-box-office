//
//  DetailViewController.swift
//  BoxOffice
//
//  Created by Kobe, yyss99 on 2023/08/13.
//

import UIKit
import OSLog

class DetailViewController: UIViewController {
    private var movieInformationDataFetcher: MovieInformationDataFetcher?
    private var moviePosterFetcher: MoviePosterFetcher?
    private var movieInformation: MovieInformation?
    private var movieCode: String?
    private let networkManager: NetworkManager = NetworkManager()
  
    
    convenience init(movieCode: String) {
        self.init(nibName: nil, bundle: nil)
        self.movieCode = movieCode
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    private func loadData() {
        guard let movieCode = movieCode else {
            return
        }
        
        
    }
    
    private func loadPosterImger() {
        guard let movieTitle = movieInformation?.movieName else { return }
        let queryKeyword = movieTitle + "포스터"
        let baseURL = KakaoAPIDataGetter.image(keyword: queryKeyword).baseURL
        
        moviePosterFetcher = MoviePosterFetcher(baseURL: baseURL)
        moviePosterFetcher?.fetchMoviePoster(completion: { result in
            switch result {
            case .success(let moviePoster):
                self.configureUI(with: moviePoster)
            case .failure(let error):
                os_log("%{public}@", type: .default, error.localizedDescription)
            }
        })
    }
}

extension DetailViewController {
    private func configureUI(with image: UIImage?) {
        guard let posterImage = image,
              let movieInformation = movieInformation else { return }
        
        let scrollView = MovieScrollView(
            frame: .zero,
            movieInformationData: movieInformation,
            moviePosterImage: posterImage
        )
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}


