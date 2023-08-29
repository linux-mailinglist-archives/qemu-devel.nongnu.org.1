Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF4478C797
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 16:33:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qazm7-0007nk-8S; Tue, 29 Aug 2023 10:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=bkLz=EO=kaod.org=clg@ozlabs.org>)
 id 1qazm2-0007fx-RE; Tue, 29 Aug 2023 10:32:54 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=bkLz=EO=kaod.org=clg@ozlabs.org>)
 id 1qazly-0007S2-21; Tue, 29 Aug 2023 10:32:54 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RZqdp2f1dz4wxn;
 Wed, 30 Aug 2023 00:32:46 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RZqdm2Kk3z4wd0;
 Wed, 30 Aug 2023 00:32:44 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 1/4] ppc/xive: Use address_space routines to access the
 machine RAM
Date: Tue, 29 Aug 2023 16:32:33 +0200
Message-ID: <20230829143236.219348-2-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829143236.219348-1-clg@kaod.org>
References: <20230829143236.219348-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=bkLz=EO=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

to log an error in case of bad configuration of the XIVE tables by the FW.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/intc/pnv_xive.c  | 27 +++++++++++++++++++++++----
 hw/intc/pnv_xive2.c | 27 +++++++++++++++++++++++----
 2 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index e536b3ec26e5..b2bafd61b157 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -242,12 +242,20 @@ static int pnv_xive_vst_read(PnvXive *xive, uint32_t type, uint8_t blk,
 {
     const XiveVstInfo *info = &vst_infos[type];
     uint64_t addr = pnv_xive_vst_addr(xive, type, blk, idx);
+    MemTxResult result;
 
     if (!addr) {
         return -1;
     }
 
-    cpu_physical_memory_read(addr, data, info->size);
+    result = address_space_read(&address_space_memory, addr,
+                                MEMTXATTRS_UNSPECIFIED, data,
+                                info->size);
+    if (result != MEMTX_OK) {
+        xive_error(xive, "VST: read failed at @0x%" HWADDR_PRIx
+                   " for VST %s %x/%x\n", addr, info->name, blk, idx);
+        return -1;
+    }
     return 0;
 }
 
@@ -258,16 +266,27 @@ static int pnv_xive_vst_write(PnvXive *xive, uint32_t type, uint8_t blk,
 {
     const XiveVstInfo *info = &vst_infos[type];
     uint64_t addr = pnv_xive_vst_addr(xive, type, blk, idx);
+    MemTxResult result;
 
     if (!addr) {
         return -1;
     }
 
     if (word_number == XIVE_VST_WORD_ALL) {
-        cpu_physical_memory_write(addr, data, info->size);
+        result = address_space_write(&address_space_memory, addr,
+                                     MEMTXATTRS_UNSPECIFIED, data,
+                                     info->size);
     } else {
-        cpu_physical_memory_write(addr + word_number * 4,
-                                  data + word_number * 4, 4);
+        result = address_space_write(&address_space_memory,
+                                     addr + word_number * 4,
+                                     MEMTXATTRS_UNSPECIFIED,
+                                     data + word_number * 4, 4);
+    }
+
+    if (result != MEMTX_OK) {
+        xive_error(xive, "VST: write failed at @0x%" HWADDR_PRIx
+                    "for VST %s %x/%x\n", addr, info->name, blk, idx);
+        return -1;
     }
     return 0;
 }
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index bbb44a533cff..4b8d0a5d8120 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -240,12 +240,20 @@ static int pnv_xive2_vst_read(PnvXive2 *xive, uint32_t type, uint8_t blk,
 {
     const XiveVstInfo *info = &vst_infos[type];
     uint64_t addr = pnv_xive2_vst_addr(xive, type, blk, idx);
+    MemTxResult result;
 
     if (!addr) {
         return -1;
     }
 
-    cpu_physical_memory_read(addr, data, info->size);
+    result = address_space_read(&address_space_memory, addr,
+                                MEMTXATTRS_UNSPECIFIED, data,
+                                info->size);
+    if (result != MEMTX_OK) {
+        xive2_error(xive, "VST: read failed at @0x%" HWADDR_PRIx
+                   " for VST %s %x/%x\n", addr, info->name, blk, idx);
+        return -1;
+    }
     return 0;
 }
 
@@ -256,16 +264,27 @@ static int pnv_xive2_vst_write(PnvXive2 *xive, uint32_t type, uint8_t blk,
 {
     const XiveVstInfo *info = &vst_infos[type];
     uint64_t addr = pnv_xive2_vst_addr(xive, type, blk, idx);
+    MemTxResult result;
 
     if (!addr) {
         return -1;
     }
 
     if (word_number == XIVE_VST_WORD_ALL) {
-        cpu_physical_memory_write(addr, data, info->size);
+        result = address_space_write(&address_space_memory, addr,
+                                     MEMTXATTRS_UNSPECIFIED, data,
+                                     info->size);
     } else {
-        cpu_physical_memory_write(addr + word_number * 4,
-                                  data + word_number * 4, 4);
+        result = address_space_write(&address_space_memory,
+                                     addr + word_number * 4,
+                                     MEMTXATTRS_UNSPECIFIED,
+                                     data + word_number * 4, 4);
+    }
+
+    if (result != MEMTX_OK) {
+        xive2_error(xive, "VST: write failed at @0x%" HWADDR_PRIx
+                   "for VST %s %x/%x\n", addr, info->name, blk, idx);
+        return -1;
     }
     return 0;
 }
-- 
2.41.0


