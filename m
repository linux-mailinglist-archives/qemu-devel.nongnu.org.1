Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 490487D7412
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 21:15:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvjGR-0006eh-Gz; Wed, 25 Oct 2023 15:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qvjGH-0006Pa-Ap
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:09:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qvjGF-0000ed-FY
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698260986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YgZKMYWn3Wdc710ymth6R/fFVwX/oO2V2i44QoXo7BY=;
 b=jLiAeQeeS5N4xUfOLE5WHF20041VAX5wO9PDyAf1AXs8eNGD7xKbCEZuTW6GVwpx5MirxZ
 eYLNvkAeozd8pnRp19SGNtT9d7cfDDJr69d1br8A1GVUvAISkEiZz2LkAu/hsNURe9KPJM
 NkdKe71Fp6ioq+UG757mRCo6hv7+v0g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-tguDdbxZMUWyzYrAroUWpw-1; Wed, 25 Oct 2023 15:09:45 -0400
X-MC-Unique: tguDdbxZMUWyzYrAroUWpw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8176837227;
 Wed, 25 Oct 2023 19:09:44 +0000 (UTC)
Received: from localhost (unknown [10.39.208.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A9262166B26;
 Wed, 25 Oct 2023 19:09:43 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v6 19/23] ui/dbus: do not require PIXMAN
Date: Wed, 25 Oct 2023 23:08:13 +0400
Message-ID: <20231025190818.3278423-20-marcandre.lureau@redhat.com>
In-Reply-To: <20231025190818.3278423-1-marcandre.lureau@redhat.com>
References: <20231025190818.3278423-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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

Implement a fallback path for region 2D update.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c | 90 ++++++++++++++++++++++++++++++++--------------
 ui/meson.build     |  4 +--
 2 files changed, 65 insertions(+), 29 deletions(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 36548a7f52..18f556aa73 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -26,9 +26,6 @@
 #include "qapi/error.h"
 #include "sysemu/sysemu.h"
 #include "dbus.h"
-#ifdef CONFIG_OPENGL
-#include <pixman.h>
-#endif
 #ifdef G_OS_UNIX
 #include <gio/gunixfdlist.h>
 #endif
@@ -41,6 +38,7 @@
 #include "ui/shader.h"
 #include "ui/egl-helpers.h"
 #include "ui/egl-context.h"
+#include "ui/qemu-pixman.h"
 #endif
 #include "trace.h"
 
@@ -62,9 +60,11 @@ struct _DBusDisplayListener {
 
     QemuDBusDisplay1Listener *proxy;
 
-#ifdef CONFIG_OPENGL
+#ifdef CONFIG_PIXMAN
     /* Keep track of the damage region */
     pixman_region32_t gl_damage;
+#else
+    int gl_damage;
 #endif
 
     DisplayChangeListener dcl;
@@ -545,6 +545,7 @@ static void dbus_gl_refresh(DisplayChangeListener *dcl)
         return;
     }
 
+#ifdef CONFIG_PIXMAN
     int n_rects = pixman_region32_n_rects(&ddl->gl_damage);
 
     for (int i = 0; i < n_rects; i++) {
@@ -555,6 +556,13 @@ static void dbus_gl_refresh(DisplayChangeListener *dcl)
                             box->x2 - box->x1, box->y2 - box->y1);
     }
     pixman_region32_clear(&ddl->gl_damage);
+#else
+    if (ddl->gl_damage) {
+        dbus_call_update_gl(dcl, 0, 0,
+                            surface_width(ddl->ds), surface_height(ddl->ds));
+        ddl->gl_damage = 0;
+    }
+#endif
 }
 #endif /* OPENGL */
 
