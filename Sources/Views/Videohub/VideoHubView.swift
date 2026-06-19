import SwiftUI
 
public struct VideoHubView: View {
   @State private var activeTab = 0
   @State private var selectedClip: VideoClip? = nil
   @State private var clips = SampleData.clips
   let tabs = ["Library", "AI Analysis", "Highlights", "Compare"]
 
   public init() {}
 
   public var body: some View {
       NavigationStack {
           ZStack { Color.ccDark.ignoresSafeArea()
               VStack(spacing: 0) {
                   CCHeader(title: "VIDEO HUB", subtitle: "AI Film Analysis — NFL Next Gen Stats Engine", icon: "🎬")
                   // Tabs
                   ScrollView(.horizontal, showsIndicators: false) {
                       HStack(spacing: 0) {
                           ForEach(Array(tabs.enumerated()), id: \.offset) { i, tab in
                               Button(tab) { activeTab = i }
                                   .font(.subheadline).fontWeight(.bold)
                                   .foregroundColor(activeTab == i ? .white : .ccSubtext)
                                   .padding(.vertical, 10).padding(.horizontal, 18)
                                   .background(activeTab == i ? Color.ccCrimson : Color.clear)
                           }
                       }
                       .background(Color.ccSurface)
                   }
                   Divider().background(Color.ccBorder)
 
                   ScrollView {
                       VStack(spacing: 14) {
                           // Camera platforms
                           cameraPlatformRow
                           // Clip grid
                           LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                               ForEach(clips) { clip in
                                   ClipCard(clip: clip, isSelected: selectedClip?.id == clip.id) {
                                       selectedClip = clip
                                   }
                               }
                           }
                       }
                       .padding(16)
                   }
               }
           }
           .navigationBarHidden(true)
           .sheet(item: $selectedClip) { clip in
               ClipAnalysisSheet(clip: clip)
           }
       }
   }
 
   var cameraPlatformRow: some View {
       ScrollView(.horizontal, showsIndicators: false) {
           HStack(spacing: 8) {
               ForEach(["🎥 Veo 3", "📡 Pixellot", "🏟️ Hudl Focus", "🔄 Reeplayer", "☁️ Spiideo", "📊 Catapult", "⌚ STATSports", "🏃 Polar Team"], id: \.self) { cam in
                   Text(cam)
                       .font(.caption).fontWeight(.semibold)
                       .foregroundColor(cam.contains("Veo") || cam.contains("Pixellot") ? .ccGreen : .ccSubtext)
                       .padding(.horizontal, 10).padding(.vertical, 6)
                       .background(cam.contains("Veo") || cam.contains("Pixellot") ? Color.ccGreen.opacity(0.15) : Color.ccDark)
                       .cornerRadius(8)
                       .overlay(RoundedRectangle(cornerRadius: 8).stroke(cam.contains("Veo") || cam.contains("Pixellot") ? Color.ccGreen.opacity(0.5) : Color.ccBorder, lineWidth: 1))
               }
           }
       }
   }
}
 
struct ClipCard: View {
   var clip: VideoClip
   var isSelected: Bool
   var onTap: () -> Void
 
   var gradeColor: Color {
       clip.aiGrade.hasPrefix("A") ? .ccGreen : clip.aiGrade.hasPrefix("B") ? .ccGold : .ccCrimson
   }
 
