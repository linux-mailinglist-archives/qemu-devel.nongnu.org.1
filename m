Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0572727AF8
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 11:15:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7BiW-0001ae-Fd; Thu, 08 Jun 2023 05:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q7BiU-0001aG-M1; Thu, 08 Jun 2023 05:14:02 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q7BiS-0005Og-OM; Thu, 08 Jun 2023 05:14:02 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-39a55e5cfc0so303438b6e.3; 
 Thu, 08 Jun 2023 02:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686215639; x=1688807639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pmN3cFMVWbvkqRrXvnAfhQ/wP7K2BbiCBZ4lOxt9qQc=;
 b=Ds/eW7Eu29nlmKkpmjYwozbFgxgTd4raAdMZll7OV+WeAtWEd1QUdRmRvsYZGL0ZUW
 uoXieVxzzU/IN+16AaLfNuqj5NAXFnrTU2mJC5xUJwuMuIKqLbQoZrf84JQ+7fIchJzZ
 1aSiMXjovWMLzdy7Xi7REjTmTl1vrU7UWxGLY7j7TVld4ViwMOFWy7anRZK4PRJXlzj5
 lH1byCyoWo5RSp6S8YkSjKLu37B/qSjtb37HIsWL+fA3H+YRfrgGkB4AmjegPgUaESZl
 puu2dEDlOfZGk1PqPTOl1/ETUCP0ahFIEX/dY6TVb03OK0eZb4Qntepr38YPWDVYw57Z
 81Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686215639; x=1688807639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pmN3cFMVWbvkqRrXvnAfhQ/wP7K2BbiCBZ4lOxt9qQc=;
 b=aPVpHO+lqhJCGGgpHx7V8uLPyerRY+eue3t2iK5LSt8cyN6vKQX4kf38hnbFRu5E2G
 RcqSc3rUkm/G4+QeHT22mFqo2So29QcfsmOnXyGRYXmtRPjl9Y7ri3zseN4HK3Uy7OdO
 T46iOCwYUEdo9uPVQaxS8ry7GS76hrERuTmhCmUR+7WjRk/I/kcwnPgdpd8WbztT6cID
 Ni7jrf0wRjBVY7bZf5YG5Pj+G4ZaZC4y/ozGNBNACmzx0W7Ft6ISP3VcknVhX15/yZGA
 ZntIyFo2krxCGkdTybl+Hf7reThmi0f1EOSa+D5h8HwvQ7UMELXbi79gB/Wov/4jPEz1
 VwkA==
X-Gm-Message-State: AC+VfDxcGz1xmkn15I+PP4Y5v1KuBpS5N+x+OsIVxr4Vaq1okBPD3mBr
 AXeL4WzOvl5jaCEi5L90pHjaNr1kPtg=
X-Google-Smtp-Source: ACHHUZ7tBURINGX3Pw4ejyhYaVSQd9wpzcbtWXSFGTdkb5IuHvjtWxSOuDg04Tv5kLuxg4z5tpZoRQ==
X-Received: by 2002:aca:1c10:0:b0:39c:76ec:9ba8 with SMTP id
 c16-20020aca1c10000000b0039c76ec9ba8mr2442088oic.44.1686215638953; 
 Thu, 08 Jun 2023 02:13:58 -0700 (PDT)
Received: from wheely.local0.net (58-6-224-112.tpgi.com.au. [58.6.224.112])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a17090a5d8b00b002563e8a0225sm823577pji.48.2023.06.08.02.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 02:13:58 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 2/4] ppc/spapr: Add a nested state struct
Date: Thu,  8 Jun 2023 19:13:42 +1000
Message-Id: <20230608091344.88685-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230608091344.88685-1-npiggin@gmail.com>
References: <20230608091344.88685-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x231.google.com
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

Rather than use a copy of CPUPPCState to store the host state while
the environment has been switched to the L2, use a new struct for
this purpose.

Have helper functions to save and load this host state.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_hcall.c            | 150 ++++++++++++++++++++++++--------
 include/hw/ppc/spapr_cpu_core.h |   5 +-
 2 files changed, 115 insertions(+), 40 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 0582b524d1..d5b8d54692 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1546,6 +1546,112 @@ static target_ulong h_copy_tofrom_guest(PowerPCCPU *cpu,
     return H_FUNCTION;
 }
 
