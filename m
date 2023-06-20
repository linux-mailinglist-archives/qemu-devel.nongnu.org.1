Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 858A7736A1A
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:58:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBZ3h-0007LV-Ro; Tue, 20 Jun 2023 06:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBZ3f-0007Jv-9d; Tue, 20 Jun 2023 06:57:59 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBZ3d-0000j0-8f; Tue, 20 Jun 2023 06:57:59 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-668730696a4so1204192b3a.1; 
 Tue, 20 Jun 2023 03:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687258675; x=1689850675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SWZnKJXRiJBNnfnp5cfb9V+MeQ+/jjMQ9HeaYGeoqGY=;
 b=pNt8p5RIrAUXDITSwXx0QCLrBx1yQqE6QXNox+H1lZiOWatlIgNK9ClLK85wGGeh1b
 Wp0adU7+c9IvPzDproZ4RXq45mEYP/WoxRmv9CCZyaZ8ttEqwjcjfHrPvwPGMB6torG/
 RLPh5y5dObo0j+5FfU+6pfuUiv0rB+3xY0RDZk+LEhAHB+uVH8+T7YoAD1cbUuTTzOYW
 06Eq6uOfAKovAy7wlTln3pv/qkOWAHLphoFHXWh2oGlzdgJvkPu3rbHvqycWLUI3jPhu
 1zVKRwPBU0VPqitBLVwNQiYHNGjEIYL9QMTj0HJg2VhIftL/e1xYSBLYYqrMPnWNG1wr
 38Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687258675; x=1689850675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SWZnKJXRiJBNnfnp5cfb9V+MeQ+/jjMQ9HeaYGeoqGY=;
 b=JEiZ6luZwpJnnclLklVzyhhOTOos4Fy1+IUmabXuAFTz57DhKYHI/NBcgMI8B3shBH
 kL+QUf5zbUp9ohHdE3Tp+VptnoJ3Mz28kT3+VcFcyk5ijCx5f59UIsm/ECwtDkLGTY5o
 u4+smfpxr7W4mb1qV4P0fpDz+bPyYC50vKpdG0hDpEuLNu4XSOSeKVB9kqew7+sip3m+
 fcKvusMjmSNJ4Fl1Ys/TOWZvfKtKAeBkUkk9CSjZ4ZQIHNMOmEniJjZdNEY/hQvzhMKz
 vP/uzzOX1YeYzL7CV2CDMyfFRNqJaT0TscPl8anMxKM2O3cbIPTdgk6bOi5UeRiW0s9i
 JWOg==
X-Gm-Message-State: AC+VfDwdQYplKcIZoPivmkcXlQ6ynJCTFFMq6jAUbNJq9JzpXs5Di6J2
 BCoSGNqwwlzVs1c1Wk1XL6HNIc9+Jnw=
X-Google-Smtp-Source: ACHHUZ4uVuSNqCAsxnppzyrc81K+wNWQb4XqNKvfy0rZqdOE/tR1ur3qeMyBiKkmNgXCHyg3d5xspw==
X-Received: by 2002:aa7:8882:0:b0:668:8c3c:3144 with SMTP id
 z2-20020aa78882000000b006688c3c3144mr3551234pfe.14.1687258675379; 
 Tue, 20 Jun 2023 03:57:55 -0700 (PDT)
Received: from wheely.local0.net ([124.170.190.103])
 by smtp.gmail.com with ESMTPSA id
 n13-20020aa78a4d000000b0064fabbc047dsm1126412pfa.55.2023.06.20.03.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 03:57:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v2 3/4] ppc/spapr: load and store l2 state with helper
 functions
Date: Tue, 20 Jun 2023 20:57:36 +1000
Message-Id: <20230620105737.160451-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620105737.160451-1-npiggin@gmail.com>
References: <20230620105737.160451-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
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

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_hcall.c | 164 ++++++++++++++++++++++---------------------
 1 file changed, 85 insertions(+), 79 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index d5b8d54692..54ad83a3e6 100644
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
-
-    env->lr = regs->link;
-    env->ctr = regs->ctr;
-    cpu_write_xer(env, regs->xer);
-    ppc_set_cr(env, regs->ccr);
+    memcpy(l2_state.gpr, regs->gpr, len);
 
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
 
+    /*
+     * Switch to the nested guest environment and start the "hdec" timer.
+     */
+    nested_load_state(cpu, &l2_state);
+
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
+        return;
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
+        return;
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


