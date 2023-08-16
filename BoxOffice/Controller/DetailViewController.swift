//
//  DetailViewController.swift
//  BoxOffice
//
//  Created by Kobe, yyss99 on 2023/08/13.
//

import UIKit

class DetailViewController: UIViewController {
    var selectedMovieCode: String
    
    init(selectedMovieCode: String) {
        self.selectedMovieCode = selectedMovieCode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemPink
        
    }

}
