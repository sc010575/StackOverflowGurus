//
//  HomeViewCell.swift
//  StackOverflowGurus
//
//  Created by Suman Chatterjee on 09/10/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import UIKit

final class HomeViewCell: UITableViewCell {

    enum UIConstant {
        static let buttonDimention: CGFloat = 40
        static let stackViewSpacing: CGFloat = 15
        static let tralingContentPadding: CGFloat = 12
        static let leadingContentPadding: CGFloat = 8
    }



//    var cellViewModel: CellViewModel? {
//        didSet {
//            guard let cellModel = cellViewModel else { return }
//            profileImageView.loadImage(urlString: cellModel.prifileImage ?? "")
//            nameLabel.text = "Name: \(cellModel.name)"
//            reputationLabel.text = "Reputation: \(cellModel.reputation)"
//        }
//    }

    let followUnfollowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "follow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let followUnFollowLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Follow"
        return label
    }()


    let blockButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "block").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let blockLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Block"
        return label
    }()


    lazy private var actionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.followUnfollowButton, self.followUnFollowLabel,self.blockButton,self.blockLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
      //  stackView.alignment = .firstBaseline
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .lightGray
        stackView.spacing = 5
        return stackView
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    fileprivate func setup() {
        backgroundColor = .lightGray
        addSubview(actionStackView)
        NSLayoutConstraint.activate([
            followUnfollowButton.widthAnchor.constraint(equalToConstant: UIConstant.buttonDimention),
            followUnfollowButton.heightAnchor.constraint(equalTo: followUnfollowButton.widthAnchor),
            blockButton.widthAnchor.constraint(equalToConstant: UIConstant.buttonDimention),
            blockButton.heightAnchor.constraint(equalTo: blockButton.widthAnchor),

            actionStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: UIConstant.leadingContentPadding),
            actionStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -UIConstant.tralingContentPadding),
            actionStackView.topAnchor.constraint(equalTo: topAnchor),
            actionStackView.bottomAnchor.constraint(equalTo: bottomAnchor)

            ])
    }
}
