Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC3380EE31
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 14:59:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD3H9-0007UD-Oe; Tue, 12 Dec 2023 08:58:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smarkusg@gmail.com>)
 id 1rCxlK-0008Fr-46
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 03:05:06 -0500
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smarkusg@gmail.com>)
 id 1rCxlE-0001kc-AT
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 03:05:05 -0500
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-35d5d54a8eeso13424815ab.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 00:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702368299; x=1702973099; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hbHIyKeTXySCxo5t0fzAYNVPOr+q87xpMRIkNL88Urc=;
 b=J5+x7igkFX51Picl2te2HhNoS/56rJTzvCDyMIfA9HtvVsOZNaOqhgDJFG6HY2KR7c
 dCPFUykv5QH78++1XJV/kAqvXRWpTF0F5IS4KGYMLwiztO8dnuI9g/V1/tV4XDs31w+C
 tKUIE4YdD1hyqOK/Omg8D2zH8L6/67aJrFMf7GZyFNp5HYE5yg2kTmVbySM7IYAd6OMp
 tBBnVh6xR4K6+OhO62DCAmNTcGTWZPEzLAAjP6IJmWbegP+D2uLHxHrd8suuDXKhzj/c
 QBMZfV7cS4yZJcClj24KCxspY4xkTi4DzxFKXU4I2JSW2X5rlxwKKOejFyN7KfcqW0nb
 3MRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702368299; x=1702973099;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hbHIyKeTXySCxo5t0fzAYNVPOr+q87xpMRIkNL88Urc=;
 b=JLYpCwhUX2MoFInWg9zeZjBBqFCrP8BUZt4LAbgUyKmKtHny0tup5oag6Wjc+hz00m
 uQh6wpfyR8d68re85v09PZk9QbBrXg717RkEGz9xQiBoIJQPHdk1mwqstuDrfDChHagZ
 HwFQlAXsUvpwFQwNvjLr8PJBS+ssQnGwrR6aaBL0iy0sQQjOLw0FIMXNYd+qOl5xMpYT
 frpHNKmE6O8WF4q5dpU6nr90TkPmVRGyUbZ8wSAdGbS78V+t6Tb5kZUeCqCA+8Kcni1f
 EHDMM1a3sc4l4Pd/+GczgLhG/7d3H7EeMnQnNli8dku5ztVRmFBdL97xabCi3o1x/rDt
 K3Yg==
X-Gm-Message-State: AOJu0Yx3rJbRnTGuXFdXrtS4yoPuTYw96Zcjq+GwO9dBnwvyLzWtBjto
 wLWJwU1r4jd57WZVLLH9adyXZ3SNoohTPLV5REI=
X-Google-Smtp-Source: AGHT+IENo7U2DLPY7xuuHs/LDV/5AMSdfKmsDVrkwBt5aNOFmSeE9HCw0uuSCV31oxjIe2q2AZvXZ6FMjG1HyyIugak=
X-Received: by 2002:a05:6e02:1a62:b0:35d:51dc:ad1 with SMTP id
 w2-20020a056e021a6200b0035d51dc0ad1mr4945277ilv.14.1702368298502; Tue, 12 Dec
 2023 00:04:58 -0800 (PST)
MIME-Version: 1.0
References: <20231211-cocoa-v6-1-49f3be0191f2@daynix.com>
In-Reply-To: <20231211-cocoa-v6-1-49f3be0191f2@daynix.com>
From: Marek Glogowski <smarkusg@gmail.com>
Date: Tue, 12 Dec 2023 09:04:47 +0100
Message-ID: <CADfA342Dr5troPrjE6Sf2+mMuPL5J1Q_zuXhJxrUnNo9tT6KsQ@mail.gmail.com>
Subject: Re: [PATCH v6] ui/cocoa: Use NSWindow's ability to resize
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000b58f2d060c4b81b2"
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=smarkusg@gmail.com; helo=mail-il1-x12c.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 Dec 2023 08:58:04 -0500
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

--000000000000b58f2d060c4b81b2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

I checked on the emulation "qemu-system-ppc -machine pegasos".
Full-screen seems to work fine. The screen is correctly initialised in
full-screen mode and there are no problems with closing the window when the
session is suspended.
With this series of patches, there is also the option "Move to", which
makes it possible to move the screen to an external device such as an IPad.
Thank you for the ui/cocoa acumen

Additionally, how can I use this message on qemu-devel.
It has a post for people who use Macos or Asahi Linux. Verify random qemu
sessions under Macos .Some are faster others are slow.
The topic is posted on qemu-discuss@nongnu.org (I don't know if developers
look there often)

https://lists.nongnu.org/archive/html/qemu-discuss/2023-12/msg00008.html

The program posted there was prepared by one of the maintainers of ppc qemu
machines "BALATON Zoltan".
We are starting to gather as much information as possible for it.
I hope nobody will be offended about this information in this topic. I do
not want to start a topic and litter other lists

Best regards
Marek G=C5=82ogowski


wt., 12 gru 2023 o 00:09 Akihiko Odaki <akihiko.odaki@daynix.com>
napisa=C5=82(a):

