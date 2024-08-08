//
//  HomeViewController.swift
//  Test-InnovativeSolutions
//
//  Created by Faraz on 08/08/2024.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var copyrightLabel: UILabel!
    private var data: MostPopularData?
    private var viewModel: HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel(nyTimeService: NYTimesAPIService())
        registerCell()
        bindViewModel()
    }
    
    private func registerCell() {
        let cellNib = UINib(nibName: MostPopularTableViewCell.className, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: MostPopularTableViewCell.className)
    }
    
    func bindViewModel() {
        viewModel?.getMostPopular()
        
        viewModel?.updateData = { [weak self] data in
            guard let self else { return }
            self.data = data
            self.copyrightLabel.text = data.copyright
            self.tableView.reloadData()
        }
        
        viewModel?.updateError = { [weak self] error in
            guard let self else { return }
            self.showAlert(message: error.localizedDescription)
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.num_results ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MostPopularTableViewCell.className,
                                                       for: indexPath) as? MostPopularTableViewCell else {
            return UITableViewCell()
        }
        cell.nextTapped = { [weak self] detail in
            guard let self else { return }
            if let vc = AppStoryboard.Main.instance.instantiateViewController(identifier: DetailViewController.className) as? DetailViewController {
                vc.detail = detail
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        cell.configure(detail: data?.results?[indexPath.row])
//        cell.detail = data?.results?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MostPopularTableViewCell.rowHeight
    }
}
