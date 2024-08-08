//
//  MostPopularTableViewCell.swift
//  Test-InnovativeSolutions
//
//  Created by Faraz on 08/08/2024.
//

import UIKit

class MostPopularTableViewCell: UITableViewCell {

    static let rowHeight: CGFloat = 145
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleImageView: UIImageView!
    
    var detail: MostPopularResults?

    var nextTapped: ((MostPopularResults?)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
 
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        titleImageView.roundCorners([.allCorners], radius: titleImageView.frame.size.width/2)
    }
    
    func configure(detail: MostPopularResults?) {
        guard let detail else { return }
        self.detail = detail
        self.titleLabel.text = detail.title
        self.subtitleLabel.text = detail.byline
        if let url = URL(string: detail.media?.first?.mediaMetadata?.last?.url ?? "") {
            titleImageView.loadImage(from: url, placeholder: UIImage(named: "placeholder"))
        }
    }
    
    @IBAction func nextScreenTapped(_ sender: UIButton) {
        self.nextTapped?(detail)
    }
}
