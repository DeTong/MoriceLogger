//
//  MoriceLogger.swift
//  PackSwiftyBeaver
//
//  Created by DeTong on 2025/12/24.
//

import Foundation

protocol MoriceLogger {
    
    //  MARK: - 基础信息
    var loggerFilePrefix: String { get }

    var loggerFileFolder: URL { get }
    var loggerFileURL: URL { get }
    
    func loggerInfo()
    
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

extension MoriceLogger {
    
    var loggerFilePrefix: String {
        return "morice_log_"
    }
    
    var loggerFileFolder: URL {
        let path = FileManager.default.urls(for:.documentDirectory, in:.userDomainMask)[0]
        let logsDirectory = path.appendingPathComponent("com.morice.logger", isDirectory: true)
        return logsDirectory
    }
    
    var loggerFileURL: URL {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: Date())
        let fileName = "\(loggerFilePrefix)\(dateString).log"
        return loggerFileFolder.appendingPathComponent(fileName)
    }
    
    func loggerInfo() {
        MLogInfo(MoriceLoggerManage.shared.loggerFilePrefix)
        MLogInfo(MoriceLoggerManage.shared.loggerFileFolder)
        MLogInfo(MoriceLoggerManage.shared.loggerFileURL)
    }
    
    func uploadLoggerFile() {
        
    }
}

//  MARK: - 便捷使用
enum MoriceLoggerManage {
    static var shared: MoriceLogger = MoriceLoggerSwiftyBeaverHelper()
}

func MLogDetail() {
    MoriceLoggerManage.shared.loggerInfo()
}

func MLogVerbose(_ message: Any?, tag: String? = nil, file: String = #file, function: String = #function, line: Int = #line) {
    MoriceLoggerManage.shared.verbose(message, tag: tag, file: file, function: function, line: line)
}

func MLogDebug(_ message: Any?, tag: String? = nil, file: String = #file, function: String = #function, line: Int = #line) {
    MoriceLoggerManage.shared.debug(message, tag: tag, file: file, function: function, line: line)
}

func MLogInfo(_ message: Any?, tag: String? = nil, file: String = #file, function: String = #function, line: Int = #line) {
    MoriceLoggerManage.shared.info(message, tag: tag, file: file, function: function, line: line)
}

func MLogWarning(_ message: Any?, tag: String? = nil, file: String = #file, function: String = #function, line: Int = #line) {
    MoriceLoggerManage.shared.warning(message, tag: tag, file: file, function: function, line: line)
}

func MLogError(_ message: Any?, tag: String? = nil, file: String = #file, function: String = #function, line: Int = #line) {
    MoriceLoggerManage.shared.error(message, tag: tag, file: file, function: function, line: line)
}

func MLogCritical(_ message: Any?, tag: String? = nil, file: String = #file, function: String = #function, line: Int = #line) {
    MoriceLoggerManage.shared.critical(message, tag: tag, file: file, function: function, line: line)
}

func MLogFault(_ message: Any?, tag: String? = nil, file: String = #file, function: String = #function, line: Int = #line) {
    MoriceLoggerManage.shared.fault(message, tag: tag, file: file, function: function, line: line)
}
