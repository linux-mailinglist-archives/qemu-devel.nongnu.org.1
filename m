Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FE175B660
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 20:16:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMYBe-0004Ed-6d; Thu, 20 Jul 2023 14:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qMYBI-0004DJ-5k
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 14:15:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qMYBG-0003I1-D6
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 14:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689876913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PYBd5yDnfH/T6/KePGzF5vmEZfP6eou01c1gPkfVF3Q=;
 b=ZXeCD2r906BTMntaNtu/sNwv4LUhFIykdQVJFZ7NmnMlbPu+IiMggS5Em1jbynTzvwNNhJ
 c3MjCJoB8tOmgXbMyR0PzuKQwTzkVUh1YP0B9Nf4YQghxbtFDVmGJrvwnezAkViH7euL0R
 uXaZKeBmIW4QnKM5P92JhGtnpS0/h74=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-369-dpdhQeiUPC6mx4dH7L738g-1; Thu, 20 Jul 2023 14:15:11 -0400
X-MC-Unique: dpdhQeiUPC6mx4dH7L738g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D39B8F1840;
 Thu, 20 Jul 2023 18:15:11 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E133C2166B26;
 Thu, 20 Jul 2023 18:15:09 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: yvugenfi@redhat.com,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 si-wei.liu@oracle.com, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Shannon Nelson <snelson@pensando.io>
Subject: [RFC PATCH 05/12] vdpa: add vhost_vdpa_set_vring_ready_internal
Date: Thu, 20 Jul 2023 20:14:52 +0200
Message-Id: <20230720181459.607008-6-eperezma@redhat.com>
In-Reply-To: <20230720181459.607008-1-eperezma@redhat.com>
References: <20230720181459.607008-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
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

Reset a virtqueue reuses this call with .num = 0, so let's make it
possible to use that way.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 12 +++++++++---
 hw/virtio/trace-events |  2 +-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index f51f5d9969..e7ab69165c 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -528,19 +528,25 @@ int vhost_vdpa_get_iova_range(int fd, struct vhost_vdpa_iova_range *iova_range)
     return ret < 0 ? -errno : 0;
 }
 
-int vhost_vdpa_set_vring_ready(struct vhost_vdpa *v, unsigned idx)
+static int vhost_vdpa_set_vring_ready_internal(struct vhost_vdpa *v,
+                                               unsigned idx, bool enable)
 {
     struct vhost_dev *dev = v->dev;
     struct vhost_vring_state state = {
         .index = idx,
-        .num = 1,
+        .num = enable,
     };
     int r = vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &state);
 
-    trace_vhost_vdpa_set_vring_ready(dev, idx, r);
+    trace_vhost_vdpa_set_vring_ready(dev, idx, enable, r);
     return r;
 }
 
+int vhost_vdpa_set_vring_ready(struct vhost_vdpa *v, unsigned idx)
+{
+    return vhost_vdpa_set_vring_ready_internal(v, idx, true);
+}
+
 /*
  * The use of this function is for requests that only need to be
  * applied once. Typically such request occurs at the beginning
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 4f6a6ba428..9b90da73af 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -46,7 +46,7 @@ vhost_vdpa_set_features(void *dev, uint64_t features) "dev: %p features: 0x%"PRI
 vhost_vdpa_get_device_id(void *dev, uint32_t device_id) "dev: %p device_id %"PRIu32
 vhost_vdpa_reset_device(void *dev, uint8_t status) "dev: %p status: 0x%"PRIx8
 vhost_vdpa_get_vq_index(void *dev, int idx, int vq_idx) "dev: %p idx: %d vq idx: %d"
-vhost_vdpa_set_vring_ready(void *dev, unsigned i, int r) "dev: %p, idx: %u, r: %d"
+vhost_vdpa_set_vring_ready(void *dev, unsigned i, bool e, int r) "dev: %p, idx: %u, num: %d, r: %d"
 vhost_vdpa_dump_config(void *dev, const char *line) "dev: %p %s"
 vhost_vdpa_set_config(void *dev, uint32_t offset, uint32_t size, uint32_t flags) "dev: %p offset: %"PRIu32" size: %"PRIu32" flags: 0x%"PRIx32
 vhost_vdpa_get_config(void *dev, void *config, uint32_t config_len) "dev: %p config: %p config_len: %"PRIu32
-- 
2.39.3


