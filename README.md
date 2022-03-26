
  

# MKFoundation


## 소개  
* 개인 프로젝트에서 공통으로 사용되는 Colorset 을 포함, UI Component를 프레임워크화 합니다
* Colorset에는 다크모드, 라이트 모드를 대응하는 Asset을 포함합니다

## 목차
 
- MKFoundation
    * [Buttons](#buttons)
        * [Button Types](#buttontypes)
        * [Button Size](#buttonsizes)
        * [Button Methods](#button-methods)
        * [Button Use Case](#button-use-case)
    * [Colors](#colors)
        * [Asset Colors](#asset-colors)
        * [Color Methods](#color-methods)
        * [Color Use Case](#color-use-case)
 
 
* [UseCase](#usecase)

---
## Buttons

### ButtonTypes
```
public enum ButtonTypes: CaseIterable {
    case red
    case orange
    case yellow
    case green
    case blue
    case pink
    case purple
    case dark
    case primary
    case white
    case grey
}
```
### ButtonSizes
```
public enum ButtonSize: CaseIterable {
    case medium
    case small
    
    var style: ButtonSizeModel {
        switch self {
            case .medium:
                let model = ButtonSizeModel(height: 48.0)
                return model

            case .small:
                let model = ButtonSizeModel(height: 44.0)
                return model
                
        }
    }
}

```

### Button Methods
* setBackgroundColor
    * 버튼 배경색을 지정합니다
```
func setBackgroundColor(
    _ color: UIColor,
    for state: UIControl.State
) {
```
---
* alignTextBelow
    * 버튼 내 이미지와 타이틀 간의 간격을 조정합니다
        - [ ] (iOS 15에서 추가된 `UIButton.Configuration` 은 향 후 대응 예정입니다)
```
func alignTextBelow(
    spacing: CGFloat = 2.0
) {
```
---
* updateTitleText
    * Foundation으로 Title 없이 설정한 버튼의 Title만 Update하고자 하는 경우 사용할 수 있습니다
        * - [ ] 내부에서 SetTitle에 자동으로 처리하도록 개선이 필요합니다
```
 func updateTitleText(
     text: String,
     status: [UIControl.State] = [.normal, .selected, .disabled, .highlighted]
 ) {
```
---
* setButtonLayout
    * 버튼 타입 및 Constants 에 따라 버튼 레이아웃을 세팅합니다
    * [Types](#buttontypes)
    * [Size](#buttonsizes)
```
func setButtonLayout(
    title: String = "",
    size: ButtonSize,
    primaryType: ButtonTypes,
    outline: Bool = false
) {
```
---
### Button Use Case
* `ButtonListViewController` 
```
lazy var mkButton: UIButton = {
    let v = UIButton()
    v.setTitle("Button", for: .normal)
    return v
}()
-----------------------------------------
self.mkButton
    .setButtonLayout(
        title: "지정할 Title을 입력하세요",
        size: .medium,
        primaryType: buttonType,
        outline: self.isOutLine
    )
```


## Colors

### Color Methods
* Colors 는 Autogen Code 입니다
* Source/ 내 `Assets.xcassets` 파일의 `Colors 폴더`을 참조하여 자동으로 enum이 생성됩니다
```
run 
- cd Scripts
- sh gen_colorset.sh
```
---
* setColorSet
    * 생성된 Colorset 을 기준으로 UIColor를 반환합니다
```
static func setColorSet(_  colorRawValue: Colors) -> UIColor {
    var color: UIColor = .black
    color = UIColor(named: colorRawValue.rawValue, in: Bundle.module, compatibleWith: nil)!
    return color
}
```

#### Asset Colors
* 상기 Autogen을 통해 생성되는 코드는 아래와 같습니다
```
public enum Colors: String {
    case background
    case background_elevated
    ...
}
```
![예시 이미지](https://github.com/vincent-k-sm/MKFoundation/blob/develop/Images/ColorSet.png?raw=true)


### Color Use Case
```
self.view.backgroundColor = UIColor.setColorSet(.background)
```
