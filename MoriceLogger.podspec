Pod::Spec.new do |s|
  s.name             = 'MoriceLogger'
  s.version          = '1.0.1'
  s.summary          = 'MoriceLogger 是基于 SwiftyBeaver 的日志封装库'
  s.description      = <<-DESC
MoriceLogger 提供了统一的日志接口，基于 SwiftyBeaver 实现，支持控制台和文件输出，自动管理日志文件。
                       DESC

  s.homepage         = 'https://github.com/DeTong/MoriceLogger'
  s.license          = { :type => 'MIT' }
  s.author           = { 'DeTong' => 'gengdetong@sina.com' }
  s.source           = { :git => 'https://github.com/DeTong/MoriceLogger.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.4'
  s.swift_version = '5.0'

  s.source_files = 'MoriceLogger/Classes/**/*'
  
  s.dependency 'SwiftyBeaver', '~> 2.0'
end

