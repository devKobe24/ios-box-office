//
//  MovieInfomationStackView.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/22.
//

import UIKit

final class MovieInformationStackView: UIStackView {
    private var movieInformation: MovieInformation?
    
    private var directorsInformation: MovieDetailStackView?
    private var productionYearInformation: MovieDetailStackView?
    private var openDateInformation: MovieDetailStackView?
    private var showTimeInformation: MovieDetailStackView?
    private var watchGradeInformation: MovieDetailStackView?
    private var producationNationInformation: MovieDetailStackView?
    private var genreInformation: MovieDetailStackView?
    private var actorsInformation: MovieDetailStackView?
    
    convenience init(frame: CGRect, movieInformation: MovieInformation) {
        self.init(frame: frame)
        self.movieInformation = movieInformation
        
        configureUI()
    }
}

extension MovieInformationStackView {
    private func configureUI() {
        self.axis = .vertical
        self.alignment = .center
        self.distribution = .fill
        self.spacing = 8
        self.translatesAutoresizingMaskIntoConstraints = false
        
        configureLabels()
        
        [directorsInformation,
         productionYearInformation,
         openDateInformation,
         showTimeInformation,
         watchGradeInformation,
         producationNationInformation,
         genreInformation,
         actorsInformation].forEach { stackView in
            guard let stackView = stackView else { return }
            self.addArrangedSubview(stackView)
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        }
    }
    
    private func configureLabels() {
        guard let directorsName = movieInformation?.directors.map({ $0.directorName }).joined(separator: ", "),
              let productionYear = movieInformation?.productionYear,
              var openDate = movieInformation?.openDate,
              let showTime = movieInformation?.showTime,
              let watchGradesName = movieInformation?.audits.map({ $0.watchGradeName }).joined(separator: ", "),
              let producationNation = movieInformation?.productionNations.map({ $0.productionNations }).joined(separator: ", "),
              let genreName = movieInformation?.genres.map({ $0.genreName }).joined(separator: ", "),
              let actorsName = movieInformation?.actors.map({ $0.peopleName }).joined(separator: ", ") else { return }
        
        directorsInformation = MovieDetailStackView(frame: .zero, title: "감독", content: directorsName)
        productionYearInformation = MovieDetailStackView(frame: .zero, title: "제작년도", content: productionYear)
        openDateInformation = MovieDetailStackView(frame: .zero, title: "개봉일", content: openDate.formattedDateWithHyphen())
        showTimeInformation = MovieDetailStackView(frame: .zero, title: "상영시간", content: showTime)
        watchGradeInformation = MovieDetailStackView(frame: .zero, title: "관람등급", content: watchGradesName)
        producationNationInformation = MovieDetailStackView(frame: .zero, title: "제작국가", content: producationNation)
        genreInformation = MovieDetailStackView(frame: .zero, title: "장르", content: genreName)
        actorsInformation = MovieDetailStackView(frame: .zero, title: "배우", content: actorsName)
    }
}


