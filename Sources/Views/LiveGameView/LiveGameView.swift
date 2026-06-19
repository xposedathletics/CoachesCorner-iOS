import SwiftUI
 
public struct LiveGameView: View {
   @State private var homeScore = 14
   @State private var awayScore = 10
   @State private var quarter = 3
   @State private var clockMin = 8
   @State private var clockSec = 42
   @State private var down = 2
   @State private var distance = 7
   @State private var winProb: Double = 0.67
   @State private var clockRunning = false
   @State private var timeoutHome = 3
   @State private var timeoutAway = 2
   @State private var plays: [PlayLogEntry] = [
       PlayLogEntry(playType: "Pass", result: "+12 yds", player: "#12", aiGrade: "A", time: "Q3 9:15"),
       PlayLogEntry(playType: "Run", result: "+4 yds", player: "#23", aiGrade: "B+", time: "Q3 9:02"),
       PlayLogEntry(playType: "Pass", result: "Incomplete", player: "#12", aiGrade: "C+", time: "Q3 8:55"),
   ]
   @State private var aiPlay = "Mesh Concept"
   @State private var aiFormation = "Shotgun 2x2"
   @State private var aiConfidence = 84
   @State private var aiType = "OFFENSE"
   @State private var aiReason = "Opponent CB has been beaten on crossing routes 3x in Q1-Q2"
   let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
 
   public init() {}
 
   public var body: some View {
       NavigationStack {
           ZStack { Color.ccDark.ignoresSafeArea()
               VStack(spacing: 0) {
                   scoreboardSection
                   ScrollView {
                       VStack(spacing: 14) {
                           aiCallPanel
                           scoreButtons
                           downDistanceControl
                           playLog
                           playerGrades
                       }
                       .padding(16)
                   }
               }
           }
           .navigationBarHidden(true)
           .onReceive(timer) { _ in
               if clockRunning { tickClock() }
           }
       }
   }
 
   var scoreboardSection: some View {
       ZStack {
           Color.black
           VStack(spacing: 10) {
               HStack(spacing: 0) {
                   // Home
                   VStack(spacing: 4) {
                       Text("HOME").font(.caption2).kerning(2).foregroundColor(.ccSubtext)
                       Text("\(homeScore)").font(.system(size: 56, weight: .black)).foregroundColor(.ccCrimson)
                       Text("EAGLES").font(.caption).fontWeight(.bold)
                       timeoutDots(count: timeoutHome, color: .ccCrimson)
                   }
                   .frame(maxWidth: .infinity)
 
                   // Clock
                   VStack(spacing: 4) {
                       Text("Q\(quarter)").font(.caption).fontWeight(.black).foregroundColor(.ccSubtext)
                       Text(String(format: "%02d:%02d", clockMin, clockSec))
                           .font(.system(size: 36, weight: .black, design: .monospaced))
                           .foregroundColor(clockRunning ? .ccGreen : .white)
                       Button(clockRunning ? "⏸ PAUSE" : "▶ START") {
                           clockRunning.toggle()
                       }
                       .font(.caption2).fontWeight(.black)
                       .foregroundColor(.white)
                       .padding(.horizontal, 14).padding(.vertical, 6)
                       .background(clockRunning ? Color.ccCrimson : Color.ccGreen)
                       .cornerRadius(20)
                       Text("\(down)\(downSuffix(down)) & \(distance)")
                           .font(.caption).foregroundColor(.ccSubtext)
                   }
                   .frame(maxWidth: .infinity)
 
                   // Away
                   VStack(spacing: 4) {
                       Text("AWAY").font(.caption2).kerning(2).foregroundColor(.ccSubtext)
                       Text("\(awayScore)").font(.system(size: 56, weight: .black)).foregroundColor(.ccGreen)
                       Text("TITANS").font(.caption).fontWeight(.bold)
                       timeoutDots(count: timeoutAway, color: .ccGreen)
                   }
                   .frame(maxWidth: .infinity)
               }
               // Win Prob Bar
               VStack(spacing: 4) {
                   HStack {
                       Text("HOME \(Int(winProb*100))%").font(.caption2).fontWeight(.bold).foregroundColor(.ccCrimson)
                       Spacer()
                       Text("AWAY \(Int((1-winProb)*100))%").font(.caption2).fontWeight(.bold).foregroundColor(.ccGreen)
                   }
                   GeometryReader { geo in
                       ZStack(alignment: .leading) {
                           RoundedRectangle(cornerRadius: 4).fill(Color.ccGreen).frame(height: 8)
                           RoundedRectangle(cornerRadius: 4).fill(Color.ccCrimson).frame(width: geo.size.width * winProb, height: 8)
                       }
                   }.frame(height: 8)
               }
               .padding(.horizontal, 20)
           }
           .padding(.vertical, 14)
       }
   }
 
