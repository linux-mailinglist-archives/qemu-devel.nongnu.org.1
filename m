Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 228C37E37EA
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 10:32:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0IQL-0002bk-GK; Tue, 07 Nov 2023 04:31:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r0IQI-0002bO-TE
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:31:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r0IQH-0003Z3-AM
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:31:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699349460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eifq5ZKfjmtcrAyT8mx5cW7pd2Vpi1t07TQ83+gEGEM=;
 b=RqVik4e3TrAedWunUtDOXPCmCrry4BvihcWI6lZ9pECPbNciXr+fw9N2/WWAD9f4NRrDv0
 FjOYfaXuJ1dYr38elB/A2gutihBHQ6DmDAP4eiCn28aOFmxiqwFbEOraqkCQCy8lYvCiEj
 RvfRTQcT4+Amh2/5HOzknagCqaz8O5A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-qcOF_zU8MnOYWXp57LBPeg-1; Tue, 07 Nov 2023 04:30:57 -0500
X-MC-Unique: qcOF_zU8MnOYWXp57LBPeg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24024185A7A2;
 Tue,  7 Nov 2023 09:30:57 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C75319E93;
 Tue,  7 Nov 2023 09:30:55 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Carwyn Ellis <carwynellis@gmail.com>
Subject: [PULL 4/5] ui/cocoa: add zoom-to-fit display option
Date: Tue,  7 Nov 2023 13:30:34 +0400
Message-ID: <20231107093035.2746581-5-marcandre.lureau@redhat.com>
In-Reply-To: <20231107093035.2746581-1-marcandre.lureau@redhat.com>
References: <20231107093035.2746581-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Provides a display option, zoom-to-fit, that enables scaling of the
display when full-screen mode is enabled.

Also ensures that the corresponding menu item is marked as enabled when
the option is set to on.

Signed-off-by: Carwyn Ellis <carwynellis@gmail.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20231027154920.80626-2-carwynellis@gmail.com>
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
2.41.0


