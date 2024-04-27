//
//  ComicsViewController.swift
//  MoyaCards
//
//  Created by Saw Pyae Yadanar on 26/4/2567 BE.
//

import UIKit
import RxSwift
import RxCocoa

class ComicsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak private var tblComics: UITableView!
    @IBOutlet weak private var viewMessage: UIView!
    @IBOutlet weak private var lblMessage: UILabel!
    @IBOutlet weak private var imgMeessage: UIImageView!
        
    private var viewModel = ComicsViewModel()
    private var bag = DisposeBag()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchComics()
        bindLoading()
        bindTableView()
    }
    
    private func bindLoading() {
        viewModel.state.asObservable().subscribe { value in
            switch value {
                
            case .next(let state):
                switch state {
                    
                case .idle:
                    self.viewMessage.isHidden = true
                    self.tblComics.isHidden = false
                case .loading:
                    self.tblComics.isHidden = true
                    self.viewMessage.isHidden = false
                    self.lblMessage.text = "Getting comics ..."
                    self.imgMeessage.image = #imageLiteral(resourceName: "Loading")
                case .error(_):
                    self.tblComics.isHidden = true
                    self.viewMessage.isHidden = false
                    self.lblMessage.text = """
                                        Something went wrong!
                                        Try again later.
                                      """
                    self.imgMeessage.image = #imageLiteral(resourceName: "Error")
                }
                
            case .error(_): break
            case .completed: break
            }
        }.disposed(by: bag)
    }
    
    
    func bindTableView() {
        
        viewModel.comics.bind(to: tblComics.rx.items(cellIdentifier: ComicCell.reuseIdentifier, cellType: ComicCell.self)) { row, item, cell in
            cell.configureWith(item)
        }.disposed(by: bag)
        
        tblComics
           .rx
           .itemSelected
           .subscribe(onNext: { [weak self] indexPath in
               guard let self = self else { return  }
               tblComics.deselectRow(at: indexPath, animated: true)
       })
           .disposed(by: bag)
        
        tblComics
            .rx
            .modelSelected(Comic.self)
            .subscribe(onNext: { comic in
                let comicVC = CardViewViewController.instantiate(comic: comic)
                self.navigationController?.pushViewController(comicVC, animated: true)
                
            })
        .disposed(by: bag)
    }
  }

