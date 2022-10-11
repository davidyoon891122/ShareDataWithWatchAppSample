//
//  TodoViewController.swift
//  ShareDataWithWatch
//
//  Created by iMac on 2022/10/11.
//

import UIKit
import SnapKit

class TodoViewController: UIViewController {
    private lazy var todoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width, height: 50.0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TodoCollectionViewCell.self, forCellWithReuseIdentifier: TodoCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    private var todos: [TodoModel] = [
        TodoModel(title: "tast1", content: "content1"),
        TodoModel(title: "tast2", content: "content2"),
        TodoModel(title: "tast3", content: "content3"),
        TodoModel(title: "tast4", content: "content4"),
        TodoModel(title: "tast5", content: "content5"),
        TodoModel(title: "tast6", content: "content6"),
        TodoModel(title: "tast7", content: "content7"),
        TodoModel(title: "tast8", content: "content8"),
        TodoModel(title: "tast9", content: "content9"),
        TodoModel(title: "tast10", content: "content10"),
        TodoModel(title: "tast11", content: "content11"),
        TodoModel(title: "tast12", content: "content12"),
        TodoModel(title: "tast13", content: "content13"),
        TodoModel(title: "tast14", content: "content14"),
        TodoModel(title: "tast15", content: "content15"),
        TodoModel(title: "tast16", content: "content16"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

extension TodoViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return todos.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TodoCollectionViewCell.identifier,
            for: indexPath
        ) as? TodoCollectionViewCell else { return UICollectionViewCell() }
        
        let todo = todos[indexPath.row]
        cell.setupCell(title: todo.title, content: todo.content)
        
        return cell
    }
    
    
}

extension TodoViewController: UICollectionViewDelegateFlowLayout {
    
}

private extension TodoViewController {
    func setupViews() {
        [
            todoCollectionView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        todoCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

