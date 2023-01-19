//
//  VideoCell.swift
//  YoutubeApp
//
//  Created by Patrick on 19.01.2023..
//

import UIKit

class VideoCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        stackView.alignment = .center

        return stackView
    }()

    lazy var thumbView: UIImageView = {
        var imageView = UIImageView()
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.numberOfLines = 0
        titleLabel.setContentHuggingPriority(.defaultLow, for: .vertical)

        return titleLabel
    }()

    lazy var contentLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 15

        return label
    }()

    func setupUI() {
        self.contentView.addSubview(stackView)
        stackView.addArrangedSubview(thumbView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(contentLabel)
        contentView.backgroundColor = .gray
        thumbView.backgroundColor = .white

        stackView.translatesAutoresizingMaskIntoConstraints = false
        thumbView.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.text = ""
        contentLabel.text = ""

        thumbView.contentMode = .scaleAspectFit
        let fillerImage = UIImage(systemName: "photo.artframe", withConfiguration: UIImage.SymbolConfiguration(pointSize: 220.0, weight: .semibold))
        thumbView.image = fillerImage
        thumbView.tintColor = .darkGray

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            thumbView.leadingAnchor.constraint(lessThanOrEqualTo: stackView.leadingAnchor, constant: 20),
            thumbView.trailingAnchor.constraint(lessThanOrEqualTo: stackView.trailingAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            contentLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            contentLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20)
        ])
    }

    func recieveModel(_ model: Video) {
        self.titleLabel.text = model.title
        self.contentLabel.text = model.description
    }

}
