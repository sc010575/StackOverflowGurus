//
//  HomeViewHeader.swift
//  StackOverflowGurus
//
//  Created by Suman Chatterjee on 09/10/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import UIKit

class HomeViewHeader: UIView {

    enum UIConstant {
        static let imageDiamention: CGFloat = 120
        static let buttonDimention: CGFloat = 30
        static let tralingContentPadding: CGFloat = 8
        static let leadingContentPadding: CGFloat = 8
        static let stackViewSpacing: CGFloat = 15
        static let nameRepuStackViewSpacing: CGFloat = 5
    }

    private var buttonTapHandler: (() -> ())?


    private let seperator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()



    var cellViewModel: CellViewModel? {
        didSet {
            guard let viewModel = cellViewModel else {
                return
            }
            profileImageView.loadImage(urlString: viewModel.prifileImage ?? "")
            nameLabel.text = "Name: \(viewModel.name)"
            reputationLabel.text = "Reputation: \(viewModel.reputation)"
        }
    }

    private let profileImageView: CachedImageView = {
        let imageView = CachedImageView(cornerRadius: 5, emptyImage: #imageLiteral(resourceName: "downloads"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let reputationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy private var nameRepuStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.nameLabel, self.reputationLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = UIConstant.nameRepuStackViewSpacing
        return stackView
    }()

    private let expandButton: UIButton = {

        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "downarrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.tag = section
        return button

    }()


    lazy private var cellStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.profileImageView, self.nameRepuStackView, expandButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = UIConstant.stackViewSpacing
        return stackView
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    fileprivate func setup() {
        backgroundColor = .white
        addSubview(cellStackView)
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: UIConstant.imageDiamention),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),

            expandButton.widthAnchor.constraint(equalToConstant: UIConstant.buttonDimention),
            expandButton.heightAnchor.constraint(equalTo: expandButton.widthAnchor),

            cellStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: UIConstant.leadingContentPadding),
            cellStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -UIConstant.tralingContentPadding),
            cellStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            cellStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),

            ])
    }

    func onButtonTapHandler(_ handler: (() -> ())?) {
        buttonTapHandler = handler
    }

    @objc func handleExpandClose() {
        buttonTapHandler?()
    }
}
