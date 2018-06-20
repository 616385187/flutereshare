#import <AVFoundation/AVAssetExportSession.h>
#import "LMSingleton.h"
#define TSLibraryImportErrorDomain @"TSLibraryImportErrorDomain"

#define TSUnknownError @"TSUnknownError"
#define TSFileExistsError @"TSFileExistsError"

#define kTSUnknownError -65536
#define kTSFileExistsError -48 //dupFNErr

//typedef NSInteger AVAssetExportSessionStatus;

@class AVAssetExportSession;

@interface TSLibraryImport : NSObject {
	NSError* movieFileErr;
}

/**
 * Pass in the NSURL* you get from an MPMediaItem's 
 * MPMediaItemPropertyAssetURL property to get the file's extension.
 *
 * Helpful in constructing the destination url for the
 * imported file.
 */
LMSingletonH(TSLibraryImport)

@property(nonatomic,strong)AVAssetExportSession* exportSession;
@property (readonly) NSError* error;
@property (readonly) AVAssetExportSessionStatus status;
@property (readonly) float progress;



/**
 开始导出音乐
 
 @param item MPMediaItem对象
 @param Cb 导出结果 code 参照ESResultCode_h
 */
+(void)startImportAsset:(MPMediaItem *)item  cb:(void(^)(int code))Cb;


/**
 停止导出音乐

 */
-(void)stopImportAsset;




@end
