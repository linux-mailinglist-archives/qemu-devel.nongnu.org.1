Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2FAA13080
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Jan 2025 02:10:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYEOE-0003aY-HT; Wed, 15 Jan 2025 20:09:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=104bc4e84=wilfred.mallawa@wdc.com>)
 id 1tYEOA-0003aC-C3; Wed, 15 Jan 2025 20:09:38 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=104bc4e84=wilfred.mallawa@wdc.com>)
 id 1tYEO7-0004Fs-Nu; Wed, 15 Jan 2025 20:09:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1736989775; x=1768525775;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=J9ozxdGwSbRc+uSjkOcWz3zQbvf4VtjqTXtqt+oOQJc=;
 b=cXGadox85yLG53jFKeBB5is/q+z3h5tkJ5UK4O3UQGLS0Th2KlNSNxww
 h2V0CT4zc0r1P0reyv6ni5UWSJcGJGEuIwowNHTHtmdzeEqSV48qVB9x2
 Xc+O/W+34QM3JkP0yOHehHkfCo6T4NNFsnV6uPi1xJKBicCyemb7FffJV
 d52JF5/b9I662NUaPg719EAa5EgA+gpHSEr0spGAtNzIv03aKErLfFOp9
 2hYQRQsGiJ7NGc48dfgEr6qEXDGiYiQC/Khh2N8XKsAcZ0M/jrFkBLZ8w
 G+oXPsH0sWE7L3kWT1lasp46b58WNcAPL82S+aBI86oxDdHsgHuEFmoOW g==;
X-CSE-ConnectionGUID: iYbHGgIkRmWNQ5YLAo3PbA==
X-CSE-MsgGUID: j1xcfgf6QLy/rONg3ul6MA==
X-IronPort-AV: E=Sophos;i="6.13,207,1732550400"; d="scan'208";a="37059667"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2025 09:09:32 +0800
IronPort-SDR: 67884d72_5tNmTEiehvwU790Bbbo0ZCrq384n9ENOkYAUP6NOOBMGNSc
 SE7L0jwxhg3mAhTzpxHYg9lMNZGlAMiQtwu0/Ow==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 15 Jan 2025 16:06:10 -0800
WDCIronportException: Internal
Received: from unknown (HELO fedora.wdc.com) ([10.225.165.91])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Jan 2025 17:09:26 -0800
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: alistair.francis@wdc.com, kbusch@kernel.org, its@irrelevant.dk,
 foss@defmacro.it, stefanha@redhat.com, fam@euphon.net, philmd@linaro.org,
 kwolf@redhat.com, hreitz@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [RFC v2 3/3] hw/nvme: connect SPDM over NVMe Security Send/Recv
Date: Thu, 16 Jan 2025 11:08:57 +1000
Message-ID: <20250116010856.95115-5-wilfred.mallawa@wdc.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250116010856.95115-2-wilfred.mallawa@wdc.com>
References: <20250116010856.95115-2-wilfred.mallawa@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=104bc4e84=wilfred.mallawa@wdc.com; helo=esa5.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-to:  Wilfred Mallawa <wilfred.mallawa@wdc.com>
From:  Wilfred Mallawa via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This patch extends the existing support we have for NVMe with only DoE
to also add support to SPDM over the NVMe Security Send/Recv commands.

With the new definition of the `spdm-trans` argument, users can specify
`spdm_trans=nvme` or `spdm_trans=doe`. This allows us to select the SPDM
transport respectively. SPDM over the NVMe Security Send/Recv commands
are defined in the DMTF DSP0286.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 docs/specs/spdm.rst         | 10 ++++--
 hw/nvme/ctrl.c              | 62 ++++++++++++++++++++++++++++++-------
 include/hw/pci/pci_device.h |  1 +
 3 files changed, 60 insertions(+), 13 deletions(-)

diff --git a/docs/specs/spdm.rst b/docs/specs/spdm.rst
index f7de080ff0..dd6cfbbd68 100644
--- a/docs/specs/spdm.rst
+++ b/docs/specs/spdm.rst
@@ -98,7 +98,7 @@ Then you can add this to your QEMU command line:
 .. code-block:: shell
 
     -drive file=blknvme,if=none,id=mynvme,format=raw \
-        -device nvme,drive=mynvme,serial=deadbeef,spdm_port=2323
+        -device nvme,drive=mynvme,serial=deadbeef,spdm_port=2323,spdm_trans=doe
 
 At which point QEMU will try to connect to the SPDM server.
 
@@ -113,7 +113,13 @@ of the default. So the entire QEMU command might look like this
         -append "root=/dev/vda console=ttyS0" \
         -net none -nographic \
         -drive file=blknvme,if=none,id=mynvme,format=raw \
-        -device nvme,drive=mynvme,serial=deadbeef,spdm_port=2323
+        -device nvme,drive=mynvme,serial=deadbeef,spdm_port=2323,spdm_trans=doe
+
+The `spdm_trans` argument defines the underlying transport type that is emulated
+by QEMU. For an PCIe NVMe controller, both "doe" and "nvme" are supported. Where,
+"doe" does SPDM transport over the PCIe extended capability Data Object Exchange
+(DOE), and "nvme" uses the NVMe Admin Security Send/Receive commands to
+implement the SPDM transport.
 
 .. _DMTF:
    https://www.dmtf.org/standards/SPDM
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index cc0a0f8bfb..653f364d88 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8742,6 +8742,23 @@ static DOEProtocol doe_spdm_prot[] = {
     { }
 };
 
