//
//  Extensions.swift
//  Test-InnovativeSolutions
//
//  Created by Faraz on 08/08/2024.
//

import UIKit

extension UIView {
    static var className: String {
        return String(describing: self)
    }
    
    @objc func roundCorners(_ corners: UIRectCorner, radius: CGFloat = 5.0) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        layer.masksToBounds = true
    }
}

extension UIViewController {
    static var className: String {
        return String(describing: self)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIImageView {
    
    private static var activityIndicatorKey = 0
    
    private var activityIndicator: UIActivityIndicatorView? {
        get {
            return objc_getAssociatedObject(self, &UIImageView.activityIndicatorKey) as? UIActivityIndicatorView
        }
        set {
            objc_setAssociatedObject(self, &UIImageView.activityIndicatorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private func showActivityIndicator() {
        if activityIndicator == nil {
            let indicator = UIActivityIndicatorView(style: .medium)
            indicator.color = .gray
            indicator.hidesWhenStopped = true
            indicator.translatesAutoresizingMaskIntoConstraints = false
            addSubview(indicator)
            
            NSLayoutConstraint.activate([
                indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
                indicator.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
            
            activityIndicator = indicator
        }
        activityIndicator?.startAnimating()
    }
    
    private func hideActivityIndicator() {
        activityIndicator?.stopAnimating()
    }

    func loadImage(from url: URL, placeholder: UIImage? = nil) {
        // Set placeholder image if any
        self.image = placeholder
        
        // Show activity indicator
        showActivityIndicator()
        
        let cacheKey = url.absoluteString
        
        // Check cache for image
        if let cachedImage = ImageCache.shared.image(forKey: cacheKey) {
            self.image = cachedImage
            hideActivityIndicator()
            return
        }
        
        // If image is not in cache, download it
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil, let downloadedImage = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self?.hideActivityIndicator()
                }
                return
            }
            
            // Cache the downloaded image
            ImageCache.shared.setImage(downloadedImage, forKey: cacheKey)
            
            // Update UIImageView on the main thread
            DispatchQueue.main.async {
                self.hideActivityIndicator()
                self.image = downloadedImage
            }
        }.resume()
    }
}

extension UINavigationController {
    func fadeTo(_ viewController: UIViewController) {
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        view.layer.add(transition, forKey: nil)
        pushViewController(viewController, animated: false)
    }
}
