//
//  DetailViewController.swift
//  BoxOffice
//
//  Created by Kobe, yyss99 on 2023/08/13.
//

import UIKit

class DetailViewController: UIViewController {
    private var selectedMovieCode: String
    private var movieTitle: String
    private let scrollView: UIScrollView = UIScrollView()
    private let contentView: UIView = UIView()
    private let posterImageView: UIImageView = UIImageView()
    private var detailInformation: IndividualMovieDetailInformation?
    private let networkManager: NetworkManager = NetworkManager()
    private var queryParameters: [String: String] = [:]
    private var moviePosterFetcher: MoviePosterFetcher
    
    
    init(
        selectedMovieCode: String,
        movieTitle:String,
        moviePosterFetcher: MoviePosterFetcher
    ) {
        self.selectedMovieCode = selectedMovieCode
        self.movieTitle = movieTitle
        self.moviePosterFetcher = moviePosterFetcher
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        configureScrollView()
        configureMovieposter()
        
        fetchDetailData {
            DispatchQueue.main.async {
                self.configureMovieStackView()
            }
        }
        self.fetchMoviePoster { posterImg in
            self.posterImageView.image = posterImg
        }
    }
    
    private func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemBackground
        scrollView.showsVerticalScrollIndicator = false
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.heightAnchor)
        ])
    }
    
    private func configureMovieposter() {
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(posterImageView)
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            posterImageView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor, multiplier: 2/3)
        ])
    }
    
    func configureMovieStackView() {
        let movieDetailStackView = UIStackView()
        movieDetailStackView.translatesAutoresizingMaskIntoConstraints = false
        movieDetailStackView.axis = .vertical
        movieDetailStackView.spacing = 5
        contentView.addSubview(movieDetailStackView)
        
        NSLayoutConstraint.activate([
            movieDetailStackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10),
            movieDetailStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieDetailStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3),
            movieDetailStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        
        
        guard let detail = detailInformation else { return }
        makeStackView(categoryName: "감독", detail: detail.movieInfoResult.movieInfo.directors[0].directorName, in: movieDetailStackView)
        makeStackView(categoryName: "제작년도", detail: detail.movieInfoResult.movieInfo.productionYear, in: movieDetailStackView)
        makeStackView(categoryName: "개봉일", detail: detail.movieInfoResult.movieInfo.openDate, in: movieDetailStackView)
        makeStackView(categoryName: "상영시간", detail: detail.movieInfoResult.movieInfo.showTime, in: movieDetailStackView)
        makeStackView(categoryName: "관람등급", detail: detail.movieInfoResult.movieInfo.audits[0].watchGradeName, in: movieDetailStackView)
        makeStackView(categoryName: "제작국가", detail: detail.movieInfoResult.movieInfo.productionNations[0].productionNations, in: movieDetailStackView)
        makeStackView(categoryName: "장르", detail: detail.movieInfoResult.movieInfo.genres[0].genreName, in: movieDetailStackView)
        
        var actorNames: String {
            if detail.movieInfoResult.movieInfo.actors.isEmpty {
                return "없음"
            } else {
                let actorsNameInList = detail.movieInfoResult.movieInfo.actors.map { $0.peopleName }
                return actorsNameInList.joined(separator: ", ")
            }
        }
        makeStackView(categoryName: "배우", detail: actorNames, in: movieDetailStackView)
    }
    
    func makeStackView(categoryName: String, detail: String, in movieDetailStackView: UIStackView){
        let categoryLabel = UILabel()
        let detailLabel = UILabel()
        
        detailLabel.text = detail
        detailLabel.font = .preferredFont(forTextStyle: .body)
        detailLabel.numberOfLines = 0
        
        categoryLabel.text = categoryName
        categoryLabel.textAlignment = .center
        categoryLabel.font = .preferredFont(forTextStyle: .body)
        
        let stackView = UIStackView(arrangedSubviews: [categoryLabel, detailLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        movieDetailStackView.addArrangedSubview(stackView)
        
        NSLayoutConstraint.activate([
            categoryLabel.widthAnchor.constraint(equalTo: movieDetailStackView.widthAnchor, multiplier: 1/5)
        ])
    }
}

extension DetailViewController {
    func fetchDetailData(completion: @escaping () -> Void) {
        do {
            let networkConfigurer: NetworkConfigurer = NetworkConfigurer(
                baseURL: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json",
                queryItems: [
                    "key": Bundle.main.API,
                    "movieCd":selectedMovieCode
                ],
                headerParameters: [
                    "Authorization": "KakaoAK 3072c89de6f543ff508009a001ea12d9"
                ]
            )
            
            let url = try networkConfigurer.generateURL(isFullPath: false)
            
            let urlRequest = URLRequest(url: url)
            
            networkManager.getBoxOfficeData(requestURL: urlRequest) { (detail: IndividualMovieDetailInformation) in
                self.detailInformation = detail
                completion()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension DetailViewController: NetworkConfigurable, BoxOffiecDataFetchable, MoviePosterFetchable {
    var baseURL: String {
        "https://dapi.kakao.com/v2/search/image"
    }
    
    var queryItems: [String : String]? {
        get {
            return self.queryParameters
        }
        set {
            guard let newValue = newValue else { return }
            self.queryParameters = newValue
        }
    }
    
    var headerParameters: [String : String]? {
        [:]
    }
}

extension DetailViewController {
    func fetchMoviePoster(completion: @escaping (UIImage) -> Void) {
        self.moviePosterFetcher.fetchMoviePoster(
            networkManager: networkManager,
            headers: ["Authorization": "KakaoAK 3072c89de6f543ff508009a001ea12d9"],
            queryParameters: ["query":"\(movieTitle)+포스터"]
        ) { moivePosterImgUrl in
                guard let data = moivePosterImgUrl.data(using: .utf8) else { return }
                guard let posterImg = UIImage(data: data) else { return }
                completion(posterImg)
        }
    }
}


