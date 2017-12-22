//
//  ViewController.swift
//  ImageSlideshow
//
//  Created by Petr Zvoníček on 30.07.15.
//  Copyright (c) 2015 Petr Zvonicek. All rights reserved.
//

import UIKit
import ImageSlideshow

class ViewController: UIViewController {

    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    @IBOutlet var slideshow: ImageSlideshow!
    @IBOutlet weak var progressBarContainerView: UIView!
    
    let localSource = [ImageSource(imageString: "img1")!, ImageSource(imageString: "img2")!, ImageSource(imageString: "img3")!, ImageSource(imageString: "img4")!]
    let afNetworkingSource = [AFURLSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, AFURLSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, AFURLSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]
    let alamofireSource = [AlamofireSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, AlamofireSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, AlamofireSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]
    let sdWebImageSource = [SDWebImageSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, SDWebImageSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, SDWebImageSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]
    let kingfisherSource = [KingfisherSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, KingfisherSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, KingfisherSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]

    override func viewDidLoad() {
        super.viewDidLoad()
        let width = UIScreen.main.bounds.width
        let widthConstraint = NSLayoutConstraint(item: progressBarContainerView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width - 30)
        progressBarContainerView.addConstraint(widthConstraint)
        
        let centerXConstraint = NSLayoutConstraint(item: progressBarContainerView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: progressBarContainerView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        view.addConstraints([centerXConstraint, centerYConstraint])
        
        slideshow.backgroundColor = UIColor.white
        slideshow.slideshowInterval = 3.0
        
        slideshow.pageControlPosition = PageControlPosition.hidden
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        slideshow.draggingEnabled = false
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        slideshow.activityIndicator = DefaultActivityIndicator()
        slideshow.currentPageChanged = { page in
            print("current page:", page)
        }

        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        slideshow.setImageInputs(alamofireSource)
        //createProgressBars()
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTap))
        slideshow.addGestureRecognizer(recognizer)
    }

    @objc func didTap() {
        slideshow.setScrollViewPage(slideshow.currentPage + 2, animated: true)
        slideshow.slideshowInterval = 3.0
    }
    
    var progressBars: [UIProgressView] = []
    private func createProgressBars() {
        let progressBarCount = alamofireSource.count
        let spaceBetweenBars = 5
//        let leading = 10
//        let trailing = 10
        let containerViewWidth = Int(progressBarContainerView.frame.width) - ((progressBarCount-1)*spaceBetweenBars) - 40
        
        let progressbarWidth = containerViewWidth/progressBarCount
        let progressbarHeight = 20
        
        var x = 20
        for _ in 1...progressBarCount {
            let progressView = UIProgressView(frame: CGRect(x: x, y: 0, width: progressbarWidth, height: progressbarHeight))
            progressBarContainerView.addSubview(progressView)
            progressView.trackTintColor = UIColor.green
            progressView.backgroundColor = UIColor.yellow
            let heightConstraint = NSLayoutConstraint(item: progressView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: CGFloat(progressbarHeight))
            progressView.addConstraint(heightConstraint)
            
            progressBars.append(progressView)
            x += progressbarWidth + spaceBetweenBars
            
            view.layoutIfNeeded()
        }
    }
}
