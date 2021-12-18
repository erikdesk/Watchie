// https://www.youtube.com/watch?v=u6TpJrZNuPU
// https://stackoverflow.com/questions/25837228/how-to-set-textcolor-of-uilabel-in-swift
// https://stackoverflow.com/questions/24034300/swift-uilabel-text-alignment
// https://stackoverflow.com/questions/27762236/line-breaks-and-number-of-lines-in-swift-label-programmatically

import UIKit

class NotificationPopupView: UIView {
    
    weak var parentView: UIView!
    var message: String!
    var alertTimer: Timer?
    
    let notificationLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.boldSystemFont(ofSize: 18) // weight: .bold
        l.textColor = .white
        l.textAlignment = .center
        l.lineBreakMode = .byWordWrapping
        l.numberOfLines = 3
        return l
    }()
    
    func animateIn() {
        self.transform = CGAffineTransform(translationX: 0, y: 20 + 70)
        self.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.transform = .identity
            self.alpha = 0.9
            // self.containerView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }

    init(frame: CGRect, parentView: UIView, message: String) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 0.9)
        
        // MARK: this gets the entire phone view.
        // self.frame = UIScreen.main.bounds
        
        self.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(self)
        self.leadingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        self.trailingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        self.bottomAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        self.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.layer.cornerRadius = 20
        
        notificationLabel.text = message
        self.addSubview(notificationLabel)
        notificationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        notificationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        notificationLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        notificationLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        animateIn()
        self.alertTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(dismiss), userInfo: nil, repeats: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismiss() {
        self.removeFromSuperview()
    }
}
