Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D818167CF
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 09:00:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rF8Wf-0002p0-EX; Mon, 18 Dec 2023 02:58:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rF8Wd-0002op-Mk
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 02:58:55 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rF8Wb-0007Qt-B7
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 02:58:55 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d075392ff6so19996835ad.1
 for <qemu-devel@nongnu.org>; Sun, 17 Dec 2023 23:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702886332; x=1703491132;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GCcy8hl6yoo+cgAVUMb/j41Lisc08fACVndcXGTVSbw=;
 b=YKM9YJl7I7N/8Y92fc7zfbvPm44GEeQb/M9OaUqDgk57soikKIaP234btKfgZ2PCD7
 kIT0l+Shxv4pcM1xCs5s6YpxiZV65IEW3MxmiBDXo1Qd6QXI8NAonxMXhiHvTnxTv8aD
 iJ/Yb6UrUsUD6Y/rjnt2RT3Hb+EswE+6HBoG5iDx5C3ikU30hc5+dLSHEyaxlgtPYBAo
 t12Wd9TgBEsPsOu/f5lSmmnJG/iH3KAdiBfl5XmHynYFIGjTjC8CE+d1cHq2iC+huIqy
 76j3LVIZPse5tNBaHaQilj0RPOGt8SNyZUNiW2IoQeMUUG6f8G4Pfetld6wxZ9d/pPHV
 5OPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702886332; x=1703491132;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GCcy8hl6yoo+cgAVUMb/j41Lisc08fACVndcXGTVSbw=;
 b=gMuR47vXgm07TX78muX6QmAyUS9GVvsSBFSw4zjsC+FEMRSf43sNnhw6Ptqv3G659i
 VTR8FZpU0MujmO0Xp853ftWKN8Kg5QNxiUZgWHOajIh8ngJ9BW5PtbkKgkImX6uOfpXA
 npadRaNR4FC3o6ycbx2XQsJxuKatLdEJoIRbT3vjvsmRIDQNmEpAmBWG3X+weeOWMLZL
 37RnCKozDUKxzY6nXslsrbYAHmvtbTfhmwqRVs2kh94mFJUEaurfFEwsDtgiH2nOiizc
 2JMWXCGw8/BS3b+o7ebl9EYECQPcuzCLpmgZdbbN+y+MrzMfgZc5p4z5VmVQNu+t5UI5
 iLfA==
X-Gm-Message-State: AOJu0YwHuXeORqMleq8Ztv6utTkBlcQU6xCGjGXJcYFUOoA544HgLQRa
 bG6sc6B6ymQFESCWwpMKRRlxSw==
X-Google-Smtp-Source: AGHT+IGUAEgUjAAFN44C6E09vznkHWyhv4rgn48oU1EAIasBS3i2vyzQzpF6A0ingLslnAzH4r6yAg==
X-Received: by 2002:a17:902:ced2:b0:1d3:67a9:d2a with SMTP id
 d18-20020a170902ced200b001d367a90d2amr9006782plg.11.1702886331735; 
 Sun, 17 Dec 2023 23:58:51 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 v4-20020a170902b7c400b001cfd35ec1d7sm3958461plz.243.2023.12.17.23.58.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Dec 2023 23:58:51 -0800 (PST)
Message-ID: <d889c324-c758-4a7a-9d7c-c3cfde926bac@daynix.com>
Date: Mon, 18 Dec 2023 16:58:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] ui/cocoa: Use NSWindow's ability to resize
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Marek Glogowski <smarkusg@gmail.com>, qemu-devel@nongnu.org,
 Rene Engel <ReneEngel80@emailn.de>
References: <20231217-cocoa-v7-1-6af21ef75680@daynix.com>
 <81d626f7-1fe5-0c74-acaa-4a2a4070a381@eik.bme.hu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <81d626f7-1fe5-0c74-acaa-4a2a4070a381@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 2023/12/17 20:39, BALATON Zoltan wrote:
