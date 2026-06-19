import SwiftUI
 
public struct ScoutingView: View {
   @State private var athletes = SampleData.athletes
   @State private var scoutingNights = SampleData.scoutingNights
   @State private var selectedAthlete: Athlete? = nil
   @State private var showReport = false
 
   public init() {}
 
   public var body: some View {
       NavigationStack {
           ZStack { Color.ccDark.ignoresSafeArea()
               VStack(spacing: 0) {
                   CCHeader(title: "SCOUTING INTELLIGENCE", subtitle: "AthleticPix + Predictive Scouting Nights + NFL-Grade Analysis", icon: "🔍")
                   ScrollView {
                       VStack(spacing: 14) {
                           scoutingNightsPanel
                           Text("ATHLETE ROSTER").font(.caption).fontWeight(.black).foregroundColor(.ccSubtext)
                               .frame(maxWidth: .infinity, alignment: .leading)
                           ForEach(athletes) { athlete in
                               AthleteRow(athlete: athlete, isSelected: selectedAthlete?.id == athlete.id) {
                                   selectedAthlete = athlete
                                   showReport = true
                               }
                           }
                       }
                       .padding(16)
                   }
               }
           }
           .navigationBarHidden(true)
           .sheet(isPresented: $showReport) {
               if let athlete = selectedAthlete {
                   ScoutingReportSheet(athlete: athlete)
               }
           }
       }
   }
 
   var scoutingNightsPanel: some View {
       VStack(alignment: .leading, spacing: 12) {
           HStack {
               Text("📅 AI-RECOMMENDED SCOUTING NIGHTS").font(.subheadline).fontWeight(.black)
               Spacer()
               Text("Proactive").font(.caption2).foregroundColor(.ccGold)
           }
           ForEach(scoutingNights) { night in
               ScoutingNightCard(night: night)
           }
       }
       .padding(14)
       .background(Color.ccSurface)
       .cornerRadius(16)
       .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.ccBorder, lineWidth: 1))
   }
}
 
struct AthleteRow: View {
   var athlete: Athlete
   var isSelected: Bool
   var onTap: () -> Void
 
   var body: some View {
       Button(action: onTap) {
           HStack(spacing: 12) {
               ZStack {
                   Circle().fill(LinearGradient(colors: [Color.ccCrimson, Color.ccGreen], startPoint: .topLeading, endPoint: .bottomTrailing))
                       .frame(width: 44, height: 44)
                   Text(String(athlete.name.prefix(1))).font(.headline).fontWeight(.black).foregroundColor(.white)
               }
               VStack(alignment: .leading, spacing: 3) {
                   Text(athlete.name).font(.subheadline).fontWeight(.bold)
                   Text(athlete.sport + " • " + athlete.position + " • " + athlete.school).font(.caption).foregroundColor(.ccSubtext)
                   Text(athlete.recruitingStatus).font(.caption2).foregroundColor(.ccGold)
               }
               Spacer()
               VStack(alignment: .trailing, spacing: 2) {
                   Text("\(athlete.overallGrade)").font(.title2).fontWeight(.black)
                       .foregroundColor(athlete.overallGrade >= 90 ? .ccGreen : athlete.overallGrade >= 80 ? .ccGold : .ccCrimson)
                   Text("Overall").font(.caption2).foregroundColor(.ccSubtext)
               }
               Image(systemName: "chevron.right").foregroundColor(.ccSubtext).font(.caption)
           }
           .padding(14)
           .background(isSelected ? Color.ccCrimson.opacity(0.15) : Color.ccSurface)
           .cornerRadius(12)
           .overlay(RoundedRectangle(cornerRadius: 12).stroke(isSelected ? Color.ccCrimson : Color.ccBorder, lineWidth: 1))
       }
       .buttonStyle(.plain)
   }
}
 
struct ScoutingNightCard: View {
   var night: ScoutingNight
 
   var body: some View {
       HStack(alignment: .top, spacing: 12) {
           VStack {
               Text(night.date).font(.caption).fontWeight(.black).foregroundColor(.ccGold)
           }
           .frame(width: 44)
           VStack(alignment: .leading, spacing: 4) {
               HStack {
                   Text(night.event).font(.subheadline).fontWeight(.bold)
                   Spacer()
                   PriorityBadge(priority: night.priority)
               }
               Text(night.location).font(.caption).foregroundColor(.ccSubtext)
               Text(night.sport + " • \(night.athleteCount) athlete\(night.athleteCount > 1 ? "s" : "")").font(.caption2).foregroundColor(.blue)
               Text("🤖 " + night.reason).font(.caption2).foregroundColor(.ccGold).italic()
           }
       }
       .padding(12)
       .background(Color.ccDark)
       .cornerRadius(10)
   }
}
 
