Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A19F0815EC6
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 12:41:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEpV8-0004IE-MW; Sun, 17 Dec 2023 06:40:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rEpV6-0004Hl-5T
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 06:40:04 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rEpV0-0001MX-VR
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 06:40:02 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5346075A4C8;
 Sun, 17 Dec 2023 12:39:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id S3qFW8lZ7TIQ; Sun, 17 Dec 2023 12:39:53 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 16EF375A4C6; Sun, 17 Dec 2023 12:39:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 141E475A4BF;
 Sun, 17 Dec 2023 12:39:53 +0100 (CET)
Date: Sun, 17 Dec 2023 12:39:53 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
cc: Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, qemu-devel@nongnu.org, 
 Rene Engel <ReneEngel80@emailn.de>
Subject: Re: [PATCH v7] ui/cocoa: Use NSWindow's ability to resize
In-Reply-To: <20231217-cocoa-v7-1-6af21ef75680@daynix.com>
Message-ID: <81d626f7-1fe5-0c74-acaa-4a2a4070a381@eik.bme.hu>
References: <20231217-cocoa-v7-1-6af21ef75680@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, PDS_OTHER_BAD_TLD=1.999,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Sun, 17 Dec 2023, Akihiko Odaki wrote:
> This change brings two new features:
> - The window will be resizable if "Zoom To Fit" is eanbled
> - The window can be made full screen by clicking full screen button
>  provided by the platform. (The left-top green button.)
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Tested-by: Rene Engel <ReneEngel80@emailn.de>
> ---
> V5 -> V6:
>  Rebased.
> ---
> Changes in v7:
> - Fixed zoom-to-fit option. (Marek Glogowski)
> - Link to v6: https://lore.kernel.org/r/20231211-cocoa-v6-1-49f3be0191f2@daynix.com
> ---
> ui/cocoa.m | 542 +++++++++++++++++++++++++++++--------------------------------
> 1 file changed, 258 insertions(+), 284 deletions(-)

Is ir possible to break this patch up into smaller ones for easier review? 
E.g. separate patch moving mouse event handling out of handleEventLocked, 
replacing stretch_video flag with NSWindowStyleMaskResizable and whatever 
else can be done as independent steps? Not sure if that's possible or 
needs the whole chnage at once but this patch seems to be too big. Some 
more comments below.

> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index cd069da6965b..31a2230f55a4 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -99,12 +99,10 @@ static void cocoa_switch(DisplayChangeListener *dcl,
> static DisplayChangeListener dcl = {
>     .ops = &dcl_ops,
> };
> -static int last_buttons;
> static int cursor_hide = 1;
> static int left_command_key_enabled = 1;
> static bool swap_opt_cmd;
>
> -static bool stretch_video;
> static NSTextField *pauseLabel;
>
> static bool allow_events;
> @@ -304,20 +302,17 @@ static void handleAnyDeviceErrors(Error * err)
> */
> @interface QemuCocoaView : NSView
> {
> +    NSTrackingArea *trackingArea;
>     QEMUScreen screen;
> -    NSWindow *fullScreenWindow;
> -    float cx,cy,cw,ch,cdx,cdy;
>     pixman_image_t *pixman_image;
>     QKbdState *kbd;
>     BOOL isMouseGrabbed;
> -    BOOL isFullscreen;
>     BOOL isAbsoluteEnabled;
>     CFMachPortRef eventsTap;
> }
> - (void) switchSurface:(pixman_image_t *)image;
> - (void) grabMouse;
> - (void) ungrabMouse;
> -- (void) toggleFullScreen:(id)sender;
> - (void) setFullGrab:(id)sender;
> - (void) handleMonitorInput:(NSEvent *)event;
> - (bool) handleEvent:(NSEvent *)event;
> @@ -333,8 +328,6 @@ - (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled;
>  */
> - (BOOL) isMouseGrabbed;
> - (BOOL) isAbsoluteEnabled;
> -- (float) cdx;
> -- (float) cdy;
> - (QEMUScreen) gscreen;
> - (void) raiseAllKeys;
> @end
> @@ -392,46 +385,43 @@ - (BOOL) isOpaque
>     return YES;
> }
>
> -- (BOOL) screenContainsPoint:(NSPoint) p
> +- (void) removeTrackingRect
> {
> -    return (p.x > -1 && p.x < screen.width && p.y > -1 && p.y < screen.height);
> +    if (trackingArea) {
> +        [self removeTrackingArea:trackingArea];
> +        [trackingArea release];
> +        trackingArea = nil;
> +    }
> }
>
> -/* Get location of event and convert to virtual screen coordinate */
> -- (CGPoint) screenLocationOfEvent:(NSEvent *)ev
> +- (void) frameUpdated
> {
> -    NSWindow *eventWindow = [ev window];
> -    // XXX: Use CGRect and -convertRectFromScreen: to support macOS 10.10
> -    CGRect r = CGRectZero;
> -    r.origin = [ev locationInWindow];
> -    if (!eventWindow) {
> -        if (!isFullscreen) {
> -            return [[self window] convertRectFromScreen:r].origin;
> -        } else {
> -            CGPoint locationInSelfWindow = [[self window] convertRectFromScreen:r].origin;
> -            CGPoint loc = [self convertPoint:locationInSelfWindow fromView:nil];
> -            if (stretch_video) {
> -                loc.x /= cdx;
> -                loc.y /= cdy;
> -            }
> -            return loc;
> -        }
> -    } else if ([[self window] isEqual:eventWindow]) {
> -        if (!isFullscreen) {
> -            return r.origin;
> -        } else {
> -            CGPoint loc = [self convertPoint:r.origin fromView:nil];
> -            if (stretch_video) {
> -                loc.x /= cdx;
> -                loc.y /= cdy;
> -            }
> -            return loc;
> -        }
> -    } else {
> -        return [[self window] convertRectFromScreen:[eventWindow convertRectToScreen:r]].origin;
> +    [self removeTrackingRect];
> +
> +    if ([self window]) {
> +        NSTrackingAreaOptions options = NSTrackingActiveInKeyWindow |
> +                                        NSTrackingMouseEnteredAndExited |
> +                                        NSTrackingMouseMoved;
> +        trackingArea = [[NSTrackingArea alloc] initWithRect:[self frame]
> +                                                    options:options
> +                                                      owner:self
> +                                                   userInfo:nil];
> +        [self addTrackingArea:trackingArea];
> +        [self updateUIInfo];
>     }
> }
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
> - (void) hideCursor
> {
>     if (!cursor_hide) {
> @@ -494,13 +484,14 @@ - (void) drawRect:(NSRect) rect
>         int i;
>         CGImageRef clipImageRef;
>         CGRect clipRect;
> +        CGFloat d = (CGFloat)h / [self frame].size.height;
>
>         [self getRectsBeingDrawn:&rectList count:&rectCount];
>         for (i = 0; i < rectCount; i++) {
> -            clipRect.origin.x = rectList[i].origin.x / cdx;
> -            clipRect.origin.y = (float)h - (rectList[i].origin.y + rectList[i].size.height) / cdy;
> -            clipRect.size.width = rectList[i].size.width / cdx;
> -            clipRect.size.height = rectList[i].size.height / cdy;
> +            clipRect.origin.x = rectList[i].origin.x * d;
> +            clipRect.origin.y = (float)h - (rectList[i].origin.y + rectList[i].size.height) * d;
> +            clipRect.size.width = rectList[i].size.width * d;
> +            clipRect.size.height = rectList[i].size.height * d;
>             clipImageRef = CGImageCreateWithImageInRect(
>                                                         imageRef,
>                                                         clipRect
> @@ -513,36 +504,43 @@ - (void) drawRect:(NSRect) rect
>     }
> }
>
> -- (void) setContentDimensions
> +- (NSSize) fixZoomedFullScreenSize:(NSSize)proposedSize
> {
> -    COCOA_DEBUG("QemuCocoaView: setContentDimensions\n");
> +    NSSize size;
>
> -    if (isFullscreen) {
> -        cdx = [[NSScreen mainScreen] frame].size.width / (float)screen.width;
> -        cdy = [[NSScreen mainScreen] frame].size.height / (float)screen.height;
> +    size.width = (CGFloat)screen.width * proposedSize.height;
> +    size.height = (CGFloat)screen.height * proposedSize.width;

One of these will be overwritten in the next if below so maybe drop this 
init and do the calculation in the if legs which is then also clearer to 
show that this would scale one of these with screen.width/screen.height or 
the inverse of that.

This also removes stretch_video flag and the calculation to preserve 
aspect ratio. Is that correct? Would it now distort the image when zooming 
to full screen if guest resolution is not the same as host screen? Is that 
how zoom-to-fit should work? At leest with -display sdl going to full 
screen guest screen is zoomed preserving aspect ratio but maybe sdl does 
not have zoom-to-fit option. I don't know how it works with other displays 
such as gtk.

> -        /* stretches video, but keeps same aspect ratio */
> -        if (stretch_video == true) {
> -            /* use smallest stretch value - prevents clipping on sides */
> -            if (MIN(cdx, cdy) == cdx) {
> -                cdy = cdx;
> -            } else {
> -                cdx = cdy;
> -            }
> -        } else {  /* No stretching */
> -            cdx = cdy = 1;
> -        }
> -        cw = screen.width * cdx;
> -        ch = screen.height * cdy;
> -        cx = ([[NSScreen mainScreen] frame].size.width - cw) / 2.0;
> -        cy = ([[NSScreen mainScreen] frame].size.height - ch) / 2.0;
> +    if (size.width < size.height) {
> +        size.width /= screen.height;
> +        size.height = proposedSize.height;
>     } else {
> -        cx = 0;
> -        cy = 0;
> -        cw = screen.width;
> -        ch = screen.height;
> -        cdx = 1.0;
> -        cdy = 1.0;
> +        size.width = proposedSize.width;
> +        size.height /= screen.width;
> +    }
> +
> +    return size;
> +}
> +
> +- (NSSize) screenSafeAreaSize
> +{
> +    NSSize size = [[[self window] screen] frame].size;
> +    NSEdgeInsets insets = [[[self window] screen] safeAreaInsets];
> +    size.width -= insets.left + insets.right;
> +    size.height -= insets.top + insets.bottom;
> +    return size;
> +}
> +
> +- (void) resizeWindow
> +{
> +    [[self window] setContentAspectRatio:NSMakeSize(screen.width, screen.height)];
> +
> +    if (([[self window] styleMask] & NSWindowStyleMaskResizable) == 0) {
> +        [[self window] setContentSize:NSMakeSize(screen.width, screen.height)];
> +        [[self window] center];
> +    } else if (([[self window] styleMask] & NSWindowStyleMaskFullScreen) != 0) {
> +        [[self window] setContentSize:[self fixZoomedFullScreenSize:[self screenSafeAreaSize]]];
> +        [[self window] center];
>     }
> }
>
> @@ -563,7 +561,11 @@ - (void) updateUIInfoLocked
>         CGSize screenPhysicalSize = CGDisplayScreenSize(display);
>         CVDisplayLinkRef displayLink;
>
> -        frameSize = isFullscreen ? screenSize : [self frame].size;
> +        if (([[self window] styleMask] & NSWindowStyleMaskFullScreen) == 0) {
> +            frameSize = [self frame].size;
> +        } else {
> +            frameSize = [self screenSafeAreaSize];
> +        }

In these ifs you seem to test for flag not set with == 0 but maybe 
swapping the else and then branches and testing for flag set would be 
clearer than testing for negative condition? I mean:

if (([[self window] styleMask] & NSWindowStyleMaskFullScreen)) {
     frameSize = [self screenSafeAreaSize];
} else {
     frameSize = [self frame].size;
}

>         if (!CVDisplayLinkCreateWithCGDisplay(display, &displayLink)) {
>             CVTime period = CVDisplayLinkGetNominalOutputVideoRefreshPeriod(displayLink);
> @@ -610,31 +612,19 @@ - (void) updateUIInfo
>     });
> }
>
> -- (void)viewDidMoveToWindow
> -{
> -    [self updateUIInfo];
> -}
> -
> - (void) switchSurface:(pixman_image_t *)image
> {
>     COCOA_DEBUG("QemuCocoaView: switchSurface\n");
>
>     int w = pixman_image_get_width(image);
>     int h = pixman_image_get_height(image);
> -    /* cdx == 0 means this is our very first surface, in which case we need
> -     * to recalculate the content dimensions even if it happens to be the size
> -     * of the initial empty window.
> -     */
> -    bool isResize = (w != screen.width || h != screen.height || cdx == 0.0);
>
> -    int oldh = screen.height;
> -    if (isResize) {
> +    if (w != screen.width || h != screen.height) {
>         // Resize before we trigger the redraw, or we'll redraw at the wrong size
>         COCOA_DEBUG("switchSurface: new size %d x %d\n", w, h);
>         screen.width = w;
>         screen.height = h;
> -        [self setContentDimensions];
> -        [self setFrame:NSMakeRect(cx, cy, cw, ch)];
> +        [self resizeWindow];
>     }
>
>     // update screenBuffer
> @@ -643,51 +633,6 @@ - (void) switchSurface:(pixman_image_t *)image
>     }
>
>     pixman_image = image;
> -
> -    // update windows
> -    if (isFullscreen) {
> -        [[fullScreenWindow contentView] setFrame:[[NSScreen mainScreen] frame]];
> -        [normalWindow setFrame:NSMakeRect([normalWindow frame].origin.x, [normalWindow frame].origin.y - h + oldh, w, h + [normalWindow frame].size.height - oldh) display:NO animate:NO];
> -    } else {
> -        if (qemu_name)
> -            [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s", qemu_name]];
> -        [normalWindow setFrame:NSMakeRect([normalWindow frame].origin.x, [normalWindow frame].origin.y - h + oldh, w, h + [normalWindow frame].size.height - oldh) display:YES animate:NO];
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
> -        isFullscreen = FALSE;
> -        [self ungrabMouse];
> -        [self setContentDimensions];
> -        [fullScreenWindow close];
> -        [normalWindow setContentView: self];
> -        [normalWindow makeKeyAndOrderFront: self];
> -        [NSMenu setMenuBarVisible:YES];
> -    } else { // switch from desktop to fullscreen
> -        isFullscreen = TRUE;
> -        [normalWindow orderOut: nil]; /* Hide the window */
> -        [self grabMouse];
> -        [self setContentDimensions];
> -        [NSMenu setMenuBarVisible:NO];
> -        fullScreenWindow = [[NSWindow alloc] initWithContentRect:[[NSScreen mainScreen] frame]
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
> }
>
> - (void) setFullGrab:(id)sender
> @@ -801,9 +746,6 @@ - (bool) handleEventLocked:(NSEvent *)event
>     COCOA_DEBUG("QemuCocoaView: handleEvent\n");
>     int buttons = 0;
>     int keycode = 0;
> -    bool mouse_event = false;
> -    // Location of event in virtual screen coordinates
> -    NSPoint p = [self screenLocationOfEvent:event];
>     NSUInteger modifiers = [event modifierFlags];
>
>     /*
> @@ -883,25 +825,25 @@ - (bool) handleEventLocked:(NSEvent *)event
>                     if (!!(modifiers & NSEventModifierFlagShift)) {
>                         [self toggleKey:Q_KEY_CODE_SHIFT];
>                     }
> -                    break;
> +                    return true;
>
>                 case kVK_RightShift:
>                     if (!!(modifiers & NSEventModifierFlagShift)) {
>                         [self toggleKey:Q_KEY_CODE_SHIFT_R];
>                     }
> -                    break;
> +                    return true;
>
>                 case kVK_Control:
>                     if (!!(modifiers & NSEventModifierFlagControl)) {
>                         [self toggleKey:Q_KEY_CODE_CTRL];
>                     }
> -                    break;
> +                    return true;
>
>                 case kVK_RightControl:
>                     if (!!(modifiers & NSEventModifierFlagControl)) {
>                         [self toggleKey:Q_KEY_CODE_CTRL_R];
>                     }
> -                    break;
> +                    return true;
>
>                 case kVK_Option:
>                     if (!!(modifiers & NSEventModifierFlagOption)) {
> @@ -911,7 +853,7 @@ - (bool) handleEventLocked:(NSEvent *)event
>                             [self toggleKey:Q_KEY_CODE_ALT];
>                         }
>                     }
> -                    break;
> +                    return true;
>
>                 case kVK_RightOption:
>                     if (!!(modifiers & NSEventModifierFlagOption)) {
> @@ -921,7 +863,7 @@ - (bool) handleEventLocked:(NSEvent *)event
>                             [self toggleKey:Q_KEY_CODE_ALT_R];
>                         }
>                     }
> -                    break;
> +                    return true;
>
>                 /* Don't pass command key changes to guest unless mouse is grabbed */
>                 case kVK_Command:
> @@ -934,7 +876,7 @@ - (bool) handleEventLocked:(NSEvent *)event
>                             [self toggleKey:Q_KEY_CODE_META_L];
>                         }
>                     }
> -                    break;
> +                    return true;
>
>                 case kVK_RightCommand:
>                     if (isMouseGrabbed &&
> @@ -945,9 +887,11 @@ - (bool) handleEventLocked:(NSEvent *)event
>                             [self toggleKey:Q_KEY_CODE_META_R];
>                         }
>                     }
> -                    break;
> +                    return true;
> +
> +                default:
> +                    return true;
>             }
> -            break;
>         case NSEventTypeKeyDown:
>             keycode = cocoa_keycode_to_qemu([event keyCode]);
>
> @@ -983,7 +927,7 @@ - (bool) handleEventLocked:(NSEvent *)event
>             } else {
>                 [self handleMonitorInput: event];
>             }
> -            break;
> +            return true;
>         case NSEventTypeKeyUp:
>             keycode = cocoa_keycode_to_qemu([event keyCode]);
>
> @@ -996,67 +940,7 @@ - (bool) handleEventLocked:(NSEvent *)event
>             if (qemu_console_is_graphic(NULL)) {
>                 qkbd_state_key_event(kbd, keycode, false);
>             }
> -            break;
> -        case NSEventTypeMouseMoved:
> -            if (isAbsoluteEnabled) {
> -                // Cursor re-entered into a window might generate events bound to screen coordinates
> -                // and `nil` window property, and in full screen mode, current window might not be
> -                // key window, where event location alone should suffice.
> -                if (![self screenContainsPoint:p] || !([[self window] isKeyWindow] || isFullscreen)) {
> -                    if (isMouseGrabbed) {
> -                        [self ungrabMouse];
> -                    }
> -                } else {
> -                    if (!isMouseGrabbed) {
> -                        [self grabMouse];
> -                    }
> -                }
> -            }
> -            mouse_event = true;
> -            break;
> -        case NSEventTypeLeftMouseDown:
> -            buttons |= MOUSE_EVENT_LBUTTON;
> -            mouse_event = true;
> -            break;
> -        case NSEventTypeRightMouseDown:
> -            buttons |= MOUSE_EVENT_RBUTTON;
> -            mouse_event = true;
> -            break;
> -        case NSEventTypeOtherMouseDown:
> -            buttons |= MOUSE_EVENT_MBUTTON;
> -            mouse_event = true;
> -            break;
> -        case NSEventTypeLeftMouseDragged:
> -            buttons |= MOUSE_EVENT_LBUTTON;
> -            mouse_event = true;
> -            break;
> -        case NSEventTypeRightMouseDragged:
> -            buttons |= MOUSE_EVENT_RBUTTON;
> -            mouse_event = true;
> -            break;
> -        case NSEventTypeOtherMouseDragged:
> -            buttons |= MOUSE_EVENT_MBUTTON;
> -            mouse_event = true;
> -            break;
> -        case NSEventTypeLeftMouseUp:
> -            mouse_event = true;
> -            if (!isMouseGrabbed && [self screenContainsPoint:p]) {
> -                /*
> -                 * In fullscreen mode, the window of cocoaView may not be the
> -                 * key window, therefore the position relative to the virtual
> -                 * screen alone will be sufficient.
> -                 */
> -                if(isFullscreen || [[self window] isKeyWindow]) {
> -                    [self grabMouse];
> -                }
> -            }
> -            break;
> -        case NSEventTypeRightMouseUp:
> -            mouse_event = true;
> -            break;
> -        case NSEventTypeOtherMouseUp:
> -            mouse_event = true;
> -            break;
> +            return true;
>         case NSEventTypeScrollWheel:
>             /*
>              * Send wheel events to the guest regardless of window focus.
> @@ -1087,62 +971,124 @@ - (bool) handleEventLocked:(NSEvent *)event
>              * Since deltaX/deltaY also report scroll wheel events we prevent mouse
>              * movement code from executing.
>              */
> -            mouse_event = false;
> -            break;
> +            return true;
>         default:
>             return false;
>     }
> +}
>
> -    if (mouse_event) {
> -        /* Don't send button events to the guest unless we've got a
> -         * mouse grab or window focus. If we have neither then this event
> -         * is the user clicking on the background window to activate and
> -         * bring us to the front, which will be done by the sendEvent
> -         * call below. We definitely don't want to pass that click through
> -         * to the guest.
> -         */
> -        if ((isMouseGrabbed || [[self window] isKeyWindow]) &&
> -            (last_buttons != buttons)) {
> -            static uint32_t bmap[INPUT_BUTTON__MAX] = {
> -                [INPUT_BUTTON_LEFT]       = MOUSE_EVENT_LBUTTON,
> -                [INPUT_BUTTON_MIDDLE]     = MOUSE_EVENT_MBUTTON,
> -                [INPUT_BUTTON_RIGHT]      = MOUSE_EVENT_RBUTTON
> -            };
> -            qemu_input_update_buttons(dcl.con, bmap, last_buttons, buttons);
> -            last_buttons = buttons;
> -        }
> -        if (isMouseGrabbed) {
> -            if (isAbsoluteEnabled) {
> -                /* Note that the origin for Cocoa mouse coords is bottom left, not top left.
> -                 * The check on screenContainsPoint is to avoid sending out of range values for
> -                 * clicks in the titlebar.
> -                 */
> -                if ([self screenContainsPoint:p]) {
> -                    qemu_input_queue_abs(dcl.con, INPUT_AXIS_X, p.x, 0, screen.width);
> -                    qemu_input_queue_abs(dcl.con, INPUT_AXIS_Y, screen.height - p.y, 0, screen.height);
> -                }
> -            } else {
> -                qemu_input_queue_rel(dcl.con, INPUT_AXIS_X, (int)[event deltaX]);
> -                qemu_input_queue_rel(dcl.con, INPUT_AXIS_Y, (int)[event deltaY]);
> -            }
> +- (void) handleMouseEvent:(NSEvent *)event
> +{
> +    if (!isMouseGrabbed) {
> +        return;
> +    }
> +
> +    with_iothread_lock(^{
> +        if (isAbsoluteEnabled) {
> +            CGFloat d = (CGFloat)screen.height / [self frame].size.height;
> +            NSPoint p = [event locationInWindow];
> +            // Note that the origin for Cocoa mouse coords is bottom left, not top left.
> +            qemu_input_queue_abs(dcl.con, INPUT_AXIS_X, p.x * d, 0, screen.width);
> +            qemu_input_queue_abs(dcl.con, INPUT_AXIS_Y, screen.height - p.y * d, 0, screen.height);
>         } else {
> -            return false;
> +            CGFloat d = (CGFloat)screen.height / [self convertSizeToBacking:[self frame].size].height;
> +            qemu_input_queue_rel(dcl.con, INPUT_AXIS_X, [event deltaX] * d);
> +            qemu_input_queue_rel(dcl.con, INPUT_AXIS_Y, [event deltaY] * d);
>         }
> +
>         qemu_input_event_sync();
> +    });
> +}
> +
> +- (void) handleMouseEvent:(NSEvent *)event button:(InputButton)button down:(bool)down
> +{
> +    if (!isMouseGrabbed) {
> +        return;
>     }
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
> }
>
> - (void) grabMouse
> {
>     COCOA_DEBUG("QemuCocoaView: grabMouse\n");
>
> -    if (!isFullscreen) {
> -        if (qemu_name)
> -            [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s - (Press  " UC_CTRL_KEY " " UC_ALT_KEY " G  to release Mouse)", qemu_name]];
> -        else
> -            [normalWindow setTitle:@"QEMU - (Press  " UC_CTRL_KEY " " UC_ALT_KEY " G  to release Mouse)"];
> -    }
> +    if (qemu_name)
> +        [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s - (Press  " UC_CTRL_KEY " " UC_ALT_KEY " G  to release Mouse)", qemu_name]];
> +    else
> +        [normalWindow setTitle:@"QEMU - (Press  " UC_CTRL_KEY " " UC_ALT_KEY " G  to release Mouse)"];
>     [self hideCursor];
>     CGAssociateMouseAndMouseCursorPosition(isAbsoluteEnabled);
>     isMouseGrabbed = TRUE; // while isMouseGrabbed = TRUE, QemuCocoaApp sends all events to [cocoaView handleEvent:]
> @@ -1152,15 +1098,14 @@ - (void) ungrabMouse
> {
>     COCOA_DEBUG("QemuCocoaView: ungrabMouse\n");
>
> -    if (!isFullscreen) {
> -        if (qemu_name)
> -            [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s", qemu_name]];
> -        else
> -            [normalWindow setTitle:@"QEMU"];
> -    }
> +    if (qemu_name)
> +        [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s", qemu_name]];
> +    else
> +        [normalWindow setTitle:@"QEMU"];
>     [self unhideCursor];
>     CGAssociateMouseAndMouseCursorPosition(TRUE);
>     isMouseGrabbed = FALSE;
> +    [self raiseAllButtons];
> }
>
> - (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled {
> @@ -1171,8 +1116,6 @@ - (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled {
> }
> - (BOOL) isMouseGrabbed {return isMouseGrabbed;}
> - (BOOL) isAbsoluteEnabled {return isAbsoluteEnabled;}
> -- (float) cdx {return cdx;}
> -- (float) cdy {return cdy;}
> - (QEMUScreen) gscreen {return screen;}
>
> /*
> @@ -1186,6 +1129,15 @@ - (void) raiseAllKeys
>         qkbd_state_lift_all_keys(kbd);
>     });
> }
> +
> +- (void) raiseAllButtons
> +{
> +    with_iothread_lock(^{
> +        qemu_input_queue_btn(dcl.con, INPUT_BUTTON_LEFT, false);
> +        qemu_input_queue_btn(dcl.con, INPUT_BUTTON_RIGHT, false);
> +        qemu_input_queue_btn(dcl.con, INPUT_BUTTON_MIDDLE, false);
> +    });
> +}
> @end
>
>
> @@ -1200,7 +1152,6 @@ @interface QemuCocoaAppController : NSObject
> {
> }
> - (void)doToggleFullScreen:(id)sender;
> -- (void)toggleFullScreen:(id)sender;
> - (void)showQEMUDoc:(id)sender;
> - (void)zoomToFit:(id) sender;
> - (void)displayConsole:(id)sender;
> @@ -1242,7 +1193,8 @@ - (id) init
>             exit(1);
>         }
>         [normalWindow setAcceptsMouseMovedEvents:YES];
> -        [normalWindow setTitle:@"QEMU"];
> +        [normalWindow setCollectionBehavior:NSWindowCollectionBehaviorFullScreenPrimary];
> +        [normalWindow setTitle:qemu_name ? [NSString stringWithFormat:@"QEMU %s", qemu_name] : @"QEMU"];
>         [normalWindow setContentView:cocoaView];
>         [normalWindow makeKeyAndOrderFront:self];
>         [normalWindow center];
> @@ -1312,9 +1264,20 @@ - (void)windowDidChangeScreen:(NSNotification *)notification
>     [cocoaView updateUIInfo];
> }
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
> - (void)windowDidResize:(NSNotification *)notification
> {
> -    [cocoaView updateUIInfo];
> +    [cocoaView frameUpdated];
> }
>
> /* Called when the user clicks on a window's close button */
> @@ -1330,6 +1293,23 @@ - (BOOL)windowShouldClose:(id)sender
>     return NO;
> }
>
> +- (NSSize) window:(NSWindow *)window willUseFullScreenContentSize:(NSSize)proposedSize
> +{
> +    if (([normalWindow styleMask] & NSWindowStyleMaskResizable) == 0) {

Same as above, testing for flag set and swapping the returns may be 
simpler to read as you don't have to think in negative condition.

> +        return NSMakeSize([cocoaView gscreen].width, [cocoaView gscreen].height);
> +    }
> +
> +    return [cocoaView fixZoomedFullScreenSize:proposedSize];
> +}
> +
> +- (NSApplicationPresentationOptions) window:(NSWindow *)window
> +                                     willUseFullScreenPresentationOptions:(NSApplicationPresentationOptions)proposedOptions;
> +
> +{
> +    return (proposedOptions & ~(NSApplicationPresentationAutoHideDock | NSApplicationPresentationAutoHideMenuBar)) |
> +           NSApplicationPresentationHideDock | NSApplicationPresentationHideMenuBar;
> +}
> +
> /*
>  * Called when QEMU goes into the background. Note that
>  * [-NSWindowDelegate windowDidResignKey:] is used here instead of
> @@ -1349,14 +1329,7 @@ - (void) windowDidResignKey: (NSNotification *)aNotification
>  */
> - (void) doToggleFullScreen:(id)sender
> {
> -    [self toggleFullScreen:(id)sender];
> -}
> -
> -- (void)toggleFullScreen:(id)sender
> -{
> -    COCOA_DEBUG("QemuCocoaAppController: toggleFullScreen\n");
> -
> -    [cocoaView toggleFullScreen:sender];
> +    [normalWindow toggleFullScreen:sender];
> }
>
> - (void) setFullGrab:(id)sender
> @@ -1400,13 +1373,15 @@ - (void)showQEMUDoc:(id)sender
>     [self openDocumentation: @"index.html"];
> }
>
> -/* Stretches video to fit host monitor size */
> +/* Toggles the flag which stretches video to fit host window size */
> - (void)zoomToFit:(id) sender
> {
> -    stretch_video = !stretch_video;
> -    if (stretch_video == true) {
> +    if (([normalWindow styleMask] & NSWindowStyleMaskResizable) == 0) {

Here again as above.

Regards,
BALATON Zoltan

> +        [normalWindow setStyleMask:[normalWindow styleMask] | NSWindowStyleMaskResizable];
>         [sender setState: NSControlStateValueOn];
>     } else {
> +        [normalWindow setStyleMask:[normalWindow styleMask] & ~NSWindowStyleMaskResizable];
> +        [cocoaView resizeWindow];
>         [sender setState: NSControlStateValueOff];
>     }
> }
> @@ -1414,7 +1389,9 @@ - (void)zoomToFit:(id) sender
> /* Displays the console on the screen */
> - (void)displayConsole:(id)sender
> {
> -    console_select([sender tag]);
> +    with_iothread_lock(^{
> +        console_select([sender tag]);
> +    });
> }
>
> /* Pause the guest */
> @@ -1671,7 +1648,7 @@ static void create_initial_menus(void)
>     menu = [[NSMenu alloc] initWithTitle:@"View"];
>     [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"Enter Fullscreen" action:@selector(doToggleFullScreen:) keyEquivalent:@"f"] autorelease]]; // Fullscreen
>     menuItem = [[[NSMenuItem alloc] initWithTitle:@"Zoom To Fit" action:@selector(zoomToFit:) keyEquivalent:@""] autorelease];
> -    [menuItem setState: stretch_video ? NSControlStateValueOn : NSControlStateValueOff];
> +    [menuItem setState: [normalWindow styleMask] & NSWindowStyleMaskResizable ? NSControlStateValueOn : NSControlStateValueOff];
>     [menu addItem: menuItem];
>     menuItem = [[[NSMenuItem alloc] initWithTitle:@"View" action:nil keyEquivalent:@""] autorelease];
>     [menuItem setSubmenu:menu];
> @@ -1962,16 +1939,14 @@ static void cocoa_update(DisplayChangeListener *dcl,
>     COCOA_DEBUG("qemu_cocoa: cocoa_update\n");
>
>     dispatch_async(dispatch_get_main_queue(), ^{
> -        NSRect rect;
> -        if ([cocoaView cdx] == 1.0) {
> -            rect = NSMakeRect(x, [cocoaView gscreen].height - y - h, w, h);
> -        } else {
> -            rect = NSMakeRect(
> -                x * [cocoaView cdx],
> -                ([cocoaView gscreen].height - y - h) * [cocoaView cdy],
> -                w * [cocoaView cdx],
> -                h * [cocoaView cdy]);
> -        }
> +        CGFloat d = [cocoaView frame].size.height / (CGFloat)[cocoaView gscreen].height;
> +
> +        NSRect rect = NSMakeRect(
> +                x * d,
> +                ([cocoaView gscreen].height - y - h) * d,
> +                w * d,
> +                h * d);
> +
>         [cocoaView setNeedsDisplayInRect:rect];
>     });
> }
> @@ -2048,8 +2023,7 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
>
>     /* if fullscreen mode is to be used */
>     if (opts->has_full_screen && opts->full_screen) {
> -        [NSApp activateIgnoringOtherApps: YES];
> -        [controller toggleFullScreen: nil];
> +        [normalWindow toggleFullScreen: nil];
>     }
>     if (opts->u.cocoa.has_full_grab && opts->u.cocoa.full_grab) {
>         [controller setFullGrab: nil];
> @@ -2067,7 +2041,7 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
>     }
>
>     if (opts->u.cocoa.has_zoom_to_fit && opts->u.cocoa.zoom_to_fit) {
> -        stretch_video = true;
> +        [normalWindow setStyleMask:[normalWindow styleMask] | NSWindowStyleMaskResizable];
>     }
>
>     create_initial_menus();
>
> ---
> base-commit: 9c74490bff6c8886a922008d0c9ce6cae70dd17e
> change-id: 20231211-cocoa-576b8639e9bd
>
> Best regards,
>

