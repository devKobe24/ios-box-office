//
//  DetailViewController.swift
//  BoxOffice
//
//  Created by Kobe, yyss99 on 2023/08/13.
//

import UIKit
import OSLog

class DetailViewController: UIViewController {
    private var selectedMovieCode: String
    private var movieTitle: String
    
//    private let scrollView: MovieScrollView = MovieScrollView(
//    private let contentView: UIView = UIView()
    private let testImageView: UIImageView = UIImageView()
    
    private let posterImageView: UIImageView = UIImageView()
    private let movieDetailStackView = UIStackView()
    
    private var detailInformation: IndividualMovieDetailInformation?
    private let networkManager: NetworkManager = NetworkManager()
    private var queryParameters: [String: String] = [:]
    private var moviePosterFetcher: MoviePosterFetcher
    
    private var testImageViewHeightConstraint: NSLayoutConstraint?
    private var movieInformationDataFetcher: MovieInformationDataFetcher?
    private var scrollView: MovieScrollView?
    
    
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
        
//        self.fetchMoviePoster { [weak self] posterImage in
//            DispatchQueue.main.async {
//                self?.configureMovieposter(posterImg: posterImage)
//            }
//        }
        
        
//        fetchDetailData {
//            DispatchQueue.main.async {
//
//                self.addSubViews()
//                self.configureScrollView()
//                self.configureContentView()
//                self.configureTestLabel()
//            }
//        }
        
        movieInformationDataFetcher = MovieInformationDataFetcher(
            baseURL: "https://dapi.kakao.com/v2/search/image",
            queryItems: [
                "query":"\(movieTitle)+포스터"
            ],
            headerParameters: [
                "Authorization": "KakaoAK 3072c89de6f543ff508009a001ea12d9"
            ]
        )
        
        movieInformationDataFetcher?.fetchMoviewInformationData(
            networkManager: networkManager,
            queryParameters: [
                "query":"\(movieTitle)+포스터"
            ],
            completion: { result in
                switch result {
                case .success(let item):
                    DispatchQueue.main.async {
//                        self.addSubViews()
                        self.configureScrollView(item: item)
//                        self.configureContentView()
//                        self.configureTestImageView()
                    }
                case .failure(let error):
                    os_log("%{public}@", type: .default, error.localizedDescription)
                }
            }
        )
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
//    private func addSubViews() {
////
////        contentView.translatesAutoresizingMaskIntoConstraints = false
////        testImageView.translatesAutoresizingMaskIntoConstraints = false
//
//
////        scrollView.addSubview(contentView)
////        contentView.addSubview(testImageView)
//
//    }
    
