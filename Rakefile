#!/usr/bin/env ruby

require 'xcodeproj'
require 'pry'

def add_system_frameworks(target, names)

	build_phase = target.frameworks_build_phase
	framework_group = target.project.frameworks_group

	names.each do |name|
		path = "System/Library/Frameworks/#{name}.framework"
		file_ref = framework_group.new_reference(path)
		file_ref.name = "#{name}.framework"
		file_ref.source_tree = 'SDKROOT'
		build_file = build_phase.add_file_reference(file_ref)
	end

end


task :xcodeproj do
  system "swift package generate-xcodeproj"

  project = Xcodeproj::Project.open(Dir["*.xcodeproj"].first)
  project.build_configurations.each { |config|
    config.build_settings["SDKROOT"] = "iphoneos"
    config.build_settings.delete("SUPPORTED_PLATFORMS")
  }

  target = project.targets.select {|t|t.name=="MIKMIDI"}.first
  add_system_frameworks(target, ["CoreMIDI", "AudioToolbox", "UIKit"])

  project.save

end
