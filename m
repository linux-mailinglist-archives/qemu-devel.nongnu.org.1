Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B12D7CFCEF
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 16:38:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtU7P-0006iw-AB; Thu, 19 Oct 2023 10:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qtU7M-0006i8-HB
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:35:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qtU7J-0000Gd-L2
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697726116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XsIAntQYdWLeT+2YVHjDJvl/kMvjNkLvmgtOnVCusOs=;
 b=SHxXwtzgiKe9U3g/nPxCDye7FK+hPoHnmX96nrzpb1Wo1q5opOOdXkjjAuicosywqDOdRX
 rPmA+BUyC4rmhLUpW6yY+iG+rWnFRkcvgD7wJSeC7kcKIaykwWd6iABZLwn4ra6zco8tVn
 LxO9tR0tA6N0+PgZftV3Y2SB+IUhIvQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-UUXGMxmJMDmHek3QD78Vaw-1; Thu, 19 Oct 2023 10:35:08 -0400
X-MC-Unique: UUXGMxmJMDmHek3QD78Vaw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 324658EB366;
 Thu, 19 Oct 2023 14:35:07 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.192.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 005C9C15BB8;
 Thu, 19 Oct 2023 14:35:04 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Shannon <shannon.nelson@amd.com>, Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, yin31149@gmail.com,
 Jason Wang <jasowang@redhat.com>, Yajun Wu <yajunw@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Lei Yang <leiyang@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, si-wei.liu@oracle.com,
 Gautam Dawar <gdawar@xilinx.com>
Subject: [RFC PATCH 03/18] vdpa: move iova_range to vhost_vdpa_shared
Date: Thu, 19 Oct 2023 16:34:40 +0200
Message-Id: <20231019143455.2377694-4-eperezma@redhat.com>
In-Reply-To: <20231019143455.2377694-1-eperezma@redhat.com>
References: <20231019143455.2377694-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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

Next patches will register the vhost_vdpa memory listener while the VM
is migrating at the destination, so we can map the memory to the device
before stopping the VM at the source.  The main goal is to reduce the
downtime.

However, the destination QEMU is unaware of which vhost_vdpa device will
register its memory_listener.  If the source guest has CVQ enabled, it
will be the CVQ device.  Otherwise, it  will be the first one.

Move the iova range to VhostVDPAShared so all vhost_vdpa can use it,
rather than always in the first or last vhost_vdpa.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h |  3 ++-
 hw/virtio/vdpa-dev.c           |  5 ++++-
 hw/virtio/vhost-vdpa.c         | 16 ++++++++++------
 net/vhost-vdpa.c               | 10 +++++-----
 4 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index ac036055d3..8d52a7e498 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -32,6 +32,8 @@ typedef struct VhostVDPAHostNotifier {
 
 /* Info shared by all vhost_vdpa device models */
 typedef struct vhost_vdpa_shared {
+    struct vhost_vdpa_iova_range iova_range;
+
     /* IOVA mapping used by the Shadow Virtqueue */
     VhostIOVATree *iova_tree;
 } VhostVDPAShared;
@@ -43,7 +45,6 @@ typedef struct vhost_vdpa {
     bool iotlb_batch_begin_sent;
     uint32_t address_space_id;
     MemoryListener listener;
-    struct vhost_vdpa_iova_range iova_range;
     uint64_t acked_features;
     bool shadow_vqs_enabled;
     /* Vdpa must send shadow addresses as IOTLB key for data queues, not GPA */
diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index f22d5d5bc0..457960d28a 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -114,7 +114,8 @@ static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp)
                    strerror(-ret));
         goto free_vqs;
     }
