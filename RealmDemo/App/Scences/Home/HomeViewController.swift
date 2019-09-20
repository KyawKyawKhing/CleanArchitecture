//
//  HomeViewController.swift
//  RealmDemo
//
//  Created by Kyaw Kyaw Khing on 9/19/19.
//  Copyright © 2019 Kyaw Kyaw Khing. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    @IBOutlet weak var tvPost: UITableView!
    private let disposeBag = DisposeBag()
    
    var dataList:[PostItemViewModel] = []
    
    let viewModel = PostsViewModel(useCase: Injection.providePostNetworkUserCaseProvider().makePostsDomainUseCase())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tvPost.refreshControl = UIRefreshControl()
        self.tvPost.delegate = self
        self.tvPost.dataSource = self
        self.tvPost.tableFooterView = UIView()
        self.tvPost.rowHeight = UITableView.automaticDimension
        self.tvPost.estimatedRowHeight = 100
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        let pull = tvPost.refreshControl!.rx
            .controlEvent(.valueChanged)
            .asDriver()
        
        let input = PostsViewModel.Input(trigger: Driver.merge(viewWillAppear, pull),
//                                         createPostTrigger: createPostButton.rx.tap.asDriver(),
                                         selection: tvPost.rx.itemSelected.asDriver())
        let output = viewModel.transform(input: input)
        //Bind Posts to UITableView
//        output.posts.drive(tvPost.rx.items(cellIdentifier: PostItemCell.reuseID, cellType: PostItemCell.self)) { tv, viewModel, cell in
//            cell.bind(viewModel)
//            }.disposed(by: disposeBag)
        output.posts.drive(onNext:{ data in
            self.dataList = data
            self.tvPost.reloadData()
        }).disposed(by: disposeBag)
        //Connect Create Post to UI
        
        output.fetching
            .drive(tvPost.refreshControl!.rx.isRefreshing)
            .disposed(by: disposeBag)
//        output.createPost
//            .drive()
//            .disposed(by: disposeBag)
//        output.selectedPost
//            .drive()
//            .disposed(by: disposeBag)
    }

}
extension HomeViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HomeViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostItemCell", for: indexPath) as! PostItemCell
        cell.setup(with: dataList[indexPath.row])
        return cell
    }
    
    
}
