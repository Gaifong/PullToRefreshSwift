//
//  PullToRefreshConst.swift
//  PullToRefreshSwift
//
//  Created by Yuji Hato on 12/11/14.
//
import Foundation
import UIKit

public extension UIScrollView {
    
    private var pullToRefreshView: PullToRefreshView? {
        get {
            let pullToRefreshView = viewWithTag(PullToRefreshConst.tag)
            return pullToRefreshView as? PullToRefreshView
        }
    }

    public func addPullToRefresh(refreshCompletion :(() -> ()), customTopInset:CGFloat = 0) {
        self.addPullToRefresh(options: PullToRefreshOption(), customTopInset: customTopInset, refreshCompletion: refreshCompletion)
    }
    
    public func addPullToRefresh(options options: PullToRefreshOption = PullToRefreshOption(), customTopInset:CGFloat = 0, refreshCompletion :(() -> ())) {
        removePullToRefresh()
        let refreshViewFrame = CGRectMake(0,  -customTopInset - PullToRefreshConst.height, self.frame.size.width, PullToRefreshConst.height)
        let refreshView = PullToRefreshView(options: options, frame: refreshViewFrame, refreshCompletion: refreshCompletion)
        refreshView.tag = PullToRefreshConst.tag
        addSubview(refreshView)
    }

    public func startPullToRefresh() {
        pullToRefreshView?.state = .Refreshing
    }
    
    public func stopPullToRefresh() {
        pullToRefreshView?.state = .Normal
    }
    
    // If you want to PullToRefreshView fixed top potision, Please call this function in scrollViewDidScroll
    public func fixedPullToRefreshViewForDidScroll() {
        if PullToRefreshConst.fixedTop {
            if self.contentOffset.y < -PullToRefreshConst.height {
                if var frame = pullToRefreshView?.frame {
                    frame.origin.y = self.contentOffset.y
                    pullToRefreshView?.frame = frame
                }
            } else {
                if var frame = pullToRefreshView?.frame {
                    frame.origin.y = -PullToRefreshConst.height
                    pullToRefreshView?.frame = frame
                }
            }
        }
    }
    
    func removePullToRefresh() {
        for subView in subviews {
            if let subView = subView as? PullToRefreshView {
                subView.removeFromSuperview()
            }
        }
    }
}
