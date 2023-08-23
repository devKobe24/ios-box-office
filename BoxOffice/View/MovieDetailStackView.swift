//
//  MovieDetailStackView.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/22.
//

import UIKit

final class MovieDetailStackView: UIStackView {
    private var title: String?
    private var content: String?
    
    private let itemTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = .zero
        
        return label
    }()
    
    private let itemDescriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = .zero
        
        return label
    }()
    
    convenience init(
        frame: CGRect,
        title: String,
        content: String
    ) {
        self.init(frame: frame)
        self.title = title
        self.content = content.isEmpty ? "-" : content
        
        configureUI()
        setUpConstraints()
    }
}

extension MovieDetailStackView {
    private func configureUI() {
        
        self.axis = .horizontal
        self.alignment = .fill
        self.distribution = .fill
        self.spacing = .zero
        self.translatesAutoresizingMaskIntoConstraints = false
        
        configureLabels()
        
        self.addArrangedSubview(itemTitleLabel)
        self.addArrangedSubview(itemDescriptionLabel)
    }
    
    private func configureLabels() {
        itemTitleLabel.text = title
        itemDescriptionLabel.text = content
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            itemTitleLabel.widthAnchor.constraint(
                equalTo: self.widthAnchor,
                multiplier: CGFloat().itemTitleLabelFromMovieDetailStackViewWidth
            )
        ])
    }
}
