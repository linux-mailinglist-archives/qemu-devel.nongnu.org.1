Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF457E259F
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 14:33:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzzjC-0005zN-CM; Mon, 06 Nov 2023 08:33:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzzj9-0005uG-Ss
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 08:33:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzzj8-0003ml-7y
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 08:33:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699277593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5o+XcPKRRjYB9IrY7Pzc8TYNltWXNcCojmQVdAXEGBg=;
 b=CJWDlo0N2Flt2Aig3IxeGLHYqcAgsOXY1UJoT7TKiJi2rknMVKvTVb3vY/dtM/c5J8X+DK
 +/3MlR9xElcm5HSRiCwh7WXaLApBR3LGbYZ8w5QzgSfuLJ/r8tUnvMaNz3KthKuUa2l3SQ
 4skdLwzPiinl1RsqWUfoW0JqGlcPaLQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-9oiJra_vOJ6W6vZyV5q92w-1; Mon,
 06 Nov 2023 08:33:01 -0500
X-MC-Unique: 9oiJra_vOJ6W6vZyV5q92w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E63593C0FC91
 for <qemu-devel@nongnu.org>; Mon,  6 Nov 2023 13:33:00 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A45F12166B26;
 Mon,  6 Nov 2023 13:32:59 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 09/10] virtio-gpu: add virtio-gpu/blob vmstate subsection
Date: Mon,  6 Nov 2023 17:32:18 +0400
Message-ID: <20231106133219.2173660-10-marcandre.lureau@redhat.com>
In-Reply-To: <20231106133219.2173660-1-marcandre.lureau@redhat.com>
References: <20231106133219.2173660-1-marcandre.lureau@redhat.com>
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
---
 hw/display/virtio-gpu.c | 101 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 26065c6466..1ab662db72 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1216,6 +1216,9 @@ static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
     assert(QTAILQ_EMPTY(&g->cmdq));
 
     QTAILQ_FOREACH(res, &g->reslist, next) {
+        if (res->blob_size) {
+            continue;
+        }
         qemu_put_be32(f, res->resource_id);
         qemu_put_be32(f, res->width);
         qemu_put_be32(f, res->height);
@@ -1340,6 +1343,74 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
     return 0;
 }
 
+static int virtio_gpu_blob_save(QEMUFile *f, void *opaque, size_t size,
+                                const VMStateField *field, JSONWriter *vmdesc)
+{
+    VirtIOGPU *g = opaque;
+    struct virtio_gpu_simple_resource *res;
+    int i;
+
+    /* in 2d mode we should never find unprocessed commands here */
+    assert(QTAILQ_EMPTY(&g->cmdq));
+
+    QTAILQ_FOREACH(res, &g->reslist, next) {
+        if (!res->blob_size) {
+            continue;
+        }
+        qemu_put_be32(f, res->resource_id);
+        qemu_put_be32(f, res->blob_size);
+        qemu_put_be32(f, res->iov_cnt);
+        for (i = 0; i < res->iov_cnt; i++) {
+            qemu_put_be64(f, res->addrs[i]);
+            qemu_put_be32(f, res->iov[i].iov_len);
+        }
+    }
+    qemu_put_be32(f, 0); /* end of list */
+
+    return 0;
+}
+
+static int virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
+                                const VMStateField *field)
+{
+    VirtIOGPU *g = opaque;
+    struct virtio_gpu_simple_resource *res;
+    uint32_t resource_id;
+    int i;
+
+    resource_id = qemu_get_be32(f);
+    while (resource_id != 0) {
+        res = virtio_gpu_find_resource(g, resource_id);
+        if (res) {
+            return -EINVAL;
+        }
+
+        res = g_new0(struct virtio_gpu_simple_resource, 1);
+        res->resource_id = resource_id;
+        res->blob_size = qemu_get_be32(f);
+        res->iov_cnt = qemu_get_be32(f);
+        res->addrs = g_new(uint64_t, res->iov_cnt);
+        res->iov = g_new(struct iovec, res->iov_cnt);
+
+        /* read data */
+        for (i = 0; i < res->iov_cnt; i++) {
+            res->addrs[i] = qemu_get_be64(f);
+            res->iov[i].iov_len = qemu_get_be32(f);
+        }
+
+        if (!virtio_gpu_load_restore_mapping(g, res)) {
+            g_free(res);
+            return -EINVAL;
+        }
+
+        virtio_gpu_init_udmabuf(res);
+
+        resource_id = qemu_get_be32(f);
+    }
+
+    return 0;
+}
+
 static int virtio_gpu_post_load(void *opaque, int version_id)
 {
     VirtIOGPU *g = opaque;
@@ -1505,6 +1576,32 @@ virtio_gpu_set_config(VirtIODevice *vdev, const uint8_t *config)
     }
 }
 
+static bool virtio_gpu_blob_state_needed(void *opaque)
+{
+    VirtIOGPU *g = VIRTIO_GPU(opaque);
+
+    return virtio_gpu_blob_enabled(g->parent_obj.conf);
+}
+
+const VMStateDescription vmstate_virtio_gpu_blob_state = {
+    .name = "virtio-gpu/blob",
+    .minimum_version_id = VIRTIO_GPU_VM_VERSION,
+    .version_id = VIRTIO_GPU_VM_VERSION,
+    .needed = virtio_gpu_blob_state_needed,
+    .fields = (const VMStateField[]){
+        {
+            .name = "virtio-gpu/blob",
+            .info = &(const VMStateInfo) {
+                .name = "blob",
+                .get = virtio_gpu_blob_load,
+                .put = virtio_gpu_blob_save,
+            },
+            .flags = VMS_SINGLE,
+        } /* device */,
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 /*
  * For historical reasons virtio_gpu does not adhere to virtio migration
  * scheme as described in doc/virtio-migration.txt, in a sense that no
@@ -1530,6 +1627,10 @@ static const VMStateDescription vmstate_virtio_gpu = {
         } /* device */,
         VMSTATE_END_OF_LIST()
     },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_virtio_gpu_blob_state,
+        NULL
+    },
     .post_load = virtio_gpu_post_load,
 };
 
-- 
2.41.0


