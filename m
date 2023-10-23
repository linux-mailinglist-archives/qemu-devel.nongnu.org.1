Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 020BB7D3D81
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 19:26:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quygE-0005jo-VC; Mon, 23 Oct 2023 13:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1quyg4-0005ho-AY
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 13:25:24 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1quyg2-0007Z6-Dy
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 13:25:20 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1quyfm-0002q9-3o; Mon, 23 Oct 2023 19:25:02 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, David Hildenbrand <david@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v8 1/9] memory-device: Support empty memory devices
Date: Mon, 23 Oct 2023 19:24:27 +0200
Message-ID: <bdbaf68649762a06edd0fe05bfcd2af4c91ce68b.1698064312.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1698064312.git.maciej.szmigiero@oracle.com>
References: <cover.1698064312.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: David Hildenbrand <david@redhat.com>

Let's support empty memory devices -- memory devices that don't have a
memory device region in the current configuration. hv-balloon with an
optional memdev is the primary use case.

Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/mem/memory-device.c         | 43 +++++++++++++++++++++++++++++++---
 include/hw/mem/memory-device.h |  7 +++++-
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index ae38f48f1676..db702ccad554 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -20,6 +20,22 @@
 #include "exec/address-spaces.h"
 #include "trace.h"
 
+static bool memory_device_is_empty(const MemoryDeviceState *md)
+{
+    const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
+    Error *local_err = NULL;
+    MemoryRegion *mr;
+
+    /* dropping const here is fine as we don't touch the memory region */
+    mr = mdc->get_memory_region((MemoryDeviceState *)md, &local_err);
+    if (local_err) {
+        /* Not empty, we'll report errors later when ontaining the MR again. */
+        error_free(local_err);
+        return false;
+    }
+    return !mr;
+}
+
 static gint memory_device_addr_sort(gconstpointer a, gconstpointer b)
 {
     const MemoryDeviceState *md_a = MEMORY_DEVICE(a);
@@ -249,6 +265,10 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
         uint64_t next_addr;
         Range tmp;
 
+        if (memory_device_is_empty(md)) {
+            continue;
+        }
+
         range_init_nofail(&tmp, mdc->get_addr(md),
                           memory_device_get_region_size(md, &error_abort));
 
@@ -292,6 +312,7 @@ MemoryDeviceInfoList *qmp_memory_device_list(void)
         const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(item->data);
         MemoryDeviceInfo *info = g_new0(MemoryDeviceInfo, 1);
 
+        /* Let's query infotmation even for empty memory devices. */
         mdc->fill_device_info(md, info);
 
         QAPI_LIST_APPEND(tail, info);
@@ -311,7 +332,7 @@ static int memory_device_plugged_size(Object *obj, void *opaque)
         const MemoryDeviceState *md = MEMORY_DEVICE(obj);
         const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(obj);
 
-        if (dev->realized) {
+        if (dev->realized && !memory_device_is_empty(md)) {
             *size += mdc->get_plugged_size(md, &error_abort);
         }
     }
@@ -337,6 +358,11 @@ void memory_device_pre_plug(MemoryDeviceState *md, MachineState *ms,
     uint64_t addr, align = 0;
     MemoryRegion *mr;
 
+    /* We support empty memory devices even without device memory. */
+    if (memory_device_is_empty(md)) {
+        return;
+    }
+
     if (!ms->device_memory) {
         error_setg(errp, "the configuration is not prepared for memory devices"
                          " (e.g., for memory hotplug), consider specifying the"
@@ -380,10 +406,17 @@ out:
 void memory_device_plug(MemoryDeviceState *md, MachineState *ms)
 {
     const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
-    const unsigned int memslots = memory_device_get_memslots(md);
-    const uint64_t addr = mdc->get_addr(md);
+    unsigned int memslots;
+    uint64_t addr;
     MemoryRegion *mr;
 
+    if (memory_device_is_empty(md)) {
+        return;
+    }
+
+    memslots = memory_device_get_memslots(md);
+    addr = mdc->get_addr(md);
+
     /*
      * We expect that a previous call to memory_device_pre_plug() succeeded, so
      * it can't fail at this point.
@@ -408,6 +441,10 @@ void memory_device_unplug(MemoryDeviceState *md, MachineState *ms)
     const unsigned int memslots = memory_device_get_memslots(md);
     MemoryRegion *mr;
 
+    if (memory_device_is_empty(md)) {
+        return;
+    }
+
     /*
      * We expect that a previous call to memory_device_pre_plug() succeeded, so
      * it can't fail at this point.
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 3354d6c1667e..a1d62cc551ab 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -38,6 +38,10 @@ typedef struct MemoryDeviceState MemoryDeviceState;
  * address in guest physical memory can either be specified explicitly
  * or get assigned automatically.
  *
+ * Some memory device might not own a memory region in certain device
+ * configurations. Such devices can logically get (un)plugged, however,
+ * empty memory devices are mostly ignored by the memory device code.
+ *
  * Conceptually, memory devices only span one memory region. If multiple
  * successive memory regions are used, a covering memory region has to
  * be provided. Scattered memory regions are not supported for single
@@ -91,7 +95,8 @@ struct MemoryDeviceClass {
     uint64_t (*get_plugged_size)(const MemoryDeviceState *md, Error **errp);
 
     /*
-     * Return the memory region of the memory device.
+     * Return the memory region of the memory device. If the device is
+     * completely empty, returns NULL without an error.
      *
      * Called when (un)plugging the memory device, to (un)map the
      * memory region in guest physical memory, but also to detect the