    private func configureScrollView(item: MovieInformation?) {
        guard let movieInformation = item else { return }
        
        let movieInformationStackView = MovieInformationStackView(
            frame: .zero,
            movieInformation: movieInformation
        )
        
        let scrollView: MovieScrollView = MovieScrollView(
            frame: .zero,
            movieInformationData: movieInformation,
            moviePosterImage: UIImage(systemName: "person")!,
            movieInformationStackView: movieInformationStackView
        )
        
        scrollView.backgroundColor = .red
        
        self.scrollView = scrollView
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        scrollView.backgroundColor = .yellow
        scrollView.showsVerticalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
//        contentView.backgroundColor = .blue
//
//        NSLayoutConstraint.activate([
//            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
//            contentView.heightAnchor.constraint(equalTo: testImageView.heightAnchor)
//        ])
    }
    
//    private func configureContentView() {
//
//
//    }
    
//    private func configureTestImageView() {
//        testImageView.image = UIImage(systemName: "person")
//        testImageView.contentMode = .scaleAspectFit
//        // MARK: - Layout Dynamic UI
//        testImageViewHeightConstraint = testImageView.heightAnchor.constraint(equalToConstant: 1)
//        testImageViewHeightConstraint?.priority = UILayoutPriority(rawValue: 999)
//        testImageViewHeightConstraint?.isActive = true
//
//
//        NSLayoutConstraint.activate([
//            // MARK: - Layout
//            testImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            testImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
//            testImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
//
//        ])
//    }
    
//    private func configureMovieposter(posterImg: UIImage?) {
//
//
//        guard let posterImg = posterImg else { return }
//        posterImageView.image = posterImg
//
//        let posterImgViewTrailing = posterImageView.trailingAnchor.constraint(
//            equalTo: scrollView.trailingAnchor,
//            constant: -20
//        )
//
//        let posterImgViewLeading = posterImageView.leadingAnchor.constraint(
//            equalTo: scrollView.leadingAnchor,
//            constant: 20
//        )
//
//        let posterImgViewTrailingContentLayoutGuide = posterImageView.trailingAnchor.constraint(
//            equalTo: scrollView.contentLayoutGuide.trailingAnchor
//        )
//        posterImgViewTrailingContentLayoutGuide.priority = .init(1000)
//
//        let posterImgViewLeadingContentLayoutGuide = posterImageView.leadingAnchor.constraint(
//            equalTo: scrollView.contentLayoutGuide.leadingAnchor
//        )
//        posterImgViewLeadingContentLayoutGuide.priority = .init(rawValue: 1000)
//
//        let posterImgViewWidthFrameLayoutGuide = posterImageView.widthAnchor.constraint(
//            equalTo: scrollView.frameLayoutGuide.widthAnchor,
//            multiplier: 1
//        )
//        posterImgViewWidthFrameLayoutGuide.priority = .init(rawValue: 1000)
//
//        let posterImgViewHeight = posterImageView.heightAnchor.constraint(
//            equalTo: scrollView.heightAnchor,
//            multiplier: 1
//        )
//        posterImgViewHeight.priority = .init(rawValue: 100)
//
//        let posterImgTop = posterImageView.topAnchor.constraint(
//            equalTo: scrollView.contentLayoutGuide.topAnchor
//        )
//        posterImgTop.priority = .init(rawValue: 1000)
//
//        let posterImgViewHeightContentLayoutGuide = posterImageView.heightAnchor.constraint(
//            equalTo: scrollView.contentLayoutGuide.heightAnchor,
//            multiplier: 1
//        )
//        posterImgViewHeightContentLayoutGuide.priority = .init(1)
//
//        NSLayoutConstraint.activate([
////            posterImgViewTrailing,
////            posterImgViewLeading,
////            posterImgViewTrailingContentLayoutGuide,
////            posterImgViewLeadingContentLayoutGuide,
////            posterImgViewWidthFrameLayoutGuide,
////            posterImgViewHeight,
////            posterImgTop,
////            posterImgViewHeightContentLayoutGuide,
//        ])
//    }
    
//    func configureMovieStackView() {
//
//
//        movieDetailStackView.axis = .vertical
//        movieDetailStackView.spacing = 5
//
//
//        NSLayoutConstraint.activate([
//            movieDetailStackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10),
//            movieDetailStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            movieDetailStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3),
//            movieDetailStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
//
//
//
//        guard let detail = detailInformation else { return }
//        makeStackView(categoryName: "감독", detail: detail.movieInfoResult.movieInfo.directors[0].directorName, in: movieDetailStackView)
//        makeStackView(categoryName: "제작년도", detail: detail.movieInfoResult.movieInfo.productionYear, in: movieDetailStackView)
//        makeStackView(categoryName: "개봉일", detail: detail.movieInfoResult.movieInfo.openDate, in: movieDetailStackView)
//        makeStackView(categoryName: "상영시간", detail: detail.movieInfoResult.movieInfo.showTime, in: movieDetailStackView)
//        makeStackView(categoryName: "관람등급", detail: detail.movieInfoResult.movieInfo.audits[0].watchGradeName, in: movieDetailStackView)
//        makeStackView(categoryName: "제작국가", detail: detail.movieInfoResult.movieInfo.productionNations[0].productionNations, in: movieDetailStackView)
//        makeStackView(categoryName: "장르", detail: detail.movieInfoResult.movieInfo.genres[0].genreName, in: movieDetailStackView)
//
//        var actorNames: String {
//            if detail.movieInfoResult.movieInfo.actors.isEmpty {
//                return "없음"
//            } else {
//                let actorsNameInList = detail.movieInfoResult.movieInfo.actors.map { $0.peopleName }
//                return actorsNameInList.joined(separator: ", ")
//            }
//        }
//        makeStackView(categoryName: "배우", detail: actorNames, in: movieDetailStackView)
//    }
    
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
    
//    func fetchDetailData(completion: @escaping () -> Void) {
//        do {
//            let networkConfigurer: NetworkConfigurer = NetworkConfigurer(
//                baseURL: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json",
//                queryItems: [
//                    "key": Bundle.main.API,
//                    "movieCd":selectedMovieCode
//                ],
//                headerParameters: [
//                    "Authorization": "KakaoAK 3072c89de6f543ff508009a001ea12d9"
//                ]
//            )
//
//            let url = try networkConfigurer.generateURL(isFullPath: false)
//
//            let urlRequest = URLRequest(url: url)
//
//            networkManager.getData(requestURL: urlRequest) { (detail: IndividualMovieDetailInformation) in
//                self.detailInformation = detail
//                completion()
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
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

//extension DetailViewController {
//    func fetchMoviePoster(completion: @escaping (UIImage?) -> Void) {
//        self.moviePosterFetcher.fetchMoviePoster(
//            networkManager: networkManager,
//            headers: ["Authorization": "KakaoAK 3072c89de6f543ff508009a001ea12d9"],
//            queryParameters: ["query":"\(movieTitle)+포스터"])
//        { result in
//            print(result)
//            switch result {
//            case .success(let posterImage):
//                completion(posterImage)
//            case .failure(let error):
//                print(error.description)
//            }
//        }
//    }
//}


