Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB8578D4A8
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:40:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHgT-0002l9-St; Wed, 30 Aug 2023 05:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHgJ-00028p-I8
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:40:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHgH-0001EB-5h
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693388408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aBsAFU5yizKx7iU38IygwtEbtVoJN5CJaxMzU8Gi3T0=;
 b=aM1dtPzWEhqpAruqJNCjoGA6EfGeABVTqxe3UD9A0E1boLKn0of5UeBsH9P5R+ZDYdMqDp
 q1nYtaHo79X8smiGlp8IkhzbgKELcL3KjteapMxLMf0mIyiNVt8mBZAUlHm7fHAGa1Q2+Z
 QXbyZCW/3ch/Jl4iesFhn5T6Cnpbpqo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-pQsmxPTIOumLzG1q0v2jDg-1; Wed, 30 Aug 2023 05:40:06 -0400
X-MC-Unique: pQsmxPTIOumLzG1q0v2jDg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F31380CD88
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:40:06 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B00240C2063;
 Wed, 30 Aug 2023 09:40:04 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 20/67] ui/console: instantiate a specific console type
Date: Wed, 30 Aug 2023 13:37:54 +0400
Message-ID: <20230830093843.3531473-21-marcandre.lureau@redhat.com>
In-Reply-To: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

This will allow to move code/data to the specific console types.

Replace console_type_t with object type check.

QemuConsole can be abstract.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 47 +++++++++++++++++++----------------------------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 4ca5064cc9..dd8e8db525 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -71,17 +71,10 @@ enum TTYState {
     TTY_STATE_CSI,
 };
 
