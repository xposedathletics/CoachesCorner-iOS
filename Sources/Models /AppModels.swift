import SwiftUI
 
// MARK: - Color Theme
public extension Color {
   static let ccCrimson   = Color(red: 0.545, green: 0.102, blue: 0.102) // #8B1A1A
   static let ccGreen     = Color(red: 0.102, green: 0.361, blue: 0.165) // #1A5C2A
   static let ccDark      = Color(red: 0.051, green: 0.051, blue: 0.051) // #0D0D0D
   static let ccSurface   = Color(red: 0.102, green: 0.102, blue: 0.102) // #1A1A1A
   static let ccBorder    = Color(red: 0.165, green: 0.165, blue: 0.165) // #2A2A2A
   static let ccGold      = Color(red: 0.788, green: 0.659, blue: 0.298) // #C9A84C
   static let ccText      = Color.white
   static let ccSubtext   = Color(white: 0.627)
}
 
// MARK: - Athlete Model
public struct Athlete: Identifiable {
   public let id = UUID()
   public var name: String
   public var sport: String
   public var position: String
   public var school: String
   public var gradYear: String
   public var overallGrade: Int
   public var speed: Int
   public var strength: Int
   public var explosiveness: Int
   public var iq: Int
   public var recruitingStatus: String
 
   public init(name: String, sport: String, position: String, school: String,
               gradYear: String, overallGrade: Int, speed: Int, strength: Int,
               explosiveness: Int, iq: Int, recruitingStatus: String) {
       self.name = name; self.sport = sport; self.position = position
       self.school = school; self.gradYear = gradYear; self.overallGrade = overallGrade
       self.speed = speed; self.strength = strength; self.explosiveness = explosiveness
       self.iq = iq; self.recruitingStatus = recruitingStatus
   }
}
 
// MARK: - Video Clip Model
public struct VideoClip: Identifiable {
   public let id = UUID()
   public var title: String
   public var sport: String
   public var duration: String
   public var date: String
   public var aiGrade: String
   public var predictiveStat: String
   public var tags: [String]
   public var playType: String
 
   public init(title: String, sport: String, duration: String, date: String,
               aiGrade: String, predictiveStat: String, tags: [String], playType: String) {
       self.title = title; self.sport = sport; self.duration = duration
       self.date = date; self.aiGrade = aiGrade; self.predictiveStat = predictiveStat
       self.tags = tags; self.playType = playType
   }
}
 
// MARK: - Play Model
public struct Play: Identifiable {
   public let id = UUID()
   public var name: String
   public var type: String
   public var formation: String
   public var successRate: Int
   public var tags: [String]
 
   public init(name: String, type: String, formation: String, successRate: Int, tags: [String]) {
       self.name = name; self.type = type; self.formation = formation
       self.successRate = successRate; self.tags = tags
   }
}
 
// MARK: - Channel Model
public struct TeamChannel: Identifiable {
   public let id = UUID()
   public var name: String
   public var icon: String
   public var unread: Int
   public var type: String
 
   public init(name: String, icon: String, unread: Int, type: String) {
       self.name = name; self.icon = icon; self.unread = unread; self.type = type
   }
}
 
// MARK: - Chat Message Model
public struct ChatMessage: Identifiable {
   public let id = UUID()
   public var from: String
   public var role: String   // "coach", "athlete", "ai"
   public var text: String
   public var time: String
 
   public init(from: String, role: String, text: String, time: String) {
       self.from = from; self.role = role; self.text = text; self.time = time
   }
}
 
// MARK: - AI Insight Model
public struct AIInsight: Identifiable {
   public let id = UUID()
   public var icon: String
   public var text: String
   public var type: String
 
   public init(icon: String, text: String, type: String) {
       self.icon = icon; self.text = text; self.type = type
   }
}
 
// MARK: - Scouting Night
public struct ScoutingNight: Identifiable {
   public let id = UUID()
   public var date: String
   public var event: String
   public var location: String
   public var sport: String
   public var priority: String
   public var reason: String
   public var athleteCount: Int
 
   public init(date: String, event: String, location: String, sport: String,
               priority: String, reason: String, athleteCount: Int) {
       self.date = date; self.event = event; self.location = location
       self.sport = sport; self.priority = priority; self.reason = reason
       self.athleteCount = athleteCount
   }
}
 
// MARK: - Play Log Entry
public struct PlayLogEntry: Identifiable {
   public let id = UUID()
   public var playType: String
   public var result: String
   public var player: String
   public var aiGrade: String
   public var time: String
 
   public init(playType: String, result: String, player: String, aiGrade: String, time: String) {
       self.playType = playType; self.result = result; self.player = player
       self.aiGrade = aiGrade; self.time = time
   }
}
 
// MARK: - Sample Data
public struct SampleData {
   public static let athletes: [Athlete] = [
       Athlete(name: "Marcus Johnson", sport: "Football", position: "WR", school: "Savannah HS", gradYear: "2025", overallGrade: 91, speed: 94, strength: 78, explosiveness: 88, iq: 90, recruitingStatus: "D1 Prospect"),
       Athlete(name: "Devon Carter", sport: "Football", position: "QB", school: "Beach HS", gradYear: "2025", overallGrade: 87, speed: 79, strength: 82, explosiveness: 84, iq: 95, recruitingStatus: "D1 Prospect"),
       Athlete(name: "Jaylen Simms", sport: "Basketball", position: "SG", school: "Islands HS", gradYear: "2026", overallGrade: 83, speed: 88, strength: 71, explosiveness: 91, iq: 82, recruitingStatus: "D2 Prospect"),
       Athlete(name: "Trey Washington", sport: "Football", position: "RB", school: "Richmond Hill HS", gradYear: "2025", overallGrade: 88, speed: 92, strength: 86, explosiveness: 90, iq: 80, recruitingStatus: "D1 Prospect"),
       Athlete(name: "Chris Evans", sport: "Soccer", position: "FW", school: "New Hampstead HS", gradYear: "2026", overallGrade: 79, speed: 86, strength: 68, explosiveness: 82, iq: 77, recruitingStatus: "NAIA Prospect"),
   ]
 
