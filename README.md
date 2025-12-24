# MoriceLogger

[![Version](https://img.shields.io/cocoapods/v/MoriceLogger.svg?style=flat)](https://cocoapods.org/pods/MoriceLogger)
[![License](https://img.shields.io/cocoapods/l/MoriceLogger.svg?style=flat)](https://cocoapods.org/pods/MoriceLogger)
[![Platform](https://img.shields.io/cocoapods/p/MoriceLogger.svg?style=flat)](https://cocoapods.org/pods/MoriceLogger)

MoriceLogger 是基于 SwiftyBeaver 的日志封装库，提供了统一的日志接口，支持控制台和文件输出，自动管理日志文件。

## 功能特性

- 📝 统一的日志接口
- 📁 自动文件日志管理
- 🗑️ 自动清理旧日志文件（默认保留最新15个）
- 📊 支持多种日志级别：verbose, debug, info, warning, error, critical, fault
- 🏷️ 支持标签（tag）功能

## 安装

### CocoaPods

MoriceLogger 可以通过 [CocoaPods](https://cocoapods.org) 安装。在你的 `Podfile` 中添加：

```ruby
pod 'MoriceLogger'
```

然后运行：

```bash
pod install
```

## 使用方法

### 导入模块

```swift
import MoriceLogger
```

### 基本使用

```swift
// 使用全局函数
SLogVerbose("这是一条详细日志")
SLogDebug("这是一条调试日志")
SLogInfo("这是一条信息日志")
SLogWarning("这是一条警告日志")
SLogError("这是一条错误日志")
SLogCritical("这是一条严重日志")
SLogFault("这是一条故障日志")

// 带标签的日志
SLogInfo("用户登录成功", tag: "Auth")
SLogError("网络请求失败", tag: "Network")
```

### 查看日志信息

```swift
// 显示日志配置信息
MoriceLoggerManage.shared.showInfo()
```

### 上传日志文件

```swift
// 上传日志文件（需要实现具体逻辑）
MoriceLoggerManage.shared.uploadLoggerFile()
```

## 日志文件位置

日志文件默认保存在：

```
Documents/com.morice.logger/morice_log_yyyy-MM-dd.log
```

## 自定义实现

如果需要自定义日志实现，可以实现 `MoriceLogger` 协议：

```swift
class CustomLogger: MoriceLogger {
    // 实现协议方法
}

// 设置自定义实现
MoriceLoggerManage.shared = CustomLogger()
```

## 依赖

- SwiftyBeaver (~> 2.0)
- iOS 13.4+

## 许可证

MoriceLogger 使用 MIT 许可证。详情请查看 [LICENSE](LICENSE) 文件。

## 作者

DeTong

## 致谢

感谢 [SwiftyBeaver](https://github.com/SwiftyBeaver/SwiftyBeaver) 提供的强大日志框架。