   var aiCallPanel: some View {
       VStack(alignment: .leading, spacing: 10) {
           HStack {
               Text("🤖 AI CALL OF THE DOWN").font(.subheadline).fontWeight(.black)
               Spacer()
               Text("\(aiConfidence)% CONF").font(.caption2).fontWeight(.black)
                   .foregroundColor(.ccGold)
                   .padding(.horizontal, 8).padding(.vertical, 3)
                   .background(Color.ccGold.opacity(0.15))
                   .cornerRadius(4)
           }
           HStack(spacing: 10) {
               Text(aiType)
                   .font(.caption).fontWeight(.black).foregroundColor(.white)
                   .padding(.horizontal, 10).padding(.vertical, 6)
                   .background(aiType == "OFFENSE" ? Color.ccCrimson : Color.ccGreen)
                   .cornerRadius(8)
               VStack(alignment: .leading, spacing: 2) {
                   Text(aiPlay).font(.title3).fontWeight(.black)
                   Text(aiFormation).font(.caption).foregroundColor(.ccSubtext)
               }
           }
           Text("📊 " + aiReason).font(.caption).foregroundColor(.ccGold).italic()
           HStack(spacing: 10) {
               Button("✓ ACCEPT") {}
                   .font(.subheadline).fontWeight(.bold).foregroundColor(.white)
                   .frame(maxWidth: .infinity).padding(.vertical, 10)
                   .background(Color.ccGreen).cornerRadius(10)
               Button("↻ NEW") { generateAICall() }
                   .font(.subheadline).fontWeight(.bold).foregroundColor(.white)
                   .frame(maxWidth: .infinity).padding(.vertical, 10)
                   .background(Color.ccSurface)
                   .cornerRadius(10)
                   .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.ccBorder, lineWidth: 1))
           }
       }
       .padding(16)
       .background(LinearGradient(colors: [Color.ccCrimson.opacity(0.2), Color.ccGreen.opacity(0.2)], startPoint: .leading, endPoint: .trailing))
       .cornerRadius(16)
       .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.ccCrimson.opacity(0.5), lineWidth: 1))
   }
 
   var scoreButtons: some View {
       HStack(spacing: 12) {
           scoreTeamPanel(label: "HOME", color: .ccCrimson) { pts in
               homeScore += pts
               winProb = min(0.95, winProb + Double(pts) * 0.01)
           }
           scoreTeamPanel(label: "AWAY", color: .ccGreen) { pts in
               awayScore += pts
               winProb = max(0.05, winProb - Double(pts) * 0.01)
           }
       }
   }
 
   func scoreTeamPanel(label: String, color: Color, onScore: @escaping (Int) -> Void) -> some View {
       VStack(alignment: .leading, spacing: 8) {
           Text(label + " SCORE").font(.caption2).fontWeight(.bold).foregroundColor(.ccSubtext)
           HStack(spacing: 6) {
               ForEach([("TD",6),("FG",3),("2PT",2),("XP",1)], id: \.0) { s in
                   Button(action: { onScore(s.1) }) {
                       VStack(spacing: 1) {
                           Text(s.0).font(.caption2).fontWeight(.black)
                           Text("+\(s.1)").font(.system(size: 9))
                       }
                       .foregroundColor(.white)
                       .frame(maxWidth: .infinity).padding(.vertical, 8)
                       .background(color.opacity(0.25))
                       .cornerRadius(8)
                       .overlay(RoundedRectangle(cornerRadius: 8).stroke(color.opacity(0.6), lineWidth: 1))
                   }
               }
           }
       }
       .padding(12)
       .background(Color.ccSurface)
       .cornerRadius(14)
       .frame(maxWidth: .infinity)
   }
 
   var downDistanceControl: some View {
       HStack(spacing: 12) {
           VStack(alignment: .leading, spacing: 8) {
               Text("DOWN").font(.caption2).fontWeight(.bold).foregroundColor(.ccSubtext)
               HStack(spacing: 6) {
                   ForEach(1...4, id: \.self) { d in
                       Button("\(d)") { down = d }
                           .font(.subheadline).fontWeight(.bold).foregroundColor(.white)
                           .frame(maxWidth: .infinity).padding(.vertical, 8)
                           .background(down == d ? Color.ccCrimson : Color.ccBorder)
                           .cornerRadius(8)
                   }
               }
           }
           VStack(alignment: .leading, spacing: 8) {
               Text("DISTANCE").font(.caption2).fontWeight(.bold).foregroundColor(.ccSubtext)
               HStack(spacing: 10) {
                   Button(action: { if distance > 1 { distance -= 1 } }) {
                       Text("−").font(.title3).fontWeight(.black).foregroundColor(.white)
                           .frame(width: 36, height: 36).background(Color.ccBorder).cornerRadius(8)
                   }
                   Text("\(distance)").font(.title2).fontWeight(.black).frame(minWidth: 30)
                   Button(action: { distance += 1 }) {
                       Text("+").font(.title3).fontWeight(.black).foregroundColor(.white)
                           .frame(width: 36, height: 36).background(Color.ccBorder).cornerRadius(8)
                   }
               }
           }
       }
       .padding(14)
       .background(Color.ccSurface)
       .cornerRadius(14)
   }
 
   var playLog: some View {
       VStack(alignment: .leading, spacing: 10) {
           HStack {
               Text("📋 PLAY LOG").font(.subheadline).fontWeight(.black)
               Spacer()
               Button("+ LOG") { addPlay() }
                   .font(.caption).fontWeight(.bold).foregroundColor(.white)
                   .padding(.horizontal, 12).padding(.vertical, 5)
                   .background(Color.ccCrimson).cornerRadius(20)
           }
           ForEach(plays.reversed()) { play in
               HStack {
                   VStack(alignment: .leading, spacing: 2) {
                       Text(play.playType + " — " + play.result).font(.subheadline).fontWeight(.bold)
                       Text("Player " + play.player + " • " + play.time).font(.caption).foregroundColor(.ccSubtext)
                   }
                   Spacer()
                   GradeBadge(grade: play.aiGrade)
               }
               .padding(.vertical, 4)
               Divider().background(Color.ccBorder)
           }
       }
       .padding(14)
       .background(Color.ccSurface)
       .cornerRadius(14)
   }
 
   var playerGrades: some View {
       VStack(alignment: .leading, spacing: 10) {
           Text("⭐ LIVE PLAYER GRADES").font(.subheadline).fontWeight(.black)
           let players = [("QB #12","QB",91,"↑"),("RB #23","RB",84,"→"),("WR #1","WR",88,"↑"),("OL #75","OL",72,"↓"),("DE #91","DE",95,"↑")]
           ForEach(players, id: \.0) { player in
               HStack {
                   VStack(alignment: .leading, spacing: 2) {
                       Text(player.0).font(.subheadline).fontWeight(.bold)
                       Text(player.1).font(.caption).foregroundColor(.ccSubtext)
                   }
                   Spacer()
                   Text(player.3)
                       .foregroundColor(player.3 == "↑" ? .ccGreen : player.3 == "↓" ? .ccCrimson : .ccSubtext)
                   Text("\(player.2)")
                       .font(.title3).fontWeight(.black)
                       .foregroundColor(player.2 >= 90 ? .ccGreen : player.2 >= 80 ? .ccGold : .ccCrimson)
               }
               Divider().background(Color.ccBorder)
           }
       }
       .padding(14)
       .background(Color.ccSurface)
       .cornerRadius(14)
   }
 
   // MARK: - Helpers
   func timeoutDots(count: Int, color: Color) -> some View {
       HStack(spacing: 4) {
           ForEach(0..<3) { i in
               Circle().fill(i < count ? color : Color.ccBorder).frame(width: 10, height: 10)
           }
       }
   }
 
   func downSuffix(_ d: Int) -> String {
       switch d { case 1: return "st"; case 2: return "nd"; case 3: return "rd"; default: return "th" }
   }
 
   func tickClock() {
       if clockSec == 0 {
           if clockMin == 0 { clockRunning = false; return }
           clockMin -= 1; clockSec = 59
       } else { clockSec -= 1 }
   }
 
   func addPlay() {
       let types = ["Pass","Run","Screen","RPO"]
       let results = ["+8 yds","+3 yds","Incomplete","+15 yds","Sack -5"]
       let grades = ["A","B+","B","C+","A-"]
       plays.append(PlayLogEntry(
           playType: types.randomElement()!,
           result: results.randomElement()!,
           player: "#\(Int.random(in: 1...90))",
           aiGrade: grades.randomElement()!,
           time: "Q\(quarter) \(String(format: "%02d:%02d", clockMin, clockSec))"
       ))
   }
 
   func generateAICall() {
       let calls = [
           ("OFFENSE","Mesh Concept","Shotgun 2x2",84,"CB #24 beaten on crossing routes 3x"),
           ("DEFENSE","Cover 3 Buzz","4-2-5 Nickel",78,"Opponent runs slant/flat on 2nd & medium 71% of the time"),
           ("OFFENSE","RPO Bubble","Spread 4x1",81,"LB walking into box — perimeter is open"),
       ]
       let c = calls.randomElement()!
       aiType = c.0; aiPlay = c.1; aiFormation = c.2; aiConfidence = c.3; aiReason = c.4
   }
}