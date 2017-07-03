//
//  SSSlider.swift
//  SSSlider
//
//  Created by ngodacdu on 6/30/17.
//  Copyright © 2017 ngodacdu. All rights reserved.
//

import UIKit

enum SliderOrientation: Int {
    case horizontal = 0
    case verticalUp
    case verticalDown
}

@IBDesignable
public class SSSlider: UIView {

    private var orientation: SliderOrientation = .horizontal
    
    fileprivate var isHorizontal: Bool {
        get {
            return orientation == .horizontal
        }
    }
    
    fileprivate var isVerticalDown: Bool {
        get {
            return orientation == .verticalDown
        }
    }
    
    @IBInspectable var orientionRaw: Int {
        get {
            return orientation.rawValue
        }
        set(newValue) {
            orientation = SliderOrientation(rawValue: newValue) ?? .horizontal
        }
    }

    /**
     * Attributes for force view
     */
    @IBInspectable public var forcePadding: CGFloat = 0.0 {
        didSet {
            relayout()
        }
    }
    
    @IBInspectable public var forceBorderColor: UIColor = UIColor.clear {
        didSet {
            forcegroundView?.layer.borderColor = forceBorderColor.cgColor
        }
    }
    
    @IBInspectable public var forceBorderWidth: CGFloat = 0.0 {
        didSet {
            forcegroundView?.layer.borderWidth = forceBorderWidth
        }
    }
    
    @IBInspectable public var forceCornerRadius: CGFloat = 0.0 {
        didSet {
            forcegroundView?.layer.cornerRadius = forceCornerRadius
            forcegroundView?.layer.masksToBounds = true
            forcegroundView?.layer.allowsEdgeAntialiasing = true
        }
    }
    
    @IBInspectable public var forceBackgroundColor: UIColor = UIColor.clear {
        didSet {
            forcegroundView?.backgroundColor = forceBackgroundColor
        }
    }
    
    /**
     * Attribute for handle view
     */
    @IBInspectable public var thickness: CGFloat = 8.0 {
        didSet {
            relayout()
        }
    }
    
    @IBInspectable public var handleBackgroundColor: UIColor = UIColor.clear {
        didSet {
            handleView?.backgroundColor = handleBackgroundColor
        }
    }
    
    @IBInspectable public var handleCornerRadius: CGFloat = 0.0 {
        didSet {
            handleView?.layer.cornerRadius = handleCornerRadius
            handleView?.layer.masksToBounds = true
            handleView?.layer.allowsEdgeAntialiasing = true
        }
    }
    
    /**
     * Content label
     */
    @IBInspectable public var content: String? {
        didSet {
            contentLabel?.text = content
            relayout()
        }
    }
    
    @IBInspectable public var contentSize: CGFloat = 14.0 {
        didSet {
            if let currentFont = contentLabel?.font {
                let newFont = UIFont(name: currentFont.familyName, size: contentSize)
                contentLabel?.font = newFont
            }
        }
    }
    
    @IBInspectable public var contentColor: UIColor = UIColor.white {
        didSet {
            contentLabel?.textColor = contentColor
        }
    }
    
    /**
     * Value view
     */
    @IBInspectable public var valueViewBackgroundColor: UIColor = UIColor.lightGray {
        didSet {
            valueView?.backgroundColor = valueViewBackgroundColor
        }
    }
    
    fileprivate var forcegroundView: SSForcegroundView?
    fileprivate var handleView: UIView?
    fileprivate var valueView: UIView?
    fileprivate var contentLabel: UILabel?
    
    public var didChangeValueBegan: ((_ slider: SSSlider, _ value: CGFloat) -> ())?
    public var didChangeValue: ((_ slider: SSSlider,_ value: CGFloat) -> ())?
    public var didChangeValueEnded: ((_ slider: SSSlider,_ value: CGFloat) -> ())?

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepare()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepare()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        relayout()
    }
    
    private func prepare() {
        if forcegroundView == nil {
            forcegroundView = SSForcegroundView()
            if let forcegroundView = forcegroundView {
                addSubview(forcegroundView)
            }
            forcegroundView?.didTouchBegan = { [weak self] (touches, event) in
                self?.moveHandleView(touches, event, .down)
            }
            forcegroundView?.didTouchMoved = { [weak self] (touches, event) in
                self?.moveHandleView(touches, event, .move)
            }
            forcegroundView?.didTouchEnded = { [weak self] (touches, event) in
                self?.moveHandleView(touches, event, .up)
            }
        }
        if valueView == nil {
            valueView = UIView()
            if let valueView = valueView {
                forcegroundView?.addSubview(valueView)
            }
        }
        if contentLabel == nil {
            contentLabel = UILabel()
            contentLabel?.textAlignment = .center
            if let contentLabel = contentLabel {
                forcegroundView?.addSubview(contentLabel)
            }
        }
        if handleView == nil {
            handleView = UIView()
            if let handleView = handleView {
                forcegroundView?.addSubview(handleView)
            }
        }
    }
    
    private func relayout() {
        relayoutForcegroundView()
        relayoutHandleView()
        relayoutContentLabel()
    }
    
    private func relayoutForcegroundView() {
        var forceFrame = CGRect.zero
        forceFrame.origin.x = forcePadding
        forceFrame.origin.y = forcePadding
        forceFrame.size.width = bounds.width - 2 * forcePadding
        forceFrame.size.height = bounds.height - 2 * forcePadding
        forcegroundView?.frame = forceFrame
    }
    
    private func relayoutHandleView() {
        guard let forcegroundView = forcegroundView else {
            return
        }
        var handleFrame = CGRect.zero
        handleFrame.origin.x = forceBorderWidth
        if isVerticalDown {
            handleFrame.origin.y = forcegroundView.frame.height - forceBorderWidth - thickness
        } else {
            handleFrame.origin.y = forceBorderWidth
        }
        if isHorizontal {
            handleFrame.size.width = thickness
            handleFrame.size.height = bounds.height - 2 * forcePadding - 2 * forceBorderWidth
        } else {
            handleFrame.size.width = bounds.width - 2 * forcePadding - 2 * forceBorderWidth
            handleFrame.size.height = thickness
        }
        handleView?.frame = handleFrame
        
        guard let handleView = handleView else {
            return
        }
        var valueFrame = CGRect.zero
        valueFrame.origin.x = forceBorderWidth
        if isVerticalDown {
            valueFrame.origin.y = handleView.center.y
        } else {
            valueFrame.origin.y = forceBorderWidth
        }
        if isHorizontal {
            valueFrame.size.width = handleView.center.x - forceBorderWidth
            valueFrame.size.height = handleFrame.height
        } else {
            valueFrame.size.width = handleFrame.width
            if isVerticalDown {
                valueFrame.size.height = forcegroundView.frame.height - handleView.center.y - forceBorderWidth
            } else {
                valueFrame.size.height = handleView.center.y - forceBorderWidth
            }
        }
        valueView?.frame = valueFrame
    }
    
    private func relayoutContentLabel() {
        if let contentBounds = forcegroundView?.bounds {
            contentLabel?.frame = contentBounds
        }
        if isHorizontal {
            contentLabel?.transform = CGAffineTransform.identity
        } else if isVerticalDown {
            contentLabel?.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2.0)
        } else {
            contentLabel?.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2.0)
        }
    }
    
}

