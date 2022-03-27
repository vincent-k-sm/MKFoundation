
  

# MKFoundation


## 소개  
* 개인 프로젝트에서 공통으로 사용되는 Colorset 을 포함, UI Component를 프레임워크화 합니다
* Colorset에는 다크모드, 라이트 모드를 대응하는 Asset을 포함합니다
https://github.com/vincent-k-sm/MKFoundation/blob/develop/Images/example_video.mov

## 목차
 
- MKFoundation Features
    * [Buttons](#buttons)
        * [Button Types](#buttontypes)
        * [Button Size](#buttonsizes)
        * [Button Methods](#button-methods)
        * [Button Use Case](#button-use-case)
    * [Colors](#colors)
        * [Asset Colors](#asset-colors)
        * [Color Methods](#color-methods)
        * [Color Use Case](#color-use-case)
     * [Textview](#textview)
         * [Textview Types](#textview-types)
         * [Textview Status](#textview-status)
         * [Textview Options](#textview-options)
         * [Textview Delegate](#textview-delegate)
         * [Textview Usecase](#textview-usecase)
      * [Textfield](#textfield)
         * [Textfield Types](#textfield-types)
         * [Textfield Status](#textfield-status)
         * [Textfield Options](#textfield-options)
         * [Textfield Delegate](#textfield-delegate)
         * [Textfield Usecase](#textfield-usecase)
     * [SelectBox](#selectbox)
         * [SelectBox Types](#selectbox-types)
         * [SelectBox Status](#selectbox-status)
         * [SelectBox Options](#selectbox-options)
         * [SelectBox Delegate](#selectbox-delegate)
         * [SelectBox Usecase](#selectbox-usecase)
     * [Switch](#switch)
         * [Switch Contants](#switch-contants)
         * [Switch Delegate](#switch-delegate)
         * [Switch Usecase](#switch-usecase) 
     * [CheckBox](#checkbox)
         * [CheckBox Options](#checkbox-options)
         * [CheckBox Delegate](#checkbox-delegate)
         * [CheckBox Usecase](#checkbox-usecase) 


<br>

## Buttons

### ButtonTypes
```swift
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
```swift
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
```swift
func setBackgroundColor(
    _ color: UIColor,
    for state: UIControl.State
) {
```
---
* alignTextBelow
    * 버튼 내 이미지와 타이틀 간의 간격을 조정합니다
        - [ ] (iOS 15에서 추가된 `UIButton.Configuration` 은 향 후 대응 예정입니다)
```swift
func alignTextBelow(
    spacing: CGFloat = 2.0
) {
```
---
* updateTitleText
    * Foundation으로 Title 없이 설정한 버튼의 Title만 Update하고자 하는 경우 사용할 수 있습니다
        * - [ ] 내부에서 SetTitle에 자동으로 처리하도록 개선이 필요합니다
```swift
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
```swift
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
```swift
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
```swift
run 
- cd Scripts
- sh gen_colorset.sh
```
---
* setColorSet
    * 생성된 Colorset 을 기준으로 UIColor를 반환합니다
```swift
static func setColorSet(_  colorRawValue: Colors) -> UIColor {
    var color: UIColor = .black
    color = UIColor(named: colorRawValue.rawValue, in: Bundle.module, compatibleWith: nil)!
    return color
}
```

#### Asset Colors
* 상기 Autogen을 통해 생성되는 코드는 아래와 같습니다
```swift
public enum Colors: String {
    case background
    case background_elevated
    ...
}
```
![예시 이미지](https://github.com/vincent-k-sm/MKFoundation/blob/develop/Images/ColorSet.png?raw=true)


### Color Use Case
```swift
self.view.backgroundColor = UIColor.setColorSet(.background)
```

## TextView 
### TextView Types
* Text View 의 타입을 지정합니다
    * outline 과 fill 로 설정할 수 있으며 fill 은 배경색과 함께 옅은 outline으로 설정됩니다
```swift
public enum TextViewTypes: CaseIterable {
    case outLine
    case fill
}
```
---
### TextView Status
```swift
@objc public enum TextViewStatus: Int, CaseIterable {
    case normal // 기본 상태
    case activate // Focused 상태
    case error // 에러
    case disabled // 비 활성화
}
```
---
### TextView Options
```swift
/// 텍스트 뷰를 구성하는 값을 적용합니다
/// - Parameters:
/// - textViewHeight: Textview 높이를 고정하는 경우 사용됩니다
/// - placeHolder: placeholer text
/// - limitCount: 최대 글자 수
/// - autoLimitCountErrorMessage: 최대 글자수 도달 시 해당 메시지로 에러가 설정됩니다
/// - title: 텍스트 필드 제목 영역 입니다 적용 시 최대 높이가 변경됩니다
/// - helperText: 하단 설명 영역입니다 적용 시 최대 높이가 변경됩니다
/// - counter: 상단 카운트 설정 여부입니다 적용 시 최대 높이가 변경됩니다
/// - doneAccessory : 키보드의 닫기 버튼을 추가합니다
/// - clearAccessory : 텍스트 뷰를 클리어하는 버튼이 사용됩니다
public struct MKTextViewOptions {
    public var textViewHeight: CGFloat = 0.0
    public var inputType: TextViewTypes = .outLine
    public var placeHolder: String = ""
    public var limitCount: Int = 0
    public var autoLimitCountErrorMessage: String? = nil
    public var title: String? = nil
    public var helperText: String? = nil
    public var counter: Bool = false
    public var doneAccessory: Bool = false
    public var clearAccessory: Bool = false
}
```
---
### TextView Delegate
```swift
@objc public protocol MKTextViewDelegate: AnyObject {

    /// An textView did count limitted
    /// - Parameter textView: The MKTextView that textView was called in
    /// - Parameter status: textView status - textViewStatus
    /// - important : Trigger Only Limit Count is Not 0
    @objc optional func textViewLimitted(_ textView: MKTextView, limitted: Bool)

    /// An textView did change Status
    /// - Parameter textView: The MKTextView that textView was called in
    /// - Parameter status: textView status - textViewStatus
    @objc optional func textViewStatusDidChange(_ textView: MKTextView, status: TextViewStatus)

    /// An textView did change Text
    /// - Parameter textView: The MKTextView that textView was called in
    /// - Parameter text: textView text
    @objc optional func textViewTextDidChange(_ textView: MKTextView, text: String)

    /// An textView DidBeginEditing
    /// - Parameter textView: The MKTextView that textView was called in
    @objc optional func textViewTextDidBeginEditing(_ textView: MKTextView)

    /// An textView textViewTextDidEndEditing
    /// - Parameter textView: The MKTextView that textView was called in
    @objc optional func textViewTextDidEndEditing(_ textView: MKTextView)
}
```
---
### TextView UseCase
* TextView를 Tableview에서 활용하는 경우 높이값에 따라 `UITableView.automaticDimension` 이 필요한 경우를 위해 Configure 시 `tableview`를 추가할 수 있습니다

* Configure TextView
```swift
/* class MKTextView */ 
func configure(
    option: MKTextViewOptions,
    tableView: UITableView? = nil,
    customToolbar: Bool = false
) {
```
```swift
/* initialize TextView*/
lazy var mkTextView: MKTextView = {
    let v = MKTextView()
    return v
}()
....
/* Set TextView Options */
let option = MKTextViewOptions(
    inputType: .outLine,
    placeHolder: "TextView PlaceHolder",
    limitCount: 10,
    autoLimitCountErrorMessage: "Text is Limitted",
    title: "Title + Counter + Limit Description",
    helperText: "description for TextView",
    counter: true
)
....
/* Configure to TextView*/
mkTextView.configure(option: op, tableView: tableView)

```
---

## TextField
### Textfield Types
* Text Field 의 타입을 지정합니다
    * outline 과 fill 로 설정할 수 있으며 fill 은 배경색과 함께 옅은 outline으로 설정됩니다
```swift
public enum TextFieldTypes: CaseIterable {
    case outLine
    case fill
}
```
---
### Textfield Status
```swift
@objc public enum TextFieldStatus: Int, CaseIterable {
    case normal // 기본 상태
    case activate // Focused 상태
    case error // 에러
    case disabled // 비 활성화
}
```
---
### Textfield Options
```swift
/// 텍스트 필드를 구성하는 값을 적용합니다
/// - Parameters:
/// - placeHolder: placeholer text
/// - limitCount: 최대 글자 수
/// - autoLimitCountErrorMessage: 최대 글자수 도달 시 해당 메시지로 에러가 설정됩니다
/// - title: 텍스트 필드 제목 영역 입니다 적용 시 최대 높이가 변경됩니다
/// - helperText: 하단 설명 영역입니다 적용 시 최대 높이가 변경됩니다
/// - counter: 상단 카운트 설정 여부입니다 적용 시 최대 높이가 변경됩니다
/// - leadingIcon : 좌측 이미지 심볼을 적용합니다 이미지가 있는 경우 레이아웃이 변경됩니다
public struct MKTextFieldOptions {
    public var inputType: TextFieldTypes = .outLine
    public var placeHolder: String = ""
    public var limitCount: Int = 0
    public var autoLimitCountErrorMessage: String? = nil
    public var title: String? = nil
    public var helperText: String? = nil
    public var counter: Bool = false
    public var leadingIcon: UIImage? = nil
}
```
---
### Textfield Delegate
```swift
@objc public protocol MKTextViewDelegate: AnyObject {

    /// override Textfield
    @objc optional func textFieldShouldReturn(_ textField: MKTextField) -> Bool
    @objc optional func textFieldShouldClear(_ textField: MKTextField) -> Bool

    /// An textfield did count limitted
    /// - Parameter textField: The MKTextField that textfield was called in
    /// - Parameter status: textfield status - TextfieldStatus
    /// - important : Trigger Only Limit Count is Not 0
    @objc optional func textFieldLimitted(_ textField: MKTextField, limitted: Bool)

    // An textfield did change Status
    /// - Parameter textField: The MKTextField that textfield was called in
    /// - Parameter status: textfield status - TextfieldStatus
    @objc optional func textFieldStatusDidChange(_ textField: MKTextField, status: TextFieldStatus)

    /// An textfield did change Text
    /// - Parameter textField: The MKTextField that textfield was called in
    /// - Parameter text: textfield text
    @objc optional func textFieldTextDidChange(_ textField: MKTextField, text: String)

    /// An textfield DidBeginEditing
    /// - Parameter textField: The MKTextField that textfield was called in
    @objc optional func textFieldTextDidBeginEditing(_ textField: MKTextField)

    /// An textfield textFieldTextDidEndEditing
    /// - Parameter textField: The MKTextField that textfield was called in
    @objc optional func textFieldTextDidEndEditing(_ textField: MKTextField
}
```
---
### Textfield UseCase
* TextView를 Tableview에서 활용하는 경우 높이값에 따라 `UITableView.automaticDimension` 이 필요한 경우를 위해 Configure 시 `tableview`를 추가할 수 있습니다

* Configure TextField
```swift
/* class MKTextField */ 
func configure(
    option: MKTextFieldOptions,
    tableView: UITableView? = nil
) {
```
```swift
/* initialize TextField*/
lazy var mkTextField: MKTextField = {
    let v = MKTextField()
    return v
}()
....
/* Set MKTextField Options */
let option = MKTextFieldOptions(
    inputType: .outLine,
    placeHolder: "TextField PlaceHolder",
    limitCount: 100,
    autoLimitCountErrorMessage: nil,
    title: "Title With Description + Counter",
    helperText: "description for TextField",
    leadingIcon: UIImage(named: "ic_search") ?? nil,
    counter: true
)
....
/* Configure to TextField*/
mkTextField.configure(option: option, tableView: tableView)

```
---

## SelectBox
### SelectBox Types
* SelectBox 의 타입을 지정합니다
    * outline 과 fill 로 설정할 수 있으며 fill 은 배경색과 함께 옅은 outline으로 설정됩니다
```swift
public enum SelectBoxTypes: CaseIterable {
    case outLine
    case fill
}
```
---
### SelectBox Status
```swift
@objc public enum SelectBoxStatus: Int, CaseIterable {
    case normal // 기본 상태
    case activate // Focused 상태
    case error // 에러
    case disabled // 비 활성화
}
```
---
### SelectBox Options
```swift
/// 셀렉트 박스 를 구성하는 값을 적용합니다
/// - Parameters:
/// - placeHolder: placeholer text
/// - title: 필드 제목 영역 입니다 적용 시 최대 높이가 변경됩니다
/// - helperText: 하단 설명 영역입니다 적용 시 최대 높이가 변경됩니다
public struct MKSelectBoxOptions {
    public var inputType: SelectBoxTypes = .outLine
    public var placeHolder: String = ""
    public var title: String? = nil
    public var helperText: String? = nil
}
```
---
### SelectBox Delegate
```swift
public protocol MKSelectBoxDelegate: AnyObject {
    // Select box Selected
    /// - Parameter selectBox: The MKSelectBox that selectBox was called in
    func didSelected(_ selectBox: MKSelectBox)

    // Select box didChangeStatus
    /// - Parameter selectBox: The MKSelectBox that selectBox was called in
    /// - Parameter status: selectBox status - SelectBoxStatus
    func didChangeStatus(_ selectBox: MKSelectBox, status: SelectBoxStatus)
}
```
---
### SelectBox UseCase
* TextView를 Tableview에서 활용하는 경우 높이값에 따라 `UITableView.automaticDimension` 이 필요한 경우를 위해 Configure 시 `tableview`를 추가할 수 있습니다

* Configure SelectBox
```swift
/* class MKSelectBox */ 
func configure(
    option: MKSelectBoxOptions,
    tableView: UITableView? = nil
) {
```
```swift
/* initialize SelectBox*/
lazy var mkSelectBox: MKSelectBox = {
    let v = MKSelectBox()
    return v
}()
....
/* Set MKSelectBox Options */
let option = MKSelectBoxOptions(
    inputType: .outLine,
    placeHolder: "Select box PlaceHolder",
    title: "Title With Description",
    helperText: "description for select box"
)
....
/* Configure to TextField*/
mkSelectBox.configure(option: option, tableView: tableView)

```
---
## Switch
### Switch Constants
```swift
public  struct  SwitchConstants {
    /// 길이
    static  var viewWidth: CGFloat = 48
    /// 높이
    static  var viewHeight: CGFloat = 28
    /// 애니메이션 시간
    static  var animateDuration: CGFloat = 0.25
    /// 버튼 높이
    static  var circleHeight: CGFloat = 24
    /// 버튼 길이
    static  var circleWidth: CGFloat = 24
    /// 활성화 + 켜졌을 경우 배경 색
    static  var enableOnBackgroundColor: UIColor = UIColor.setColorSet(.purple500)
    /// 활성화 + 꺼졌을 경우 배경 색
    static  var enableOffBackgroundColor: UIColor = UIColor.setColorSet(.grey100)
    /// 비 활성화 + 켜졌을 경우 배경 색
    static  var disableOnBackgroundColor: UIColor = UIColor.setColorSet(.grey300)
    /// 비 활성화 + 꺼졌을 경우 배경 색
    static  var disableOffBackgroundColor: UIColor = UIColor.setColorSet(.grey300)
}
```
### Switch Delegate
```swift
public protocol SwitchDelegate: AnyObject {
    func isOnValueChange(switch: MKSwitch, isOn: Bool)
}
```
### Switch Usecase
* Disabled 상태에서는 `isOn` `status` 가 `return` 됩니다
```swift
/* class MKSwitch: UIView */
--- 
/// set switch status
public func setSwitch(isOn: Bool)

/// set isEnabled
public var isEnabled: Bool = true

/// initialize switch
lazy var mkSwitch: MKSwitch = {
    let v = MKSwitch()
    return v
}()
```
---
## CheckBox

### CheckBox Options
```swift 
/// 체크박스를 구성하는 값을 적용합니다
/// - Parameters:
/// - text : 컨텐츠 내용
/// - isEnabled : enable 여부를 설정합니다
/// - textColor : 제목 색상 (title Label에 직접 접근하여 변경할 수 있습니다)
/// - isOn: On/Off Status
public struct MKCheckBoxOptions {
    public var text: String? = nil
    public var isEnabled: Bool = true
    public var textColor: Colors = .text_primary
    public var isOn: Bool = false
}
```

### CheckBox Delegate
```swift 
public protocol MKCheckBoxDelegate: AnyObject {
    func didSelected(_ selectBox: MKCheckBox)
    func didChangeStatus(_ selectBox: MKCheckBox, status: Bool)
}
```
### CheckBox Usecase
```swift 

/// initialize Checkbox
lazy var mkCheckBox: MKCheckBox = {
    let v = MKCheckBox()
    return v
}()

/// set checkbox options
let option = MKCheckBoxOptions(
    text: "enabled + isOn",
    isEnabled: true,
    textColor: .text_primary,
    isOn: true
)

/// configure
mkCheckBox.configure(option: option)
```
---