   var body: some View {
       Button(action: onTap) {
           VStack(alignment: .leading, spacing: 0) {
               // Thumbnail
               ZStack(alignment: .topLeading) {
                   LinearGradient(colors: [Color.ccCrimson.opacity(0.4), Color.ccGreen.opacity(0.4)],
                                  startPoint: .topLeading, endPoint: .bottomTrailing)
                       .frame(height: 100)
                   Text(clip.sport == "Football" ? "🏈" : clip.sport == "Basketball" ? "🏀" : "⚽")
                       .font(.largeTitle)
                       .frame(maxWidth: .infinity, maxHeight: .infinity)
                   GradeBadge(grade: clip.aiGrade)
                       .padding(6)
               }
               .frame(height: 100)
               .clipped()
               .cornerRadius(10, corners: [.topLeft, .topRight])
 
               VStack(alignment: .leading, spacing: 6) {
                   Text(clip.title).font(.caption).fontWeight(.bold).lineLimit(2)
                   Text(clip.sport + " • " + clip.date).font(.caption2).foregroundColor(.ccSubtext)
                   Text("🤖 " + clip.predictiveStat).font(.caption2).foregroundColor(.ccGold).lineLimit(2)
                   ScrollView(.horizontal, showsIndicators: false) {
                       HStack(spacing: 4) {
                           ForEach(clip.tags, id: \.self) { tag in TagChip(label: tag) }
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
 
struct ClipAnalysisSheet: View {
   var clip: VideoClip
   @Environment(\.dismiss) var dismiss
 
   var body: some View {
       NavigationStack {
           ZStack { Color.ccDark.ignoresSafeArea()
               ScrollView {
                   VStack(alignment: .leading, spacing: 16) {
                       // Thumbnail Hero
                       ZStack {
                           LinearGradient(colors: [Color.ccCrimson.opacity(0.5), Color.ccGreen.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing)
                           Text(clip.sport == "Football" ? "🏈" : clip.sport == "Basketball" ? "🏀" : "⚽")
                               .font(.system(size: 60))
                       }
                       .frame(height: 180)
                       .cornerRadius(14)
 
                       VStack(alignment: .leading, spacing: 4) {
                           Text(clip.title).font(.title3).fontWeight(.black)
                           Text(clip.sport + " • " + clip.date).font(.caption).foregroundColor(.ccSubtext)
                           Text("🤖 " + clip.predictiveStat).font(.caption).foregroundColor(.ccGold)
                       }
 
                       // NGS Metrics
                       VStack(alignment: .leading, spacing: 10) {
                           Text("⚡ NEXT GEN METRICS").font(.caption).fontWeight(.black).foregroundColor(.ccGold)
                           let metrics = [("Speed", "18.4 mph"), ("Acceleration", "9.2 ft/s²"), ("Separation", "3.1 yds"), ("Completion Prob", "87%"), ("Route Efficiency", "94%")]
                           ForEach(metrics, id: \.0) { m in
                               HStack {
                                   Text(m.0).font(.subheadline).foregroundColor(.ccSubtext)
                                   Spacer()
                                   Text(m.1).font(.subheadline).fontWeight(.bold).foregroundColor(.ccGreen)
                               }
                               Divider().background(Color.ccBorder)
                           }
                       }
                       .padding(14)
                       .background(Color.ccSurface)
                       .cornerRadius(12)
 
                       // Predictive Outcome
                       VStack(alignment: .leading, spacing: 6) {
                           Text("🎯 PREDICTIVE OUTCOME").font(.caption).fontWeight(.black).foregroundColor(.ccGreen)
                           Text("First Down — 89% probability").font(.subheadline).fontWeight(.bold)
                       }
                       .padding(14)
                       .frame(maxWidth: .infinity, alignment: .leading)
                       .background(Color.ccGreen.opacity(0.12))
                       .cornerRadius(12)
                       .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.ccGreen.opacity(0.4), lineWidth: 1))
 
                       // Next Play AI
                       VStack(alignment: .leading, spacing: 6) {
                           Text("⚡ AI PLAY SUGGESTION").font(.caption).fontWeight(.black).foregroundColor(.ccCrimson)
                           Text("Run Inside Zone — opponent will rotate to pass coverage").font(.subheadline)
                       }
                       .padding(14)
                       .frame(maxWidth: .infinity, alignment: .leading)
                       .background(Color.ccCrimson.opacity(0.12))
                       .cornerRadius(12)
                       .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.ccCrimson.opacity(0.4), lineWidth: 1))
                   }
                   .padding(16)
               }
           }
           .navigationTitle("NGS Analysis")
           .navigationBarTitleDisplayMode(.inline)
           .toolbar {
               ToolbarItem(placement: .navigationBarTrailing) {
                   Button("Done") { dismiss() }.foregroundColor(.ccCrimson)
               }
           }
       }
       .preferredColorScheme(.dark)
   }
}
 
extension View {
   func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
       clipShape(RoundedCorner(radius: radius, corners: corners))
   }
}
 
struct RoundedCorner: Shape {
   var radius: CGFloat; var corners: UIRectCorner
   func path(in rect: CGRect) -> Path {
       let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners,
                               cornerRadii: CGSize(width: radius, height: radius))
       return Path(path.cgPath)
   }
}