> On Sun, 17 Dec 2023, Akihiko Odaki wrote:
>> This change brings two new features:
>> - The window will be resizable if "Zoom To Fit" is eanbled
>> - The window can be made full screen by clicking full screen button
>>  provided by the platform. (The left-top green button.)
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Tested-by: Rene Engel <ReneEngel80@emailn.de>
>> ---
>> V5 -> V6:
>>  Rebased.
>> ---
>> Changes in v7:
>> - Fixed zoom-to-fit option. (Marek Glogowski)
>> - Link to v6: 
>> https://lore.kernel.org/r/20231211-cocoa-v6-1-49f3be0191f2@daynix.com
>> ---
>> ui/cocoa.m | 542 
>> +++++++++++++++++++++++++++++--------------------------------
>> 1 file changed, 258 insertions(+), 284 deletions(-)
> 
> Is ir possible to break this patch up into smaller ones for easier 
> review? E.g. separate patch moving mouse event handling out of 
> handleEventLocked, replacing stretch_video flag with 
> NSWindowStyleMaskResizable and whatever else can be done as independent 
> steps? Not sure if that's possible or needs the whole chnage at once but 
> this patch seems to be too big. Some more comments below.

I split it into three patches with v8, but most changes are still in one 
patch because they depend on the change to unify the full screen window 
and normal window and vice-versa.

