//
//  StepItemTableViewCell.swift
//  Steps
//
//  Created by Corey Morello on 7/13/20.
//  Copyright © 2020 Corey Morello. All rights reserved.
//

import UIKit

public class StepItemTableViewCell: UITableViewCell {
    public static let reuseIdentifier = "StepItemTableViewCell"
    var padding = UIEdgeInsets(top: 20, left: 20, bottom: -20, right: -20)

    public var date: Date = Date() {
        didSet {
            self.daysAgoLabel.text = self.date.daysAgoString
            self.dateLabel.text = self.date.shortDateString
        }
    }

    public var stepValue: Int = 0 {
        didSet {
            self.stepValueLabel.text = "\(self.stepValue)"
        }
    }

    private lazy var daysAgoLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.accessibilityIdentifier = "dateLabel"
        self.contentView.addSubview(view)
        view.font = UIFont.preferredFont(forTextStyle: .subheadline)
        view.textColor = view.textColor.withAlphaComponent(0.6)
        view.numberOfLines = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: padding.top),
            view.bottomAnchor.constraint(equalTo: self.dateLabel.topAnchor),
            view.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: padding.left),
            view.rightAnchor.constraint(equalTo: self.stepTitleLabel.leftAnchor, constant: padding.right),
        ])
        return view
    }()

    private lazy var dateLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.accessibilityIdentifier = "daysAgoLabel"
        self.contentView.addSubview(view)
        view.font = UIFont.preferredFont(forTextStyle: .title1)
        view.numberOfLines = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        NSLayoutConstraint.activate([
            view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: padding.bottom),
            view.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: padding.left),
            view.rightAnchor.constraint(equalTo: self.stepValueLabel.leftAnchor, constant: padding.right),
        ])
        return view
    }()

    private lazy var stepTitleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.accessibilityIdentifier = "stepTitleLabel"
        self.contentView.addSubview(view)
        view.font = UIFont.preferredFont(forTextStyle: .subheadline)
        view.textColor = view.textColor.withAlphaComponent(0.6)
        view.numberOfLines = 1
        view.textAlignment = .right
        view.text = "Step Total"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: padding.top),
            view.bottomAnchor.constraint(equalTo: self.stepValueLabel.topAnchor),
            view.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: padding.right),
        ])
        return view
    }()

    private lazy var stepValueLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.accessibilityIdentifier = "dateLabel"
        self.contentView.addSubview(view)
        view.font = UIFont.preferredFont(forTextStyle: .title1)
        view.numberOfLines = 1
        view.textAlignment = .right
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        NSLayoutConstraint.activate([
            view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: padding.bottom),
            view.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: padding.right),
        ])
        return view
    }()

}