+static inline uint32_t nvme_get_spdm_trans_type(PCIDevice *pci_dev)
+{
+    if (!pci_dev) {
+        return false;
+    }
+
+    if (!strcmp(pci_dev->spdm_trans, "nvme")) {
+        return SPDM_SOCKET_TRANSPORT_TYPE_NVME;
+    }
+
+    if (!strcmp(pci_dev->spdm_trans, "doe")) {
+        return SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE;
+    }
+
+    return 0;
+}
+
 static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
 {
     ERRP_GUARD();
@@ -8825,19 +8842,31 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
 
     pcie_cap_deverr_init(pci_dev);
 
-    /* DOE Initialisation */
+    /* SPDM Initialisation */
     if (pci_dev->spdm_port) {
-        uint16_t doe_offset = n->params.sriov_max_vfs ?
-                                  PCI_CONFIG_SPACE_SIZE + PCI_ARI_SIZEOF
-                                  : PCI_CONFIG_SPACE_SIZE;
+        switch  (nvme_get_spdm_trans_type(pci_dev)) {
+        case SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE:
+            uint16_t doe_offset = n->params.sriov_max_vfs ?
+                                    PCI_CONFIG_SPACE_SIZE + PCI_ARI_SIZEOF
+                                    : PCI_CONFIG_SPACE_SIZE;
 
-        pcie_doe_init(pci_dev, &pci_dev->doe_spdm, doe_offset,
-                      doe_spdm_prot, true, 0);
+            pcie_doe_init(pci_dev, &pci_dev->doe_spdm, doe_offset,
+                        doe_spdm_prot, true, 0);
 
-        pci_dev->doe_spdm.spdm_socket = spdm_socket_connect(pci_dev->spdm_port,
-                                                            errp);
+            pci_dev->doe_spdm.spdm_socket = spdm_socket_connect(
+                                             pci_dev->spdm_port, errp);
 
-        if (pci_dev->doe_spdm.spdm_socket < 0) {
+            if (pci_dev->doe_spdm.spdm_socket < 0) {
+                return false;
+            }
+            break;
+        case SPDM_SOCKET_TRANSPORT_TYPE_NVME:
+            n->spdm_socket = spdm_socket_connect(pci_dev->spdm_port, errp);
+            if (n->spdm_socket < 0) {
+                return false;
+            }
+            break;
+        default:
             return false;
         }
     }
@@ -9106,11 +9135,17 @@ static void nvme_exit(PCIDevice *pci_dev)
         g_free(n->cmb.buf);
     }
 
+    /* Only one of the `spdm_socket` below would have been setup */
     if (pci_dev->doe_spdm.spdm_socket > 0) {
         spdm_socket_close(pci_dev->doe_spdm.spdm_socket,
                           SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE);
     }
 
+    if (n->spdm_socket > 0) {
+        spdm_socket_close(pci_dev->doe_spdm.spdm_socket,
+                          SPDM_SOCKET_TRANSPORT_TYPE_NVME);
+    }
+
     if (n->pmr.dev) {
         host_memory_backend_set_mapped(n->pmr.dev, false);
     }
@@ -9162,6 +9197,7 @@ static const Property nvme_props[] = {
                      false),
     DEFINE_PROP_UINT16("mqes", NvmeCtrl, params.mqes, 0x7ff),
     DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port, 0),
+    DEFINE_PROP_STRING("spdm_trans", PCIDevice, spdm_trans),
     DEFINE_PROP_BOOL("ctratt.mem", NvmeCtrl, params.ctratt.mem, false),
     DEFINE_PROP_BOOL("atomic.dn", NvmeCtrl, params.atomic_dn, 0),
     DEFINE_PROP_UINT16("atomic.awun", NvmeCtrl, params.atomic_awun, 0),
@@ -9236,7 +9272,9 @@ static void nvme_pci_write_config(PCIDevice *dev, uint32_t address,
 {
     uint16_t old_num_vfs = pcie_sriov_num_vfs(dev);
 
-    if (pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE)) {
+    /* DOE is only initialised if SPDM over DOE is used */
+    if (pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE) &&
+        nvme_get_spdm_trans_type(dev) == SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE) {
         pcie_doe_write_config(&dev->doe_spdm, address, val, len);
     }
     pci_default_write_config(dev, address, val, len);
@@ -9247,7 +9285,9 @@ static void nvme_pci_write_config(PCIDevice *dev, uint32_t address,
 static uint32_t nvme_pci_read_config(PCIDevice *dev, uint32_t address, int len)
 {
     uint32_t val;
-    if (dev->spdm_port && pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE)) {
+
+    if (dev->spdm_port && pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE) &&
+        (nvme_get_spdm_trans_type(dev) == SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE)) {
         if (pcie_doe_read_config(&dev->doe_spdm, address, len, &val)) {
             return val;
         }
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index add208edfa..9ec66809d3 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -160,6 +160,7 @@ struct PCIDevice {
 
     /* SPDM */
     uint16_t spdm_port;
+    char *spdm_trans;
 
     /* DOE */
     DOECap doe_spdm;
-- 
2.48.0


