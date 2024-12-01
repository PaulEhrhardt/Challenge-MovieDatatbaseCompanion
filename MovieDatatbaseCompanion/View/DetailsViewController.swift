//
//  DetailsViewController.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 1/12/24.
//

import UIKit


// MARK: - TrendingView -

final class DetailsViewController: UIViewController {



    // MARK: - Proerties

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var originTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var originCountryLabel: UILabel!
    @IBOutlet weak var homepageLabel: UILabel!
    @IBOutlet weak var averageVoteLabel: UILabel!


    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    // MARK: - API

    func scrollViewVisibility(shouldShow: Bool) {
        if shouldShow {
            scrollView.alpha = 1.0
            activityIndicator.isHidden = true
        } else {
            scrollView.alpha = 0.0
            activityIndicator.isHidden = false
        }
    }
}
