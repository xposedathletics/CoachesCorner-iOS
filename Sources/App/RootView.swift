import SwiftUI
 
public struct RootView: View {
   @State private var selectedTab: AppTab = .dashboard
 
   public init() {}
 
   public var body: some View {
       TabView(selection: $selectedTab) {
           DashboardView()
               .tabItem {
                   Label("Dashboard", systemImage: "house.fill")
               }
               .tag(AppTab.dashboard)
 
           VideoHubView()
               .tabItem {
                   Label("Video", systemImage: "video.fill")
               }
               .tag(AppTab.video)
 
           LiveGameView()
               .tabItem {
                   Label("Live Game", systemImage: "sportscourt.fill")
               }
               .tag(AppTab.liveGame)
 
           ScoutingView()
               .tabItem {
                   Label("Scouting", systemImage: "magnifyingglass")
               }
               .tag(AppTab.scouting)
 
           PlaybookView()
               .tabItem {
                   Label("Playbook", systemImage: "doc.text.fill")
               }
               .tag(AppTab.playbook)
 
           TeamCommsView()
               .tabItem {
                   Label("Team", systemImage: "bubble.left.and.bubble.right.fill")
               }
               .tag(AppTab.comms)
 
           AnalyticsView()
               .tabItem {
                   Label("Analytics", systemImage: "chart.bar.fill")
               }
               .tag(AppTab.analytics)
       }
       .accentColor(Color.ccCrimson)
       .preferredColorScheme(.dark)
   }
}
 
public enum AppTab: Hashable {
   case dashboard, video, liveGame, scouting, playbook, comms, analytics
}