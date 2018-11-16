source 'git@github.com:bbc/map-ios-podspecs.git'
source 'https://github.com/CocoaPods/Specs.git'

inhibit_all_warnings!

def smp
    pod 'smp-ios', '32.5.1'
end

target 'MediaPlayback' do
    use_frameworks!
    
    project 'VideoPlayback/MediaPlayback/MediaPlayback'
    
    smp

end

workspace 'SMPAugmented.xcworkspace'
