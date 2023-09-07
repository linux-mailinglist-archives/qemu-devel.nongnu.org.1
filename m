Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD8C7972B5
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:13:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeElp-0003YA-95; Thu, 07 Sep 2023 09:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qeElk-0003FW-GK
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:10:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qeElc-0001xW-RO
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694092189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NiLDqzrC6xsFAIxYfOcbCzOE5OexdG4EO9/XFCE2h8Q=;
 b=T5XpsDtpMLLLN5SWEc5DG6OkFdQNyU9iEP/UQebVIPDTYms+gccYRqfClStQ68yF8TC6ZC
 MoJAgeu2mJzBj2u6FvR9QJ6K0JIS6mzhFy4umlogIDMwJP325WzH1MBhiiLjUb7BmYpoQV
 ZYVkuX9eAKGmkxTlFvmFOuMis+UC8Ik=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-JfOTYpcWO1GTOBd0V6bukQ-1; Thu, 07 Sep 2023 09:09:48 -0400
X-MC-Unique: JfOTYpcWO1GTOBd0V6bukQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0861917840
 for <qemu-devel@nongnu.org>; Thu,  7 Sep 2023 13:09:47 +0000 (UTC)
Received: from localhost (unknown [10.39.208.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0513C400F5F;
 Thu,  7 Sep 2023 13:09:46 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kraxel@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 2/5] virtio-gpu: factor out restore mapping
Date: Thu,  7 Sep 2023 17:09:33 +0400
Message-ID: <20230907130936.767722-3-marcandre.lureau@redhat.com>
In-Reply-To: <20230907130936.767722-1-marcandre.lureau@redhat.com>
References: <20230907130936.767722-1-marcandre.lureau@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The same function is going to be used next to restore "blob" resources.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c | 60 ++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index d6909bfa97..a58cb68f1c 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1237,6 +1237,35 @@ static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
     return vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL);
 }
 
+static bool virtio_gpu_load_restore_mapping(VirtIOGPU *g,
+                                            struct virtio_gpu_simple_resource *res)
+{
+    int i;
+
+    for (i = 0; i < res->iov_cnt; i++) {
+        hwaddr len = res->iov[i].iov_len;
+        res->iov[i].iov_base =
+            dma_memory_map(VIRTIO_DEVICE(g)->dma_as, res->addrs[i], &len,
+                           DMA_DIRECTION_TO_DEVICE, MEMTXATTRS_UNSPECIFIED);
+
+        if (!res->iov[i].iov_base || len != res->iov[i].iov_len) {
+            /* Clean up the half-a-mapping we just created... */
+            if (res->iov[i].iov_base) {
+                dma_memory_unmap(VIRTIO_DEVICE(g)->dma_as, res->iov[i].iov_base,
+                                 len, DMA_DIRECTION_TO_DEVICE, 0);
+            }
+            /* ...and the mappings for previous loop iterations */
+            res->iov_cnt = i;
+            virtio_gpu_cleanup_mapping(g, res);
+            return false;
+        }
+    }
+
+    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
+    g->hostmem += res->hostmem;
+    return true;
+}
+
 static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
                            const VMStateField *field)
 {
@@ -1299,35 +1328,12 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
         qemu_get_buffer(f, (void *)pixman_image_get_data(res->image),
                         pixman_image_get_stride(res->image) * res->height);
 
-        /* restore mapping */
-        for (i = 0; i < res->iov_cnt; i++) {
-            hwaddr len = res->iov[i].iov_len;
-            res->iov[i].iov_base =
-                dma_memory_map(VIRTIO_DEVICE(g)->dma_as, res->addrs[i], &len,
-                               DMA_DIRECTION_TO_DEVICE,
-                               MEMTXATTRS_UNSPECIFIED);
-
-            if (!res->iov[i].iov_base || len != res->iov[i].iov_len) {
-                /* Clean up the half-a-mapping we just created... */
-                if (res->iov[i].iov_base) {
-                    dma_memory_unmap(VIRTIO_DEVICE(g)->dma_as,
-                                     res->iov[i].iov_base,
-                                     len,
-                                     DMA_DIRECTION_TO_DEVICE,
-                                     0);
-                }
-                /* ...and the mappings for previous loop iterations */
-                res->iov_cnt = i;
-                virtio_gpu_cleanup_mapping(g, res);
-                pixman_image_unref(res->image);
-                g_free(res);
-                return -EINVAL;
-            }
+        if (!virtio_gpu_load_restore_mapping(g, res)) {
+            pixman_image_unref(res->image);
+            g_free(res);
+            return -EINVAL;
         }
 
-        QTAILQ_INSERT_HEAD(&g->reslist, res, next);
-        g->hostmem += res->hostmem;
-
         resource_id = qemu_get_be32(f);
     }
 
-- 
2.41.0


