//
//  MovieCell.swift
//  SW Flix
//
//  Created by Sajidah Wahdy on 2/8/22.
//
// created to contain outlets which are the connections(ctrl click drag)
import UIKit

class MovieCell: UITableViewCell {//3 outlets below
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
