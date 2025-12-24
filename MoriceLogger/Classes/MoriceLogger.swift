//
//  MoriceLogger.swift
//  MoriceLogger
//
//  Created by DeTong on 2025/12/24.
//

import Foundation

public protocol MoriceLogger {
    
    //  MARK: - 基础信息
    var loggerFilePrefix: String { get }

    var loggerFileFolder: URL { get }
    var loggerFileURL: URL { get }
    
    func showInfo()
    

    //  MARK: - 日志输出
    func verbose(_ message: Any?, tag: String?, file: String, function: String, line: Int)
    func debug(_ message: Any?, tag: String?, file: String, function: String, line: Int)
    func info(_ message: Any?, tag: String?, file: String, function: String, line: Int)
    func warning(_ message: Any?, tag: String?, file: String, function: String, line: Int)
    func error(_ message: Any?, tag: String?, file: String, function: String, line: Int)
    func critical(_ message: Any?, tag: String?, file: String, function: String, line: Int)
    func fault(_ message: Any?, tag: String?, file: String, function: String, line: Int)

    //  MARK: - 日志上传
    func uploadLoggerFile()
}

public extension MoriceLogger {
    
    var loggerFilePrefix: String {
        return "morice_log_"
    }
    
    var loggerFileFolder: URL {
        let path = FileManager.default.urls(for:.documentDirectory, in:.userDomainMask)[0]
        let logsDirectory = path.appendingPathComponent("com.morice.logger", isDirectory: true)
        
        // 确保目录存在
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: logsDirectory.path) {
            try? fileManager.createDirectory(at: logsDirectory, withIntermediateDirectories: true, attributes: nil)
        }
        
        return logsDirectory
    }
    
    /// 根据当前日期生成日志文件 URL
    var loggerFileURL: URL {
        // 生成基于日期的文件名，格式：morice_log_yyyy-MM-dd.log
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: Date())
        let fileName = "\(loggerFilePrefix)\(dateString).log"
        
        return loggerFileFolder.appendingPathComponent(fileName)
    }
    
    func showInfo() {
        SLogInfo(MoriceLoggerManage.shared.loggerFilePrefix)
        SLogInfo(MoriceLoggerManage.shared.loggerFileFolder)
        SLogInfo(MoriceLoggerManage.shared.loggerFileURL)
    }
    
    func uploadLoggerFile() {
        
    }
}

public enum MoriceLoggerManage {
    public static var shared: MoriceLogger = SPAXSwiftyBeaverLogger()
}

public func SLogVerbose(_ message: Any?, tag: String? = nil, file: String = #file, function: String = #function, line: Int = #line) {
    MoriceLoggerManage.shared.verbose(message, tag: tag, file: file, function: function, line: line)
}

public func SLogDebug(_ message: Any?, tag: String? = nil, file: String = #file, function: String = #function, line: Int = #line) {
    MoriceLoggerManage.shared.debug(message, tag: tag, file: file, function: function, line: line)
}

public func SLogInfo(_ message: Any?, tag: String? = nil, file: String = #file, function: String = #function, line: Int = #line) {
    MoriceLoggerManage.shared.info(message, tag: tag, file: file, function: function, line: line)
}

public func SLogWarning(_ message: Any?, tag: String? = nil, file: String = #file, function: String = #function, line: Int = #line) {
    MoriceLoggerManage.shared.warning(message, tag: tag, file: file, function: function, line: line)
}

public func SLogError(_ message: Any?, tag: String? = nil, file: String = #file, function: String = #function, line: Int = #line) {
    MoriceLoggerManage.shared.error(message, tag: tag, file: file, function: function, line: line)
}

public func SLogCritical(_ message: Any?, tag: String? = nil, file: String = #file, function: String = #function, line: Int = #line) {
    MoriceLoggerManage.shared.critical(message, tag: tag, file: file, function: function, line: line)
}

public func SLogFault(_ message: Any?, tag: String? = nil, file: String = #file, function: String = #function, line: Int = #line) {
    MoriceLoggerManage.shared.fault(message, tag: tag, file: file, function: function, line: line)
}

