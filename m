Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 235B9727AF6
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 11:15:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Bic-0001d8-2E; Thu, 08 Jun 2023 05:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q7BiZ-0001cR-U0; Thu, 08 Jun 2023 05:14:07 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q7BiX-0005Py-RK; Thu, 08 Jun 2023 05:14:07 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-256e1d87998so278523a91.3; 
 Thu, 08 Jun 2023 02:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686215643; x=1688807643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pBKlsQGmNESnd5f161f21LEW1NdURDBamigTOA8If0E=;
 b=TOKbn9cZuzNCQDxTx+8yN06W6g61S9BezTlxJ8z68mXexsxXyXUSvxNzUdST1nA2tA
 90Wlvm0fnmGxy9un5063s2/YpoGj0yoE6HNTiuW1HSF/jMTd23bUjcJN6DLKpsLgIXX8
 kOP9F130x3suqouRLizyA91NMaxVEhkQ/eXyOSVifwJr25MeVFN/1wGvxduD0ofaZGy0
 EnHcSKwmVHlnaEWapsg4xCVXsKwA6wmQfIiy36Tv2KB5AGgsx5GAQBdswEfujjpkSaIR
 x8ELV9IsQ0kSnHPn9ai4RwfRDDtse9IgJIGvOI30POZgTTxoZvyhZDflt3T90g3UIxeP
 TZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686215643; x=1688807643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pBKlsQGmNESnd5f161f21LEW1NdURDBamigTOA8If0E=;
 b=cY+bFXS/w1IWqoxgQVqewUmbu8FkoyUmOHcB7jtqnAsO7+4rgSRPbr2BnyqiSKvSyq
 /9ok2pifbuBr6Q/hx7LMI9FZ9ur6/VnNFrECaAuwJ1ODeDYVn0sCvozgaierc+Dgay18
 Ro+a/HucbuOK8b3+DBAg3ziaIBjIngkg3V4f4If0ZncAZRm/TDzfzxrHKdK1rq712xSY
 iOnBFmHzQpmJ2eaCl1fdwhzlXFyu5X/b9ezIofFmAXNk2262yqHP5a2TZiNtlu2SEaAI
 tWOYGpcDP+jWJa+j+erTtczzGa8KNezWSDX7iJqgxLZYrOTEoAzsYZ8P9nl92iUQ9KS/
 ag9A==
X-Gm-Message-State: AC+VfDyO8uhCVDnktUvsafMQKH+l9osonXg63aDVVOrfBo0gQDpS7+W7
 QchcvloXYFHEArReCnV0IZSaVR0kHuM=
X-Google-Smtp-Source: ACHHUZ6JFQFYup/36qyuVi2TVdi2CuvytzF8nMrkRiarvAAotZPZTbLggEKcMtUOKM+ML5Ac3hsTIA==
X-Received: by 2002:a17:90b:110e:b0:258:b43d:bdcc with SMTP id
 gi14-20020a17090b110e00b00258b43dbdccmr7255104pjb.8.1686215642525; 
 Thu, 08 Jun 2023 02:14:02 -0700 (PDT)
Received: from wheely.local0.net (58-6-224-112.tpgi.com.au. [58.6.224.112])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a17090a5d8b00b002563e8a0225sm823577pji.48.2023.06.08.02.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 02:14:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 3/4] ppc/spapr: load and store l2 state with helper functions
Date: Thu,  8 Jun 2023 19:13:43 +1000
Message-Id: <20230608091344.88685-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230608091344.88685-1-npiggin@gmail.com>
References: <20230608091344.88685-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102f.google.com
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

