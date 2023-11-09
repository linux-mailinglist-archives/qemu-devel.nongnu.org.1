Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAE37E6BB4
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:54:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15Nr-0000yu-Py; Thu, 09 Nov 2023 08:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15NJ-0007oa-TT; Thu, 09 Nov 2023 08:47:15 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15N1-00021A-QJ; Thu, 09 Nov 2023 08:47:08 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5D1E831B1D;
 Thu,  9 Nov 2023 16:43:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6D82D344C3;
 Thu,  9 Nov 2023 16:43:06 +0300 (MSK)
Received: (nullmailer pid 1461873 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 37/55] virtio-gpu: block migration of VMs with blob=true
Date: Thu,  9 Nov 2023 16:42:41 +0300
Message-Id: <20231109134300.1461632-37-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

"blob" resources don't have an associated pixman image:

#0  pixman_image_get_stride (image=0x0) at ../pixman/pixman-image.c:921
#1  0x0000562327c25236 in virtio_gpu_save (f=0x56232bb13b00, opaque=0x56232b555a60, size=0, field=0x5623289ab6c8 <__compound_literal.3+104>, vmdesc=0x56232ab59fe0) at ../hw/display/virtio-gpu.c:1225

Related to:
https://bugzilla.redhat.com/show_bug.cgi?id=2236353

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit 9c549ab6895a43ad0cb33e684e11cdb0b5400897)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 93857ad523..5b64942637 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -26,6 +26,7 @@
 #include "hw/virtio/virtio-gpu-pixman.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/qdev-properties.h"
+#include "migration/blocker.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
@@ -44,6 +45,8 @@ static void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
                                        struct virtio_gpu_simple_resource *res);
 static void virtio_gpu_reset_bh(void *opaque);
 
+static Error *blob_mig_blocker;
+
 void virtio_gpu_update_cursor_data(VirtIOGPU *g,
                                    struct virtio_gpu_scanout *s,
                                    uint32_t resource_id)
@@ -1376,6 +1379,14 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
             error_setg(errp, "blobs and virgl are not compatible (yet)");
             return;
         }
+
+        if (!blob_mig_blocker) {
+            error_setg(&blob_mig_blocker,
+                       "virtio-gpu blob VMs are currently not migratable.");
+        }
+        if (migrate_add_blocker(blob_mig_blocker, errp)) {
+            return;
+        }
     }
 
     if (!virtio_gpu_base_device_realize(qdev,
@@ -1402,6 +1413,9 @@ static void virtio_gpu_device_unrealize(DeviceState *qdev)
 {
     VirtIOGPU *g = VIRTIO_GPU(qdev);
 
+    if (virtio_gpu_blob_enabled(g->parent_obj.conf)) {
+        migrate_del_blocker(blob_mig_blocker);
+    }
     g_clear_pointer(&g->ctrl_bh, qemu_bh_delete);
     g_clear_pointer(&g->cursor_bh, qemu_bh_delete);
     g_clear_pointer(&g->reset_bh, qemu_bh_delete);
-- 
2.39.2


