Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 875F9747352
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:50:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGgPV-0002xK-G5; Tue, 04 Jul 2023 09:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=18er=CW=kaod.org=clg@ozlabs.org>)
 id 1qGgPT-0002we-E9; Tue, 04 Jul 2023 09:49:39 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=18er=CW=kaod.org=clg@ozlabs.org>)
 id 1qGgPR-0006X5-D1; Tue, 04 Jul 2023 09:49:39 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QwPKp42pjz4wxq;
 Tue,  4 Jul 2023 23:49:34 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QwPKm4fhwz4wZw;
 Tue,  4 Jul 2023 23:49:32 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [RFC PATCH 3/4] ppc/pnv: add support for the PC MMIOs
Date: Tue,  4 Jul 2023 15:49:20 +0200
Message-ID: <20230704134921.2626692-4-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704134921.2626692-1-clg@kaod.org>
References: <20230704134921.2626692-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=18er=CW=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Associated with each NVT is a CI page address that is intended for use
by privileged interrupt management code to adjust the backlog counts
of a logical server and interrupt pending buffer for a specific
virtual processor. This backlog count adjustment function is valuable
to avoid extraneous physical interrupts when the hardware accumulates
the backlog count per event queue post while the software handles
multiple event queue entries on a single physical interrupt. Likewise
adjusting the Interrupt Pending Buffer allows a virtual processor to
process event queues of other priorities during one physical interrupt
cycle.

The NVT adjustment is initiated by a store byte (stb) or a double word
load instruction.

For the store byte operations that increment/decrement a backlog count
the value of the data byte is the amount added (counter saturates at
maximum value) / subtracted from the backlog counter (the counter does
not go negative).

For the store byte operations that set/reset an IPB priority bit, the
data byte is ignored.

The load double word operations that target a backlog counter
increment/decrement the backlog count by one count (counter saturates
at maximum value / does not go negative).

Load operations to an IPB return the pre-operation value, while load
operations to a backlog counter return the post-operation value, in
both cases right justified in the double word.

Programs may use the load operations if they need to know when the
operation has completed; this may be accomplished by introducing a
data dependency upon the returned load data. Other operation lengths
(other than store byte and load double word) are not supported –
results are boundedly undefined.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/intc/pnv_xive.c | 85 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 80 insertions(+), 5 deletions(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index b41ab85e01bd..844965cfe281 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1773,17 +1773,92 @@ static uint64_t pnv_xive_pc_read(void *opaque, hwaddr addr,
                                  unsigned size)
 {
     PnvXive *xive = PNV_XIVE(opaque);
+    uint32_t offset = (addr & 0x1F0) >> 4;
+    uint8_t nvt_blk;
+    uint32_t nvt_idx;
+    XiveNVT nvt;
+    uint8_t ipb;
+    uint64_t ret = -1;
 
-    xive_error(xive, "PC: invalid read @%"HWADDR_PRIx, addr);
-    return -1;
+    if (size != 8) {
+        xive_error(xive, "PC: invalid read size %d @%"HWADDR_PRIx"\n",
+                   size, addr);
+        return -1;
+    }
+
+    /* TODO: support multi block */
+    nvt_blk = pnv_xive_block_id(xive);
+    nvt_idx = addr >> TM_SHIFT;
+
+    if (xive_router_get_nvt(XIVE_ROUTER(xive), nvt_blk, nvt_idx, &nvt)) {
+        xive_error(xive, "PC: invalid NVT %x/%x\n", nvt_blk, nvt_idx);
+        return -1;
+    }
+
+    ipb = xive_get_field32(NVT_W4_IPB, nvt.w4);
+
+    switch (offset) {
+    case  0x0 ... 0x7: /* set IBP bit x */
+        ret = ipb;
+        ipb |= 1 << offset;
+        break;
+    case 0x10 ... 0x17: /* reset IBP bit x */
+        ret = ipb;
+        ipb &= ~(1 << (offset - 0x10));
+        break;
+
+    case  0x8 ... 0xF: /* TODO: increment backlog */
+        /* backlog = offset - 0x8; */
+    case 0x18 ... 0x1F: /* TODO: decrement backlog */
+        /* backlog = offset - 0x18; */
+    default:
+        xive_error(xive, "PC: invalid write @%"HWADDR_PRIx"\n", addr);
+    }
+
+    if (ipb != xive_get_field32(NVT_W4_IPB, nvt.w4)) {
+        nvt.w4 = xive_set_field32(NVT_W4_IPB, nvt.w4, ipb);
+        xive_router_write_nvt(XIVE_ROUTER(xive), nvt_blk, nvt_idx, &nvt, 4);
+    }
+
+    return ret;
 }
 
 static void pnv_xive_pc_write(void *opaque, hwaddr addr,
                               uint64_t value, unsigned size)
 {
     PnvXive *xive = PNV_XIVE(opaque);
+    uint32_t offset = (addr & 0x1F0) >> 4;
+    uint8_t nvt_blk;
+    uint32_t nvt_idx;
+    XiveNVT nvt;
+
+    if (size != 1) {
+        xive_error(xive, "PC: invalid write size %d @%"HWADDR_PRIx"\n",
+                   size, addr);
+        return;
+    }
+
+    /* TODO: support multi block */
+    nvt_blk = pnv_xive_block_id(xive);
+    nvt_idx = addr >> TM_SHIFT;
+
+    if (xive_router_get_nvt(XIVE_ROUTER(xive), nvt_blk, nvt_idx, &nvt)) {
+        xive_error(xive, "PC: invalid NVT %x/%x\n", nvt_blk, nvt_idx);
+        return;
+    }
 
-    xive_error(xive, "PC: invalid write to VC @%"HWADDR_PRIx, addr);
+    switch (offset) {
+    case  0x0 ... 0x7: /* ignored */
+    case 0x10 ... 0x17: /* ignored */
+        break;
+
+    case  0x8 ... 0xF: /* TODO: Add to backlog */
+        /* backlog = offset - 0x8; */
+    case 0x18 ... 0x1F: /* TODO: substract to backlog */
+        /* backlog = offset - 0x18; */
+    default:
+        xive_error(xive, "PC: invalid write @%"HWADDR_PRIx"\n", addr);
+    }
 }
 
 static const MemoryRegionOps pnv_xive_pc_ops = {
@@ -1791,11 +1866,11 @@ static const MemoryRegionOps pnv_xive_pc_ops = {
     .write = pnv_xive_pc_write,
     .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
-        .min_access_size = 8,
+        .min_access_size = 1,
         .max_access_size = 8,
     },
     .impl = {
-        .min_access_size = 8,
+        .min_access_size = 1,
         .max_access_size = 8,
     },
 };
-- 
2.41.0


