Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C3670DA42
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:20:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1P4V-0008BA-D6; Tue, 23 May 2023 06:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P4M-0007Nz-3w; Tue, 23 May 2023 06:16:42 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P4K-000235-4o; Tue, 23 May 2023 06:16:41 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 00D6D7D02;
 Tue, 23 May 2023 13:15:53 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3B61B7292;
 Tue, 23 May 2023 13:15:52 +0300 (MSK)
Received: (nullmailer pid 85538 invoked by uid 1000);
 Tue, 23 May 2023 10:15:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.1 52/59] hw/pci: Disable PCI_ERR_UNCOR_MASK register for
 machine type < 8.0
Date: Tue, 23 May 2023 13:15:12 +0300
Message-Id: <20230523101536.85424-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.1-20230523131351@cover.tls.msk.ru>
References: <qemu-stable-8.0.1-20230523131351@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Leonardo Bras <leobras@redhat.com>

Since it's implementation on v8.0.0-rc0, having the PCI_ERR_UNCOR_MASK
set for machine types < 8.0 will cause migration to fail if the target
QEMU version is < 8.0.0 :

qemu-system-x86_64: get_pci_config_device: Bad config data: i=0x10a read: 40 device: 0 cmask: ff wmask: 0 w1cmask:0
qemu-system-x86_64: Failed to load PCIDevice:config
qemu-system-x86_64: Failed to load e1000e:parent_obj
qemu-system-x86_64: error while loading state for instance 0x0 of device '0000:00:02.0/e1000e'
qemu-system-x86_64: load of migration failed: Invalid argument

The above test migrated a 7.2 machine type from QEMU master to QEMU 7.2.0,
with this cmdline:

./qemu-system-x86_64 -M pc-q35-7.2 [-incoming XXX]

In order to fix this, property x-pcie-err-unc-mask was introduced to
control when PCI_ERR_UNCOR_MASK is enabled. This property is enabled by
default, but is disabled if machine type <= 7.2.

Fixes: 010746ae1d ("hw/pci/aer: Implement PCI_ERR_UNCOR_MASK register")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Leonardo Bras <leobras@redhat.com>
Message-Id: <20230503002701.854329-1-leobras@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1576
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 5ed3dabe57dd9f4c007404345e5f5bf0e347317f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/core/machine.c b/hw/core/machine.c
index cd13b8b0a3..5060119952 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -43,6 +43,7 @@ GlobalProperty hw_compat_7_2[] = {
     { "e1000e", "migrate-timadj", "off" },
     { "virtio-mem", "x-early-migration", "false" },
     { "migration", "x-preempt-pre-7-2", "true" },
+    { TYPE_PCI_DEVICE, "x-pcie-err-unc-mask", "off" },
 };
 const size_t hw_compat_7_2_len = G_N_ELEMENTS(hw_compat_7_2);
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index def5000e7b..8ad4349e96 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -79,6 +79,8 @@ static Property pci_props[] = {
     DEFINE_PROP_STRING("failover_pair_id", PCIDevice,
                        failover_pair_id),
     DEFINE_PROP_UINT32("acpi-index",  PCIDevice, acpi_index, 0),
+    DEFINE_PROP_BIT("x-pcie-err-unc-mask", PCIDevice, cap_present,
+                    QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index 103667c368..374d593ead 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -112,10 +112,13 @@ int pcie_aer_init(PCIDevice *dev, uint8_t cap_ver, uint16_t offset,
 
     pci_set_long(dev->w1cmask + offset + PCI_ERR_UNCOR_STATUS,
                  PCI_ERR_UNC_SUPPORTED);
-    pci_set_long(dev->config + offset + PCI_ERR_UNCOR_MASK,
-                 PCI_ERR_UNC_MASK_DEFAULT);
-    pci_set_long(dev->wmask + offset + PCI_ERR_UNCOR_MASK,
-                 PCI_ERR_UNC_SUPPORTED);
+
+    if (dev->cap_present & QEMU_PCIE_ERR_UNC_MASK) {
+        pci_set_long(dev->config + offset + PCI_ERR_UNCOR_MASK,
+                     PCI_ERR_UNC_MASK_DEFAULT);
+        pci_set_long(dev->wmask + offset + PCI_ERR_UNCOR_MASK,
+                     PCI_ERR_UNC_SUPPORTED);
+    }
 
     pci_set_long(dev->config + offset + PCI_ERR_UNCOR_SEVER,
                  PCI_ERR_UNC_SEVERITY_DEFAULT);
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index d5a40cd058..6dc6742fc4 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -207,6 +207,8 @@ enum {
     QEMU_PCIE_EXTCAP_INIT = (1 << QEMU_PCIE_EXTCAP_INIT_BITNR),
 #define QEMU_PCIE_CXL_BITNR 10
     QEMU_PCIE_CAP_CXL = (1 << QEMU_PCIE_CXL_BITNR),
+#define QEMU_PCIE_ERR_UNC_MASK_BITNR 11
+    QEMU_PCIE_ERR_UNC_MASK = (1 << QEMU_PCIE_ERR_UNC_MASK_BITNR),
 };
 
 typedef struct PCIINTxRoute {
-- 
2.39.2


