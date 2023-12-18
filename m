Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F26E8167AD
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 08:48:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rF8LY-00081n-P9; Mon, 18 Dec 2023 02:47:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rF8LV-00081V-Ae
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 02:47:25 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rF8LS-00053G-GS
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 02:47:25 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d32c5ce32eso27654505ad.0
 for <qemu-devel@nongnu.org>; Sun, 17 Dec 2023 23:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702885641; x=1703490441;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kM9TDnK3aCKIejR89sB+D0fVEY9do/hfi/rBYHx4awo=;
 b=fLt6aXFH9NjA/oS3b9pxdZjS4rDzDyQ+c8aFvBSVwk9cRPPwXcZiw2Qb8jXwkIyNk5
 HfqxSkoNe4RsHZb3hGTE8qrf4LWqzJSq0szQ0lSSab9Iy7ePzEKbkgYcCa59DCYX2+Bb
 YIc0RIO4tOVo/WvzLcDXz8a4HoQpDRrfkMzHirdc06qQHu/1XI1Mr/rZz0wddvl5J8U0
 uflMPHAcyvi0d4+dNRlt/J/J19GWVQzjIWO3979QbObBM5y3LnxFSjqD62nPwACH21MX
 RT6OHhFP0oERYvdOnMz+KihPO/CVW4JcFGbsvqcMpwa8hwFzkOcST+t4qaiX3ygk3tPD
 O+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702885641; x=1703490441;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kM9TDnK3aCKIejR89sB+D0fVEY9do/hfi/rBYHx4awo=;
 b=B+xjzYiglY5xaTxOTCV81ZWBU7WXqlGt5hFC1CUDFvM4+DysC/Zp/BSjM1gs2MG4G8
 3s8PXoOi23ELCIi1AZnhUqreEDPznSU8RRZ0j3c9QvXSdmhtMjPib5t59ItDo6oF9MiY
 gSQv8Y2yV2n8oj8kX1FnHoy8mH7pDPDPrQuowDCNCsr1gp6XbHZSnUDKGFyiCweuOglZ
 95CHpBZEQ79W95jsKoyJSd3m0O1tkeSwqLIlno02Fdku43BVEfIoTiimMANY3gTxZEIE
 pSgYYgvAMojP/8N290i/MeMA3g+SddIJBawmmTiZlS00Xedi0BvLTCgxVsisW9k+BO9l
 toQQ==
X-Gm-Message-State: AOJu0YxelsAv4B9Muya7DziNKyZgQj7o+4ha9e9I+fJlxXhNYwWM86M7
 q8QL/22JlF2aXoFlIcn5MMvhAQ==
X-Google-Smtp-Source: AGHT+IHIoiuL+NZSu4B6qaLWpySErIMZOwtMr+28eGQ/AfutGH0b5yUVOyMnQ0KB3OBrOLg06WHDhw==
X-Received: by 2002:a17:902:d10c:b0:1d3:9128:2ce0 with SMTP id
 w12-20020a170902d10c00b001d391282ce0mr4105289plw.58.1702885640927; 
 Sun, 17 Dec 2023 23:47:20 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 f13-20020a170902ce8d00b001d0cfd7f6b9sm6271572plg.54.2023.12.17.23.47.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Dec 2023 23:47:20 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 18 Dec 2023 16:47:02 +0900
Subject: [PATCH v8 2/3] ui/cocoa: Use NSWindow's ability to resize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-cocoa-v8-2-d7fad80c7ef6@daynix.com>
References: <20231218-cocoa-v8-0-d7fad80c7ef6@daynix.com>
In-Reply-To: <20231218-cocoa-v8-0-d7fad80c7ef6@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
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

