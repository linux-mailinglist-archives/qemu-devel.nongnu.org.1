Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47098930D8F
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jul 2024 07:26:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTEEB-0002WT-IN; Mon, 15 Jul 2024 01:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTEE9-0002Sj-Vq
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:26:21 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTEE3-0000fu-M4
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:26:21 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fb1ff21748so23037695ad.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 22:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721021174; x=1721625974;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HyblI6J8nHcgpLCqw/BWLjpJpAxCOF36i19GG8sv7lM=;
 b=sqJg/Uq3v1Mtj5llX7QXC1CPbza4NoAaTVQrxr9cBjfnGg+6ESYfcdJCzFy9BFfRta
 He0qVFkDPxCab8wBRQvzkh/pkRDbOI0NDsrQKNzQXbL+cS/BZtBVOMH9mHI65mrH0Knc
 obaf8CUtIhk73jurQ7+GwlZcAhlbahl1AhDDIPCozr55KNUUT1DC9bo8dJwk0n4gQmxv
 ybW5F3GW9B7jkkQZ/y0CTKctGMhHF4QNIHQH7T6LY1A5fxdKzOnoHBN6oZN15ChNHvjz
 s9LMVeLEAwpU9Dk853M7UmvLtY2c33bXATDBy5/C77S/byiyGMmhy0wxKs/1TWYzSRaw
 tDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721021174; x=1721625974;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HyblI6J8nHcgpLCqw/BWLjpJpAxCOF36i19GG8sv7lM=;
 b=n9CR1mdvrp+hwhG47+jJdIdea/Bch13yVW4p71hCrz323lS7jUQJt2fhPt52Km5ATs
 8aSNTBkO/38pUtYVaHTXDCcOA2bXkkj+xzLEEotqy+VBTtg3+d9oOuhF3QUsRnz/hDNX
 oHAOydfFbHFySB2rZAEbT4Ad5s5h9HsXZCdl52kDQ19Z6vJibf78jcA4ZjrA2MPt/UUK
 seRIaHG3Cd5EKWqtG+Fp7MqNjp4EXErVfVIyV9+lla4+HMfhQsY/YUNpHg8JywVT1NIj
 cOOtcXnZys+YZExNMsytIBEVtETJA2H3qLJsnxNOMEQiFml/rBjsYZe32OStGUR7bXqu
 u4ag==
X-Gm-Message-State: AOJu0YwWfYfCnASUjN7/6QGbTDOqlGLl7dwoOR882BGAPxEH4ftn3V+E
 R0DLJlZE5tXzVDRVz5W3ub0nMN7YTJdw54qErYGNAJg4+pv2KRw0QKAdT/nJXTc=
X-Google-Smtp-Source: AGHT+IHDkdivwGRLEIBJutOl4xE56xLlI1/bXDCfZ5YEIxvWpoUnO5VUijOS61umFJtNDdpAN0DhOw==
X-Received: by 2002:a17:902:760f:b0:1fb:3474:9525 with SMTP id
 d9443c01a7336-1fbb6d4dc4cmr76802695ad.29.1721021174306; 
 Sun, 14 Jul 2024 22:26:14 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fc0bb6fe47sm31660865ad.49.2024.07.14.22.26.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 22:26:14 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 15 Jul 2024 14:25:44 +0900
Subject: [PATCH v3 3/4] ui/cocoa: Add cursor composition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-cursor-v3-3-afa5b9492dbf@daynix.com>
References: <20240715-cursor-v3-0-afa5b9492dbf@daynix.com>
In-Reply-To: <20240715-cursor-v3-0-afa5b9492dbf@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add accelerated cursor composition to ui/cocoa. This does not only
improve performance for display devices that exposes the capability to
the guest according to dpy_cursor_define_supported(), but fixes the
cursor display for devices that unconditionally expects the availability
of the capability (e.g., virtio-gpu).

The common pattern to implement accelerated cursor composition is to
replace the cursor and warp it so that the replaced cursor is shown at
the correct position on the guest display for relative pointer devices.
Unfortunately, ui/cocoa cannot do the same because warping the cursor
position interfers with the mouse input so it uses CALayer instead;
although it is not specialized for cursor composition, it still can
compose images with hardware acceleration.

Co-authored-by: Phil Dennis-Jordan <phil@philjordan.eu>
Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 meson.build |  3 +-
 ui/cocoa.m  | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 638660714455..59cc1fb8bcfc 100644
--- a/meson.build
+++ b/meson.build
@@ -1041,7 +1041,8 @@ if get_option('attr').allowed()
   endif
 endif
 
