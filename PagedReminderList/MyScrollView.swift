//
//  MyScrollView.swift
//  PagedReminderList
//
//  Created by Harry Ng on 27/6/2016.
//  Copyright © 2016 STAY REAL LIMITED. All rights reserved.
//

import Cocoa

enum Goto {
    case Previous, Current, Next
}

class MyScrollView: NSScrollView {
    
    override var hasHorizontalScroller: Bool {
        get { return false }
        set { }
    }
    
    var isSwiping = false {
        didSet {
            Swift.print("isSwiping: \(isSwiping)")
        }
    }
    var goto: Goto = .Current
    var currentOffset = CGPoint(x: 0, y: 0)

    override func scrollWheel(theEvent: NSEvent) {
        
        switch theEvent.phase {
        case NSEventPhase.Began:
            isSwiping = true
            currentOffset = self.documentVisibleRect.origin
            Swift.print("Start : \(currentOffset)")
        case NSEventPhase.Changed:
            Swift.print(self.documentVisibleRect.origin.x)
            super.scrollWheel(theEvent)
        case NSEventPhase.Ended:
            isSwiping = false
            Swift.print("End at: \(self.documentVisibleRect.origin)")
            
            let offsetX = self.documentVisibleRect.origin.x
            let diff = offsetX - currentOffset.x
            
            if diff > 125 {
                goto = .Next
            } else if diff < -125 {
                goto = .Previous
            } else {
                goto = .Current
            }
        default: break
        }
        
        //super.scrollWheel(theEvent)
    }
    
    override func reflectScrolledClipView(cView: NSClipView) {
        super.reflectScrolledClipView(cView)
        
        guard isSwiping == false else { return }
        guard let collectionView = self.documentView as? MyCollectionView else { return }
            
        switch goto {
        case .Previous:
            collectionView.scrollToX(248 * 0)
        case .Current:
            collectionView.scrollToX(248 * 1)
        case .Next:
            collectionView.scrollToX(248 * 2)
        }
    }
}
