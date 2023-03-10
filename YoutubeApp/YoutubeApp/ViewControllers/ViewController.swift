//
//  ViewController.swift
//  YoutubeApp
//
//  Created by Patrick on 12.01.2023..
//

import UIKit

class ViewController: UIViewController {

    var videos = [Video]() {
        didSet {
            createSnapshot()
        }
    }
    var model = APICaller()
    var tableView = UITableView()
    var tableViewDiffableDataSource: UITableViewDiffableDataSource<Int, String>? {
        didSet {
            createSnapshot()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewDiffableDataSource = createDataSource()
        setupUI()
        model.getVideos()
        model.delegate = self
    }

    func setupUI() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(VideoCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func createDataSource() -> UITableViewDiffableDataSource<Int, String> {
        let diffableDataSource = UITableViewDiffableDataSource<Int, String>(tableView: tableView) { [weak self] tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? VideoCell else {fatalError()}
            if let video = self?.videos[indexPath.row] {
                cell.recieveModel(video)
            }

            return cell
        }
        return diffableDataSource
    }

    func createSnapshot() {
        guard let tableViewDiffableDataSource = tableViewDiffableDataSource else {
            return
        }
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()

        snapshot.appendSections([0])
        let videoIds = videos.map { $0.video }
        snapshot.appendItems(videoIds, toSection: 0)
        tableViewDiffableDataSource.apply(snapshot)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.openVideo(videos[indexPath.row])
        navigationController?.pushViewController(detailViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: APICallerDelegate {
    func apiCaller(didRecieve reponse: [Video]) {
        self.videos = reponse
    }
}