+struct nested_ppc_state {
+    uint64_t gpr[32];
+    uint64_t lr;
+    uint64_t ctr;
+    uint64_t cfar;
+    uint64_t msr;
+    uint64_t nip;
+    uint32_t cr;
+
+    uint64_t xer;
+
+    uint64_t lpcr;
+    uint64_t lpidr;
+    uint64_t pidr;
+    uint64_t pcr;
+    uint64_t dpdes;
+    uint64_t hfscr;
+    uint64_t srr0;
+    uint64_t srr1;
+    uint64_t sprg0;
+    uint64_t sprg1;
+    uint64_t sprg2;
+    uint64_t sprg3;
+    uint64_t ppr;
+
+    int64_t tb_offset;
+};
+
+static void nested_save_state(struct nested_ppc_state *save, PowerPCCPU *cpu)
+{
+    CPUPPCState *env = &cpu->env;
+
+    memcpy(save->gpr, env->gpr, sizeof(save->gpr));
+
+    save->lr = env->lr;
+    save->ctr = env->ctr;
+    save->cfar = env->cfar;
+    save->msr = env->msr;
+    save->nip = env->nip;
+
+    save->cr = ppc_get_cr(env);
+    save->xer = cpu_read_xer(env);
+
+    save->lpcr = env->spr[SPR_LPCR];
+    save->lpidr = env->spr[SPR_LPIDR];
+    save->pcr = env->spr[SPR_PCR];
+    save->dpdes = env->spr[SPR_DPDES];
+    save->hfscr = env->spr[SPR_HFSCR];
+    save->srr0 = env->spr[SPR_SRR0];
+    save->srr1 = env->spr[SPR_SRR1];
+    save->sprg0 = env->spr[SPR_SPRG0];
+    save->sprg1 = env->spr[SPR_SPRG1];
+    save->sprg2 = env->spr[SPR_SPRG2];
+    save->sprg3 = env->spr[SPR_SPRG3];
+    save->pidr = env->spr[SPR_BOOKS_PID];
+    save->ppr = env->spr[SPR_PPR];
+
+    save->tb_offset = env->tb_env->tb_offset;
+}
+
+static void nested_load_state(PowerPCCPU *cpu, struct nested_ppc_state *load)
+{
+    CPUState *cs = CPU(cpu);
+    CPUPPCState *env = &cpu->env;
+
+    memcpy(env->gpr, load->gpr, sizeof(env->gpr));
+
+    env->lr = load->lr;
+    env->ctr = load->ctr;
+    env->cfar = load->cfar;
+    env->msr = load->msr;
+    env->nip = load->nip;
+
+    ppc_set_cr(env, load->cr);
+    cpu_write_xer(env, load->xer);
+
+    env->spr[SPR_LPCR] = load->lpcr;
+    env->spr[SPR_LPIDR] = load->lpidr;
+    env->spr[SPR_PCR] = load->pcr;
+    env->spr[SPR_DPDES] = load->dpdes;
+    env->spr[SPR_HFSCR] = load->hfscr;
+    env->spr[SPR_SRR0] = load->srr0;
+    env->spr[SPR_SRR1] = load->srr1;
+    env->spr[SPR_SPRG0] = load->sprg0;
+    env->spr[SPR_SPRG1] = load->sprg1;
+    env->spr[SPR_SPRG2] = load->sprg2;
+    env->spr[SPR_SPRG3] = load->sprg3;
+    env->spr[SPR_BOOKS_PID] = load->pidr;
+    env->spr[SPR_PPR] = load->ppr;
+
+    env->tb_env->tb_offset = load->tb_offset;
+
+    /*
+     * MSR updated, compute hflags and possible interrupts.
+     */
+    hreg_compute_hflags(env);
+    ppc_maybe_interrupt(env);
+
+    /*
+     * Nested HV does not tag TLB entries between L1 and L2, so must
+     * flush on transition.
+     */
+    tlb_flush(cs);
+    env->reserve_addr = -1; /* Reset the reservation */
+}
+
 /*
  * When this handler returns, the environment is switched to the L2 guest
  * and TCG begins running that. spapr_exit_nested() performs the switch from
@@ -1593,12 +1699,14 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
         return H_PARAMETER;
     }
 
-    spapr_cpu->nested_host_state = g_try_new(CPUPPCState, 1);
+    spapr_cpu->nested_host_state = g_try_new(struct nested_ppc_state, 1);
     if (!spapr_cpu->nested_host_state) {
         return H_NO_MEM;
     }
 
-    memcpy(spapr_cpu->nested_host_state, env, sizeof(CPUPPCState));
+    assert(env->spr[SPR_LPIDR] == 0);
+    assert(env->spr[SPR_DPDES] == 0);
+    nested_save_state(spapr_cpu->nested_host_state, cpu);
 
     len = sizeof(*regs);
     regs = address_space_map(CPU(cpu)->as, regs_ptr, &len, false,
@@ -1639,7 +1747,6 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
     env->spr[SPR_DPDES] = hv_state.dpdes;
     env->spr[SPR_HFSCR] = hv_state.hfscr;
     hdec = hv_state.hdec_expiry - now;
-    spapr_cpu->nested_tb_offset = hv_state.tb_offset;
     /* TCG does not implement DAWR*, CIABR, PURR, SPURR, IC, VTB, HEIR SPRs*/
     env->spr[SPR_SRR0] = hv_state.srr0;
     env->spr[SPR_SRR1] = hv_state.srr1;
