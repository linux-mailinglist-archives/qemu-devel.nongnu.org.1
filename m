Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FC478D4DA
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:44:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHgR-0002Ao-48; Wed, 30 Aug 2023 05:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHgB-00021w-PL
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:40:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHg9-0000zd-4L
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693388400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XFnOdNYuiv69WO1ry6iYZlboB+aJKY5lwScUXpmbQ2Q=;
 b=Zd20JXdqLOgdnI215INvsm7F2r7WAbBN8p66JqwZQAqeu68HAL33Ci8ORJ2jbBIxreDm07
 ka/aXzlezRD6ghEIWMyb9rz8+AExLL/YpusjyQPYrqou4p3SygDBzXPlmrqEuJ5GtLgQPF
 hmtpev5cIqpclYSkzD9RZ1K2E2NXuMI=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15-wOuSYbXcMXibzy8mcuuICw-1; Wed, 30 Aug 2023 05:39:58 -0400
X-MC-Unique: wOuSYbXcMXibzy8mcuuICw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B3053C100B6
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:39:58 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D950C15BAE;
 Wed, 30 Aug 2023 09:39:57 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 18/67] ui/console: change new_console() to use object
 initialization
Date: Wed, 30 Aug 2023 13:37:52 +0400
Message-ID: <20230830093843.3531473-19-marcandre.lureau@redhat.com>
In-Reply-To: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

Object construction should be done in respective object instance and
class handlers.

Introduce qemu_console_register() to split out the registration logic.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 93 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 56 insertions(+), 37 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 7d0bb819ac..bdecfe7306 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -27,6 +27,7 @@
 #include "hw/qdev-core.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-ui.h"
+#include "qapi/visitor.h"
 #include "qemu/coroutine.h"
 #include "qemu/fifo8.h"
 #include "qemu/error-report.h"
@@ -1253,40 +1254,24 @@ static void text_console_update(void *opaque, console_ch_t *chardata)
     }
 }
 
-static QemuConsole *new_console(console_type_t console_type,
-                                uint32_t head)
+static void
+qemu_console_register(QemuConsole *c, console_type_t console_type)
 {
-    DisplayState *ds = get_alloc_displaystate();
-    Object *obj;
-    QemuConsole *s;
     int i;
 
-    obj = object_new(TYPE_QEMU_CONSOLE);
-    s = QEMU_CONSOLE(obj);
-    qemu_co_queue_init(&s->dump_queue);
-    s->head = head;
-    object_property_add_link(obj, "device", TYPE_DEVICE,
-                             (Object **)&s->device,
-                             object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG);
-    object_property_add_uint32_ptr(obj, "head", &s->head,
-                                   OBJ_PROP_FLAG_READ);
-
     if (!active_console || ((active_console->console_type != GRAPHIC_CONSOLE) &&
-        (console_type == GRAPHIC_CONSOLE))) {
-        active_console = s;
+                            (console_type == GRAPHIC_CONSOLE))) {
+        active_console = c;
     }
-    s->ds = ds;
-    s->console_type = console_type;
-    s->window_id = -1;
+    c->console_type = console_type;
 
     if (QTAILQ_EMPTY(&consoles)) {
-        s->index = 0;
-        QTAILQ_INSERT_TAIL(&consoles, s, next);
+        c->index = 0;
+        QTAILQ_INSERT_TAIL(&consoles, c, next);
     } else if (console_type != GRAPHIC_CONSOLE || phase_check(PHASE_MACHINE_READY)) {
         QemuConsole *last = QTAILQ_LAST(&consoles);
-        s->index = last->index + 1;
-        QTAILQ_INSERT_TAIL(&consoles, s, next);
+        c->index = last->index + 1;
+        QTAILQ_INSERT_TAIL(&consoles, c, next);
     } else {
         /*
          * HACK: Put graphical consoles before text consoles.
@@ -1294,41 +1279,75 @@ static QemuConsole *new_console(console_type_t console_type,
          * Only do that for coldplugged devices.  After initial device
          * initialization we will not renumber the consoles any more.
          */
-        QemuConsole *c = QTAILQ_FIRST(&consoles);
+        QemuConsole *it = QTAILQ_FIRST(&consoles);
 
-        while (QTAILQ_NEXT(c, next) != NULL &&
-               c->console_type == GRAPHIC_CONSOLE) {
-            c = QTAILQ_NEXT(c, next);
+        while (QTAILQ_NEXT(it, next) != NULL &&
+               it->console_type == GRAPHIC_CONSOLE) {
+            it = QTAILQ_NEXT(it, next);
         }
-        if (c->console_type == GRAPHIC_CONSOLE) {
+        if (it->console_type == GRAPHIC_CONSOLE) {
             /* have no text consoles */
-            s->index = c->index + 1;
-            QTAILQ_INSERT_AFTER(&consoles, c, s, next);
+            c->index = it->index + 1;
+            QTAILQ_INSERT_AFTER(&consoles, it, c, next);
         } else {
-            s->index = c->index;
-            QTAILQ_INSERT_BEFORE(c, s, next);
+            c->index = it->index;
+            QTAILQ_INSERT_BEFORE(it, c, next);
             /* renumber text consoles */
-            for (i = s->index + 1; c != NULL; c = QTAILQ_NEXT(c, next), i++) {
-                c->index = i;
+            for (i = c->index + 1; it != NULL; it = QTAILQ_NEXT(it, next), i++) {
+                it->index = i;
             }
         }
     }
-    return s;
 }
 
 static void
 qemu_console_finalize(Object *obj)
 {
+    /* TODO: should unregister from consoles and free itself  */
+}
+
+static void
+qemu_console_prop_get_head(Object *obj, Visitor *v, const char *name,
+                           void *opaque, Error **errp)
+{
+    QemuConsole *c = QEMU_CONSOLE(obj);
+
+    visit_type_uint32(v, name, &c->head, errp);
 }
 
 static void
 qemu_console_class_init(ObjectClass *oc, void *data)
 {
+    object_class_property_add_link(oc, "device", TYPE_DEVICE,
+                                   offsetof(QemuConsole, device),
+                                   object_property_allow_set_link,
+                                   OBJ_PROP_LINK_STRONG);
+    object_class_property_add(oc, "head", "uint32",
+                              qemu_console_prop_get_head,
+                              NULL, NULL, NULL);
 }
 
 static void
 qemu_console_init(Object *obj)
 {
+    QemuConsole *c = QEMU_CONSOLE(obj);
+    DisplayState *ds = get_alloc_displaystate();
+
+    qemu_co_queue_init(&c->dump_queue);
+    c->ds = ds;
+    c->window_id = -1;
+}
+
+static QemuConsole *new_console(console_type_t console_type,
+                                uint32_t head)
+{
+    QemuConsole *c = QEMU_CONSOLE(object_new(TYPE_QEMU_CONSOLE));
+
+    c->head = head;
+    /* TODO: move to console_init() once there is a type hierarchy */
+    qemu_console_register(c, console_type);
+
+    return c;
 }
 
 #ifdef WIN32
-- 
2.41.0


