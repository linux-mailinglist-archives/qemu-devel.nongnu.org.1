Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C517D9CAC
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 17:11:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwOTk-0001JS-EJ; Fri, 27 Oct 2023 11:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carwynellis@gmail.com>)
 id 1qwOTh-0001JC-On
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:10:25 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <carwynellis@gmail.com>)
 id 1qwOTX-0000Jx-21
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:10:25 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4079ed65471so16425305e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 08:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698419411; x=1699024211; darn=nongnu.org;
 h=content-transfer-encoding:signed-off-by:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XlAxfdS29shWSV8p788hR3hznJQxB31E52ICyVCvi5Y=;
 b=Td77ppx1HkooaYTrpfjuS1eMqP/ObEKnXQFwkXyMIayFmCzXt9rooI8XVfseX9HjdS
 rvDDNJdtdVDCh4zheRiqNhlgwTkjYvs1Eus+ohVhy6eoV23QcEcWHfXYCT81EBrZM6vf
 tS6oIn20PBCAJ/6yMlKhn/cxhNgkobxLISRtDeNwNWdJ+pPTmEgagzo9Qxue5o9XQg75
 LWjecAIQJ35W0hFJYz0V91D7MRpWlQ86/Xt8fys+7rtIqOmqB21GREDzKakjXjOEjgmA
 m5kT2YQLf+Gea7j7yjyxwgb0CUYqfPv1iRe7DH5I2JGCFp59UbMoW9llV1ZWdCoYv96u
 Jw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698419411; x=1699024211;
 h=content-transfer-encoding:signed-off-by:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XlAxfdS29shWSV8p788hR3hznJQxB31E52ICyVCvi5Y=;
 b=aLnbcrmRe0s8cX5nuScHyZ/9l1+3h0tNdPPtXedor3g2n9ushxJNyb4EpKAiVqoQOh
 jacF0+cR2m3LJbsJNlwlH8gkmGZKdW/+KnXmcw99WFVer78yDVpsnWLDGb+82v0Gw8+Q
 9fZW6CRI1FQh9zWspOs1qSWr/rqS5g2UvdRpY1DwjuebEH8joIZ2Re7NuTN6bLgJBFnY
 2yGCwgncfOlX+OUEMatgjGM4z3ZjulMnqO03GMMbJAiM7uu4sR+zvH5joMnqGG+60FgX
 qoPAzJQUCacAo/vlRu2so3R3KGO4VXorPSVx6pPo+0alQN5QFUpw+EgnajSG7KPuDEyG
 iMGw==
X-Gm-Message-State: AOJu0YwlWHI2v4iPx9AokADIfV68pjSmWy3VhbBpVuq9qMEwzdX+3pON
 bRDdNYIStbUJbonYFuV9h2igg32vfwI=
X-Google-Smtp-Source: AGHT+IFpAXXt4Rht33dwVhNcz+YGkTEvFLbV+8LsflvA/a/GdhnQyT3qkbJVsl9FHY+B2bRq8fkYFA==
X-Received: by 2002:a05:600c:164a:b0:409:1841:3f42 with SMTP id
 o10-20020a05600c164a00b0040918413f42mr2412420wmn.13.1698419410192; 
 Fri, 27 Oct 2023 08:10:10 -0700 (PDT)
Received: from localhost.localdomain
 (host86-185-6-213.range86-185.btcentralplus.com. [86.185.6.213])
 by smtp.googlemail.com with ESMTPSA id
 k6-20020adff286000000b0032da8fb0d05sm1926096wro.110.2023.10.27.08.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 08:10:09 -0700 (PDT)
From: carwynellis@gmail.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, akihiko.odaki@daynix.com,
 kraxel@redhat.com, marcandre.lureau@redhat.com,
 Carwyn Ellis <carwynellis@gmail.com>
Subject: [PATCH v2 1/1] ui/cocoa: add zoom-to-fit display option
Date: Fri, 27 Oct 2023 16:09:42 +0100
Message-ID: <20231027150942.72357-2-carwynellis@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231027150942.72357-1-carwynellis@gmail.com>
References: <20231027150942.72357-1-carwynellis@gmail.com>
MIME-Version: 1.0
Signed-off-by: Carwyn Ellis <carwynellis@gmail.com>
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=carwynellis@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Provides a display option, zoom-to-fit, that enables scaling of the
display when full-screen mode is enabled.

