Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC1F8C3938
	for <lists+qemu-devel@lfdr.de>; Mon, 13 May 2024 01:29:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Ibu-0001Gs-Hm; Sun, 12 May 2024 19:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Ibq-0001F7-NO; Sun, 12 May 2024 19:28:02 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Ibp-0000LH-06; Sun, 12 May 2024 19:28:02 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8062B4E6775;
 Mon, 13 May 2024 01:27:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id rIDf1s9wHB9C; Mon, 13 May 2024 01:27:57 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8AA164E676F; Mon, 13 May 2024 01:27:57 +0200 (CEST)
Message-Id: <8b83d8228a471d9be431114aa0bc449b20c7c351.1715555763.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715555763.git.balaton@eik.bme.hu>
References: <cover.1715555763.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v7 24/61] target/ppc/mmu_common.c: Split off real mode
 handling from get_physical_address_wtlb()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 13 May 2024 01:27:57 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

Add ppc_real_mode_xlate() to handle real mode translation and allow
removing this case from ppc_jumbo_xlate().

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 46 ++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 8599106f75..ab912da821 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1117,23 +1117,12 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
                                      MMUAccessType access_type, int type,
                                      int mmu_idx)
 {
-    bool real_mode = (type == ACCESS_CODE) ? !FIELD_EX64(env->msr, MSR, IR)
-                                           : !FIELD_EX64(env->msr, MSR, DR);
-    if (real_mode) {
-        ctx->raddr = eaddr;
-        ctx->prot = PAGE_RWX;
-        return 0;
-    }
-
     switch (env->mmu_model) {
     case POWERPC_MMU_SOFT_6xx:
         return mmu6xx_get_physical_address(env, ctx, eaddr, access_type, type);
     case POWERPC_MMU_SOFT_4xx:
         return mmu40x_get_physical_address(env, &ctx->raddr, &ctx->prot, eaddr,
                                            access_type);
-    case POWERPC_MMU_REAL:
-        cpu_abort(env_cpu(env),
-                  "PowerPC in real mode do not do any translation\n");
     default:
         cpu_abort(env_cpu(env), "Unknown or invalid MMU model\n");
     }
@@ -1251,6 +1240,24 @@ static bool ppc_booke_xlate(PowerPCCPU *cpu, vaddr eaddr,
     return false;
 }
 
+static bool ppc_real_mode_xlate(PowerPCCPU *cpu, vaddr eaddr,
+                                MMUAccessType access_type,
+                                hwaddr *raddrp, int *psizep, int *protp)
+{
+    CPUPPCState *env = &cpu->env;
+
+    if (access_type == MMU_INST_FETCH ? !FIELD_EX64(env->msr, MSR, IR)
+                                      : !FIELD_EX64(env->msr, MSR, DR)) {
+        *raddrp = eaddr;
+        *protp = PAGE_RWX;
+        *psizep = TARGET_PAGE_BITS;
+        return true;
+    } else if (env->mmu_model == POWERPC_MMU_REAL) {
+        cpu_abort(CPU(cpu), "PowerPC in real mode shold not do translation\n");
+    }
+    return false;
+}
+
 /* Perform address translation */
 /* TODO: Split this by mmu_model. */
 static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
@@ -1264,6 +1271,10 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
     int type;
     int ret;
 
+    if (ppc_real_mode_xlate(cpu, eaddr, access_type, raddrp, psizep, protp)) {
+        return true;
+    }
+
     if (access_type == MMU_INST_FETCH) {
         /* code access */
         type = ACCESS_CODE;
@@ -1303,11 +1314,8 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
                 env->spr[SPR_40x_DEAR] = eaddr;
                 env->spr[SPR_40x_ESR] = 0x00000000;
                 break;
-            case POWERPC_MMU_REAL:
-                cpu_abort(cs, "PowerPC in real mode should never raise "
-                              "any MMU exceptions\n");
             default:
-                cpu_abort(cs, "Unknown or invalid MMU model\n");
+                g_assert_not_reached();
             }
             break;
         case -2:
@@ -1359,11 +1367,8 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
                     env->spr[SPR_40x_ESR] = 0x00000000;
                 }
                 break;
-            case POWERPC_MMU_REAL:
-                cpu_abort(cs, "PowerPC in real mode should never raise "
-                              "any MMU exceptions\n");
             default:
-                cpu_abort(cs, "Unknown or invalid MMU model\n");
+                g_assert_not_reached();
             }
             break;
         case -2:
@@ -1457,6 +1462,9 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     case POWERPC_MMU_BOOKE206:
         return ppc_booke_xlate(cpu, eaddr, access_type, raddrp,
                                psizep, protp, mmu_idx, guest_visible);
+    case POWERPC_MMU_REAL:
+        return ppc_real_mode_xlate(cpu, eaddr, access_type, raddrp, psizep,
+                                   protp);
     case POWERPC_MMU_MPC8xx:
         cpu_abort(env_cpu(&cpu->env), "MPC8xx MMU model is not implemented\n");
     default:
-- 
2.30.9


