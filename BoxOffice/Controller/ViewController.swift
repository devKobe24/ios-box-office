//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
//    var boxOfficeData: BoxOffice?
//    var itemData: [Item] = []
    
    let networkManager: NetworkManager = NetworkManager()
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>? = nil
    
    var countUp: Int = 20230720
    
    let refreshControl = UIRefreshControl()
    
    // MARK: - ViewDidLoad 자체가 main thread 에서 실행.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "2023-01-05"
        
        self.configureHierarchy()
        
        fetchBoxOfficeData {
            DispatchQueue.main.async {
                self.configureDataSource()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchBoxOfficeData {
            DispatchQueue.main.async {
                self.initRefresh()
            }
        }
    }
    
    func creatLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    lazy var collectionView: UICollectionView = UICollectionView(
        frame: view.frame,
        collectionViewLayout: creatLayout()
    )
    
    func configureHierarchy() {
        collectionView.autoresizingMask = [
            .flexibleHeight,
            .flexibleWidth
        ]
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            collectionView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            ),
            collectionView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),
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
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func initRefresh() {
        refreshControl.addTarget(self, action: #selector(refreshCollection), for: .valueChanged)
        
        collectionView.refreshControl = refreshControl
    }
    
    @objc func refreshCollection() {
        self.countUp += 1
        Item.all.removeAll()
        fetchBoxOfficeData {
            DispatchQueue.main.async {
                self.configureDataSource()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.refreshControl.endRefreshing()
            }
        }
    }
}

extension ViewController {
    func printBoxOfficeData() {
        do {
            
            let endPoint = EndPoint(
                baseURL: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
                queryItems: [
                    "key": "d4bb1f8d42a3b440bb739e9d49729660",
                    "targetDt": "20230724"
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
    func fetchBoxOfficeData(completion: @escaping () -> ()) {
        print("DATE =========>>> \(countUp)")
        do {
            
            let endPoint: EndPoint = EndPoint(
                baseURL: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
                queryItems: [
                    "key": "d4bb1f8d42a3b440bb739e9d49729660",
                    "targetDt": "\(countUp)"
                ]
            )
            
            let url = try endPoint.generateURL(
                isFullPath: false
            )
            
            let urlRequest = URLRequest(url: url)
            
            networkManager.getBoxOfficeData(requestURL: urlRequest) { (boxOffice: BoxOffice) in
                let count = boxOffice.boxOfficeResult.dailyBoxOfficeList.count
                for index in 0...(count-1) {
                    let rankNumber = boxOffice.boxOfficeResult.dailyBoxOfficeList[index].rankNumber
                    let rankIntensity = boxOffice.boxOfficeResult.dailyBoxOfficeList[index].rankIntensity
                    let movieName = boxOffice.boxOfficeResult.dailyBoxOfficeList[index].movieName
                    let audienceCount = boxOffice.boxOfficeResult.dailyBoxOfficeList[index].audienceCount
                    let audienceAccumulated = boxOffice.boxOfficeResult.dailyBoxOfficeList[index].audienceAccumulated
                    
                    let items = Item(rankNumber: rankNumber, rankIntensity: rankIntensity, movieName: movieName, audienceCount: audienceCount, audienceAccumulated: audienceAccumulated)
                    
                    Item.all.append(items)
                }
                completion()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