@@ -1665,7 +1772,7 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
      * and it's not obviously worth a new data structure to do it.
      */
 
-    env->tb_env->tb_offset += spapr_cpu->nested_tb_offset;
+    env->tb_env->tb_offset += hv_state.tb_offset;
     spapr_cpu->in_nested = true;
 
     hreg_compute_hflags(env);
@@ -1684,7 +1791,6 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
 
 void spapr_exit_nested(PowerPCCPU *cpu, int excp)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
     target_ulong r3_return = env->excp_vectors[excp]; /* hcall return value */
@@ -1766,34 +1872,8 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
     address_space_unmap(CPU(cpu)->as, regs, len, len, true);
 
 out_restore_l1:
-    memcpy(env->gpr, spapr_cpu->nested_host_state->gpr, sizeof(env->gpr));
-    env->lr = spapr_cpu->nested_host_state->lr;
-    env->ctr = spapr_cpu->nested_host_state->ctr;
-    memcpy(env->crf, spapr_cpu->nested_host_state->crf, sizeof(env->crf));
-    env->cfar = spapr_cpu->nested_host_state->cfar;
-    env->xer = spapr_cpu->nested_host_state->xer;
-    env->so = spapr_cpu->nested_host_state->so;
-    env->ca = spapr_cpu->nested_host_state->ca;
-    env->ov = spapr_cpu->nested_host_state->ov;
-    env->ov32 = spapr_cpu->nested_host_state->ov32;
-    env->ca32 = spapr_cpu->nested_host_state->ca32;
-    env->msr = spapr_cpu->nested_host_state->msr;
-    env->nip = spapr_cpu->nested_host_state->nip;
-
     assert(env->spr[SPR_LPIDR] != 0);
-    env->spr[SPR_LPCR] = spapr_cpu->nested_host_state->spr[SPR_LPCR];
-    env->spr[SPR_LPIDR] = spapr_cpu->nested_host_state->spr[SPR_LPIDR];
-    env->spr[SPR_PCR] = spapr_cpu->nested_host_state->spr[SPR_PCR];
-    env->spr[SPR_DPDES] = 0;
-    env->spr[SPR_HFSCR] = spapr_cpu->nested_host_state->spr[SPR_HFSCR];
-    env->spr[SPR_SRR0] = spapr_cpu->nested_host_state->spr[SPR_SRR0];
-    env->spr[SPR_SRR1] = spapr_cpu->nested_host_state->spr[SPR_SRR1];
-    env->spr[SPR_SPRG0] = spapr_cpu->nested_host_state->spr[SPR_SPRG0];
-    env->spr[SPR_SPRG1] = spapr_cpu->nested_host_state->spr[SPR_SPRG1];
-    env->spr[SPR_SPRG2] = spapr_cpu->nested_host_state->spr[SPR_SPRG2];
-    env->spr[SPR_SPRG3] = spapr_cpu->nested_host_state->spr[SPR_SPRG3];
-    env->spr[SPR_BOOKS_PID] = spapr_cpu->nested_host_state->spr[SPR_BOOKS_PID];
-    env->spr[SPR_PPR] = spapr_cpu->nested_host_state->spr[SPR_PPR];
+    nested_load_state(cpu, spapr_cpu->nested_host_state);
 
     /*
      * Return the interrupt vector address from H_ENTER_NESTED to the L1
@@ -1801,14 +1881,8 @@ out_restore_l1:
      */
     env->gpr[3] = r3_return;
 
-    env->tb_env->tb_offset -= spapr_cpu->nested_tb_offset;
     spapr_cpu->in_nested = false;
 
-    hreg_compute_hflags(env);
-    ppc_maybe_interrupt(env);
-    tlb_flush(cs);
-    env->reserve_addr = -1; /* Reset the reservation */
-
     g_free(spapr_cpu->nested_host_state);
     spapr_cpu->nested_host_state = NULL;
 }
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
index b560514560..69a52e39b8 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -41,6 +41,8 @@ void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip,
                                target_ulong r1, target_ulong r3,
                                target_ulong r4);
 
+struct nested_ppc_state;
+
 typedef struct SpaprCpuState {
     uint64_t vpa_addr;
     uint64_t slb_shadow_addr, slb_shadow_size;
@@ -51,8 +53,7 @@ typedef struct SpaprCpuState {
 
     /* Fields for nested-HV support */
     bool in_nested; /* true while the L2 is executing */
-    CPUPPCState *nested_host_state; /* holds the L1 state while L2 executes */
-    int64_t nested_tb_offset; /* L1->L2 TB offset */
+    struct nested_ppc_state *nested_host_state; /* holds the L1 state while L2 executes */
 } SpaprCpuState;
 
 static inline SpaprCpuState *spapr_cpu_state(PowerPCCPU *cpu)
-- 
2.40.1