This change brings two new features:
- The window will be resizable if "Zoom To Fit" is eanbled
- The window can be made full screen by clicking full screen button
  provided by the platform. (The left-top green button.)

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Rene Engel <ReneEngel80@emailn.de>
---
 ui/cocoa.m | 458 ++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 227 insertions(+), 231 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 4db85d8dfac8..1357690e50ca 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -303,20 +303,17 @@ static void handleAnyDeviceErrors(Error * err)
 */
 @interface QemuCocoaView : NSView
 {
+    NSTrackingArea *trackingArea;
     QEMUScreen screen;
-    NSWindow *fullScreenWindow;
-    float cx,cy,cw,ch,cdx,cdy;
     pixman_image_t *pixman_image;
     QKbdState *kbd;
     BOOL isMouseGrabbed;
-    BOOL isFullscreen;
     BOOL isAbsoluteEnabled;
     CFMachPortRef eventsTap;
 }
 - (void) switchSurface:(pixman_image_t *)image;
 - (void) grabMouse;
 - (void) ungrabMouse;
-- (void) toggleFullScreen:(id)sender;
 - (void) setFullGrab:(id)sender;
 - (void) handleMonitorInput:(NSEvent *)event;
 - (bool) handleEvent:(NSEvent *)event;
@@ -332,8 +329,6 @@ - (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled;
  */
 - (BOOL) isMouseGrabbed;
 - (BOOL) isAbsoluteEnabled;
-- (float) cdx;
-- (float) cdy;
 - (QEMUScreen) gscreen;
 - (void) raiseAllKeys;
 @end
@@ -391,46 +386,43 @@ - (BOOL) isOpaque
     return YES;
 }
 
-- (BOOL) screenContainsPoint:(NSPoint) p
+- (void) removeTrackingRect
 {
-    return (p.x > -1 && p.x < screen.width && p.y > -1 && p.y < screen.height);
+    if (trackingArea) {
+        [self removeTrackingArea:trackingArea];
+        [trackingArea release];
+        trackingArea = nil;
+    }
 }
 
