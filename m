Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3605B385F8
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Aug 2025 17:14:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHlz-0002bp-9X; Wed, 27 Aug 2025 11:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHjt-0007GP-4g; Wed, 27 Aug 2025 11:07:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHjr-0005XT-6u; Wed, 27 Aug 2025 11:07:04 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3A3AE14C551;
 Wed, 27 Aug 2025 18:02:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 23B5E269859;
 Wed, 27 Aug 2025 18:03:26 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Kowal <kowal@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 41/59] ppc/xive2: Remote VSDs need to match on
 forwarding address
Date: Wed, 27 Aug 2025 18:02:46 +0300
Message-ID: <20250827150323.2694101-41-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Michael Kowal <kowal@linux.ibm.com>

In a multi chip environment there will be remote/forwarded VSDs.  The check
to find a matching INT controller (XIVE) of the remote block number was
checking the INTs chip number.  Block numbers are not tied to a chip number.
The matching remote INT is the one that matches the forwarded VSD address
with VSD types associated MMIO BAR.

Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-5-npiggin@gmail.com
[ clg: Fixed log format in pnv_xive2_get_remote() ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit e8cf73b849879cd93b1d1b5fd3bde79fb42064dc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 0b81dad6ba..92e62b3e5f 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -101,12 +101,10 @@ static uint32_t pnv_xive2_block_id(PnvXive2 *xive)
 }
 
 /*
- * Remote access to controllers. HW uses MMIOs. For now, a simple scan
- * of the chips is good enough.
- *
- * TODO: Block scope support
+ * Remote access to INT controllers. HW uses MMIOs(?). For now, a simple
+ * scan of all the chips INT controller is good enough.
  */
-static PnvXive2 *pnv_xive2_get_remote(uint8_t blk)
+static PnvXive2 *pnv_xive2_get_remote(uint32_t vsd_type, hwaddr fwd_addr)
 {
     PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
     int i;
@@ -115,10 +113,23 @@ static PnvXive2 *pnv_xive2_get_remote(uint8_t blk)
         Pnv10Chip *chip10 = PNV10_CHIP(pnv->chips[i]);
         PnvXive2 *xive = &chip10->xive;
 
-        if (pnv_xive2_block_id(xive) == blk) {
+        /*
+         * Is this the XIVE matching the forwarded VSD address is for this
+         * VSD type
+         */
+        if ((vsd_type == VST_ESB   && fwd_addr == xive->esb_base) ||
+            (vsd_type == VST_END   && fwd_addr == xive->end_base)  ||
+            ((vsd_type == VST_NVP ||
+              vsd_type == VST_NVG) && fwd_addr == xive->nvpg_base) ||
+            (vsd_type == VST_NVC   && fwd_addr == xive->nvc_base)) {
             return xive;
         }
     }
+
+    qemu_log_mask(LOG_GUEST_ERROR,
+                 "XIVE: >>>>> %s vsd_type %u  fwd_addr 0x%"HWADDR_PRIx
+                  " NOT FOUND\n",
+                  __func__, vsd_type, fwd_addr);
     return NULL;
 }
 
@@ -251,8 +262,7 @@ static uint64_t pnv_xive2_vst_addr(PnvXive2 *xive, uint32_t type, uint8_t blk,
 
     /* Remote VST access */
     if (GETFIELD(VSD_MODE, vsd) == VSD_MODE_FORWARD) {
-        xive = pnv_xive2_get_remote(blk);
-
+        xive = pnv_xive2_get_remote(type, (vsd & VSD_ADDRESS_MASK));
         return xive ? pnv_xive2_vst_addr(xive, type, blk, idx) : 0;
     }
 
-- 
2.47.2


