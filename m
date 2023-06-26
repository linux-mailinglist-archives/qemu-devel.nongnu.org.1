Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9908D73D796
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 08:09:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDfFD-0004hb-Hl; Mon, 26 Jun 2023 01:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfEP-0003Qh-83; Mon, 26 Jun 2023 01:57:49 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfEN-0007Qx-CP; Mon, 26 Jun 2023 01:57:44 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QqHF03rh1z4wb4;
 Mon, 26 Jun 2023 15:57:40 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqHDy1z6hz4wb1;
 Mon, 26 Jun 2023 15:57:37 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 15/30] target/ppc: Change partition-scope translate interface
Date: Mon, 26 Jun 2023 07:56:32 +0200
Message-ID: <20230626055647.1147743-16-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626055647.1147743-1-clg@kaod.org>
References: <20230626055647.1147743-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

Rather than always performing partition scope page table translation
with access type of 0 (MMU_DATA_LOAD), pass through the processor
access type which first initiated the translation sequence. Process-
scoped page table loads are then set to MMU_DATA_LOAD access type in
the xlate function.

This will allow more information to be passed to the exception
handler in the next patch.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 target/ppc/mmu-radix64.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 031efda0df6a..1fc1ba3ecf22 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -380,6 +380,14 @@ static int ppc_radix64_partition_scoped_xlate(PowerPCCPU *cpu,
     hwaddr pte_addr;
     uint64_t pte;
 
+    if (pde_addr) {
+        /*
+         * Translation of process-scoped tables/directories is performed as
+         * a read-access.
+         */
+        access_type = MMU_DATA_LOAD;
+    }
+
     qemu_log_mask(CPU_LOG_MMU, "%s for %s @0x%"VADDR_PRIx
                   " mmu_idx %u 0x%"HWADDR_PRIx"\n",
                   __func__, access_str(access_type),
@@ -477,10 +485,10 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu,
          * is only used to translate the effective addresses of the
          * process table entries.
          */
-        ret = ppc_radix64_partition_scoped_xlate(cpu, 0, eaddr, prtbe_addr,
-                                                 pate, &h_raddr, &h_prot,
-                                                 &h_page_size, true,
-            /* mmu_idx is 5 because we're translating from hypervisor scope */
+        /* mmu_idx is 5 because we're translating from hypervisor scope */
+        ret = ppc_radix64_partition_scoped_xlate(cpu, access_type, eaddr,
+                                                 prtbe_addr, pate, &h_raddr,
+                                                 &h_prot, &h_page_size, true,
                                                  5, guest_visible);
         if (ret) {
             return ret;
@@ -519,11 +527,11 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu,
          * translation
          */
         do {
-            ret = ppc_radix64_partition_scoped_xlate(cpu, 0, eaddr, pte_addr,
-                                                     pate, &h_raddr, &h_prot,
-                                                     &h_page_size, true,
             /* mmu_idx is 5 because we're translating from hypervisor scope */
-                                                     5, guest_visible);
+            ret = ppc_radix64_partition_scoped_xlate(cpu, access_type, eaddr,
+                                                     pte_addr, pate, &h_raddr,
+                                                     &h_prot, &h_page_size,
+                                                     true, 5, guest_visible);
             if (ret) {
                 return ret;
             }
-- 
2.41.0


