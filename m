Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB197E268F
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:23:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00UA-0000wW-84; Mon, 06 Nov 2023 09:21:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1r00U6-0000w0-G5
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:21:46 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1r00U4-0005Yt-RL
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:21:46 -0500
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1r00U3-0000e5-Ii; Mon, 06 Nov 2023 15:21:43 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>
Subject: [PULL 07/10] qapi: Add query-memory-devices support to hv-balloon
Date: Mon,  6 Nov 2023 15:20:51 +0100
Message-ID: <16dff2f9bb877bd1e147b5c5d9966d5a1d336c8c.1699279190.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1699279190.git.maciej.szmigiero@oracle.com>
References: <cover.1699279190.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Used by the driver to report its provided memory state information.

Co-developed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/core/machine-hmp-cmds.c | 15 +++++++++++++++
 hw/hyperv/hv-balloon.c     | 27 +++++++++++++++++++++++++-
 qapi/machine.json          | 39 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index 9a4b59c6f210..a6ff6a487583 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -253,6 +253,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
     MemoryDeviceInfo *value;
     PCDIMMDeviceInfo *di;
     SgxEPCDeviceInfo *se;
+    HvBalloonDeviceInfo *hi;
 
     for (info = info_list; info; info = info->next) {
         value = info->value;
@@ -310,6 +311,20 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
                 monitor_printf(mon, "  node: %" PRId64 "\n", se->node);
                 monitor_printf(mon, "  memdev: %s\n", se->memdev);
                 break;
+            case MEMORY_DEVICE_INFO_KIND_HV_BALLOON:
+                hi = value->u.hv_balloon.data;
+                monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
+                               MemoryDeviceInfoKind_str(value->type),
+                               hi->id ? hi->id : "");
+                if (hi->has_memaddr) {
+                    monitor_printf(mon, "  memaddr: 0x%" PRIx64 "\n",
+                                   hi->memaddr);
+                }
+                monitor_printf(mon, "  max-size: %" PRIu64 "\n", hi->max_size);
+                if (hi->memdev) {
+                    monitor_printf(mon, "  memdev: %s\n", hi->memdev);
+                }
+                break;
             default:
                 g_assert_not_reached();
             }
diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
index 5999f1127d87..44a8d15cc841 100644
--- a/hw/hyperv/hv-balloon.c
+++ b/hw/hyperv/hv-balloon.c
@@ -1625,6 +1625,31 @@ static MemoryRegion *hv_balloon_md_get_memory_region(MemoryDeviceState *md,
     return balloon->mr;
 }
 
+static void hv_balloon_md_fill_device_info(const MemoryDeviceState *md,
+                                           MemoryDeviceInfo *info)
+{
+    HvBalloonDeviceInfo *hi = g_new0(HvBalloonDeviceInfo, 1);
+    const HvBalloon *balloon = HV_BALLOON(md);
+    DeviceState *dev = DEVICE(md);
+
+    if (dev->id) {
+        hi->id = g_strdup(dev->id);
+    }
+
+    if (balloon->hostmem) {
+        hi->memdev = object_get_canonical_path(OBJECT(balloon->hostmem));
+        hi->memaddr = balloon->addr;
+        hi->has_memaddr = true;
+        hi->max_size = memory_region_size(balloon->mr);
+        /* TODO: expose current provided size or something else? */
+    } else {
+        hi->max_size = 0;
+    }
+
+    info->u.hv_balloon.data = hi;
+    info->type = MEMORY_DEVICE_INFO_KIND_HV_BALLOON;
+}
+
 static void hv_balloon_decide_memslots(MemoryDeviceState *md,
                                        unsigned int limit)
 {
@@ -1712,5 +1737,5 @@ static void hv_balloon_class_init(ObjectClass *klass, void *data)
     mdc->get_memory_region = hv_balloon_md_get_memory_region;
     mdc->decide_memslots = hv_balloon_decide_memslots;
     mdc->get_memslots = hv_balloon_get_memslots;
-    /* implement fill_device_info */
+    mdc->fill_device_info = hv_balloon_md_fill_device_info;
 }
diff --git a/qapi/machine.json b/qapi/machine.json
index 6c9d2f6dcffe..2985d043c00d 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1289,6 +1289,29 @@
           }
 }
 
+##
+# @HvBalloonDeviceInfo:
+#
+# hv-balloon provided memory state information
+#
+# @id: device's ID
+#
+# @memaddr: physical address in memory, where device is mapped
+#
+# @max-size: the maximum size of memory that the device can provide
+#
+# @memdev: memory backend linked with device
+#
+# Since: 8.2
+##
+{ 'struct': 'HvBalloonDeviceInfo',
+  'data': { '*id': 'str',
+            '*memaddr': 'size',
+            'max-size': 'size',
+            '*memdev': 'str'
+          }
+}
+
 ##
 # @MemoryDeviceInfoKind:
 #
@@ -1300,10 +1323,13 @@
 #
 # @sgx-epc: since 6.2.
 #
+# @hv-balloon: since 8.2.
+#
 # Since: 2.1
 ##
 { 'enum': 'MemoryDeviceInfoKind',
-  'data': [ 'dimm', 'nvdimm', 'virtio-pmem', 'virtio-mem', 'sgx-epc' ] }
+  'data': [ 'dimm', 'nvdimm', 'virtio-pmem', 'virtio-mem', 'sgx-epc',
+            'hv-balloon' ] }
 
 ##
 # @PCDIMMDeviceInfoWrapper:
@@ -1337,6 +1363,14 @@
 { 'struct': 'SgxEPCDeviceInfoWrapper',
   'data': { 'data': 'SgxEPCDeviceInfo' } }
 
+##
+# @HvBalloonDeviceInfoWrapper:
+#
+# Since: 8.2
+##
+{ 'struct': 'HvBalloonDeviceInfoWrapper',
+  'data': { 'data': 'HvBalloonDeviceInfo' } }
+
 ##
 # @MemoryDeviceInfo:
 #
@@ -1351,7 +1385,8 @@
             'nvdimm': 'PCDIMMDeviceInfoWrapper',
             'virtio-pmem': 'VirtioPMEMDeviceInfoWrapper',
             'virtio-mem': 'VirtioMEMDeviceInfoWrapper',
-            'sgx-epc': 'SgxEPCDeviceInfoWrapper'
+            'sgx-epc': 'SgxEPCDeviceInfoWrapper',
+            'hv-balloon': 'HvBalloonDeviceInfoWrapper'
           }
 }
 

