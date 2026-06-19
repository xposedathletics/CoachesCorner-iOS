// swift-tools-version:5.9
import PackageDescription
 
let package = Package(
   name: "CoachesCorner",
   platforms: [.iOS(.v17)],
   products: [
       .library(name: "CoachesCorner", targets: ["CoachesCorner"])
   ],
   targets: [
       .target(
           name: "CoachesCorner",
           path: "Sources"
       )
   ]
)