> This change brings two new features:
> - The window will be resizable if "Zoom To Fit" is eanbled
> - The window can be made full screen by clicking full screen button
>   provided by the platform. (The left-top green button.)
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> V5 -> V6:
>   Rebased.
> ---
>  ui/cocoa.m | 542
> +++++++++++++++++++++++++++++--------------------------------
>  1 file changed, 258 insertions(+), 284 deletions(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index cd069da696..302e4f76be 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -99,12 +99,10 @@ static void cocoa_switch(DisplayChangeListener *dcl,
>  static DisplayChangeListener dcl =3D {
>      .ops =3D &dcl_ops,
>  };
> -static int last_buttons;
>  static int cursor_hide =3D 1;
>  static int left_command_key_enabled =3D 1;
>  static bool swap_opt_cmd;
>
> -static bool stretch_video;
>  static NSTextField *pauseLabel;
>
>  static bool allow_events;
> @@ -304,20 +302,17 @@ static void handleAnyDeviceErrors(Error * err)
>  */
>  @interface QemuCocoaView : NSView
>  {
> +    NSTrackingArea *trackingArea;
>      QEMUScreen screen;
> -    NSWindow *fullScreenWindow;
> -    float cx,cy,cw,ch,cdx,cdy;
>      pixman_image_t *pixman_image;
>      QKbdState *kbd;
>      BOOL isMouseGrabbed;
> -    BOOL isFullscreen;
>      BOOL isAbsoluteEnabled;
>      CFMachPortRef eventsTap;
>  }
>  - (void) switchSurface:(pixman_image_t *)image;
>  - (void) grabMouse;
>  - (void) ungrabMouse;
> -- (void) toggleFullScreen:(id)sender;
>  - (void) setFullGrab:(id)sender;
>  - (void) handleMonitorInput:(NSEvent *)event;
>  - (bool) handleEvent:(NSEvent *)event;
> @@ -333,8 +328,6 @@ - (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled;
>   */
>  - (BOOL) isMouseGrabbed;
>  - (BOOL) isAbsoluteEnabled;
> -- (float) cdx;
> -- (float) cdy;
>  - (QEMUScreen) gscreen;
>  - (void) raiseAllKeys;
>  @end
> @@ -392,46 +385,43 @@ - (BOOL) isOpaque
>      return YES;
>  }
>
> -- (BOOL) screenContainsPoint:(NSPoint) p
> +- (void) removeTrackingRect
>  {
> -    return (p.x > -1 && p.x < screen.width && p.y > -1 && p.y <
> screen.height);
> +    if (trackingArea) {
> +        [self removeTrackingArea:trackingArea];
> +        [trackingArea release];
> +        trackingArea =3D nil;
> +    }
>  }
>
> -/* Get location of event and convert to virtual screen coordinate */
> -- (CGPoint) screenLocationOfEvent:(NSEvent *)ev
> +- (void) frameUpdated
>  {
> -    NSWindow *eventWindow =3D [ev window];
> -    // XXX: Use CGRect and -convertRectFromScreen: to support macOS 10.1=
0
> -    CGRect r =3D CGRectZero;
> -    r.origin =3D [ev locationInWindow];
> -    if (!eventWindow) {
> -        if (!isFullscreen) {
> -            return [[self window] convertRectFromScreen:r].origin;
> -        } else {
> -            CGPoint locationInSelfWindow =3D [[self window]
> convertRectFromScreen:r].origin;
> -            CGPoint loc =3D [self convertPoint:locationInSelfWindow
> fromView:nil];
> -            if (stretch_video) {
> -                loc.x /=3D cdx;
> -                loc.y /=3D cdy;
> -            }
> -            return loc;
> -        }
> -    } else if ([[self window] isEqual:eventWindow]) {
> -        if (!isFullscreen) {
> -            return r.origin;
> -        } else {
> -            CGPoint loc =3D [self convertPoint:r.origin fromView:nil];
> -            if (stretch_video) {
> -                loc.x /=3D cdx;
> -                loc.y /=3D cdy;
> -            }
> -            return loc;
> -        }
> -    } else {
> -        return [[self window] convertRectFromScreen:[eventWindow
> convertRectToScreen:r]].origin;
> +    [self removeTrackingRect];
> +
> +    if ([self window]) {
> +        NSTrackingAreaOptions options =3D NSTrackingActiveInKeyWindow |
> +                                        NSTrackingMouseEnteredAndExited =
|
> +                                        NSTrackingMouseMoved;
> +        trackingArea =3D [[NSTrackingArea alloc] initWithRect:[self fram=
e]
> +                                                    options:options
> +                                                      owner:self
> +                                                   userInfo:nil];
> +        [self addTrackingArea:trackingArea];
> +        [self updateUIInfo];
>      }
>  }
>
> +- (void) viewDidMoveToWindow
> +{
> +    [self resizeWindow];
> +    [self frameUpdated];
> +}
> +
> +- (void) viewWillMoveToWindow:(NSWindow *)newWindow
> +{
> +    [self removeTrackingRect];
> +}
> +
>  - (void) hideCursor
>  {
>      if (!cursor_hide) {
> @@ -494,13 +484,14 @@ - (void) drawRect:(NSRect) rect
>          int i;
>          CGImageRef clipImageRef;
>          CGRect clipRect;
> +        CGFloat d =3D (CGFloat)h / [self frame].size.height;
>
>          [self getRectsBeingDrawn:&rectList count:&rectCount];
>          for (i =3D 0; i < rectCount; i++) {
> -            clipRect.origin.x =3D rectList[i].origin.x / cdx;
> -            clipRect.origin.y =3D (float)h - (rectList[i].origin.y +
> rectList[i].size.height) / cdy;
> -            clipRect.size.width =3D rectList[i].size.width / cdx;
> -            clipRect.size.height =3D rectList[i].size.height / cdy;
> +            clipRect.origin.x =3D rectList[i].origin.x * d;
> +            clipRect.origin.y =3D (float)h - (rectList[i].origin.y +
> rectList[i].size.height) * d;
> +            clipRect.size.width =3D rectList[i].size.width * d;
> +            clipRect.size.height =3D rectList[i].size.height * d;
>              clipImageRef =3D CGImageCreateWithImageInRect(
>                                                          imageRef,
>                                                          clipRect
> @@ -513,36 +504,43 @@ - (void) drawRect:(NSRect) rect
>      }
>  }
>
> -- (void) setContentDimensions
> +- (NSSize) fixZoomedFullScreenSize:(NSSize)proposedSize
>  {
> -    COCOA_DEBUG("QemuCocoaView: setContentDimensions\n");
> +    NSSize size;
>
> -    if (isFullscreen) {
> -        cdx =3D [[NSScreen mainScreen] frame].size.width /
> (float)screen.width;
> -        cdy =3D [[NSScreen mainScreen] frame].size.height /
> (float)screen.height;
> +    size.width =3D (CGFloat)screen.width * proposedSize.height;
> +    size.height =3D (CGFloat)screen.height * proposedSize.width;
>
> -        /* stretches video, but keeps same aspect ratio */
> -        if (stretch_video =3D=3D true) {
> -            /* use smallest stretch value - prevents clipping on sides *=
/
> -            if (MIN(cdx, cdy) =3D=3D cdx) {
> -                cdy =3D cdx;
> -            } else {
> -                cdx =3D cdy;
> -            }
> -        } else {  /* No stretching */
> -            cdx =3D cdy =3D 1;
> -        }
> -        cw =3D screen.width * cdx;
> -        ch =3D screen.height * cdy;
> -        cx =3D ([[NSScreen mainScreen] frame].size.width - cw) / 2.0;
> -        cy =3D ([[NSScreen mainScreen] frame].size.height - ch) / 2.0;
> +    if (size.width < size.height) {
> +        size.width /=3D screen.height;
> +        size.height =3D proposedSize.height;
>      } else {
> -        cx =3D 0;
> -        cy =3D 0;
> -        cw =3D screen.width;
> -        ch =3D screen.height;
> -        cdx =3D 1.0;
> -        cdy =3D 1.0;
> +        size.width =3D proposedSize.width;
> +        size.height /=3D screen.width;
> +    }
> +
> +    return size;
> +}
> +
> +- (NSSize) screenSafeAreaSize
> +{
> +    NSSize size =3D [[[self window] screen] frame].size;
> +    NSEdgeInsets insets =3D [[[self window] screen] safeAreaInsets];
> +    size.width -=3D insets.left + insets.right;
> +    size.height -=3D insets.top + insets.bottom;
> +    return size;
> +}
> +
> +- (void) resizeWindow
> +{
> +    [[self window] setContentAspectRatio:NSMakeSize(screen.width,
> screen.height)];
> +
> +    if (([[self window] styleMask] & NSWindowStyleMaskResizable) =3D=3D =
0) {
> +        [[self window] setContentSize:NSMakeSize(screen.width,
> screen.height)];
> +        [[self window] center];
> +    } else if (([[self window] styleMask] & NSWindowStyleMaskFullScreen)
> !=3D 0) {
> +        [[self window] setContentSize:[self fixZoomedFullScreenSize:[sel=
f
> screenSafeAreaSize]]];
> +        [[self window] center];
>      }
>  }
>
> @@ -563,7 +561,11 @@ - (void) updateUIInfoLocked
>          CGSize screenPhysicalSize =3D CGDisplayScreenSize(display);
>          CVDisplayLinkRef displayLink;
>
> -        frameSize =3D isFullscreen ? screenSize : [self frame].size;
> +        if (([[self window] styleMask] & NSWindowStyleMaskFullScreen) =
=3D=3D
> 0) {
> +            frameSize =3D [self frame].size;
> +        } else {
> +            frameSize =3D [self screenSafeAreaSize];
> +        }
>
>          if (!CVDisplayLinkCreateWithCGDisplay(display, &displayLink)) {
>              CVTime period =3D
> CVDisplayLinkGetNominalOutputVideoRefreshPeriod(displayLink);
> @@ -610,31 +612,19 @@ - (void) updateUIInfo
>      });
>  }
>
> -- (void)viewDidMoveToWindow
> -{
> -    [self updateUIInfo];
> -}
> -
>  - (void) switchSurface:(pixman_image_t *)image
>  {
>      COCOA_DEBUG("QemuCocoaView: switchSurface\n");
>
>      int w =3D pixman_image_get_width(image);
>      int h =3D pixman_image_get_height(image);
> -    /* cdx =3D=3D 0 means this is our very first surface, in which case =
we
> need
> -     * to recalculate the content dimensions even if it happens to be th=
e
> size
> -     * of the initial empty window.
> -     */
> -    bool isResize =3D (w !=3D screen.width || h !=3D screen.height || cd=
x =3D=3D
> 0.0);
>
> -    int oldh =3D screen.height;
> -    if (isResize) {
> +    if (w !=3D screen.width || h !=3D screen.height) {
>          // Resize before we trigger the redraw, or we'll redraw at the
> wrong size
>          COCOA_DEBUG("switchSurface: new size %d x %d\n", w, h);
>          screen.width =3D w;
>          screen.height =3D h;
> -        [self setContentDimensions];
> -        [self setFrame:NSMakeRect(cx, cy, cw, ch)];
> +        [self resizeWindow];
>      }
>
>      // update screenBuffer
> @@ -643,51 +633,6 @@ - (void) switchSurface:(pixman_image_t *)image
>      }
>
>      pixman_image =3D image;
> -
> -    // update windows
> -    if (isFullscreen) {
> -        [[fullScreenWindow contentView] setFrame:[[NSScreen mainScreen]
> frame]];
> -        [normalWindow setFrame:NSMakeRect([normalWindow frame].origin.x,
> [normalWindow frame].origin.y - h + oldh, w, h + [normalWindow
> frame].size.height - oldh) display:NO animate:NO];
> -    } else {
> -        if (qemu_name)
> -            [normalWindow setTitle:[NSString stringWithFormat:@"QEMU
> %s", qemu_name]];
> -        [normalWindow setFrame:NSMakeRect([normalWindow frame].origin.x,
> [normalWindow frame].origin.y - h + oldh, w, h + [normalWindow
> frame].size.height - oldh) display:YES animate:NO];
> -    }
> -
> -    if (isResize) {
> -        [normalWindow center];
> -    }
> -}
> -
> -- (void) toggleFullScreen:(id)sender
> -{
> -    COCOA_DEBUG("QemuCocoaView: toggleFullScreen\n");
> -
> -    if (isFullscreen) { // switch from fullscreen to desktop
> -        isFullscreen =3D FALSE;
> -        [self ungrabMouse];
> -        [self setContentDimensions];
> -        [fullScreenWindow close];
> -        [normalWindow setContentView: self];
> -        [normalWindow makeKeyAndOrderFront: self];
> -        [NSMenu setMenuBarVisible:YES];
> -    } else { // switch from desktop to fullscreen
> -        isFullscreen =3D TRUE;
> -        [normalWindow orderOut: nil]; /* Hide the window */
> -        [self grabMouse];
> -        [self setContentDimensions];
> -        [NSMenu setMenuBarVisible:NO];
> -        fullScreenWindow =3D [[NSWindow alloc]
> initWithContentRect:[[NSScreen mainScreen] frame]
> -            styleMask:NSWindowStyleMaskBorderless
> -            backing:NSBackingStoreBuffered
> -            defer:NO];
> -        [fullScreenWindow setAcceptsMouseMovedEvents: YES];
> -        [fullScreenWindow setHasShadow:NO];
> -        [fullScreenWindow setBackgroundColor: [NSColor blackColor]];
> -        [self setFrame:NSMakeRect(cx, cy, cw, ch)];
> -        [[fullScreenWindow contentView] addSubview: self];
> -        [fullScreenWindow makeKeyAndOrderFront:self];
> -    }
>  }
>
>  - (void) setFullGrab:(id)sender
> @@ -801,9 +746,6 @@ - (bool) handleEventLocked:(NSEvent *)event
>      COCOA_DEBUG("QemuCocoaView: handleEvent\n");
>      int buttons =3D 0;
>      int keycode =3D 0;
> -    bool mouse_event =3D false;
> -    // Location of event in virtual screen coordinates
> -    NSPoint p =3D [self screenLocationOfEvent:event];
>      NSUInteger modifiers =3D [event modifierFlags];
>
>      /*
> @@ -883,25 +825,25 @@ - (bool) handleEventLocked:(NSEvent *)event
>                      if (!!(modifiers & NSEventModifierFlagShift)) {
>                          [self toggleKey:Q_KEY_CODE_SHIFT];
>                      }
> -                    break;
> +                    return true;
>
>                  case kVK_RightShift:
>                      if (!!(modifiers & NSEventModifierFlagShift)) {
>                          [self toggleKey:Q_KEY_CODE_SHIFT_R];
>                      }
> -                    break;
> +                    return true;
>
>                  case kVK_Control:
>                      if (!!(modifiers & NSEventModifierFlagControl)) {
>                          [self toggleKey:Q_KEY_CODE_CTRL];
>                      }
> -                    break;
> +                    return true;
>
>                  case kVK_RightControl:
>                      if (!!(modifiers & NSEventModifierFlagControl)) {
>                          [self toggleKey:Q_KEY_CODE_CTRL_R];
>                      }
> -                    break;
> +                    return true;
>
>                  case kVK_Option:
>                      if (!!(modifiers & NSEventModifierFlagOption)) {
> @@ -911,7 +853,7 @@ - (bool) handleEventLocked:(NSEvent *)event
>                              [self toggleKey:Q_KEY_CODE_ALT];
>                          }
>                      }
> -                    break;
> +                    return true;
>
>                  case kVK_RightOption:
>                      if (!!(modifiers & NSEventModifierFlagOption)) {
> @@ -921,7 +863,7 @@ - (bool) handleEventLocked:(NSEvent *)event
>                              [self toggleKey:Q_KEY_CODE_ALT_R];
>                          }
>                      }
> -                    break;
> +                    return true;
>
>                  /* Don't pass command key changes to guest unless mouse
> is grabbed */
>                  case kVK_Command:
> @@ -934,7 +876,7 @@ - (bool) handleEventLocked:(NSEvent *)event
>                              [self toggleKey:Q_KEY_CODE_META_L];
>                          }
>                      }
> -                    break;
> +                    return true;
>
>                  case kVK_RightCommand:
>                      if (isMouseGrabbed &&
> @@ -945,9 +887,11 @@ - (bool) handleEventLocked:(NSEvent *)event
>                              [self toggleKey:Q_KEY_CODE_META_R];
>                          }
>                      }
> -                    break;
> +                    return true;
> +
> +                default:
> +                    return true;
>              }
> -            break;
>          case NSEventTypeKeyDown:
>              keycode =3D cocoa_keycode_to_qemu([event keyCode]);
>
> @@ -983,7 +927,7 @@ - (bool) handleEventLocked:(NSEvent *)event
>              } else {
>                  [self handleMonitorInput: event];
>              }
> -            break;
> +            return true;
>          case NSEventTypeKeyUp:
>              keycode =3D cocoa_keycode_to_qemu([event keyCode]);
>
> @@ -996,67 +940,7 @@ - (bool) handleEventLocked:(NSEvent *)event
>              if (qemu_console_is_graphic(NULL)) {
>                  qkbd_state_key_event(kbd, keycode, false);
>              }
> -            break;
> -        case NSEventTypeMouseMoved:
> -            if (isAbsoluteEnabled) {
> -                // Cursor re-entered into a window might generate events
> bound to screen coordinates
> -                // and `nil` window property, and in full screen mode,
> current window might not be
> -                // key window, where event location alone should suffice=
.
> -                if (![self screenContainsPoint:p] || !([[self window]
> isKeyWindow] || isFullscreen)) {
> -                    if (isMouseGrabbed) {
> -                        [self ungrabMouse];
> -                    }
> -                } else {
> -                    if (!isMouseGrabbed) {
> -                        [self grabMouse];
> -                    }
> -                }
> -            }
> -            mouse_event =3D true;
> -            break;
> -        case NSEventTypeLeftMouseDown:
> -            buttons |=3D MOUSE_EVENT_LBUTTON;
> -            mouse_event =3D true;
> -            break;
> -        case NSEventTypeRightMouseDown:
> -            buttons |=3D MOUSE_EVENT_RBUTTON;
> -            mouse_event =3D true;
> -            break;
> -        case NSEventTypeOtherMouseDown:
> -            buttons |=3D MOUSE_EVENT_MBUTTON;
> -            mouse_event =3D true;
> -            break;
> -        case NSEventTypeLeftMouseDragged:
> -            buttons |=3D MOUSE_EVENT_LBUTTON;
> -            mouse_event =3D true;
> -            break;
> -        case NSEventTypeRightMouseDragged:
> -            buttons |=3D MOUSE_EVENT_RBUTTON;
> -            mouse_event =3D true;
> -            break;
> -        case NSEventTypeOtherMouseDragged:
> -            buttons |=3D MOUSE_EVENT_MBUTTON;
> -            mouse_event =3D true;
> -            break;
> -        case NSEventTypeLeftMouseUp:
> -            mouse_event =3D true;
> -            if (!isMouseGrabbed && [self screenContainsPoint:p]) {
> -                /*
> -                 * In fullscreen mode, the window of cocoaView may not b=
e
> the
> -                 * key window, therefore the position relative to the
> virtual
> -                 * screen alone will be sufficient.
> -                 */
> -                if(isFullscreen || [[self window] isKeyWindow]) {
> -                    [self grabMouse];
> -                }
> -            }
> -            break;
> -        case NSEventTypeRightMouseUp:
> -            mouse_event =3D true;
> -            break;
> -        case NSEventTypeOtherMouseUp:
> -            mouse_event =3D true;
> -            break;
> +            return true;
>          case NSEventTypeScrollWheel:
>              /*
>               * Send wheel events to the guest regardless of window focus=
.
> @@ -1087,62 +971,124 @@ - (bool) handleEventLocked:(NSEvent *)event
>               * Since deltaX/deltaY also report scroll wheel events we
> prevent mouse
>               * movement code from executing.
>               */
> -            mouse_event =3D false;
> -            break;
> +            return true;
>          default:
>              return false;
>      }
> +}
>
> -    if (mouse_event) {
> -        /* Don't send button events to the guest unless we've got a
> -         * mouse grab or window focus. If we have neither then this even=
t
> -         * is the user clicking on the background window to activate and
> -         * bring us to the front, which will be done by the sendEvent
> -         * call below. We definitely don't want to pass that click throu=
gh
> -         * to the guest.
> -         */
> -        if ((isMouseGrabbed || [[self window] isKeyWindow]) &&
> -            (last_buttons !=3D buttons)) {
> -            static uint32_t bmap[INPUT_BUTTON__MAX] =3D {
> -                [INPUT_BUTTON_LEFT]       =3D MOUSE_EVENT_LBUTTON,
> -                [INPUT_BUTTON_MIDDLE]     =3D MOUSE_EVENT_MBUTTON,
> -                [INPUT_BUTTON_RIGHT]      =3D MOUSE_EVENT_RBUTTON
> -            };
> -            qemu_input_update_buttons(dcl.con, bmap, last_buttons,
> buttons);
> -            last_buttons =3D buttons;
> -        }
> -        if (isMouseGrabbed) {
> -            if (isAbsoluteEnabled) {
> -                /* Note that the origin for Cocoa mouse coords is bottom
> left, not top left.
> -                 * The check on screenContainsPoint is to avoid sending
> out of range values for
> -                 * clicks in the titlebar.
> -                 */
> -                if ([self screenContainsPoint:p]) {
> -                    qemu_input_queue_abs(dcl.con, INPUT_AXIS_X, p.x, 0,
> screen.width);
> -                    qemu_input_queue_abs(dcl.con, INPUT_AXIS_Y,
> screen.height - p.y, 0, screen.height);
> -                }
> -            } else {
> -                qemu_input_queue_rel(dcl.con, INPUT_AXIS_X, (int)[event
> deltaX]);
> -                qemu_input_queue_rel(dcl.con, INPUT_AXIS_Y, (int)[event
> deltaY]);
> -            }
> +- (void) handleMouseEvent:(NSEvent *)event
> +{
> +    if (!isMouseGrabbed) {
> +        return;
> +    }
> +
> +    with_iothread_lock(^{
> +        if (isAbsoluteEnabled) {
> +            CGFloat d =3D (CGFloat)screen.height / [self frame].size.hei=
ght;
> +            NSPoint p =3D [event locationInWindow];
> +            // Note that the origin for Cocoa mouse coords is bottom
> left, not top left.
> +            qemu_input_queue_abs(dcl.con, INPUT_AXIS_X, p.x * d, 0,
> screen.width);
> +            qemu_input_queue_abs(dcl.con, INPUT_AXIS_Y, screen.height -
> p.y * d, 0, screen.height);
>          } else {
> -            return false;
> +            CGFloat d =3D (CGFloat)screen.height / [self
> convertSizeToBacking:[self frame].size].height;
> +            qemu_input_queue_rel(dcl.con, INPUT_AXIS_X, [event deltaX] *
> d);
> +            qemu_input_queue_rel(dcl.con, INPUT_AXIS_Y, [event deltaY] *
> d);
>          }
> +
>          qemu_input_event_sync();
> +    });
> +}
> +
> +- (void) handleMouseEvent:(NSEvent *)event button:(InputButton)button
> down:(bool)down
> +{
> +    if (!isMouseGrabbed) {
> +        return;
>      }
> -    return true;
> +
> +    with_iothread_lock(^{
> +        qemu_input_queue_btn(dcl.con, button, down);
> +    });
> +
> +    [self handleMouseEvent:event];
> +}
> +
> +- (void) mouseExited:(NSEvent *)event
> +{
> +    if (isAbsoluteEnabled && isMouseGrabbed) {
> +        [self ungrabMouse];
> +    }
> +}
> +
> +- (void) mouseEntered:(NSEvent *)event
> +{
> +    if (isAbsoluteEnabled && !isMouseGrabbed) {
> +        [self grabMouse];
> +    }
> +}
> +
> +- (void) mouseMoved:(NSEvent *)event
> +{
> +    [self handleMouseEvent:event];
> +}
> +
> +- (void) mouseDown:(NSEvent *)event
> +{
> +    [self handleMouseEvent:event button:INPUT_BUTTON_LEFT down:true];
> +}
> +
> +- (void) rightMouseDown:(NSEvent *)event
> +{
> +    [self handleMouseEvent:event button:INPUT_BUTTON_RIGHT down:true];
> +}
> +
> +- (void) otherMouseDown:(NSEvent *)event
> +{
> +    [self handleMouseEvent:event button:INPUT_BUTTON_MIDDLE down:true];
> +}
> +
> +- (void) mouseDragged:(NSEvent *)event
> +{
> +    [self handleMouseEvent:event];
> +}
> +
> +- (void) rightMouseDragged:(NSEvent *)event
> +{
> +    [self handleMouseEvent:event];
> +}
> +
> +- (void) otherMouseDragged:(NSEvent *)event
> +{
> +    [self handleMouseEvent:event];
> +}
> +
> +- (void) mouseUp:(NSEvent *)event
> +{
> +    if (!isMouseGrabbed) {
> +        [self grabMouse];
> +    }
> +
> +    [self handleMouseEvent:event button:INPUT_BUTTON_LEFT down:false];
> +}
> +
> +- (void) rightMouseUp:(NSEvent *)event
> +{
> +    [self handleMouseEvent:event button:INPUT_BUTTON_RIGHT down:false];
> +}
> +
> +- (void) otherMouseUp:(NSEvent *)event
> +{
> +    [self handleMouseEvent:event button:INPUT_BUTTON_MIDDLE down:false];
>  }
>
>  - (void) grabMouse
>  {
>      COCOA_DEBUG("QemuCocoaView: grabMouse\n");
>
> -    if (!isFullscreen) {
> -        if (qemu_name)
> -            [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s
> - (Press  " UC_CTRL_KEY " " UC_ALT_KEY " G  to release Mouse)", qemu_name=
]];
> -        else
> -            [normalWindow setTitle:@"QEMU - (Press  " UC_CTRL_KEY " "
> UC_ALT_KEY " G  to release Mouse)"];
> -    }
> +    if (qemu_name)
> +        [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s -
> (Press  " UC_CTRL_KEY " " UC_ALT_KEY " G  to release Mouse)", qemu_name]]=
;
> +    else
> +        [normalWindow setTitle:@"QEMU - (Press  " UC_CTRL_KEY " "
> UC_ALT_KEY " G  to release Mouse)"];
>      [self hideCursor];
>      CGAssociateMouseAndMouseCursorPosition(isAbsoluteEnabled);
>      isMouseGrabbed =3D TRUE; // while isMouseGrabbed =3D TRUE, QemuCocoa=
App
> sends all events to [cocoaView handleEvent:]
> @@ -1152,15 +1098,14 @@ - (void) ungrabMouse
>  {
>      COCOA_DEBUG("QemuCocoaView: ungrabMouse\n");
>
> -    if (!isFullscreen) {
> -        if (qemu_name)
> -            [normalWindow setTitle:[NSString stringWithFormat:@"QEMU
> %s", qemu_name]];
> -        else
> -            [normalWindow setTitle:@"QEMU"];
> -    }
> +    if (qemu_name)
> +        [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s",
> qemu_name]];
> +    else
> +        [normalWindow setTitle:@"QEMU"];
>      [self unhideCursor];
>      CGAssociateMouseAndMouseCursorPosition(TRUE);
>      isMouseGrabbed =3D FALSE;
> +    [self raiseAllButtons];
>  }
>
>  - (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled {
> @@ -1171,8 +1116,6 @@ - (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnable=
d
> {
>  }
>  - (BOOL) isMouseGrabbed {return isMouseGrabbed;}
>  - (BOOL) isAbsoluteEnabled {return isAbsoluteEnabled;}
> -- (float) cdx {return cdx;}
> -- (float) cdy {return cdy;}
>  - (QEMUScreen) gscreen {return screen;}
>
>  /*
> @@ -1186,6 +1129,15 @@ - (void) raiseAllKeys
>          qkbd_state_lift_all_keys(kbd);
>      });
>  }
> +
> +- (void) raiseAllButtons
> +{
> +    with_iothread_lock(^{
> +        qemu_input_queue_btn(dcl.con, INPUT_BUTTON_LEFT, false);
> +        qemu_input_queue_btn(dcl.con, INPUT_BUTTON_RIGHT, false);
> +        qemu_input_queue_btn(dcl.con, INPUT_BUTTON_MIDDLE, false);
> +    });
> +}
>  @end
>
>
> @@ -1200,7 +1152,6 @@ @interface QemuCocoaAppController : NSObject
>  {
>  }
>  - (void)doToggleFullScreen:(id)sender;
> -- (void)toggleFullScreen:(id)sender;
>  - (void)showQEMUDoc:(id)sender;
>  - (void)zoomToFit:(id) sender;
>  - (void)displayConsole:(id)sender;
> @@ -1242,7 +1193,8 @@ - (id) init
>              exit(1);
>          }
>          [normalWindow setAcceptsMouseMovedEvents:YES];
> -        [normalWindow setTitle:@"QEMU"];
> +        [normalWindow
> setCollectionBehavior:NSWindowCollectionBehaviorFullScreenPrimary];
> +        [normalWindow setTitle:qemu_name ? [NSString stringWithFormat:@"=
QEMU
> %s", qemu_name] : @"QEMU"];
>          [normalWindow setContentView:cocoaView];
>          [normalWindow makeKeyAndOrderFront:self];
>          [normalWindow center];
> @@ -1312,9 +1264,20 @@ - (void)windowDidChangeScreen:(NSNotification
> *)notification
>      [cocoaView updateUIInfo];
>  }
>
> +- (void)windowDidEnterFullScreen:(NSNotification *)notification
> +{
> +    [cocoaView grabMouse];
> +}
> +
> +- (void)windowDidExitFullScreen:(NSNotification *)notification
> +{
> +    [cocoaView resizeWindow];
> +    [cocoaView ungrabMouse];
> +}
> +
>  - (void)windowDidResize:(NSNotification *)notification
>  {
> -    [cocoaView updateUIInfo];
> +    [cocoaView frameUpdated];
>  }
>
>  /* Called when the user clicks on a window's close button */
> @@ -1330,6 +1293,23 @@ - (BOOL)windowShouldClose:(id)sender
>      return NO;
>  }
>
> +- (NSSize) window:(NSWindow *)window
> willUseFullScreenContentSize:(NSSize)proposedSize
> +{
> +    if (([normalWindow styleMask] & NSWindowStyleMaskResizable) =3D=3D 0=
) {
> +        return NSMakeSize([cocoaView gscreen].width, [cocoaView
> gscreen].height);
> +    }
> +
> +    return [cocoaView fixZoomedFullScreenSize:proposedSize];
> +}
> +
> +- (NSApplicationPresentationOptions) window:(NSWindow *)window
> +
>  willUseFullScreenPresentationOptions:(NSApplicationPresentationOptions)p=
roposedOptions;
> +
> +{
> +    return (proposedOptions & ~(NSApplicationPresentationAutoHideDock |
> NSApplicationPresentationAutoHideMenuBar)) |
> +           NSApplicationPresentationHideDock |
> NSApplicationPresentationHideMenuBar;
> +}
> +
>  /*
>   * Called when QEMU goes into the background. Note that
>   * [-NSWindowDelegate windowDidResignKey:] is used here instead of
> @@ -1349,14 +1329,7 @@ - (void) windowDidResignKey: (NSNotification
> *)aNotification
>   */
>  - (void) doToggleFullScreen:(id)sender
>  {
> -    [self toggleFullScreen:(id)sender];
> -}
> -
> -- (void)toggleFullScreen:(id)sender
> -{
> -    COCOA_DEBUG("QemuCocoaAppController: toggleFullScreen\n");
> -
> -    [cocoaView toggleFullScreen:sender];
> +    [normalWindow toggleFullScreen:sender];
>  }
>
>  - (void) setFullGrab:(id)sender
> @@ -1400,13 +1373,15 @@ - (void)showQEMUDoc:(id)sender
>      [self openDocumentation: @"index.html"];
>  }
>
> -/* Stretches video to fit host monitor size */
> +/* Toggles the flag which stretches video to fit host window size */
>  - (void)zoomToFit:(id) sender
>  {
> -    stretch_video =3D !stretch_video;
> -    if (stretch_video =3D=3D true) {
> +    if (([normalWindow styleMask] & NSWindowStyleMaskResizable) =3D=3D 0=
) {
> +        [normalWindow setStyleMask:[normalWindow styleMask] |
> NSWindowStyleMaskResizable];
>          [sender setState: NSControlStateValueOn];
>      } else {
> +        [normalWindow setStyleMask:[normalWindow styleMask] &
> ~NSWindowStyleMaskResizable];
> +        [cocoaView resizeWindow];
>          [sender setState: NSControlStateValueOff];
>      }
>  }
> @@ -1414,7 +1389,9 @@ - (void)zoomToFit:(id) sender
>  /* Displays the console on the screen */
>  - (void)displayConsole:(id)sender
>  {
> -    console_select([sender tag]);
> +    with_iothread_lock(^{
> +        console_select([sender tag]);
> +    });
>  }
>
>  /* Pause the guest */
> @@ -1671,7 +1648,7 @@ static void create_initial_menus(void)
>      menu =3D [[NSMenu alloc] initWithTitle:@"View"];
>      [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"Enter
> Fullscreen" action:@selector(doToggleFullScreen:) keyEquivalent:@"f"]
> autorelease]]; // Fullscreen
>      menuItem =3D [[[NSMenuItem alloc] initWithTitle:@"Zoom To Fit"
> action:@selector(zoomToFit:) keyEquivalent:@""] autorelease];
> -    [menuItem setState: stretch_video ? NSControlStateValueOn :
> NSControlStateValueOff];
> +    [menuItem setState: [normalWindow styleMask] &
> NSWindowStyleMaskResizable ? NSControlStateValueOn :
> NSControlStateValueOff];
>      [menu addItem: menuItem];
>      menuItem =3D [[[NSMenuItem alloc] initWithTitle:@"View" action:nil
> keyEquivalent:@""] autorelease];
>      [menuItem setSubmenu:menu];
> @@ -1962,16 +1939,14 @@ static void cocoa_update(DisplayChangeListener
> *dcl,
>      COCOA_DEBUG("qemu_cocoa: cocoa_update\n");
>
>      dispatch_async(dispatch_get_main_queue(), ^{
> -        NSRect rect;
> -        if ([cocoaView cdx] =3D=3D 1.0) {
> -            rect =3D NSMakeRect(x, [cocoaView gscreen].height - y - h, w=
,
> h);
> -        } else {
> -            rect =3D NSMakeRect(
> -                x * [cocoaView cdx],
> -                ([cocoaView gscreen].height - y - h) * [cocoaView cdy],
> -                w * [cocoaView cdx],
> -                h * [cocoaView cdy]);
> -        }
> +        CGFloat d =3D [cocoaView frame].size.height / (CGFloat)[cocoaVie=
w
> gscreen].height;
> +
> +        NSRect rect =3D NSMakeRect(
> +                x * d,
> +                ([cocoaView gscreen].height - y - h) * d,
> +                w * d,
> +                h * d);
> +
>          [cocoaView setNeedsDisplayInRect:rect];
>      });
>  }
> @@ -2048,8 +2023,7 @@ static void cocoa_display_init(DisplayState *ds,
> DisplayOptions *opts)
>
>      /* if fullscreen mode is to be used */
>      if (opts->has_full_screen && opts->full_screen) {
> -        [NSApp activateIgnoringOtherApps: YES];
> -        [controller toggleFullScreen: nil];
> +        [normalWindow toggleFullScreen: nil];
>      }
>      if (opts->u.cocoa.has_full_grab && opts->u.cocoa.full_grab) {
>          [controller setFullGrab: nil];
> @@ -2067,7 +2041,7 @@ static void cocoa_display_init(DisplayState *ds,
> DisplayOptions *opts)
>      }
>
>      if (opts->u.cocoa.has_zoom_to_fit && opts->u.cocoa.zoom_to_fit) {
> -        stretch_video =3D true;
> +        [normalWindow setStyleMask:[normalWindow styleMask] &
> ~NSWindowStyleMaskResizable];
>      }
>
>      create_initial_menus();
>
> ---
> base-commit: 9c74490bff6c8886a922008d0c9ce6cae70dd17e
> change-id: 20231211-cocoa-576b8639e9bd
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>
>
>
>

--000000000000b58f2d060c4b81b2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi</div><div><br></div><div>I checke=
d on the emulation &quot;qemu-system-ppc -machine pegasos&quot;.</div><div>=
Full-screen seems to work fine. The screen is correctly initialised in full=
-screen mode and there are no problems with closing the window when the ses=
sion is suspended.</div><div>With this series of patches, there is also the=
 option &quot;Move to&quot;, which makes it possible to move the screen to =
an external device such as an IPad.</div><div>Thank you for the ui/cocoa ac=
umen</div><div><br></div><div>Additionally, how can I use this message on q=
emu-devel.</div><div>It has a post for people who use Macos or Asahi Linux.=
 Verify random qemu sessions under Macos .Some are faster others are slow.<=
/div><div>The topic is posted on <a href=3D"mailto:qemu-discuss@nongnu.org"=
>qemu-discuss@nongnu.org</a> (I don&#39;t know if developers look there oft=
en)</div><div><br></div><div><a href=3D"https://lists.nongnu.org/archive/ht=
ml/qemu-discuss/2023-12/msg00008.html">https://lists.nongnu.org/archive/htm=
l/qemu-discuss/2023-12/msg00008.html</a></div><div><br></div><div>The progr=
am posted there was prepared by one of the maintainers of ppc qemu machines=
 &quot;BALATON Zoltan&quot;.</div><div>We are starting to gather as much in=
formation as possible for it.</div><div>I hope nobody will be offended abou=
t this information in this topic. I do not want to start a topic and litter=
 other lists</div><div><br></div><div>Best regards=C2=A0</div><div>Marek G=
=C5=82ogowski</div><div><br></div></div></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">wt., 12 gru 2023 o 00:09=C2=A0Akihi=
ko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@dayn=
ix.com</a>&gt; napisa=C5=82(a):<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">This change brings two new features:<br>
- The window will be resizable if &quot;Zoom To Fit&quot; is eanbled<br>
- The window can be made full screen by clicking full screen button<br>
=C2=A0 provided by the platform. (The left-top green button.)<br>
<br>
Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com=
" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
---<br>
V5 -&gt; V6:<br>
=C2=A0 Rebased.<br>
---<br>
=C2=A0ui/cocoa.m | 542 +++++++++++++++++++++++++++++-----------------------=
---------<br>
=C2=A01 file changed, 258 insertions(+), 284 deletions(-)<br>
<br>
diff --git a/ui/cocoa.m b/ui/cocoa.m<br>
index cd069da696..302e4f76be 100644<br>
--- a/ui/cocoa.m<br>
+++ b/ui/cocoa.m<br>
@@ -99,12 +99,10 @@ static void cocoa_switch(DisplayChangeListener *dcl,<br=
>
=C2=A0static DisplayChangeListener dcl =3D {<br>
=C2=A0 =C2=A0 =C2=A0.ops =3D &amp;dcl_ops,<br>
=C2=A0};<br>
-static int last_buttons;<br>
=C2=A0static int cursor_hide =3D 1;<br>
=C2=A0static int left_command_key_enabled =3D 1;<br>
=C2=A0static bool swap_opt_cmd;<br>
<br>
-static bool stretch_video;<br>
=C2=A0static NSTextField *pauseLabel;<br>
<br>
=C2=A0static bool allow_events;<br>
@@ -304,20 +302,17 @@ static void handleAnyDeviceErrors(Error * err)<br>
=C2=A0*/<br>
=C2=A0@interface QemuCocoaView : NSView<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 NSTrackingArea *trackingArea;<br>
=C2=A0 =C2=A0 =C2=A0QEMUScreen screen;<br>
-=C2=A0 =C2=A0 NSWindow *fullScreenWindow;<br>
-=C2=A0 =C2=A0 float cx,cy,cw,ch,cdx,cdy;<br>
=C2=A0 =C2=A0 =C2=A0pixman_image_t *pixman_image;<br>
=C2=A0 =C2=A0 =C2=A0QKbdState *kbd;<br>
=C2=A0 =C2=A0 =C2=A0BOOL isMouseGrabbed;<br>
-=C2=A0 =C2=A0 BOOL isFullscreen;<br>
=C2=A0 =C2=A0 =C2=A0BOOL isAbsoluteEnabled;<br>
=C2=A0 =C2=A0 =C2=A0CFMachPortRef eventsTap;<br>
=C2=A0}<br>
=C2=A0- (void) switchSurface:(pixman_image_t *)image;<br>
=C2=A0- (void) grabMouse;<br>
=C2=A0- (void) ungrabMouse;<br>
-- (void) toggleFullScreen:(id)sender;<br>
=C2=A0- (void) setFullGrab:(id)sender;<br>
=C2=A0- (void) handleMonitorInput:(NSEvent *)event;<br>
=C2=A0- (bool) handleEvent:(NSEvent *)event;<br>
@@ -333,8 +328,6 @@ - (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled;<b=
r>
=C2=A0 */<br>
=C2=A0- (BOOL) isMouseGrabbed;<br>
=C2=A0- (BOOL) isAbsoluteEnabled;<br>
-- (float) cdx;<br>
-- (float) cdy;<br>
=C2=A0- (QEMUScreen) gscreen;<br>
=C2=A0- (void) raiseAllKeys;<br>
=C2=A0@end<br>
@@ -392,46 +385,43 @@ - (BOOL) isOpaque<br>
=C2=A0 =C2=A0 =C2=A0return YES;<br>
=C2=A0}<br>
<br>
-- (BOOL) screenContainsPoint:(NSPoint) p<br>
+- (void) removeTrackingRect<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return (p.x &gt; -1 &amp;&amp; p.x &lt; screen.width &amp;&a=
mp; p.y &gt; -1 &amp;&amp; p.y &lt; screen.height);<br>
+=C2=A0 =C2=A0 if (trackingArea) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [self removeTrackingArea:trackingArea];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [trackingArea release];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trackingArea =3D nil;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
-/* Get location of event and convert to virtual screen coordinate */<br>
-- (CGPoint) screenLocationOfEvent:(NSEvent *)ev<br>
+- (void) frameUpdated<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 NSWindow *eventWindow =3D [ev window];<br>
-=C2=A0 =C2=A0 // XXX: Use CGRect and -convertRectFromScreen: to support ma=
cOS 10.10<br>
-=C2=A0 =C2=A0 CGRect r =3D CGRectZero;<br>
-=C2=A0 =C2=A0 r.origin =3D [ev locationInWindow];<br>
-=C2=A0 =C2=A0 if (!eventWindow) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!isFullscreen) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return [[self window] convertRec=
tFromScreen:r].origin;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CGPoint locationInSelfWindow =3D=
 [[self window] convertRectFromScreen:r].origin;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CGPoint loc =3D [self convertPoi=
nt:locationInSelfWindow fromView:nil];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (stretch_video) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 loc.x /=3D cdx;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 loc.y /=3D cdy;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return loc;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 } else if ([[self window] isEqual:eventWindow]) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!isFullscreen) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r.origin;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CGPoint loc =3D [self convertPoi=
nt:r.origin fromView:nil];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (stretch_video) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 loc.x /=3D cdx;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 loc.y /=3D cdy;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return loc;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return [[self window] convertRectFromScreen:[e=
ventWindow convertRectToScreen:r]].origin;<br>
+=C2=A0 =C2=A0 [self removeTrackingRect];<br>
+<br>
+=C2=A0 =C2=A0 if ([self window]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 NSTrackingAreaOptions options =3D NSTrackingAc=
tiveInKeyWindow |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NSTracki=
ngMouseEnteredAndExited |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NSTracki=
ngMouseMoved;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trackingArea =3D [[NSTrackingArea alloc] initW=
ithRect:[self frame]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options:options<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 owner:self<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0userInfo:nil];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [self addTrackingArea:trackingArea];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [self updateUIInfo];<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+- (void) viewDidMoveToWindow<br>
+{<br>
+=C2=A0 =C2=A0 [self resizeWindow];<br>
+=C2=A0 =C2=A0 [self frameUpdated];<br>
+}<br>
+<br>
+- (void) viewWillMoveToWindow:(NSWindow *)newWindow<br>
+{<br>
+=C2=A0 =C2=A0 [self removeTrackingRect];<br>
+}<br>
+<br>
=C2=A0- (void) hideCursor<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (!cursor_hide) {<br>
@@ -494,13 +484,14 @@ - (void) drawRect:(NSRect) rect<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CGImageRef clipImageRef;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CGRect clipRect;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CGFloat d =3D (CGFloat)h / [self frame].size.h=
eight;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[self getRectsBeingDrawn:&amp;rectList co=
unt:&amp;rectCount];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; rectCount; i++) {<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clipRect.origin.x =3D rectList[i=
].origin.x / cdx;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clipRect.origin.y =3D (float)h -=
 (rectList[i].origin.y + rectList[i].size.height) / cdy;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clipRect.size.width =3D rectList=
[i].size.width / cdx;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clipRect.size.height =3D rectLis=
t[i].size.height / cdy;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clipRect.origin.x =3D rectList[i=
].origin.x * d;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clipRect.origin.y =3D (float)h -=
 (rectList[i].origin.y + rectList[i].size.height) * d;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clipRect.size.width =3D rectList=
[i].size.width * d;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clipRect.size.height =3D rectLis=
t[i].size.height * d;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clipImageRef =3D CGImageCre=
ateWithImageInRect(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0imageRef,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clipRect<br>
@@ -513,36 +504,43 @@ - (void) drawRect:(NSRect) rect<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-- (void) setContentDimensions<br>
+- (NSSize) fixZoomedFullScreenSize:(NSSize)proposedSize<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 COCOA_DEBUG(&quot;QemuCocoaView: setContentDimensions\n&quot=
;);<br>
+=C2=A0 =C2=A0 NSSize size;<br>
<br>
-=C2=A0 =C2=A0 if (isFullscreen) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cdx =3D [[NSScreen mainScreen] frame].size.wid=
th / (float)screen.width;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cdy =3D [[NSScreen mainScreen] frame].size.hei=
ght / (float)screen.height;<br>
+=C2=A0 =C2=A0 size.width =3D (CGFloat)screen.width * proposedSize.height;<=
br>
+=C2=A0 =C2=A0 size.height =3D (CGFloat)screen.height * proposedSize.width;=
<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* stretches video, but keeps same aspect rati=
o */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (stretch_video =3D=3D true) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* use smallest stretch value - =
prevents clipping on sides */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (MIN(cdx, cdy) =3D=3D cdx) {<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cdy =3D cdx;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cdx =3D cdy;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {=C2=A0 /* No stretching */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cdx =3D cdy =3D 1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cw =3D screen.width * cdx;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ch =3D screen.height * cdy;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cx =3D ([[NSScreen mainScreen] frame].size.wid=
th - cw) / 2.0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cy =3D ([[NSScreen mainScreen] frame].size.hei=
ght - ch) / 2.0;<br>
+=C2=A0 =C2=A0 if (size.width &lt; size.height) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 size.width /=3D screen.height;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 size.height =3D proposedSize.height;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cx =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cy =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cw =3D screen.width;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ch =3D screen.height;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cdx =3D 1.0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cdy =3D 1.0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 size.width =3D proposedSize.width;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 size.height /=3D screen.width;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return size;<br>
+}<br>
+<br>
+- (NSSize) screenSafeAreaSize<br>
+{<br>
+=C2=A0 =C2=A0 NSSize size =3D [[[self window] screen] frame].size;<br>
+=C2=A0 =C2=A0 NSEdgeInsets insets =3D [[[self window] screen] safeAreaInse=
ts];<br>
+=C2=A0 =C2=A0 size.width -=3D insets.left + insets.right;<br>
+=C2=A0 =C2=A0 size.height -=3D insets.top + insets.bottom;<br>
+=C2=A0 =C2=A0 return size;<br>
+}<br>
+<br>
+- (void) resizeWindow<br>
+{<br>
+=C2=A0 =C2=A0 [[self window] setContentAspectRatio:NSMakeSize(screen.width=
, screen.height)];<br>
+<br>
+=C2=A0 =C2=A0 if (([[self window] styleMask] &amp; NSWindowStyleMaskResiza=
ble) =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [[self window] setContentSize:NSMakeSize(scree=
n.width, screen.height)];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [[self window] center];<br>
+=C2=A0 =C2=A0 } else if (([[self window] styleMask] &amp; NSWindowStyleMas=
kFullScreen) !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [[self window] setContentSize:[self fixZoomedF=
ullScreenSize:[self screenSafeAreaSize]]];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [[self window] center];<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
@@ -563,7 +561,11 @@ - (void) updateUIInfoLocked<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CGSize screenPhysicalSize =3D CGDisplaySc=
reenSize(display);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CVDisplayLinkRef displayLink;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 frameSize =3D isFullscreen ? screenSize : [sel=
f frame].size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (([[self window] styleMask] &amp; NSWindowS=
tyleMaskFullScreen) =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 frameSize =3D [self frame].size;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 frameSize =3D [self screenSafeAr=
eaSize];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!CVDisplayLinkCreateWithCGDisplay(dis=
play, &amp;displayLink)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CVTime period =3D CVDisplay=
LinkGetNominalOutputVideoRefreshPeriod(displayLink);<br>
@@ -610,31 +612,19 @@ - (void) updateUIInfo<br>
=C2=A0 =C2=A0 =C2=A0});<br>
=C2=A0}<br>
<br>
-- (void)viewDidMoveToWindow<br>
-{<br>
-=C2=A0 =C2=A0 [self updateUIInfo];<br>
-}<br>
-<br>
=C2=A0- (void) switchSurface:(pixman_image_t *)image<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0COCOA_DEBUG(&quot;QemuCocoaView: switchSurface\n&quot;)=
;<br>
<br>
=C2=A0 =C2=A0 =C2=A0int w =3D pixman_image_get_width(image);<br>
=C2=A0 =C2=A0 =C2=A0int h =3D pixman_image_get_height(image);<br>
-=C2=A0 =C2=A0 /* cdx =3D=3D 0 means this is our very first surface, in whi=
ch case we need<br>
-=C2=A0 =C2=A0 =C2=A0* to recalculate the content dimensions even if it hap=
pens to be the size<br>
-=C2=A0 =C2=A0 =C2=A0* of the initial empty window.<br>
-=C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 bool isResize =3D (w !=3D screen.width || h !=3D screen.heig=
ht || cdx =3D=3D 0.0);<br>
<br>
-=C2=A0 =C2=A0 int oldh =3D screen.height;<br>
-=C2=A0 =C2=A0 if (isResize) {<br>
+=C2=A0 =C2=A0 if (w !=3D screen.width || h !=3D screen.height) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// Resize before we trigger the redraw, o=
r we&#39;ll redraw at the wrong size<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0COCOA_DEBUG(&quot;switchSurface: new size=
 %d x %d\n&quot;, w, h);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0screen.width =3D w;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0screen.height =3D h;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [self setContentDimensions];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [self setFrame:NSMakeRect(cx, cy, cw, ch)];<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [self resizeWindow];<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0// update screenBuffer<br>
@@ -643,51 +633,6 @@ - (void) switchSurface:(pixman_image_t *)image<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0pixman_image =3D image;<br>
-<br>
-=C2=A0 =C2=A0 // update windows<br>
-=C2=A0 =C2=A0 if (isFullscreen) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [[fullScreenWindow contentView] setFrame:[[NSS=
creen mainScreen] frame]];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [normalWindow setFrame:NSMakeRect([normalWindo=
w frame].origin.x, [normalWindow frame].origin.y - h + oldh, w, h + [normal=
Window frame].size.height - oldh) display:NO animate:NO];<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qemu_name)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [normalWindow setTitle:[NSString=
 stringWithFormat:@&quot;QEMU %s&quot;, qemu_name]];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [normalWindow setFrame:NSMakeRect([normalWindo=
w frame].origin.x, [normalWindow frame].origin.y - h + oldh, w, h + [normal=
Window frame].size.height - oldh) display:YES animate:NO];<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (isResize) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [normalWindow center];<br>
-=C2=A0 =C2=A0 }<br>
-}<br>
-<br>
-- (void) toggleFullScreen:(id)sender<br>
-{<br>
-=C2=A0 =C2=A0 COCOA_DEBUG(&quot;QemuCocoaView: toggleFullScreen\n&quot;);<=
br>
-<br>
-=C2=A0 =C2=A0 if (isFullscreen) { // switch from fullscreen to desktop<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 isFullscreen =3D FALSE;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [self ungrabMouse];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [self setContentDimensions];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [fullScreenWindow close];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [normalWindow setContentView: self];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [normalWindow makeKeyAndOrderFront: self];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [NSMenu setMenuBarVisible:YES];<br>
-=C2=A0 =C2=A0 } else { // switch from desktop to fullscreen<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 isFullscreen =3D TRUE;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [normalWindow orderOut: nil]; /* Hide the wind=
ow */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [self grabMouse];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [self setContentDimensions];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [NSMenu setMenuBarVisible:NO];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 fullScreenWindow =3D [[NSWindow alloc] initWit=
hContentRect:[[NSScreen mainScreen] frame]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 styleMask:NSWindowStyleMaskBorde=
rless<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 backing:NSBackingStoreBuffered<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 defer:NO];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [fullScreenWindow setAcceptsMouseMovedEvents: =
YES];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [fullScreenWindow setHasShadow:NO];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [fullScreenWindow setBackgroundColor: [NSColor=
 blackColor]];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [self setFrame:NSMakeRect(cx, cy, cw, ch)];<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [[fullScreenWindow contentView] addSubview: se=
lf];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [fullScreenWindow makeKeyAndOrderFront:self];<=
br>
-=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0- (void) setFullGrab:(id)sender<br>
@@ -801,9 +746,6 @@ - (bool) handleEventLocked:(NSEvent *)event<br>
=C2=A0 =C2=A0 =C2=A0COCOA_DEBUG(&quot;QemuCocoaView: handleEvent\n&quot;);<=
br>
=C2=A0 =C2=A0 =C2=A0int buttons =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0int keycode =3D 0;<br>
-=C2=A0 =C2=A0 bool mouse_event =3D false;<br>
-=C2=A0 =C2=A0 // Location of event in virtual screen coordinates<br>
-=C2=A0 =C2=A0 NSPoint p =3D [self screenLocationOfEvent:event];<br>
=C2=A0 =C2=A0 =C2=A0NSUInteger modifiers =3D [event modifierFlags];<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
@@ -883,25 +825,25 @@ - (bool) handleEventLocked:(NSEvent *)event<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (!!(modifiers &amp; NSEventModifierFlagShift)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0[self toggleKey:Q_KEY_CODE_SHIFT];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brea=
k;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn true;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case kVK_Righ=
tShift:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (!!(modifiers &amp; NSEventModifierFlagShift)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0[self toggleKey:Q_KEY_CODE_SHIFT_R];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brea=
k;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn true;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case kVK_Cont=
rol:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (!!(modifiers &amp; NSEventModifierFlagControl)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0[self toggleKey:Q_KEY_CODE_CTRL];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brea=
k;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn true;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case kVK_Righ=
tControl:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (!!(modifiers &amp; NSEventModifierFlagControl)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0[self toggleKey:Q_KEY_CODE_CTRL_R];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brea=
k;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn true;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case kVK_Opti=
on:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (!!(modifiers &amp; NSEventModifierFlagOption)) {<br>
@@ -911,7 +853,7 @@ - (bool) handleEventLocked:(NSEvent *)event<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[self toggleKey:Q_KEY_CODE_ALT];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brea=
k;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn true;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case kVK_Righ=
tOption:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (!!(modifiers &amp; NSEventModifierFlagOption)) {<br>
@@ -921,7 +863,7 @@ - (bool) handleEventLocked:(NSEvent *)event<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[self toggleKey:Q_KEY_CODE_ALT_R];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brea=
k;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn true;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Don&#39;t =
pass command key changes to guest unless mouse is grabbed */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case kVK_Comm=
and:<br>
@@ -934,7 +876,7 @@ - (bool) handleEventLocked:(NSEvent *)event<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[self toggleKey:Q_KEY_CODE_META_L];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brea=
k;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn true;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case kVK_Righ=
tCommand:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (isMouseGrabbed &amp;&amp;<br>
@@ -945,9 +887,11 @@ - (bool) handleEventLocked:(NSEvent *)event<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[self toggleKey:Q_KEY_CODE_META_R];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brea=
k;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn true;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case NSEventTypeKeyDown:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0keycode =3D cocoa_keycode_t=
o_qemu([event keyCode]);<br>
<br>
@@ -983,7 +927,7 @@ - (bool) handleEventLocked:(NSEvent *)event<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[self handleM=
onitorInput: event];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case NSEventTypeKeyUp:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0keycode =3D cocoa_keycode_t=
o_qemu([event keyCode]);<br>
<br>
@@ -996,67 +940,7 @@ - (bool) handleEventLocked:(NSEvent *)event<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (qemu_console_is_graphic=
(NULL)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qkbd_state_ke=
y_event(kbd, keycode, false);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case NSEventTypeMouseMoved:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (isAbsoluteEnabled) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // Cursor re-enter=
ed into a window might generate events bound to screen coordinates<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // and `nil` windo=
w property, and in full screen mode, current window might not be<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // key window, whe=
re event location alone should suffice.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (![self screenC=
ontainsPoint:p] || !([[self window] isKeyWindow] || isFullscreen)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
isMouseGrabbed) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 [self ungrabMouse];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
!isMouseGrabbed) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 [self grabMouse];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mouse_event =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case NSEventTypeLeftMouseDown:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buttons |=3D MOUSE_EVENT_LBUTTON=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mouse_event =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case NSEventTypeRightMouseDown:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buttons |=3D MOUSE_EVENT_RBUTTON=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mouse_event =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case NSEventTypeOtherMouseDown:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buttons |=3D MOUSE_EVENT_MBUTTON=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mouse_event =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case NSEventTypeLeftMouseDragged:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buttons |=3D MOUSE_EVENT_LBUTTON=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mouse_event =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case NSEventTypeRightMouseDragged:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buttons |=3D MOUSE_EVENT_RBUTTON=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mouse_event =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case NSEventTypeOtherMouseDragged:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buttons |=3D MOUSE_EVENT_MBUTTON=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mouse_event =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case NSEventTypeLeftMouseUp:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mouse_event =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!isMouseGrabbed &amp;&amp; [=
self screenContainsPoint:p]) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* In fullscr=
een mode, the window of cocoaView may not be the<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* key window=
, therefore the position relative to the virtual<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* screen alo=
ne will be sufficient.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if(isFullscreen ||=
 [[self window] isKeyWindow]) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [sel=
f grabMouse];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case NSEventTypeRightMouseUp:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mouse_event =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case NSEventTypeOtherMouseUp:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mouse_event =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case NSEventTypeScrollWheel:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Send wheel events to the=
 guest regardless of window focus.<br>
@@ -1087,62 +971,124 @@ - (bool) handleEventLocked:(NSEvent *)event<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Since deltaX/deltaY also=
 report scroll wheel events we prevent mouse<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * movement code from execu=
ting.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mouse_event =3D false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+}<br>
<br>
-=C2=A0 =C2=A0 if (mouse_event) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Don&#39;t send button events to the guest u=
nless we&#39;ve got a<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* mouse grab or window focus. If we have=
 neither then this event<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* is the user clicking on the background=
 window to activate and<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* bring us to the front, which will be d=
one by the sendEvent<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* call below. We definitely don&#39;t wa=
nt to pass that click through<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* to the guest.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((isMouseGrabbed || [[self window] isKeyWin=
dow]) &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (last_buttons !=3D buttons)) {<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 static uint32_t bmap[INPUT_BUTTO=
N__MAX] =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [INPUT_BUTTON_LEFT=
]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D MOUSE_EVENT_LBUTTON,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [INPUT_BUTTON_MIDD=
LE]=C2=A0 =C2=A0 =C2=A0=3D MOUSE_EVENT_MBUTTON,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [INPUT_BUTTON_RIGH=
T]=C2=A0 =C2=A0 =C2=A0 =3D MOUSE_EVENT_RBUTTON<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_update_buttons(dcl.co=
n, bmap, last_buttons, buttons);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_buttons =3D buttons;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (isMouseGrabbed) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (isAbsoluteEnabled) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Note that the o=
rigin for Cocoa mouse coords is bottom left, not top left.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The check =
on screenContainsPoint is to avoid sending out of range values for<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* clicks in =
the titlebar.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ([self screenCo=
ntainsPoint:p]) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu=
_input_queue_abs(dcl.con, INPUT_AXIS_X, p.x, 0, screen.width);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu=
_input_queue_abs(dcl.con, INPUT_AXIS_Y, screen.height - p.y, 0, screen.heig=
ht);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_queue_r=
el(dcl.con, INPUT_AXIS_X, (int)[event deltaX]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_queue_r=
el(dcl.con, INPUT_AXIS_Y, (int)[event deltaY]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+- (void) handleMouseEvent:(NSEvent *)event<br>
+{<br>
+=C2=A0 =C2=A0 if (!isMouseGrabbed) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 with_iothread_lock(^{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (isAbsoluteEnabled) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CGFloat d =3D (CGFloat)screen.he=
ight / [self frame].size.height;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NSPoint p =3D [event locationInW=
indow];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // Note that the origin for Coco=
a mouse coords is bottom left, not top left.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_queue_abs(dcl.con, IN=
PUT_AXIS_X, p.x * d, 0, screen.width);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_queue_abs(dcl.con, IN=
PUT_AXIS_Y, screen.height - p.y * d, 0, screen.height);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CGFloat d =3D (CGFloat)screen.he=
ight / [self convertSizeToBacking:[self frame].size].height;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_queue_rel(dcl.con, IN=
PUT_AXIS_X, [event deltaX] * d);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_queue_rel(dcl.con, IN=
PUT_AXIS_Y, [event deltaY] * d);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_input_event_sync();<br>
+=C2=A0 =C2=A0 });<br>
+}<br>
+<br>
+- (void) handleMouseEvent:(NSEvent *)event button:(InputButton)button down=
:(bool)down<br>
+{<br>
+=C2=A0 =C2=A0 if (!isMouseGrabbed) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 return true;<br>
+<br>
+=C2=A0 =C2=A0 with_iothread_lock(^{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_queue_btn(dcl.con, button, down);<b=
r>
+=C2=A0 =C2=A0 });<br>
+<br>
+=C2=A0 =C2=A0 [self handleMouseEvent:event];<br>
+}<br>
+<br>
+- (void) mouseExited:(NSEvent *)event<br>
+{<br>
+=C2=A0 =C2=A0 if (isAbsoluteEnabled &amp;&amp; isMouseGrabbed) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [self ungrabMouse];<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+- (void) mouseEntered:(NSEvent *)event<br>
+{<br>
+=C2=A0 =C2=A0 if (isAbsoluteEnabled &amp;&amp; !isMouseGrabbed) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [self grabMouse];<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+- (void) mouseMoved:(NSEvent *)event<br>
+{<br>
+=C2=A0 =C2=A0 [self handleMouseEvent:event];<br>
+}<br>
+<br>
+- (void) mouseDown:(NSEvent *)event<br>
+{<br>
+=C2=A0 =C2=A0 [self handleMouseEvent:event button:INPUT_BUTTON_LEFT down:t=
rue];<br>
+}<br>
+<br>
+- (void) rightMouseDown:(NSEvent *)event<br>
+{<br>
+=C2=A0 =C2=A0 [self handleMouseEvent:event button:INPUT_BUTTON_RIGHT down:=
true];<br>
+}<br>
+<br>
+- (void) otherMouseDown:(NSEvent *)event<br>
+{<br>
+=C2=A0 =C2=A0 [self handleMouseEvent:event button:INPUT_BUTTON_MIDDLE down=
:true];<br>
+}<br>
+<br>
+- (void) mouseDragged:(NSEvent *)event<br>
+{<br>
+=C2=A0 =C2=A0 [self handleMouseEvent:event];<br>
+}<br>
+<br>
+- (void) rightMouseDragged:(NSEvent *)event<br>
+{<br>
+=C2=A0 =C2=A0 [self handleMouseEvent:event];<br>
+}<br>
+<br>
+- (void) otherMouseDragged:(NSEvent *)event<br>
+{<br>
+=C2=A0 =C2=A0 [self handleMouseEvent:event];<br>
+}<br>
+<br>
+- (void) mouseUp:(NSEvent *)event<br>
+{<br>
+=C2=A0 =C2=A0 if (!isMouseGrabbed) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [self grabMouse];<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 [self handleMouseEvent:event button:INPUT_BUTTON_LEFT down:f=
alse];<br>
+}<br>
+<br>
+- (void) rightMouseUp:(NSEvent *)event<br>
+{<br>
+=C2=A0 =C2=A0 [self handleMouseEvent:event button:INPUT_BUTTON_RIGHT down:=
false];<br>
+}<br>
+<br>
+- (void) otherMouseUp:(NSEvent *)event<br>
+{<br>
+=C2=A0 =C2=A0 [self handleMouseEvent:event button:INPUT_BUTTON_MIDDLE down=
:false];<br>
=C2=A0}<br>
<br>
=C2=A0- (void) grabMouse<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0COCOA_DEBUG(&quot;QemuCocoaView: grabMouse\n&quot;);<br=
>
<br>
-=C2=A0 =C2=A0 if (!isFullscreen) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qemu_name)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [normalWindow setTitle:[NSString=
 stringWithFormat:@&quot;QEMU %s - (Press=C2=A0 &quot; UC_CTRL_KEY &quot; &=
quot; UC_ALT_KEY &quot; G=C2=A0 to release Mouse)&quot;, qemu_name]];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [normalWindow setTitle:@&quot;QE=
MU - (Press=C2=A0 &quot; UC_CTRL_KEY &quot; &quot; UC_ALT_KEY &quot; G=C2=
=A0 to release Mouse)&quot;];<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (qemu_name)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [normalWindow setTitle:[NSString stringWithFor=
mat:@&quot;QEMU %s - (Press=C2=A0 &quot; UC_CTRL_KEY &quot; &quot; UC_ALT_K=
EY &quot; G=C2=A0 to release Mouse)&quot;, qemu_name]];<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [normalWindow setTitle:@&quot;QEMU - (Press=C2=
=A0 &quot; UC_CTRL_KEY &quot; &quot; UC_ALT_KEY &quot; G=C2=A0 to release M=
ouse)&quot;];<br>
=C2=A0 =C2=A0 =C2=A0[self hideCursor];<br>
=C2=A0 =C2=A0 =C2=A0CGAssociateMouseAndMouseCursorPosition(isAbsoluteEnable=
d);<br>
=C2=A0 =C2=A0 =C2=A0isMouseGrabbed =3D TRUE; // while isMouseGrabbed =3D TR=
UE, QemuCocoaApp sends all events to [cocoaView handleEvent:]<br>
@@ -1152,15 +1098,14 @@ - (void) ungrabMouse<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0COCOA_DEBUG(&quot;QemuCocoaView: ungrabMouse\n&quot;);<=
br>
<br>
-=C2=A0 =C2=A0 if (!isFullscreen) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qemu_name)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [normalWindow setTitle:[NSString=
 stringWithFormat:@&quot;QEMU %s&quot;, qemu_name]];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [normalWindow setTitle:@&quot;QE=
MU&quot;];<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (qemu_name)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [normalWindow setTitle:[NSString stringWithFor=
mat:@&quot;QEMU %s&quot;, qemu_name]];<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [normalWindow setTitle:@&quot;QEMU&quot;];<br>
=C2=A0 =C2=A0 =C2=A0[self unhideCursor];<br>
=C2=A0 =C2=A0 =C2=A0CGAssociateMouseAndMouseCursorPosition(TRUE);<br>
=C2=A0 =C2=A0 =C2=A0isMouseGrabbed =3D FALSE;<br>
+=C2=A0 =C2=A0 [self raiseAllButtons];<br>
=C2=A0}<br>
<br>
=C2=A0- (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled {<br>
@@ -1171,8 +1116,6 @@ - (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled =
{<br>
=C2=A0}<br>
=C2=A0- (BOOL) isMouseGrabbed {return isMouseGrabbed;}<br>
=C2=A0- (BOOL) isAbsoluteEnabled {return isAbsoluteEnabled;}<br>
-- (float) cdx {return cdx;}<br>
-- (float) cdy {return cdy;}<br>
=C2=A0- (QEMUScreen) gscreen {return screen;}<br>
<br>
=C2=A0/*<br>
@@ -1186,6 +1129,15 @@ - (void) raiseAllKeys<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qkbd_state_lift_all_keys(kbd);<br>
=C2=A0 =C2=A0 =C2=A0});<br>
=C2=A0}<br>
+<br>
+- (void) raiseAllButtons<br>
+{<br>
+=C2=A0 =C2=A0 with_iothread_lock(^{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_queue_btn(dcl.con, INPUT_BUTTON_LEF=
T, false);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_queue_btn(dcl.con, INPUT_BUTTON_RIG=
HT, false);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_queue_btn(dcl.con, INPUT_BUTTON_MID=
DLE, false);<br>
+=C2=A0 =C2=A0 });<br>
+}<br>
=C2=A0@end<br>
<br>
<br>
@@ -1200,7 +1152,6 @@ @interface QemuCocoaAppController : NSObject<br>
=C2=A0{<br>
=C2=A0}<br>
=C2=A0- (void)doToggleFullScreen:(id)sender;<br>
-- (void)toggleFullScreen:(id)sender;<br>
=C2=A0- (void)showQEMUDoc:(id)sender;<br>
=C2=A0- (void)zoomToFit:(id) sender;<br>
=C2=A0- (void)displayConsole:(id)sender;<br>
@@ -1242,7 +1193,8 @@ - (id) init<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[normalWindow setAcceptsMouseMovedEvents:=
YES];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [normalWindow setTitle:@&quot;QEMU&quot;];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [normalWindow setCollectionBehavior:NSWindowCo=
llectionBehaviorFullScreenPrimary];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [normalWindow setTitle:qemu_name ? [NSString s=
tringWithFormat:@&quot;QEMU %s&quot;, qemu_name] : @&quot;QEMU&quot;];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[normalWindow setContentView:cocoaView];<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[normalWindow makeKeyAndOrderFront:self];=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[normalWindow center];<br>
@@ -1312,9 +1264,20 @@ - (void)windowDidChangeScreen:(NSNotification *)noti=
fication<br>
=C2=A0 =C2=A0 =C2=A0[cocoaView updateUIInfo];<br>
=C2=A0}<br>
<br>
+- (void)windowDidEnterFullScreen:(NSNotification *)notification<br>
+{<br>
+=C2=A0 =C2=A0 [cocoaView grabMouse];<br>
+}<br>
+<br>
+- (void)windowDidExitFullScreen:(NSNotification *)notification<br>
+{<br>
+=C2=A0 =C2=A0 [cocoaView resizeWindow];<br>
+=C2=A0 =C2=A0 [cocoaView ungrabMouse];<br>
+}<br>
+<br>
=C2=A0- (void)windowDidResize:(NSNotification *)notification<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 [cocoaView updateUIInfo];<br>
+=C2=A0 =C2=A0 [cocoaView frameUpdated];<br>
=C2=A0}<br>
<br>
=C2=A0/* Called when the user clicks on a window&#39;s close button */<br>
@@ -1330,6 +1293,23 @@ - (BOOL)windowShouldClose:(id)sender<br>
=C2=A0 =C2=A0 =C2=A0return NO;<br>
=C2=A0}<br>
<br>
+- (NSSize) window:(NSWindow *)window willUseFullScreenContentSize:(NSSize)=
proposedSize<br>
+{<br>
+=C2=A0 =C2=A0 if (([normalWindow styleMask] &amp; NSWindowStyleMaskResizab=
le) =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NSMakeSize([cocoaView gscreen].width, [=
cocoaView gscreen].height);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return [cocoaView fixZoomedFullScreenSize:proposedSize];<br>
+}<br>
+<br>
+- (NSApplicationPresentationOptions) window:(NSWindow *)window<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0willUseFullScree=
nPresentationOptions:(NSApplicationPresentationOptions)proposedOptions;<br>
+<br>
+{<br>
+=C2=A0 =C2=A0 return (proposedOptions &amp; ~(NSApplicationPresentationAut=
oHideDock | NSApplicationPresentationAutoHideMenuBar)) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NSApplicationPresentationHideDock=
 | NSApplicationPresentationHideMenuBar;<br>
+}<br>
+<br>
=C2=A0/*<br>
=C2=A0 * Called when QEMU goes into the background. Note that<br>
=C2=A0 * [-NSWindowDelegate windowDidResignKey:] is used here instead of<br=
>
@@ -1349,14 +1329,7 @@ - (void) windowDidResignKey: (NSNotification *)aNoti=
fication<br>
=C2=A0 */<br>
=C2=A0- (void) doToggleFullScreen:(id)sender<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 [self toggleFullScreen:(id)sender];<br>
-}<br>
-<br>
-- (void)toggleFullScreen:(id)sender<br>
-{<br>
-=C2=A0 =C2=A0 COCOA_DEBUG(&quot;QemuCocoaAppController: toggleFullScreen\n=
&quot;);<br>
-<br>
-=C2=A0 =C2=A0 [cocoaView toggleFullScreen:sender];<br>
+=C2=A0 =C2=A0 [normalWindow toggleFullScreen:sender];<br>
=C2=A0}<br>
<br>
=C2=A0- (void) setFullGrab:(id)sender<br>
@@ -1400,13 +1373,15 @@ - (void)showQEMUDoc:(id)sender<br>
=C2=A0 =C2=A0 =C2=A0[self openDocumentation: @&quot;index.html&quot;];<br>
=C2=A0}<br>
<br>
-/* Stretches video to fit host monitor size */<br>
+/* Toggles the flag which stretches video to fit host window size */<br>
=C2=A0- (void)zoomToFit:(id) sender<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 stretch_video =3D !stretch_video;<br>
-=C2=A0 =C2=A0 if (stretch_video =3D=3D true) {<br>
+=C2=A0 =C2=A0 if (([normalWindow styleMask] &amp; NSWindowStyleMaskResizab=
le) =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [normalWindow setStyleMask:[normalWindow style=
Mask] | NSWindowStyleMaskResizable];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[sender setState: NSControlStateValueOn];=
<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [normalWindow setStyleMask:[normalWindow style=
Mask] &amp; ~NSWindowStyleMaskResizable];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [cocoaView resizeWindow];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[sender setState: NSControlStateValueOff]=
;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
@@ -1414,7 +1389,9 @@ - (void)zoomToFit:(id) sender<br>
=C2=A0/* Displays the console on the screen */<br>
=C2=A0- (void)displayConsole:(id)sender<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 console_select([sender tag]);<br>
+=C2=A0 =C2=A0 with_iothread_lock(^{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 console_select([sender tag]);<br>
+=C2=A0 =C2=A0 });<br>
=C2=A0}<br>
<br>
=C2=A0/* Pause the guest */<br>
@@ -1671,7 +1648,7 @@ static void create_initial_menus(void)<br>
=C2=A0 =C2=A0 =C2=A0menu =3D [[NSMenu alloc] initWithTitle:@&quot;View&quot=
;];<br>
=C2=A0 =C2=A0 =C2=A0[menu addItem: [[[NSMenuItem alloc] initWithTitle:@&quo=
t;Enter Fullscreen&quot; action:@selector(doToggleFullScreen:) keyEquivalen=
t:@&quot;f&quot;] autorelease]]; // Fullscreen<br>
=C2=A0 =C2=A0 =C2=A0menuItem =3D [[[NSMenuItem alloc] initWithTitle:@&quot;=
Zoom To Fit&quot; action:@selector(zoomToFit:) keyEquivalent:@&quot;&quot;]=
 autorelease];<br>
-=C2=A0 =C2=A0 [menuItem setState: stretch_video ? NSControlStateValueOn : =
NSControlStateValueOff];<br>
+=C2=A0 =C2=A0 [menuItem setState: [normalWindow styleMask] &amp; NSWindowS=
tyleMaskResizable ? NSControlStateValueOn : NSControlStateValueOff];<br>
=C2=A0 =C2=A0 =C2=A0[menu addItem: menuItem];<br>
=C2=A0 =C2=A0 =C2=A0menuItem =3D [[[NSMenuItem alloc] initWithTitle:@&quot;=
View&quot; action:nil keyEquivalent:@&quot;&quot;] autorelease];<br>
=C2=A0 =C2=A0 =C2=A0[menuItem setSubmenu:menu];<br>
@@ -1962,16 +1939,14 @@ static void cocoa_update(DisplayChangeListener *dcl=
,<br>
=C2=A0 =C2=A0 =C2=A0COCOA_DEBUG(&quot;qemu_cocoa: cocoa_update\n&quot;);<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0dispatch_async(dispatch_get_main_queue(), ^{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 NSRect rect;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ([cocoaView cdx] =3D=3D 1.0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rect =3D NSMakeRect(x, [cocoaVie=
w gscreen].height - y - h, w, h);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rect =3D NSMakeRect(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 x * [cocoaView cdx=
],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ([cocoaView gscree=
n].height - y - h) * [cocoaView cdy],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w * [cocoaView cdx=
],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 h * [cocoaView cdy=
]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CGFloat d =3D [cocoaView frame].size.height / =
(CGFloat)[cocoaView gscreen].height;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 NSRect rect =3D NSMakeRect(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 x * d,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ([cocoaView gscree=
n].height - y - h) * d,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w * d,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 h * d);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[cocoaView setNeedsDisplayInRect:rect];<b=
r>
=C2=A0 =C2=A0 =C2=A0});<br>
=C2=A0}<br>
@@ -2048,8 +2023,7 @@ static void cocoa_display_init(DisplayState *ds, Disp=
layOptions *opts)<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* if fullscreen mode is to be used */<br>
=C2=A0 =C2=A0 =C2=A0if (opts-&gt;has_full_screen &amp;&amp; opts-&gt;full_s=
creen) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [NSApp activateIgnoringOtherApps: YES];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 [controller toggleFullScreen: nil];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [normalWindow toggleFullScreen: nil];<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (opts-&gt;u.cocoa.has_full_grab &amp;&amp; opts-&gt;=
u.cocoa.full_grab) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[controller setFullGrab: nil];<br>
@@ -2067,7 +2041,7 @@ static void cocoa_display_init(DisplayState *ds, Disp=
layOptions *opts)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (opts-&gt;u.cocoa.has_zoom_to_fit &amp;&amp; opts-&g=
t;u.cocoa.zoom_to_fit) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 stretch_video =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [normalWindow setStyleMask:[normalWindow style=
Mask] &amp; ~NSWindowStyleMaskResizable];<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0create_initial_menus();<br>
<br>
---<br>
base-commit: 9c74490bff6c8886a922008d0c9ce6cae70dd17e<br>
change-id: 20231211-cocoa-576b8639e9bd<br>
<br>
Best regards,<br>
-- <br>
Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_bl=
ank">akihiko.odaki@daynix.com</a>&gt;<br>
<br>
<br>
<br>
</blockquote></div>

--000000000000b58f2d060c4b81b2--

