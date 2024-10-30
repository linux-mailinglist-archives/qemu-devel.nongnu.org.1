Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA389B63D4
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Oct 2024 14:15:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t68XJ-0002H4-4E; Wed, 30 Oct 2024 09:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1t68XE-0002DV-A0
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 09:14:52 -0400
Received: from mx24.baidu.com ([111.206.215.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1t68XA-0001Hx-JY
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 09:14:52 -0400
To: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
CC: <gaoshiyuan@baidu.com>, <zuoboqun@baidu.com>, <david@redhat.com>,
 <qemu-devel@nongnu.org>, Junjie Mao <junjie.mao@hotmail.com>,
 <wangliang44@baidu.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: [PATCH v3 1/1] virtio-pci: fix memory_region_find for
 VirtIOPCIRegion's MR
Date: Wed, 30 Oct 2024 21:13:24 +0800
Message-ID: <20241030131324.34144-1-gaoshiyuan@baidu.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.127.73.8]
X-ClientProxiedBy: BJHW-Mail-Ex14.internal.baidu.com (10.127.64.37) To
 bjkjy-mail-ex26.internal.baidu.com (172.31.50.42)
X-FEAS-Client-IP: 172.31.51.58
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=111.206.215.185;
 envelope-from=gaoshiyuan@baidu.com; helo=baidu.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Gao Shiyuan <gaoshiyuan@baidu.com>
From:  Gao Shiyuan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

As shown below, if a virtio PCI device is attached under a pci-bridge, the MR
of VirtIOPCIRegion does not belong to any address space. So memory_region_find
cannot be used to search for this MR.

Introduce the virtio-pci and pci_bridge address spaces to solve this problem.

Before:
memory-region: pci_bridge_pci
  0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
    00000000fe840000-00000000fe840fff (prio 1, i/o): virtio-net-pci-msix
      00000000fe840000-00000000fe84003f (prio 0, i/o): msix-table
      00000000fe840800-00000000fe840807 (prio 0, i/o): msix-pba
    0000380000000000-0000380000003fff (prio 1, i/o): virtio-pci
      0000380000000000-0000380000000fff (prio 0, i/o): virtio-pci-common-virtio-net
      0000380000001000-0000380000001fff (prio 0, i/o): virtio-pci-isr-virtio-net
      0000380000002000-0000380000002fff (prio 0, i/o): virtio-pci-device-virtio-net
      0000380000003000-0000380000003fff (prio 0, i/o): virtio-pci-notify-virtio-net

After:
address-space: virtio-pci-cfg-mem-as
  0000380000000000-0000380000003fff (prio 1, i/o): virtio-pci
    0000380000000000-0000380000000fff (prio 0, i/o): virtio-pci-common-virtio-net
    0000380000001000-0000380000001fff (prio 0, i/o): virtio-pci-isr-virtio-net
    0000380000002000-0000380000002fff (prio 0, i/o): virtio-pci-device-virtio-net
    0000380000003000-0000380000003fff (prio 0, i/o): virtio-pci-notify-virtio-net

address-space: pci_bridge_pci_mem
  0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
    00000000fe840000-00000000fe840fff (prio 1, i/o): virtio-net-pci-msix
      00000000fe840000-00000000fe84003f (prio 0, i/o): msix-table
      00000000fe840800-00000000fe840807 (prio 0, i/o): msix-pba
    0000380000000000-0000380000003fff (prio 1, i/o): virtio-pci
      0000380000000000-0000380000000fff (prio 0, i/o): virtio-pci-common-virtio-net
      0000380000001000-0000380000001fff (prio 0, i/o): virtio-pci-isr-virtio-net
      0000380000002000-0000380000002fff (prio 0, i/o): virtio-pci-device-virtio-net
      0000380000003000-0000380000003fff (prio 0, i/o): virtio-pci-notify-virtio-net

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2576
Fixes: ffa8a3e3b2e6 ("virtio-pci: Add lookup subregion of VirtIOPCIRegion MR")
Co-developed-by: Zuo Boqun <zuoboqun@baidu.com>
Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
Co-developed-by: Wang Liang <wangliang44@baidu.com>
Signed-off-by: Wang Liang <wangliang44@baidu.com>
Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
---
 hw/pci/pci_bridge.c                    |  5 ++++
 hw/virtio/virtio-pci.c                 | 10 +++++++
 include/hw/pci/pci_bridge.h            |  2 ++
 include/hw/virtio/virtio-pci.h         |  3 +++
 tests/qtest/fuzz-virtio-balloon-test.c | 37 ++++++++++++++++++++++++++
 tests/qtest/meson.build                |  1 +
 6 files changed, 58 insertions(+)
 create mode 100644 tests/qtest/fuzz-virtio-balloon-test.c

v2 -> v3:
* add qtest for the issue
* fix a bug, only when enable modern_pio, destroy modern_cfg_io_as

v1 -> v2:
* modify commit message
* add address space for port I/O notification config region

diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 6a4e38856d..2c7bb1a525 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -380,9 +380,12 @@ void pci_bridge_initfn(PCIDevice *dev, const char *typename)
     sec_bus->map_irq = br->map_irq ? br->map_irq : pci_swizzle_map_irq_fn;
     sec_bus->address_space_mem = &br->address_space_mem;
     memory_region_init(&br->address_space_mem, OBJECT(br), "pci_bridge_pci", UINT64_MAX);
+    address_space_init(&br->as_mem, &br->address_space_mem,
+                       "pci_bridge_pci_mem");
     sec_bus->address_space_io = &br->address_space_io;
     memory_region_init(&br->address_space_io, OBJECT(br), "pci_bridge_io",
                        4 * GiB);
+    address_space_init(&br->as_io, &br->address_space_io, "pci_bridge_pci_io");
     pci_bridge_region_init(br);
     QLIST_INIT(&sec_bus->child);
     QLIST_INSERT_HEAD(&parent->child, sec_bus, sibling);
@@ -399,6 +402,8 @@ void pci_bridge_exitfn(PCIDevice *pci_dev)
     PCIBridge *s = PCI_BRIDGE(pci_dev);
     assert(QLIST_EMPTY(&s->sec_bus.child));
     QLIST_REMOVE(&s->sec_bus, sibling);
+    address_space_destroy(&s->as_mem);
+    address_space_destroy(&s->as_io);
     pci_bridge_region_del(s, &s->windows);
     pci_bridge_region_cleanup(s, &s->windows);
     /* object_unparent() is called automatically during device deletion */
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 4d832fe845..5d98ceadf5 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2057,6 +2057,8 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
         if (modern_pio) {
             memory_region_init(&proxy->io_bar, OBJECT(proxy),
                                "virtio-pci-io", 0x4);
+            address_space_init(&proxy->modern_cfg_io_as, &proxy->io_bar,
+                               "virtio-pci-cfg-io-as");
 
             pci_register_bar(&proxy->pci_dev, proxy->modern_io_bar_idx,
                              PCI_BASE_ADDRESS_SPACE_IO, &proxy->io_bar);
@@ -2180,6 +2182,9 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
                        /* PCI BAR regions must be powers of 2 */
                        pow2ceil(proxy->notify.offset + proxy->notify.size));
 
+    address_space_init(&proxy->modern_cfg_mem_as, &proxy->modern_bar,
+                       "virtio-pci-cfg-mem-as");
+
     if (proxy->disable_legacy == ON_OFF_AUTO_AUTO) {
         proxy->disable_legacy = pcie_port ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
     }
@@ -2269,12 +2274,17 @@ static void virtio_pci_exit(PCIDevice *pci_dev)
     VirtIOPCIProxy *proxy = VIRTIO_PCI(pci_dev);
     bool pcie_port = pci_bus_is_express(pci_get_bus(pci_dev)) &&
                      !pci_bus_is_root(pci_get_bus(pci_dev));
+    bool modern_pio = proxy->flags & VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY;
 
     msix_uninit_exclusive_bar(pci_dev);
     if (proxy->flags & VIRTIO_PCI_FLAG_AER && pcie_port &&
         pci_is_express(pci_dev)) {
         pcie_aer_exit(pci_dev);
     }
+    address_space_destroy(&proxy->modern_cfg_mem_as);
+    if (modern_pio) {
+        address_space_destroy(&proxy->modern_cfg_io_as);
+    }
 }
 
 static void virtio_pci_reset(DeviceState *qdev)
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index 5cd452115a..bd12fbe4ef 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -72,6 +72,8 @@ struct PCIBridge {
      */
     MemoryRegion address_space_mem;
     MemoryRegion address_space_io;
+    AddressSpace as_mem;
+    AddressSpace as_io;
 
     PCIBridgeWindows windows;
 
diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 9e67ba38c7..971c5fabd4 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -147,6 +147,9 @@ struct VirtIOPCIProxy {
     };
     MemoryRegion modern_bar;
     MemoryRegion io_bar;
+    /* address space for VirtIOPCIRegions */
+    AddressSpace modern_cfg_mem_as;
+    AddressSpace modern_cfg_io_as;
     uint32_t legacy_io_bar_idx;
     uint32_t msix_bar_idx;
     uint32_t modern_io_bar_idx;
diff --git a/tests/qtest/fuzz-virtio-balloon-test.c b/tests/qtest/fuzz-virtio-balloon-test.c
new file mode 100644
index 0000000000..ecb597fbee
--- /dev/null
+++ b/tests/qtest/fuzz-virtio-balloon-test.c
@@ -0,0 +1,37 @@
+/*
+ * QTest fuzzer-generated testcase for virtio balloon device
+ *
+ * Copyright (c) 2024 Gao Shiyuan <gaoshiyuan@baidu.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+/*
+ * https://gitlab.com/qemu-project/qemu/-/issues/2576
+ * Used to trigger:
+ *   virtio_address_space_lookup: Assertion `mrs.mr' failed.
+ */
+static void oss_fuzz_71649(void)
+{
+    QTestState *s = qtest_init("-device virtio-balloon -machine q35"
+                               " -nodefaults");
+
+    qtest_outl(s, 0xcf8, 0x80000890);
+    qtest_outl(s, 0xcfc, 0x2);
+    qtest_outl(s, 0xcf8, 0x80000891);
+    qtest_inl(s, 0xcfc);
+    qtest_quit(s);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("fuzz/virtio/oss_fuzz_71649", oss_fuzz_71649);
+
+    return g_test_run();
+}
+
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index f7a19032f7..0e1924dfec 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -88,6 +88,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_MEGASAS_SCSI_PCI') ? ['fuzz-megasas-test'] : []) +    \
   (config_all_devices.has_key('CONFIG_LSI_SCSI_PCI') ? ['fuzz-lsi53c895a-test'] : []) +     \
   (config_all_devices.has_key('CONFIG_VIRTIO_SCSI') ? ['fuzz-virtio-scsi-test'] : []) +     \
+  (config_all_devices.has_key('CONFIG_VIRTIO_BALLOON') ? ['fuzz-virtio-balloon-test'] : []) + \
   (config_all_devices.has_key('CONFIG_Q35') ? ['q35-test'] : []) +                          \
   (config_all_devices.has_key('CONFIG_SB16') ? ['fuzz-sb16-test'] : []) +                   \
   (config_all_devices.has_key('CONFIG_SDHCI_PCI') ? ['fuzz-sdcard-test'] : []) +            \
-- 
2.34.1


