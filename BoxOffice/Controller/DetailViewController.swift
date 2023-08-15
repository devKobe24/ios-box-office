//
//  DetailViewController.swift
//  BoxOffice
//
//  Created by Kobe, yyss99 on 2023/08/13.
//

import UIKit

class DetailViewController: UIViewController {
    let scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let contentView: UIView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    let movieImageView: UIImageView = {
        let movieImageView: UIImageView = UIImageView()
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        return movieImageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        addSubViews()
        setUpScrollViewConstraints()
        setUpContentViewConstraints()
        setUpMovieImageViewContraints()
    }

}

extension DetailViewController {
    private func addSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(movieImageView)
    }
    
    private func setUpScrollViewConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setUpContentViewConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
    }
    
    private func setUpMovieImageViewContraints() {
        NSLayoutConstraint.activate([
            movieImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            movieImageView.widthAnchor.constraint(equalToConstant: 300),
            movieImageView.heightAnchor.constraint(equalTo: movieImageView.widthAnchor, multiplier: 2),
        ])
        
    }
}