// handle handle view
extension SSSlider {
    
    fileprivate func moveHandleView(_ touches: Set<UITouch>, _ event: UIEvent?, _ action: TouchAction) {
        guard let forcegroundView = forcegroundView else {
            return
        }
        if let touch = touches.first {
            var location = touch.location(in: forcegroundView)
            if isHorizontal {
                if location.x < (forceBorderWidth + thickness / 2.0) {
                    location.x = forceBorderWidth + thickness / 2.0
                } else if location.x > (forcegroundView.frame.size.width - forceBorderWidth - thickness / 2.0) {
                    location.x = forcegroundView.frame.size.width - forceBorderWidth - thickness / 2.0
                }
            } else {
                if location.y < (forceBorderWidth + thickness / 2.0) {
                    location.y = forceBorderWidth + thickness / 2.0
                } else if location.y > (forcegroundView.frame.size.height - forceBorderWidth - thickness / 2.0) {
                    location.y = forcegroundView.frame.size.height - forceBorderWidth - thickness / 2.0
                }
            }
            
            changeSliderValue(location: location, action: action)
            
            UIView.animate(withDuration: 0.25, animations: { [weak self] in
                if true == self?.isHorizontal {
                    self?.handleView?.center.x = location.x
                    if let forceBorderWidth = self?.forceBorderWidth {
                        self?.valueView?.frame.size.width = location.x - forceBorderWidth
                    }
                } else {
                    self?.handleView?.center.y = location.y
                    if let forceBorderWidth = self?.forceBorderWidth {
                        if true == self?.isVerticalDown {
                            self?.valueView?.frame.origin.y = location.y
                            self?.valueView?.frame.size.height = forcegroundView.frame.height - location.y - forceBorderWidth
                        } else {
                            self?.valueView?.frame.size.height = location.y - forceBorderWidth
                        }
                    }
                }
            })
        }
    }
    
    fileprivate func changeSliderValue(location: CGPoint, action: TouchAction) {
        guard let handleView = handleView else {
            return
        }
        guard let forcegroundView = forcegroundView else {
            return
        }
        let currentValue: CGFloat = {
            if isHorizontal {
                if location.x <= (forceBorderWidth + thickness / 2.0) {
                    return 0
                } else if location.x >= (forcegroundView.frame.size.width - forceBorderWidth - thickness / 2.0) {
                    return forcegroundView.frame.size.width - 2 * forceBorderWidth - thickness
                }
                return location.x - forceBorderWidth - thickness / 2.0
            }
            if location.y <= (forceBorderWidth + thickness / 2.0) {
                return 0
            } else if location.y >= (forcegroundView.frame.size.height - forceBorderWidth - thickness / 2.0) {
                return forcegroundView.frame.size.height - 2 * forceBorderWidth - thickness
            }
            return location.y - forceBorderWidth - thickness / 2.0
        }()
        let maximumValue: CGFloat = {
            if isHorizontal {
                return forcegroundView.frame.width - 2 * forceBorderWidth - thickness
            }
            return forcegroundView.frame.height - 2 * forceBorderWidth - thickness
        }()
        let valuePercent: CGFloat = {
            if isVerticalDown {
                return 1.0 - currentValue / maximumValue
            }
            return currentValue / maximumValue
        }()
        print(valuePercent)
        switch action {
        case .down:
            didChangeValueBegan?(self, valuePercent)
            break
        case .move:
            didChangeValue?(self, valuePercent)
            break
        case .up:
            didChangeValueEnded?(self, valuePercent)
            break
        }
    }
    
}
