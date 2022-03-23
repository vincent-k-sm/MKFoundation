public struct MKFoundation {
    
    public init() {
        
    }
    public static var debugEnabled = false {
        willSet {
            SystemUtils.shared.debugEnabled = newValue
        }
    }

    
}
