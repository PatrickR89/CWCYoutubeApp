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
        stackView.distribution = .equalCentering
        stackView.alignment = .center

        return stackView
    }()

    lazy var thumbView: UIImageView = {
        var imageView = UIImageView()
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)

        return titleLabel
    }()

    lazy var contentLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.setContentHuggingPriority(.required, for: .vertical)

        return label
    }()

    func setupUI() {
        self.contentView.backgroundColor = .clear
        self.contentView.addSubview(stackView)
        stackView.addArrangedSubview(thumbView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(contentLabel)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        thumbView.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.text = ""
        contentLabel.text = ""

        thumbView.contentMode = .scaleAspectFill
        let fillerImage = UIImage(systemName: "photo.artframe", withConfiguration: UIImage.SymbolConfiguration(pointSize: 220.0, weight: .semibold))
        thumbView.image = fillerImage
        thumbView.tintColor = .darkGray

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            thumbView.leadingAnchor.constraint(lessThanOrEqualTo: stackView.leadingAnchor, constant: 20),
            thumbView.trailingAnchor.constraint(lessThanOrEqualTo: stackView.trailingAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            contentLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            contentLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: thumbView.bottomAnchor, constant: 20),
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        ])
    }

    func recieveModel(_ model: Video) {
        self.titleLabel.text = model.title
        let df = DateFormatter()
        df.dateFormat = "EEEE, d. MMMM, yyyy"

        self.contentLabel.text = df.string(from: model.published)

        guard let url = URL(string: model.thumbnail) else {return}
        let session = URLSession.shared

        let dataTask = session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error!)
                return
            }

            guard let data = data else {
                return
            }

            let image = UIImage(data: data)

            DispatchQueue.main.async { [weak self] in
                self?.thumbView.image = image
                self?.thumbView.tintColor = .none
            }
        }

        dataTask.resume()
    }

}
