//
//  ZoomingTransitioningDelegate.swift
//  DesignCodeYG
//
//  Created by Soufiane Salouf on 3/18/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import UIKit

@objc
protocol ZoomingViewController {
    func ZoomingBackgroundImageView(for transition: ZoomTransitioningDelegate) -> UIImageView?
    func ZoomingTitle(for transition: ZoomTransitioningDelegate) -> UILabel?
    func ZoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView?
    func ZoomingSubTitle(for transition: ZoomTransitioningDelegate) -> UILabel?
}

enum TransitionState {
    case initial
    case final
}

class ZoomTransitioningDelegate: NSObject {
    var transitionDuration = 0.5
    var operation : UINavigationControllerOperation = .none
    private let zoomScale = CGFloat(15)
    private let backgroundScale = CGFloat(0.7)
    
    typealias ZoomingViews = (backgroundImageView: UIImageView,title: UILabel,imageView: UIImageView,subTitle: UILabel)
    
    func configureViews(for state: TransitionState, containerView: UIView, backgroundViewController: UIViewController, viewsInBackground: ZoomingViews, viewsInForeground: ZoomingViews, snapshotViews: ZoomingViews){
        switch state {
        case .initial:
            backgroundViewController.view.transform = CGAffineTransform.identity
            backgroundViewController.view.alpha = 1
            
            snapshotViews.backgroundImageView.frame = containerView.convert(viewsInBackground.backgroundImageView.frame, from: viewsInBackground.backgroundImageView.superview)
            snapshotViews.title.frame = containerView.convert(viewsInBackground.title.frame, from: viewsInBackground.title.superview)
            snapshotViews.imageView.frame = containerView.convert(viewsInBackground.imageView.frame, from: viewsInBackground.imageView.superview)
            snapshotViews.subTitle.frame = containerView.convert(viewsInBackground.subTitle.frame, from: viewsInBackground.subTitle.superview)
            
        case .final:
            backgroundViewController.view.transform = CGAffineTransform(scaleX: backgroundScale, y: backgroundScale)
            backgroundViewController.view.alpha = 0
            
            snapshotViews.backgroundImageView.frame = containerView.convert(viewsInForeground.backgroundImageView.frame, from: viewsInForeground.backgroundImageView.superview)
            snapshotViews.title.frame = containerView.convert(viewsInForeground.title.frame, from: viewsInForeground.title.superview)
            snapshotViews.imageView.frame = containerView.convert(viewsInForeground.imageView.frame, from: viewsInForeground.imageView.superview)
            snapshotViews.subTitle.frame = containerView.convert(viewsInForeground.subTitle.frame, from: viewsInForeground.subTitle.superview)
            
        }
    }
}

