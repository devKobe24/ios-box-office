//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit
import OSLog

class ViewController: UIViewController {
    lazy var collectionView: UICollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: self.createListLayout())
    private var items: [DailyBoxOfficeList] = []
    private let refreshControl: UIRefreshControl = UIRefreshControl()
    private var dataSource: UICollectionViewDiffableDataSource<Section, DailyBoxOfficeList>?
    private var queryParameters: [String: String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDate()
        configureHierarchy()
        fetchBoxOfficeData()
        configureDataSource()
        
        collectionView.delegate = self
        
       
    }
    
    func fetchBoxOfficeData() {
        do {
            let calendar: Calendar = Calendar.current
            let targetDt: String = try calendar.targetDt()
            
            let boxOfficeDataFetcher: BoxOfficeDataFetcher = BoxOfficeDataFetcher()
            
            boxOfficeDataFetcher.fetchBoxOfficeData(
                with: targetDt) { result in
                    switch result {
                    case .success(let items):
                        DispatchQueue.main.async {
                            guard let items = items else {
                                return
                            }
                            
                            self.items = items
                            self.applySnapshot()
                        }
                    case .failure(let error):
                        os_log("%{public}@", type: .default, error.localizedDescription)
                    }
                }
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    private func configureHierarchy() {
//        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func createListLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CustomListCell, DailyBoxOfficeList> { (cell, indexPath, item) in
            cell.updateWithItem(item)
            cell.accessories = [.disclosureIndicator()]
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, DailyBoxOfficeList>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        })
        applySnapshot()
    }
}

extension ViewController {
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DailyBoxOfficeList>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        
        guard let dataSource = dataSource else { return }
        
        DispatchQueue.main.async {
            self.dataSource?.apply(snapshot, animatingDifferences: true)
        }
    }
}
//extension ViewController {
//    func fetchBoxOfficeData() {
//        boxOfficeDataFetcher?.fetchDataBoxOfficeData(
//            networkManager: networkManager,
//            queryParameters: [
//                "key": "d4bb1f8d42a3b440bb739e9d49729660",
//                "targetDt": "\(dateCountUpForTest)"
//            ],
//            completion: { result in
//                switch result {
//                case .success(let item):
//                    guard let item = item else { return }
//                    Item.all.append(item)
//                case .failure(let error):
//                    os_log("%{public}@", type: .default, error.localizedDescription)
//                }
//            }
//        )
//    }
//}

//extension ViewController {
//
//    private func initRefreshControl() {
//        refreshControl.addTarget(self, action: #selector(pullRefreshControl), for: .valueChanged)
//        collectionView.refreshControl = refreshControl
//    }
//
//    @objc func pullRefreshControl() {
//        self.dateCountUpForTest += 1
//        Item.all.removeAll()
//        boxOfficeDataFetcher?.appendBoxOfficeDataToItem(
//            networkManager: networkManager,
//            queryParameters: [
//                "key": Bundle.main.API_KEY,
//                "targetDt": "\(dateCountUpForTest)"],
//            completion: {
//                DispatchQueue.main.async {
//                    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
//                    snapshot.appendSections([.main])
//                    snapshot.appendItems(Item.all)
//                    guard let dataSource = self.dataSource else { return }
//                    dataSource.apply(snapshot)
//
//                    self.refreshControl.endRefreshing()
//                }
//            }
//        )
//    }
//}

extension ViewController {
    private func fetchDate() {
        do {
            let title = try DateFormatter().changeDateFormat(Date(), DateFormatter.DateFormat.hyphen)
            
            self.navigationItem.title = title
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedMovieCode = dataSource?.itemIdentifier(for: indexPath)?.movieCode else { return }
//        guard let movieTitle = dataSource?.itemIdentifier(for: indexPath)?.movieName else { return }
//        let moviePosterFetcher = MoviePosterFetcher(
//            baseURL: "https://dapi.kakao.com/v2/search/image"
//        )
        
        let detailViewController = DetailViewController(movieCode: selectedMovieCode)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

//extension ViewController: BoxOffiecDataFetchable {
//    var baseURL: String {
//         return "http://www.kobis.or.kr"
//    }
//
//    var path: String {
//        var pathString = "/kobisopenapi/webservice/rest/"
//
//        switch self.boxOfficeDataFetcher {
//        case .boxOffice:
//            pathString += "boxoffice/searchDailyBoxOfficeList.json"
//        case .movieCode:
//            pathString += "movie/searchMovieInfo.json"
//        case .none:
//            break
//        }
//        return pathString
//    }
//
//    var queries: [URLQueryItem] {
//        switch self.boxOfficeDataFetcher {
//        case .boxOffice(let targerDate):
//            return [
//                URLQueryItem(name: "key", value: Bundle.main.API_KEY),
//                URLQueryItem(name: "targetDt", value: targerDate)
//            ]
//        case .movieCode(let movieCode):
//            return [
//                URLQueryItem(name: "key", value: Bundle.main.API_KEY),
//                URLQueryItem(name: "movieCd", value: movieCode)
//            ]
//        case .none:
//            break
//        }
//    }
//}