@@ -569,20 +577,64 @@ static void dbus_gl_gfx_update(DisplayChangeListener *dcl,
 {
     DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
 
+#ifdef CONFIG_PIXMAN
     pixman_region32_t rect_region;
     pixman_region32_init_rect(&rect_region, x, y, w, h);
     pixman_region32_union(&ddl->gl_damage, &ddl->gl_damage, &rect_region);
     pixman_region32_fini(&rect_region);
+#else
+    ddl->gl_damage++;
+#endif
 }
 #endif
 
+static void dbus_gfx_update_sub(DBusDisplayListener *ddl,
+                                int x, int y, int w, int h)
+{
+    pixman_image_t *img;
+    size_t stride;
+    GVariant *v_data;
+
+    /* make a copy, since gvariant only handles linear data */
+    stride = w * DIV_ROUND_UP(PIXMAN_FORMAT_BPP(surface_format(ddl->ds)), 8);
+    img = pixman_image_create_bits(surface_format(ddl->ds),
+                                   w, h, NULL, stride);
+#ifdef CONFIG_PIXMAN
+    pixman_image_composite(PIXMAN_OP_SRC, ddl->ds->image, NULL, img,
+                           x, y, 0, 0, 0, 0, w, h);
+#else
+    {
+        uint8_t *src = (uint8_t *)pixman_image_get_data(ddl->ds->image);
+        uint8_t *dst = (uint8_t *)pixman_image_get_data(img);
+        int bp = PIXMAN_FORMAT_BPP(surface_format(ddl->ds)) / 8;
+        int hh;
+
+        for (hh = 0; hh < h; hh++) {
+            memcpy(&dst[stride * hh],
+                   &src[surface_stride(ddl->ds) * (hh + y) + x * bp],
+                   stride);
+        }
+    }
+#endif
+    v_data = g_variant_new_from_data(
+        G_VARIANT_TYPE("ay"),
+        pixman_image_get_data(img),
+        pixman_image_get_stride(img) * h,
+        TRUE,
+        (GDestroyNotify)pixman_image_unref,
+        img);
+    qemu_dbus_display1_listener_call_update(ddl->proxy,
+        x, y, w, h, pixman_image_get_stride(img), pixman_image_get_format(img),
+        v_data,
+        G_DBUS_CALL_FLAGS_NONE,
+        DBUS_DEFAULT_TIMEOUT, NULL, NULL, NULL);
+}
+
 static void dbus_gfx_update(DisplayChangeListener *dcl,
                             int x, int y, int w, int h)
 {
     DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
-    pixman_image_t *img;
     GVariant *v_data;
-    size_t stride;
 
     assert(ddl->ds);
 
@@ -619,25 +671,7 @@ static void dbus_gfx_update(DisplayChangeListener *dcl,
         return;
     }
 
-    /* make a copy, since gvariant only handles linear data */
-    stride = w * DIV_ROUND_UP(PIXMAN_FORMAT_BPP(surface_format(ddl->ds)), 8);
-    img = pixman_image_create_bits(surface_format(ddl->ds),
-                                   w, h, NULL, stride);
-    pixman_image_composite(PIXMAN_OP_SRC, ddl->ds->image, NULL, img,
-                           x, y, 0, 0, 0, 0, w, h);
-
-    v_data = g_variant_new_from_data(
-        G_VARIANT_TYPE("ay"),
-        pixman_image_get_data(img),
-        pixman_image_get_stride(img) * h,
-        TRUE,
-        (GDestroyNotify)pixman_image_unref,
-        img);
-    qemu_dbus_display1_listener_call_update(ddl->proxy,
-        x, y, w, h, pixman_image_get_stride(img), pixman_image_get_format(img),
-        v_data,
-        G_DBUS_CALL_FLAGS_NONE,
-        DBUS_DEFAULT_TIMEOUT, NULL, NULL, NULL);
+    dbus_gfx_update_sub(ddl, x, y, w, h);
 }
 
 #ifdef CONFIG_OPENGL
@@ -751,8 +785,10 @@ dbus_display_listener_dispose(GObject *object)
     g_clear_object(&ddl->map_proxy);
     g_clear_object(&ddl->d3d11_proxy);
     g_clear_pointer(&ddl->peer_process, CloseHandle);
-#ifdef CONFIG_OPENGL
+#ifdef CONFIG_PIXMAN
     pixman_region32_fini(&ddl->gl_damage);
+#endif
+#ifdef CONFIG_OPENGL
     egl_fb_destroy(&ddl->fb);
 #endif
 #endif
@@ -787,7 +823,7 @@ dbus_display_listener_class_init(DBusDisplayListenerClass *klass)
 static void
 dbus_display_listener_init(DBusDisplayListener *ddl)
 {
-#ifdef CONFIG_OPENGL
+#ifdef CONFIG_PIXMAN
     pixman_region32_init(&ddl->gl_damage);
 #endif
 }
diff --git a/ui/meson.build b/ui/meson.build
index 024f494faf..0ccb3387ee 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -93,7 +93,7 @@ if dbus_display
                                           '--generate-c-code', '@BASENAME@'])
   dbus_display1_lib = static_library('dbus-display1', dbus_display1, dependencies: gio)
   dbus_display1_dep = declare_dependency(link_with: dbus_display1_lib, include_directories: include_directories('.'))
-  dbus_ss.add(when: [gio, pixman, dbus_display1_dep],
+  dbus_ss.add(when: [gio, dbus_display1_dep],
               if_true: [files(
                 'dbus-chardev.c',
                 'dbus-clipboard.c',
@@ -101,7 +101,7 @@ if dbus_display
                 'dbus-error.c',
                 'dbus-listener.c',
                 'dbus.c',
-              ), opengl, gbm])
+              ), opengl, gbm, pixman])
   ui_modules += {'dbus' : dbus_ss}
 endif
 
-- 
2.41.0


