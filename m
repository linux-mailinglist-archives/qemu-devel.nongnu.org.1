Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D61FA79887C
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 16:22:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qecNE-0001Wz-JP; Fri, 08 Sep 2023 10:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qecNC-0001Tq-93
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qecN9-0001jU-MN
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694182930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pjxTzzi+bUALobF5fcq+ZnLIGXFuzgDZ7k3W7Jwshcc=;
 b=OdQT8gbKAW4zGzvi71Uc07VAh//OskGsEnpAgVFW3oBrTViwprsaNq9dxygSzZwRIJ3GFf
 z0UJ1Dny4HBpx9JZ2Sk8LshVdGT5noLIFWHjCJhAgwpxWpjgdfA0vPf4MKDCLvH9LuLnwF
 /+9kkYXTQ5wJMZ5/GovtuDX4u857KZk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-dAuzfzXiOwKSFnAHbJ0VbQ-1; Fri, 08 Sep 2023 10:22:07 -0400
X-MC-Unique: dAuzfzXiOwKSFnAHbJ0VbQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76A93181C283;
 Fri,  8 Sep 2023 14:22:06 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DBAB2C03295;
 Fri,  8 Sep 2023 14:22:03 +0000 (UTC)
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
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, kvm@vger.kernel.org
Subject: [PATCH v3 09/16] memory-device,
 vhost: Support memory devices that dynamically consume memslots
Date: Fri,  8 Sep 2023 16:21:29 +0200
Message-ID: <20230908142136.403541-10-david@redhat.com>
In-Reply-To: <20230908142136.403541-1-david@redhat.com>
References: <20230908142136.403541-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We want to support memory devices that have a dynamically managed memory
region container as device memory region. This device memory region maps
multiple RAM memory subregions (e.g., aliases to the same RAM memory
region), whereby these subregions can be (un)mapped on demand.

Each RAM subregion will consume a memslot in KVM and vhost, resulting in
such a new device consuming memslots dynamically, and initially usually
0. We already track the number of used vs. required memslots for all
memslots. From that, we can derive the number of reserved memslots that
must not be used otherwise.

The target use case is virtio-mem and the hyper-v balloon, which will
dynamically map aliases to RAM memory region into their device memory
region container.

Properly document what's supported and what's not and extend the vhost
memslot check accordingly.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c         | 29 +++++++++++++++++++++++++++--
 hw/virtio/vhost.c              | 18 ++++++++++++++----
 include/hw/mem/memory-device.h |  7 +++++++
 stubs/memory_device.c          |  5 +++++
 4 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index d37cfbd65d..1b14ba5661 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -62,19 +62,44 @@ static unsigned int memory_device_get_memslots(MemoryDeviceState *md)
     return 1;
 }
 
+/*
+ * Memslots that are reserved by memory devices (required but still reported
+ * as free from KVM / vhost).
+ */
+static unsigned int get_reserved_memslots(MachineState *ms)
+{
+    if (ms->device_memory->used_memslots >
+        ms->device_memory->required_memslots) {
+        /* This is unexpected, and we warned already in the memory notifier. */
+        return 0;
+    }
+    return ms->device_memory->required_memslots -
+           ms->device_memory->used_memslots;
+}
+
+unsigned int memory_devices_get_reserved_memslots(void)
+{
+    if (!current_machine->device_memory) {
+        return 0;
+    }
+    return get_reserved_memslots(current_machine);
+}
+
 static void memory_device_check_addable(MachineState *ms, MemoryDeviceState *md,
                                         MemoryRegion *mr, Error **errp)
 {
     const uint64_t used_region_size = ms->device_memory->used_region_size;
     const uint64_t size = memory_region_size(mr);
     const unsigned int required_memslots = memory_device_get_memslots(md);
+    const unsigned int reserved_memslots = get_reserved_memslots(ms);
 
     /* we will need memory slots for kvm and vhost */
-    if (kvm_enabled() && kvm_get_free_memslots() < required_memslots) {
+    if (kvm_enabled() &&
+        kvm_get_free_memslots() < required_memslots + reserved_memslots) {
         error_setg(errp, "hypervisor has not enough free memory slots left");
         return;
     }
-    if (vhost_get_free_memslots() < required_memslots) {
+    if (vhost_get_free_memslots() < required_memslots + reserved_memslots) {
         error_setg(errp, "a used vhost backend has not enough free memory slots left");
         return;
     }
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 8e84dca246..f7e1ac12a8 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -23,6 +23,7 @@
 #include "qemu/log.h"
 #include "standard-headers/linux/vhost_types.h"
 #include "hw/virtio/virtio-bus.h"
+#include "hw/mem/memory-device.h"
 #include "migration/blocker.h"
 #include "migration/qemu-file-types.h"
 #include "sysemu/dma.h"
@@ -1423,7 +1424,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    Error **errp)
 {
-    unsigned int used;
+    unsigned int used, reserved, limit;
     uint64_t features;
     int i, r, n_initialized_vqs = 0;
 
@@ -1529,9 +1530,18 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     } else {
         used = used_memslots;
     }
-    if (used > hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
-        error_setg(errp, "vhost backend memory slots limit is less"
-                   " than current number of present memory slots");
+    /*
+     * We assume that all reserved memslots actually require a real memslot
+     * in our vhost backend. This might not be true, for example, if the
+     * memslot would be ROM. If ever relevant, we can optimize for that --
+     * but we'll need additional information about the reservations.
+     */
+    reserved = memory_devices_get_reserved_memslots();
+    limit = hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
+    if (used + reserved > limit) {
+        error_setg(errp, "vhost backend memory slots limit (%d) is less"
+                   " than current number of used (%d) and reserved (%d)"
+                   " memory slots for memory devices.", limit, used, reserved);
         r = -EINVAL;
         goto fail_busyloop;
     }
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index b51a579fb9..c7b624da6a 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -46,6 +46,12 @@ typedef struct MemoryDeviceState MemoryDeviceState;
  * single RAM memory region or a memory region container with subregions
  * that are RAM memory regions or aliases to RAM memory regions. Other
  * memory regions or subregions are not supported.
+ *
+ * If the device memory region returned via @get_memory_region is a
+ * memory region container, it's supported to dynamically (un)map subregions
+ * as long as the number of memslots returned by @get_memslots() won't
+ * be exceeded and as long as all memory regions are of the same kind (e.g.,
+ * all RAM or all ROM).
  */
 struct MemoryDeviceClass {
     /* private */
@@ -125,6 +131,7 @@ struct MemoryDeviceClass {
 
 MemoryDeviceInfoList *qmp_memory_device_list(void);
 uint64_t get_plugged_memory_size(void);
+unsigned int memory_devices_get_reserved_memslots(void);
 void memory_device_pre_plug(MemoryDeviceState *md, MachineState *ms,
                             const uint64_t *legacy_align, Error **errp);
 void memory_device_plug(MemoryDeviceState *md, MachineState *ms);
diff --git a/stubs/memory_device.c b/stubs/memory_device.c
index e75cac62dc..318a5d4187 100644
--- a/stubs/memory_device.c
+++ b/stubs/memory_device.c
@@ -10,3 +10,8 @@ uint64_t get_plugged_memory_size(void)
 {
     return (uint64_t)-1;
 }
+
+unsigned int memory_devices_get_reserved_memslots(void)
+{
+    return 0;
+}
-- 
2.41.0


