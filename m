Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C125678D4C0
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:43:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHfd-0007jz-3n; Wed, 30 Aug 2023 05:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHfb-0007iq-Nw
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:39:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHfZ-0000tY-3e
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693388364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IP2KlXkL9S9hKgfR0NcUmYvurDGjQqMWtSz/HTRbsmQ=;
 b=LAxeqdbI1PFIFOR976TkWJCJlhJXtPFoDnSeINowr0IgXHbS1suxsiigUUri2iEnZiPNbd
 lwTvQeXOMK3/SWkuaSZf7Dw8aXNaj7Mr6AM1B4POIZqsoa7kPp2Mo/NeteJ5mJ0PaOPMg9
 HzdjKtdi8HOu7X3f6+aZsi6WKoxoFX0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-d1C8c9p3PS6v2FtcrOZsxA-1; Wed, 30 Aug 2023 05:39:22 -0400
X-MC-Unique: d1C8c9p3PS6v2FtcrOZsxA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 541AE101A528
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:39:22 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7AD67140E96E;
 Wed, 30 Aug 2023 09:39:21 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 09/67] ui/console: get the DisplayState from new_console()
Date: Wed, 30 Aug 2023 13:37:43 +0400
Message-ID: <20230830093843.3531473-10-marcandre.lureau@redhat.com>
In-Reply-To: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

There is no obvious reason to defer text console initialization. We can
simply take the global display state in new_console().

This simplify somewhat the code to allow moving the VC to a separate unit.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index fc1836782d..ba79c735b7 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -143,7 +143,7 @@ static QTAILQ_HEAD(, QemuConsole) consoles =
 static bool cursor_visible_phase;
 static QEMUTimer *cursor_timer;
 
-static void text_console_do_init(Chardev *chr, DisplayState *ds);
+static void text_console_do_init(Chardev *chr);
 static void dpy_refresh(DisplayState *s);
 static DisplayState *get_alloc_displaystate(void);
 static void text_console_update_cursor_timer(void);
@@ -1249,9 +1249,10 @@ static void text_console_update(void *opaque, console_ch_t *chardata)
     }
 }
 
-static QemuConsole *new_console(DisplayState *ds, console_type_t console_type,
+static QemuConsole *new_console(console_type_t console_type,
                                 uint32_t head)
 {
+    DisplayState *ds = get_alloc_displaystate();
     Object *obj;
     QemuConsole *s;
     int i;
@@ -2049,13 +2050,7 @@ DisplayState *init_displaystate(void)
     gchar *name;
     QemuConsole *con;
 
-    get_alloc_displaystate();
     QTAILQ_FOREACH(con, &consoles, next) {
-        if (con->console_type != GRAPHIC_CONSOLE &&
-            con->ds == NULL) {
-            text_console_do_init(con->chr, display_state);
-        }
-
         /* Hook up into the qom tree here (not in new_console()), once
          * all QemuConsoles are created and the order / numbering
          * doesn't change any more */
@@ -2085,10 +2080,8 @@ QemuConsole *graphic_console_init(DeviceState *dev, uint32_t head,
     int width = 640;
     int height = 480;
     QemuConsole *s;
-    DisplayState *ds;
     DisplaySurface *surface;
 
-    ds = get_alloc_displaystate();
     s = qemu_console_lookup_unused();
     if (s) {
         trace_console_gfx_reuse(s->index);
@@ -2096,7 +2089,7 @@ QemuConsole *graphic_console_init(DeviceState *dev, uint32_t head,
         height = qemu_console_get_height(s, 0);
     } else {
         trace_console_gfx_new();
-        s = new_console(ds, GRAPHIC_CONSOLE, head);
+        s = new_console(GRAPHIC_CONSOLE, head);
         s->ui_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
                                    dpy_set_ui_info_timer, s);
     }
@@ -2405,7 +2398,7 @@ static const GraphicHwOps text_console_ops = {
     .text_update = text_console_update,
 };
 
-static void text_console_do_init(Chardev *chr, DisplayState *ds)
+static void text_console_do_init(Chardev *chr)
 {
     VCChardev *drv = VC_CHARDEV(chr);
     QemuConsole *s = drv->console;
@@ -2413,7 +2406,6 @@ static void text_console_do_init(Chardev *chr, DisplayState *ds)
     int g_height = 24 * FONT_HEIGHT;
 
     fifo8_create(&s->out_fifo, 16);
-    s->ds = ds;
 
     s->y_displayed = 0;
     s->y_base = 0;
@@ -2482,9 +2474,9 @@ static void vc_chr_open(Chardev *chr,
 
     trace_console_txt_new(width, height);
     if (width == 0 || height == 0) {
-        s = new_console(NULL, TEXT_CONSOLE, 0);
+        s = new_console(TEXT_CONSOLE, 0);
     } else {
-        s = new_console(NULL, TEXT_CONSOLE_FIXED_SIZE, 0);
+        s = new_console(TEXT_CONSOLE_FIXED_SIZE, 0);
         s->scanout.kind = SCANOUT_SURFACE;
         s->surface = qemu_create_displaysurface(width, height);
     }
@@ -2497,9 +2489,7 @@ static void vc_chr_open(Chardev *chr,
     s->chr = chr;
     drv->console = s;
 
-    if (display_state) {
-        text_console_do_init(chr, display_state);
-    }
+    text_console_do_init(chr);
 
     /* console/chardev init sometimes completes elsewhere in a 2nd
      * stage, so defer OPENED events until they are fully initialized
-- 
2.41.0


