/**
* Copyright (c) 2015-2016 VisionStar Information Technology (Shanghai) Co., Ltd. All Rights Reserved.
* EasyAR is the registered trademark or trademark of VisionStar Information Technology (Shanghai) Co., Ltd in China
* and other countries for the augmented reality technology developed by VisionStar Information Technology (Shanghai) Co., Ltd.
*/

#import "OpenGLView.h"
#import "AppDelegate.h"

#include <iostream>
#include "ar.hpp"
#include "renderer.hpp"

/*
* Steps to create the key for this sample:
*  1. login www.easyar.com
*  2. create app with
*      Name: HelloARVideo
*      Bundle ID: cn.easyar.samples.helloarvideo
*  3. find the created item in the list and show key
*  4. set key string bellow
*/
NSString* key = @"X4qIdef5JwYlbJKbmSYJlIsvEMq81RPrFgLYXQ9qIbUrqz2wradu1btrWkXVOn2dBAU8arjuCDYLrLe4z0QyXFHvtxIQQQWxQR9845168c978f908ea4efa737e0ad39e4dfWkcFH8eaBAls97Lv25eFAJnju0lG6Nje4HOCrsMEYQmbCbdZHf7jp2qBDH5XQeH0nxZf";

namespace EasyAR {
namespace samples {

class HelloARVideo : public AR
{
public:
    HelloARVideo();
    ~HelloARVideo();
    virtual void initGL();
    virtual void resizeGL(int width, int height);
    virtual void render();
    virtual bool clear();
    int openMusic;
    std::string musicname;
private:
    Vec2I view_size;
    VideoRenderer* renderer[50];
    int tracked_target;
    int active_target;
    int texid[50];
    ARVideo* video;
    VideoRenderer* video_renderer;
};

HelloARVideo::HelloARVideo()
{
    view_size[0] = -1;
    tracked_target = 0;
    active_target = 0;
    for(int i = 0; i < 50; ++i) {
        texid[i] = 0;
        renderer[i] = new VideoRenderer;
    }
    video = NULL;
    video_renderer = NULL;
}

HelloARVideo::~HelloARVideo()
{
    for(int i = 0; i < 50; ++i) {
        delete renderer[i];
    }
}

void HelloARVideo::initGL()
{
    augmenter_ = Augmenter();
    for(int i = 0; i < 50; ++i) {
        renderer[i]->init();
        texid[i] = renderer[i]->texId();
    }
}

void HelloARVideo::resizeGL(int width, int height)
{
    view_size = Vec2I(width, height);
}

void HelloARVideo::render()
{
    glClearColor(0.f, 0.f, 0.f, 1.f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    Frame frame = augmenter_.newFrame();
    if(view_size[0] > 0){
        int width = view_size[0];
        int height = view_size[1];
        Vec2I size = Vec2I(1, 1);
        if (camera_ && camera_.isOpened())
            size = camera_.size();
        if(portrait_)
            std::swap(size[0], size[1]);
        float scaleRatio = std::max((float)width / (float)size[0], (float)height / (float)size[1]);
        Vec2I viewport_size = Vec2I((int)(size[0] * scaleRatio), (int)(size[1] * scaleRatio));
        if(portrait_)
            viewport_ = Vec4I(0, height - viewport_size[1], viewport_size[0], viewport_size[1]);
        else
            viewport_ = Vec4I(0, width - height, viewport_size[0], viewport_size[1]);
        if(camera_ && camera_.isOpened())
            view_size[0] = -1;
    }
    augmenter_.setViewPort(viewport_);
    augmenter_.drawVideoBackground();
    glViewport(viewport_[0], viewport_[1], viewport_[2], viewport_[3]);

    AugmentedTarget::Status status = frame.targets()[0].status();
    if(status == AugmentedTarget::kTargetStatusTracked){
        int id = frame.targets()[0].target().id();
        if(active_target && active_target != id) {
            video->onLost();
            delete video;
            video = NULL;
            tracked_target = 0;
            active_target = 0;
        }
        if (!tracked_target) {
            if (video == NULL) {
                if(frame.targets()[0].target().name() == std::string("2017_3_14") && texid[0]) {
                    video = new ARVideo;
                    video->openVideoFile("liveoldStreet.mp4", texid[0]);
                    video_renderer = renderer[0];
                    musicname = "";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_3_15") && texid[1]) {
                    musicname = "oldstreet.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_3_16") && texid[2]) {

                    musicname = "liveMp3.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_3_17") && texid[3]) {
                    musicname = "oldstreet.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_3_18") && texid[4]) {
                    
                    musicname = "liveMp3.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_3_19") && texid[5]) {
                    
                    musicname = "oldstreet.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_3_20") && texid[6]) {
                    video = new ARVideo;
                    video->openVideoFile("haomi.mp4", texid[6]);
                    video_renderer = renderer[6];
                    musicname = "";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_3_21") && texid[7]) {
                    
                    musicname = "oldstreet.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_3_22") && texid[8]) {
                    video = new ARVideo;
                    video->openVideoFile("jiuba.mp4", texid[8]);
                    video_renderer = renderer[8];
                    musicname = "";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_3_23") && texid[9]) {
                    video = new ARVideo;
                    video->openVideoFile("fanji.mp4", texid[9]);
                    video_renderer = renderer[9];
                    musicname = "";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_3_24") && texid[10]) {
                    
                    musicname = "liveMp3.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_3_25") && texid[11]) {
                    
                    musicname = "oldstreet.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_3_26") && texid[12]) {
                    
                    musicname = "oldstreet.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_3_27") && texid[13]) {
                    
                    musicname = "liveMp3.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_3_28") && texid[14]) {
                    
                    musicname = "oldstreet.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_3_29") && texid[15]) {
                    
                    musicname = "liveMp3.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_3_30") && texid[16]) {
                    
                    musicname = "oldstreet.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_3_31") && texid[17]) {
                    
                    musicname = "liveMp3.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_4_1") && texid[18]) {
                    
                    musicname = "oldstreet.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_4_2") && texid[19]) {
                    
                    musicname = "liveMp3.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_4_3") && texid[20]) {
                    
                    musicname = "DREAMCITY.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_4_23") && texid[21]) {
                    
                    musicname = "liveMp3.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_4_24") && texid[22]) {
                    
                    musicname = "oldstreet.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_4_25") && texid[23]) {
                    
                    musicname = "liveMp3.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_4_26") && texid[24]) {
                    
                    musicname = "oldstreet.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_4_27") && texid[25]) {
                    
                    musicname = "liveMp3.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_4_28") && texid[26]) {
                    
                    musicname = "oldstreet.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_4_29") && texid[27]) {
                    
                    musicname = "liveMp3.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_4_30") && texid[28]) {
                    
                    musicname = "oldstreet.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_5_1") && texid[29]) {
                    
                    musicname = "liveMp3.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_5_2") && texid[30]) {
                    musicname = "oldstreet.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_5_3") && texid[31]) {
                    
                    musicname = "liveMp3.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_5_4") && texid[32]) {
                    
                    musicname = "oldstreet.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_5_5") && texid[33]) {
                    
                    musicname = "liveMp3.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_5_6") && texid[34]) {
                    
                    musicname = "oldstreet.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_5_7") && texid[35]) {
                    
                    musicname = "liveMp3.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_5_8") && texid[36]) {
                    
                    musicname = "oldstreet.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_5_9") && texid[37]) {
                    
                    musicname = "liveMp3.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_5_10") && texid[38]) {
                    
                    musicname = "oldstreet.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_5_11") && texid[39]) {
                    
                    musicname = "liveMp3.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_5_12") && texid[40]) {
                    
                    musicname = "oldstreet.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_5_13") && texid[41]) {
                    
                    musicname = "liveMp3.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_5_14") && texid[42]) {
                    
                    musicname = "oldstreet.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_5_15") && texid[43]) {
                    
                    musicname = "liveMp3.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_5_16") && texid[44]) {
                    
                    musicname = "oldstreet.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_5_17") && texid[45]) {
                    
                    musicname = "liveMp3.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("2017_5_18") && texid[46]) {
                    
                    musicname = "oldstreet.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("A2-01") && texid[47]) {
                    video = new ARVideo;
                    video->openVideoFile("yaoqing.mp4", texid[47]);
                    video_renderer = renderer[47];
                    musicname = "";
                }
                else if(frame.targets()[0].target().name() == std::string("demo1") && texid[48]) {
                    
                    musicname = "gushilaoge.mp3";
                }
                else if(frame.targets()[0].target().name() == std::string("demo2") && texid[49]) {
                    musicname = "aolifo.mp3";
                }
            }
            if (video) {
                video->onFound();
                tracked_target = id;
                active_target = id;
            }
        }
        Matrix44F projectionMatrix = getProjectionGL(camera_.cameraCalibration(), 0.2f, 500.f);
        Matrix44F cameraview = getPoseGL(frame.targets()[0].pose());
        ImageTarget target = frame.targets()[0].target().cast_dynamic<ImageTarget>();
        if(tracked_target) {
            video->update();
            video_renderer->render(projectionMatrix, cameraview, target.size());
        }
    } else {
        if (tracked_target) {
            video->onLost();
            tracked_target = 0;
        }
    }
}