Arguably this is just shuffling around register accesses, but one nice
thing it does is allow the exit to save away the L2 state then switch
the environment to the L1 before copying L2 data back to the L1, which
logically flows more naturally and simplifies the error paths.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_hcall.c | 164 ++++++++++++++++++++++---------------------
 1 file changed, 85 insertions(+), 79 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index d5b8d54692..da6440f235 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1663,9 +1663,9 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
                                    target_ulong *args)
 {
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
+    struct nested_ppc_state l2_state;
     target_ulong hv_ptr = args[0];
     target_ulong regs_ptr = args[1];
     target_ulong hdec, now = cpu_ppc_load_tbl(env);
@@ -1699,6 +1699,10 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
         return H_PARAMETER;
     }
 
+    if (hv_state.lpid == 0) {
+        return H_PARAMETER;
+    }
+
     spapr_cpu->nested_host_state = g_try_new(struct nested_ppc_state, 1);
     if (!spapr_cpu->nested_host_state) {
         return H_NO_MEM;
@@ -1717,46 +1721,49 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
         return H_P2;
     }
 
-    len = sizeof(env->gpr);
+    len = sizeof(l2_state.gpr);
     assert(len == sizeof(regs->gpr));
-    memcpy(env->gpr, regs->gpr, len);
+    memcpy(l2_state.gpr, regs->gpr, len);
 
-    env->lr = regs->link;
-    env->ctr = regs->ctr;
-    cpu_write_xer(env, regs->xer);
-    ppc_set_cr(env, regs->ccr);
-
-    env->msr = regs->msr;
-    env->nip = regs->nip;
+    l2_state.lr = regs->link;
+    l2_state.ctr = regs->ctr;
+    l2_state.xer = regs->xer;
+    l2_state.cr = regs->ccr;
+    l2_state.msr = regs->msr;
+    l2_state.nip = regs->nip;
 
     address_space_unmap(CPU(cpu)->as, regs, len, len, false);
 
-    env->cfar = hv_state.cfar;
-
-    assert(env->spr[SPR_LPIDR] == 0);
-    env->spr[SPR_LPIDR] = hv_state.lpid;
+    l2_state.cfar = hv_state.cfar;
+    l2_state.lpidr = hv_state.lpid;
 
     lpcr_mask = LPCR_DPFD | LPCR_ILE | LPCR_AIL | LPCR_LD | LPCR_MER;
     lpcr = (env->spr[SPR_LPCR] & ~lpcr_mask) | (hv_state.lpcr & lpcr_mask);
     lpcr |= LPCR_HR | LPCR_UPRT | LPCR_GTSE | LPCR_HVICE | LPCR_HDICE;
     lpcr &= ~LPCR_LPES0;
-    env->spr[SPR_LPCR] = lpcr & pcc->lpcr_mask;
+    l2_state.lpcr = lpcr & pcc->lpcr_mask;
 
-    env->spr[SPR_PCR] = hv_state.pcr;
+    l2_state.pcr = hv_state.pcr;
     /* hv_state.amor is not used */
-    env->spr[SPR_DPDES] = hv_state.dpdes;
-    env->spr[SPR_HFSCR] = hv_state.hfscr;
-    hdec = hv_state.hdec_expiry - now;
+    l2_state.dpdes = hv_state.dpdes;
+    l2_state.hfscr = hv_state.hfscr;
     /* TCG does not implement DAWR*, CIABR, PURR, SPURR, IC, VTB, HEIR SPRs*/
-    env->spr[SPR_SRR0] = hv_state.srr0;
-    env->spr[SPR_SRR1] = hv_state.srr1;
-    env->spr[SPR_SPRG0] = hv_state.sprg[0];
-    env->spr[SPR_SPRG1] = hv_state.sprg[1];
-    env->spr[SPR_SPRG2] = hv_state.sprg[2];
-    env->spr[SPR_SPRG3] = hv_state.sprg[3];
-    env->spr[SPR_BOOKS_PID] = hv_state.pidr;
-    env->spr[SPR_PPR] = hv_state.ppr;
+    l2_state.srr0 = hv_state.srr0;
+    l2_state.srr1 = hv_state.srr1;
+    l2_state.sprg0 = hv_state.sprg[0];
+    l2_state.sprg1 = hv_state.sprg[1];
+    l2_state.sprg2 = hv_state.sprg[2];
+    l2_state.sprg3 = hv_state.sprg[3];
+    l2_state.pidr = hv_state.pidr;
+    l2_state.ppr = hv_state.ppr;
+    l2_state.tb_offset = env->tb_env->tb_offset + hv_state.tb_offset;
+
+    /*
+     * Switch to the nested guest environment and start the "hdec" timer.
+     */
+    nested_load_state(cpu, &l2_state);
 
