Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A510D79145F
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:09:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd5ZR-0005gE-T4; Mon, 04 Sep 2023 05:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5ZB-0005PZ-64; Mon, 04 Sep 2023 05:08:19 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Z6-00042s-J3; Mon, 04 Sep 2023 05:08:15 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RfN8V1ZRdz4x2b;
 Mon,  4 Sep 2023 19:08:10 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfN8S2nSxz4x2D;
 Mon,  4 Sep 2023 19:08:08 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Frederic Barrat <fbarrat@linux.ibm.com>
Subject: [PULL 35/35] ppc/xive: Add support for the PC MMIOs
Date: Mon,  4 Sep 2023 11:06:30 +0200
Message-ID: <20230904090630.725952-36-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904090630.725952-1-clg@kaod.org>
References: <20230904090630.725952-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=kZzc=EU=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

The XIVE interrupt contoller maintains various fields on interrupt
targets in a structure called NVT. Each unit has a NVT cache, backed
by RAM.

When the NVT structure is not local (in RAM) to the chip, the XIVE
interrupt controller forwards the memory operation to the owning chip
using the PC MMIO region configured for this purpose. QEMU does not
need to be so precise since software shouldn't perform any of these
operations. The model implementation is simplified to return the RAM
address of the NVT structure which is then used by pnv_xive_vst_write
or read to perform the operation in RAM.

Remove the last use of pnv_xive_get_remote().

Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/intc/pnv_xive.c | 84 ++++++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 36 deletions(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index aae5cb6f607b..9b10e905195a 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -84,28 +84,6 @@ static uint8_t pnv_xive_block_id(PnvXive *xive)
     return blk;
 }
 
-/*
- * Remote access to controllers. HW uses MMIOs. For now, a simple scan
- * of the chips is good enough.
- *
- * TODO: Block scope support
- */
-static PnvXive *pnv_xive_get_remote(uint8_t blk)
-{
-    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
-    int i;
-
-    for (i = 0; i < pnv->num_chips; i++) {
-        Pnv9Chip *chip9 = PNV9_CHIP(pnv->chips[i]);
-        PnvXive *xive = &chip9->xive;
-
-        if (pnv_xive_block_id(xive) == blk) {
-            return xive;
-        }
-    }
-    return NULL;
-}
-
 /*
  * VST accessors for SBE, EAT, ENDT, NVT
  *
@@ -209,6 +187,42 @@ static uint64_t pnv_xive_vst_addr_indirect(PnvXive *xive, uint32_t type,
     return pnv_xive_vst_addr_direct(xive, type, vsd, (idx % vst_per_page));
 }
 
+/*
+ * This is a simplified model of operation forwarding on a remote IC.
+ *
+ * A PC MMIO address is built to identify the NVT structure. The load
+ * on the remote IC will return the address of the structure in RAM,
+ * which will then be used by pnv_xive_vst_write/read to perform the
+ * RAM operation.
+ */
+static uint64_t pnv_xive_vst_addr_remote(PnvXive *xive, uint32_t type,
+                                         uint64_t vsd, uint8_t blk,
+                                         uint32_t idx)
+{
+    const XiveVstInfo *info = &vst_infos[type];
+    uint64_t remote_addr = vsd & VSD_ADDRESS_MASK;
+    uint64_t vst_addr;
+    MemTxResult result;
+
+    if (type != VST_TSEL_VPDT) {
+        xive_error(xive, "VST: invalid access on remote VST %s %x/%x !?",
+                   info->name, blk, idx);
+        return 0;
+    }
+
+    remote_addr |= idx << xive->pc_shift;
+
+    vst_addr = address_space_ldq_be(&address_space_memory, remote_addr,
+                                    MEMTXATTRS_UNSPECIFIED, &result);
+    if (result != MEMTX_OK) {
+        xive_error(xive, "VST: read failed at @0x%"  HWADDR_PRIx
+                   " for NVT %x/%x\n", remote_addr, blk, idx);
+        return 0;
+    }
+
+    return vst_addr;
+}
+
 static uint64_t pnv_xive_vst_addr(PnvXive *xive, uint32_t type, uint8_t blk,
                                   uint32_t idx)
 {
@@ -225,14 +239,7 @@ static uint64_t pnv_xive_vst_addr(PnvXive *xive, uint32_t type, uint8_t blk,
 
     /* Remote VST access */
     if (GETFIELD(VSD_MODE, vsd) == VSD_MODE_FORWARD) {
-        if (type != VST_TSEL_VPDT) {
-            xive_error(xive, "VST: invalid access on remote VST %s %x/%x !?",
-                       info->name, blk, idx);
-            return 0;
-        }
-        xive = pnv_xive_get_remote(blk);
-
-        return xive ? pnv_xive_vst_addr(xive, type, blk, idx) : 0;
+        return pnv_xive_vst_addr_remote(xive, type, vsd, blk, idx);
     }
 
     if (VSD_INDIRECT & vsd) {
@@ -1785,16 +1792,20 @@ static const MemoryRegionOps pnv_xive_vc_ops = {
 };
 
 /*
- * Presenter Controller MMIO region. The Virtualization Controller
- * updates the IPB in the NVT table when required. Not modeled.
+ * Presenter Controller MMIO region. Points to the NVT sets.
+ *
+ * HW implements all possible mem ops to the underlying NVT structure
+ * but QEMU does not need to be so precise. The model implementation
+ * simply returns the RAM address of the NVT structure which is then
+ * used by pnv_xive_vst_write/read to perform the RAM operation.
  */
-static uint64_t pnv_xive_pc_read(void *opaque, hwaddr addr,
-                                 unsigned size)
+static uint64_t pnv_xive_pc_read(void *opaque, hwaddr offset, unsigned size)
 {
     PnvXive *xive = PNV_XIVE(opaque);
+    uint32_t nvt_idx = offset >> xive->pc_shift;
+    uint8_t blk = pnv_xive_block_id(xive); /* TODO: VDT -> block xlate */
 
-    xive_error(xive, "PC: invalid read @%"HWADDR_PRIx, addr);
-    return -1;
+    return pnv_xive_vst_addr(xive, VST_TSEL_VPDT, blk, nvt_idx);
 }
 
 static void pnv_xive_pc_write(void *opaque, hwaddr addr,
@@ -2016,6 +2027,7 @@ static void pnv_xive_realize(DeviceState *dev, Error **errp)
     /* Presenter Controller MMIO region (not modeled) */
     memory_region_init_io(&xive->pc_mmio, OBJECT(xive), &pnv_xive_pc_ops, xive,
                           "xive-pc", PNV9_XIVE_PC_SIZE);
+    xive->pc_mmio.disable_reentrancy_guard = true;
 
     /* Thread Interrupt Management Area (Direct) */
     memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &pnv_xive_tm_ops,
-- 
2.41.0


