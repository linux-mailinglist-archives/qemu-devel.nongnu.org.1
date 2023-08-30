Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E1178D4D7
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:44:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHj9-0006Lk-52; Wed, 30 Aug 2023 05:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHj3-0006Ak-IT
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:43:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHj1-00020l-24
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693388578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tRrDCxUd6Z8r8T/BzOI7Pbglh7Lm9c8FNfmbB1n3zyI=;
 b=ati+t1c/DW34K3oRG+a3mmqZEo+jxNnAOT7dpkuiVbk5KpwSZhCh1VUXg6Rkzx1njD9Jvv
 9Au4YtnQq9GyF3zgVPgPIrcKc+WaEtikXVIx0ppL3zzac8HGC+QupM9+5PzOYHYNbo1LYo
 eruW/Yisrb9asHRAxcnLA6b7M+m5DY0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-YszIj7liP0Gql2WB5FW6NA-1; Wed, 30 Aug 2023 05:42:57 -0400
X-MC-Unique: YszIj7liP0Gql2WB5FW6NA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED28A806007
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:42:56 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A38E401E63;
 Wed, 30 Aug 2023 09:42:55 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 63/67] ui/dbus: do not require PIXMAN
Date: Wed, 30 Aug 2023 13:38:37 +0400
Message-ID: <20230830093843.3531473-64-marcandre.lureau@redhat.com>
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

Implement a fallback path for region 2D update.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c | 62 ++++++++++++++++++++++++++++++----------------
 ui/meson.build     |  2 +-
 2 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 30917271ab..f773c40685 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -562,13 +562,51 @@ static void dbus_gl_gfx_update(DisplayChangeListener *dcl,
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
+        uint8_t *src = pixman_image_get_data(ddl->ds->image);
+        uint8_t *dst = pixman_image_get_data(img);
+        int bp = PIXMAN_FORMAT_BPP(surface_format(ddl->ds)) / 8;
+        int hh;
+
+        for (hh = 0; hh < h; hh++) {
+            memcpy(&dst[stride * hh], &src[surface_stride(ddl->ds) * (hh + y) + x * bp], stride);
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
 
@@ -605,25 +643,7 @@ static void dbus_gfx_update(DisplayChangeListener *dcl,
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
diff --git a/ui/meson.build b/ui/meson.build
index 40dff7b3e0..dec2d471cc 100644
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
-- 
2.41.0