+    hdec = hv_state.hdec_expiry - now;
     cpu_ppc_hdecr_init(env);
     cpu_ppc_store_hdecr(env, hdec);
 
@@ -1772,14 +1779,8 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
      * and it's not obviously worth a new data structure to do it.
      */
 
-    env->tb_env->tb_offset += hv_state.tb_offset;
     spapr_cpu->in_nested = true;
 
-    hreg_compute_hflags(env);
-    ppc_maybe_interrupt(env);
-    tlb_flush(cs);
-    env->reserve_addr = -1; /* Reset the reservation */
-
     /*
      * The spapr hcall helper sets env->gpr[3] to the return value, but at
      * this point the L1 is not returning from the hcall but rather we
@@ -1793,49 +1794,69 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
     SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
-    target_ulong r3_return = env->excp_vectors[excp]; /* hcall return value */
+    struct nested_ppc_state l2_state;
     target_ulong hv_ptr = spapr_cpu->nested_host_state->gpr[4];
     target_ulong regs_ptr = spapr_cpu->nested_host_state->gpr[5];
+    target_ulong hsrr0, hsrr1, hdar, asdr, hdsisr;
     struct kvmppc_hv_guest_state *hvstate;
     struct kvmppc_pt_regs *regs;
     hwaddr len;
 
     assert(spapr_cpu->in_nested);
 
+    nested_save_state(&l2_state, cpu);
+    hsrr0 = env->spr[SPR_HSRR0];
+    hsrr1 = env->spr[SPR_HSRR1];
+    hdar = env->spr[SPR_HDAR];
+    hdsisr = env->spr[SPR_HDSISR];
+    asdr = env->spr[SPR_ASDR];
+
+    /*
+     * Switch back to the host environment (including for any error).
+     */
+    assert(env->spr[SPR_LPIDR] != 0);
+    nested_load_state(cpu, spapr_cpu->nested_host_state);
+    env->gpr[3] = env->excp_vectors[excp]; /* hcall return value */
+
     cpu_ppc_hdecr_exit(env);
 
+    spapr_cpu->in_nested = false;
+
+    g_free(spapr_cpu->nested_host_state);
+    spapr_cpu->nested_host_state = NULL;
+
     len = sizeof(*hvstate);
     hvstate = address_space_map(CPU(cpu)->as, hv_ptr, &len, true,
                                 MEMTXATTRS_UNSPECIFIED);
     if (len != sizeof(*hvstate)) {
         address_space_unmap(CPU(cpu)->as, hvstate, len, 0, true);
-        r3_return = H_PARAMETER;
-        goto out_restore_l1;
+        env->gpr[3] = H_PARAMETER;
+	return;
     }
 
-    hvstate->cfar = env->cfar;
-    hvstate->lpcr = env->spr[SPR_LPCR];
-    hvstate->pcr = env->spr[SPR_PCR];
-    hvstate->dpdes = env->spr[SPR_DPDES];
-    hvstate->hfscr = env->spr[SPR_HFSCR];
+    hvstate->cfar = l2_state.cfar;
+    hvstate->lpcr = l2_state.lpcr;
+    hvstate->pcr = l2_state.pcr;
+    hvstate->dpdes = l2_state.dpdes;
+    hvstate->hfscr = l2_state.hfscr;
 
     if (excp == POWERPC_EXCP_HDSI) {
-        hvstate->hdar = env->spr[SPR_HDAR];
-        hvstate->hdsisr = env->spr[SPR_HDSISR];
-        hvstate->asdr = env->spr[SPR_ASDR];
+        hvstate->hdar = hdar;
+        hvstate->hdsisr = hdsisr;
+        hvstate->asdr = asdr;
     } else if (excp == POWERPC_EXCP_HISI) {
-        hvstate->asdr = env->spr[SPR_ASDR];
+        hvstate->asdr = asdr;
     }
 
     /* HEIR should be implemented for HV mode and saved here. */
