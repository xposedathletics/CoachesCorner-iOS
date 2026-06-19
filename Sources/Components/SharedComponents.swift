import SwiftUI
 
// MARK: - CC Header
public struct CCHeader: View {
   public var title: String
   public var subtitle: String
   public var icon: String
 
   public init(title: String, subtitle: String, icon: String) {
       self.title = title; self.subtitle = subtitle; self.icon = icon
   }
 
   public var body: some View {
       ZStack {
           LinearGradient(
               colors: [Color.ccCrimson, Color(red: 0.18, green: 0.36, blue: 0.20)],
               startPoint: .leading, endPoint: .trailing
           )
           HStack(spacing: 12) {
               Text(icon).font(.title2)
               VStack(alignment: .leading, spacing: 2) {
                   Text(title)
                       .font(.headline).fontWeight(.black).foregroundColor(.white)
                   Text(subtitle)
                       .font(.caption2).foregroundColor(.white.opacity(0.65))
               }
               Spacer()
           }
           .padding(.horizontal, 20)
           .padding(.vertical, 14)
       }
       .frame(maxWidth: .infinity)
   }
}
 
// MARK: - Stat Card
public struct CCStatCard: View {
   public var label: String
   public var value: String
   public var icon: String
   public var accentColor: Color
 
   public init(label: String, value: String, icon: String, accentColor: Color) {
       self.label = label; self.value = value; self.icon = icon; self.accentColor = accentColor
   }
 
   public var body: some View {
       VStack(alignment: .leading, spacing: 6) {
           Text(icon).font(.title2)
           Text(value)
               .font(.system(size: 28, weight: .black))
               .foregroundColor(accentColor)
           Text(label)
               .font(.caption)
               .foregroundColor(.ccSubtext)
       }
       .padding(16)
       .frame(maxWidth: .infinity, alignment: .leading)
       .background(Color.ccSurface)
       .cornerRadius(14)
       .overlay(
           RoundedRectangle(cornerRadius: 14)
               .stroke(accentColor.opacity(0.4), lineWidth: 1)
       )
   }
}
 
// MARK: - Grade Badge
public struct GradeBadge: View {
   public var grade: String
 
   public init(grade: String) { self.grade = grade }
 
   public var gradeColor: Color {
       if grade.hasPrefix("A") { return .ccGreen }
       if grade.hasPrefix("B") { return .ccGold }
       return .ccCrimson
   }
 
   public var body: some View {
       Text(grade)
           .font(.caption).fontWeight(.black)
           .foregroundColor(.white)
           .padding(.horizontal, 8).padding(.vertical, 3)
           .background(gradeColor)
           .cornerRadius(6)
   }
}
 
// MARK: - Progress Bar
public struct CCProgressBar: View {
   public var value: Double       // 0.0 – 1.0
   public var color: Color
 
   public init(value: Double, color: Color) { self.value = value; self.color = color }
 
   public var body: some View {
       GeometryReader { geo in
           ZStack(alignment: .leading) {
               RoundedRectangle(cornerRadius: 4).fill(Color.ccBorder).frame(height: 8)
               RoundedRectangle(cornerRadius: 4)
                   .fill(LinearGradient(colors: [Color.ccCrimson, color], startPoint: .leading, endPoint: .trailing))
                   .frame(width: geo.size.width * min(1, max(0, value)), height: 8)
           }
       }
       .frame(height: 8)
   }
}
 
// MARK: - Tag Chip
public struct TagChip: View {
   public var label: String
   public init(label: String) { self.label = label }
 
   public var body: some View {
       Text(label)
           .font(.caption2).fontWeight(.semibold)
           .foregroundColor(.ccSubtext)
           .padding(.horizontal, 8).padding(.vertical, 4)
           .background(Color.ccDark)
           .cornerRadius(6)
           .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.ccBorder, lineWidth: 1))
   }
}
 
// MARK: - AI Insight Row
public struct AIInsightRow: View {
   public var insight: AIInsight
   public init(insight: AIInsight) { self.insight = insight }
 
   public var typeColor: Color {
       switch insight.type {
       case "HEALTH": return .orange
       case "SCOUT": return .ccGold
       case "DEFENSE": return .ccGreen
       default: return .blue
       }
   }
 
   public var body: some View {
       HStack(alignment: .top, spacing: 12) {
           Text(insight.icon).font(.title3)
           VStack(alignment: .leading, spacing: 4) {
               Text(insight.text)
                   .font(.caption).foregroundColor(.ccText).fixedSize(horizontal: false, vertical: true)
               Text(insight.type)
                   .font(.caption2).fontWeight(.black)
                   .foregroundColor(typeColor)
           }
           Spacer()
       }
       .padding(12)
       .background(Color.ccDark)
       .cornerRadius(10)
       .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.ccBorder, lineWidth: 1))
   }
}
 
// MARK: - Priority Badge
public struct PriorityBadge: View {
   public var priority: String
   public init(priority: String) { self.priority = priority }
 
   public var priorityColor: Color {
       switch priority {
       case "CRITICAL": return .ccCrimson
       case "HIGH": return .ccGold
       default: return .ccSubtext
       }
   }
 
   public var body: some View {
       Text(priority)
           .font(.caption2).fontWeight(.black)
           .foregroundColor(priorityColor)
           .padding(.horizontal, 8).padding(.vertical, 3)
           .background(priorityColor.opacity(0.15))
           .cornerRadius(4)
           .overlay(RoundedRectangle(cornerRadius: 4).stroke(priorityColor.opacity(0.5), lineWidth: 1))
   }
}