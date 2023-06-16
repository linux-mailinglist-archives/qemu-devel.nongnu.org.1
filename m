Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D23C1732B7F
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 11:28:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA5k1-00053v-N6; Fri, 16 Jun 2023 05:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qA5jz-00053f-Hg
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 05:27:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qA5jx-0000Kj-Vz
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 05:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686907653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+jKODj7ovPHYOHB3eWQPr2rWBGMRtCIVQbyT2++7pqc=;
 b=Q9OOsb7+vzslwdfEESKyrsxZ4679KxdwPnZzI/86ppcvzQEEkZRaSAaILXbhpJ4U9zE5uc
 wVMW0IhUDHMqvRyBZ9eNDnVSVs/o5t17VZCJt4cAmFYPw44ctpt5RzYe7cHe6RqoIzPxh0
 ap8RFGZC9vHVK9+PKbrsKpv+etWpWUk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-_PCBw_ZeMIWlRCKjc7sPpA-1; Fri, 16 Jun 2023 05:27:29 -0400
X-MC-Unique: _PCBw_ZeMIWlRCKjc7sPpA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1ED94811E78;
 Fri, 16 Jun 2023 09:27:29 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.194.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 549471121314;
 Fri, 16 Jun 2023 09:27:26 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Michal Privoznik <mprivozn@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gavin Shan <gshan@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v1 06/15] vhost: Return number of free memslots
Date: Fri, 16 Jun 2023 11:26:45 +0200
Message-Id: <20230616092654.175518-7-david@redhat.com>
In-Reply-To: <20230616092654.175518-1-david@redhat.com>
References: <20230616092654.175518-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Let's return the number of free slots instead of only checking if there
is a free slot. Required to support memory devices that consume multiple
memslots.

This is a preparation for memory devices that consume multiple memslots.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c    | 2 +-
 hw/virtio/vhost-stub.c    | 4 ++--
 hw/virtio/vhost.c         | 4 ++--
 include/hw/virtio/vhost.h | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index cee90d5182..2f19183a25 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -137,7 +137,7 @@ static void memory_device_check_addable(MachineState *ms, MemoryRegion *mr,
         error_setg(errp, "hypervisor has no free memory slots left");
         return;
     }
-    if (!vhost_has_free_slot()) {
+    if (!vhost_get_free_memslots()) {
         error_setg(errp, "a used vhost backend has no free memory slots left");
         return;
     }
diff --git a/hw/virtio/vhost-stub.c b/hw/virtio/vhost-stub.c
index 2722af5580..d77b944cda 100644
--- a/hw/virtio/vhost-stub.c
+++ b/hw/virtio/vhost-stub.c
@@ -7,9 +7,9 @@ unsigned int vhost_get_max_memslots(void)
     return UINT_MAX;
 }
 
-bool vhost_has_free_slot(void)
+unsigned int vhost_get_free_memslots(void)
 {
-    return true;
+    return UINT_MAX;
 }
 
 bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error **errp)
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 5865049484..472ccba4ab 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -67,7 +67,7 @@ unsigned int vhost_get_max_memslots(void)
     return max;
 }
 
-bool vhost_has_free_slot(void)
+unsigned int vhost_get_free_memslots(void)
 {
     unsigned int free = UINT_MAX;
     struct vhost_dev *hdev;
@@ -84,7 +84,7 @@ bool vhost_has_free_slot(void)
         }
         free = MIN(free, cur_free);
     }
-    return free > 0;
+    return free;
 }
 
 static void vhost_dev_sync_region(struct vhost_dev *dev,
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index fb8fdf07f9..7f87fa2661 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -316,7 +316,7 @@ uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
 void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bits,
                         uint64_t features);
 unsigned int vhost_get_max_memslots(void);
-bool vhost_has_free_slot(void);
+unsigned int vhost_get_free_memslots(void);
 
 int vhost_net_set_backend(struct vhost_dev *hdev,
                           struct vhost_vring_file *file);
-- 
2.40.1


