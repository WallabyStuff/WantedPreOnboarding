//
//  ImageAPIService.swift
//  WantedPreOnboarding
//
//  Created by Wallaby on 2023/03/01.
//

import UIKit

class ImageAPIService {
  
  // MARK: - Constants
  
  static let imagePath = "https://picsum.photos/300/200"
  
  
  // MARK: - Properties
  
  private var task: Task<UIImage?, Error>?
  
  
  // MARK: - Methods
  
  public func fetchRandomImage() async -> UIImage? {
    task?.cancel()
    
    guard let imageURL = URL(string: Self.imagePath) else {
      return nil
    }
    
    let uuid = UUID()
    
    let task = Task { () -> UIImage? in
      let (data, _) = try await URLSession.shared.data(from: imageURL)
      if let image = UIImage(data: data) {
        return image
      } else {
        return nil
      }
    }
    self.task = task
    
    do {
      let image = try await task.value
      return image
    }
    catch {
      return nil
    }
  }
  
  public func stopTask() {
    task?.cancel()
  }
}
