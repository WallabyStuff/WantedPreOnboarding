//
//  ImageLoaderTableViewCell.swift
//  WantedPreOnboarding
//
//  Created by 이승기 on 2023/03/01.
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
  
  @IBOutlet weak var randomImageView: UIImageView!
  @IBOutlet weak var loadButton: UIButton!
  @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
  @IBOutlet weak var imagePlaceholderImageView: UIImageView!
  
  
  // MARK: - LifeCycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
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
}
