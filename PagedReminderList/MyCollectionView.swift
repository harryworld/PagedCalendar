//
//  MyCollectionView.swift
//  PagedReminderList
//
//  Created by Harry Ng on 29/6/2016.
//  Copyright © 2016 STAY REAL LIMITED. All rights reserved.
//

import Cocoa

class MyCollectionView: NSCollectionView {

    func setXOffset(x:CGFloat) {
        
        guard let layout = collectionViewLayout as? NSCollectionViewFlowLayout else { return }
        guard let numItems = dataSource?.collectionView(self, numberOfItemsInSection: 0) else { return }
        guard let scrollView = enclosingScrollView else { return }
        
        // Calculate size manually, as it seems this doesn't get done properly
        // on initial collection view loading and layout
        let contentView = scrollView.contentView
        let itemWidth = bounds.width
        let itemHeight = bounds.height
        let spacing = layout.minimumLineSpacing
        
        let width = CGFloat(numItems) * itemWidth + CGFloat(numItems - 1) * spacing
        frame = NSRect(x: 0, y: 0, width: width, height: itemHeight)
        
        contentView.scrollPoint(NSPoint(x: x, y: 0))
    }
    
    func scrollToX(x:CGFloat) {
        
        guard let scrollView = enclosingScrollView else { return }
        
        let contentView = scrollView.contentView
        NSAnimationContext.beginGrouping()
        NSAnimationContext.currentContext().duration = 0.5
        
        let currentX = contentView.bounds.origin.x
        let dx = x - currentX
        
        contentView.animator().bounds.offsetInPlace(dx: dx, dy: 0)
        NSAnimationContext.endGrouping()
    }
    
}
