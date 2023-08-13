//
//  CustomListCell.swift
//  BoxOffice
//
//  Created by Kobe, yyss99 on 2023/08/08.
//

import UIKit

class CustomListCell: ItemListCell {
    private func defaultListContentConfiguration() -> UIListContentConfiguration {
        return .subtitleCell()
    }
    
    private lazy var listContentView = UIListContentView(configuration: defaultContentConfiguration())
    
    let rankNumberLabel = UILabel()
    let rankChangeLabel = UILabel()
    
    var setupViewsIfNeededFlag: Bool? = nil
}

extension CustomListCell {
    func setupViewsIfNeeded() {
        let movieRankStackView = UIStackView(arrangedSubviews: [rankNumberLabel, rankChangeLabel])
        movieRankStackView.alignment = .fill
        movieRankStackView.distribution = .fillEqually
        movieRankStackView.spacing = 0
        movieRankStackView.axis = .vertical
        movieRankStackView.translatesAutoresizingMaskIntoConstraints = false
        
        [listContentView, movieRankStackView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let listContentViewBottomConstraint = listContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        listContentViewBottomConstraint.priority = .defaultHigh
        let movieRankStackViewBottomConstraint = movieRankStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        movieRankStackViewBottomConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            listContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60),
            listContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            listContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            listContentViewBottomConstraint,
            
            movieRankStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            movieRankStackView.widthAnchor.constraint(equalToConstant: 40),
            movieRankStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            movieRankStackViewBottomConstraint
        ])
        
        setupViewsIfNeededFlag = true
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        setupViewsIfNeeded()
        
        var content = defaultListContentConfiguration().updated(for: state)
        
        content.axesPreservingSuperviewLayoutMargins = []
        
        content.text = state.item?.movieName
        content.textProperties.font = .preferredFont(forTextStyle: .subheadline)
        content.secondaryText = "오늘 \(state.item?.audienceCount ?? "오류") / 총 \(state.item?.audienceAccumulated ?? "오류")"
        
        rankNumberLabel.text = state.item?.rankNumber
        rankNumberLabel.font = .preferredFont(forTextStyle: .title1)
        
        guard let isNewMovie = state.item?.rankOldAndNew else { return }
        guard let rankIntensity = state.item?.rankIntensity else { return }
        
        var rankChangeLabelText: String {
            switch isNewMovie {
            case "NEW":
                return "신작"
            case "OLD":
                return "기존"
            default:
                return "에러"
            }
        }
        
        
        if isNewMovie == "NEW" {
            rankChangeLabel.text = "신작"
            rankChangeLabel.font = UIFont.systemFont(ofSize: 17.0)
            rankChangeLabel.textColor = .red
        } else if isNewMovie == "OLD" {
            makeRankIntensity(rankIntensityData: rankIntensity) { [weak self] rankIntensity in
                self?
                    .rankChangeLabel.attributedText = rankIntensity
            }
        }
        
        
        
        listContentView.configuration = content
    }
}

extension CustomListCell {
    func makeRankIntensity(rankIntensityData: String?, completion: @escaping (NSAttributedString) -> ()?) {
        // MARK: - 공통 사용 변수, 상수
        guard var rankIntensity = rankIntensityData else { return }
        let font = UIFont.systemFont(ofSize: 17.0)
        
        if rankIntensity.contains("-") {
            rankIntensity = rankIntensity.replacingOccurrences(of: "-", with: "▼")
            
            let attributeDownRankIntesity = NSMutableAttributedString(string: rankIntensity)
            attributeDownRankIntesity.addAttributes([
                NSMutableAttributedString.Key.foregroundColor: UIColor.blue,
                NSMutableAttributedString.Key.font: font as Any
            ], range: (rankIntensity as NSString).range(of: "▼"))
            
            completion(attributeDownRankIntesity)
        } else if rankIntensity.contains("0") {
            rankIntensity = rankIntensity.replacingOccurrences(of: "0", with: "-")
            
            let attributeStayRankIntesity = NSMutableAttributedString(string: rankIntensity)
            attributeStayRankIntesity.addAttribute(
                .foregroundColor,
                value: UIColor.black,
                range: (rankIntensity as NSString).range(of: "-")
            )
            
            completion(attributeStayRankIntesity)
        } else {
            rankIntensity = rankIntensity.replacingOccurrences(of: rankIntensity, with: "▲\(rankIntensity)")
            
            let attributeUpRankIntesity = NSMutableAttributedString(string: rankIntensity)
            attributeUpRankIntesity.addAttributes([
                NSMutableAttributedString.Key.foregroundColor: UIColor.red,
                NSMutableAttributedString.Key.font: font as Any
            ], range: (rankIntensity as NSString).range(of: "▲"))
            
            completion(attributeUpRankIntesity)
        }
    }
}

enum RankIntensityCategory {
    case down
    case up
    case stay
}





//        var rankIntensityText: String {
//            if rankIntensity.contains("-") {
//                rankIntensity = rankIntensity.replacingOccurrences(of: "-", with: "▼")
//                return rankIntensity
//            } else if rankIntensity.contains("0") {
//                rankIntensity = rankIntensity.replacingOccurrences(of: "0", with: "-")
//                return rankIntensity
//            }
//            rankIntensity = rankIntensity.replacingOccurrences(of: rankIntensity, with: "▲\(rankIntensity)")
//            return rankIntensity
//        }
