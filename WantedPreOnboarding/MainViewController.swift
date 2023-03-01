//
//  ViewController.swift
//  WantedPreOnboarding
//
//  Created by Wallaby on 2023/02/28.
//

import UIKit

class MainViewController: UIViewController {
  
  // MARK: - Properties
  
  @IBOutlet weak var imageLoaderTableView: UITableView!
  @IBOutlet weak var loadAllImageButton: UIButton!
  
  
  // MARK: - LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    setupImageLoaderTableView()
  }
  
  private func setupImageLoaderTableView() {
    let nib = UINib(nibName: "ImageLoaderTableViewCell",
                    bundle: nil)
    imageLoaderTableView.register(nib, forCellReuseIdentifier: ImageLoaderTableViewCell.identifier)
    imageLoaderTableView.delegate = self
    imageLoaderTableView.dataSource = self
  }
  
  
  // MARK: - Methods
  
  @IBAction func didTapLoadAllButton(_ sender: Any) {
    for cell in imageLoaderTableView.visibleCells {
      guard let cell = cell as? ImageLoaderTableViewCell else {
        continue
      }
      
      cell.cancelImageLoadingTask()
      cell.setRandomImage()
    }
  }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageLoaderTableViewCell.identifier) as? ImageLoaderTableViewCell else {
      return UITableViewCell()
    }

    return cell
  }
}

