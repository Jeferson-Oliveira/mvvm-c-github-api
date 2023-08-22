import UIKit

extension UIImageView {
    
    func fromURL(from url: URL,
                 placeholder: UIImage? = nil) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let _ = error {
                self?.updateImageFromURL(placeholder)
            }
            guard let data = data, let downloadedImage = UIImage(data: data) else {
                self?.updateImageFromURL(placeholder)
                return
            }
            self?.updateImageFromURL(downloadedImage)
        }
        task.resume()
    }
    
    fileprivate func updateImageFromURL(_ image: UIImage?) {
        DispatchQueue.main.async {
            self.image = image
        }
    }
}
