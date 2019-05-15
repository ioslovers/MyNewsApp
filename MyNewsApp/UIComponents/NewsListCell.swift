//
//  SearchSuggestionCell.swift
//  MyNewsApp
//
//  Created by Ashish Tripathi on 11/5/19.
//  Copyright © 2019 Ashish Tripathi. All rights reserved.
//

import UIKit

/// NewsListCellData protocol for data sources
public protocol NewsListCellData {
    var title: UIElementValue<String> { get }
    var body: UIElementValue<String> { get }
    var footer: UIElementValue<String> { get }
    var icon: UIElementValue<String> { get }
    var cellValue: UIElementValue<String> { get }
}

final public class NewsListCell: UITableViewCell {
    
    //  MARK:- Outlets
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var bodyLabel: UILabel!
    @IBOutlet private var footerLabel: UILabel!
    @IBOutlet private var iconView: UIImageView!
    
    //  MARK:- Public routines
    public static let cellId = "NewsListCellId"
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization style
        setStyle()
    }

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setStyle()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func show(data: NewsListCellData) {
        titleLabel.text = data.title.rawValue
        titleLabel.accessibilityValue = data.title.accessibilityValue
        titleLabel.accessibilityIdentifier = data.title.accessibilityIdentifier
        
        bodyLabel.text = data.body.rawValue
        bodyLabel.accessibilityLabel = data.body.accessibilityValue
        bodyLabel.accessibilityIdentifier = data.body.accessibilityIdentifier
        
        footerLabel.text = data.footer.rawValue
        footerLabel.accessibilityLabel = data.footer.accessibilityValue
        footerLabel.accessibilityIdentifier = data.footer.accessibilityIdentifier
        
        iconView.loadThumbnail(urlSting: data.icon.rawValue)
        iconView.accessibilityLabel = data.icon.accessibilityValue
        iconView.accessibilityIdentifier = data.icon.accessibilityIdentifier
        
        accessibilityLabel = data.cellValue.accessibilityValue
        accessibilityIdentifier = data.cellValue.accessibilityIdentifier

    }

    public func setStyle(titleFont: UIFont = Theme.appearance.font.basicFont.title,
                          titleTextColor: UIColor = Theme.appearance.color.basicColor.title,
                          subTitleFont: UIFont = Theme.appearance.font.basicFont.footer,
                          subTitleTextColor: UIColor = Theme.appearance.color.basicColor.body,
                          footerFont: UIFont = Theme.appearance.font.basicFont.footer,
                          footerTextColor: UIColor = Theme.appearance.color.basicColor.body
                          ) {
        titleLabel.font = titleFont
        titleLabel.textColor = titleTextColor
        bodyLabel.font = subTitleFont
        bodyLabel.textColor = subTitleTextColor
        footerLabel.font = footerFont
        footerLabel.textColor = footerTextColor
    }
}