-cocoa = dependency('appleframeworks', modules: ['Cocoa', 'CoreVideo'],
+cocoa = dependency('appleframeworks',
+                   modules: ['Cocoa', 'CoreVideo', 'QuartzCore'],
                    required: get_option('cocoa'))
 
 vmnet = dependency('appleframeworks', modules: 'vmnet', required: get_option('vmnet'))
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 908454a434c5..0f52cf0de934 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 
 #import <Cocoa/Cocoa.h>
+#import <QuartzCore/QuartzCore.h>
 #include <crt_externs.h>
 
 #include "qemu/help-texts.h"
@@ -79,12 +80,16 @@ static void cocoa_switch(DisplayChangeListener *dcl,
                          DisplaySurface *surface);
 
 static void cocoa_refresh(DisplayChangeListener *dcl);
+static void cocoa_mouse_set(DisplayChangeListener *dcl, int x, int y, bool on);
+static void cocoa_cursor_define(DisplayChangeListener *dcl, QEMUCursor *cursor);
 
 static const DisplayChangeListenerOps dcl_ops = {
     .dpy_name          = "cocoa",
     .dpy_gfx_update = cocoa_update,
     .dpy_gfx_switch = cocoa_switch,
     .dpy_refresh = cocoa_refresh,
+    .dpy_mouse_set = cocoa_mouse_set,
+    .dpy_cursor_define = cocoa_cursor_define,
 };
 static DisplayChangeListener dcl = {
     .ops = &dcl_ops,
@@ -300,6 +305,11 @@ @interface QemuCocoaView : NSView
     BOOL isAbsoluteEnabled;
     CFMachPortRef eventsTap;
     CGColorSpaceRef colorspace;
+    CALayer *cursorLayer;
+    QEMUCursor *cursor;
+    int mouseX;
+    int mouseY;
+    bool mouseOn;
 }
 - (void) switchSurface:(pixman_image_t *)image;
 - (void) grabMouse;
@@ -365,6 +375,12 @@ - (id)initWithFrame:(NSRect)frameRect
 #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_VERSION_14_0
         [self setClipsToBounds:YES];
 #endif
+        [self setWantsLayer:YES];
+        cursorLayer = [[CALayer alloc] init];
+        [cursorLayer setAnchorPoint:CGPointMake(0, 1)];
+        [cursorLayer setAutoresizingMask:kCALayerMaxXMargin |
+                                         kCALayerMinYMargin];
+        [[self layer] addSublayer:cursorLayer];
 
     }
     return self;
@@ -383,6 +399,8 @@ - (void) dealloc
     }
 
     CGColorSpaceRelease(colorspace);
+    [cursorLayer release];
+    cursor_unref(cursor);
     [super dealloc];
 }
 
@@ -426,6 +444,72 @@ - (void) unhideCursor
     [NSCursor unhide];
 }
 
+- (void)setMouseX:(int)x y:(int)y on:(bool)on
+{
+    CGPoint position;
+
+    mouseX = x;
+    mouseY = y;
+    mouseOn = on;
+
+    position.x = mouseX;
+    position.y = screen.height - mouseY;
+
+    [CATransaction begin];
+    [CATransaction setDisableActions:YES];
+    [cursorLayer setPosition:position];
+    [cursorLayer setHidden:!mouseOn];
+    [CATransaction commit];
+}
+
+- (void)setCursor:(QEMUCursor *)given_cursor
+{
+    CGDataProviderRef provider;
+    CGImageRef image;
+    CGRect bounds = CGRectZero;
+
+    cursor_unref(cursor);
+    cursor = given_cursor;
+
+    if (!cursor) {
+        return;
+    }
+
+    cursor_ref(cursor);
+
+    bounds.size.width = cursor->width;
+    bounds.size.height = cursor->height;
+
+    provider = CGDataProviderCreateWithData(
+        NULL,
+        cursor->data,
+        cursor->width * cursor->height * 4,
+        NULL
+    );
+
+    image = CGImageCreate(
+        cursor->width, //width
+        cursor->height, //height
+        8, //bitsPerComponent
+        32, //bitsPerPixel
+        cursor->width * 4, //bytesPerRow
+        colorspace, //colorspace
+        kCGBitmapByteOrder32Little | kCGImageAlphaFirst, //bitmapInfo
+        provider, //provider
+        NULL, //decode
+        0, //interpolate
+        kCGRenderingIntentDefault //intent
+    );
+
+    CGDataProviderRelease(provider);
+    [CATransaction begin];
+    [CATransaction setDisableActions:YES];
+    [cursorLayer setBounds:bounds];
+    [cursorLayer setContents:(id)image];
+    [CATransaction commit];
+    CGImageRelease(image);
+}
+
 - (void) drawRect:(NSRect) rect
 {
     COCOA_DEBUG("QemuCocoaView: drawRect\n");
@@ -2003,6 +2087,21 @@ static void cocoa_refresh(DisplayChangeListener *dcl)
     [pool release];
 }
 
+static void cocoa_mouse_set(DisplayChangeListener *dcl, int x, int y, bool on)
+{
+    dispatch_async(dispatch_get_main_queue(), ^{
+        [cocoaView setMouseX:x y:y on:on];
+    });
+}
+
+static void cocoa_cursor_define(DisplayChangeListener *dcl, QEMUCursor *cursor)
+{
+    dispatch_async(dispatch_get_main_queue(), ^{
+        BQL_LOCK_GUARD();
+        [cocoaView setCursor:qemu_console_get_cursor(dcl->con)];
+    });
+}
+
 static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 {
     NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

-- 
2.45.2


