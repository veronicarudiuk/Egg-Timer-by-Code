//
//  ViewController.swift
//  Egg Timer by Code
//
//  Created by Veronica Rudiuk on 24.10.22.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    //    let softImage = UIImageView(image: UIImage(named: "Soft egg"))
    let softButton = UIButton()
    let mediumButton = UIButton()
    let hardButton = UIButton()
    let softImage = UIImageView(image: UIImage(named: "Soft"))
    let mediumImage = UIImageView(image: UIImage(named: "Medium"))
    let hardImage = UIImageView(image: UIImage(named: "Hard"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.7949336767, green: 0.9477056861, blue: 0.9900913835, alpha: 1)
        
        let title = UILabel()
        title.text = "How do you like your eggs?"
        title.font = .systemFont(ofSize: 30)
        title.textColor = .darkGray
        title.textAlignment = .center
        
        let softView = UIView(button: softButton, image: softImage, title: "Soft")
        let mediumView = UIView(button: mediumButton, image: mediumImage, title: "Medium")
        let hardView = UIView(button: hardButton, image: hardImage, title: "Hard")

        
        
        let eggStackView = UIStackView(arrangedSubviews: [softView, mediumView, hardView])
        eggStackView.axis = .horizontal
        eggStackView.distribution = .fillEqually
        eggStackView.spacing = 20
        
        let progressBar = UIProgressView(progressViewStyle: .bar)
        progressBar.progressTintColor = .systemYellow
        progressBar.trackTintColor = .systemGray
        let progressView = UIView()
        progressView.addSubview(progressBar)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressBar.centerYAnchor.constraint(equalTo: progressView.centerYAnchor),
            progressBar.leadingAnchor.constraint(equalTo: progressView.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: progressView.trailingAnchor),
        ])
        
        let mainStackView = UIStackView(arrangedSubviews: [title, eggStackView, progressView])
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}
extension UIView {
    convenience init(button: UIButton, image: UIImageView, title: String) {
        self.init()
        self.addSubview(image)
        self.addSubview(button)
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .black)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}


struct SwiftUIController: UIViewControllerRepresentable {
    typealias UIViewControllerType = ViewController
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        let viewController = UIViewControllerType()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
    }
}

struct SwiftUIController_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIController().edgesIgnoringSafeArea(.all)
    }
}