-    hvstate->srr0 = env->spr[SPR_SRR0];
-    hvstate->srr1 = env->spr[SPR_SRR1];
-    hvstate->sprg[0] = env->spr[SPR_SPRG0];
-    hvstate->sprg[1] = env->spr[SPR_SPRG1];
-    hvstate->sprg[2] = env->spr[SPR_SPRG2];
-    hvstate->sprg[3] = env->spr[SPR_SPRG3];
-    hvstate->pidr = env->spr[SPR_BOOKS_PID];
-    hvstate->ppr = env->spr[SPR_PPR];
+    hvstate->srr0 = l2_state.srr0;
+    hvstate->srr1 = l2_state.srr1;
+    hvstate->sprg[0] = l2_state.sprg0;
+    hvstate->sprg[1] = l2_state.sprg1;
+    hvstate->sprg[2] = l2_state.sprg2;
+    hvstate->sprg[3] = l2_state.sprg3;
+    hvstate->pidr = l2_state.pidr;
+    hvstate->ppr = l2_state.ppr;
 
     /* Is it okay to specify write length larger than actual data written? */
     address_space_unmap(CPU(cpu)->as, hvstate, len, len, true);
@@ -1845,46 +1866,31 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
                                 MEMTXATTRS_UNSPECIFIED);
     if (!regs || len != sizeof(*regs)) {
         address_space_unmap(CPU(cpu)->as, regs, len, 0, true);
-        r3_return = H_P2;
-        goto out_restore_l1;
+        env->gpr[3] = H_P2;
+	return;
     }
 
     len = sizeof(env->gpr);
     assert(len == sizeof(regs->gpr));
-    memcpy(regs->gpr, env->gpr, len);
+    memcpy(regs->gpr, l2_state.gpr, len);
 
-    regs->link = env->lr;
-    regs->ctr = env->ctr;
-    regs->xer = cpu_read_xer(env);
-    regs->ccr = ppc_get_cr(env);
+    regs->link = l2_state.lr;
+    regs->ctr = l2_state.ctr;
+    regs->xer = l2_state.xer;
+    regs->ccr = l2_state.cr;
 
     if (excp == POWERPC_EXCP_MCHECK ||
         excp == POWERPC_EXCP_RESET ||
         excp == POWERPC_EXCP_SYSCALL) {
-        regs->nip = env->spr[SPR_SRR0];
-        regs->msr = env->spr[SPR_SRR1] & env->msr_mask;
+        regs->nip = l2_state.srr0;
+        regs->msr = l2_state.srr1 & env->msr_mask;
     } else {
-        regs->nip = env->spr[SPR_HSRR0];
-        regs->msr = env->spr[SPR_HSRR1] & env->msr_mask;
+        regs->nip = hsrr0;
+        regs->msr = hsrr1 & env->msr_mask;
     }
 
     /* Is it okay to specify write length larger than actual data written? */
     address_space_unmap(CPU(cpu)->as, regs, len, len, true);
-
-out_restore_l1:
-    assert(env->spr[SPR_LPIDR] != 0);
-    nested_load_state(cpu, spapr_cpu->nested_host_state);
-
-    /*
-     * Return the interrupt vector address from H_ENTER_NESTED to the L1
-     * (or error code).
-     */
-    env->gpr[3] = r3_return;
-
-    spapr_cpu->in_nested = false;
-
-    g_free(spapr_cpu->nested_host_state);
-    spapr_cpu->nested_host_state = NULL;
 }
 
 static void hypercall_register_nested(void)
-- 
2.40.1