-    v->vdpa.iova_range = iova_range;
+    v->vdpa.shared = g_new0(VhostVDPAShared, 1);
+    v->vdpa.shared->iova_range = iova_range;
 
     ret = vhost_dev_init(&v->dev, &v->vdpa, VHOST_BACKEND_TYPE_VDPA, 0, NULL);
     if (ret < 0) {
@@ -162,6 +163,7 @@ vhost_cleanup:
     vhost_dev_cleanup(&v->dev);
 free_vqs:
     g_free(vqs);
+    g_free(v->vdpa.shared);
 out:
     qemu_close(v->vhostfd);
     v->vhostfd = -1;
@@ -184,6 +186,7 @@ static void vhost_vdpa_device_unrealize(DeviceState *dev)
     g_free(s->config);
     g_free(s->dev.vqs);
     vhost_dev_cleanup(&s->dev);
+    g_free(s->vdpa.shared);
     qemu_close(s->vhostfd);
     s->vhostfd = -1;
 }
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 9cee38cb6d..2bceadd118 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -213,10 +213,10 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     RCU_READ_LOCK_GUARD();
     /* check if RAM section out of device range */
     llend = int128_add(int128_makes64(iotlb->addr_mask), int128_makes64(iova));
-    if (int128_gt(llend, int128_make64(v->iova_range.last))) {
+    if (int128_gt(llend, int128_make64(v->shared->iova_range.last))) {
         error_report("RAM section out of device range (max=0x%" PRIx64
                      ", end addr=0x%" PRIx64 ")",
-                     v->iova_range.last, int128_get64(llend));
+                     v->shared->iova_range.last, int128_get64(llend));
         return;
     }
 
@@ -316,8 +316,10 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
     int page_size = qemu_target_page_size();
     int page_mask = -page_size;
 
-    if (vhost_vdpa_listener_skipped_section(section, v->iova_range.first,
-                                            v->iova_range.last, page_mask)) {
+    if (vhost_vdpa_listener_skipped_section(section,
+                                            v->shared->iova_range.first,
+                                            v->shared->iova_range.last,
+                                            page_mask)) {
         return;
     }
     if (memory_region_is_iommu(section->mr)) {
@@ -403,8 +405,10 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
     int page_size = qemu_target_page_size();
     int page_mask = -page_size;
 
-    if (vhost_vdpa_listener_skipped_section(section, v->iova_range.first,
-                                            v->iova_range.last, page_mask)) {
+    if (vhost_vdpa_listener_skipped_section(section,
+                                            v->shared->iova_range.first,
+                                            v->shared->iova_range.last,
+                                            page_mask)) {
         return;
     }
     if (memory_region_is_iommu(section->mr)) {
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 15e7579b13..9648b0ef7e 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -345,8 +345,8 @@ static void vhost_vdpa_net_data_start_first(VhostVDPAState *s)
 
     add_migration_state_change_notifier(&s->migration_state);
     if (v->shadow_vqs_enabled) {
-        v->shared->iova_tree = vhost_iova_tree_new(v->iova_range.first,
-                                                   v->iova_range.last);
+        v->shared->iova_tree = vhost_iova_tree_new(v->shared->iova_range.first,
+                                                   v->shared->iova_range.last);
     }
 }
 
@@ -581,8 +581,8 @@ out:
      * and it is not worth it for the moment.
      */
     if (!v->shared->iova_tree) {
-        v->shared->iova_tree = vhost_iova_tree_new(v->iova_range.first,
-                                                   v->iova_range.last);
+        v->shared->iova_tree = vhost_iova_tree_new(v->shared->iova_range.first,
+                                                   v->shared->iova_range.last);
     }
 
     r = vhost_vdpa_cvq_map_buf(&s->vhost_vdpa, s->cvq_cmd_out_buffer,
@@ -1455,12 +1455,12 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
     s->always_svq = svq;
     s->migration_state.notify = vdpa_net_migration_state_notifier;
     s->vhost_vdpa.shadow_vqs_enabled = svq;
-    s->vhost_vdpa.iova_range = iova_range;
     s->vhost_vdpa.shadow_data = svq;
     if (queue_pair_index == 0) {
         vhost_vdpa_net_valid_svq_features(features,
                                           &s->vhost_vdpa.migration_blocker);
         s->vhost_vdpa.shared = g_new0(VhostVDPAShared, 1);
+        s->vhost_vdpa.shared->iova_range = iova_range;
     } else if (!is_datapath) {
         s->cvq_cmd_out_buffer = mmap(NULL, vhost_vdpa_net_cvq_cmd_page_len(),
                                      PROT_READ | PROT_WRITE,
-- 
2.39.3


