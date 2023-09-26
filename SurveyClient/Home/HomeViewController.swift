//
//  HomeViewController.swift
//  SurveyClient
//
//  Created by Bryan A Bolivar M on 25/09/23.
//

import UIKit
import Style
import Kingfisher

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel = HomeViewModel()
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let cellWidth = UIScreen.main.bounds.width
        let cellHeight = UIScreen.main.bounds.height
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.scrollDirection = .horizontal
        return layout
    }()
    let profileImageView = UIImageView(frame: .zero)
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: .zero)
        pageControl.contentHorizontalAlignment = .leading
        pageControl.contentMode = .left
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    let surveyTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.textColor = ColorStyle.white
        label.font = FontStyle.display28
        return label
    }()
    
    let surveyDescriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 2
        label.textColor = ColorStyle.white
        label.font = FontStyle.regular17
        return label
    }()
    
    let loadSurveyButton = UIButton(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.delegate = self
        viewModel.fetchSurveys()
        
        viewModel.didLoadSurveys = {
            self.collectionView.reloadData()
            self.pageControl.numberOfPages = self.viewModel.surveys.count
        }
        
        viewModel.didLoadUserProfile = {
            self.profileImageView.kf.setImage(with: URL(string: self.viewModel.user?.avatarURL ?? ""))
        }
        
        addHeaderSection()
        addFooterSection()
        viewModel.fetchUserProfile()
    }
    
    func addHeaderSection() {
        let vStack = UIStackView(frame: .zero)
        let dateLabel = UILabel(frame: .zero)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Language.Home.dayFormat
        dateLabel.text = dateFormatter.string(from: Date()).uppercased()
        dateLabel.font = FontStyle.xSmall13
        dateLabel.textColor = ColorStyle.white
        vStack.addArrangedSubview(Component.generateEmptyView(height: 16))
        vStack.addArrangedSubview(dateLabel)
        vStack.axis = .vertical
        view.addSubview(vStack)
        vStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(60)
        }
        
        let todayLabel = UILabel(frame: .zero)
        todayLabel.font = FontStyle.largeTitle34
        todayLabel.text = "Today".uppercased()
        todayLabel.textColor = .white
        
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(36)
        }
        profileImageView.layer.cornerRadius = 18
        profileImageView.backgroundColor = .gray
        profileImageView.clipsToBounds = true
        
        let hstack = UIStackView(frame: .zero)
        hstack.addArrangedSubview(todayLabel)
        hstack.addArrangedSubview(UIView())
        hstack.addArrangedSubview(profileImageView)
        vStack.addArrangedSubview(hstack)

    }
    
    func addFooterSection() {
        let vstack = UIStackView(frame: .zero)
        vstack.axis = .vertical
        view.addSubview(vstack)
        vstack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(40)
        }
        
        let pageControlHstack = UIStackView(frame: .zero)
        let containerView = UIView(frame: .zero)
        containerView.addSubview(pageControl)
        pageControlHstack.addArrangedSubview(containerView)
        pageControlHstack.addArrangedSubview(UIView())
        
        vstack.addArrangedSubview(pageControlHstack)
        vstack.addArrangedSubview(surveyTitleLabel)
        
        let hstack = UIStackView(frame: .zero)
        hstack.addArrangedSubview(surveyDescriptionLabel)
        hstack.addArrangedSubview(UIView())
        
        loadSurveyButton.snp.makeConstraints { make in
            make.width.height.equalTo(56)
        }
        loadSurveyButton.setImage(UIImage(named: "action"), for: .normal)
        hstack.addArrangedSubview(loadSurveyButton)
        pageControl.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(-30)
        }
        containerView.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        vstack.addArrangedSubview(hstack)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        cell.backgroundColor = .gray
        cell.model = viewModel.surveys[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.surveys.count
    }
}

extension HomeViewController: UIScrollViewDelegate, UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let xPoint = scrollView.contentOffset.x + scrollView.frame.width / 2
         let yPoint = scrollView.frame.height / 2
         let center = CGPoint(x: xPoint, y: yPoint)
        if let ip = collectionView.indexPathForItem(at: center) {
             self.pageControl.currentPage = ip.row
         }
        
        surveyTitleLabel.text = viewModel.surveys[self.pageControl.currentPage].title
        surveyDescriptionLabel.text = viewModel.surveys[self.pageControl.currentPage].description
    }
}

