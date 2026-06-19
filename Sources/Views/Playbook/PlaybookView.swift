import SwiftUI
 
public struct PlaybookView: View {
   @State private var plays = SampleData.plays
   @State private var selectedSport = "Football"
   @State private var selectedPlay: Play? = nil
   @State private var showAISuggestion = false
   @State private var aiSuggestionPlay = "Mesh Concept"
   @State private var aiSuggestionConf = 81
 
   let sports = ["Football", "Basketball", "Soccer", "Baseball", "Volleyball"]
 
   public init() {}
 
   public var body: some View {
       NavigationStack {
           ZStack { Color.ccDark.ignoresSafeArea()
               VStack(spacing: 0) {
                   CCHeader(title: "PLAYBOOK BUILDER", subtitle: "AI Play Design — Formation Library — Qwikcut Tagging", icon: "📋")
 
                   // Sport Selector
                   ScrollView(.horizontal, showsIndicators: false) {
                       HStack(spacing: 8) {
                           ForEach(sports, id: \.self) { sport in
                               Button(sport) { selectedSport = sport }
                                   .font(.caption).fontWeight(selectedSport == sport ? .bold : .regular)
                                   .foregroundColor(.white)
                                   .padding(.horizontal, 14).padding(.vertical, 7)
                                   .background(selectedSport == sport ? Color.ccCrimson : Color.ccSurface)
                                   .cornerRadius(20)
                                   .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.ccBorder, lineWidth: 1))
                           }
                       }
                       .padding(.horizontal, 16).padding(.vertical, 10)
                   }
                   .background(Color.ccSurface)
 
                   ScrollView {
                       VStack(spacing: 14) {
                           // AI Suggestion Banner
                           if showAISuggestion {
                               aiSuggestionBanner
                           }
 
                           // Action Buttons
                           HStack(spacing: 10) {
                               Button(action: { withAnimation { showAISuggestion.toggle() } }) {
                                   Label("AI Play Suggest", systemImage: "brain.head.profile")
                                       .font(.subheadline).fontWeight(.bold).foregroundColor(.white)
                                       .frame(maxWidth: .infinity).padding(.vertical, 10)
                                       .background(Color.ccGreen).cornerRadius(12)
                               }
                               Button(action: {}) {
                                   Label("New Play", systemImage: "plus")
                                       .font(.subheadline).fontWeight(.bold).foregroundColor(.white)
                                       .frame(maxWidth: .infinity).padding(.vertical, 10)
                                       .background(Color.ccCrimson).cornerRadius(12)
                               }
                           }
 
                           // Play Grid
                           LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                               ForEach(plays) { play in
                                   PlayCard(play: play, isSelected: selectedPlay?.id == play.id) {
                                       selectedPlay = play
                                   }
                               }
                           }
 
                           // Selected Play Detail
                           if let play = selectedPlay {
                               PlayDetailPanel(play: play)
                           }
                       }
                       .padding(16)
                   }
               }
           }
           .navigationBarHidden(true)
       }
   }
 
   var aiSuggestionBanner: some View {
       VStack(alignment: .leading, spacing: 10) {
           HStack {
               Text("🤖 AI SITUATIONAL PLAY CALL").font(.subheadline).fontWeight(.black).foregroundColor(.ccGold)
               Spacer()
               Text("\(aiSuggestionConf)% SUCCESS").font(.caption2).fontWeight(.black)
                   .foregroundColor(.ccGreen)
                   .padding(.horizontal, 8).padding(.vertical, 3)
                   .background(Color.ccGreen.opacity(0.15)).cornerRadius(4)
           }
           Text("SITUATION: 3rd & 7, Opponent 35yd line, Q4, Up by 4")
               .font(.caption2).foregroundColor(.ccSubtext)
           Text(aiSuggestionPlay + " — Shotgun 2x2").font(.title3).fontWeight(.black)
           Text("📊 Opponent CB #24 has been beaten on crossing routes. Slot receiver 94% route efficiency today.")
               .font(.caption).foregroundColor(.ccGold).italic()
           Text("ALT: RPO Bubble — if linebacker walks into box").font(.caption2).foregroundColor(.ccSubtext)
           Button("Dismiss") { withAnimation { showAISuggestion = false } }
               .font(.caption).foregroundColor(.ccSubtext)
       }
       .padding(14)
       .background(LinearGradient(colors: [Color.ccGreen.opacity(0.15), Color.ccCrimson.opacity(0.15)], startPoint: .leading, endPoint: .trailing))
       .cornerRadius(14)
       .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.ccGold.opacity(0.5), lineWidth: 1))
   }
}
 
