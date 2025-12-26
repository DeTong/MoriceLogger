//
//  MoriceLoggerSwiftyBeaverHelper.swift
//  PackSwiftyBeaver
//
//  Created by DeTong on 2025/12/24.
//

import Foundation
import SwiftyBeaver

final class MoriceLoggerSwiftyBeaverHelper: MoriceLogger {
    
    private let log = SwiftyBeaver.self
    private var fileDestination: FileDestination?
    
    // 最多保留的日志文件数量
    private let maxLogFileCount = 15

    init() {
        setup()
    }

    private func setup() {
        
        let logFormat = "[Morice Logger] [$Dyyyy-MM-dd HH:mm:ss.SSS$d] [$L] $N.$F: $l - $M $X"
        
        let console = ConsoleDestination()
        console.format = logFormat
        console.asynchronously = false
        console.logPrintWay = .logger(subsystem: "Main", category: "UI")
        log.addDestination(console)

        let file = FileDestination()
        file.format = logFormat
        file.logFileMaxSize = 25 * 1024 * 1024
        
        // 初始化时设置当前日期的日志文件 URL
        file.logFileURL = loggerFileURL
        
        // 清理旧的日志文件，只保留最新的15个
        cleanupOldLogFiles()
        
        log.addDestination(file)
        fileDestination = file
    }
    
    /// 清理旧的日志文件，只保留最新的15个文件
    private func cleanupOldLogFiles() {
        let logsDirectory = loggerFileURL.deletingLastPathComponent()
        let fileManager = FileManager.default
        
        // 确保目录存在
        guard fileManager.fileExists(atPath: logsDirectory.path) else { return }
        
        do {
            // 获取目录下所有文件
            let files = try fileManager.contentsOfDirectory(at: logsDirectory, includingPropertiesForKeys: [.contentModificationDateKey], options: [])
            
            // 筛选出日志文件（文件名以 ‘loggerFilePrefix’ 开头，以 .log 结尾）
            let logFiles = files.filter { url in
                let fileName = url.lastPathComponent
                return fileName.hasPrefix(loggerFilePrefix) && fileName.hasSuffix(".log")
            }
            
            // 如果文件数量超过限制，删除最旧的文件
            if logFiles.count > maxLogFileCount {
                // 按修改时间排序（最旧的在前）
                let sortedFiles = logFiles.sorted { url1, url2 in
                    let date1 = (try? url1.resourceValues(forKeys: [.contentModificationDateKey]).contentModificationDate) ?? Date.distantPast
                    let date2 = (try? url2.resourceValues(forKeys: [.contentModificationDateKey]).contentModificationDate) ?? Date.distantPast
                    return date1 < date2
                }
                
                // 删除最旧的文件
                let filesToDelete = sortedFiles.prefix(logFiles.count - maxLogFileCount)
                for fileToDelete in filesToDelete {
                    try? fileManager.removeItem(at: fileToDelete)
                }
            }
        } catch {
            print("清理日志文件时出错: \(error)")
        }
    }
    
    //  MARK: - 日志输出
    func verbose(_ message: Any?, tag: String?, file: String, function: String, line: Int) {
        log.verbose(format(message, tag: tag), file: file, function: function, line: line)
    }

    func debug(_ message: Any?, tag: String?, file: String, function: String, line: Int) {
        log.debug(format(message, tag: tag), file: file, function: function, line: line)
    }
    
    func info(_ message: Any?, tag: String?, file: String, function: String, line: Int) {
        log.info(format(message, tag: tag), file: file, function: function, line: line)
    }
    
    func warning(_ message: Any?, tag: String?, file: String, function: String, line: Int) {
        log.warning(format(message, tag: tag), file: file, function: function, line: line)
    }
    
    func error(_ message: Any?, tag: String?, file: String, function: String, line: Int) {
        log.error(format(message, tag: tag), file: file, function: function, line: line)
    }
    
    func critical(_ message: Any?, tag: String?, file: String, function: String, line: Int) {
        log.critical(format(message, tag: tag), file: file, function: function, line: line)
    }
    
    func fault(_ message: Any?, tag: String?, file: String, function: String, line: Int) {
        log.fault(format(message, tag: tag), file: file, function: function, line: line)
    }
    
    //  整理输出格式
    private func format(_ message: Any?, tag: String?) -> String {
        let msg = message.map { String(describing: $0) } ?? "nil"
        return tag != nil ? "[\(tag!)] \(msg)" : msg
    }
    
    //  MARK: - 日志上传
    func uploadLoggerFile() {
        
    }
}