extension ZoomTransitioningDelegate: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        let containerView = transitionContext.containerView
        
        var backgroundViewController = fromViewController
        var foregroundViewController = toViewController
        
        if operation == .pop {
            backgroundViewController = toViewController
            foregroundViewController = fromViewController
        }
        
        let maybeBackgroundBackgroundImageView = (backgroundViewController as? ZoomingViewController)?.ZoomingBackgroundImageView(for: self)
        let maybeForegroundBackgroundImageView = (foregroundViewController as? ZoomingViewController)?.ZoomingBackgroundImageView(for: self)
        
        let maybeBackgroundTitle = (backgroundViewController as? ZoomingViewController)?.ZoomingTitle(for: self)
        let maybeForegroundTitle = (foregroundViewController as? ZoomingViewController)?.ZoomingTitle(for: self)

        let maybeBackgroundImageView = (backgroundViewController as? ZoomingViewController)?.ZoomingImageView(for: self)
        let maybeForegroundImageView = (foregroundViewController as? ZoomingViewController)?.ZoomingImageView(for: self)

        let maybeBackgroundSubTitle = (backgroundViewController as? ZoomingViewController)?.ZoomingSubTitle(for: self)
        let maybeForegroundSubTitle = (foregroundViewController as? ZoomingViewController)?.ZoomingSubTitle(for: self)
        
        assert(maybeBackgroundBackgroundImageView != nil , "Connot find ImageView in BackgroundVC")
        assert(maybeForegroundBackgroundImageView != nil , "Connot find ImageView in foregroundVC")
        
        assert(maybeBackgroundTitle != nil , "Connot find ImageView in BackgroundVC")
        assert(maybeForegroundTitle != nil , "Connot find ImageView in foregroundVC")
        
        assert(maybeBackgroundImageView != nil , "Connot find ImageView in BackgroundVC")
        assert(maybeForegroundImageView != nil , "Connot find ImageView in foregroundVC")
        
        assert(maybeBackgroundSubTitle != nil , "Connot find ImageView in BackgroundVC")
        assert(maybeForegroundSubTitle != nil , "Connot find ImageView in foregroundVC")
        
        let backgroundBackgroundImageView = maybeBackgroundBackgroundImageView!
        let foregroundBackgroundImageView = maybeForegroundBackgroundImageView!
        
        let backgroundTitle = maybeBackgroundTitle!
        let foregroundTitle = maybeForegroundTitle!
        
        let backgroundImageView = maybeBackgroundImageView!
        let foregroundImageView = maybeForegroundImageView!
        
        let backgroundSubTitle = maybeBackgroundSubTitle!
        let foregroundSubTitle = maybeForegroundSubTitle!
        
        
        let imageViewSnapshot = UIImageView(image: backgroundImageView.image)
        imageViewSnapshot.contentMode = .scaleAspectFill
        imageViewSnapshot.layer.masksToBounds = true
        let titleSnapshot = backgroundTitle
        let subTitleSnapshot = backgroundSubTitle
        
        let backgroundImageViewSnapshot = UIImageView(image: backgroundBackgroundImageView.image)
        backgroundImageViewSnapshot.contentMode = .scaleAspectFill
        backgroundImageViewSnapshot.layer.masksToBounds = true
        
        backgroundBackgroundImageView.isHidden = true
        foregroundBackgroundImageView.isHidden = true
        backgroundTitle.isHidden = true
        foregroundTitle.isHidden = true
        backgroundImageView.isHidden = true
        foregroundImageView.isHidden = true
        backgroundSubTitle.isHidden = true
        foregroundSubTitle.isHidden = true
        
        let foregroundViewBackgroundColor = foregroundViewController.view.backgroundColor
        foregroundViewController.view.backgroundColor = UIColor.clear
        containerView.backgroundColor = UIColor.white
        
        containerView.addSubview(backgroundViewController.view)
        containerView.addSubview(foregroundViewController.view)
        containerView.addSubview(backgroundImageViewSnapshot)
        containerView.addSubview(titleSnapshot)
        containerView.addSubview(imageViewSnapshot)
        containerView.addSubview(subTitleSnapshot)
        
        var preTransitionState = TransitionState.initial
        var postTransitionState = TransitionState.final
        
        if operation == .pop {
            preTransitionState = .final
            postTransitionState = .initial
        }
        
        configureViews(for: preTransitionState, containerView: containerView, backgroundViewController: backgroundViewController, viewsInBackground: (backgroundBackgroundImageView,backgroundTitle,backgroundImageView,backgroundSubTitle), viewsInForeground: (foregroundBackgroundImageView,foregroundTitle,foregroundImageView,foregroundSubTitle), snapshotViews: (backgroundImageViewSnapshot,titleSnapshot,imageViewSnapshot,subTitleSnapshot))
        
        foregroundViewController.view.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [], animations: {
            
            self.configureViews(for: postTransitionState, containerView: containerView, backgroundViewController: backgroundViewController, viewsInBackground: (backgroundBackgroundImageView,backgroundTitle,backgroundImageView,backgroundSubTitle), viewsInForeground: (foregroundBackgroundImageView,foregroundTitle,foregroundImageView,foregroundSubTitle), snapshotViews: (backgroundImageViewSnapshot,titleSnapshot,imageViewSnapshot,subTitleSnapshot))
            
        }) { (finished) in
            backgroundViewController.view.transform = CGAffineTransform.identity
            backgroundImageViewSnapshot.removeFromSuperview()
            titleSnapshot.removeFromSuperview()
            imageViewSnapshot.removeFromSuperview()
            subTitleSnapshot.removeFromSuperview()
            backgroundBackgroundImageView.isHidden = false
            foregroundBackgroundImageView.isHidden = false
            backgroundTitle.isHidden = false
            foregroundTitle.isHidden = false
            backgroundImageView.isHidden = false
            foregroundImageView.isHidden = false
            backgroundSubTitle.isHidden = false
            foregroundSubTitle.isHidden = false
            
            foregroundViewController.view.backgroundColor = foregroundViewBackgroundColor
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

extension ZoomTransitioningDelegate: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC is ZoomingViewController && toVC is ZoomingViewController {
            self.operation = operation
            return self
        } else {
            return nil
        }
    }
}