> 
>> diff --git a/ui/cocoa.m b/ui/cocoa.m
>> index cd069da6965b..31a2230f55a4 100644
>> --- a/ui/cocoa.m
>> +++ b/ui/cocoa.m
>> @@ -99,12 +99,10 @@ static void cocoa_switch(DisplayChangeListener *dcl,
>> static DisplayChangeListener dcl = {
>>     .ops = &dcl_ops,
>> };
>> -static int last_buttons;
>> static int cursor_hide = 1;
>> static int left_command_key_enabled = 1;
>> static bool swap_opt_cmd;
>>
>> -static bool stretch_video;
>> static NSTextField *pauseLabel;
>>
>> static bool allow_events;
>> @@ -304,20 +302,17 @@ static void handleAnyDeviceErrors(Error * err)
>> */
>> @interface QemuCocoaView : NSView
>> {
>> +    NSTrackingArea *trackingArea;
>>     QEMUScreen screen;
>> -    NSWindow *fullScreenWindow;
>> -    float cx,cy,cw,ch,cdx,cdy;
>>     pixman_image_t *pixman_image;
>>     QKbdState *kbd;
>>     BOOL isMouseGrabbed;
>> -    BOOL isFullscreen;
>>     BOOL isAbsoluteEnabled;
>>     CFMachPortRef eventsTap;
>> }
>> - (void) switchSurface:(pixman_image_t *)image;
>> - (void) grabMouse;
>> - (void) ungrabMouse;
>> -- (void) toggleFullScreen:(id)sender;
>> - (void) setFullGrab:(id)sender;
>> - (void) handleMonitorInput:(NSEvent *)event;
>> - (bool) handleEvent:(NSEvent *)event;
>> @@ -333,8 +328,6 @@ - (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled;
>>  */
>> - (BOOL) isMouseGrabbed;
>> - (BOOL) isAbsoluteEnabled;
>> -- (float) cdx;
>> -- (float) cdy;
>> - (QEMUScreen) gscreen;
>> - (void) raiseAllKeys;
>> @end
>> @@ -392,46 +385,43 @@ - (BOOL) isOpaque
>>     return YES;
>> }
>>
>> -- (BOOL) screenContainsPoint:(NSPoint) p
>> +- (void) removeTrackingRect
>> {
>> -    return (p.x > -1 && p.x < screen.width && p.y > -1 && p.y < 
>> screen.height);
>> +    if (trackingArea) {
>> +        [self removeTrackingArea:trackingArea];
>> +        [trackingArea release];
>> +        trackingArea = nil;
>> +    }
>> }
>>
>> -/* Get location of event and convert to virtual screen coordinate */
>> -- (CGPoint) screenLocationOfEvent:(NSEvent *)ev
>> +- (void) frameUpdated
>> {
>> -    NSWindow *eventWindow = [ev window];
>> -    // XXX: Use CGRect and -convertRectFromScreen: to support macOS 
>> 10.10
>> -    CGRect r = CGRectZero;
>> -    r.origin = [ev locationInWindow];
>> -    if (!eventWindow) {
>> -        if (!isFullscreen) {
>> -            return [[self window] convertRectFromScreen:r].origin;
>> -        } else {
>> -            CGPoint locationInSelfWindow = [[self window] 
>> convertRectFromScreen:r].origin;
>> -            CGPoint loc = [self convertPoint:locationInSelfWindow 
>> fromView:nil];
>> -            if (stretch_video) {
>> -                loc.x /= cdx;
>> -                loc.y /= cdy;
>> -            }
>> -            return loc;
>> -        }
>> -    } else if ([[self window] isEqual:eventWindow]) {
>> -        if (!isFullscreen) {
>> -            return r.origin;
>> -        } else {
>> -            CGPoint loc = [self convertPoint:r.origin fromView:nil];
>> -            if (stretch_video) {
>> -                loc.x /= cdx;
>> -                loc.y /= cdy;
>> -            }
>> -            return loc;
>> -        }
>> -    } else {
>> -        return [[self window] convertRectFromScreen:[eventWindow 
>> convertRectToScreen:r]].origin;
>> +    [self removeTrackingRect];
>> +
>> +    if ([self window]) {
>> +        NSTrackingAreaOptions options = NSTrackingActiveInKeyWindow |
>> +                                        
>> NSTrackingMouseEnteredAndExited |
>> +                                        NSTrackingMouseMoved;
>> +        trackingArea = [[NSTrackingArea alloc] initWithRect:[self frame]
>> +                                                    options:options
>> +                                                      owner:self
>> +                                                   userInfo:nil];
>> +        [self addTrackingArea:trackingArea];
>> +        [self updateUIInfo];
>>     }
>> }
>>
>> +- (void) viewDidMoveToWindow
>> +{
>> +    [self resizeWindow];
>> +    [self frameUpdated];
>> +}
>> +
>> +- (void) viewWillMoveToWindow:(NSWindow *)newWindow
>> +{
>> +    [self removeTrackingRect];
>> +}
>> +
>> - (void) hideCursor
>> {
>>     if (!cursor_hide) {
>> @@ -494,13 +484,14 @@ - (void) drawRect:(NSRect) rect
>>         int i;
>>         CGImageRef clipImageRef;
>>         CGRect clipRect;
>> +        CGFloat d = (CGFloat)h / [self frame].size.height;
>>
>>         [self getRectsBeingDrawn:&rectList count:&rectCount];
>>         for (i = 0; i < rectCount; i++) {
>> -            clipRect.origin.x = rectList[i].origin.x / cdx;
>> -            clipRect.origin.y = (float)h - (rectList[i].origin.y + 
>> rectList[i].size.height) / cdy;
>> -            clipRect.size.width = rectList[i].size.width / cdx;
>> -            clipRect.size.height = rectList[i].size.height / cdy;
>> +            clipRect.origin.x = rectList[i].origin.x * d;
>> +            clipRect.origin.y = (float)h - (rectList[i].origin.y + 
>> rectList[i].size.height) * d;
>> +            clipRect.size.width = rectList[i].size.width * d;
>> +            clipRect.size.height = rectList[i].size.height * d;
>>             clipImageRef = CGImageCreateWithImageInRect(
>>                                                         imageRef,
>>                                                         clipRect
>> @@ -513,36 +504,43 @@ - (void) drawRect:(NSRect) rect
>>     }
>> }
>>
>> -- (void) setContentDimensions
>> +- (NSSize) fixZoomedFullScreenSize:(NSSize)proposedSize
>> {
>> -    COCOA_DEBUG("QemuCocoaView: setContentDimensions\n");
>> +    NSSize size;
>>
>> -    if (isFullscreen) {
>> -        cdx = [[NSScreen mainScreen] frame].size.width / 
>> (float)screen.width;
>> -        cdy = [[NSScreen mainScreen] frame].size.height / 
>> (float)screen.height;
>> +    size.width = (CGFloat)screen.width * proposedSize.height;
>> +    size.height = (CGFloat)screen.height * proposedSize.width;
> 
> One of these will be overwritten in the next if below so maybe drop this 
> init and do the calculation in the if legs which is then also clearer to 
> show that this would scale one of these with screen.width/screen.height 
> or the inverse of that.
> 
> This also removes stretch_video flag and the calculation to preserve 
> aspect ratio. Is that correct? Would it now distort the image when 
> zooming to full screen if guest resolution is not the same as host 
> screen? Is that how zoom-to-fit should work? At leest with -display sdl 
> going to full screen guest screen is zoomed preserving aspect ratio but 
> maybe sdl does not have zoom-to-fit option. I don't know how it works 
> with other displays such as gtk.

The purpose of this method is to fix the aspect ratio for zoom-to-fit by 
shrinking width or height. It operates in the three steps:
1. Compute the values necessary either for shrinking width or height.
2. Decide which of width or height to shrink.
3. Compute the final values.

> 
>> -        /* stretches video, but keeps same aspect ratio */
>> -        if (stretch_video == true) {
>> -            /* use smallest stretch value - prevents clipping on 
>> sides */
>> -            if (MIN(cdx, cdy) == cdx) {
>> -                cdy = cdx;
>> -            } else {
>> -                cdx = cdy;
>> -            }
>> -        } else {  /* No stretching */
>> -            cdx = cdy = 1;
>> -        }
>> -        cw = screen.width * cdx;
>> -        ch = screen.height * cdy;
>> -        cx = ([[NSScreen mainScreen] frame].size.width - cw) / 2.0;
>> -        cy = ([[NSScreen mainScreen] frame].size.height - ch) / 2.0;
>> +    if (size.width < size.height) {
>> +        size.width /= screen.height;
>> +        size.height = proposedSize.height;
>>     } else {
>> -        cx = 0;
>> -        cy = 0;
>> -        cw = screen.width;
>> -        ch = screen.height;
>> -        cdx = 1.0;
>> -        cdy = 1.0;
>> +        size.width = proposedSize.width;
>> +        size.height /= screen.width;
>> +    }
>> +
>> +    return size;
>> +}
>> +
>> +- (NSSize) screenSafeAreaSize
>> +{
>> +    NSSize size = [[[self window] screen] frame].size;
>> +    NSEdgeInsets insets = [[[self window] screen] safeAreaInsets];
>> +    size.width -= insets.left + insets.right;
>> +    size.height -= insets.top + insets.bottom;
>> +    return size;
>> +}
>> +
>> +- (void) resizeWindow
>> +{
>> +    [[self window] setContentAspectRatio:NSMakeSize(screen.width, 
>> screen.height)];
>> +
>> +    if (([[self window] styleMask] & NSWindowStyleMaskResizable) == 0) {
>> +        [[self window] setContentSize:NSMakeSize(screen.width, 
>> screen.height)];
>> +        [[self window] center];
>> +    } else if (([[self window] styleMask] & 
>> NSWindowStyleMaskFullScreen) != 0) {
>> +        [[self window] setContentSize:[self 
>> fixZoomedFullScreenSize:[self screenSafeAreaSize]]];
>> +        [[self window] center];
>>     }
>> }
>>
>> @@ -563,7 +561,11 @@ - (void) updateUIInfoLocked
>>         CGSize screenPhysicalSize = CGDisplayScreenSize(display);
>>         CVDisplayLinkRef displayLink;
>>
>> -        frameSize = isFullscreen ? screenSize : [self frame].size;
>> +        if (([[self window] styleMask] & NSWindowStyleMaskFullScreen) 
>> == 0) {
>> +            frameSize = [self frame].size;
>> +        } else {
>> +            frameSize = [self screenSafeAreaSize];
>> +        }
> 
> In these ifs you seem to test for flag not set with == 0 but maybe 
> swapping the else and then branches and testing for flag set would be 
> clearer than testing for negative condition? I mean:
> 
> if (([[self window] styleMask] & NSWindowStyleMaskFullScreen)) {
>      frameSize = [self screenSafeAreaSize];
> } else {
>      frameSize = [self frame].size;
> }

Fixed with v8.

Regards,
Akihiko Odaki

