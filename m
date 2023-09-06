Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4297793D6E
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 15:09:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdsGU-0007OG-Kp; Wed, 06 Sep 2023 09:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qdsGS-0007Nf-B2
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 09:08:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qdsGP-0003yc-UJ
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 09:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694005688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=b41wk96HMFXs7MBCesnZ8KY/vMtIRKpzK/hgkYRIyp8=;
 b=JvjucGz2goWGCdPZkLAXQPqxsDLSlgUCXcTByTtWKsp+Epx8K/tlZkMG35Y7RndXvCOk2r
 AdFl2edp84lO1wbNJBNXiZIUdj651IeC8HwQ19fq5RwwFCKqtA/ARwBAHqlWZm87CL4MRY
 Y2zPA/5ZRsg99ZienB3tkOJ8YzQwIiE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-_VRbEv_QP_m6gaQKt6a6QQ-1; Wed, 06 Sep 2023 09:08:06 -0400
X-MC-Unique: _VRbEv_QP_m6gaQKt6a6QQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DEF61C0CCAE
 for <qemu-devel@nongnu.org>; Wed,  6 Sep 2023 13:08:06 +0000 (UTC)
Received: from localhost (unknown [10.39.208.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D250D20BAE37;
 Wed,  6 Sep 2023 13:08:05 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio-gpu: block migration of VMs with blob=true
Date: Wed,  6 Sep 2023 17:08:03 +0400
Message-ID: <20230906130803.597185-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

"blob" resources don't have an associated pixman image:

#0  pixman_image_get_stride (image=0x0) at ../pixman/pixman-image.c:921
#1  0x0000562327c25236 in virtio_gpu_save (f=0x56232bb13b00, opaque=0x56232b555a60, size=0, field=0x5623289ab6c8 <__compound_literal.3+104>, vmdesc=0x56232ab59fe0) at ../hw/display/virtio-gpu.c:1225

Related to:
https://bugzilla.redhat.com/show_bug.cgi?id=2236353

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index fdb7b25a70..2f991789ed 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -27,6 +27,7 @@
 #include "hw/virtio/virtio-gpu-pixman.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/qdev-properties.h"
+#include "migration/blocker.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
@@ -45,6 +46,8 @@ static void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
                                        struct virtio_gpu_simple_resource *res);
 static void virtio_gpu_reset_bh(void *opaque);
 
+static Error *blob_mig_blocker;
+
 void virtio_gpu_update_cursor_data(VirtIOGPU *g,
                                    struct virtio_gpu_scanout *s,
                                    uint32_t resource_id)
@@ -1368,6 +1371,14 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
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
@@ -1394,6 +1405,9 @@ static void virtio_gpu_device_unrealize(DeviceState *qdev)
 {
     VirtIOGPU *g = VIRTIO_GPU(qdev);
 
+    if (virtio_gpu_blob_enabled(g->parent_obj.conf)) {
+        migrate_del_blocker(blob_mig_blocker);
+    }
     g_clear_pointer(&g->ctrl_bh, qemu_bh_delete);
     g_clear_pointer(&g->cursor_bh, qemu_bh_delete);
     g_clear_pointer(&g->reset_bh, qemu_bh_delete);
-- 
2.41.0


