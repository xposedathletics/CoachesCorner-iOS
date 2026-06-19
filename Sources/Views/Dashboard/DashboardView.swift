import SwiftUI
 
public struct DashboardView: View {
   @State private var winProb: Double = 0.73
   @State private var insights = SampleData.insights
 
   public init() {}
 
   let cameras = [
       ("Veo 3", "Field 1", "LIVE", Color.red),
       ("Pixellot", "Field 2", "READY", Color.ccGreen),
       ("Hudl Focus", "Gym", "OFFLINE", Color.ccSubtext),
       ("Catapult GPS", "All Fields", "SYNCED", Color.blue),
   ]
 
   public var body: some View {
       NavigationStack {
           ZStack(alignment: .top) {
               Color.ccDark.ignoresSafeArea()
               ScrollView {
                   VStack(spacing: 0) {
                       // Header
                       headerBanner
 
                       VStack(spacing: 16) {
                           // Stat Cards
                           LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                               CCStatCard(label: "Active Athletes", value: "\(SampleData.athletes.count)", icon: "👥", accentColor: .ccCrimson)
                               CCStatCard(label: "Sessions This Week", value: "14", icon: "🏋️", accentColor: .ccGreen)
                               CCStatCard(label: "Games Logged", value: "8", icon: "🏈", accentColor: .ccGold)
                               CCStatCard(label: "AI Alerts", value: "\(insights.count)", icon: "🤖", accentColor: .blue)
                           }
 
                           // AI Intelligence Panel
                           aiPanel
 
                           // Win Probability
                           winProbPanel
 
                           // Camera Feeds
                           cameraPanel
 
                           // Quick Actions
                           quickActionsPanel
                       }
                       .padding(16)
                   }
               }
           }
           .navigationBarHidden(true)
       }
   }
 
   // MARK: - Sub Views
   var headerBanner: some View {
       ZStack {
           LinearGradient(colors: [Color.ccCrimson, Color(red:0.18,green:0.36,blue:0.20)],
                          startPoint: .leading, endPoint: .trailing)
           VStack(spacing: 2) {
               HStack(spacing: 10) {
                   ZStack {
                       RoundedRectangle(cornerRadius: 10)
                           .fill(Color.white.opacity(0.15))
                           .frame(width: 44, height: 44)
                       Text("🏆").font(.title2)
                   }
                   VStack(alignment: .leading, spacing: 1) {
                       HStack(spacing: 0) {
                           Text("COACHES").font(.title3).fontWeight(.black).foregroundColor(.white)
                           Text("CORNER").font(.title3).fontWeight(.black).foregroundColor(.ccGold)
                       }
                       Text("THE WORLD'S FASTEST AI COACHING PLATFORM")
                           .font(.system(size: 9, weight: .semibold))
                           .foregroundColor(.white.opacity(0.65))
                           .kerning(1.2)
                   }
                   Spacer()
               }
               .padding(.horizontal, 20)
               .padding(.top, 16)
               .padding(.bottom, 12)
           }
       }
   }
 
   var aiPanel: some View {
       VStack(alignment: .leading, spacing: 12) {
           HStack {
               Image(systemName: "brain.head.profile")
                   .foregroundColor(.ccGold)
               VStack(alignment: .leading, spacing: 1) {
                   Text("AI COACHING INTELLIGENCE")
                       .font(.subheadline).fontWeight(.black).foregroundColor(.white)
                   Text("Next Gen Stats Engine")
                       .font(.caption2).foregroundColor(.ccSubtext)
               }
               Spacer()
               liveBadge
           }
           ForEach(insights) { insight in
               AIInsightRow(insight: insight)
           }
       }
       .padding(16)
       .background(Color.ccSurface)
       .cornerRadius(16)
       .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.ccBorder, lineWidth: 1))
   }
 
   var winProbPanel: some View {
       VStack(alignment: .leading, spacing: 12) {
           Text("⚡ WIN PROBABILITY ENGINE")
               .font(.subheadline).fontWeight(.black)
           HStack {
               VStack {
                   Text("\(Int(winProb * 100))%")
                       .font(.system(size: 48, weight: .black))
                       .foregroundColor(.ccGreen)
                   Text("Win Probability")
                       .font(.caption).foregroundColor(.ccSubtext)
               }
               Spacer()
               VStack(alignment: .trailing, spacing: 6) {
                   Label("Offense: 81%", systemImage: "arrow.up").font(.caption).foregroundColor(.ccGreen)
                   Label("Defense: 68%", systemImage: "arrow.down").font(.caption).foregroundColor(.ccGold)
                   Label("vs Last Game: +6%", systemImage: "chart.line.uptrend.xyaxis").font(.caption).foregroundColor(.ccGold)
               }
           }
           CCProgressBar(value: winProb, color: .ccGreen)
       }
       .padding(16)
       .background(Color.ccSurface)
       .cornerRadius(16)
       .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.ccBorder, lineWidth: 1))
   }
 
   var cameraPanel: some View {
       VStack(alignment: .leading, spacing: 10) {
           Text("📹 AI CAMERA FEEDS")
               .font(.subheadline).fontWeight(.black)
           ForEach(Array(cameras.enumerated()), id: \.offset) { i, cam in
               HStack {
                   VStack(alignment: .leading, spacing: 2) {
                       Text(cam.0).font(.subheadline).fontWeight(.bold)
                       Text(cam.1).font(.caption).foregroundColor(.ccSubtext)
                   }
                   Spacer()
                   Text(cam.2)
                       .font(.caption2).fontWeight(.black)
                       .foregroundColor(cam.3)
                       .padding(.horizontal, 10).padding(.vertical, 4)
                       .background(cam.3.opacity(0.15))
                       .cornerRadius(20)
                       .overlay(RoundedRectangle(cornerRadius: 20).stroke(cam.3.opacity(0.4), lineWidth: 1))
               }
               if i < cameras.count - 1 {
                   Divider().background(Color.ccBorder)
               }
           }
       }
       .padding(16)
       .background(Color.ccSurface)
       .cornerRadius(16)
       .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.ccBorder, lineWidth: 1))
   }
 
   var quickActionsPanel: some View {
       VStack(alignment: .leading, spacing: 10) {
           Text("⚡ QUICK ACTIONS")
               .font(.subheadline).fontWeight(.black)
           let actions = [
               ("🎬", "Start Film Session", Color.ccCrimson),
               ("🔍", "Generate Scouting Report", Color.ccGreen),
               ("📋", "Build Game Plan", Color.ccGold),
               ("📢", "Team Broadcast", Color.blue),
           ]
           ForEach(Array(actions.enumerated()), id: \.offset) { _, action in
               Button(action: {}) {
                   HStack {
                       Text(action.0).font(.title3)
                       Text(action.1).font(.subheadline).fontWeight(.semibold).foregroundColor(.white)
                       Spacer()
                       Image(systemName: "chevron.right").foregroundColor(action.2)
                   }
                   .padding(12)
                   .background(Color.ccDark)
                   .cornerRadius(10)
                   .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.ccBorder, lineWidth: 1))
               }
           }
       }
       .padding(16)
       .background(Color.ccSurface)
       .cornerRadius(16)
       .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.ccBorder, lineWidth: 1))
   }
 
   var liveBadge: some View {
       HStack(spacing: 5) {
           Circle().fill(Color.green).frame(width: 7, height: 7)
           Text("LIVE").font(.caption2).fontWeight(.black).foregroundColor(.green)
       }
       .padding(.horizontal, 10).padding(.vertical, 4)
       .background(Color.green.opacity(0.12))
       .cornerRadius(20)
       .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.green.opacity(0.4), lineWidth: 1))
   }
}