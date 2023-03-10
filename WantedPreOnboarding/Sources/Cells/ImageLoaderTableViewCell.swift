//
//  ImageLoaderTableViewCell.swift
//  WantedPreOnboarding
//
//  Created by Wallaby on 2023/03/01.
//

import UIKit

class ImageLoaderTableViewCell: UITableViewCell {
  
  // MARK: - Constants
  
  static let identifier = "ImageLoaderTableViewCell"
  
  struct Metric {
    static let randomImageViewCornerRadius: CGFloat = 4
    static let loadButtonCornerRadius: CGFloat = 8
    static let selectedViewCornerRadius: CGFloat = 10
  }
  
  // MARK: - Properties
  
  public var imageAPIService: ImageAPIService?
  
  @IBOutlet weak var randomImageView: UIImageView!
  @IBOutlet weak var loadButton: UIButton!
  @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
  @IBOutlet weak var imagePlaceholderImageView: UIImageView!
  
  
  // MARK: - LifeCycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    cancelImageLoadingTask()
  }
  
  
  // MARK: - Setups
  
  private func setup() {
    setupView()
  }
  
  private func setupView() {
    setupRandomImageView()
    setupLoadButton()
    setupSelectedView()
    setupLoadingIndicatorView()
  }
  
  private func setupRandomImageView() {
    randomImageView.layer.cornerRadius = Metric.randomImageViewCornerRadius
  }
  
  private func setupLoadButton() {
    loadButton.layer.cornerRadius = Metric.loadButtonCornerRadius
  }
  
  private func setupSelectedView() {
    let selectedView = UIView()
    selectedView.backgroundColor = .systemGray5
    selectedView.layer.cornerRadius = Metric.selectedViewCornerRadius
    self.selectedBackgroundView = selectedView
  }
  
  private func setupLoadingIndicatorView() {
    loadingIndicatorView.isHidden = true
  }
  
  
  // MARK: - Methods
  
  @IBAction func didTapLoadButton(_ sender: Any) {
    setRandomImage()
  }
  
  public func setRandomImage() {
    if imageAPIService == nil {
      imageAPIService = ImageAPIService()
    }
    
    startLoading()
    
    Task {
      let image = await imageAPIService?.fetchRandomImage()
      DispatchQueue.main.async {
        self.stopLoading()
        self.randomImageView.image = image
        
        if image == nil {
          self.imagePlaceholderImageView.isHidden = false
        } else {
          self.imagePlaceholderImageView.isHidden = true
        }
      }
    }
  }
  
  public func cancelImageLoadingTask() {
    imageAPIService?.stopTask()
    
    if randomImageView.image == nil {
      imagePlaceholderImageView.isHidden = false
      stopLoading()
    }
  }
  
  private func startLoading() {
    loadingIndicatorView.startAnimating()
    loadingIndicatorView.isHidden = false
    randomImageView.image = nil
    imagePlaceholderImageView.isHidden = true
  }
  
  private func stopLoading() {
    loadingIndicatorView.stopAnimating()
    loadingIndicatorView.isHidden = true
  }
}
