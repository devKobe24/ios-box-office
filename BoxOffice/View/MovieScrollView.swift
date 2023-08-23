//
//  MovieScrollView.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/22.
//

import UIKit

final class MovieScrollView: UIScrollView {
    private var movieInformationData: MovieInformation?
    private var moviePosterImage: UIImage?
    private var movieInformationStackView: MovieInformationStackView?
    
    private let containerStackView: UIStackView = {
        let containerStackView: UIStackView = UIStackView()
        containerStackView.axis = .vertical
        containerStackView.alignment = .center
        containerStackView.distribution = .fill
        containerStackView.spacing = 8
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return containerStackView
    }()
    
    private let moviePosterImageView: UIImageView = {
        let moviePosterImageView: UIImageView = UIImageView()
        moviePosterImageView.contentMode = .scaleAspectFit
        moviePosterImageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        
        return moviePosterImageView
    }()
    
    convenience init(
        frame: CGRect,
        movieInformationData: MovieInformation,
        moviePosterImage: UIImage,
        movieInformationStackView: MovieInformationStackView
    ) {
        self.init(frame: frame)
        self.movieInformationData = movieInformationData
        self.moviePosterImage = moviePosterImage
        self.movieInformationStackView = movieInformationStackView
        self.translatesAutoresizingMaskIntoConstraints = false
        
        configureUI()
        setUpConstraints()
    }
}

extension MovieScrollView {
    private func configureUI() {
        do {
            guard let movieInformationStackView = self.movieInformationStackView else {
                return
            }
            configureMoviePoster()
            try configureMovieInformationStackView()
            
            self.addSubview(containerStackView)
            containerStackView.addArrangedSubview(moviePosterImageView)
            containerStackView.addArrangedSubview(movieInformationStackView)
            
        } catch {
            print(MovieInformationDataError.decodeFailed)
        }
    }
    
    private func configureMoviePoster() {
        moviePosterImageView.image = moviePosterImage
    }
    
    private func configureMovieInformationStackView() throws {
        guard let movieInfomationData = movieInformationData else {
            throw MovieInformationDataError.decodeFailed
        }
        movieInformationStackView = MovieInformationStackView(frame: .zero, movieInformation: movieInfomationData)
    }
    
    private func calculateMoviePosterRation() -> Double {
        guard let moviePosterImage = moviePosterImage else {
            return Double().defaultMoviePosterRatio
        }
        
        return Double(moviePosterImage.size.height) / Double(moviePosterImage.size.width)
    }
    
    private func setUpConstraints() {
        guard let movieInformationStackView = self.movieInformationStackView else { return }
        
        let posterRatio = calculateMoviePosterRation()
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            moviePosterImageView.widthAnchor.constraint(
                equalTo: containerStackView.widthAnchor,
                multiplier: CGFloat().moviePosterImageFromContainerStackViewWidth
            ),
            
            moviePosterImageView.heightAnchor.constraint(
                equalTo: containerStackView.widthAnchor,
                multiplier: posterRatio
            ),
            
            movieInformationStackView.widthAnchor.constraint(
                equalTo: containerStackView.widthAnchor,
                multiplier: CGFloat().movieInformationStackViewFromContainerStackViewWidth
            )
        ])
    }
}


