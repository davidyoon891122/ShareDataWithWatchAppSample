//
//  TodoViewController.swift
//  ShareDataWithWatch
//
//  Created by iMac on 2022/10/11.
//

import UIKit
import SnapKit
import WatchConnectivity

class TodoViewController: UIViewController {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0)
        label.textColor = .label
        label.text = "Text"
        
        return label
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("전송", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.setTitleColor(.label.withAlphaComponent(0.3), for: .highlighted)
        
        button.addTarget(self, action: #selector(didTapSendDataButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var topView: UIView = {
        let view = UIView()
        [
            label,
            sendButton
        ]
            .forEach {
                view.addSubview($0)
            }
        
        label.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalTo(150.0)
        }
        
        sendButton.snp.makeConstraints {
            $0.centerY.equalTo(label)
            $0.leading.equalTo(label.snp.trailing).offset(16.0)
            $0.trailing.equalToSuperview().offset(-16.0)
        }
        return view
    }()
    
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
    
    var session: WCSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureWatchKitSession()
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

extension TodoViewController: WCSessionDelegate {
    func session(
        _ session: WCSession,
        activationDidCompleteWith activationState: WCSessionActivationState,
        error: Error?
    ) {
        print("ActivationDidCompleteWith")
    }
    
    func session(
        _ session: WCSession,
        didReceiveUserInfo userInfo: [String : Any] = [:]
    ) {
        print("UserInfo from Watch App : \(userInfo)")
        
        
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("SessionDidBecomeInactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("SessionDidDeactivate")
    }
    
    
}

private extension TodoViewController {
    func setupViews() {
        [
            topView,
            todoCollectionView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        topView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(50.0)
        }
        
        todoCollectionView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func configureWatchKitSession() {
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
    
    @objc
    func didTapSendDataButton() {
        
        let data: [String: Any] = ["iPhone": "Hello Watch App" as Any]
        session?.transferUserInfo(data)
    }
}

