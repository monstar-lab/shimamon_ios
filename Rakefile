# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'しまもん'
  app.version = '1.0'
  app.identifier = 'com.hasumikin.shimamon'
  app.pods do
    pod 'AFNetworking'
  end
  app.icons = ['icon-29.png', 'icon-29@2x.png', 'icon-29@3x.png', 'icon-40@3x.png', 'icon-60@3x.png', 'icon-76.png', 'icon-76@2x.png']
  app.device_family = [:iphone, :ipad]
  app.codesign_certificate = "iPhone Developer: hasumikin@gmail.com (2HLAHTGHF8)"
  app.provisioning_profile = '~/Library/MobileDevice/Provisioning Profiles/5bd7a6dc-3061-487c-9357-4859a242c490.mobileprovision'
  app.info_plist['NSAppTransportSecurity'] = { 'NSAllowsArbitraryLoads' => true }
end

