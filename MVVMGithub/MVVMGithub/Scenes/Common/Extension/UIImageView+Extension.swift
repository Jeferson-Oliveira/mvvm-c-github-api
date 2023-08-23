import UIKit

protocol ImageFromUrlProviderProtocol {
    func getImage(from url: URL, completion: @escaping (UIImage?) -> Void)
}

extension UIImageView {
    static var imageFronUrlProvider: ImageFromUrlProviderProtocol = SessionManagerImageProvider()
    
    func fromURL(from url: URL,
                 placeholder: UIImage? = nil) {
        UIImageView.imageFronUrlProvider.getImage(from: url, completion: { [weak self] image in
            if let image = image {
                self?.updateImageFromURL(image)
            } else {
                self?.updateImageFromURL(placeholder)
            }
        })
    }
    
    fileprivate func updateImageFromURL(_ image: UIImage?) {
        DispatchQueue.main.async {
            self.image = image
        }
    }
}


struct SessionManagerImageProvider: ImageFromUrlProviderProtocol {
    func getImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let _ = error {
                completion(nil)
            }
            guard let data = data, let downloadedImage = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(downloadedImage)
        }
        task.resume()
    }
}
