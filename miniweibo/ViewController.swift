//
//  ViewController.swift
//  miniweibo
//
//  Created by xyli on 2020/3/23.
//  Copyright © 2020 xyli. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

  @IBOutlet weak var nameLabel: UILabel!

	let viewModel = MomentViewModel.init(momentService: MomentService())

  override func viewDidLoad() {
    super.viewDidLoad()

    attemptFetchMoment()
  }

  private func attemptFetchMoment() {
    viewModel.fetchMoments()

    viewModel.updateLoadingStatus = {
      let _ = self.viewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
    }

    viewModel.showAlertClosure = {
      if let error = self.viewModel.error {
          print(error.localizedDescription)
      }
    }

    viewModel.didFinishFetch = {
      self.nameLabel.text = self.viewModel.text
    }
  }

  private func activityIndicatorStart() {
    print("start")
  }

  private func activityIndicatorStop() {
    print("stop")
  }
}


