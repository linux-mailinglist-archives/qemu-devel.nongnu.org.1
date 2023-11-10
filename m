Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A142B7E7DB6
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 17:19:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1UCb-0006fW-UI; Fri, 10 Nov 2023 11:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carwynellis@gmail.com>)
 id 1r1UCY-0006de-J4
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 11:17:47 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <carwynellis@gmail.com>)
 id 1r1UCV-00052c-PC
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 11:17:45 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2c501bd6ff1so30021421fa.3
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 08:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699633061; x=1700237861; darn=nongnu.org;
 h=content-transfer-encoding:signed-off-by:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1LlGGAsuGEciFtqW7AcVcmHiNhhbZmOzg1/XRrkYRU0=;
 b=GaAxsxrfEJVG/9Im7kgm8k8joJ1fhJESzLQpFFHu1Q9N8/frmQZuE4wPPt/UOkZkms
 OPtANyQwBEmnSZgGFHpQi/BYRYS67KdIB8r7Cj4EKGzAbbLIiqd0sHJFfSS6ihEjFtjp
 gsiB/6ei5oW3SyIWlBUI6vtqBYz+TCT0GnoeftJMlIECJ26T9ClDC12zmwS5PeJ+60rL
 Xtx5lO5IRqeCqWRjLwlFh+/ekWQwEakonMrN3fCNa7ID9GEaYLrGbvdHpT0kGyCSgHKv
 jTCv3p7Xt1W+8L7fz8fTXhJQu3Rbi44InevU+dM5bFlFr6h43GmxfU/iR1/W0Jt7l6gL
 xs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699633061; x=1700237861;
 h=content-transfer-encoding:signed-off-by:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1LlGGAsuGEciFtqW7AcVcmHiNhhbZmOzg1/XRrkYRU0=;
 b=kwIcfClprbXKbNmGG9KWNZgpUYL3iV5Nc6hkg+LfQCq31ugYPUAYQ7nz1q40v5vBdq
 f850HGcXq05GrpTLePuIqcWOfJ02CXSuiSobMfbrH5M49hNtmNRipU2lH6xY7d6X8qCE
 +JDZnXxrYDqW2Z4qFm12xi0df3o+WeYa0byPeXjJLOSo2pzRaElWPZX3qISCAw9GHDKl
 qlvHka2t5g55HukxVJ2XJT3PL3a6Yu+thhEw7D3UL+ycWGfkzckfUHJJt1cypMcoVR5x
 yZw0IuTwaAe69VZVInoW4Ipp2X9V1bnAWfhh9t8ih5Iuf/lJFDxr8ym4866zJjAkegf3
 M2kA==
X-Gm-Message-State: AOJu0Yx/ffjplBRQN9DSRQEZEnulb43f2hvA353MgSjICe8gvIzRFVQ0
 mL1jq+K+PmuWSaGgnmIGDwLL6yvpdBbixw==
X-Google-Smtp-Source: AGHT+IFtHmlRxJrc7gXIj0WEk7otoJleyQXUPUx3OHd26uGtXgYJo8tV4KumWrVy85LheKXNwAR37Q==
X-Received: by 2002:a2e:b803:0:b0:2c0:1c32:b4e1 with SMTP id
 u3-20020a2eb803000000b002c01c32b4e1mr6227862ljo.27.1699633061273; 
 Fri, 10 Nov 2023 08:17:41 -0800 (PST)
Received: from localhost.localdomain
 (host86-185-6-213.range86-185.btcentralplus.com. [86.185.6.213])
 by smtp.googlemail.com with ESMTPSA id
 u24-20020a05600c00d800b0040a463cf09dsm2097879wmm.33.2023.11.10.08.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 08:17:40 -0800 (PST)
From: carwynellis@gmail.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, akihiko.odaki@daynix.com,
 kraxel@redhat.com, marcandre.lureau@redhat.com,
 Carwyn Ellis <carwynellis@gmail.com>
Subject: [PATCH 1/1] ui/cocoa: add zoom-interpolation display option
Date: Fri, 10 Nov 2023 16:17:29 +0000
Message-ID: <20231110161729.36822-2-carwynellis@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231110161729.36822-1-carwynellis@gmail.com>
References: <20231110161729.36822-1-carwynellis@gmail.com>
MIME-Version: 1.0
Signed-off-by: Carwyn Ellis <carwynellis@gmail.com>
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=carwynellis@gmail.com; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Carwyn Ellis <carwynellis@gmail.com>

