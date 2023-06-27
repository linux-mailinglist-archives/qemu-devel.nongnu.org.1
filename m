Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5832B73FC5D
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:04:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8MG-0000F9-ON; Tue, 27 Jun 2023 09:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8ME-0000Et-E3
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8MC-0007GS-Bi
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687871023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9nIOGEUGeOA+o9MIw0UsGwFcaDjc0VQDmZA47y3tpYM=;
 b=eaii6+PPhno8sbh+oDtMQptrai8xqTVfQVvWZuPwXM0HqdH9e6DWJcId92xRFL5JzqcFcH
 hBK1Ky6KIhEnTqhvFAX0cPHj9mlDopdRmOvgt3wkp01Ar/5JLFr2+g83sB818P+fw05+Ap
 aAOxNaKq/O3pausZM4HyIMYvto6bhO0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-462-56Bg6xlEOYO_kx33-LUYZQ-1; Tue, 27 Jun 2023 09:03:42 -0400
X-MC-Unique: 56Bg6xlEOYO_kx33-LUYZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1525C8C7C26;
 Tue, 27 Jun 2023 13:03:35 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA8A740C6CCD;
 Tue, 27 Jun 2023 13:03:34 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 30/33] ui/egl: query ANGLE d3d device
Date: Tue, 27 Jun 2023 15:02:27 +0200
Message-ID: <20230627130231.1614896-31-marcandre.lureau@redhat.com>
In-Reply-To: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Check if ANGLE is being used with D3D backend.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230606115658.677673-19-marcandre.lureau@redhat.com>
---
 include/ui/egl-helpers.h |  1 +
 ui/egl-helpers.c         | 32 +++++++++++++++++++++++++++++++-
 ui/trace-events          |  3 +++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index 6e2f0c49a6..4b8c0d2281 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -12,6 +12,7 @@
 extern EGLDisplay *qemu_egl_display;
 extern EGLConfig qemu_egl_config;
 extern DisplayGLMode qemu_egl_mode;
+extern bool qemu_egl_angle_d3d;
 
 typedef struct egl_fb {
     int width;
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index f38800e920..8f9fbf583e 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -15,16 +15,19 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+
 #include "qemu/drm.h"
 #include "qemu/error-report.h"
 #include "ui/console.h"
 #include "ui/egl-helpers.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
+#include "trace.h"
 
 EGLDisplay *qemu_egl_display;
 EGLConfig qemu_egl_config;
 DisplayGLMode qemu_egl_mode;
+bool qemu_egl_angle_d3d;
 
 /* ------------------------------------------------------------------ */
 
@@ -553,7 +556,34 @@ int qemu_egl_init_dpy_win32(EGLNativeDisplayType dpy, DisplayGLMode mode)
     if (mode == DISPLAYGL_MODE_ON) {
         mode = DISPLAYGL_MODE_ES;
     }
-    return qemu_egl_init_dpy(dpy, 0, mode);
+
+    if (qemu_egl_init_dpy(dpy, 0, mode) < 0) {
+        return -1;
+    }
+
+#ifdef EGL_D3D11_DEVICE_ANGLE
+    if (epoxy_has_egl_extension(qemu_egl_display, "EGL_EXT_device_query")) {
+        EGLDeviceEXT device;
+        void *d3d11_device;
+
+        if (!eglQueryDisplayAttribEXT(qemu_egl_display,
+                                      EGL_DEVICE_EXT,
+                                      (EGLAttrib *)&device)) {
+            return 0;
+        }
+
+        if (!eglQueryDeviceAttribEXT(device,
+                                     EGL_D3D11_DEVICE_ANGLE,
+                                     (EGLAttrib *)&d3d11_device)) {
+            return 0;
+        }
+
+        trace_egl_init_d3d11_device(device);
+        qemu_egl_angle_d3d = device != NULL;
+    }
+#endif
+
+    return 0;
 }
 #endif
 
diff --git a/ui/trace-events b/ui/trace-events
index fe58675163..76b19a2995 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -162,3 +162,6 @@ dbus_clipboard_register(const char *bus_name) "peer %s"
 dbus_clipboard_unregister(const char *bus_name) "peer %s"
 dbus_scanout_texture(uint32_t tex_id, bool backing_y_0_top, uint32_t backing_width, uint32_t backing_height, uint32_t x, uint32_t y, uint32_t w, uint32_t h) "tex_id:%u y0top:%d back:%ux%u %u+%u-%ux%u"
 dbus_gl_gfx_switch(void *p) "surf: %p"
+
+# egl-helpers.c
+egl_init_d3d11_device(void *p) "d3d device: %p"
-- 
2.41.0


