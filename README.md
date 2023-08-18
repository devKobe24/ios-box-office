*# 박스오피스[STEP4]

> 📌 네트워킹을 활용하여 박스오피스 데이터를 불러와 정보를 화면에 표기하고 리스트를 잡아끌면 새로고침할 수 있도록 하는 기능이 있는 앱입니다.

## 📚 목차</br>
- [팀원소개](#-팀원-소개)
- [파일트리](#-파일트리)
- [시각화된 프로젝트 구조](#시각화된-프로젝트-구조)
- [타임라인](#-타임라인)
- [실행화면](#-실행화면)
- [트러블 슈팅](#-트러블-슈팅)
- [참고자료](#-참고자료)

## 🧑‍💻 팀원 소개</br>
| <img src="https://hackmd.io/_uploads/H11K3alon.png" width="200" height="200"/> | <img src="https://github.com/devKobe24/BranchTest/blob/main/IMG_5424.JPG?raw=true" width="200" height="200"/> |
| :-: | :-: |
| [**yyss99(와이)**](https://github.com/yy-ss99) | [**Kobe**](https://github.com/devKobe24) |

## 🗂️ 파일트리</br>
```
.
├── BoxOffice
│   ├── API_KEY.plist
│   ├── Model
│   │   ├── ApiDataConfigurable.swift
│   │   ├── BoxOffice.swift
│   │   ├── EndPoint.swift
│   │   ├── Fetchable.swift
│   │   ├── IndividualMovieDetailInformation.swift
│   │   ├── Item.swift
│   │   ├── KakaoImageSearchResult.swift
│   │   ├── MoviePoster.swift
│   │   ├── NetworkConfigurable.swift
│   │   ├── NetworkConfigure
│   │   │   └── Implementation
│   │   ├── NetworkManager.swift
│   │   ├── RankIntensity.swift
│   │   ├── Section.swift
│   │   └── URLSession.swift
│   ├── View
│   │   ├── Base.lproj
│   │   │   ├── LaunchScreen.storyboard
│   │   │   └── Main.storyboard
│   │   ├── CustomListCell.swift
│   │   └── ItemListCell.swift
│   ├── Controller
│   │   ├── DetailViewController.swift
│   │   └── ViewController.swift
│   ├── Error
│   │   ├── NetworkConfigurableError.swift
│   │   ├── NetworkManagerError.swift
│   │   └── URLRequestError.swift
│   ├── Extension
│   │   ├── Bundle+.swift
│   │   ├── DateFormatter+.swift
│   │   ├── String+.swift
│   │   ├── UICellConfigurationState+.swift
│   │   └── UIConfigurationStateCustomKey+.swift
│   │
│   └── Resource
│       ├── AppDelegate.swift
│       ├── Assets.xcassets
│       │   ├── AccentColor.colorset
│       │   │   └── Contents.json
│       │   ├── AppIcon.appiconset
│       │   │   └── Contents.json
│       │   ├── Contents.json
│       │   └── box_office_sample.dataset
│       │       ├── Contents.json
│       │       └── box_office_sample.json
│       └── SceneDelegate.swift
├── BoxOfficeTests
│   ├── BoxOfficeTestPlan.xctestplan
│   └── BoxOfficeTests.swift
└── README.md
```

## 🗺️ 시각화된 프로젝트 구조</br>
<img src = "https://github.com/devKobe24/images/blob/main/BoxOffice_Step4_UML.png?raw=true">

## ⏰ 타임라인</br>
프로젝트 진행 기간 | 23.07.10.(월) ~ 23.07.14.(금)

| 날짜 | 진행 사항 |
| -------- | -------- |
| 23.07.25.(월)     |  BoxOffice 모델 객체 생성 및 구현. <br/> JSON 객체 추가 및 BoxOffice 모델 생성 및 구현. <br/> BoxOfficeModel에 코딩키 추가. <br/> BoxOffice Model Unit Test 생성 및 실행.<br/> refactor: MVC 패턴으로 폴더링.<br/> |
| 23.07.26.(화)     | 인덴트 수정.<br/>
| 23.07.27.(수)     | NetworkManager 구현 및 MakeURLRequestError 오류 타입 구현.<br/>
| 23.08.01(화)     | NetworkConfigurable 프로토콜 구현 및 확장.<br/> NetworkConfigurable에 generateURL 메서드 추가.<br/> NetworkConfigurableError 타입 구현.<br/> App Transport Security Settings Key를 추가. <br/> API_KEY gitignore 추가.<br/> Bundle 확장 및 내부 구현. <br/> BoxOffice 데이터 출력을 위한 함수 구현.<br/>
| 23.08.01(화)     | 리드미 업데이트.<br/> NetWorkManagerError 생성. <br/>
| 23.08.06(일)     | Section 모델 구현.<br/>  UIConfigurationStateCustomKey 확장 및 구현. <br/> UICellConfigurationState 확장. <br/>
| 23.08.08(화)     |UICellConfigurationState에 Item 추가. <br/>  boxOffice 구조체에 Hashable 포로토콜 채택. <br/>  UICellConfigurationState에 Item 추가. <br/> CustomListCell 생성. <br/> ItemListCell로 파일명 변경. <br/> CustomListCell 구현. <br/> configureDataSource, creatLayout 함수 구현
| 23.08.10(목)     | Item 타입 생성.<br/> Item 타입으로 수정.<br/> generateURL 함수 수정.<br/> fetchBoxOfficeData 함수 생성, Item으로 수정.<br/> CustomListCell Layout 수정. <br/> ViewController refresh 기능 구현, navigationController 추가.
| 23.08.11(금)     | CustomListCell Layout 수정. <br/> DateFormatter extension 파일 생성 및 구현, viewController에 적용. <br/>
| 23.08.12(토)     | String을 확장하여 numberformat 함수 구현. <br/> numberformat 메서드 적용.<br/>  rankChangeLabel 순위 등락 표시 생성 및 적용
| 23.08.13(일)     | DetailViewController 생성. <br/> DetailViewController로 화면 전환을 위한 메서드 구현 <br/> CustomListCell 순위등락 기능 추가 및 수정.
| 23.08.16(수)     | RankIntensity 추가 및 CustomListCell 등락 표시 기능 수정. <br/> detailViewController 이동 로직 구현. <br/> DetailViewController 초기 필수 사항 구현. <br/>  movieCode 프로퍼티 추가. <br/> IndividualMovieDetailInfomation 모델 객체 구현.<br/> DetailViewController UI 구성 및 Layout 구현. <br/>  ApiDataConfigurable, ApiDataNetworkConfig 생성 및 구현. <br/> viewController 데이터 가져오는 기능 수정.
| 23.08.18(금)     |배우 이름 로직 변경, 영화 포스터 mock 이미지 삽입.



## 📺 실행화면</br>
- STEP3 BoxOffice 시뮬레이터 실행화면 🎬 </br>
<img src = "https://github.com/devKobe24/images/blob/main/BoxOffice_STEP4.gif?raw=true">

## 🔨 트러블 슈팅 
### 1️⃣ **배우가 빈 값인 경우가 있습니다.**</br>
### 🔒 **문제점** 🔒</br>
<img src = "https://github.com/devKobe24/images/blob/main/Boxoffice_STEP4_%E1%84%90%E1%85%B3%E1%84%85%E1%85%A5%E1%84%87%E1%85%B3%E1%86%AF%E1%84%89%E1%85%B2%E1%84%90%E1%85%B5%E1%86%BC(1).png?raw=true"></br>

**🚨 `postman`으로 확인해본 결과 `staffs`가 빈 배열로 결과값이 들어오는 경우가 있었습니다.**</br>

### 🔑 **해결방법** 🔑</br>
**🙋‍♂️ 비어있는 배열이 들어올 경우 "없음"이라는 값으로 actorNames에 값을 주고 값이 있을 경우에는 콤마를 기준으로 새로운 값을 actorNames에 값을 줄 수 있는 계산 프로퍼티를 만들었습니다.</br>이 계산 프로퍼티를 makeStackView의 detail에 값으로 넣어주어 해결하였습니다.**

<details> 
<summary> DetailViewController </summary>

```swift!
import UIKit

class DetailViewController: UIViewController {
        private var detailInformation: IndividualMovieDetailInformation?
        private let networkManager: NetworkManager = NetworkManager()
    
            override func viewDidLoad() {
            super.viewDidLoad()
        
            fetchDetailData {
                DispatchQueue.main.async {
                    self.configureMovieStackView()
                }
            }
        }
    
        func configureMovieStackView() {
    
        let movieDetailStackView = UIStackView()
    
        movieDetailStackView.translatesAutoresizingMaskIntoConstraints = false
        movieDetailStackView.axis = .vertical
        movieDetailStackView.spacing = 5
    
        contentView.addSubview(movieDetailStackView)
        
        NSLayoutConstraint.activate([
            movieDetailStackView.topAnchor.constraint(
            equalTo: posterImageView.bottomAnchor,
            constant: 10
        ),
            movieDetailStackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
        ),
            movieDetailStackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -3
        ),
            movieDetailStackView.bottomAnchor.constraint(
        equalTo: contentView.bottomAnchor
        )
            ])
        
        guard let detail = detailInformation else { return }
    
        makeStackView(
            categoryName: "감독",
            detail: detail.movieInfoResult.movieInfo.directors[0].directorName,
            in: movieDetailStackView
        )
        makeStackView(
            categoryName: "제작년도",
            detail: detail.movieInfoResult.movieInfo.productionYear,
            in: movieDetailStackView
        )
        makeStackView(
            categoryName: "개봉일",
            detail: detail.movieInfoResult.movieInfo.openDate,
            in: movieDetailStackView
        )
        makeStackView(
            categoryName: "상영시간",
            detail: detail.movieInfoResult.movieInfo.showTime,
            in: movieDetailStackView
        )
        makeStackView(
            categoryName: "관람등급",
            detail: detail.movieInfoResult.movieInfo.audits[0].watchGradeName,
            in: movieDetailStackView
        )
        makeStackView(
            categoryName: "제작국가",
           detail: detail.movieInfoResult.movieInfo.productionNations[0].productionNations,
            in: movieDetailStackView
        )
        makeStackView(
            categoryName: "장르",
            detail: detail.movieInfoResult.movieInfo.genres[0].genreName,
            in: movieDetailStackView
        )
            var actorNames: String {
        if detail.movieInfoResult.movieInfo.actors.isEmpty {
            return "없음"
        } else {
            let actorsNameInList = detail.movieInfoResult.movieInfo.actors.map { $0.peopleName }
            return actorsNameInList.joined(separator: ", ")
        }
            }
        makeStackView(
            categoryName: "배우",
            detail: actorNames,
            in: movieDetailStackView
        )
    }
}
```
</details>

<details> 
<summary> DetailViewController Extension </summary>

```swift!
import UIKit
    
extension DetailViewController {
    func fetchDetailData(completion: @escaping () -> Void) {
        do {
            let endPoint = EndPoint(
                baseURL: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json",
                queryItems: ["key": Bundle.main.API ,"movieCd":selectedMovieCode]
            )
            
            let url = try endPoint.generateURL(isFullPath: false)
            
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

```
</details>

### 2️⃣ **이미지 쿼리 명에 따라 달리 나오는 이미지 결과.** </br>
### 🔒 **문제점** 🔒</br>
**🚨 이미지 검색시 쿼리의 Value를 `[영화제목 + 영화 포스터]`로 검색 했을 때, 검색 결과가 제대로 된 이미지를 가져오지 못하는 현상이 있었습니다.**

### 🔑 **해결방법** 🔑</br>
🙋‍♂️`[영화제목 + 포스터]`라는 Value를 사용하여 이미지 검색 결과의 정확도를 높혔습니다.</br>

- 1. `[나홀로집에 + 영화 포스터] 검색 결과` 예시.
    - <img src = "https://github.com/devKobe24/images/blob/main/%E1%84%8C%E1%85%B5%E1%84%80%E1%85%AA%E1%86%AB%E1%84%90%E1%85%A9%E1%86%BC.jpeg?raw=true" width = 300>
- 2. `[나홀로집에 + 포스터] 검색 결과` 예시
    - <img src = "https://github.com/devKobe24/images/blob/main/%E1%84%82%E1%85%A1%E1%84%92%E1%85%A9%E1%86%AF%E1%84%85%E1%85%A9%20%E1%84%8C%E1%85%B5%E1%86%B8%E1%84%8B%E1%85%A6%201.jpg?raw=true"  width = 300>

### 3️⃣ ScrollView에서 poster의 높이를 정해주기

### 🔒 **문제점** 🔒</br>
`poster`는 화면에서 영화에 대한 세부 설명 위쪽에 고정되어서 일정한 크기를 유지해야 합니다. 스크롤뷰 였기 때문에 `Constraint`를 어떤 식으로 잡을지 고민을 많이 했습니다.

### 🔑 **해결방법** 🔑</br>

```swift
NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            posterImageView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor, multiplier: 2/3)
        ])
```

`poster`의 높이를 `contentView`가 아닌 `frameLayout`을 기준으로 비율을 정해주었습니다. 
`contentView`는 스크롤 했을 때 보이는 모든 화면 크기를 기준으로 하고 있으므로 유동적입니다. 그래서 `contentView`를 기준으로 `poster`의 크기를 잡게 되면, 그때그때 담기는 값에 따라 달라지는 스크롤뷰의 높이에 따라서 `poster`의 높이도 매번 바뀌게 됩니다. 그래서 변하지 않고 현재 화면을 기준으로 하는 `frameLayout`을 높이로 `poster`에 대한 `constraint`를 잡아주었습니다.

## 📑 참고자료
- [📃 Encoding, Decoding, and Serialization](https://developer.apple.com/documentation/swift/encoding-decoding-and-serialization)
    - [📃 Decodable](https://developer.apple.com/documentation/swift/decodable)
    - [📃 CodingKey](https://developer.apple.com/documentation/swift/codingkey)
- [📃 Basic Behaviors](https://developer.apple.com/documentation/swift/basic-behaviors)
    - [📃 Hashable](https://developer.apple.com/documentation/swift/hashable)
    - [📃 Identifiable](https://developer.apple.com/documentation/swift/identifiable)
- [📃 UIFont](https://developer.apple.com/documentation/uikit/uifont)
    - [📃 preferredFont(forTextStyle:)](https://developer.apple.com/documentation/uikit/uifont/1619030-preferredfont)
- [📃 Generics](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/generics/)
- [📃 Protocols](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols/)
- [📃 UIStackView](https://developer.apple.com/documentation/uikit/uistackview)
- [📃 UIScrollView](https://developer.apple.com/documentation/uikit/uiscrollview)
- [📃 snapshot()](https://developer.apple.com/documentation/uikit/uicollectionviewdiffabledatasource/3255141-snapshot)
- [📃 UICollectionViewListCell](https://developer.apple.com/documentation/uikit/uicollectionviewlistcell)
- [📃 UICollectionView.CellRegistration](https://developer.apple.com/documentation/uikit/uicollectionview/cellregistration)
- [📃 UICollectionViewDiffableDataSource](https://developer.apple.com/documentation/uikit/uicollectionviewdiffabledatasource)
- [📃 UICollectionViewLayout](https://developer.apple.com/documentation/uikit/uicollectionviewlayout)
- [📃 UICollectionViewCompositionalLayout](https://developer.apple.com/documentation/uikit/uicollectionviewcompositionallayout)
- [📃 UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview)
    - [🎦 Modern cell configuration](https://developer.apple.com/videos/play/wwdc2020/10027/)
    - [🎦 Lists in UICollectionView](https://developer.apple.com/videos/play/wwdc2020/10026)
    - [📃 Implementing Modern Collection Views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views)
