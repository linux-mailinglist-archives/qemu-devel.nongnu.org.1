Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B76EE7161F0
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:31:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zOE-00005W-Hr; Tue, 30 May 2023 09:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3zMg-0005XA-U5; Tue, 30 May 2023 09:26:24 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3zMZ-0001K9-FQ; Tue, 30 May 2023 09:26:13 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-52cb8e5e9f5so2874976a12.0; 
 Tue, 30 May 2023 06:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685453169; x=1688045169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IjONfP8e90/jbnPjI2B9cUahYDVVk0DhhvwAaHcIujU=;
 b=pMFXi/PwqBbTG59SmJ7y4reRoVeqQ5ShJ7xSCK7xzTwobUl8PHZku8hi55Rgs9BMVs
 jLA9/pVdZ2Q/T6lxEGejuplJtpuAmTCd+LEYXkTaou9XsmD2WvW1yKziujeLhQIzroKp
 l0l4p1qlxq1uTZoadB3v8qEBjr9JlCGtt+iNb5vGy4q/uugugjOJ5c839L2h53sRPnMQ
 XTg2SdA02+M/qe4PC5bHpI5QIImfy/7MRbzyAmEUwRc4k0+WtJJc6JKiCCtb6oQebTem
 e7TqGahyz1skIAfI4BEZUPPBRQy6PF0izV7dnWanusluqZIi4PEqQR+Tw1BYLp8MLSAw
 r5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453169; x=1688045169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IjONfP8e90/jbnPjI2B9cUahYDVVk0DhhvwAaHcIujU=;
 b=T0W2fJWL+lhZFDL2pwUNHh3EyLKChZutGnnbTT5wkMQydr+LR68m+4t8IEabXWSX4n
 dWxb7yXc4Nu97mMcrwPO6CDCxeGb4EjQMTtDzX07pXpS3yk4YNV4QuWFQuNTv86ntceH
 arCn2qJYFaMyTnPV7NJTh4wpQ+vxXybLR6THaCeAc860E00SnpZnSsZKm51ppG/hseyH
 N71l2NAONNZHstUYOHWtXJnVW3E+WZLitm6Qphqgy+TAc9yNHuefMm/uwWU3ZyqK/BfU
 iARfQmI2l8OvjW5eHroks3rM8L+7Tl+Ppfvgwjw9MF67qJAnzxe9vvSWGpU8Z5Ekg/X/
 szsQ==
X-Gm-Message-State: AC+VfDywybvPkil8LRbv4PS97QeNPgyI6Ml9ITYy3KGClkzDNTbbYUXd
 hfM/eWqsv48z6zSZBnCmJaZzEBBke/k=
X-Google-Smtp-Source: ACHHUZ6biXwuqNsww9+1aoSTNNaVpUy3qUPEAPrptjfM6RIusI005Wel4fSXGkL7HBtZam4U+rWW4w==
X-Received: by 2002:a17:90a:e7cc:b0:255:38ed:9dcd with SMTP id
 kb12-20020a17090ae7cc00b0025538ed9dcdmr11685199pjb.0.1685453168912; 
 Tue, 30 May 2023 06:26:08 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 w32-20020a634920000000b0050927cb606asm8601514pga.13.2023.05.30.06.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:26:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v4 3/6] target/ppc: Add SRR1 prefix indication to interrupt
 handlers
Date: Tue, 30 May 2023 23:25:40 +1000
Message-Id: <20230530132543.385138-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530132543.385138-1-npiggin@gmail.com>
References: <20230530132543.385138-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x530.google.com
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
 target/ppc/excp_helper.c | 44 ++++++++++++++++++++++++++++++++++++++++
 target/ppc/mmu-radix64.c | 14 ++++++++++---
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 0274617b4a..b4fcaa1d88 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1348,12 +1348,21 @@ static bool books_vhyp_handles_hv_excp(PowerPCCPU *cpu)
     return false;
 }
 
+static bool is_prefix_excp(CPUPPCState *env, uint32_t insn)
+{
+    if (!(env->insns_flags2 & PPC2_ISA310)) {
+        return false;
+    }
+    return ((insn & 0xfc000000) == 0x04000000);
+}
+
 static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 {
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
     int srr0, srr1, lev = -1;
+    uint32_t insn = 0;
 
     /* new srr1 value excluding must-be-zero bits */
     msr = env->msr & ~0x783f0000ULL;
@@ -1392,6 +1401,41 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 
     vector |= env->excp_prefix;
 
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
+    case POWERPC_EXCP_HV_FU:
+        insn = ppc_ldl_code(env, env->nip);
+        if (is_prefix_excp(env, insn)) {
+            msr |= PPC_BIT(34);
+        }
+        break;
+    default:
+        break;
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