bool HelloARVideo::clear()
{
    AR::clear();
    if(video){
        delete video;
        video = NULL;
        tracked_target = 0;
        active_target = 0;
    }
    return true;
}

}
}
EasyAR::samples::HelloARVideo ar;

@interface OpenGLView (){
}

@property(nonatomic, strong) CADisplayLink * displayLink;

- (void)displayLinkCallback:(CADisplayLink*)displayLink;

@end

@implementation OpenGLView

+ (Class)layerClass
{
    return [CAEAGLLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    frame.size.width = frame.size.height = MAX(frame.size.width, frame.size.height);
    self = [super initWithFrame:frame];
    if(self){
        [self setupGL];

        EasyAR::initialize([key UTF8String]);
        ar.initGL();
    }

    return self;
}

- (void)dealloc
{
    ar.clear();
}

- (void)setupGL
{
    _eaglLayer = (CAEAGLLayer*) self.layer;
    _eaglLayer.opaque = YES;

    EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
    _context = [[EAGLContext alloc] initWithAPI:api];
    if (!_context)
        NSLog(@"Failed to initialize OpenGLES 2.0 context");
    if (![EAGLContext setCurrentContext:_context])
        NSLog(@"Failed to set current OpenGL context");

    GLuint frameBuffer;
    glGenFramebuffers(1, &frameBuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, frameBuffer);

    glGenRenderbuffers(1, &_colorRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
    [_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:_eaglLayer];
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _colorRenderBuffer);

    int width, height;
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &width);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &height);

    GLuint depthRenderBuffer;
    glGenRenderbuffers(1, &depthRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, depthRenderBuffer);
    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, width, height);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, depthRenderBuffer);
}

