Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59ADC8C07B9
	for <lists+qemu-devel@lfdr.de>; Thu,  9 May 2024 01:37:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4qq4-00045y-Ci; Wed, 08 May 2024 19:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4qq1-0003yj-9p; Wed, 08 May 2024 19:36:41 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4qpy-0002eQ-4I; Wed, 08 May 2024 19:36:39 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 70A5B4E65DB;
 Thu, 09 May 2024 01:36:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id ru5XT7bXWBmO; Thu,  9 May 2024 01:36:34 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7FAA04E65DC; Thu, 09 May 2024 01:36:34 +0200 (CEST)
Message-Id: <bd9c8e004c67c9a681d943c38f768fc095b08ebf.1715209155.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715209155.git.balaton@eik.bme.hu>
References: <cover.1715209155.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 30/33] target/ppc/mmu-hash32.c: Drop a local variable
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 09 May 2024 01:36:34 +0200 (CEST)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

In ppc_hash32_xlate() the value of need_prop is checked in two places
but precalculating it does not help because when we reach the first
check we always return and not reach the second place so the value
will only be used once. We can drop the local variable and calculate
it when needed, which makes these checks using it similar to other
places with such checks.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu-hash32.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 960751a50e..b5d7aeed4e 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -347,7 +347,6 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     hwaddr pte_offset;
     ppc_hash_pte32_t pte;
     int prot;
-    int need_prot;
     hwaddr raddr;
 
     /* There are no hash32 large pages. */
@@ -361,13 +360,11 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
         return true;
     }
 
-    need_prot = prot_for_access_type(access_type);
-
     /* 2. Check Block Address Translation entries (BATs) */
     if (env->nb_BATs != 0) {
         raddr = ppc_hash32_bat_lookup(cpu, eaddr, access_type, protp, mmu_idx);
         if (raddr != -1) {
-            if (need_prot & ~*protp) {
+            if (prot_for_access_type(access_type) & ~*protp) {
                 if (guest_visible) {
                     if (access_type == MMU_INST_FETCH) {
                         cs->exception_index = POWERPC_EXCP_ISI;
@@ -435,7 +432,7 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
 
     prot = ppc_hash32_pte_prot(mmu_idx, sr, pte);
 
-    if (need_prot & ~prot) {
+    if (prot_for_access_type(access_type) & ~prot) {
         /* Access right violation */
         qemu_log_mask(CPU_LOG_MMU, "PTE access rejected\n");
         if (guest_visible) {
-- 
2.30.9


