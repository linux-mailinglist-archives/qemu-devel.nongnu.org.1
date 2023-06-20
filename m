Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CF1736CC7
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 15:12:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBb8g-0007N0-41; Tue, 20 Jun 2023 09:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBb8d-0007Ml-2y; Tue, 20 Jun 2023 09:11:16 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBb8b-0000C8-8x; Tue, 20 Jun 2023 09:11:14 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-66615629689so4102183b3a.2; 
 Tue, 20 Jun 2023 06:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687266671; x=1689858671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tlJWLjigIxCs/9BWhWNpbYBgast/1lf+L/OL3y0vS50=;
 b=Swj9VCBK0z9DEBP0pI8kwzaGIBcamDz7RdmZkuV1Z7UkGfalwggvSznBbqdrgQ5VI6
 xiWbRzEeWza/kLdQFP5kCqXzkphDvokX8zddkDvDe0kKtS6HRmQqM5p1VCIB+AC8cojv
 bWQ3SSu6VpHvSPWV2UP8C0+DUjdR/YOPCXEKtVOkrnVDk9whuBedUVHK2sVTHbGYbqf5
 SCVgto6Yf06kVibsRrxH0AkwbWEj6kNO8L+o+RLmPLoCztKqlyM5K8OLCzFXZbVTjOPd
 WLdN0CeVc85DkYduYz6Hqmo4KeDa72APRKXWQp59qqs9DaNc505TqpHMi6rgKdXJ/Hw/
 TTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687266671; x=1689858671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tlJWLjigIxCs/9BWhWNpbYBgast/1lf+L/OL3y0vS50=;
 b=UILg3+K8DcWYdZBfxZqR6Oo1umRLXZ53s7QIkLVqYOe2fb1VljzFeQfMPqat+imicY
 zdRKeP4mjLiVrqgOFYnMqVVmm/vr5t2mcsSI97k+E59bOYMKlm5oOWeGtnQz/D792n7k
 yMDsxZnKBQ9xSkw2jqUdfbU1H4lnFxGh3LFyEwnT0mhAUweC6+51bDwwLl5FLLcPSzKQ
 kxYkx75EgnwXdF+vTWwgrYJLHsUhDaEE6WD8RS7X8FEJttg2CYszys5scXp95PEPJCo9
 iE+iHQg2HyNloHVwpTx36PGzJCnKVcK14PK9praMVglc4EyZadVN5DgMq7SJmz2qFTs5
 4RbA==
X-Gm-Message-State: AC+VfDwY8Dj48NBAApXM4C8HsATBuZEcwLiQvEvuwjxYnh2SAl4T8BH5
 t+cbkzYpKT343GJT+oGJe3/7lpIdzes=
X-Google-Smtp-Source: ACHHUZ60BUPS9H7Q4X96B5QcFlKNZ8qRbcJu7DhLRgVdeM5ez/3DFLhwy1JHbGvvh432jeGT3MxQMg==
X-Received: by 2002:a05:6a00:1496:b0:668:82c5:ff75 with SMTP id
 v22-20020a056a00149600b0066882c5ff75mr5490368pfu.28.1687266670876; 
 Tue, 20 Jun 2023 06:11:10 -0700 (PDT)
Received: from wheely.local0.net ([124.170.190.103])
 by smtp.gmail.com with ESMTPSA id
 w5-20020aa78585000000b00652a72b89d1sm1353285pfn.170.2023.06.20.06.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 06:11:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 3/4] target/ppc: Add SRR1 prefix indication to interrupt
 handlers
Date: Tue, 20 Jun 2023 23:10:43 +1000
Message-Id: <20230620131044.169110-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620131044.169110-1-npiggin@gmail.com>
References: <20230620131044.169110-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
---
 target/ppc/excp_helper.c | 73 +++++++++++++++++++++++++++++++++++++++-
 target/ppc/mmu-radix64.c | 14 ++++++--
 2 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index a2801f6e6b..1de6ea3f03 100644
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
+	 * This does not load instructions and set the prefix bit correctly
+	 * for injected interrupts with KVM. That may have to be discovered
+	 * and set by the KVM layer before injecting.
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
index 1fc1ba3ecf..920084bd8f 100644
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
2.40.1