- (void)start{
    ar.initCamera();
    ar.loadAllFromJsonFile("targets.json");
    ar.loadFromImage("namecard.jpg");
    ar.loadFromImage("IMG_7967.JPG");
    ar.start();
    ar.openMusic = self.SJMusicType;
    
    
    ar.musicname = "";
    musicString = @"";
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkCallback:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}


- (void)stop
{
    ar.clear();
}

- (void)displayLinkCallback:(CADisplayLink*)displayLink{
    if (!((AppDelegate*)[[UIApplication sharedApplication]delegate]).active)
        return;
    ar.render();
    std::string str = ar.musicname;
    NSString *temp = [NSString stringWithUTF8String:str.c_str()];
    if ([musicString isEqualToString:@""]){
    }
    if (![temp isEqualToString:musicString]) {
        NSLog(@"%@",musicString);
        musicString = temp;
        if ([self.OpenGLDelegate respondsToSelector:@selector(changeMusicType:)]){
            [self.OpenGLDelegate changeMusicType:musicString];
            NSLog(@"传送%@",musicString);
        }
    }
    
    (void)displayLink;
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
    [_context presentRenderbuffer:GL_RENDERBUFFER];
    
    
}

- (void)resize:(CGRect)frame orientation:(UIInterfaceOrientation)orientation
{
    BOOL isPortrait = FALSE;
    switch (orientation)
    {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            isPortrait = TRUE;
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            isPortrait = FALSE;
            break;
        default:
            break;
    }
    ar.setPortrait(isPortrait);
    ar.resizeGL(frame.size.width, frame.size.height);
}

- (void)setOrientation:(UIInterfaceOrientation)orientation
{
    switch (orientation)
    {
        case UIInterfaceOrientationPortrait:
            EasyAR::setRotationIOS(270);
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            EasyAR::setRotationIOS(90);
            break;
        case UIInterfaceOrientationLandscapeLeft:
            EasyAR::setRotationIOS(180);
            break;
        case UIInterfaceOrientationLandscapeRight:
            EasyAR::setRotationIOS(0);
            break;
        default:
            break;
    }
}

@end
