//
//  SwitchConstants.swift
//


import Foundation
import UIKit

public struct SwitchConstants {
    /// 길이
    static let viewWidth: CGFloat = 48
    /// 높이
    static let viewHeight: CGFloat = 28
    /// 애니메이션 시간
    static let animateDuration: CGFloat = 0.25
    /// 버튼 높이
    static let circleHeight: CGFloat = 24
    /// 버튼 길이
    static let circleWidth: CGFloat = 24
    /// 활성화 켜졌을 경우 배경 색
    static let enableOnBackgroundColor: UIColor = UIColor.setColorSet(.purple500)
    /// 활성화 꺼졌을 경우 배경 색
    static let enableOffBackgroundColor: UIColor = UIColor.setColorSet(.grey100)
    /// 비 활성화 켜졌을 경우 배경 색
    static let disableOnBackgroundColor: UIColor = UIColor.setColorSet(.purple300)
    /// 비 활성화 꺼졌을 경우 배경 색
    static let disableOffBackgroundColor: UIColor = UIColor.setColorSet(.grey50)
}
