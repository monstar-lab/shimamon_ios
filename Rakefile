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
  app.identifier = 'com.monstar-lab.shimane.shimamon'
  app.pods do
    pod 'AFNetworking'
  end
  app.icons = ['icon-29.png', 'icon-29@2x.png', 'icon-29@3x.png', 'icon-40@3x.png', 'icon-60@3x.png', 'icon-76.png', 'icon-76@2x.png']
  app.device_family = [:iphone, :ipad]
  app.provisioning_profile = '/Users/bp/Library/MobileDevice/Provisioning Profiles/d91265d6-5f31-40f7-b8ae-6308f8388a4c.mobileprovision'
  app.info_plist['NSAppTransportSecurity'] = { 'NSAllowsArbitraryLoads' => true }
end
