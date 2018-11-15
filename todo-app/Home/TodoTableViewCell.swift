//
//  TodoTableViewCell.swift
//  todo-app
//
//  Created by Michael Florendo on 09/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    
    //MARK: -Properties
    
    @IBOutlet weak var todoStatus: UILabel!
    @IBOutlet weak var todoTitle: UILabel!
    @IBOutlet weak var buttonStatus: UIButton!
    
    var delegate: TodoCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonStatusTapped(_ sender: UIButton) {
        self.delegate?.todoStatusToggle(self)
    }
}
