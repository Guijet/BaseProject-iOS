//
//  UITableViewTools.swift
//  InfluenceMe
//
//  Created by Guillaume Jette on 2018-01-25.
//  Copyright © 2018 Guillaume Jette. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "cellID")
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been found")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setUpView(){}
}
