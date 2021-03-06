//
//  CollieGalleryAnimationOptions.swift
//
//  Copyright (c) 2016 Guilherme Munhoz <g.araujo.munhoz@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

/**
 
    Transition type used on the presentation and dismissal of the gallery.

    - Default: Zoom transition based on the center of the screen.
    - Zoom: Zoom transition based on a view.
    - None: No transition.
 
 */
public enum CollieGalleryTransitionType
{
    case Default
    case Zoom(fromView: UIView, zoomTransitionDelegate: CollieGalleryZoomTransitionDelegate)
    case None
    
    internal var transition: CollieGalleryTransitionProtocol? {
        switch self {
        case .None:
            return nil
        case .Zoom(let fromView, let zoomTransitionDelegate):
            return CollieGalleryZoomTransition(fromView: fromView,
                                               zoomTransitionDelegate: zoomTransitionDelegate)
        default:
            return CollieGalleryDefaultTransition()
        }
    }
    
    internal var animated: Bool {
        switch self {
        case .None:
            return false
        default:
            return true
        }
    }
    
    internal var fromView: UIView? {
        switch self {
        case .Zoom(let fromView, _):
            return fromView
        default:
            return nil
        }
    }
    
    /// The default transition for all new instances of the gallery
    public static var defaultType = CollieGalleryTransitionType.Default
}
