Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA2979146F
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:10:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd5ZS-0005nR-R0; Mon, 04 Sep 2023 05:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5ZQ-0005Zk-Cq; Mon, 04 Sep 2023 05:08:32 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5ZM-0003xW-S7; Mon, 04 Sep 2023 05:08:32 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RfN8R6BC6z4x2W;
 Mon,  4 Sep 2023 19:08:07 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfN8Q0JJpz4wy9;
 Mon,  4 Sep 2023 19:08:05 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Frederic Barrat <fbarrat@linux.ibm.com>
Subject: [PULL 34/35] ppc/xive: Handle END triggers between chips with MMIOs
Date: Mon,  4 Sep 2023 11:06:29 +0200
Message-ID: <20230904090630.725952-35-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904090630.725952-1-clg@kaod.org>
References: <20230904090630.725952-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=kZzc=EU=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The notify page of the interrupt controller can either be used to
receive trigger events from the HW controllers (PHB, PSI) or to
reroute interrupts between Interrupt Controllers. In which case, the
VSD table is used to determine the address of the notify page of the
remote IC and the store data is forwarded.

Today, our model grabs the remote VSD (EAS, END, NVT) address using
pnv_xive_get_remote() helper. Be more precise and implement remote END
triggers using a store on the remote IC notify page.

We still have a shortcut in the model for the NVT accesses which we
will address later.

Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/intc/pnv_xive_regs.h |  1 +
 hw/intc/pnv_xive.c      | 69 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/hw/intc/pnv_xive_regs.h b/hw/intc/pnv_xive_regs.h
index c78f030c0260..793847638bce 100644
--- a/hw/intc/pnv_xive_regs.h
+++ b/hw/intc/pnv_xive_regs.h
@@ -228,6 +228,7 @@
  *       VSD and is only meant to be used in indirect mode !
  */
 #define VSD_MODE                PPC_BITMASK(0, 1)
