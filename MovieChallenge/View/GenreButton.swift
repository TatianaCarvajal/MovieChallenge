//
//  GenreButton.swift
//  MovieChallenge
//
//  Created by Tatiana Carvajal on 31/03/23.
//

import UIKit

class GenreButton: UIButton {
    
    private let title: String
    private let action: (Int) -> Void
    
    init(title: String, tag: Int, action: @escaping (Int) -> Void) {
        self.title = title
        self.action = action
        super.init(frame: .zero)
        self.tag = tag
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
        setTitleColor(.black, for: .normal)
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        widthAnchor.constraint(equalToConstant: 120).isActive = true
        addTarget(self, action: #selector(pressed(_:)), for: .touchUpInside)
    }
    
    @objc private func pressed(_ sender: UIButton) {
        action(sender.tag)
    }
}
