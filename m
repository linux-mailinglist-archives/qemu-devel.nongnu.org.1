Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE2D7D9D66
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 17:50:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwP5h-0007Q9-RJ; Fri, 27 Oct 2023 11:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carwynellis@gmail.com>)
 id 1qwP5f-0007Q0-Cm
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:49:39 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <carwynellis@gmail.com>)
 id 1qwP5d-0001DD-O5
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:49:39 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32dbbf3c782so2058046f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 08:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698421776; x=1699026576; darn=nongnu.org;
 h=content-transfer-encoding:signed-off-by:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=h+pC4N6/ssFeXVj1fTFKUw736roODscw+P/GkxgaYV8=;
 b=FhOnAhGMNRMozH34mb56AQd4LkR7oI61ffBdPFs6A4w0mr6o73fhzMEhupTZbx+5vt
 qeyI6ZCADBFynKmhIpmNE9uJv3z5KfyLk+gL6Uqi+NRMuWTaWjuvVPkO6jjQYIE3VksG
 FIiZf+8tQq7PKJ9xQXZ4kcQQrijuQ19kOblhI5IHAsB9d+F+uU67FLktUJPXIOW2M8tp
 v3w9739MfLhN+17wQmWtjpStV5UHuv88Ee9Bh9TGJZOZFHFkRmzGInzvIVeRq6xwl71q
 h49sqG+E+PQJlhvvs03Jl/diPOcqoPEFo5fMlPMxvqzJG3NyjOzjv31Lv3NHYhB0537t
 fMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698421776; x=1699026576;
 h=content-transfer-encoding:signed-off-by:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h+pC4N6/ssFeXVj1fTFKUw736roODscw+P/GkxgaYV8=;
 b=kxk3Ya4qbotox48IPaMGko5K6e2yVvB1nj9W97xkRI1s3dSIpKDxK540AIvASHIV55
 XlOVJezbOc8SwnQsA6DaYGeVOL63IRwiRm4Q5T/U17WBekClFSxAlm2lJyTgK91jrRcA
 EAFC7uXm7dqxAbk1qsRTBd3MoQwA162Dk9pAsCQC/q3+/1tW7nCspAGR2z75+t8a0v11
 dYedTEVn90nlBgLMQEyn3DaeFDDHYQgMGrgq2OJN3kZwT1WxqEI2V14q4ksLQOVonQZQ
 Zk+s1P+fWRI/8VC6seN1SrsJqLKDoGNHq2W/1OSYU8XhA/l55psWmSIZVAdE0liRD+z1
 7A1g==
X-Gm-Message-State: AOJu0Yw9vCYGVyy5WmxucCSZteV3lKWX7LGmbrb6MIOZlXJRis57MgO/
 BiakUtJ/2PJDHN3QcUfZdDZ8KMQGwCI=
X-Google-Smtp-Source: AGHT+IEpe33yQfLaTZZBopIEqRVegozJmFr5KVsGo6+s5/kDDrX7viKn3dza7YB/cIzoMv0YD1KNOw==
X-Received: by 2002:a5d:6051:0:b0:32d:cb21:4e99 with SMTP id
 j17-20020a5d6051000000b0032dcb214e99mr6238721wrt.13.1698421776100; 
 Fri, 27 Oct 2023 08:49:36 -0700 (PDT)
Received: from localhost.localdomain
 (host86-185-6-213.range86-185.btcentralplus.com. [86.185.6.213])
 by smtp.googlemail.com with ESMTPSA id
 u7-20020a05600c138700b003feea62440bsm1910362wmf.43.2023.10.27.08.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 08:49:35 -0700 (PDT)
From: carwynellis@gmail.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, akihiko.odaki@daynix.com,
 kraxel@redhat.com, marcandre.lureau@redhat.com,
 Carwyn Ellis <carwynellis@gmail.com>
Subject: [PATCH v3 1/1] ui/cocoa: add zoom-to-fit display option
Date: Fri, 27 Oct 2023 16:49:20 +0100
Message-ID: <20231027154920.80626-2-carwynellis@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231027154920.80626-1-carwynellis@gmail.com>
References: <20231027154920.80626-1-carwynellis@gmail.com>
MIME-Version: 1.0
Signed-off-by: Carwyn Ellis <carwynellis@gmail.com>
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=carwynellis@gmail.com; helo=mail-wr1-x431.google.com
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
 qapi/ui.json |  7 ++++++-
 ui/cocoa.m   | 32 ++++++++++++++++++--------------
 2 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index 006616aa77..3718d40fcf 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1409,13 +1409,18 @@
 #     codes match their position on non-Mac keyboards and you can use
 #     Meta/Super and Alt where you expect them.  (default: off)
 #
+# @zoom-to-fit: Zoom guest display to fit into the host window. When
+#     turned off the host window will be resized instead. Defaults to
+#     "off". (Since 8.2)
+#
 # Since: 7.0
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
index d95276013c..cd069da696 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
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
@@ -2077,6 +2066,21 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
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


