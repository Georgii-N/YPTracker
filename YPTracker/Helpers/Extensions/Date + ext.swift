import Foundation

extension Date: Equatable {
    public static func == (lhs: Date, rhs: Date) -> Bool {
        let calendar = Calendar.current
        let lhsComponents = calendar.dateComponents([.year, .month, .day], from: lhs)
        let rhsComponents = calendar.dateComponents([.year, .month, .day], from: rhs)
        
        return lhsComponents.year == rhsComponents.year &&
            lhsComponents.month == rhsComponents.month &&
            lhsComponents.day == rhsComponents.day
    }
}

