//
//  ButtonSheet.swift
//  custom half-modal
//
//  Created by 양혜지 on 2022/03/15.
//

import UIKit

class BottomSheetViewController: UIViewController {
    
    // MARK: - Properties
    // 바텀 시트 높이
    let bottomHeight: CGFloat = 359
    
    // bottomSheet가 view의 상단에서 떨어진 거리
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    
    // 기존 화면을 흐려지게 만들기 위한 뷰
    private let dimmedBackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        return view
    }()
    
    // 바텀 시트 뷰
    private let bottomSheetView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        view.layer.cornerRadius = 27
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        
        return view
    }()
    
    // dismiss Indicator View UI 구성 부분
    private let dismissIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray2
        view.layer.cornerRadius = 3
        
        return view
    }()
    
    let tableView: UITableView = {
        
        let tv = UITableView(frame: .zero, style: .plain)
        
        tv.separatorStyle = .singleLineEtched
    
        tv.layer.cornerRadius = 27
        tv.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return tv
    }()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        setupUI()
        setupGestureRecognizer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showBottomSheet()
    }

    // MARK: - @Functions
    // UI 세팅 작업
    private func setupUI() {
        view.addSubview(dimmedBackView)
        view.addSubview(bottomSheetView)
        view.addSubview(dismissIndicatorView)
        
        dimmedBackView.alpha = 0.0
        setupLayout()
    }
    
    // GestureRecognizer 세팅 작업
    private func setupGestureRecognizer() {
        // 흐린 부분 탭할 때, 바텀시트를 내리는 TapGesture
        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
        dimmedBackView.addGestureRecognizer(dimmedTap)
        dimmedBackView.isUserInteractionEnabled = true
        
        // 스와이프 했을 때, 바텀시트를 내리는 swipeGesture
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(panGesture))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    // 레이아웃 세팅
    private func setupLayout() {
        
 
        
        self.view.addSubview(dimmedBackView)
        self.dimmedBackView.snp.makeConstraints{ maker in
            maker.edges.equalToSuperview()
        }

        
        self.view.addSubview(tableView)
        self.tableView.snp.makeConstraints{ maker in
            maker.leading.equalTo(view)
            maker.trailing.equalTo(view)
            maker.bottom.equalTo(view)
            maker.height.equalTo(300)
        }
        
        self.view.addSubview(dismissIndicatorView)
        self.dismissIndicatorView.snp.makeConstraints{ maker in
            maker.centerX.equalTo(tableView.snp.centerX)
            maker.top.equalTo(tableView.snp.top).offset(12)
            maker.width.equalTo(102)
            maker.height.equalTo(7)
        }

    }
    
    // 바텀 시트 표출 애니메이션
    private func showBottomSheet() {
        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom
        
//        bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - bottomHeight
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedBackView.alpha = 0.5
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    // 바텀 시트 사라지는 애니메이션
    private func hideBottomSheetAndGoBack() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
//        bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedBackView.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    // UITapGestureRecognizer 연결 함수 부분
    @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheetAndGoBack()
    }
    
    // UISwipeGestureRecognizer 연결 함수 부분
    @objc func panGesture(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            switch recognizer.direction {
            case .down:
                hideBottomSheetAndGoBack()
            default:
                break
            }
        }
    }
    
    fileprivate func configureTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(reportCell.self, forCellReuseIdentifier: reportCell.cellId)
        self.tableView.register(reportCell2.self, forCellReuseIdentifier: reportCell2.cellId)
    }
}

extension BottomSheetViewController  : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 2
        }
        return 3
    }
    
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: reportCell2.cellId, for: indexPath) as! reportCell2
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: reportCell.cellId, for: indexPath) as! reportCell
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return reportCell.getCellHeight()
    }
}

class reportCell : UITableViewCell {
    
    static let cellId = "reportCellId"
    
    let titleLable : UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "hello"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: UIFont.buttonFontSize)

    
        
        return label
    }()
    
    let button : UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("더보기", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureCell()
    }
    
    required init?(coder: NSCoder){
        fatalError("init")
    }
    
    fileprivate func configureCell() {
        self.setupUILayouts()
    }
    
    fileprivate func setupUILayouts(){
        self.addSubview(self.button)
        self.button.snp.makeConstraints { maker in
            maker.centerX.equalTo(self)
            maker.centerY.equalTo(self)
            maker.width.height.equalTo(100)
            
        }
    }
    
    static func getCellHeight() -> CGFloat {
        return 60
    }
}


class reportCell2 : UITableViewCell {
    
    static let cellId = "reportCellId2"
    
    let titleLable : UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "hello"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: UIFont.buttonFontSize)

    
        
        return label
    }()
    
    let button : UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("더안보기", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureCell()
    }
    
    required init?(coder: NSCoder){
        fatalError("init")
    }
    
    fileprivate func configureCell() {
        self.setupUILayouts()
    }
    
    fileprivate func setupUILayouts(){
        self.addSubview(self.button)
        self.button.snp.makeConstraints { maker in
            maker.centerX.equalTo(self)
            maker.centerY.equalTo(self)
            maker.width.height.equalTo(100)
            
        }
    }
    
    static func getCellHeight() -> CGFloat {
        return 60
    }
}
