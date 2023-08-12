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
        
        guard let isNewMovie = state.item?.rankOldAndNew else { return }
        guard var rankIntensity = state.item?.rankIntensity else { return }
        
        var rankIntensityText: String {
            if rankIntensity.contains("-") {
                rankIntensity = rankIntensity.replacingOccurrences(of: "-", with: "▼")
                return rankIntensity
            } else if rankIntensity.contains("0") {
                rankIntensity = rankIntensity.replacingOccurrences(of: "0", with: "-")
                return rankIntensity
            }
            rankIntensity = rankIntensity.replacingOccurrences(of: rankIntensity, with: "▲\(rankIntensity)")
            return rankIntensity
        }
        
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
        
//        var rankIntensityOperation: NSAttributedString? {
//            guard let rankIntensity = rankIntensity else { return nil }
//            if rankIntensity.contains("-") {
//                return makeRankIntensity(rankIntensityData: rankIntensity, rankIntensityState: .down)
//            } else if rankIntensity.contains("0") {
//                return makeRankIntensity(rankIntensityData: rankIntensity, rankIntensityState: .stay)
//            }
//            return makeRankIntensity(rankIntensityData: rankIntensity, rankIntensityState: .up)
//        }
        
        if isNewMovie == "NEW" {
            rankChangeLabel.text = rankChangeLabelText
        } else if isNewMovie == "OLD" {
//            rankChangeLabel.text = rankIntensityText
//            guard let rankIntensityOperation = rankIntensityOperation else { return }
            rankChangeLabel.text = rankIntensityText
        }
        
        
        rankNumberLabel.font = .preferredFont(forTextStyle: .title1)
        listContentView.configuration = content
    }
}

extension CustomListCell {
    func makeRankIntensity(rankIntensityData: String?, rankIntensityState: RankIntensityCategory) -> NSAttributedString? {
        // MARK: - 공통 사용 변수, 상수
        guard var rankIntensity = rankIntensityData else { return nil }
        let font = UIFont.systemFont(ofSize: 17.0)
        
        // MARK: - downRankIntensity
        var downRankIntensity: String? {
            if rankIntensity.contains("-") {
                rankIntensity = rankIntensity.replacingOccurrences(of: "-", with: "▼")
                return rankIntensity
            }
            return nil
        }
        
        let downRankIntensityAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.red,
            NSAttributedString.Key.font: font as Any
        ] as [NSAttributedString.Key: Any]
        
        guard let downRankIntensity = downRankIntensity else { return nil }
        
        let attributeDownRankIntesity = NSMutableAttributedString(string: downRankIntensity)
        attributeDownRankIntesity.addAttribute(
            .foregroundColor,
            value: UIColor.blue,
            range: (downRankIntensity as NSString).range(of: "▼")
        )
        
        // MARK: - upRankIntensity
        var upRankIntensity: String? {
            rankIntensity = rankIntensity.replacingOccurrences(of: rankIntensity, with: "▲" + "\(rankIntensity)")
            return rankIntensity
        }
        
        let upRankIntensityAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.red,
            NSAttributedString.Key.font: font as Any
        ] as [NSAttributedString.Key: Any]
        
        guard let upRankIntensity = upRankIntensity else { return nil }
        
        let attributeUpRankIntesity = NSMutableAttributedString(string: upRankIntensity)
        attributeUpRankIntesity.addAttribute(
            .foregroundColor,
            value: UIColor.red,
            range: (upRankIntensity as NSString).range(of: "▲")
        )

        // MARK: - stayRankIntensity
        var stayRankIntensity: String? {
            rankIntensity = rankIntensity.replacingOccurrences(of: "0", with: "-")
            return rankIntensity
        }
        
        let stayRankIntensityAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.red,
            NSAttributedString.Key.font: font as Any
        ] as [NSAttributedString.Key: Any]
        
        guard let stayRankIntensity = stayRankIntensity else { return nil }
        
        let attributeStayRankIntesity = NSMutableAttributedString(string: stayRankIntensity)
        attributeStayRankIntesity.addAttribute(
            .foregroundColor,
            value: UIColor.red,
            range: (stayRankIntensity as NSString).range(of: "-")
        )
        
        switch rankIntensityState {
        case .down:
            return attributeDownRankIntesity
        case .up:
            return attributeUpRankIntesity
        case .stay:
            return attributeStayRankIntesity
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