Also ensures that the corresponding menu item is marked as enabled when
the option is set to on.

Signed-off-by: Carwyn Ellis <carwynellis@gmail.com>
---
 qapi/ui.json |  8 ++++++--
 ui/cocoa.m   | 35 ++++++++++++++++++++---------------
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index 006616aa77..fd12791ff9 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1409,13 +1409,17 @@
 #     codes match their position on non-Mac keyboards and you can use
 #     Meta/Super and Alt where you expect them.  (default: off)
 #
-# Since: 7.0
+# @zoom-to-fit: Scale display to fit when full-screen enabled.
+#     Defaults to "off".
+#
+# Since: 8.2
 ##
 { 'struct': 'DisplayCocoa',
   'data': {
       '*left-command-key': 'bool',
       '*full-grab': 'bool',
-      '*swap-opt-cmd': 'bool'
+      '*swap-opt-cmd': 'bool',
+      '*zoom-to-fit': 'bool'
   } }
 
 ##
diff --git a/ui/cocoa.m b/ui/cocoa.m
index d95276013c..903adb85a1 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -104,7 +104,7 @@ static void cocoa_switch(DisplayChangeListener *dcl,
 static int left_command_key_enabled = 1;
 static bool swap_opt_cmd;
 
-static bool stretch_video;
+static bool stretch_video = false;
 static NSTextField *pauseLabel;
 
 static bool allow_events;
@@ -1247,7 +1247,6 @@ - (id) init
         [normalWindow makeKeyAndOrderFront:self];
         [normalWindow center];
         [normalWindow setDelegate: self];
-        stretch_video = false;
 
         /* Used for displaying pause on the screen */
         pauseLabel = [NSTextField new];
@@ -1671,7 +1670,9 @@ static void create_initial_menus(void)
     // View menu
     menu = [[NSMenu alloc] initWithTitle:@"View"];
     [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"Enter Fullscreen" action:@selector(doToggleFullScreen:) keyEquivalent:@"f"] autorelease]]; // Fullscreen
-    [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"Zoom To Fit" action:@selector(zoomToFit:) keyEquivalent:@""] autorelease]];
+    menuItem = [[[NSMenuItem alloc] initWithTitle:@"Zoom To Fit" action:@selector(zoomToFit:) keyEquivalent:@""] autorelease];
+    [menuItem setState: stretch_video ? NSControlStateValueOn : NSControlStateValueOff];
+    [menu addItem: menuItem];
     menuItem = [[[NSMenuItem alloc] initWithTitle:@"View" action:nil keyEquivalent:@""] autorelease];
     [menuItem setSubmenu:menu];
     [[NSApp mainMenu] addItem:menuItem];
@@ -2041,18 +2042,6 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 
     [QemuApplication sharedApplication];
 
-    create_initial_menus();
-
-    /*
-     * Create the menu entries which depend on QEMU state (for consoles
-     * and removable devices). These make calls back into QEMU functions,
-     * which is OK because at this point we know that the second thread
-     * holds the iothread lock and is synchronously waiting for us to
-     * finish.
-     */
-    add_console_menu_entries();
-    addRemovableDevicesMenuItems();
-
     // Create an Application controller
     QemuCocoaAppController *controller = [[QemuCocoaAppController alloc] init];
     [NSApp setDelegate:controller];
@@ -2077,6 +2066,22 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
         left_command_key_enabled = 0;
     }
 
+    if (opts->u.cocoa.has_zoom_to_fit && opts->u.cocoa.zoom_to_fit) {
+        stretch_video = true;
+    }
+
+    create_initial_menus();
+    /*
+     * Create the menu entries which depend on QEMU state (for consoles
+     * and removable devices). These make calls back into QEMU functions,
+     * which is OK because at this point we know that the second thread
+     * holds the iothread lock and is synchronously waiting for us to
+     * finish.
+     */
+    add_console_menu_entries();
+    addRemovableDevicesMenuItems();
+
     // register vga output callbacks
     register_displaychangelistener(&dcl);
 
-- 
2.42.0