-typedef enum {
-    GRAPHIC_CONSOLE,
-    TEXT_CONSOLE,
-    TEXT_CONSOLE_FIXED_SIZE
-} console_type_t;
-
 struct QemuConsole {
     Object parent;
 
     int index;
-    console_type_t console_type;
     DisplayState *ds;
     DisplaySurface *surface;
     DisplayScanout scanout;
@@ -126,7 +119,7 @@ struct QemuConsole {
     QTAILQ_ENTRY(QemuConsole) next;
 };
 
-OBJECT_DEFINE_TYPE(QemuConsole, qemu_console, QEMU_CONSOLE, OBJECT)
+OBJECT_DEFINE_ABSTRACT_TYPE(QemuConsole, qemu_console, QEMU_CONSOLE, OBJECT)
 
 typedef struct QemuGraphicConsole {
     QemuConsole parent;
@@ -1156,7 +1149,7 @@ void kbd_put_keysym_console(QemuConsole *s, int keysym)
     int c;
     uint32_t num_free;
 
-    if (!s || (s->console_type == GRAPHIC_CONSOLE))
+    if (!s || QEMU_IS_GRAPHIC_CONSOLE(s))
         return;
 
     switch(keysym) {
@@ -1258,7 +1251,7 @@ static void text_console_invalidate(void *opaque)
 {
     QemuConsole *s = (QemuConsole *) opaque;
 
-    if (s->console_type == TEXT_CONSOLE) {
+    if (QEMU_IS_TEXT_CONSOLE(s) && !QEMU_IS_FIXED_TEXT_CONSOLE(s)) {
         text_console_resize(s);
     }
     console_refresh(s);
@@ -1294,20 +1287,19 @@ static void text_console_update(void *opaque, console_ch_t *chardata)
 }
 
 static void
-qemu_console_register(QemuConsole *c, console_type_t console_type)
+qemu_console_register(QemuConsole *c)
 {
     int i;
 
-    if (!active_console || ((active_console->console_type != GRAPHIC_CONSOLE) &&
-                            (console_type == GRAPHIC_CONSOLE))) {
+    if (!active_console || (!QEMU_IS_GRAPHIC_CONSOLE(active_console) &&
+                            QEMU_IS_GRAPHIC_CONSOLE(c))) {
         active_console = c;
     }
-    c->console_type = console_type;
 
     if (QTAILQ_EMPTY(&consoles)) {
         c->index = 0;
         QTAILQ_INSERT_TAIL(&consoles, c, next);
-    } else if (console_type != GRAPHIC_CONSOLE || phase_check(PHASE_MACHINE_READY)) {
+    } else if (!QEMU_IS_GRAPHIC_CONSOLE(c) || phase_check(PHASE_MACHINE_READY)) {
         QemuConsole *last = QTAILQ_LAST(&consoles);
         c->index = last->index + 1;
         QTAILQ_INSERT_TAIL(&consoles, c, next);
@@ -1320,11 +1312,10 @@ qemu_console_register(QemuConsole *c, console_type_t console_type)
          */
         QemuConsole *it = QTAILQ_FIRST(&consoles);
 
-        while (QTAILQ_NEXT(it, next) != NULL &&
-               it->console_type == GRAPHIC_CONSOLE) {
+        while (QTAILQ_NEXT(it, next) != NULL && QEMU_IS_GRAPHIC_CONSOLE(it)) {
             it = QTAILQ_NEXT(it, next);
         }
-        if (it->console_type == GRAPHIC_CONSOLE) {
+        if (QEMU_IS_GRAPHIC_CONSOLE(it)) {
             /* have no text consoles */
             c->index = it->index + 1;
             QTAILQ_INSERT_AFTER(&consoles, it, c, next);
@@ -1422,14 +1413,14 @@ qemu_fixed_text_console_init(Object *obj)
 {
 }
 
-static QemuConsole *new_console(console_type_t console_type,
+static QemuConsole *new_console(const char *typename,
                                 uint32_t head)
 {
-    QemuConsole *c = QEMU_CONSOLE(object_new(TYPE_QEMU_CONSOLE));
+    QemuConsole *c = QEMU_CONSOLE(object_new(typename));
 
     c->head = head;
     /* TODO: move to console_init() once there is a type hierarchy */
-    qemu_console_register(c, console_type);
+    qemu_console_register(c);
 
     return c;
 }
@@ -2211,7 +2202,7 @@ QemuConsole *graphic_console_init(DeviceState *dev, uint32_t head,
         height = qemu_console_get_height(s, 0);
     } else {
         trace_console_gfx_new();
-        s = new_console(GRAPHIC_CONSOLE, head);
+        s = new_console(TYPE_QEMU_GRAPHIC_CONSOLE, head);
         s->ui_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
                                    dpy_set_ui_info_timer, s);
     }
@@ -2345,7 +2336,7 @@ bool qemu_console_is_graphic(QemuConsole *con)
     if (con == NULL) {
         con = active_console;
     }
-    return con && (con->console_type == GRAPHIC_CONSOLE);
+    return con && QEMU_IS_GRAPHIC_CONSOLE(con);
 }
 
 bool qemu_console_is_fixedsize(QemuConsole *con)
@@ -2353,7 +2344,7 @@ bool qemu_console_is_fixedsize(QemuConsole *con)
     if (con == NULL) {
         con = active_console;
     }
-    return con && (con->console_type != TEXT_CONSOLE);
+    return con && (QEMU_IS_GRAPHIC_CONSOLE(con) || QEMU_IS_FIXED_TEXT_CONSOLE(con));
 }
 
 bool qemu_console_is_gl_blocked(QemuConsole *con)
@@ -2389,7 +2380,7 @@ bool qemu_console_is_multihead(DeviceState *dev)
 
 char *qemu_console_get_label(QemuConsole *con)
 {
-    if (con->console_type == GRAPHIC_CONSOLE) {
+    if (QEMU_IS_GRAPHIC_CONSOLE(con)) {
         if (con->device) {
             DeviceState *dev;
             bool multihead;
@@ -2588,9 +2579,9 @@ static void vc_chr_open(Chardev *chr,
 
     trace_console_txt_new(width, height);
     if (width == 0 || height == 0) {
-        s = new_console(TEXT_CONSOLE, 0);
+        s = new_console(TYPE_QEMU_TEXT_CONSOLE, 0);
     } else {
-        s = new_console(TEXT_CONSOLE_FIXED_SIZE, 0);
+        s = new_console(TYPE_QEMU_FIXED_TEXT_CONSOLE, 0);
         s->scanout.kind = SCANOUT_SURFACE;
         s->surface = qemu_create_displaysurface(width, height);
     }
@@ -2610,7 +2601,7 @@ void qemu_console_resize(QemuConsole *s, int width, int height)
 {
     DisplaySurface *surface = qemu_console_surface(s);
 
-    assert(s->console_type == GRAPHIC_CONSOLE);
+    assert(QEMU_IS_GRAPHIC_CONSOLE(s));
 
     if ((s->scanout.kind != SCANOUT_SURFACE ||
          (surface && surface->flags & QEMU_ALLOCATED_FLAG)) &&
-- 
2.41.0


