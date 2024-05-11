Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D3A8C2E93
	for <lists+qemu-devel@lfdr.de>; Sat, 11 May 2024 03:49:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5bp7-0005Am-Q3; Fri, 10 May 2024 21:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5boQ-0004wu-BZ; Fri, 10 May 2024 21:46:11 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5boA-0003Ns-LR; Fri, 10 May 2024 21:46:09 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 456E04E6785;
 Sat, 11 May 2024 03:45:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id kmbr6vQkIwxF; Sat, 11 May 2024 03:45:51 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5508E4E6786; Sat, 11 May 2024 03:45:51 +0200 (CEST)
Message-Id: <7ff8076e04bd8f019e89585927d9c27aea86ed4d.1715390232.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715390232.git.balaton@eik.bme.hu>
References: <cover.1715390232.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v6 12/48] target/ppc/mmu_common.c: Split off real mode cases
 in get_physical_address_wtlb()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Sat, 11 May 2024 03:45:51 +0200 (CEST)
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

The real mode handling is identical in the remaining switch cases.
Split off these common real mode cases into a separate conditional to
leave only the else branches in the switch that are different.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 9f177b6976..b13150ce23 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1172,7 +1172,6 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
                                      MMUAccessType access_type, int type,
                                      int mmu_idx)
 {
-    int ret = -1;
     bool real_mode;
 
     if (env->mmu_model == POWERPC_MMU_BOOKE) {
@@ -1184,38 +1183,23 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
 
     real_mode = (type == ACCESS_CODE) ? !FIELD_EX64(env->msr, MSR, IR)
                                       : !FIELD_EX64(env->msr, MSR, DR);
+    if (real_mode && (env->mmu_model == POWERPC_MMU_SOFT_6xx ||
+                      env->mmu_model == POWERPC_MMU_SOFT_4xx ||
+                      env->mmu_model == POWERPC_MMU_REAL)) {
+        return check_physical(env, ctx, eaddr, access_type);
+    }
 
     switch (env->mmu_model) {
     case POWERPC_MMU_SOFT_6xx:
-        if (real_mode) {
-            ret = check_physical(env, ctx, eaddr, access_type);
-        } else {
-            ret = mmu6xx_get_physical_address(env, ctx, eaddr, access_type,
-                                              type);
-        }
-        break;
-
+        return mmu6xx_get_physical_address(env, ctx, eaddr, access_type, type);
     case POWERPC_MMU_SOFT_4xx:
-        if (real_mode) {
-            ret = check_physical(env, ctx, eaddr, access_type);
-        } else {
-            ret = mmu40x_get_physical_address(env, ctx, eaddr, access_type);
-        }
-        break;
+        return mmu40x_get_physical_address(env, ctx, eaddr, access_type);
     case POWERPC_MMU_REAL:
-        if (real_mode) {
-            ret = check_physical(env, ctx, eaddr, access_type);
-        } else {
-            cpu_abort(env_cpu(env),
-                      "PowerPC in real mode do not do any translation\n");
-        }
-        return -1;
+        cpu_abort(env_cpu(env),
+                  "PowerPC in real mode do not do any translation\n");
     default:
         cpu_abort(env_cpu(env), "Unknown or invalid MMU model\n");
-        return -1;
     }
-
-    return ret;
 }
 
 static void booke206_update_mas_tlb_miss(CPUPPCState *env, target_ulong address,
-- 
2.30.9