Provides a new display option, zoom-interpolation, that enables
interpolation of the scaled display when zoom-to-fit is enabled.

Also provides a corresponding view menu item to allow this to be toggled
as required.

Signed-off-by: Carwyn Ellis <carwynellis@gmail.com>
---
 qapi/ui.json |  6 +++++-
 ui/cocoa.m   | 21 ++++++++++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index a0158baf23..e27e57f69c 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1414,6 +1414,9 @@
 #     turned off the host window will be resized instead. Defaults to
 #     "off". (Since 8.2)
 #
+# @zoom-interpolation: Apply interpolation to smooth output when
+#     zoom-to-fit is enabled. Defaults to "off". (Since 8.2)
+#
 # Since: 7.0
 ##
 { 'struct': 'DisplayCocoa',
@@ -1421,7 +1424,8 @@
       '*left-command-key': 'bool',
       '*full-grab': 'bool',
       '*swap-opt-cmd': 'bool',
-      '*zoom-to-fit': 'bool'
+      '*zoom-to-fit': 'bool',
+      '*zoom-interpolation': 'bool'
   } }
 
 ##
diff --git a/ui/cocoa.m b/ui/cocoa.m
index cd069da696..35df8d6ce2 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -105,6 +105,7 @@ static void cocoa_switch(DisplayChangeListener *dcl,
 static bool swap_opt_cmd;
 
 static bool stretch_video;
+static CGInterpolationQuality zoom_interpolation = kCGInterpolationNone;
 static NSTextField *pauseLabel;
 
 static bool allow_events;
@@ -455,7 +456,7 @@ - (void) drawRect:(NSRect) rect
     // get CoreGraphic context
     CGContextRef viewContextRef = [[NSGraphicsContext currentContext] CGContext];
 
-    CGContextSetInterpolationQuality (viewContextRef, kCGInterpolationNone);
+    CGContextSetInterpolationQuality (viewContextRef, zoom_interpolation);
     CGContextSetShouldAntialias (viewContextRef, NO);
 
     // draw screen bitmap directly to Core Graphics context
@@ -1411,6 +1412,17 @@ - (void)zoomToFit:(id) sender
     }
 }
 
+- (void)toggleZoomInterpolation:(id) sender
+{
+    if (zoom_interpolation == kCGInterpolationNone) {
+        zoom_interpolation = kCGInterpolationLow;
+        [sender setState: NSControlStateValueOn];
+    } else {
+        zoom_interpolation = kCGInterpolationNone;
+        [sender setState: NSControlStateValueOff];
+    }
+}
+
 /* Displays the console on the screen */
 - (void)displayConsole:(id)sender
 {
@@ -1673,6 +1685,9 @@ static void create_initial_menus(void)
     menuItem = [[[NSMenuItem alloc] initWithTitle:@"Zoom To Fit" action:@selector(zoomToFit:) keyEquivalent:@""] autorelease];
     [menuItem setState: stretch_video ? NSControlStateValueOn : NSControlStateValueOff];
     [menu addItem: menuItem];
+    menuItem = [[[NSMenuItem alloc] initWithTitle:@"Zoom Interpolation" action:@selector(toggleZoomInterpolation:) keyEquivalent:@""] autorelease];
+    [menuItem setState: zoom_interpolation == kCGInterpolationLow ? NSControlStateValueOn : NSControlStateValueOff];
+    [menu addItem: menuItem];
     menuItem = [[[NSMenuItem alloc] initWithTitle:@"View" action:nil keyEquivalent:@""] autorelease];
     [menuItem setSubmenu:menu];
     [[NSApp mainMenu] addItem:menuItem];
@@ -2070,6 +2085,10 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
         stretch_video = true;
     }
 
+    if (opts->u.cocoa.has_zoom_interpolation && opts->u.cocoa.zoom_interpolation) {
+        zoom_interpolation = kCGInterpolationLow;
+    }
+
     create_initial_menus();
     /*
      * Create the menu entries which depend on QEMU state (for consoles
-- 
2.42.1