struct ScoutingReportSheet: View {
   var athlete: Athlete
   @Environment(\.dismiss) var dismiss
   let colleges = ["University of Georgia", "Georgia Tech", "Florida State", "Clemson"]
 
   var body: some View {
       NavigationStack {
           ZStack { Color.ccDark.ignoresSafeArea()
               ScrollView {
                   VStack(alignment: .leading, spacing: 16) {
                       // Hero
                       ZStack {
                           LinearGradient(colors: [Color.ccCrimson, Color.ccGreen], startPoint: .leading, endPoint: .trailing)
                           VStack(spacing: 4) {
                               Text(String(athlete.name.prefix(1))).font(.system(size: 50, weight: .black)).foregroundColor(.white)
                               Text(athlete.name).font(.title2).fontWeight(.black).foregroundColor(.white)
                               Text(athlete.school + " • Class of " + athlete.gradYear).font(.caption).foregroundColor(.white.opacity(0.7))
                               Text("🏆 " + athlete.recruitingStatus).font(.caption).fontWeight(.bold).foregroundColor(.ccGold)
                           }
                       }
                       .frame(height: 150)
                       .cornerRadius(14)
 
                       // Comparable
                       HStack {
                           Text("🏈 Comparable Pro:").font(.caption).foregroundColor(.ccSubtext)
                           Text("Justin Jefferson (81% film similarity)").font(.caption).fontWeight(.bold).foregroundColor(.ccGold)
                       }
                       .padding(12)
                       .background(Color.ccSurface).cornerRadius(10)
 
                       // Score bars
                       VStack(alignment: .leading, spacing: 10) {
                           Text("📊 PERFORMANCE METRICS").font(.caption).fontWeight(.black).foregroundColor(.ccGold)
                           metricBar("Speed", value: Double(athlete.speed) / 100.0, score: athlete.speed)
                           metricBar("Strength", value: Double(athlete.strength) / 100.0, score: athlete.strength)
                           metricBar("Explosiveness", value: Double(athlete.explosiveness) / 100.0, score: athlete.explosiveness)
                           metricBar("Football IQ", value: Double(athlete.iq) / 100.0, score: athlete.iq)
                       }
                       .padding(14).background(Color.ccSurface).cornerRadius(12)
 
                       // AI Recommendations
                       VStack(alignment: .leading, spacing: 8) {
                           Text("🤖 AI RECRUITING RECOMMENDATIONS").font(.caption).fontWeight(.black).foregroundColor(.ccGreen)
                           Text("→ Schedule D1 showcase — peak performance window next 3 weeks").font(.caption)
                           Divider().background(Color.ccBorder)
                           Text("→ Highlight reel should feature route versatility as primary differentiator").font(.caption)
                           Divider().background(Color.ccBorder)
                           Text("→ Increase 40-yard dash training — currently 4.51, target 4.45 for elite interest").font(.caption)
                       }
                       .padding(14).background(Color.ccGreen.opacity(0.12)).cornerRadius(12)
                       .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.ccGreen.opacity(0.4), lineWidth: 1))
 
                       // College Matches
                       VStack(alignment: .leading, spacing: 8) {
                           Text("🎓 AI-MATCHED COLLEGES").font(.caption).fontWeight(.black).foregroundColor(.ccSubtext)
                           LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                               ForEach(colleges, id: \.self) { college in
                                   Text(college).font(.caption).fontWeight(.semibold)
                                       .padding(10).frame(maxWidth: .infinity)
                                       .background(Color.ccSurface).cornerRadius(8)
                                       .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.ccBorder, lineWidth: 1))
                               }
                           }
                       }
                   }
                   .padding(16)
               }
           }
           .navigationTitle(athlete.name)
           .navigationBarTitleDisplayMode(.inline)
           .toolbar {
               ToolbarItem(placement: .navigationBarTrailing) {
                   Button("Done") { dismiss() }.foregroundColor(.ccCrimson)
               }
           }
       }
       .preferredColorScheme(.dark)
   }
 
   func metricBar(_ label: String, value: Double, score: Int) -> some View {
       VStack(alignment: .leading, spacing: 4) {
           HStack {
               Text(label).font(.subheadline).foregroundColor(.ccSubtext)
               Spacer()
               Text("\(score)").font(.subheadline).fontWeight(.black)
                   .foregroundColor(score >= 90 ? .ccGreen : score >= 80 ? .ccGold : .ccCrimson)
           }
           CCProgressBar(value: value, color: score >= 90 ? .ccGreen : score >= 80 ? .ccGold : .ccCrimson)
       }
   }
}