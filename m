Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E5F7E1B13
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:25:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzty4-00020k-C3; Mon, 06 Nov 2023 02:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzty0-0001uO-LM
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:24:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qztxy-0006Na-Tx
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:24:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699255450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=laHjWLzCritiBmm3tfQnxZN8308Nvvp2FONGgcUqOYE=;
 b=d+s7aoiW5JqSogn1yOffL42nStalI1kFsTXX9pjYyAKjdKqrLNjbB0pWFsN0K6aVHFRfEP
 kbD+fUXlGmceTAQzFOJA7hddw2sdsOqUo3xM5rtcdzbMn2FsYe2XKoKPiRQRAgrd6+R/ya
 SY4YJDkZR4ujEHvztxRs/8f+2KSWUY8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-8Zi27KIoOTKZLSkZIIlhVQ-1; Mon,
 06 Nov 2023 02:24:09 -0500
X-MC-Unique: 8Zi27KIoOTKZLSkZIIlhVQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB05C280604A;
 Mon,  6 Nov 2023 07:24:08 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6DEABC1596F;
 Mon,  6 Nov 2023 07:24:07 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 12/23] virtio-gpu: replace PIXMAN for region/rect test
Date: Mon,  6 Nov 2023 11:23:01 +0400
Message-ID: <20231106072313.1742543-13-marcandre.lureau@redhat.com>
In-Reply-To: <20231106072313.1742543-1-marcandre.lureau@redhat.com>
References: <20231106072313.1742543-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Use a simpler implementation for rectangle geometry & intersect, drop
the need for (more complex) PIXMAN functions.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/ui/rect.h       | 59 +++++++++++++++++++++++++++++++++++++++++
 hw/display/virtio-gpu.c | 30 ++++++++-------------
 2 files changed, 70 insertions(+), 19 deletions(-)
 create mode 100644 include/ui/rect.h

diff --git a/include/ui/rect.h b/include/ui/rect.h
new file mode 100644
index 0000000000..94898f92d0
--- /dev/null
+++ b/include/ui/rect.h
@@ -0,0 +1,59 @@
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
+static inline void qemu_rect_init(QemuRect *rect,
+                                  int16_t x, int16_t y,
+                                  uint16_t width, uint16_t height)
+{
+    rect->x = x;
+    rect->y = x;
+    rect->width = width;
+    rect->height = height;
+}
+
+static inline void qemu_rect_translate(QemuRect *rect,
+                                       int16_t dx, int16_t dy)
+{
+    rect->x += dx;
+    rect->y += dy;
+}
+
+static inline bool qemu_rect_intersect(const QemuRect *a, const QemuRect *b,
+                                       QemuRect *res)
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
index 4265316cbb..a8e767245f 100644
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
@@ -503,7 +504,7 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
     struct virtio_gpu_simple_resource *res;
     struct virtio_gpu_resource_flush rf;
     struct virtio_gpu_scanout *scanout;
-    pixman_region16_t flush_region;
+    QemuRect flush_rect;
     bool within_bounds = false;
     bool update_submitted = false;
     int i;
@@ -565,34 +566,25 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
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


