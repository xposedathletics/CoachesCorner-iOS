import SwiftUI
 
public struct TeamCommsView: View {
   @State private var channels = SampleData.channels
   @State private var activeChannel: TeamChannel? = SampleData.channels.first
   @State private var messages = SampleData.messages
   @State private var newMessage = ""
 
   public init() {}
 
   public var body: some View {
       NavigationStack {
           ZStack { Color.ccDark.ignoresSafeArea()
               VStack(spacing: 0) {
                   CCHeader(title: "TEAM COMMUNICATIONS", subtitle: "SportsYou-Level Messaging — Film Assignments — Parent Portal", icon: "📡")
 
                   // Channel selector
                   ScrollView(.horizontal, showsIndicators: false) {
                       HStack(spacing: 8) {
                           ForEach(channels) { channel in
                               Button(action: { activeChannel = channel }) {
                                   HStack(spacing: 5) {
                                       Image(systemName: channel.icon).font(.caption)
                                       Text(channel.name).font(.caption).fontWeight(activeChannel?.id == channel.id ? .bold : .regular)
                                       if channel.unread > 0 {
                                           Text("\(channel.unread)")
                                               .font(.caption2).fontWeight(.black)
                                               .foregroundColor(.white)
                                               .frame(width: 16, height: 16)
                                               .background(Color.ccCrimson)
                                               .clipShape(Circle())
                                       }
                                   }
                                   .foregroundColor(.white)
                                   .padding(.horizontal, 12).padding(.vertical, 7)
                                   .background(activeChannel?.id == channel.id ? Color.ccCrimson : Color.ccSurface)
                                   .cornerRadius(20)
                                   .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.ccBorder, lineWidth: 1))
                               }
                           }
                       }
                       .padding(.horizontal, 16).padding(.vertical, 10)
                   }
                   .background(Color.ccSurface)
 
                   // Channel Header
                   if let ch = activeChannel {
                       HStack {
                           Image(systemName: ch.icon)
                           Text(ch.name).font(.subheadline).fontWeight(.bold)
                           Text("• 22 members").font(.caption).foregroundColor(.ccSubtext)
                           Spacer()
                           Button("📎 Film") {}
                               .font(.caption2).foregroundColor(.ccSubtext)
                               .padding(.horizontal, 8).padding(.vertical, 4)
                               .background(Color.ccSurface).cornerRadius(6)
                           Button("📅 Schedule") {}
                               .font(.caption2).foregroundColor(.ccSubtext)
                               .padding(.horizontal, 8).padding(.vertical, 4)
                               .background(Color.ccSurface).cornerRadius(6)
                       }
                       .padding(.horizontal, 16).padding(.vertical, 8)
                       .background(Color.ccDark)
                   }
                   Divider().background(Color.ccBorder)
 
                   // Messages
                   ScrollView {
                       LazyVStack(spacing: 12) {
                           ForEach(messages) { msg in
                               MessageRow(message: msg)
                           }
                       }
                       .padding(16)
                   }
 
                   // Input bar
                   inputBar
               }
           }
           .navigationBarHidden(true)
       }
   }
 
   var inputBar: some View {
       HStack(spacing: 10) {
           HStack(spacing: 8) {
               TextField("Message team...", text: $newMessage)
                   .foregroundColor(.white)
                   .submitLabel(.send)
                   .onSubmit { sendMessage() }
               Button(action: {}) { Image(systemName: "paperclip").foregroundColor(.ccSubtext) }
               Button(action: {}) { Image(systemName: "film").foregroundColor(.ccSubtext) }
           }
           .padding(.horizontal, 14).padding(.vertical, 10)
           .background(Color.ccDark)
           .cornerRadius(12)
           .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.ccBorder, lineWidth: 1))
 
           Button(action: sendMessage) {
               Image(systemName: "arrow.up.circle.fill")
                   .font(.title2)
                   .foregroundStyle(LinearGradient(colors: [Color.ccCrimson, Color.ccGreen], startPoint: .top, endPoint: .bottom))
           }
       }
       .padding(.horizontal, 16).padding(.vertical, 12)
       .background(Color.ccSurface)
   }
 
   func sendMessage() {
       guard !newMessage.trimmingCharacters(in: .whitespaces).isEmpty else { return }
       let now = Date()
       let formatter = DateFormatter()
       formatter.timeStyle = .short
       messages.append(ChatMessage(from: "Coach Watson", role: "coach", text: newMessage, time: formatter.string(from: now)))
       newMessage = ""
   }
}
 
struct MessageRow: View {
   var message: ChatMessage
 
   var avatarColor: Color {
       switch message.role {
       case "coach": return .ccCrimson
       case "ai": return .blue
       default: return .ccGreen
       }
   }
 
   var avatarLabel: String {
       message.role == "ai" ? "🤖" : String(message.from.prefix(1))
   }
 
   var nameColor: Color {
       switch message.role {
       case "coach": return .ccCrimson
       case "ai": return .blue
       default: return .ccGreen
       }
   }
 
   var body: some View {
       HStack(alignment: .top, spacing: 10) {
           ZStack {
               Circle().fill(avatarColor).frame(width: 36, height: 36)
               Text(avatarLabel).font(.subheadline).fontWeight(.bold).foregroundColor(.white)
           }
           VStack(alignment: .leading, spacing: 4) {
               HStack(spacing: 8) {
                   Text(message.from).font(.caption).fontWeight(.bold).foregroundColor(nameColor)
                   Text(message.time).font(.caption2).foregroundColor(.ccSubtext)
                   if message.role == "coach" {
                       Text("✓✓").font(.caption2).foregroundColor(.ccGreen)
                   }
               }
               Text(message.text)
                   .font(.subheadline)
                   .foregroundColor(.white)
                   .fixedSize(horizontal: false, vertical: true)
                   .padding(12)
                   .background(Color.ccSurface)
                   .cornerRadius(12)
                   .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.ccBorder, lineWidth: 1))
           }
           Spacer()
       }
   }
}