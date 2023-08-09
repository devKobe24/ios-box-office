//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController, Fetchable {
    var boxOfficeData: [BoxOffice] = []
    var itemData: [Item] = []
    
    var targetDate = "20230724"
    
    let networkManager: NetworkManager = NetworkManager()
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>? = nil
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "2023-01-05"
        self.makeRefreshControl()
        self.configureHierarchy()
        
        fetchBoxOfficeData { items in
            DispatchQueue.main.async {
                self.configureDataSource()
            }
        }
    }
    
    func creatLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    lazy var collectionView: UICollectionView = UICollectionView(frame: view.frame, collectionViewLayout: creatLayout())
    
    func makeRefreshControl() {
        collectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshRankData(_:)), for: .valueChanged)
    }
    
    func configureHierarchy() {
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    
    @objc func refreshRankData(_ sender: Any) {
        itemData = []
        
        fetchBoxOfficeData { [weak self] newItems in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.refreshControl.beginRefreshing()
                self.itemData = newItems
                
                var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()

                snapshot.appendSections([.main])
                snapshot.appendItems(self.itemData)
                if let dataSource = self.dataSource {
                    dataSource.apply(snapshot, animatingDifferences: false)
                }
                self.refreshControl.endRefreshing()
            }
        }
        targetDate = "20230720"
    }
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CustomListCell, Item> { (cell, indexPath, item) in
            cell.updateWithItem(item)
            cell.accessories = [.disclosureIndicator()]
        }
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(itemData)
        guard let dataSource = dataSource else { return }
        dataSource.apply(snapshot)
    }
}

extension ViewController {
    func printBoxOfficeData() {
        do {
            
            let endPoint = EndPoint(
                baseURL: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
                queryItems: [
                    "key": "d4bb1f8d42a3b440bb739e9d49729660",
                    "targetDt": targetDate
                ]
            )
            
            let url = try endPoint.generateURL(
                isFullPath: false
            )
            
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
    func fetchBoxOfficeData(completion: @escaping ([Item]) -> ()) {
        do {
            let endPoint: EndPoint = EndPoint(
                baseURL: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
                queryItems: [
                    "key": "d4bb1f8d42a3b440bb739e9d49729660",
                    "targetDt": targetDate
                ]
            )
            
            let url = try endPoint.generateURL(
                isFullPath: false
            )
            
            let urlRequest = URLRequest(url: url)
            
            networkManager.getBoxOfficeData(requestURL: urlRequest) { [weak self] (boxOffice: BoxOffice) in
                guard let self = self else { return }
                
                self.boxOfficeData.append(boxOffice)
                let count = boxOffice.boxOfficeResult.dailyBoxOfficeList.count
                for index in 1...count {
                    let rankNumber = boxOffice.boxOfficeResult.dailyBoxOfficeList[index-1].rankNumber
                    let rankIntensity = boxOffice.boxOfficeResult.dailyBoxOfficeList[index-1].rankIntensity
                    let movieName = boxOffice.boxOfficeResult.dailyBoxOfficeList[index-1].movieName
                    let audienceCount = boxOffice.boxOfficeResult.dailyBoxOfficeList[index-1].audienceCount
                    let audienceAccumulated = boxOffice.boxOfficeResult.dailyBoxOfficeList[index-1].audienceAccumulated
                    
                    let items = Item(rankNumber: rankNumber, rankIntensity: rankIntensity, movieName: movieName, audienceCount: audienceCount, audienceAccumulated: audienceAccumulated)
                    
                    self.itemData.append(items)
                }
                completion(self.itemData)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
