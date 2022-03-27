//
//  SwitchConstants.swift
//


import Foundation
import UIKit

public struct SwitchConstants {
    /// 길이
    static var viewWidth: CGFloat = 48
    /// 높이
    static var viewHeight: CGFloat = 28
    /// 애니메이션 시간
    static var animateDuration: CGFloat = 0.25
    /// 버튼 높이
    static var circleHeight: CGFloat = 24
    /// 버튼 길이
    static var circleWidth: CGFloat = 24
    /// 활성화 + 켜졌을 경우 배경 색
    static var enableOnBackgroundColor: UIColor = UIColor.setColorSet(.purple500)
    /// 활성화 + 꺼졌을 경우 배경 색
    static var enableOffBackgroundColor: UIColor = UIColor.setColorSet(.grey100)
    /// 비 활성화 + 켜졌을 경우 배경 색
    static var disableOnBackgroundColor: UIColor = UIColor.setColorSet(.grey300)
    /// 비 활성화 + 꺼졌을 경우 배경 색
    static var disableOffBackgroundColor: UIColor = UIColor.setColorSet(.grey300)
}
