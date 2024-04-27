//
//  ComicTableViewCell.swift
//  MoyaCards
//
//  Created by Saw Pyae Yadanar on 26/4/2567 BE.
//

import UIKit
import Kingfisher

class ComicCell: UITableViewCell {
  public static let reuseIdentifier = "cell"

    @IBOutlet private weak var imgThumb: UIImageView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblDesc: UILabel!

  public func configureWith(_ comic: Comic) {
    lblTitle.text = comic.title
    lblDesc.text = comic.description ?? "No description available"
      debugPrint("\n")
      debugPrint(comic.thumbnail.url.absoluteString)
    imgThumb.kf.setImage(with: comic.thumbnail.url,
                         options: [.transition(.fade(0.3))])
  }
}