-/* Get location of event and convert to virtual screen coordinate */
-- (CGPoint) screenLocationOfEvent:(NSEvent *)ev
+- (void) frameUpdated
 {
-    NSWindow *eventWindow = [ev window];
-    // XXX: Use CGRect and -convertRectFromScreen: to support macOS 10.10
-    CGRect r = CGRectZero;
-    r.origin = [ev locationInWindow];
-    if (!eventWindow) {
-        if (!isFullscreen) {
-            return [[self window] convertRectFromScreen:r].origin;
-        } else {
-            CGPoint locationInSelfWindow = [[self window] convertRectFromScreen:r].origin;
-            CGPoint loc = [self convertPoint:locationInSelfWindow fromView:nil];
-            if (stretch_video) {
-                loc.x /= cdx;
-                loc.y /= cdy;
-            }
-            return loc;
-        }
-    } else if ([[self window] isEqual:eventWindow]) {
-        if (!isFullscreen) {
-            return r.origin;
-        } else {
-            CGPoint loc = [self convertPoint:r.origin fromView:nil];
-            if (stretch_video) {
-                loc.x /= cdx;
-                loc.y /= cdy;
-            }
-            return loc;
-        }
-    } else {
-        return [[self window] convertRectFromScreen:[eventWindow convertRectToScreen:r]].origin;
+    [self removeTrackingRect];
+
+    if ([self window]) {
+        NSTrackingAreaOptions options = NSTrackingActiveInKeyWindow |
+                                        NSTrackingMouseEnteredAndExited |
+                                        NSTrackingMouseMoved;
+        trackingArea = [[NSTrackingArea alloc] initWithRect:[self frame]
+                                                    options:options
+                                                      owner:self
+                                                   userInfo:nil];
+        [self addTrackingArea:trackingArea];
+        [self updateUIInfo];
     }
 }
 
+- (void) viewDidMoveToWindow
+{
+    [self resizeWindow];
+    [self frameUpdated];
+}
+
+- (void) viewWillMoveToWindow:(NSWindow *)newWindow
+{
+    [self removeTrackingRect];
+}
+
 - (void) hideCursor
 {
     if (!cursor_hide) {
@@ -493,13 +485,14 @@ - (void) drawRect:(NSRect) rect
         int i;
         CGImageRef clipImageRef;
         CGRect clipRect;
+        CGFloat d = (CGFloat)h / [self frame].size.height;
 
         [self getRectsBeingDrawn:&rectList count:&rectCount];
         for (i = 0; i < rectCount; i++) {
-            clipRect.origin.x = rectList[i].origin.x / cdx;
-            clipRect.origin.y = (float)h - (rectList[i].origin.y + rectList[i].size.height) / cdy;
-            clipRect.size.width = rectList[i].size.width / cdx;
-            clipRect.size.height = rectList[i].size.height / cdy;
+            clipRect.origin.x = rectList[i].origin.x * d;
+            clipRect.origin.y = (float)h - (rectList[i].origin.y + rectList[i].size.height) * d;
+            clipRect.size.width = rectList[i].size.width * d;
+            clipRect.size.height = rectList[i].size.height * d;
             clipImageRef = CGImageCreateWithImageInRect(
                                                         imageRef,
                                                         clipRect
@@ -512,36 +505,43 @@ - (void) drawRect:(NSRect) rect
     }
 }
 
-- (void) setContentDimensions
+- (NSSize) fixZoomedFullScreenSize:(NSSize)proposedSize
 {
-    COCOA_DEBUG("QemuCocoaView: setContentDimensions\n");
+    NSSize size;
 
-    if (isFullscreen) {
-        cdx = [[NSScreen mainScreen] frame].size.width / (float)screen.width;
-        cdy = [[NSScreen mainScreen] frame].size.height / (float)screen.height;
+    size.width = (CGFloat)screen.width * proposedSize.height;
+    size.height = (CGFloat)screen.height * proposedSize.width;
 
-        /* stretches video, but keeps same aspect ratio */
-        if (stretch_video == true) {
-            /* use smallest stretch value - prevents clipping on sides */
-            if (MIN(cdx, cdy) == cdx) {
-                cdy = cdx;
-            } else {
-                cdx = cdy;
-            }
-        } else {  /* No stretching */
-            cdx = cdy = 1;
-        }
-        cw = screen.width * cdx;
-        ch = screen.height * cdy;
-        cx = ([[NSScreen mainScreen] frame].size.width - cw) / 2.0;
-        cy = ([[NSScreen mainScreen] frame].size.height - ch) / 2.0;
+    if (size.width < size.height) {
+        size.width /= screen.height;
+        size.height = proposedSize.height;
     } else {
-        cx = 0;
-        cy = 0;
-        cw = screen.width;
-        ch = screen.height;
-        cdx = 1.0;
-        cdy = 1.0;
+        size.width = proposedSize.width;
+        size.height /= screen.width;
+    }
+
+    return size;
+}
+
+- (NSSize) screenSafeAreaSize
+{
+    NSSize size = [[[self window] screen] frame].size;
+    NSEdgeInsets insets = [[[self window] screen] safeAreaInsets];
+    size.width -= insets.left + insets.right;
+    size.height -= insets.top + insets.bottom;
+    return size;
+}
+
+- (void) resizeWindow
+{
+    [[self window] setContentAspectRatio:NSMakeSize(screen.width, screen.height)];
+
+    if (!([[self window] styleMask] & NSWindowStyleMaskResizable)) {
+        [[self window] setContentSize:NSMakeSize(screen.width, screen.height)];
+        [[self window] center];
+    } else if ([[self window] styleMask] & NSWindowStyleMaskFullScreen) {
+        [[self window] setContentSize:[self fixZoomedFullScreenSize:[self screenSafeAreaSize]]];
+        [[self window] center];
     }
 }
 
@@ -560,9 +560,10 @@ - (void) updateUIInfoLocked
         CGDirectDisplayID display = [[description objectForKey:@"NSScreenNumber"] unsignedIntValue];
         NSSize screenSize = [[[self window] screen] frame].size;
         CGSize screenPhysicalSize = CGDisplayScreenSize(display);
+        bool isFullscreen = ([[self window] styleMask] & NSWindowStyleMaskFullScreen) != 0;
         CVDisplayLinkRef displayLink;
 
-        frameSize = isFullscreen ? screenSize : [self frame].size;
+        frameSize = isFullscreen ? [self screenSafeAreaSize] : [self frame].size;
 
         if (!CVDisplayLinkCreateWithCGDisplay(display, &displayLink)) {
             CVTime period = CVDisplayLinkGetNominalOutputVideoRefreshPeriod(displayLink);
@@ -609,31 +610,19 @@ - (void) updateUIInfo
     });
 }
 
-- (void)viewDidMoveToWindow
-{
-    [self updateUIInfo];
-}
-
 - (void) switchSurface:(pixman_image_t *)image
 {
     COCOA_DEBUG("QemuCocoaView: switchSurface\n");
 
     int w = pixman_image_get_width(image);
     int h = pixman_image_get_height(image);
-    /* cdx == 0 means this is our very first surface, in which case we need
-     * to recalculate the content dimensions even if it happens to be the size
-     * of the initial empty window.
-     */
-    bool isResize = (w != screen.width || h != screen.height || cdx == 0.0);
 
-    int oldh = screen.height;
-    if (isResize) {
+    if (w != screen.width || h != screen.height) {
         // Resize before we trigger the redraw, or we'll redraw at the wrong size
         COCOA_DEBUG("switchSurface: new size %d x %d\n", w, h);
         screen.width = w;
         screen.height = h;
-        [self setContentDimensions];
-        [self setFrame:NSMakeRect(cx, cy, cw, ch)];
+        [self resizeWindow];
     }
 
     // update screenBuffer
@@ -642,51 +631,6 @@ - (void) switchSurface:(pixman_image_t *)image
     }
 
     pixman_image = image;
-
-    // update windows
-    if (isFullscreen) {
-        [[fullScreenWindow contentView] setFrame:[[NSScreen mainScreen] frame]];
-        [normalWindow setFrame:NSMakeRect([normalWindow frame].origin.x, [normalWindow frame].origin.y - h + oldh, w, h + [normalWindow frame].size.height - oldh) display:NO animate:NO];
-    } else {
-        if (qemu_name)
-            [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s", qemu_name]];
-        [normalWindow setFrame:NSMakeRect([normalWindow frame].origin.x, [normalWindow frame].origin.y - h + oldh, w, h + [normalWindow frame].size.height - oldh) display:YES animate:NO];
-    }
-
-    if (isResize) {
-        [normalWindow center];
-    }
-}
-
-- (void) toggleFullScreen:(id)sender
-{
-    COCOA_DEBUG("QemuCocoaView: toggleFullScreen\n");
-
-    if (isFullscreen) { // switch from fullscreen to desktop
-        isFullscreen = FALSE;
-        [self ungrabMouse];
-        [self setContentDimensions];
-        [fullScreenWindow close];
-        [normalWindow setContentView: self];
-        [normalWindow makeKeyAndOrderFront: self];
-        [NSMenu setMenuBarVisible:YES];
-    } else { // switch from desktop to fullscreen
-        isFullscreen = TRUE;
-        [normalWindow orderOut: nil]; /* Hide the window */
-        [self grabMouse];
-        [self setContentDimensions];
-        [NSMenu setMenuBarVisible:NO];
-        fullScreenWindow = [[NSWindow alloc] initWithContentRect:[[NSScreen mainScreen] frame]
-            styleMask:NSWindowStyleMaskBorderless
-            backing:NSBackingStoreBuffered
-            defer:NO];
-        [fullScreenWindow setAcceptsMouseMovedEvents: YES];
-        [fullScreenWindow setHasShadow:NO];
-        [fullScreenWindow setBackgroundColor: [NSColor blackColor]];
-        [self setFrame:NSMakeRect(cx, cy, cw, ch)];
-        [[fullScreenWindow contentView] addSubview: self];
-        [fullScreenWindow makeKeyAndOrderFront:self];
-    }
 }
 
 - (void) setFullGrab:(id)sender
@@ -800,7 +744,6 @@ - (bool) handleEventLocked:(NSEvent *)event
     COCOA_DEBUG("QemuCocoaView: handleEvent\n");
     int buttons = 0;
     int keycode = 0;
-    NSPoint p = [self screenLocationOfEvent:event];
     NSUInteger modifiers = [event modifierFlags];
 
     /*
@@ -996,48 +939,6 @@ - (bool) handleEventLocked:(NSEvent *)event
                 qkbd_state_key_event(kbd, keycode, false);
             }
             return true;
-        case NSEventTypeMouseMoved:
-            if (isAbsoluteEnabled) {
-                // Cursor re-entered into a window might generate events bound to screen coordinates
-                // and `nil` window property, and in full screen mode, current window might not be
-                // key window, where event location alone should suffice.
-                if (![self screenContainsPoint:p] || !([[self window] isKeyWindow] || isFullscreen)) {
-                    if (isMouseGrabbed) {
-                        [self ungrabMouse];
-                    }
-                } else {
-                    if (!isMouseGrabbed) {
-                        [self grabMouse];
-                    }
-                }
-            }
-            return [self handleMouseEvent:event];
-        case NSEventTypeLeftMouseDown:
-            return [self handleMouseEvent:event button:MOUSE_EVENT_LBUTTON down:true];
-        case NSEventTypeRightMouseDown:
-            return [self handleMouseEvent:event button:MOUSE_EVENT_RBUTTON down:true];
-        case NSEventTypeLeftMouseDragged:
-            return [self handleMouseEvent:event button:MOUSE_EVENT_LBUTTON down:true];
-        case NSEventTypeRightMouseDragged:
-            return [self handleMouseEvent:event button:MOUSE_EVENT_RBUTTON down:true];
-        case NSEventTypeOtherMouseDragged:
-            return [self handleMouseEvent:event button:MOUSE_EVENT_MBUTTON down:true];
-        case NSEventTypeLeftMouseUp:
-            if (!isMouseGrabbed && [self screenContainsPoint:p]) {
-                /*
-                 * In fullscreen mode, the window of cocoaView may not be the
-                 * key window, therefore the position relative to the virtual
-                 * screen alone will be sufficient.
-                 */
-                if(isFullscreen || [[self window] isKeyWindow]) {
-                    [self grabMouse];
-                }
-            }
-            return [self handleMouseEvent:event button:MOUSE_EVENT_LBUTTON down:false];
-        case NSEventTypeRightMouseUp:
-            return [self handleMouseEvent:event button:MOUSE_EVENT_RBUTTON down:false];
-        case NSEventTypeOtherMouseUp:
-            return [self handleMouseEvent:event button:MOUSE_EVENT_MBUTTON down:false];
         case NSEventTypeScrollWheel:
             /*
              * Send wheel events to the guest regardless of window focus.
@@ -1074,53 +975,118 @@ - (bool) handleEventLocked:(NSEvent *)event
     }
 }
 
-- (bool) handleMouseEvent:(NSEvent *)event
+- (void) handleMouseEvent:(NSEvent *)event
 {
     if (!isMouseGrabbed) {
-        return false;
+        return;
     }
 
-    if (isAbsoluteEnabled) {
-        NSPoint p = [self screenLocationOfEvent:event];
-        /* Note that the origin for Cocoa mouse coords is bottom left, not top left.
-         * The check on screenContainsPoint is to avoid sending out of range values for
-         * clicks in the titlebar.
-         */
-        if ([self screenContainsPoint:p]) {
-            qemu_input_queue_abs(dcl.con, INPUT_AXIS_X, p.x, 0, screen.width);
-            qemu_input_queue_abs(dcl.con, INPUT_AXIS_Y, screen.height - p.y, 0, screen.height);
+    with_iothread_lock(^{
+        if (isAbsoluteEnabled) {
+            CGFloat d = (CGFloat)screen.height / [self frame].size.height;
+            NSPoint p = [event locationInWindow];
+            /* Note that the origin for Cocoa mouse coords is bottom left, not top left. */
+            qemu_input_queue_abs(dcl.con, INPUT_AXIS_X, p.x * d, 0, screen.width);
+            qemu_input_queue_abs(dcl.con, INPUT_AXIS_Y, screen.height - p.y * d, 0, screen.height);
+        } else {
+            CGFloat d = (CGFloat)screen.height / [self convertSizeToBacking:[self frame].size].height;
+            qemu_input_queue_rel(dcl.con, INPUT_AXIS_X, [event deltaX] * d);
+            qemu_input_queue_rel(dcl.con, INPUT_AXIS_Y, [event deltaY] * d);
         }
-    } else {
-        qemu_input_queue_rel(dcl.con, INPUT_AXIS_X, (int)[event deltaX]);
-        qemu_input_queue_rel(dcl.con, INPUT_AXIS_Y, (int)[event deltaY]);
+
+        qemu_input_event_sync();
+    });
+}
+
+- (void) handleMouseEvent:(NSEvent *)event button:(InputButton)button down:(bool)down
+{
+    if (!isMouseGrabbed) {
+        return;
     }
 
-    qemu_input_event_sync();
+    with_iothread_lock(^{
+        qemu_input_queue_btn(dcl.con, button, down);
+    });
 
-    return true;
+    [self handleMouseEvent:event];
 }
 
-- (bool) handleMouseEvent:(NSEvent *)event button:(InputButton)button down:(bool)down
+- (void) mouseExited:(NSEvent *)event
 {
-    if (!isMouseGrabbed && ![[self window] isKeyWindow]) {
-        return false;
+    if (isAbsoluteEnabled && isMouseGrabbed) {
+        [self ungrabMouse];
     }
+}
 
-    qemu_input_queue_btn(dcl.con, button, down);
+- (void) mouseEntered:(NSEvent *)event
+{
+    if (isAbsoluteEnabled && !isMouseGrabbed) {
+        [self grabMouse];
+    }
+}
+
+- (void) mouseMoved:(NSEvent *)event
+{
+    [self handleMouseEvent:event];
+}
+
+- (void) mouseDown:(NSEvent *)event
+{
+    [self handleMouseEvent:event button:INPUT_BUTTON_LEFT down:true];
+}
+
+- (void) rightMouseDown:(NSEvent *)event
+{
+    [self handleMouseEvent:event button:INPUT_BUTTON_RIGHT down:true];
+}
 
-    return [self handleMouseEvent:event];
+- (void) otherMouseDown:(NSEvent *)event
+{
+    [self handleMouseEvent:event button:INPUT_BUTTON_MIDDLE down:true];
+}
+
+- (void) mouseDragged:(NSEvent *)event
+{
+    [self handleMouseEvent:event];
+}
+
+- (void) rightMouseDragged:(NSEvent *)event
+{
+    [self handleMouseEvent:event];
+}
+
+- (void) otherMouseDragged:(NSEvent *)event
+{
+    [self handleMouseEvent:event];
+}
+
+- (void) mouseUp:(NSEvent *)event
+{
+    if (!isMouseGrabbed) {
+        [self grabMouse];
+    }
+
+    [self handleMouseEvent:event button:INPUT_BUTTON_LEFT down:false];
+}
+
+- (void) rightMouseUp:(NSEvent *)event
+{
+    [self handleMouseEvent:event button:INPUT_BUTTON_RIGHT down:false];
+}
+
+- (void) otherMouseUp:(NSEvent *)event
+{
+    [self handleMouseEvent:event button:INPUT_BUTTON_MIDDLE down:false];
 }
 
 - (void) grabMouse
 {
     COCOA_DEBUG("QemuCocoaView: grabMouse\n");
 
-    if (!isFullscreen) {
-        if (qemu_name)
-            [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s - (Press  " UC_CTRL_KEY " " UC_ALT_KEY " G  to release Mouse)", qemu_name]];
-        else
-            [normalWindow setTitle:@"QEMU - (Press  " UC_CTRL_KEY " " UC_ALT_KEY " G  to release Mouse)"];
-    }
+    if (qemu_name)
+        [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s - (Press  " UC_CTRL_KEY " " UC_ALT_KEY " G  to release Mouse)", qemu_name]];
+    else
+        [normalWindow setTitle:@"QEMU - (Press  " UC_CTRL_KEY " " UC_ALT_KEY " G  to release Mouse)"];
     [self hideCursor];
     CGAssociateMouseAndMouseCursorPosition(isAbsoluteEnabled);
     isMouseGrabbed = TRUE; // while isMouseGrabbed = TRUE, QemuCocoaApp sends all events to [cocoaView handleEvent:]
@@ -1130,15 +1096,14 @@ - (void) ungrabMouse
 {
     COCOA_DEBUG("QemuCocoaView: ungrabMouse\n");
 
-    if (!isFullscreen) {
-        if (qemu_name)
-            [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s", qemu_name]];
-        else
-            [normalWindow setTitle:@"QEMU"];
-    }
+    if (qemu_name)
+        [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s", qemu_name]];
+    else
+        [normalWindow setTitle:@"QEMU"];
     [self unhideCursor];
     CGAssociateMouseAndMouseCursorPosition(TRUE);
     isMouseGrabbed = FALSE;
+    [self raiseAllButtons];
 }
 
 - (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled {
@@ -1149,8 +1114,6 @@ - (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled {
 }
 - (BOOL) isMouseGrabbed {return isMouseGrabbed;}
 - (BOOL) isAbsoluteEnabled {return isAbsoluteEnabled;}
-- (float) cdx {return cdx;}
-- (float) cdy {return cdy;}
 - (QEMUScreen) gscreen {return screen;}
 
 /*
@@ -1164,6 +1127,15 @@ - (void) raiseAllKeys
         qkbd_state_lift_all_keys(kbd);
     });
 }
+
+- (void) raiseAllButtons
+{
+    with_iothread_lock(^{
+        qemu_input_queue_btn(dcl.con, INPUT_BUTTON_LEFT, false);
+        qemu_input_queue_btn(dcl.con, INPUT_BUTTON_RIGHT, false);
+        qemu_input_queue_btn(dcl.con, INPUT_BUTTON_MIDDLE, false);
+    });
+}
 @end
 
 
@@ -1178,7 +1150,6 @@ @interface QemuCocoaAppController : NSObject
 {
 }
 - (void)doToggleFullScreen:(id)sender;
-- (void)toggleFullScreen:(id)sender;
 - (void)showQEMUDoc:(id)sender;
 - (void)zoomToFit:(id) sender;
 - (void)displayConsole:(id)sender;
@@ -1220,7 +1191,8 @@ - (id) init
             exit(1);
         }
         [normalWindow setAcceptsMouseMovedEvents:YES];
-        [normalWindow setTitle:@"QEMU"];
+        [normalWindow setCollectionBehavior:NSWindowCollectionBehaviorFullScreenPrimary];
+        [normalWindow setTitle:qemu_name ? [NSString stringWithFormat:@"QEMU %s", qemu_name] : @"QEMU"];
         [normalWindow setContentView:cocoaView];
         [normalWindow makeKeyAndOrderFront:self];
         [normalWindow center];
@@ -1290,9 +1262,20 @@ - (void)windowDidChangeScreen:(NSNotification *)notification
     [cocoaView updateUIInfo];
 }
 
+- (void)windowDidEnterFullScreen:(NSNotification *)notification
+{
+    [cocoaView grabMouse];
+}
+
+- (void)windowDidExitFullScreen:(NSNotification *)notification
+{
+    [cocoaView resizeWindow];
+    [cocoaView ungrabMouse];
+}
+
 - (void)windowDidResize:(NSNotification *)notification
 {
-    [cocoaView updateUIInfo];
+    [cocoaView frameUpdated];
 }
 
 /* Called when the user clicks on a window's close button */
@@ -1308,6 +1291,23 @@ - (BOOL)windowShouldClose:(id)sender
     return NO;
 }
 
+- (NSSize) window:(NSWindow *)window willUseFullScreenContentSize:(NSSize)proposedSize
+{
+    if ([normalWindow styleMask] & NSWindowStyleMaskResizable) {
+        return [cocoaView fixZoomedFullScreenSize:proposedSize];
+    }
+
+    return NSMakeSize([cocoaView gscreen].width, [cocoaView gscreen].height);
+}
+
+- (NSApplicationPresentationOptions) window:(NSWindow *)window
+                                     willUseFullScreenPresentationOptions:(NSApplicationPresentationOptions)proposedOptions;
+
+{
+    return (proposedOptions & ~(NSApplicationPresentationAutoHideDock | NSApplicationPresentationAutoHideMenuBar)) |
+           NSApplicationPresentationHideDock | NSApplicationPresentationHideMenuBar;
+}
+
 /*
  * Called when QEMU goes into the background. Note that
  * [-NSWindowDelegate windowDidResignKey:] is used here instead of
@@ -1327,14 +1327,7 @@ - (void) windowDidResignKey: (NSNotification *)aNotification
  */
 - (void) doToggleFullScreen:(id)sender
 {
-    [self toggleFullScreen:(id)sender];
-}
-
-- (void)toggleFullScreen:(id)sender
-{
-    COCOA_DEBUG("QemuCocoaAppController: toggleFullScreen\n");
-
-    [cocoaView toggleFullScreen:sender];
+    [normalWindow toggleFullScreen:sender];
 }
 
 - (void) setFullGrab:(id)sender
@@ -1383,8 +1376,11 @@ - (void)zoomToFit:(id) sender
 {
     stretch_video = !stretch_video;
     if (stretch_video == true) {
+        [normalWindow setStyleMask:[normalWindow styleMask] | NSWindowStyleMaskResizable];
         [sender setState: NSControlStateValueOn];
     } else {
+        [normalWindow setStyleMask:[normalWindow styleMask] & ~NSWindowStyleMaskResizable];
+        [cocoaView resizeWindow];
         [sender setState: NSControlStateValueOff];
     }
 }
@@ -1392,7 +1388,9 @@ - (void)zoomToFit:(id) sender
 /* Displays the console on the screen */
 - (void)displayConsole:(id)sender
 {
-    console_select([sender tag]);
+    with_iothread_lock(^{
+        console_select([sender tag]);
+    });
 }
 
 /* Pause the guest */
@@ -1940,16 +1938,14 @@ static void cocoa_update(DisplayChangeListener *dcl,
     COCOA_DEBUG("qemu_cocoa: cocoa_update\n");
 
     dispatch_async(dispatch_get_main_queue(), ^{
-        NSRect rect;
-        if ([cocoaView cdx] == 1.0) {
-            rect = NSMakeRect(x, [cocoaView gscreen].height - y - h, w, h);
-        } else {
-            rect = NSMakeRect(
-                x * [cocoaView cdx],
-                ([cocoaView gscreen].height - y - h) * [cocoaView cdy],
-                w * [cocoaView cdx],
-                h * [cocoaView cdy]);
-        }
+        CGFloat d = [cocoaView frame].size.height / (CGFloat)[cocoaView gscreen].height;
+
+        NSRect rect = NSMakeRect(
+                x * d,
+                ([cocoaView gscreen].height - y - h) * d,
+                w * d,
+                h * d);
+
         [cocoaView setNeedsDisplayInRect:rect];
     });
 }
@@ -2026,8 +2022,7 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 
     /* if fullscreen mode is to be used */
     if (opts->has_full_screen && opts->full_screen) {
-        [NSApp activateIgnoringOtherApps: YES];
-        [controller toggleFullScreen: nil];
+        [normalWindow toggleFullScreen: nil];
     }
     if (opts->u.cocoa.has_full_grab && opts->u.cocoa.full_grab) {
         [controller setFullGrab: nil];
@@ -2046,6 +2041,7 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 
     if (opts->u.cocoa.has_zoom_to_fit && opts->u.cocoa.zoom_to_fit) {
         stretch_video = true;
+        [normalWindow setStyleMask:[normalWindow styleMask] | NSWindowStyleMaskResizable];
     }
 
     create_initial_menus();

-- 
2.43.0


