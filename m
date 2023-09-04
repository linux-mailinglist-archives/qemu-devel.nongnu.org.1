Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E56E4791693
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 13:57:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd88v-00026m-Ph; Mon, 04 Sep 2023 07:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd88t-00026a-Py
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:53:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd88r-0008Is-Gi
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TXGp0QMTholmKSO/2mYb8qpO/fURuGBPc+i0AzL2vXE=;
 b=iin1+SSRMzgeuMqnRUaXgwrb+6g/S9IaQlkWt/wf1rp3K6rc6kHm8K46nX1RlHs497/3UR
 94zRrCYR28tyNngGQ26kT15XdDbb9unUzlJr9IDg8kIu/vPqNRMZ6LBmAGljrNCIsVseMW
 2MeH3W3Oh/GYO9nquJceTxgV9HvrU78=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-xNpIGQXGO2KU5j8YTwlSuQ-1; Mon, 04 Sep 2023 07:53:15 -0400
X-MC-Unique: xNpIGQXGO2KU5j8YTwlSuQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E8EA3810D23
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:53:15 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A625493114;
 Mon,  4 Sep 2023 11:53:13 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 05/52] ui/vc: drop have_text
Date: Mon,  4 Sep 2023 15:52:02 +0400
Message-ID: <20230904115251.4161397-6-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124;
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

If there are no "text" listener, the callback will simply be ignored.
The rest of text handling can be done cheaply.

This allows to remove some dependency on DisplayState from VC
implementation.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230830093843.3531473-6-marcandre.lureau@redhat.com>
---
 ui/console.c | 42 +++++++++++++-----------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index a448e4d283..bec2d1a40a 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -133,7 +133,6 @@ struct DisplayState {
     uint64_t update_interval;
     bool refreshing;
     bool have_gfx;
-    bool have_text;
 
     QLIST_HEAD(, DisplayChangeListener) listeners;
 };
@@ -185,7 +184,6 @@ static void gui_setup_refresh(DisplayState *ds)
     DisplayChangeListener *dcl;
     bool need_timer = false;
     bool have_gfx = false;
-    bool have_text = false;
 
     QLIST_FOREACH(dcl, &ds->listeners, next) {
         if (dcl->ops->dpy_refresh != NULL) {
@@ -194,9 +192,6 @@ static void gui_setup_refresh(DisplayState *ds)
         if (dcl->ops->dpy_gfx_update != NULL) {
             have_gfx = true;
         }
-        if (dcl->ops->dpy_text_update != NULL) {
-            have_text = true;
-        }
     }
 
     if (need_timer && ds->gui_timer == NULL) {
@@ -209,7 +204,6 @@ static void gui_setup_refresh(DisplayState *ds)
     }
 
     ds->have_gfx = have_gfx;
-    ds->have_text = have_text;
 }
 
 void graphic_hw_update_done(QemuConsole *con)
@@ -456,9 +450,7 @@ static void update_xy(QemuConsole *s, int x, int y)
     TextCell *c;
     int y1, y2;
 
-    if (s->ds->have_text) {
-        text_update_xy(s, x, y);
-    }
+    text_update_xy(s, x, y);
 
     y1 = (s->y_base + y) % s->total_height;
     y2 = y1 - s->y_displayed;
@@ -482,9 +474,7 @@ static void console_show_cursor(QemuConsole *s, int show)
     int y, y1;
     int x = s->x;
 
-    if (s->ds->have_text) {
-        s->cursor_invalidate = 1;
-    }
+    s->cursor_invalidate = 1;
 
     if (x >= s->width) {
         x = s->width - 1;
@@ -513,13 +503,11 @@ static void console_refresh(QemuConsole *s)
     TextCell *c;
     int x, y, y1;
 
-    if (s->ds->have_text) {
-        s->text_x[0] = 0;
-        s->text_y[0] = 0;
-        s->text_x[1] = s->width - 1;
-        s->text_y[1] = s->height - 1;
-        s->cursor_invalidate = 1;
-    }
+    s->text_x[0] = 0;
+    s->text_y[0] = 0;
+    s->text_x[1] = s->width - 1;
+    s->text_y[1] = s->height - 1;
+    s->cursor_invalidate = 1;
 
     vga_fill_rect(s, 0, 0, surface_width(surface), surface_height(surface),
                   color_table_rgb[0][QEMU_COLOR_BLACK]);
@@ -594,12 +582,10 @@ static void console_put_lf(QemuConsole *s)
             c++;
         }
         if (s->y_displayed == s->y_base) {
-            if (s->ds->have_text) {
-                s->text_x[0] = 0;
-                s->text_y[0] = 0;
-                s->text_x[1] = s->width - 1;
-                s->text_y[1] = s->height - 1;
-            }
+            s->text_x[0] = 0;
+            s->text_y[0] = 0;
+            s->text_x[1] = s->width - 1;
+            s->text_y[1] = s->height - 1;
 
             vga_bitblt(s, 0, FONT_HEIGHT, 0, 0,
                        s->width * FONT_WIDTH,
@@ -1069,9 +1055,7 @@ void console_select(unsigned int index)
                 displaychangelistener_display_console(dcl, s, NULL);
             }
         }
-        if (ds->have_text) {
-            dpy_text_resize(s, s->width, s->height);
-        }
+        dpy_text_resize(s, s->width, s->height);
         text_console_update_cursor(NULL);
     }
 }
@@ -1239,7 +1223,7 @@ static void text_console_invalidate(void *opaque)
 {
     QemuConsole *s = (QemuConsole *) opaque;
 
-    if (s->ds->have_text && s->console_type == TEXT_CONSOLE) {
+    if (s->console_type == TEXT_CONSOLE) {
         text_console_resize(s);
     }
     console_refresh(s);
-- 
2.41.0


