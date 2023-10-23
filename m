Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 570B67D3D92
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 19:27:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quygO-0005uU-EB; Mon, 23 Oct 2023 13:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1quygM-0005tE-Kk
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 13:25:38 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1quygL-0007gM-19
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 13:25:38 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1quygD-0002s4-1g; Mon, 23 Oct 2023 19:25:29 +0200
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
Subject: [PATCH v8 6/9] qapi: Add query-memory-devices support to hv-balloon
Date: Mon, 23 Oct 2023 19:24:32 +0200
Message-ID: <3b69abd621786fc5fbc27510a7513d4eb061110b.1698064313.git.maciej.szmigiero@oracle.com>
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
index c3e55ef9e9cd..7b06ed35decb 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -247,6 +247,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
     MemoryDeviceInfo *value;
     PCDIMMDeviceInfo *di;
     SgxEPCDeviceInfo *se;
+    HvBalloonDeviceInfo *hi;
 
     for (info = info_list; info; info = info->next) {
         value = info->value;
@@ -304,6 +305,20 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
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
index 4d87f99375b5..c384f23a3b5e 100644
--- a/hw/hyperv/hv-balloon.c
+++ b/hw/hyperv/hv-balloon.c
@@ -1622,6 +1622,31 @@ static MemoryRegion *hv_balloon_md_get_memory_region(MemoryDeviceState *md,
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
@@ -1709,5 +1734,5 @@ static void hv_balloon_class_init(ObjectClass *klass, void *data)
     mdc->get_memory_region = hv_balloon_md_get_memory_region;
     mdc->decide_memslots = hv_balloon_decide_memslots;
     mdc->get_memslots = hv_balloon_get_memslots;
-    /* implement fill_device_info */
+    mdc->fill_device_info = hv_balloon_md_fill_device_info;
 }
diff --git a/qapi/machine.json b/qapi/machine.json
index a08b6576cac6..5ede977cf2bc 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1265,6 +1265,29 @@
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
@@ -1276,10 +1299,13 @@
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
@@ -1313,6 +1339,14 @@
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
@@ -1327,7 +1361,8 @@
             'nvdimm': 'PCDIMMDeviceInfoWrapper',
             'virtio-pmem': 'VirtioPMEMDeviceInfoWrapper',
             'virtio-mem': 'VirtioMEMDeviceInfoWrapper',
-            'sgx-epc': 'SgxEPCDeviceInfoWrapper'
+            'sgx-epc': 'SgxEPCDeviceInfoWrapper',
+            'hv-balloon': 'HvBalloonDeviceInfoWrapper'
           }
 }
 

