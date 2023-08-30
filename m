Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE31378D4D6
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:44:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHiv-0004ko-Lr; Wed, 30 Aug 2023 05:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHie-00042E-IL
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:42:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHic-0001pn-9t
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693388553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eQHmC7587AX8nFVPxeECguZ4m8Q/iR2kxUKQWtBNVXY=;
 b=iyv0eR3uvoXCFTKVgmAEIqXXcNykh8s2lGGEg27phXG62uQPDlc9N3GpAF9uqcws7skYcN
 T0wjB+DQABncKUZ4PfGkBtlfcoTn5numjIb15dRgGDFuOyjG7J7NZfEXPU5jiO8j5V+2ea
 QKI7kTSqEvx8VH+14kBx8CFJN0o34Jw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-8WG8XbY7MGS3gSP5JoUx2Q-1; Wed, 30 Aug 2023 05:42:31 -0400
X-MC-Unique: 8WG8XbY7MGS3gSP5JoUx2Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45F3980602D
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:42:31 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 66EA063F6C;
 Wed, 30 Aug 2023 09:42:30 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 56/67] virtio-gpu: replace PIXMAN for region/rect test
Date: Wed, 30 Aug 2023 13:38:30 +0400
Message-ID: <20230830093843.3531473-57-marcandre.lureau@redhat.com>
In-Reply-To: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

Use a simpler implementation for rectangle geometry & intersect, drop
the need for (more complex) PIXMAN functions.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/rect.h       | 55 +++++++++++++++++++++++++++++++++++++++++
 hw/display/virtio-gpu.c | 30 +++++++++-------------
 2 files changed, 66 insertions(+), 19 deletions(-)
 create mode 100644 include/ui/rect.h

diff --git a/include/ui/rect.h b/include/ui/rect.h
new file mode 100644
index 0000000000..63edf7a39d
--- /dev/null
+++ b/include/ui/rect.h
@@ -0,0 +1,55 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef QEMU_RECT_H
+#define QEMU_RECT_H
+
+#include <stdint.h>
+#include <stdbool.h>
+
+typedef struct QemuRect {
+    int16_t x;
+    int16_t y;
+    uint16_t width;
+    uint16_t height;
+} QemuRect;
+
+static inline void qemu_rect_init(QemuRect* rect, int16_t x, int16_t y, uint16_t width, uint16_t height)
+{
+    rect->x = x;
+    rect->y = x;
+    rect->width = width;
+    rect->height = height;
+}
+
+static inline void qemu_rect_translate(QemuRect* rect, int16_t dx, int16_t dy)
+{
+    rect->x += dx;
+    rect->y += dy;
+}
+
+static inline bool qemu_rect_intersect(const QemuRect* a, const QemuRect* b, QemuRect *res)
+{
+    int16_t x1, x2, y1, y2;
+
+    x1 = MAX(a->x, b->x);
+    y1 = MAX(a->y, b->y);
+    x2 = MIN(a->x + a->width, b->x + b->width);
+    y2 = MIN(a->y + a->height, b->y + b->height);
+
+    if (x1 >= x2 || y1 >= y2) {
+        if (res) {
+            qemu_rect_init(res, 0, 0, 0, 0);
+        }
+
+        return false;
+    }
+
+    if (res) {
+        qemu_rect_init(res, x1, y1, x2 - x1, y2 - y1);
+    }
+
+    return true;
+}
+
+#endif
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index bbd5c6561a..e77187a610 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -16,6 +16,7 @@
 #include "qemu/iov.h"
 #include "sysemu/cpus.h"
 #include "ui/console.h"
+#include "ui/rect.h"
 #include "trace.h"
 #include "sysemu/dma.h"
 #include "sysemu/sysemu.h"
@@ -507,7 +508,7 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
     struct virtio_gpu_simple_resource *res;
     struct virtio_gpu_resource_flush rf;
     struct virtio_gpu_scanout *scanout;
-    pixman_region16_t flush_region;
+    QemuRect flush_rect;
     bool within_bounds = false;
     bool update_submitted = false;
     int i;
@@ -569,34 +570,25 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
         return;
     }
 
-    pixman_region_init_rect(&flush_region,
-                            rf.r.x, rf.r.y, rf.r.width, rf.r.height);
+    qemu_rect_init(&flush_rect, rf.r.x, rf.r.y, rf.r.width, rf.r.height);
     for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
-        pixman_region16_t region, finalregion;
-        pixman_box16_t *extents;
+        QemuRect rect;
 
         if (!(res->scanout_bitmask & (1 << i))) {
             continue;
         }
         scanout = &g->parent_obj.scanout[i];
 
-        pixman_region_init(&finalregion);
-        pixman_region_init_rect(&region, scanout->x, scanout->y,
-                                scanout->width, scanout->height);
+        qemu_rect_init(&rect, scanout->x, scanout->y,
+                       scanout->width, scanout->height);
 
-        pixman_region_intersect(&finalregion, &flush_region, &region);
-        pixman_region_translate(&finalregion, -scanout->x, -scanout->y);
-        extents = pixman_region_extents(&finalregion);
         /* work out the area we need to update for each console */
-        dpy_gfx_update(g->parent_obj.scanout[i].con,
-                       extents->x1, extents->y1,
-                       extents->x2 - extents->x1,
-                       extents->y2 - extents->y1);
-
-        pixman_region_fini(&region);
-        pixman_region_fini(&finalregion);
+        if (qemu_rect_intersect(&flush_rect, &rect, &rect)) {
+            qemu_rect_translate(&rect, -scanout->x, -scanout->y);
+            dpy_gfx_update(g->parent_obj.scanout[i].con,
+                           rect.x, rect.y, rect.width, rect.height);
+        }
     }
-    pixman_region_fini(&flush_region);
 }
 
 static void virtio_unref_resource(pixman_image_t *image, void *data)
-- 
2.41.0


