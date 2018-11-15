//
//  TodoCellDelegate.swift
//  todo-app
//
//  Created by Michael Florendo on 15/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import Foundation

protocol TodoCellDelegate {
    func todoStatusToggle(_ sender: TodoTableViewCell)  //function to handle button toggling inside the cell
}