+#define  VSD_MODE_INVALID       0
 #define  VSD_MODE_SHARED        1
 #define  VSD_MODE_EXCLUSIVE     2
 #define  VSD_MODE_FORWARD       3
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index b2bafd61b157..aae5cb6f607b 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -225,6 +225,11 @@ static uint64_t pnv_xive_vst_addr(PnvXive *xive, uint32_t type, uint8_t blk,
 
     /* Remote VST access */
     if (GETFIELD(VSD_MODE, vsd) == VSD_MODE_FORWARD) {
+        if (type != VST_TSEL_VPDT) {
+            xive_error(xive, "VST: invalid access on remote VST %s %x/%x !?",
+                       info->name, blk, idx);
+            return 0;
+        }
         xive = pnv_xive_get_remote(blk);
 
         return xive ? pnv_xive_vst_addr(xive, type, blk, idx) : 0;
@@ -294,12 +299,26 @@ static int pnv_xive_vst_write(PnvXive *xive, uint32_t type, uint8_t blk,
 static int pnv_xive_get_end(XiveRouter *xrtr, uint8_t blk, uint32_t idx,
                             XiveEND *end)
 {
+    PnvXive *xive = PNV_XIVE(xrtr);
+
+    if (pnv_xive_block_id(xive) != blk) {
+        xive_error(xive, "VST: END %x/%x is remote !?", blk, idx);
+        return -1;
+    }
+
     return pnv_xive_vst_read(PNV_XIVE(xrtr), VST_TSEL_EQDT, blk, idx, end);
 }
 
 static int pnv_xive_write_end(XiveRouter *xrtr, uint8_t blk, uint32_t idx,
                               XiveEND *end, uint8_t word_number)
 {
+    PnvXive *xive = PNV_XIVE(xrtr);
+
+    if (pnv_xive_block_id(xive) != blk) {
+        xive_error(xive, "VST: END %x/%x is remote !?", blk, idx);
+        return -1;
+    }
+
     return pnv_xive_vst_write(PNV_XIVE(xrtr), VST_TSEL_EQDT, blk, idx, end,
                               word_number);
 }
@@ -1368,6 +1387,50 @@ static const MemoryRegionOps pnv_xive_ic_reg_ops = {
 #define PNV_XIVE_SYNC_PUSH          0xf00 /* Sync push context */
 #define PNV_XIVE_SYNC_VPC           0xf80 /* Sync remove VPC store */
 
+static void pnv_xive_end_notify(XiveRouter *xrtr, XiveEAS *eas)
+{
+    PnvXive *xive = PNV_XIVE(xrtr);
+    uint8_t end_blk = xive_get_field64(EAS_END_BLOCK, eas->w);
+    uint32_t end_idx = xive_get_field64(EAS_END_INDEX, eas->w);
+    uint32_t end_data = xive_get_field64(EAS_END_DATA, eas->w);
+    uint64_t end_vsd = xive->vsds[VST_TSEL_EQDT][end_blk];
+
+    switch (GETFIELD(VSD_MODE, end_vsd)) {
+    case VSD_MODE_EXCLUSIVE:
+        /* Perform the END notification on the local IC. */
+        xive_router_end_notify(xrtr, eas);
+        break;
+
+    case VSD_MODE_FORWARD: {
+        MemTxResult result;
+        uint64_t notif_port = end_vsd & VSD_ADDRESS_MASK;
+        uint64_t data = XIVE_TRIGGER_END | XIVE_TRIGGER_PQ |
+            be64_to_cpu(eas->w);
+
+        /* Forward the store on the remote IC notify page. */
+        address_space_stq_be(&address_space_memory, notif_port, data,
+                             MEMTXATTRS_UNSPECIFIED, &result);
+        if (result != MEMTX_OK) {
+            xive_error(xive, "IC: Forward notif END %x/%x [%x] failed @%"
+                       HWADDR_PRIx, end_blk, end_idx, end_data, notif_port);
+            return;
+        }
+        break;
+    }
+
+    case VSD_MODE_INVALID:
+    default:
+        /* Set FIR */
+        xive_error(xive, "IC: Invalid END VSD for block %x", end_blk);
+        return;
+    }
+}
+
+/*
+ * The notify page can either be used to receive trigger events from
+ * the HW controllers (PHB, PSI) or to reroute interrupts between
+ * Interrupt controllers.
+ */
 static void pnv_xive_ic_hw_trigger(PnvXive *xive, hwaddr addr, uint64_t val)
 {
     uint8_t blk;
@@ -1376,8 +1439,8 @@ static void pnv_xive_ic_hw_trigger(PnvXive *xive, hwaddr addr, uint64_t val)
     trace_pnv_xive_ic_hw_trigger(addr, val);
 
     if (val & XIVE_TRIGGER_END) {
-        xive_error(xive, "IC: END trigger at @0x%"HWADDR_PRIx" data 0x%"PRIx64,
-                   addr, val);
+        val = cpu_to_be64(val);
+        pnv_xive_end_notify(XIVE_ROUTER(xive), (XiveEAS *) &val);
         return;
     }
 
@@ -1917,6 +1980,7 @@ static void pnv_xive_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&xive->ic_notify_mmio, OBJECT(dev),
                           &pnv_xive_ic_notify_ops,
                           xive, "xive-ic-notify", 1 << xive->ic_shift);
+    xive->ic_notify_mmio.disable_reentrancy_guard = true;
 
     /* The Pervasive LSI trigger and EOI pages (not modeled) */
     memory_region_init_io(&xive->ic_lsi_mmio, OBJECT(dev), &pnv_xive_ic_lsi_ops,
@@ -2017,6 +2081,7 @@ static void pnv_xive_class_init(ObjectClass *klass, void *data)
     xrc->get_nvt = pnv_xive_get_nvt;
     xrc->write_nvt = pnv_xive_write_nvt;
     xrc->get_block_id = pnv_xive_get_block_id;
+    xrc->end_notify = pnv_xive_end_notify;
 
     xnc->notify = pnv_xive_notify;
     xpc->match_nvt  = pnv_xive_match_nvt;
-- 
2.41.0