struct PlayCard: View {
   var play: Play
   var isSelected: Bool
   var onTap: () -> Void
 
   var typeColor: Color {
       switch play.type {
       case "Pass": return .ccCrimson
       case "Run": return .ccGreen
       case "Defense": return .blue
       default: return .ccGold
       }
   }
 
   var body: some View {
       Button(action: onTap) {
           VStack(alignment: .leading, spacing: 0) {
               // Field Diagram
               ZStack(alignment: .topTrailing) {
                   Color(red: 0.04, green: 0.12, blue: 0.06)
                       .frame(height: 90)
                   // Simple field lines
                   VStack(spacing: 18) {
                       Spacer()
                       Rectangle().fill(Color.ccGreen.opacity(0.3)).frame(height: 1)
                       Rectangle().fill(Color.ccGreen.opacity(0.15)).frame(height: 1)
                       Spacer()
                   }
                   // Player dots
                   HStack(spacing: 10) {
                       ForEach(0..<5) { _ in
                           Circle().fill(Color.ccCrimson).frame(width: 10, height: 10)
                       }
                   }
                   .offset(y: 15)
                   // Type badge
                   Text(play.type)
                       .font(.caption2).fontWeight(.black).foregroundColor(.white)
                       .padding(.horizontal, 8).padding(.vertical, 3)
                       .background(typeColor).cornerRadius(4)
                       .padding(6)
               }
               .clipShape(RoundedCorner(radius: 10, corners: [.topLeft, .topRight]))
 
               VStack(alignment: .leading, spacing: 6) {
                   HStack {
                       Text(play.name).font(.subheadline).fontWeight(.bold)
                       Spacer()
                       Text("\(play.successRate)%")
                           .font(.subheadline).fontWeight(.black)
                           .foregroundColor(play.successRate >= 75 ? .ccGreen : play.successRate >= 60 ? .ccGold : .ccCrimson)
                   }
                   Text(play.formation).font(.caption).foregroundColor(.ccSubtext)
                   ScrollView(.horizontal, showsIndicators: false) {
                       HStack(spacing: 4) {
                           ForEach(play.tags, id: \.self) { tag in TagChip(label: tag) }
                       }
                   }
               }
               .padding(10)
           }
           .background(Color.ccSurface)
           .cornerRadius(12)
           .overlay(RoundedRectangle(cornerRadius: 12).stroke(isSelected ? Color.ccCrimson : Color.ccBorder, lineWidth: isSelected ? 2 : 1))
       }
       .buttonStyle(.plain)
   }
}
 
struct PlayDetailPanel: View {
   var play: Play
 
   var body: some View {
       VStack(alignment: .leading, spacing: 12) {
           Text(play.name).font(.title3).fontWeight(.black)
           Text(play.formation + " — " + play.type).font(.caption).foregroundColor(.ccSubtext)
 
           let stats = [("Success Rate", "\(play.successRate)%"), ("Avg Yards", "7.4 yds"), ("Times Called", "34x"), ("3rd Down Conv", "68%"), ("Red Zone", "71%")]
           ForEach(stats, id: \.0) { stat in
               HStack {
                   Text(stat.0).font(.subheadline).foregroundColor(.ccSubtext)
                   Spacer()
                   Text(stat.1).font(.subheadline).fontWeight(.bold).foregroundColor(.ccGreen)
               }
               Divider().background(Color.ccBorder)
           }
 
           HStack(spacing: 10) {
               Button("📎 Link to Film") {}
                   .font(.subheadline).fontWeight(.bold).foregroundColor(.white)
                   .frame(maxWidth: .infinity).padding(.vertical, 10)
                   .background(Color.ccGreen).cornerRadius(10)
               Button("📤 Export PDF") {}
                   .font(.subheadline).fontWeight(.bold).foregroundColor(.white)
                   .frame(maxWidth: .infinity).padding(.vertical, 10)
                   .background(Color.ccCrimson).cornerRadius(10)
           }
       }
       .padding(14)
       .background(Color.ccSurface)
       .cornerRadius(14)
       .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.ccBorder, lineWidth: 1))
   }
}