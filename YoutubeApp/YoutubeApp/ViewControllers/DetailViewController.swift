//
//  DetailViewController.swift
//  YoutubeApp
//
//  Created by Patrick on 20.01.2023..
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    let videoView = WKWebView()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .left
        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()

    let descriptionView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = true

        return textView
    }()

    let margin: CGFloat = 10.0
    let videoRatio: CGFloat = 768.0 / 1024.0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        let views: [UIView] = [titleLabel, dateLabel, videoView, descriptionView]
        views.forEach {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin)
            ])
        }

        titleLabel.text = "Video title"
        dateLabel.text = "01.01.2023"

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: margin),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: margin),
            videoView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: margin),
            videoView.heightAnchor.constraint(equalTo: videoView.widthAnchor, multiplier: videoRatio),
            descriptionView.topAnchor.constraint(equalTo: videoView.bottomAnchor, constant: margin),
            descriptionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin)
        ])
    }

    func openVideo(_ video: Video) {
        titleLabel.text = video.title
        descriptionView.text = video.description

        let df = DateFormatter()
        df.dateFormat = "EEEE, d. MMMM, yyyy"

        self.dateLabel.text = df.string(from: video.published)

        guard let url = URL(string: "https://www.youtube.com/embed/\(video.video)") else {return}
        videoView.load(URLRequest(url: url))
    }
}
