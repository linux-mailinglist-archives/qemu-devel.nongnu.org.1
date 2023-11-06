Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2AD7E25B9
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 14:34:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzzio-0005ps-Em; Mon, 06 Nov 2023 08:32:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzzim-0005pG-IV
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 08:32:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzzik-0003lY-Rj
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 08:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699277569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X3pznm3QlOU/ZHLArGlalsrlHMHaEqY9m5mHFzJczgg=;
 b=hgmJGfVm8opRgpHQRlZ/0iwh5/V02Namr73q57dvvVyaZXTsAUNMbBykixpVosqJ7yFaXX
 qEJuE/NrZDiUzzBrbB2XK0ScLtMXT63eqgah7R+i0QMcFIyh5vkQx/eJafG8GEYMlH50y8
 VwGQoNZfI1SHP7VUWGC/h0joSFr9EBs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638--qHk8jM8PnijWRIfJ7O29A-1; Mon,
 06 Nov 2023 08:32:48 -0500
X-MC-Unique: -qHk8jM8PnijWRIfJ7O29A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24DF42815E22
 for <qemu-devel@nongnu.org>; Mon,  6 Nov 2023 13:32:48 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 684DE2166B26;
 Mon,  6 Nov 2023 13:32:47 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 06/10] virtio-gpu: block migration of VMs with blob=true
Date: Mon,  6 Nov 2023 17:32:15 +0400
Message-ID: <20231106133219.2173660-7-marcandre.lureau@redhat.com>
In-Reply-To: <20231106133219.2173660-1-marcandre.lureau@redhat.com>
References: <20231106133219.2173660-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

"blob" resources don't have an associated pixman image:

#0  pixman_image_get_stride (image=0x0) at ../pixman/pixman-image.c:921
#1  0x0000562327c25236 in virtio_gpu_save (f=0x56232bb13b00, opaque=0x56232b555a60, size=0, field=0x5623289ab6c8 <__compound_literal.3+104>, vmdesc=0x56232ab59fe0) at ../hw/display/virtio-gpu.c:1225

Related to:
https://bugzilla.redhat.com/show_bug.cgi?id=2236353

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
---
 hw/display/virtio-gpu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 4265316cbb..dd9965c2ef 100644
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
@@ -40,6 +41,8 @@ virtio_gpu_find_check_resource(VirtIOGPU *g, uint32_t resource_id,
 
 static void virtio_gpu_reset_bh(void *opaque);
 
+static Error *blob_mig_blocker;
+
 void virtio_gpu_update_cursor_data(VirtIOGPU *g,
                                    struct virtio_gpu_scanout *s,
                                    uint32_t resource_id)
@@ -1373,6 +1376,14 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
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
@@ -1399,6 +1410,9 @@ static void virtio_gpu_device_unrealize(DeviceState *qdev)
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