   public static let clips: [VideoClip] = [
       VideoClip(title: "Q1 — TD Drive #1", sport: "Football", duration: "3:42", date: "Jun 17", aiGrade: "A+", predictiveStat: "87% play success probability", tags: ["TD", "Pass", "Red Zone"], playType: "Pass"),
       VideoClip(title: "Defensive Stand — 4th & Goal", sport: "Football", duration: "1:18", date: "Jun 17", aiGrade: "A", predictiveStat: "91% stop probability vs this formation", tags: ["Defense", "Stop"], playType: "Defense"),
       VideoClip(title: "Fast Break — 3rd Period", sport: "Basketball", duration: "0:54", date: "Jun 16", aiGrade: "B+", predictiveStat: "74% scoring efficiency on transition", tags: ["Fast Break", "Score"], playType: "Offense"),
       VideoClip(title: "Corner Kick Routine", sport: "Soccer", duration: "2:10", date: "Jun 15", aiGrade: "A-", predictiveStat: "62% scoring probability from this setup", tags: ["Set Piece", "Corner"], playType: "Set Piece"),
   ]
 
   public static let plays: [Play] = [
       Play(name: "Mesh Concept", type: "Pass", formation: "Shotgun 2x2", successRate: 78, tags: ["Short", "Cross", "High%"]),
       Play(name: "Inside Zone", type: "Run", formation: "I-Form", successRate: 62, tags: ["Run", "Gap", "Goal Line"]),
       Play(name: "PA Flood Right", type: "Pass", formation: "Shotgun 3x1", successRate: 71, tags: ["Play Action", "Deep"]),
       Play(name: "RPO Bubble", type: "RPO", formation: "Spread 4x1", successRate: 84, tags: ["RPO", "Edge", "Quick"]),
       Play(name: "Cover 3 Match", type: "Defense", formation: "4-2-5", successRate: 69, tags: ["Zone", "Deep"]),
       Play(name: "Overload Blitz", type: "Defense", formation: "3-3-5", successRate: 73, tags: ["Pressure", "Blitz"]),
   ]
 
   public static let channels: [TeamChannel] = [
       TeamChannel(name: "Team General", icon: "megaphone.fill", unread: 2, type: "Team"),
       TeamChannel(name: "Offense Unit", icon: "bolt.fill", unread: 0, type: "Unit"),
       TeamChannel(name: "Defense Unit", icon: "shield.fill", unread: 1, type: "Unit"),
       TeamChannel(name: "Coaching Staff", icon: "person.3.fill", unread: 3, type: "Staff"),
       TeamChannel(name: "Parent Portal", icon: "house.fill", unread: 0, type: "Parents"),
       TeamChannel(name: "Scouting Room", icon: "magnifyingglass", unread: 1, type: "Scouts"),
   ]
 
   public static let messages: [ChatMessage] = [
       ChatMessage(from: "Coach Watson", role: "coach", text: "Watch the Q2 red zone film before Thursday practice. AI tagged 3 key adjustments.", time: "2:14 PM"),
       ChatMessage(from: "Marcus #12", role: "athlete", text: "Watched it coach — I see the leverage issue on the post routes", time: "2:31 PM"),
       ChatMessage(from: "AI Assistant", role: "ai", text: "📊 Film Assignment: 3 athletes have not watched the assigned clip. Sending reminder push notifications now.", time: "3:00 PM"),
       ChatMessage(from: "Coach Watson", role: "coach", text: "Practice tomorrow 4PM. Full pads. Bring the energy.", time: "3:45 PM"),
   ]
 
   public static let insights: [AIInsight] = [
       AIInsight(icon: "🎯", text: "3 athletes showing elite acceleration trends — scouting night recommended this week", type: "SCOUT"),
       AIInsight(icon: "⚡", text: "Win probability model: 2-minute drill efficiency is 67% — drill adjustment suggested", type: "GAMEPLAN"),
       AIInsight(icon: "🛡️", text: "Opponent tendency: 74% run rate on 3rd & short — load box coverage package", type: "DEFENSE"),
       AIInsight(icon: "📈", text: "Team speed avg up 8% this month — consider expanding perimeter route tree", type: "OFFENSE"),
       AIInsight(icon: "⚠️", text: "2 athletes flagged for elevated training load — reduce contact reps this week", type: "HEALTH"),
   ]
 
   public static let scoutingNights: [ScoutingNight] = [
       ScoutingNight(date: "Jun 20", event: "Regional Championships", location: "Savannah Civic Center", sport: "Basketball", priority: "HIGH", reason: "3 athletes trending elite — 94th percentile speed scores", athleteCount: 3),
       ScoutingNight(date: "Jun 25", event: "Summer Showcase", location: "Memorial Stadium", sport: "Football", priority: "CRITICAL", reason: "QB has 89% completion efficiency last 4 games — D1 prospect", athleteCount: 1),
       ScoutingNight(date: "Jul 3", event: "Travel League Finals", location: "GSU Sports Complex", sport: "Soccer", priority: "MEDIUM", reason: "Forward showing 71% goal probability on left-foot strikes", athleteCount: 2),
   ]
}