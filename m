Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AD77916E9
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:13:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8Bv-0001EQ-Ph; Mon, 04 Sep 2023 07:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8Bm-0001A5-RF
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:56:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8Bi-0000vD-Pz
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AhtXdRNeiJoLLsMz2vDYsiZmmU2kQifZxRBQRz5M77o=;
 b=DcJHVEkvgZoKP5IxRMPW2487B6ep2ZahOvIz8FvNB6J3syYMC+NzqGishAAx/SYct2Nl95
 J3WklCnz+TIf/RGoUaV6VlRCOL4AaI+ZGVyp9Gh9XEyOeeUWPqCthIc9acHy8M8ZF4Zna3
 taM1ZxWyKjZUB6zg5qlmnSTT985zo7Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-4aPPfu9kM4ykZ7w2ZR299g-1; Mon, 04 Sep 2023 07:56:12 -0400
X-MC-Unique: 4aPPfu9kM4ykZ7w2ZR299g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8996A2999B26
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:56:12 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D7B1640C206F;
 Mon,  4 Sep 2023 11:56:11 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Bilal Elmoussaoui <belmouss@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 49/52] ui/dbus: implement damage regions for GL
Date: Mon,  4 Sep 2023 15:52:46 +0400
Message-ID: <20230904115251.4161397-50-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

From: Bilal Elmoussaoui <belmouss@redhat.com>

Currently, when using `-display dbus,gl=on` all updates to the client
become "full scanout" updates, meaning there is no way for the client to
limit damage regions to the display server.

Instead of using an "update count", this patch tracks the damage region
and propagates it to the client.

This was less of an issue when clients were using GtkGLArea for
rendering,
as you'd be doing full-surface redraw. To be efficient, the client needs
both a DMA-BUF and the damage region to be updated.

Co-authored-by: Christian Hergert <chergert@redhat.com>
Signed-off-by: Bilal Elmoussaoui <belmouss@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230814125802.102160-1-belmouss@redhat.com>
---
 ui/dbus-listener.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 30917271ab..36548a7f52 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -26,6 +26,9 @@
 #include "qapi/error.h"
 #include "sysemu/sysemu.h"
 #include "dbus.h"
+#ifdef CONFIG_OPENGL
+#include <pixman.h>
+#endif
 #ifdef G_OS_UNIX
 #include <gio/gunixfdlist.h>
 #endif
@@ -59,12 +62,15 @@ struct _DBusDisplayListener {
 
     QemuDBusDisplay1Listener *proxy;
 
+#ifdef CONFIG_OPENGL
+    /* Keep track of the damage region */
+    pixman_region32_t gl_damage;
+#endif
+
     DisplayChangeListener dcl;
     DisplaySurface *ds;
     enum share_kind ds_share;
 
-    int gl_updates;
-
     bool ds_mapped;
     bool can_share_map;
 
@@ -539,11 +545,16 @@ static void dbus_gl_refresh(DisplayChangeListener *dcl)
         return;
     }
 
-    if (ddl->gl_updates) {
-        dbus_call_update_gl(dcl, 0, 0,
-                            surface_width(ddl->ds), surface_height(ddl->ds));
-        ddl->gl_updates = 0;
+    int n_rects = pixman_region32_n_rects(&ddl->gl_damage);
+
+    for (int i = 0; i < n_rects; i++) {
+        pixman_box32_t *box;
+        box = pixman_region32_rectangles(&ddl->gl_damage, NULL) + i;
+        /* TODO: Add a UpdateList call to send multiple updates at once */
+        dbus_call_update_gl(dcl, box->x1, box->y1,
+                            box->x2 - box->x1, box->y2 - box->y1);
     }
+    pixman_region32_clear(&ddl->gl_damage);
 }
 #endif /* OPENGL */
 
@@ -558,7 +569,10 @@ static void dbus_gl_gfx_update(DisplayChangeListener *dcl,
 {
     DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
 
-    ddl->gl_updates++;
+    pixman_region32_t rect_region;
+    pixman_region32_init_rect(&rect_region, x, y, w, h);
+    pixman_region32_union(&ddl->gl_damage, &ddl->gl_damage, &rect_region);
+    pixman_region32_fini(&rect_region);
 }
 #endif
 
@@ -738,6 +752,7 @@ dbus_display_listener_dispose(GObject *object)
     g_clear_object(&ddl->d3d11_proxy);
     g_clear_pointer(&ddl->peer_process, CloseHandle);
 #ifdef CONFIG_OPENGL
+    pixman_region32_fini(&ddl->gl_damage);
     egl_fb_destroy(&ddl->fb);
 #endif
 #endif
@@ -772,6 +787,9 @@ dbus_display_listener_class_init(DBusDisplayListenerClass *klass)
 static void
 dbus_display_listener_init(DBusDisplayListener *ddl)
 {
+#ifdef CONFIG_OPENGL
+    pixman_region32_init(&ddl->gl_damage);
+#endif
 }
 
 const char *
-- 
2.41.0


