//
//  HSWellcomePage.swift
//  HSWellcomePage
//
//  Created by Hakan Silek
//
#if canImport(UIKit)
import UIKit

enum MyError: Error {
    case viewsEmpty(String)
}

final public class HSWellcomePage: UIViewController{
    
    private final let forCellWithReuseIdentifier = "page"
    private var views = [UIView]()
    private let leadingAnchorTrailingAnchorConstant: CGFloat = 25
    private let bottomAnchorConstant:CGFloat = -15
    
    private var doneFunction: (()->Void?)? = nil
    
    private var viewUILayoutGuide = UILayoutGuide()
    
    
    private let wellcomePageCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let prevButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("PREV", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    private let nextButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("NEXT", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let doneButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("DONE", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.isHidden = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let pageControl : UIPageControl = {
        let pg = UIPageControl()
        pg.isUserInteractionEnabled = false
        pg.currentPageIndicatorTintColor = .black
        pg.currentPage = 0
        pg.pageIndicatorTintColor = .gray
        pg.translatesAutoresizingMaskIntoConstraints = false
        return pg
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        viewUILayoutGuide = self.view.safeAreaLayoutGuide
        do{
            try createViews()
            addPrevAndNextButton()
            addPageControl()
        }catch{
            print(error)
        }
    }
    
    private func createViews() throws{
        if(views.isEmpty){
            throw MyError.viewsEmpty("You have to add at least 1 view.")
        }else{
        wellcomePageCollectionView.dataSource=self
        wellcomePageCollectionView.delegate = self
        wellcomePageCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: forCellWithReuseIdentifier)
        addCollectionView()
        }
    }
    
    private func addPrevAndNextButton(){
        view.addSubview(prevButton)
        prevButton.leadingAnchor.constraint(equalTo: viewUILayoutGuide.leadingAnchor, constant: leadingAnchorTrailingAnchorConstant).isActive=true
        prevButton.bottomAnchor.constraint(equalTo: viewUILayoutGuide.bottomAnchor, constant: bottomAnchorConstant).isActive=true
        
        prevButton.addTarget(self, action: #selector(prevPage), for: .touchUpInside)
        
        view.addSubview(nextButton)
        nextButton.trailingAnchor.constraint(equalTo: viewUILayoutGuide.trailingAnchor, constant: -leadingAnchorTrailingAnchorConstant).isActive=true
        nextButton.bottomAnchor.constraint(equalTo: viewUILayoutGuide.bottomAnchor, constant: bottomAnchorConstant).isActive=true
        nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        
        view.addSubview(doneButton)
        doneButton.trailingAnchor.constraint(equalTo: viewUILayoutGuide.trailingAnchor, constant: -leadingAnchorTrailingAnchorConstant).isActive=true
        doneButton.bottomAnchor.constraint(equalTo: viewUILayoutGuide.bottomAnchor, constant: bottomAnchorConstant).isActive=true
        doneButton.addTarget(self, action: #selector(doneWellcomePage), for: .touchUpInside)
    }
    
    private func addPageControl(){
        pageControl.numberOfPages = views.count
        view.addSubview(pageControl)
        pageControl.centerXAnchor.constraint(equalTo: viewUILayoutGuide.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: viewUILayoutGuide.bottomAnchor, constant: bottomAnchorConstant).isActive=true
        pageControl.widthAnchor.constraint(lessThanOrEqualTo: viewUILayoutGuide.widthAnchor, multiplier: 1).isActive = true
        
    }
    
    private func addCollectionView(){
        view.addSubview(wellcomePageCollectionView)
        wellcomePageCollectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        wellcomePageCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        wellcomePageCollectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        wellcomePageCollectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1).isActive = true
    }
    
    @objc private func prevPage(){
        if(pageControl.currentPage == 0){return}
        let index = pageControl.currentPage - 1
        scrollToView(index)
    }
    
    @objc private func nextPage(){
        if(pageControl.currentPage == views.count - 1){return}
        let index = pageControl.currentPage + 1
        scrollToView(index)
    }
    
    @objc private func doneWellcomePage(){
        if let done = doneFunction{
            done()
        }else{
            print("You have to call doneButtonTapped !")
        }
    }
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = pageControl.currentPage
        if pageIndex == views.count - 1 {
            showDoneButton()
        }else{
            hideDoneButton()
        }
    }
    
    private func scrollToView(_ index: Int){
        let indexPath = IndexPath(item: index, section: 0)
        pageControl.currentPage = index
        wellcomePageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageIndex = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageIndex
    }
    
    private func showDoneButton(){
        doneButton.isHidden = false
        nextButton.isHidden = true
    }
    
    private func hideDoneButton(){
        doneButton.isHidden = true
        nextButton.isHidden = false
    }
}

extension HSWellcomePage:UICollectionViewDataSource, UICollectionViewDelegate{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return views.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: forCellWithReuseIdentifier, for: indexPath)
        let view = views[indexPath.item]
        cell.contentView.addSubview(view)
        view.frame = cell.contentView.frame
        return cell
    }
}

extension HSWellcomePage: UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension HSWellcomePage{
    public func addViews(_ views: [UIView]){
        self.views = views
    }
    
    public func setPrevButton(title t: String){
        prevButton.setTitle(t, for: .normal)
    }
    
    public func setPrevButton(titleColor c: UIColor){
        prevButton.setTitleColor(c, for: .normal)
    }
    
    public func setPrevButton(icon i: UIImage, withTintColor c: UIColor = .black){
        prevButton.setImage(i, for: .normal)
        prevButton.tintColor = c
    }
    
    public func setNextButton(title t: String){
        nextButton.setTitle(t, for: .normal)
    }
    
    public func setNextButton(titleColor c: UIColor){
        nextButton.setTitleColor(c, for: .normal)
    }
    
    public func setNextButton(icon i: UIImage, withTintColor c: UIColor = .black){
        nextButton.setImage(i, for: .normal)
        nextButton.tintColor = c
    }
    
    public func setDoneButton(title t: String){
        doneButton.setTitle(t, for: .normal)
    }
    
    public func setDoneButton(titleColor c: UIColor){
        doneButton.setTitleColor(c, for: .normal)
    }
    
    public func setDoneButton(icon i: UIImage, withTintColor c: UIColor = .black){
        doneButton.setImage(i, for: .normal)
        doneButton.tintColor = c
    }

    public func setPageControl(indicatorPrefferedImage i: UIImage){
       pageControl.preferredIndicatorImage = i
    }
    
    public func setPageControl(currentPageIndicatorTintColor c : UIColor){
        pageControl.currentPageIndicatorTintColor = c
    }
    
    public func setPageControl(pageIndicatorTintColor c : UIColor){
        pageControl.pageIndicatorTintColor = c
    }
    
    public func doneButtonTapped(clouser: @escaping ()->Void){
        doneFunction = clouser
    }
}
#endif
