//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    private var dateCountUpForTest: Int = 20230720
    private let networkManager: NetworkManager = NetworkManager()
    private let refreshControl: UIRefreshControl = UIRefreshControl()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>? = nil
    private var queryParameters: [String: String] = [:]
    private var boxOfficeDataFetcher: BoxOfficeDataFetcher?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        
        self.fetchDate()
        self.configureHierarchy()
        self.initRefreshControl()
        
        boxOfficeDataFetcher = BoxOfficeDataFetcher(
            baseURL: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
            queryItems: [
                "key": "d4bb1f8d42a3b440bb739e9d49729660",
                "targetDt": "20230724"
            ],
            headerParameters: nil
        )
        
        boxOfficeDataFetcher?.appendBoxOfficeDataToItem(
            networkManager: networkManager,
            queryParameters: [
                "key": Bundle.main.API,
                "targetDt": "\(dateCountUpForTest)"
            ]
        ) {
            
            DispatchQueue.main.async {
                print("SUCCESS ALL ITEMS APPENDED.")
                self.configureDataSource()
            }
            
            self.fetchBoxOfficeData { dailyBoxOfficeData in
                let count = dailyBoxOfficeData.count
                
                for index in 0...(count-1) {
                    let rankNumber = dailyBoxOfficeData[index].rankNumber
                    let rankIntensity = dailyBoxOfficeData[index].rankIntensity
                    let movieName = dailyBoxOfficeData[index].movieName
                    let audienceCount = dailyBoxOfficeData[index].audienceCount
                    let audienceAccumulated = dailyBoxOfficeData[index].audienceAccumulated
                    let rankOldAndNew = dailyBoxOfficeData[index].rankOldAndNew
                    let movieCode = dailyBoxOfficeData[index].movieCode
                    
                    Item.all.append(
                        Item(
                            rankNumber: rankNumber,
                            rankIntensity: rankIntensity,
                            movieName: movieName,
                            audienceCount: audienceCount,
                            audienceAccumulated: audienceAccumulated,
                            rankOldAndNew: rankOldAndNew,
                            movieCode: movieCode
                        )
                    )
                }
            }
        }
    }
    
    func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    lazy var collectionView: UICollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
    
    func configureHierarchy() {
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CustomListCell, Item> { (cell, indexPath, item) in
            cell.updateWithItem(item)
            cell.accessories = [.disclosureIndicator()]
        }
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Item.all)
        guard let dataSource = dataSource else { return }
        dataSource.apply(snapshot)
    }
}

extension ViewController {
    func printBoxOfficeData() {
        do {
            let networkConfigurer: NetworkConfigurer = NetworkConfigurer(
                baseURL: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
                queryItems: [
                    "key": "d4bb1f8d42a3b440bb739e9d49729660",
                    "targetDt": "20230724"
                ],
                headerParameters: nil
            )
            
            let url = try networkConfigurer.generateURL(isFullPath: false)
            
            let urlRequest = URLRequest(url: url)
            
            let networkManager = NetworkManager()
            networkManager.getBoxOfficeData(requestURL: urlRequest) { (boxOffice: BoxOffice) in
                print(boxOffice)
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
extension ViewController {
    func fetchBoxOfficeData(completion: @escaping ([Item]) -> Void) {
        let boxOfficeData = boxOfficeDataFetcher?.fetchDataBoxOfficeData(
            networkManager: networkManager,
            queryParameters: [
                "key": "d4bb1f8d42a3b440bb739e9d49729660",
                "targetDt": "\(dateCountUpForTest)"
            ]
        )
        
        guard let dailyBoxOfiiceDay = boxOfficeData else { return }
        
        completion(dailyBoxOfiiceDay)
    }
}

extension ViewController {
    
    private func initRefreshControl() {
        refreshControl.addTarget(self, action: #selector(pullRefreshControl), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc func pullRefreshControl() {
        self.dateCountUpForTest += 1
        Item.all.removeAll()
        boxOfficeDataFetcher?.appendBoxOfficeDataToItem(
            networkManager: networkManager,
            queryParameters: [
                "key": Bundle.main.API,
                "targetDt": "\(dateCountUpForTest)"],
            completion: {
                DispatchQueue.main.async {
                    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                    snapshot.appendSections([.main])
                    snapshot.appendItems(Item.all)
                    guard let dataSource = self.dataSource else { return }
                    dataSource.apply(snapshot)

                    self.refreshControl.endRefreshing()
                }
            }
        )
    }
}

extension ViewController {
    private func fetchDate() {
        do {
            self.navigationItem.title = try DateFormatter().changeDateFormat(Date(), DateFormatter.DateFormat.hyphen)
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedMovieCode = dataSource?.itemIdentifier(for: indexPath)?.movieCode else { return }
        guard let movieTitle = dataSource?.itemIdentifier(for: indexPath)?.movieName else { return }
        let moviePosterFetcher = MoviePosterFetcher(
            baseURL: "https://dapi.kakao.com/v2/search/image"
        )
        
        let detailViewController = DetailViewController(selectedMovieCode: selectedMovieCode, movieTitle: movieTitle, moviePosterFetcher: moviePosterFetcher)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension ViewController: NetworkConfigurable, BoxOffiecDataFetchable, MoviePosterFetchable {
    var baseURL: String {
         return "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
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
