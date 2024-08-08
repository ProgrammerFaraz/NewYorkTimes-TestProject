//
//  DetailViewController.swift
//  Test-InnovativeSolutions
//
//  Created by Faraz on 08/08/2024.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var titleImageView: UIImageView!

    var detail: MostPopularResults?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        guard let detail else { return }
        titleLabel.text = detail.title
        captionLabel.text = detail.media?.first?.caption
        abstractLabel.text = detail.abstract
        copyrightLabel.text = detail.media?.first?.copyright
        urlLabel.text = detail.url
        if let url = URL(string: detail.media?.first?.mediaMetadata?.last?.url ?? "") {
            titleImageView.loadImage(from: url, placeholder: UIImage(named: "placeholder"))
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func linkTapped(_ sender: UIButton) {
        guard let detail else { return }
        if let openLink = URL(string: detail.url ?? "") {
            if UIApplication.shared.canOpenURL(openLink) {
                UIApplication.shared.open(openLink, options: [:])
            }
        }
    }
}
