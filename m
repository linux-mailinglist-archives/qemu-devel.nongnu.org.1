Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 617797D6E63
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 16:05:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qveVV-0000Di-Lc; Wed, 25 Oct 2023 10:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carwynellis@gmail.com>)
 id 1qveVO-0000CG-Pl; Wed, 25 Oct 2023 10:05:06 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <carwynellis@gmail.com>)
 id 1qveVH-0006Rr-1h; Wed, 25 Oct 2023 10:05:05 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32d8c2c6dfdso3644932f8f.1; 
 Wed, 25 Oct 2023 07:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698242696; x=1698847496; darn=nongnu.org;
 h=content-transfer-encoding:signed-off-by:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/SXdcp1LT8ZlY84+M35TdkDbvAz1Zap45bhOkLjSmgc=;
 b=c0iNEHxFAuhYg93zeXipcEQglxyAwT49+FzICBqfqfTtWBoc5YCUv6bjz3W9yaeeeg
 JISp0wTT6+VN4/m5qLmPZVPPOH3JSuVt2pu7gVFMu8CkAK8u3p13DvtuGyx00yR5OgTp
 FDnT0p/tn3GQws5lrdzVc1Td12UTfi7/7cpkJ8QeBoSlKmen2WQ7p/PsQDgniEFfnjj5
 9O+EwmdjCw5vx/hsfpU+H1HH1JHbDol35/OoS2x1dV91Qz4v+K0SuHAYIhuKoicVBFZi
 +cWozBkpKOw9Q7bCmSktYwHLg5wQ5eoh/DSqUCrpWQV1etrNf2JMXocNA8uVfI5Av0L9
 SiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698242696; x=1698847496;
 h=content-transfer-encoding:signed-off-by:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/SXdcp1LT8ZlY84+M35TdkDbvAz1Zap45bhOkLjSmgc=;
 b=N0gHOb8JWJizDQwleIUJiE9xNtLkYNOMpftvA2loqy3IUs1jiRh4l58ZcGH8zshD9u
 wcGw6P2yTFBGXDztTQ09HjJUXsGOTgS47Vc82A2a25GntJMtjRXxFSrZTMYm1EbXvT4A
 ZsxNBsPtb8U0UFPpchy3fmdHB0AxOt3gtGfaNMkLsHM7Il4Wp0V11c7v5KdOXOstgkkt
 1VcDFXbJAbcC1K5yFGRYNj6E36p1LEUcSQJ1PY197nryanTAU8wc5nVJ3FqgrE5gUL7x
 g9Hk4UmDAGvu+iKVLFiyMmMKdC0xXKOXASSb4M0cSicgYq/sBdtnM6H+aqkThbmFHY+f
 qvGQ==
X-Gm-Message-State: AOJu0Yw6aEpARwlTrqK1PvaLQ1F4EsPF/V7y+YLim/IxLRvoAs7k/NWi
 FS9e51MST27j1sib4UuBhE7cOwV0/vo=
X-Google-Smtp-Source: AGHT+IGvTEdsBwFHKcT2R8yRPYljR11LGrzIDY7l1xxL3cn8vGSqflO6EbPtBSARD3bypOX6SPZQBA==
X-Received: by 2002:adf:db44:0:b0:32d:a7c8:eaf7 with SMTP id
 f4-20020adfdb44000000b0032da7c8eaf7mr11450764wrj.20.1698242696120; 
 Wed, 25 Oct 2023 07:04:56 -0700 (PDT)
Received: from localhost.localdomain
 (host86-185-6-213.range86-185.btcentralplus.com. [86.185.6.213])
 by smtp.googlemail.com with ESMTPSA id
 d17-20020a5d6451000000b0032da022855fsm12103044wrw.111.2023.10.25.07.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 07:04:55 -0700 (PDT)
From: carwynellis@gmail.com
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, philmd@linaro.org,
 akihiko.odaki@daynix.com, Carwyn Ellis <carwynellis@gmail.com>
Subject: [PATCH 1/1] ui/cocoa: add full-screen-scaling display option
Date: Wed, 25 Oct 2023 15:04:43 +0100
Message-ID: <20231025140443.68520-2-carwynellis@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025140443.68520-1-carwynellis@gmail.com>
References: <20231025140443.68520-1-carwynellis@gmail.com>
MIME-Version: 1.0
Signed-off-by: Carwyn Ellis <carwynellis@gmail.com>
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=carwynellis@gmail.com; helo=mail-wr1-x430.google.com
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

Provides a display option, full-screen-scaling, that enables scaling of
the display when full-screen mode is enabled.

Also ensures that the corresponding menu item is marked as enabled when
the option is set to on.
---
 qapi/ui.json |  6 +++++-
 ui/cocoa.m   | 33 ++++++++++++++++++++-------------
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index 006616aa77..9035b230ce 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1409,13 +1409,17 @@
 #     codes match their position on non-Mac keyboards and you can use
 #     Meta/Super and Alt where you expect them.  (default: off)
 #
+# @full-screen-scaling: Scale display to fit when full-screen enabled.
+#     Defaults to "off".
+#
 # Since: 7.0
 ##
 { 'struct': 'DisplayCocoa',
   'data': {
       '*left-command-key': 'bool',
       '*full-grab': 'bool',
-      '*swap-opt-cmd': 'bool'
+      '*swap-opt-cmd': 'bool',
+      '*full-screen-scaling': 'bool'
   } }
 
 ##
diff --git a/ui/cocoa.m b/ui/cocoa.m
index d95276013c..7ddc4de174 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1671,7 +1671,9 @@ static void create_initial_menus(void)
     // View menu
     menu = [[NSMenu alloc] initWithTitle:@"View"];
     [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"Enter Fullscreen" action:@selector(doToggleFullScreen:) keyEquivalent:@"f"] autorelease]]; // Fullscreen
-    [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"Zoom To Fit" action:@selector(zoomToFit:) keyEquivalent:@""] autorelease]];
+    menuItem = [[[NSMenuItem alloc] initWithTitle:@"Zoom To Fit" action:@selector(zoomToFit:) keyEquivalent:@""] autorelease];
+    [menuItem setState: (stretch_video) ? NSControlStateValueOn : NSControlStateValueOff];
+    [menu addItem: menuItem];
     menuItem = [[[NSMenuItem alloc] initWithTitle:@"View" action:nil keyEquivalent:@""] autorelease];
     [menuItem setSubmenu:menu];
     [[NSApp mainMenu] addItem:menuItem];
@@ -2041,18 +2043,6 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 
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
@@ -2062,6 +2052,7 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
         [NSApp activateIgnoringOtherApps: YES];
         [controller toggleFullScreen: nil];
     }
+
     if (opts->u.cocoa.has_full_grab && opts->u.cocoa.full_grab) {
         [controller setFullGrab: nil];
     }
@@ -2077,6 +2068,22 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
         left_command_key_enabled = 0;
     }
 
+    if (opts->u.cocoa.has_full_screen_scaling && opts->u.cocoa.full_screen_scaling) {
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
+
     // register vga output callbacks
     register_displaychangelistener(&dcl);
 
-- 
2.42.0


