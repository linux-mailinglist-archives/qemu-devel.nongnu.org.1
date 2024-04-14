Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4D589E9F8
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Apr 2024 07:47:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruQn4-0006Se-1S; Wed, 10 Apr 2024 01:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQmQ-0005Uq-SB; Wed, 10 Apr 2024 01:46:02 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQmO-0001il-Dj; Wed, 10 Apr 2024 01:45:54 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CD94A5D4EA;
 Wed, 10 Apr 2024 08:46:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 92073B0151;
 Wed, 10 Apr 2024 08:44:17 +0300 (MSK)
Received: (nullmailer pid 4182055 invoked by uid 1000);
 Wed, 10 Apr 2024 05:44:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <foss@defmacro.it>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.11 18/41] hw/nvme: add machine compatibility parameter to
 enable msix exclusive bar
Date: Wed, 10 Apr 2024 08:43:39 +0300
Message-Id: <20240410054416.4181891-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.11-20240410084037@cover.tls.msk.ru>
References: <qemu-stable-7.2.11-20240410084037@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Klaus Jensen <k.jensen@samsung.com>

Commit 1901b4967c3f ("hw/block/nvme: move msix table and pba to BAR 0")
moved the MSI-X table and PBA to BAR 0 to make room for enabling CMR and
PMR at the same time. As reported by Julien Grall in #2184, this breaks
migration through system hibernation.

Add a machine compatibility parameter and set it on machines pre 6.0 to
enable the old behavior automatically, restoring the hibernation
migration support.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2184
Fixes: 1901b4967c3f ("hw/block/nvme: move msix table and pba to BAR 0")
Reported-by: Julien Grall julien@xen.org
Tested-by: Julien Grall julien@xen.org
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit fa905f65c5549703279f68c253914799b10ada47)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 19f42450f5..1daaace9a3 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -80,6 +80,7 @@ GlobalProperty hw_compat_5_2[] = {
     { "PIIX4_PM", "smm-compat", "on"},
     { "virtio-blk-device", "report-discard-granularity", "off" },
     { "virtio-net-pci-base", "vectors", "3"},
+    { "nvme", "msix-exclusive-bar", "on"},
 };
 const size_t hw_compat_5_2_len = G_N_ELEMENTS(hw_compat_5_2);
 
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 32df214762..88c40afc28 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7017,6 +7017,11 @@ static bool nvme_check_params(NvmeCtrl *n, Error **errp)
     }
 
     if (n->pmr.dev) {
+        if (params->msix_exclusive_bar) {
+            error_setg(errp, "not enough BARs available to enable PMR");
+            return false;
+        }
+
         if (host_memory_backend_is_mapped(n->pmr.dev)) {
             error_setg(errp, "can't use already busy memdev: %s",
                        object_get_canonical_path_component(OBJECT(n->pmr.dev)));
@@ -7319,24 +7324,38 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
         pcie_ari_init(pci_dev, 0x100, 1);
     }
 
-    /* add one to max_ioqpairs to account for the admin queue pair */
-    bar_size = nvme_mbar_size(n->params.max_ioqpairs + 1, n->params.msix_qsize,
-                              &msix_table_offset, &msix_pba_offset);
+    if (n->params.msix_exclusive_bar && !pci_is_vf(pci_dev)) {
+        bar_size = nvme_mbar_size(n->params.max_ioqpairs + 1, 0, NULL, NULL);
+        memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n, "nvme",
+                              bar_size);
+        pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
+                         PCI_BASE_ADDRESS_MEM_TYPE_64, &n->iomem);
+        ret = msix_init_exclusive_bar(pci_dev, n->params.msix_qsize, 4, errp);
+    } else {
+        assert(n->params.msix_qsize >= 1);
 
-    memory_region_init(&n->bar0, OBJECT(n), "nvme-bar0", bar_size);
-    memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n, "nvme",
-                          msix_table_offset);
-    memory_region_add_subregion(&n->bar0, 0, &n->iomem);
+        /* add one to max_ioqpairs to account for the admin queue pair */
+        bar_size = nvme_mbar_size(n->params.max_ioqpairs + 1,
+                                  n->params.msix_qsize, &msix_table_offset,
+                                  &msix_pba_offset);
 
-    if (pci_is_vf(pci_dev)) {
-        pcie_sriov_vf_register_bar(pci_dev, 0, &n->bar0);
-    } else {
-        pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
-                         PCI_BASE_ADDRESS_MEM_TYPE_64, &n->bar0);
+        memory_region_init(&n->bar0, OBJECT(n), "nvme-bar0", bar_size);
+        memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n, "nvme",
+                              msix_table_offset);
+        memory_region_add_subregion(&n->bar0, 0, &n->iomem);
+
+        if (pci_is_vf(pci_dev)) {
+            pcie_sriov_vf_register_bar(pci_dev, 0, &n->bar0);
+        } else {
+            pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
+                             PCI_BASE_ADDRESS_MEM_TYPE_64, &n->bar0);
+        }
+
+        ret = msix_init(pci_dev, n->params.msix_qsize,
+                        &n->bar0, 0, msix_table_offset,
+                        &n->bar0, 0, msix_pba_offset, 0, errp);
     }
-    ret = msix_init(pci_dev, n->params.msix_qsize,
-                    &n->bar0, 0, msix_table_offset,
-                    &n->bar0, 0, msix_pba_offset, 0, errp);
+
     if (ret == -ENOTSUP) {
         /* report that msix is not supported, but do not error out */
         warn_report_err(*errp);
@@ -7629,6 +7648,8 @@ static Property nvme_props[] = {
                       params.sriov_max_vi_per_vf, 0),
     DEFINE_PROP_UINT8("sriov_max_vq_per_vf", NvmeCtrl,
                       params.sriov_max_vq_per_vf, 0),
+    DEFINE_PROP_BOOL("msix-exclusive-bar", NvmeCtrl, params.msix_exclusive_bar,
+                     false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 7adf042ec3..4d5e42b669 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -427,6 +427,7 @@ typedef struct NvmeParams {
     uint16_t sriov_vi_flexible;
     uint8_t  sriov_max_vq_per_vf;
     uint8_t  sriov_max_vi_per_vf;
+    bool     msix_exclusive_bar;
 } NvmeParams;
 
 typedef struct NvmeCtrl {
-- 
2.39.2


