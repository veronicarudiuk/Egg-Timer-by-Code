//
//  ViewController.swift
//  Egg Timer by Code
//
//  Created by Veronica Rudiuk on 24.10.22.
//

import UIKit
import SwiftUI
import AVFoundation

class ViewController: UIViewController {
    
    let softButton = UIButton()
    let mediumButton = UIButton()
    let hardButton = UIButton()
    let softImage = UIImageView(image: UIImage(named: "Soft"))
    let mediumImage = UIImageView(image: UIImage(named: "Medium"))
    let hardImage = UIImageView(image: UIImage(named: "Hard"))
    let titlel = UILabel()
    let progressBar = UIProgressView(progressViewStyle: .bar)
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var timer = Timer()
    var player: AVPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.7949336767, green: 0.9477056861, blue: 0.9900913835, alpha: 1)
        
        //        настройка лейбла
        titlel.text = "How do you like your eggs?"
        titlel.font = .systemFont(ofSize: 30)
        titlel.textColor = .darkGray
        titlel.textAlignment = .center
        
        //        настройка кнопок
        let softView = UIView(button: softButton, image: softImage, title: "Soft")
        let mediumView = UIView(button: mediumButton, image: mediumImage, title: "Medium")
        let hardView = UIView(button: hardButton, image: hardImage, title: "Hard")
        let eggStackView = UIStackView(arrangedSubviews: [softView, mediumView, hardView])
        eggStackView.axis = .horizontal
        eggStackView.distribution = .fillEqually
        eggStackView.spacing = 20
        
        softButton.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        mediumButton.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        hardButton.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        
        //        настройка прогресс вью
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
        
        //        настройка стак вью
        let mainStackView = UIStackView(arrangedSubviews: [titlel, eggStackView, progressView])
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    @objc func onClick(_ sender: UIButton!) {
        let hardness = sender.currentTitle!
        let totalTime = eggTimes[hardness]!
        var passedTime = 0
        timer.invalidate()
        self.titlel.text = hardness
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if passedTime < totalTime {
                passedTime += 1
                self.progressBar.progress = Float(passedTime) / Float(totalTime)
            } else {
                Timer.invalidate()
                self.titlel.text = "Done!"
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    self.titlel.text = "How do you like your eggs?"
                    self.progressBar.progress = 0.0
                }
                let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                self.player = AVPlayer.init(url: url!)
                self.player.play()
            }
        }
    }
}
// возможность во вью помещать кнопку с картинкой с общими настройками
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

//превью свифт юай
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
