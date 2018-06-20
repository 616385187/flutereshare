


// tv端显示的照片大小
#define Img_Size_version1 CGSizeMake(1920, 1080)
// UIImageJPEGRepresentation函数中的compressionQuality参数值
#define  COMPRESSSSION_QUALITY 0.6


#define kTitleKey				@"title"
#define kExplainKey				@"explainText"
#define kIconKey				@"IconFile"
#define kExtensionKey			@"fileextension"
#define kFileTypeKey			@"fileType"
#define kFilePathKey            @"filePath"
#define kFileModifyDate         @"fileTime"

typedef NS_ENUM(NSInteger,FileType)
{
    kFileTypeFolder     = 0,
    kFileTypeVideo	,
    kFileTypeAudio	,
    kFileTypeImage	,
    kFileTypeTxt	,
    kFileTypeOther	,
};
typedef NS_ENUM(NSInteger, AlbumsType) {
    AlbumsTypePhoto = 1,
    AlbumsTypePhotVideo ,
    
};
typedef NS_ENUM(NSInteger,MediaType)
{
    MediaTypeVideo = 0 ,  // iTunes中的视频
    MediaTypeMusic, // iTunes中的音频
    MediaTypeLocalVideo, // 文件共享中的视频
    MediaTypeLocalMusic, // 文件共享中的音频

    
};
typedef NS_ENUM(NSUInteger,ModelT) {
    ModelT_Touch, // 触摸
    ModelT_Key, // 按键
    ModelT_Mouse, // 鼠标
    ModelT_AirMouse , // 空鼠
    
};
typedef NS_ENUM(NSInteger,WifiType)
{
    WifiType_WEP     = 0,
    WifiType_WPA	,
    WifiType_NOPWD, // 无密码
    WifiType_INVALID, // 无效
    
    
};
