import SwiftUI
 
public struct AnalyticsView: View {
   @State private var activeView = 0
   let viewTabs = ["Team", "Individual", "Opponent", "Predictive"]
 
   public init() {}
 
   let teamMetrics = [
       ("Avg Speed", "18.7 mph", "+4%", true),
       ("Avg Acceleration", "9.1 ft/s²", "+2%", true),
       ("Completion %", "67%", "+5%", true),
       ("Defensive Stop %", "71%", "-1%", false),
       ("Training Load", "742 AU", "+8%", true),
       ("Injury Risk", "2.3/10", "↓ Low", true),
   ]
 
   let situational = [
       ("Red Zone Offense", 0.74), ("3rd Down Conv.", 0.61),
       ("2-Minute Drill", 0.83), ("4th Quarter Eff.", 0.71),
   ]
 
   let playerGrades: [(String, String, Int)] = [
       ("Marcus Johnson", "WR", 91), ("Devon Carter", "QB", 87),
       ("Jaylen Simms", "SG", 83), ("Trey Washington", "RB", 88),
       ("Chris Evans", "FW", 79),
   ]
 
   public var body: some View {
       NavigationStack {
           ZStack { Color.ccDark.ignoresSafeArea()
               VStack(spacing: 0) {
                   CCHeader(title: "ANALYTICS ENGINE", subtitle: "NFL Next Gen Stats Grade Analytics", icon: "📊")
 
                   // Tabs
                   ScrollView(.horizontal, showsIndicators: false) {
                       HStack(spacing: 0) {
                           ForEach(Array(viewTabs.enumerated()), id: \.offset) { i, tab in
                               Button(tab) { activeView = i }
                                   .font(.caption).fontWeight(.bold)
                                   .foregroundColor(activeView == i ? .white : .ccSubtext)
                                   .padding(.vertical, 10).padding(.horizontal, 16)
                                   .background(activeView == i ? Color.ccGreen : Color.clear)
                           }
                       }
                       .background(Color.ccSurface)
                   }
                   Divider().background(Color.ccBorder)
 
                   ScrollView {
                       VStack(spacing: 16) {
                           // Team Metrics
                           LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                               ForEach(Array(teamMetrics.enumerated()), id: \.offset) { _, m in
                                   metricCard(label: m.0, value: m.1, trend: m.2, positive: m.3)
                               }
                           }
 
                           // Situational Efficiency
                           VStack(alignment: .leading, spacing: 12) {
                               Text("⚡ SITUATIONAL EFFICIENCY").font(.subheadline).fontWeight(.black)
                               ForEach(situational, id: \.0) { s in
                                   VStack(alignment: .leading, spacing: 4) {
                                       HStack {
                                           Text(s.0).font(.subheadline).foregroundColor(.ccSubtext)
                                           Spacer()
                                           Text("\(Int(s.1 * 100))%").font(.subheadline).fontWeight(.bold)
                                               .foregroundColor(s.1 >= 0.7 ? .ccGreen : .ccGold)
                                       }
                                       CCProgressBar(value: s.1, color: s.1 >= 0.7 ? .ccGreen : .ccGold)
                                   }
                               }
                           }
                           .padding(14).background(Color.ccSurface).cornerRadius(14)
                           .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.ccBorder, lineWidth: 1))
 
                           // NGS Player Grades
                           VStack(alignment: .leading, spacing: 10) {
                               Text("🏆 NGS PLAYER GRADES").font(.subheadline).fontWeight(.black)
                               ForEach(playerGrades, id: \.0) { player in
                                   HStack {
                                       VStack(alignment: .leading, spacing: 2) {
                                           Text(player.0).font(.subheadline).fontWeight(.bold)
                                           Text(player.1).font(.caption).foregroundColor(.ccSubtext)
                                       }
                                       Spacer()
                                       CCProgressBar(value: Double(player.2) / 100.0, color: player.2 >= 90 ? .ccGreen : player.2 >= 80 ? .ccGold : .ccCrimson)
                                           .frame(width: 80)
                                       Text("\(player.2)").font(.headline).fontWeight(.black)
                                           .foregroundColor(player.2 >= 90 ? .ccGreen : player.2 >= 80 ? .ccGold : .ccCrimson)
                                           .frame(width: 32, alignment: .trailing)
                                   }
                                   Divider().background(Color.ccBorder)
                               }
                           }
                           .padding(14).background(Color.ccSurface).cornerRadius(14)
                           .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.ccBorder, lineWidth: 1))
 
                           // Win Probability Model
                           VStack(alignment: .leading, spacing: 10) {
                               Text("🤖 PREDICTIVE WIN MODEL").font(.subheadline).fontWeight(.black)
                               HStack {
                                   VStack(alignment: .leading) {
                                       Text("W").font(.system(size: 48, weight: .black)).foregroundColor(.ccGreen) +
                                       Text(" 73%").font(.title).foregroundColor(.ccSubtext)
                                       Text("Next Game Prediction").font(.caption).foregroundColor(.ccSubtext)
                                       Text("Based on 847 data points").font(.caption2).foregroundColor(.ccGold)
                                   }
                                   Spacer()
                                   VStack(alignment: .trailing, spacing: 6) {
                                       factorRow("Offense Efficiency", "+12%")
                                       factorRow("Defensive Stop Rate", "+8%")
                                       factorRow("Turnover Margin", "+4 avg")
                                       factorRow("Opp 3rd Down Conv", "31% low")
                                   }
                               }
                           }
                           .padding(14).background(Color.ccSurface).cornerRadius(14)
                           .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.ccBorder, lineWidth: 1))
 
                           // Export Panel
                           VStack(alignment: .leading, spacing: 10) {
                               Text("📤 EXPORT & SHARE").font(.subheadline).fontWeight(.black)
                               let exports = [("📄","Full Season Report PDF"),("🃏","Player Grade Cards"),("🔍","Opponent Scouting PDF"),("📊","NGS Stats CSV"),("🏆","Recruiting Highlight Package"),("📣","Share to Team")]
                               ForEach(exports, id: \.1) { exp in
                                   Button(action: {}) {
                                       HStack {
                                           Text(exp.0).font(.title3)
                                           Text(exp.1).font(.subheadline).fontWeight(.semibold).foregroundColor(.white)
                                           Spacer()
                                           Image(systemName: "arrow.down.circle").foregroundColor(.ccCrimson)
                                       }
                                       .padding(12)
                                       .background(Color.ccDark)
                                       .cornerRadius(10)
                                       .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.ccBorder, lineWidth: 1))
                                   }
                               }
                           }
                           .padding(14).background(Color.ccSurface).cornerRadius(14)
                           .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.ccBorder, lineWidth: 1))
                       }
                       .padding(16)
                   }
               }
           }
           .navigationBarHidden(true)
       }
   }
 
   func metricCard(label: String, value: String, trend: String, positive: Bool) -> some View {
       VStack(alignment: .leading, spacing: 4) {
           Text(label).font(.caption2).foregroundColor(.ccSubtext).lineLimit(1)
           Text(value).font(.headline).fontWeight(.black).foregroundColor(positive ? .ccGreen : .ccCrimson)
           Text(trend).font(.caption2).foregroundColor(positive ? .ccGreen : .ccCrimson)
       }
       .padding(12)
       .frame(maxWidth: .infinity, alignment: .leading)
       .background(Color.ccSurface)
       .cornerRadius(12)
       .overlay(RoundedRectangle(cornerRadius: 12).stroke(positive ? Color.ccGreen.opacity(0.3) : Color.ccCrimson.opacity(0.3), lineWidth: 1))
   }
 
   func factorRow(_ label: String, _ value: String) -> some View {
       HStack(spacing: 6) {
           Text(label).font(.caption2).foregroundColor(.ccSubtext)
           Text(value).font(.caption2).fontWeight(.bold).foregroundColor(.ccGreen)
       }
   }
}