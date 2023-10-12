Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C677C706E
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:38:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqwoM-0002h3-DN; Thu, 12 Oct 2023 10:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qqwoJ-0002ei-85
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:37:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qqwoH-0005f7-2m
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697121428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ijDnJ7CaGFhNmyr/Xr7jvfHcw5a4QjDOf/HiVcXbz/w=;
 b=Zz0FU2sAoiWg3GOvsVJ8y867fLrASONrwPrDlusULTeCJ6xH5Jpx3nZk+WiJonLorS1Ry5
 oUtjFVClVmfdJ1Q2I0TEPLMl3T3JF4Rcaud2nfyDgw9RB3wYBYXM7zM76sOVYZDgQB9PEF
 IL6/KRNNxVFF4H87nYPIepd9/noM/LY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-79qB7tYtPFe9UcxpSAs75Q-1; Thu, 12 Oct 2023 10:37:03 -0400
X-MC-Unique: 79qB7tYtPFe9UcxpSAs75Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DEBD3823332;
 Thu, 12 Oct 2023 14:37:03 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9365D1C060DF;
 Thu, 12 Oct 2023 14:37:02 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [GIT PULL 05/18] vhost: Return number of free memslots
Date: Thu, 12 Oct 2023 16:36:42 +0200
Message-ID: <20231012143655.114631-6-david@redhat.com>
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

Let's return the number of free slots instead of only checking if there
is a free slot. Required to support memory devices that consume multiple
memslots.

This is a preparation for memory devices that consume multiple memslots.

Message-ID: <20230926185738.277351-6-david@redhat.com>
Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c    | 2 +-
 hw/virtio/vhost-stub.c    | 4 ++--
 hw/virtio/vhost.c         | 4 ++--
 include/hw/virtio/vhost.h | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 98e355c960..e09960744d 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -63,7 +63,7 @@ static void memory_device_check_addable(MachineState *ms, MemoryRegion *mr,
         error_setg(errp, "hypervisor has no free memory slots left");
         return;
     }
-    if (!vhost_has_free_slot()) {
+    if (!vhost_get_free_memslots()) {
         error_setg(errp, "a used vhost backend has no free memory slots left");
         return;
     }
diff --git a/hw/virtio/vhost-stub.c b/hw/virtio/vhost-stub.c
index aa858ef3fb..d53dd9d288 100644
--- a/hw/virtio/vhost-stub.c
+++ b/hw/virtio/vhost-stub.c
@@ -2,9 +2,9 @@
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-user.h"
 
-bool vhost_has_free_slot(void)
+unsigned int vhost_get_free_memslots(void)
 {
-    return true;
+    return UINT_MAX;
 }
 
 bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error **errp)
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 530a65c1b4..82c3d20521 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -54,7 +54,7 @@ static unsigned int used_shared_memslots;
 static QLIST_HEAD(, vhost_dev) vhost_devices =
     QLIST_HEAD_INITIALIZER(vhost_devices);
 
-bool vhost_has_free_slot(void)
+unsigned int vhost_get_free_memslots(void)
 {
     unsigned int free = UINT_MAX;
     struct vhost_dev *hdev;
@@ -71,7 +71,7 @@ bool vhost_has_free_slot(void)
         }
         free = MIN(free, cur_free);
     }
-    return free > 0;
+    return free;
 }
 
 static void vhost_dev_sync_region(struct vhost_dev *dev,
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 6a173cb9fa..603bf834be 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -315,7 +315,7 @@ uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
  */
 void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bits,
                         uint64_t features);
-bool vhost_has_free_slot(void);
+unsigned int vhost_get_free_memslots(void);
 
 int vhost_net_set_backend(struct vhost_dev *hdev,
                           struct vhost_vring_file *file);
-- 
2.41.0


