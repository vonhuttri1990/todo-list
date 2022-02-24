//
//  TodoCell.swift
//  Todo List
//
//  Created by Võ Trí on 11/02/2022.
//

import UIKit



class TodoCell: UITableViewCell {
    @IBOutlet weak var todoLabel: UILabel!
    var btnPressed: (() -> ()) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tappedDoneTodo(_ sender: UIButton) {
        btnPressed()
    }
}
