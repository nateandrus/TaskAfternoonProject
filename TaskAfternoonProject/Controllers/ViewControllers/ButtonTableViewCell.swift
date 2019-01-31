//
//  ButtonTableViewCell.swift
//  TaskAfternoonProject
//
//  Created by Nathan Andrus on 1/30/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

import UIKit

@IBDesignable

class ButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    var delegate: ButtonTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        delegate?.buttonCellButtonTapped(self)
    }
    
    fileprivate func updateButton(_ isComplete: Bool) {
        let imageName = isComplete ? "complete" : "incomplete"
        completeButton.setImage(UIImage(named: imageName), for: .normal)
    }

}

extension ButtonTableViewCell {
    
    func update(withTask task: Task) {
        nameLabel.text = task.name
        updateButton(task.isComplete)
    }
}

protocol ButtonTableViewCellDelegate {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell)
}
