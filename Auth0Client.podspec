Pod::Spec.new do |s|
  s.name             = "Auth0Client"
  s.version          = "1.0.0-beta"
  s.summary          = "A library that uses Auth0 for Authentication with Native Look & Feel"
  s.description      = <<-DESC
[![Auth0](https://i.cloudup.com/1vaSVATKTL.png)](http://auth0.com)

Auth0 is a SaaS that helps you with Authentication and Authorization. You can use Social Providers (Like Facebook, Google, Twitter, etc.), Enterprise Providers (Active Directory, LDap, Windows Azure AD, SAML, etc.) and a Username/Password store which can be saved either by us or by you. We have SDKs for the most common platforms (Ruby, Node, iOS, Angular, etc.) so that with a couple lines of code, you can get the Authentication for your app implemented. Let us worry about Authentication so that you can focus on the core of your business.
                       DESC
  s.homepage         = "https://github.com/auth0/Auth0.iOS"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.authors          = { "Martin Gontovnikas" => "gonto@auth0.com" }, { "Hernan Zalazar" => "hernan.zalazar@gmail.com" }
  s.source           = { :git => "https://github.com/auth0/Auth0.iOS.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/authzero'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.dependency 'libextobjc', '~> 0.4'
  s.dependency 'CocoaLumberjack', '~> 1.9'
  s.default_subspecs = 'UI', 'Facebook', 'Twitter'
  s.prefix_header_contents = <<-EOS
    #import "A0Logging.h"
    #define A0LocalizedString(key) NSLocalizedStringFromTable(key, @"Auth0", nil)
  EOS
  s.subspec 'Core' do |core|
    core.public_header_files = 'Pod/Classes/Core/*.h'
    core.source_files = 'Pod/Classes/Core/*.{h,m}'
    core.dependency 'AFNetworking', '~> 2.3'
    core.dependency 'ISO8601DateFormatter', '~> 0.7'
    core.dependency 'UICKeyChainStore', '~> 1.0.5'
  end

  s.subspec 'UI' do |ui|
    ui.public_header_files = 'Pod/Classes/{UI,Utils}/*.h'
    ui.source_files = 'Pod/Classes/{UI,Utils}/*.{h,m}'
    ui.dependency 'Auth0Client/Provider'
    ui.resources = 'Pod/Assets/*.xib'
    ui.resource_bundles = { 'Auth0' => ['Pod/Assets/Images/*.png', 'Pod/Assets/*.plist', 'Pod/Assets/connections.ttf']}
  end

  s.subspec 'Provider' do |provider|
    provider.public_header_files = 'Pod/Classes/Provider/*.h'
    provider.source_files = 'Pod/Classes/Provider/*.{h,m}'
    provider.dependency 'Auth0Client/Core'
  end

  s.subspec 'Facebook' do |facebook|
    facebook.public_header_files = 'Pod/Classes/Provider/Facebook/*.h'
    facebook.source_files = 'Pod/Classes/Provider/Facebook/*.{h,m}'
    facebook.dependency 'Auth0Client/Provider'
    facebook.dependency 'Facebook-iOS-SDK', '~> 3.15'
  end

  s.subspec 'Twitter' do |twitter|
    twitter.public_header_files = 'Pod/Classes/Twitter/*.h'
    twitter.source_files = 'Pod/Classes/Provider/Twitter/*.{h,m}'
    twitter.dependency 'Auth0Client/Provider'
    twitter.dependency 'BDBOAuth1Manager', '~> 1.3'
    twitter.dependency 'TWReverseAuth', '~> 0.1.0'
    twitter.dependency 'PSAlertView', '~> 2.0'
    twitter.frameworks  = 'Social', 'Accounts', 'Twitter'
  end
end
