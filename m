Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AB3783C30
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 10:55:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYN93-0005Er-TF; Tue, 22 Aug 2023 04:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qYN91-0005Ej-VT
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 04:53:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qYN8z-0000e7-O2
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 04:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692694425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sN6hUcBG/m2dmC5bPzPlcPUfvywRtZL8/dZ0pwpfeoA=;
 b=PlWBqpk6cpZ2WzOaYRtBJhsU4LHzDMwh4qiYO5AsXMyxURtSZHTReqyZDUBuc9zhs6Xqwo
 wa0jsbrYS8B2LJMqjReP/buoJxOdUhW4a1K2v0BKmL9gILbM8CBSW7IKCWCVpvIkNspX7y
 8BpYWM3i8/1HA9v6NWGSrXpPnoyaRxo=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-m5UpCl4HPNC4KglrBeEJ3Q-1; Tue, 22 Aug 2023 04:53:41 -0400
X-MC-Unique: m5UpCl4HPNC4KglrBeEJ3Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E08A1C0754C;
 Tue, 22 Aug 2023 08:53:40 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E32B40D2843;
 Tue, 22 Aug 2023 08:53:37 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>,
 Shannon Nelson <snelson@pensando.io>,
 Stefano Garzarella <sgarzare@redhat.com>, Lei Yang <leiyang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hawkins Jiawei <yin31149@gmail.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Gautam Dawar <gdawar@xilinx.com>,
 si-wei.liu@oracle.com, Zhu Lingshan <lingshan.zhu@intel.com>,
 Jason Wang <jasowang@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>
Subject: [PATCH v3 2/5] vdpa: export vhost_vdpa_set_vring_ready
Date: Tue, 22 Aug 2023 10:53:27 +0200
Message-Id: <20230822085330.3978829-3-eperezma@redhat.com>
In-Reply-To: <20230822085330.3978829-1-eperezma@redhat.com>
References: <20230822085330.3978829-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
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

The vhost-vdpa net backend needs to enable vrings in a different order
than default, so export it.

No functional change intended except for tracing, that now includes the
(virtio) index being enabled and the return value of the ioctl.

Still ignoring return value of this function if called from
vhost_vdpa_dev_start, as reorganize calling code around it is out of
the scope of this series.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h |  1 +
 hw/virtio/vhost-vdpa.c         | 25 +++++++++++++------------
 hw/virtio/trace-events         |  2 +-
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index e64bfc7f98..5407d54fd7 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -57,6 +57,7 @@ typedef struct vhost_vdpa {
 } VhostVDPA;
 
 int vhost_vdpa_get_iova_range(int fd, struct vhost_vdpa_iova_range *iova_range);
+int vhost_vdpa_set_vring_ready(struct vhost_vdpa *v, unsigned idx);
 
 int vhost_vdpa_dma_map(struct vhost_vdpa *v, uint32_t asid, hwaddr iova,
                        hwaddr size, void *vaddr, bool readonly);
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 42f2a4bae9..0d9975b5b5 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -876,18 +876,17 @@ static int vhost_vdpa_get_vq_index(struct vhost_dev *dev, int idx)
     return idx;
 }
 
-static int vhost_vdpa_set_vring_ready(struct vhost_dev *dev)
+int vhost_vdpa_set_vring_ready(struct vhost_vdpa *v, unsigned idx)
 {
-    int i;
-    trace_vhost_vdpa_set_vring_ready(dev);
-    for (i = 0; i < dev->nvqs; ++i) {
-        struct vhost_vring_state state = {
-            .index = dev->vq_index + i,
-            .num = 1,
-        };
-        vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &state);
-    }
-    return 0;
+    struct vhost_dev *dev = v->dev;
+    struct vhost_vring_state state = {
+        .index = idx,
+        .num = 1,
+    };
+    int r = vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &state);
+
+    trace_vhost_vdpa_set_vring_ready(dev, idx, r);
+    return r;
 }
 
 static int vhost_vdpa_set_config_call(struct vhost_dev *dev,
@@ -1298,7 +1297,9 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
         if (unlikely(!ok)) {
             return -1;
         }
-        vhost_vdpa_set_vring_ready(dev);
+        for (int i = 0; i < dev->nvqs; ++i) {
+            vhost_vdpa_set_vring_ready(v, dev->vq_index + i);
+        }
     } else {
         vhost_vdpa_suspend(dev);
         vhost_vdpa_svqs_stop(dev);
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 7109cf1a3b..1cb9027d1e 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -48,7 +48,7 @@ vhost_vdpa_set_features(void *dev, uint64_t features) "dev: %p features: 0x%"PRI
 vhost_vdpa_get_device_id(void *dev, uint32_t device_id) "dev: %p device_id %"PRIu32
 vhost_vdpa_reset_device(void *dev) "dev: %p"
 vhost_vdpa_get_vq_index(void *dev, int idx, int vq_idx) "dev: %p idx: %d vq idx: %d"
-vhost_vdpa_set_vring_ready(void *dev) "dev: %p"
+vhost_vdpa_set_vring_ready(void *dev, unsigned i, int r) "dev: %p, idx: %u, r: %d"
 vhost_vdpa_dump_config(void *dev, const char *line) "dev: %p %s"
 vhost_vdpa_set_config(void *dev, uint32_t offset, uint32_t size, uint32_t flags) "dev: %p offset: %"PRIu32" size: %"PRIu32" flags: 0x%"PRIx32
 vhost_vdpa_get_config(void *dev, void *config, uint32_t config_len) "dev: %p config: %p config_len: %"PRIu32
-- 
2.39.3


