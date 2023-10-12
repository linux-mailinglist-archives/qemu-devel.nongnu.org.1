Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC1F7C706F
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:38:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqwoQ-0002nL-F4; Thu, 12 Oct 2023 10:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qqwoH-0002c5-Qi
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qqwoE-0005eg-PX
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697121423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ao5OtKdbUrU5LNB3xebbci3FGCKjA6rXtHekpWYTt40=;
 b=ZSWVcBBa5m/Q84MfEZ0q5664Eh20tD0hEmW0RuSk13xEAOwMaN9FFFBGVfG+XrfhblUNOz
 m3Q0+/dIy4vsgM73vVHZE51K4f6YqBiFk4qsbNxxi0kNUiBm6Jh3vDywNhH4BydroHrFNH
 pxcNxRFVq5L4YtoqxUz/xyJ6kAan+BE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-Cuhw3Yo4PzWZjHkexHU6BQ-1; Thu, 12 Oct 2023 10:37:01 -0400
X-MC-Unique: Cuhw3Yo4PzWZjHkexHU6BQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E65BA88B7B4
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 14:36:59 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 84C1D1C0653E;
 Thu, 12 Oct 2023 14:36:58 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [GIT PULL 02/18] vhost: Remove vhost_backend_can_merge() callback
Date: Thu, 12 Oct 2023 16:36:39 +0200
Message-ID: <20231012143655.114631-3-david@redhat.com>
In-Reply-To: <20231012143655.114631-1-david@redhat.com>
References: <20231012143655.114631-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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

Checking whether the memory regions are equal is sufficient: if they are
equal, then most certainly the contained fd is equal.

The whole vhost-user memslot handling is suboptimal and overly
complicated. We shouldn't have to lookup a RAM memory regions we got
notified about in vhost_user_get_mr_data() using a host pointer. But that
requires a bigger rework -- especially an alternative vhost_set_mem_table()
backend call that simply consumes MemoryRegionSections.

For now, let's just drop vhost_backend_can_merge().

Message-ID: <20230926185738.277351-3-david@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/vhost-user.c            | 14 --------------
 hw/virtio/vhost-vdpa.c            |  1 -
 hw/virtio/vhost.c                 |  6 +-----
 include/hw/virtio/vhost-backend.h |  4 ----
 4 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 85e99061d3..68eb1f0c99 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2327,19 +2327,6 @@ static int vhost_user_migration_done(struct vhost_dev *dev, char* mac_addr)
     return -ENOTSUP;
 }
 
-static bool vhost_user_can_merge(struct vhost_dev *dev,
-                                 uint64_t start1, uint64_t size1,
-                                 uint64_t start2, uint64_t size2)
-{
-    ram_addr_t offset;
-    int mfd, rfd;
-
-    (void)vhost_user_get_mr_data(start1, &offset, &mfd);
-    (void)vhost_user_get_mr_data(start2, &offset, &rfd);
-
-    return mfd == rfd;
-}
-
 static int vhost_user_net_set_mtu(struct vhost_dev *dev, uint16_t mtu)
 {
     VhostUserMsg msg;
@@ -2886,7 +2873,6 @@ const VhostOps user_ops = {
         .vhost_set_vring_enable = vhost_user_set_vring_enable,
         .vhost_requires_shm_log = vhost_user_requires_shm_log,
         .vhost_migration_done = vhost_user_migration_done,
-        .vhost_backend_can_merge = vhost_user_can_merge,
         .vhost_net_set_mtu = vhost_user_net_set_mtu,
         .vhost_set_iotlb_callback = vhost_user_set_iotlb_callback,
         .vhost_send_device_iotlb_msg = vhost_user_send_device_iotlb_msg,
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 89ff02a999..819b2d811a 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1512,7 +1512,6 @@ const VhostOps vdpa_ops = {
         .vhost_set_config = vhost_vdpa_set_config,
         .vhost_requires_shm_log = NULL,
         .vhost_migration_done = NULL,
-        .vhost_backend_can_merge = NULL,
         .vhost_net_set_mtu = NULL,
         .vhost_set_iotlb_callback = NULL,
         .vhost_send_device_iotlb_msg = NULL,
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 0edd31a7e8..530a65c1b4 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -728,11 +728,7 @@ static void vhost_region_add_section(struct vhost_dev *dev,
             size_t offset = mrs_gpa - prev_gpa_start;
 
             if (prev_host_start + offset == mrs_host &&
-                section->mr == prev_sec->mr &&
-                (!dev->vhost_ops->vhost_backend_can_merge ||
-                 dev->vhost_ops->vhost_backend_can_merge(dev,
-                    mrs_host, mrs_size,
-                    prev_host_start, prev_size))) {
+                section->mr == prev_sec->mr) {
                 uint64_t max_end = MAX(prev_host_end, mrs_host + mrs_size);
                 need_add = false;
                 prev_sec->offset_within_address_space =
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index d4aa635153..96ccc18cd3 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -86,9 +86,6 @@ typedef int (*vhost_set_vring_enable_op)(struct vhost_dev *dev,
 typedef bool (*vhost_requires_shm_log_op)(struct vhost_dev *dev);
 typedef int (*vhost_migration_done_op)(struct vhost_dev *dev,
                                        char *mac_addr);
-typedef bool (*vhost_backend_can_merge_op)(struct vhost_dev *dev,
-                                           uint64_t start1, uint64_t size1,
-                                           uint64_t start2, uint64_t size2);
 typedef int (*vhost_vsock_set_guest_cid_op)(struct vhost_dev *dev,
                                             uint64_t guest_cid);
 typedef int (*vhost_vsock_set_running_op)(struct vhost_dev *dev, int start);
@@ -163,7 +160,6 @@ typedef struct VhostOps {
     vhost_set_vring_enable_op vhost_set_vring_enable;
     vhost_requires_shm_log_op vhost_requires_shm_log;
     vhost_migration_done_op vhost_migration_done;
-    vhost_backend_can_merge_op vhost_backend_can_merge;
     vhost_vsock_set_guest_cid_op vhost_vsock_set_guest_cid;
     vhost_vsock_set_running_op vhost_vsock_set_running;
     vhost_set_iotlb_callback_op vhost_set_iotlb_callback;
-- 
2.41.0


