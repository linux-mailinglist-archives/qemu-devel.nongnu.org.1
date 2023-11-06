Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7FA7E2597
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 14:33:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzzit-0005sF-9W; Mon, 06 Nov 2023 08:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzzir-0005rR-4B
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 08:32:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzzip-0003ls-I6
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 08:32:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699277573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A8UAkq1odSE9Wc7UJB+Fgiwz/bE8MqjvP5XpsReUFhI=;
 b=YP+MP6JS9xWyQijsVLRzJqVQiVU3qCOxUrUT+lk6Lu/mLlpRd4XqUlwHyNS61c87IzMxlM
 YPVDxKMH2JnbrP12+bF9bew57kmk4JbIqM7QVDyKe+7OJy0CdSkdi7s8k3c3tEX3C1KxVc
 i4H7Jb1J6jpACCxmp+Jq2BYBne/Qb4E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-xQetAEX5Me6PnbhBHqG79g-1; Mon, 06 Nov 2023 08:32:52 -0500
X-MC-Unique: xQetAEX5Me6PnbhBHqG79g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2179984B108
 for <qemu-devel@nongnu.org>; Mon,  6 Nov 2023 13:32:52 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1123A502B;
 Mon,  6 Nov 2023 13:32:50 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 07/10] virtio-gpu: factor out restore mapping
Date: Mon,  6 Nov 2023 17:32:16 +0400
Message-ID: <20231106133219.2173660-8-marcandre.lureau@redhat.com>
In-Reply-To: <20231106133219.2173660-1-marcandre.lureau@redhat.com>
References: <20231106133219.2173660-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The same function is going to be used next to restore "blob" resources.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
---
 hw/display/virtio-gpu.c | 60 ++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index dd9965c2ef..8efabae7ee 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1233,6 +1233,35 @@ static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
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
@@ -1297,35 +1326,12 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
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


