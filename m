Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D44673D777
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 08:02:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDfEd-0003eo-8z; Mon, 26 Jun 2023 01:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfEU-0003V0-1t; Mon, 26 Jun 2023 01:57:51 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfEQ-0007Sd-9Q; Mon, 26 Jun 2023 01:57:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QqHF34ZdKz4wb5;
 Mon, 26 Jun 2023 15:57:43 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqHF10l1Qz4wb1;
 Mon, 26 Jun 2023 15:57:40 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 16/30] target/ppc: Add SRR1 prefix indication to interrupt
 handlers
Date: Mon, 26 Jun 2023 07:56:33 +0200
Message-ID: <20230626055647.1147743-17-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626055647.1147743-1-clg@kaod.org>
References: <20230626055647.1147743-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

ISA v3.1 introduced prefix instructions. Among the changes, various
synchronous interrupts report whether they were caused by a prefix
instruction in (H)SRR1.

The case of instruction fetch that causes an HDSI due to access of a
process-scoped table faulting on the partition scoped translation is the
tricky one. As with ISIs and HISIs, this does not try to set the prefix
bit because there is no instruction image to be loaded. The HDSI needs
the originating access type to be passed through to the handler to
distinguish this from HDSIs that fault translating process scoped tables
originating from a load or store instruction (in that case the prefix
bit should be provided).

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[ clg: checkpatch issues ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 target/ppc/excp_helper.c | 73 +++++++++++++++++++++++++++++++++++++++-
 target/ppc/mmu-radix64.c | 14 ++++++--
 2 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index a2801f6e6b6a..847f8a33beba 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -28,6 +28,7 @@
 #include "trace.h"
 
 #ifdef CONFIG_TCG
+#include "sysemu/tcg.h"
 #include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
 #endif
@@ -141,7 +142,7 @@ static inline bool insn_need_byteswap(CPUArchState *env)
     return !!(env->msr & ((target_ulong)1 << MSR_LE));
 }
 
-static uint32_t ppc_ldl_code(CPUArchState *env, hwaddr addr)
+static uint32_t ppc_ldl_code(CPUArchState *env, abi_ptr addr)
 {
     uint32_t insn = cpu_ldl_code(env, addr);
 
@@ -1348,6 +1349,72 @@ static bool books_vhyp_handles_hv_excp(PowerPCCPU *cpu)
     return false;
 }
 
+#ifdef CONFIG_TCG
+static bool is_prefix_insn(CPUPPCState *env, uint32_t insn)
+{
+    if (!(env->insns_flags2 & PPC2_ISA310)) {
+        return false;
+    }
+    return ((insn & 0xfc000000) == 0x04000000);
+}
+
+static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
+{
+    CPUPPCState *env = &cpu->env;
+
+    if (!tcg_enabled()) {
+        /*
+         * This does not load instructions and set the prefix bit correctly
+         * for injected interrupts with KVM. That may have to be discovered
+         * and set by the KVM layer before injecting.
+         */
+        return false;
+    }
+
+    switch (excp) {
+    case POWERPC_EXCP_HDSI:
+        /* HDSI PRTABLE_FAULT has the originating access type in error_code */
+        if ((env->spr[SPR_HDSISR] & DSISR_PRTABLE_FAULT) &&
+            (env->error_code == MMU_INST_FETCH)) {
+            /*
+             * Fetch failed due to partition scope translation, so prefix
+             * indication is not relevant (and attempting to load the
+             * instruction at NIP would cause recursive faults with the same
+             * translation).
+             */
+            break;
+        }
+        /* fall through */
+    case POWERPC_EXCP_MCHECK:
+    case POWERPC_EXCP_DSI:
+    case POWERPC_EXCP_DSEG:
+    case POWERPC_EXCP_ALIGN:
+    case POWERPC_EXCP_PROGRAM:
+    case POWERPC_EXCP_FPU:
+    case POWERPC_EXCP_TRACE:
+    case POWERPC_EXCP_HV_EMU:
+    case POWERPC_EXCP_VPU:
+    case POWERPC_EXCP_VSXU:
+    case POWERPC_EXCP_FU:
+    case POWERPC_EXCP_HV_FU: {
+        uint32_t insn = ppc_ldl_code(env, env->nip);
+        if (is_prefix_insn(env, insn)) {
+            return true;
+        }
+        break;
+    }
+    default:
+        break;
+    }
+    return false;
+}
+#else
+static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
+{
+    return false;
+}
+#endif
+
 static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 {
     CPUState *cs = CPU(cpu);
@@ -1395,6 +1462,10 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 
     vector |= env->excp_prefix;
 
+    if (is_prefix_insn_excp(cpu, excp)) {
+        msr |= PPC_BIT(34);
+    }
+
     switch (excp) {
     case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
         if (!FIELD_EX64(env->msr, MSR, ME)) {
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 1fc1ba3ecf22..920084bd8ff2 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -145,6 +145,13 @@ static void ppc_radix64_raise_hsi(PowerPCCPU *cpu, MMUAccessType access_type,
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
 
+    env->error_code = 0;
+    if (cause & DSISR_PRTABLE_FAULT) {
+        /* HDSI PRTABLE_FAULT gets the originating access type in error_code */
+        env->error_code = access_type;
+        access_type = MMU_DATA_LOAD;
+    }
+
     qemu_log_mask(CPU_LOG_MMU, "%s for %s @0x%"VADDR_PRIx" 0x%"
                   HWADDR_PRIx" cause %08x\n",
                   __func__, access_str(access_type),
@@ -166,7 +173,6 @@ static void ppc_radix64_raise_hsi(PowerPCCPU *cpu, MMUAccessType access_type,
         env->spr[SPR_HDSISR] = cause;
         env->spr[SPR_HDAR] = eaddr;
         env->spr[SPR_ASDR] = g_raddr;
-        env->error_code = 0;
         break;
     default:
         g_assert_not_reached();
@@ -369,13 +375,14 @@ static bool validate_pate(PowerPCCPU *cpu, uint64_t lpid, ppc_v3_pate_t *pate)
 }
 
 static int ppc_radix64_partition_scoped_xlate(PowerPCCPU *cpu,
-                                              MMUAccessType access_type,
+                                              MMUAccessType orig_access_type,
                                               vaddr eaddr, hwaddr g_raddr,
                                               ppc_v3_pate_t pate,
                                               hwaddr *h_raddr, int *h_prot,
                                               int *h_page_size, bool pde_addr,
                                               int mmu_idx, bool guest_visible)
 {
+    MMUAccessType access_type = orig_access_type;
     int fault_cause = 0;
     hwaddr pte_addr;
     uint64_t pte;
@@ -404,7 +411,8 @@ static int ppc_radix64_partition_scoped_xlate(PowerPCCPU *cpu,
             fault_cause |= DSISR_PRTABLE_FAULT;
         }
         if (guest_visible) {
-            ppc_radix64_raise_hsi(cpu, access_type, eaddr, g_raddr, fault_cause);
+            ppc_radix64_raise_hsi(cpu, orig_access_type,
+                                  eaddr, g_raddr, fault_cause);
         }
         return 1;
     }
-- 
2.41.0


