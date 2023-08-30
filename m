Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6896778D4D1
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:44:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHim-00047c-VY; Wed, 30 Aug 2023 05:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHiG-0003Jm-6c
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:42:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHiB-0001ad-DT
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693388520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u0n3cYiLlbTRydon3bLKBopMnuRSzBrD2Oc1gfFzsuE=;
 b=OrqZGH1Tr1gSFwfmQnHrRzB+hYeu+vv0zf0DwFn0TqGJGjO6AdzfdSyirM6f5nY9ExHg9T
 /2qOTasg9js2lZxLK68pxSo1E/Xr3o78cVPHLzmm5CZXXxevnP7KLHtWsyKsl96B8ibeTt
 OfsbyLAUc4o3y/bsyuKsvr3T29ifI3c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-Z-b3d4HPPU6ncuUI1Sd8pg-1; Wed, 30 Aug 2023 05:41:58 -0400
X-MC-Unique: Z-b3d4HPPU6ncuUI1Sd8pg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CD59185A791
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:41:58 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3929D401E63;
 Wed, 30 Aug 2023 09:41:56 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 48/67] ui/vc: preliminary QemuTextConsole changes before split
Date: Wed, 30 Aug 2023 13:38:22 +0400
Message-ID: <20230830093843.3531473-49-marcandre.lureau@redhat.com>
In-Reply-To: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

Those changes will help to split console.c unit in the following commit.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 52 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index f7bc27f596..c2c1f22979 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -174,7 +174,7 @@ static QEMUTimer *cursor_timer;
 
 static void dpy_refresh(DisplayState *s);
 static DisplayState *get_alloc_displaystate(void);
-static void text_console_update_cursor(void *opaque);
+static void qemu_text_console_update_cursor(void *opaque);
 static bool displaychangelistener_has_dmabuf(DisplayChangeListener *dcl);
 static bool console_compatible_with(QemuConsole *con,
                                     DisplayChangeListener *dcl, Error **errp);
@@ -1065,6 +1065,13 @@ static void displaychangelistener_display_console(DisplayChangeListener *dcl,
     }
 }
 
+static void
+qemu_text_console_select(QemuTextConsole *c)
+{
+    dpy_text_resize(QEMU_CONSOLE(c), c->width, c->height);
+    qemu_text_console_update_cursor(NULL);
+}
+
 void console_select(unsigned int index)
 {
     DisplayChangeListener *dcl;
@@ -1084,8 +1091,7 @@ void console_select(unsigned int index)
         }
 
         if (QEMU_IS_TEXT_CONSOLE(s)) {
-            dpy_text_resize(s, QEMU_TEXT_CONSOLE(s)->width, QEMU_TEXT_CONSOLE(s)->height);
-            text_console_update_cursor(NULL);
+            qemu_text_console_select(QEMU_TEXT_CONSOLE(s));
         }
     }
 }
@@ -1135,19 +1141,12 @@ static void kbd_send_chars(QemuTextConsole *s)
 }
 
 /* called when an ascii key is pressed */
-void qemu_text_console_put_keysym(QemuTextConsole *s, int keysym)
+static void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
 {
     uint8_t buf[16], *q;
     int c;
     uint32_t num_free;
 
-    if (!s) {
-        if (!QEMU_IS_TEXT_CONSOLE(active_console)) {
-            return;
-        }
-        s = QEMU_TEXT_CONSOLE(active_console);
-    }
-
     switch(keysym) {
     case QEMU_KEY_CTRL_UP:
         console_scroll(s, -1);
@@ -1192,6 +1191,18 @@ void qemu_text_console_put_keysym(QemuTextConsole *s, int keysym)
     }
 }
 
+void qemu_text_console_put_keysym(QemuTextConsole *s, int keysym)
+{
+    if (!s) {
+        if (!QEMU_IS_TEXT_CONSOLE(active_console)) {
+            return;
+        }
+        s = QEMU_TEXT_CONSOLE(active_console);
+    }
+
+    qemu_text_console_handle_keysym(s, keysym);
+}
+
 static const int qcode_to_keysym[Q_KEY_CODE__MAX] = {
     [Q_KEY_CODE_UP]     = QEMU_KEY_UP,
     [Q_KEY_CODE_DOWN]   = QEMU_KEY_DOWN,
@@ -1395,7 +1406,7 @@ qemu_text_console_class_init(ObjectClass *oc, void *data)
 {
     if (!cursor_timer) {
         cursor_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
-                                    text_console_update_cursor, NULL);
+                                    qemu_text_console_update_cursor, NULL);
     }
 }
 
@@ -1701,7 +1712,7 @@ void register_displaychangelistener(DisplayChangeListener *dcl)
     if (QEMU_IS_GRAPHIC_CONSOLE(con)) {
         dcl_set_graphic_cursor(dcl, QEMU_GRAPHIC_CONSOLE(con));
     }
-    text_console_update_cursor(NULL);
+    qemu_text_console_update_cursor(NULL);
 }
 
 void update_displaychangelistener(DisplayChangeListener *dcl,
@@ -2388,6 +2399,13 @@ bool qemu_console_is_multihead(DeviceState *dev)
     return false;
 }
 
+
+static const char *
+qemu_text_console_get_label(QemuTextConsole *c)
+{
+    return c->chr ? c->chr->label : NULL;
+}
+
 char *qemu_console_get_label(QemuConsole *con)
 {
     if (QEMU_IS_GRAPHIC_CONSOLE(con)) {
@@ -2411,9 +2429,9 @@ char *qemu_console_get_label(QemuConsole *con)
         }
         return g_strdup("VGA");
     } else if (QEMU_IS_TEXT_CONSOLE(con)) {
-        QemuTextConsole *c = QEMU_TEXT_CONSOLE(con);
-        if (c->chr && c->chr->label) {
-            return g_strdup(c->chr->label);
+        const char *label = qemu_text_console_get_label(QEMU_TEXT_CONSOLE(con));
+        if (label) {
+            return g_strdup(label);
         }
     }
 
@@ -2513,7 +2531,7 @@ int qemu_invalidate_text_consoles(void)
     return count;
 }
 
-static void text_console_update_cursor(void *opaque)
+static void qemu_text_console_update_cursor(void *opaque)
 {
     cursor_visible_phase = !cursor_visible_phase;
 
-- 
2.41.0


