Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C40B773D78B
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 08:08:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDfEZ-0003b2-QA; Mon, 26 Jun 2023 01:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfEK-0003Pq-Ub; Mon, 26 Jun 2023 01:57:42 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfEG-0007Nt-Uq; Mon, 26 Jun 2023 01:57:40 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QqHDt1yjVz4wZy;
 Mon, 26 Jun 2023 15:57:34 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqHDq3F2yz4wb1;
 Mon, 26 Jun 2023 15:57:31 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 13/30] ppc/spapr: Move spapr nested HV to a new file
Date: Mon, 26 Jun 2023 07:56:30 +0200
Message-ID: <20230626055647.1147743-14-clg@kaod.org>
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

Create spapr_nested.c for most of the nested HV implementation.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr.h        |  62 -----
 include/hw/ppc/spapr_nested.h | 102 +++++++++
 hw/ppc/spapr.c                |   1 +
 hw/ppc/spapr_hcall.c          | 416 +---------------------------------
 hw/ppc/spapr_nested.c         | 395 ++++++++++++++++++++++++++++++++
 hw/ppc/meson.build            |   1 +
 6 files changed, 501 insertions(+), 476 deletions(-)
 create mode 100644 include/hw/ppc/spapr_nested.h
 create mode 100644 hw/ppc/spapr_nested.c

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index bd5a6c47807b..538b2dfb8996 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -621,66 +621,6 @@ struct SpaprMachineState {
 #define SVM_H_TPM_COMM              0xEF10
 #define SVM_HCALL_MAX               SVM_H_TPM_COMM
 
-/*
- * Register state for entering a nested guest with H_ENTER_NESTED.
- * New member must be added at the end.
- */
-struct kvmppc_hv_guest_state {
-    uint64_t version;      /* version of this structure layout, must be first */
-    uint32_t lpid;
-    uint32_t vcpu_token;
-    /* These registers are hypervisor privileged (at least for writing) */
-    uint64_t lpcr;
-    uint64_t pcr;
-    uint64_t amor;
-    uint64_t dpdes;
-    uint64_t hfscr;
-    int64_t tb_offset;
-    uint64_t dawr0;
-    uint64_t dawrx0;
-    uint64_t ciabr;
-    uint64_t hdec_expiry;
-    uint64_t purr;
-    uint64_t spurr;
-    uint64_t ic;
-    uint64_t vtb;
-    uint64_t hdar;
-    uint64_t hdsisr;
-    uint64_t heir;
-    uint64_t asdr;
-    /* These are OS privileged but need to be set late in guest entry */
-    uint64_t srr0;
-    uint64_t srr1;
-    uint64_t sprg[4];
-    uint64_t pidr;
-    uint64_t cfar;
-    uint64_t ppr;
-    /* Version 1 ends here */
-    uint64_t dawr1;
-    uint64_t dawrx1;
-    /* Version 2 ends here */
-};
-
-/* Latest version of hv_guest_state structure */
-#define HV_GUEST_STATE_VERSION  2
-
-/* Linux 64-bit powerpc pt_regs struct, used by nested HV */
-struct kvmppc_pt_regs {
-    uint64_t gpr[32];
-    uint64_t nip;
-    uint64_t msr;
-    uint64_t orig_gpr3;    /* Used for restarting system calls */
-    uint64_t ctr;
-    uint64_t link;
-    uint64_t xer;
-    uint64_t ccr;
-    uint64_t softe;        /* Soft enabled/disabled */
-    uint64_t trap;         /* Reason for being here */
-    uint64_t dar;          /* Fault registers */
-    uint64_t dsisr;        /* on 4xx/Book-E used for ESR */
-    uint64_t result;       /* Result of a system call */
-};
-
 typedef struct SpaprDeviceTreeUpdateHeader {
     uint32_t version_id;
 } SpaprDeviceTreeUpdateHeader;
@@ -698,8 +638,6 @@ void spapr_register_hypercall(target_ulong opcode, spapr_hcall_fn fn);
 target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
                              target_ulong *args);
 
-void spapr_exit_nested(PowerPCCPU *cpu, int excp);
-
 target_ulong softmmu_resize_hpt_prepare(PowerPCCPU *cpu, SpaprMachineState *spapr,
                                          target_ulong shift);
 target_ulong softmmu_resize_hpt_commit(PowerPCCPU *cpu, SpaprMachineState *spapr,
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
new file mode 100644
index 000000000000..d3834864764f
--- /dev/null
+++ b/include/hw/ppc/spapr_nested.h
@@ -0,0 +1,102 @@
+#ifndef HW_SPAPR_NESTED_H
+#define HW_SPAPR_NESTED_H
+
+#include "qemu/osdep.h"
+#include "target/ppc/cpu.h"
+
+/*
+ * Register state for entering a nested guest with H_ENTER_NESTED.
+ * New member must be added at the end.
+ */
+struct kvmppc_hv_guest_state {
+    uint64_t version;      /* version of this structure layout, must be first */
+    uint32_t lpid;
+    uint32_t vcpu_token;
+    /* These registers are hypervisor privileged (at least for writing) */
+    uint64_t lpcr;
+    uint64_t pcr;
+    uint64_t amor;
+    uint64_t dpdes;
+    uint64_t hfscr;
+    int64_t tb_offset;
+    uint64_t dawr0;
+    uint64_t dawrx0;
+    uint64_t ciabr;
+    uint64_t hdec_expiry;
+    uint64_t purr;
+    uint64_t spurr;
+    uint64_t ic;
+    uint64_t vtb;
+    uint64_t hdar;
+    uint64_t hdsisr;
+    uint64_t heir;
+    uint64_t asdr;
+    /* These are OS privileged but need to be set late in guest entry */
+    uint64_t srr0;
+    uint64_t srr1;
+    uint64_t sprg[4];
+    uint64_t pidr;
+    uint64_t cfar;
+    uint64_t ppr;
+    /* Version 1 ends here */
+    uint64_t dawr1;
+    uint64_t dawrx1;
+    /* Version 2 ends here */
+};
+
+/* Latest version of hv_guest_state structure */
+#define HV_GUEST_STATE_VERSION  2
+
+/* Linux 64-bit powerpc pt_regs struct, used by nested HV */
+struct kvmppc_pt_regs {
+    uint64_t gpr[32];
+    uint64_t nip;
+    uint64_t msr;
+    uint64_t orig_gpr3;    /* Used for restarting system calls */
+    uint64_t ctr;
+    uint64_t link;
+    uint64_t xer;
+    uint64_t ccr;
+    uint64_t softe;        /* Soft enabled/disabled */
+    uint64_t trap;         /* Reason for being here */
+    uint64_t dar;          /* Fault registers */
+    uint64_t dsisr;        /* on 4xx/Book-E used for ESR */
+    uint64_t result;       /* Result of a system call */
+};
+
+/*
+ * nested_ppc_state is used to save the host CPU state before switching it to
+ * the guest CPU state, to be restored on H_ENTER_NESTED exit.
+ */
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
+void spapr_register_nested(void);
+void spapr_exit_nested(PowerPCCPU *cpu, int excp);
+
+#endif /* HW_SPAPR_NESTED_H */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index dcb7f1c70aa0..e55905a1f068 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -61,6 +61,7 @@
 
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/spapr.h"
+#include "hw/ppc/spapr_nested.h"
 #include "hw/ppc/spapr_vio.h"
 #include "hw/ppc/vof.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 54ad83a3e66a..002ea0b7c10b 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -13,6 +13,7 @@
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_cpu_core.h"
+#include "hw/ppc/spapr_nested.h"
 #include "mmu-hash64.h"
 #include "cpu-models.h"
 #include "trace.h"
@@ -1498,430 +1499,17 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
 }
 
 #ifdef CONFIG_TCG
-#define PRTS_MASK      0x1f
-
-static target_ulong h_set_ptbl(PowerPCCPU *cpu,
-                               SpaprMachineState *spapr,
-                               target_ulong opcode,
-                               target_ulong *args)
-{
-    target_ulong ptcr = args[0];
-
-    if (!spapr_get_cap(spapr, SPAPR_CAP_NESTED_KVM_HV)) {
-        return H_FUNCTION;
-    }
-
-    if ((ptcr & PRTS_MASK) + 12 - 4 > 12) {
-        return H_PARAMETER;
-    }
-
-    spapr->nested_ptcr = ptcr; /* Save new partition table */
-
-    return H_SUCCESS;
-}
-
-static target_ulong h_tlb_invalidate(PowerPCCPU *cpu,
-                                     SpaprMachineState *spapr,
-                                     target_ulong opcode,
-                                     target_ulong *args)
-{
-    /*
-     * The spapr virtual hypervisor nested HV implementation retains no L2
-     * translation state except for TLB. And the TLB is always invalidated
-     * across L1<->L2 transitions, so nothing is required here.
-     */
-
-    return H_SUCCESS;
-}
-
-static target_ulong h_copy_tofrom_guest(PowerPCCPU *cpu,
-                                        SpaprMachineState *spapr,
-                                        target_ulong opcode,
-                                        target_ulong *args)
-{
-    /*
-     * This HCALL is not required, L1 KVM will take a slow path and walk the
-     * page tables manually to do the data copy.
-     */
-    return H_FUNCTION;
-}
-
-struct nested_ppc_state {
-    uint64_t gpr[32];
-    uint64_t lr;
-    uint64_t ctr;
-    uint64_t cfar;
-    uint64_t msr;
-    uint64_t nip;
-    uint32_t cr;
-
-    uint64_t xer;
-
-    uint64_t lpcr;
-    uint64_t lpidr;
-    uint64_t pidr;
-    uint64_t pcr;
-    uint64_t dpdes;
-    uint64_t hfscr;
-    uint64_t srr0;
-    uint64_t srr1;
-    uint64_t sprg0;
-    uint64_t sprg1;
-    uint64_t sprg2;
-    uint64_t sprg3;
-    uint64_t ppr;
-
-    int64_t tb_offset;
-};
-
-static void nested_save_state(struct nested_ppc_state *save, PowerPCCPU *cpu)
-{
-    CPUPPCState *env = &cpu->env;
-
-    memcpy(save->gpr, env->gpr, sizeof(save->gpr));
-
-    save->lr = env->lr;
-    save->ctr = env->ctr;
-    save->cfar = env->cfar;
-    save->msr = env->msr;
-    save->nip = env->nip;
-
-    save->cr = ppc_get_cr(env);
-    save->xer = cpu_read_xer(env);
-
-    save->lpcr = env->spr[SPR_LPCR];
-    save->lpidr = env->spr[SPR_LPIDR];
-    save->pcr = env->spr[SPR_PCR];
-    save->dpdes = env->spr[SPR_DPDES];
-    save->hfscr = env->spr[SPR_HFSCR];
-    save->srr0 = env->spr[SPR_SRR0];
-    save->srr1 = env->spr[SPR_SRR1];
-    save->sprg0 = env->spr[SPR_SPRG0];
-    save->sprg1 = env->spr[SPR_SPRG1];
-    save->sprg2 = env->spr[SPR_SPRG2];
-    save->sprg3 = env->spr[SPR_SPRG3];
-    save->pidr = env->spr[SPR_BOOKS_PID];
-    save->ppr = env->spr[SPR_PPR];
-
-    save->tb_offset = env->tb_env->tb_offset;
-}
-
-static void nested_load_state(PowerPCCPU *cpu, struct nested_ppc_state *load)
-{
-    CPUState *cs = CPU(cpu);
-    CPUPPCState *env = &cpu->env;
-
-    memcpy(env->gpr, load->gpr, sizeof(env->gpr));
-
-    env->lr = load->lr;
-    env->ctr = load->ctr;
-    env->cfar = load->cfar;
-    env->msr = load->msr;
-    env->nip = load->nip;
-
-    ppc_set_cr(env, load->cr);
-    cpu_write_xer(env, load->xer);
-
-    env->spr[SPR_LPCR] = load->lpcr;
-    env->spr[SPR_LPIDR] = load->lpidr;
-    env->spr[SPR_PCR] = load->pcr;
-    env->spr[SPR_DPDES] = load->dpdes;
-    env->spr[SPR_HFSCR] = load->hfscr;
-    env->spr[SPR_SRR0] = load->srr0;
-    env->spr[SPR_SRR1] = load->srr1;
-    env->spr[SPR_SPRG0] = load->sprg0;
-    env->spr[SPR_SPRG1] = load->sprg1;
-    env->spr[SPR_SPRG2] = load->sprg2;
-    env->spr[SPR_SPRG3] = load->sprg3;
-    env->spr[SPR_BOOKS_PID] = load->pidr;
-    env->spr[SPR_PPR] = load->ppr;
-
-    env->tb_env->tb_offset = load->tb_offset;
-
-    /*
-     * MSR updated, compute hflags and possible interrupts.
-     */
-    hreg_compute_hflags(env);
-    ppc_maybe_interrupt(env);
-
-    /*
-     * Nested HV does not tag TLB entries between L1 and L2, so must
-     * flush on transition.
-     */
-    tlb_flush(cs);
-    env->reserve_addr = -1; /* Reset the reservation */
-}
-
-/*
- * When this handler returns, the environment is switched to the L2 guest
- * and TCG begins running that. spapr_exit_nested() performs the switch from
- * L2 back to L1 and returns from the H_ENTER_NESTED hcall.
- */
-static target_ulong h_enter_nested(PowerPCCPU *cpu,
-                                   SpaprMachineState *spapr,
-                                   target_ulong opcode,
-                                   target_ulong *args)
-{
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
-    CPUPPCState *env = &cpu->env;
-    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
-    struct nested_ppc_state l2_state;
-    target_ulong hv_ptr = args[0];
-    target_ulong regs_ptr = args[1];
-    target_ulong hdec, now = cpu_ppc_load_tbl(env);
-    target_ulong lpcr, lpcr_mask;
-    struct kvmppc_hv_guest_state *hvstate;
-    struct kvmppc_hv_guest_state hv_state;
-    struct kvmppc_pt_regs *regs;
-    hwaddr len;
-
-    if (spapr->nested_ptcr == 0) {
-        return H_NOT_AVAILABLE;
-    }
-
-    len = sizeof(*hvstate);
-    hvstate = address_space_map(CPU(cpu)->as, hv_ptr, &len, false,
-                                MEMTXATTRS_UNSPECIFIED);
-    if (len != sizeof(*hvstate)) {
-        address_space_unmap(CPU(cpu)->as, hvstate, len, 0, false);
-        return H_PARAMETER;
-    }
-
-    memcpy(&hv_state, hvstate, len);
-
-    address_space_unmap(CPU(cpu)->as, hvstate, len, len, false);
-
-    /*
-     * We accept versions 1 and 2. Version 2 fields are unused because TCG
-     * does not implement DAWR*.
-     */
-    if (hv_state.version > HV_GUEST_STATE_VERSION) {
-        return H_PARAMETER;
-    }
-
-    if (hv_state.lpid == 0) {
-        return H_PARAMETER;
-    }
-
-    spapr_cpu->nested_host_state = g_try_new(struct nested_ppc_state, 1);
-    if (!spapr_cpu->nested_host_state) {
-        return H_NO_MEM;
-    }
-
-    assert(env->spr[SPR_LPIDR] == 0);
-    assert(env->spr[SPR_DPDES] == 0);
-    nested_save_state(spapr_cpu->nested_host_state, cpu);
-
-    len = sizeof(*regs);
-    regs = address_space_map(CPU(cpu)->as, regs_ptr, &len, false,
-                                MEMTXATTRS_UNSPECIFIED);
-    if (!regs || len != sizeof(*regs)) {
-        address_space_unmap(CPU(cpu)->as, regs, len, 0, false);
-        g_free(spapr_cpu->nested_host_state);
-        return H_P2;
-    }
-
-    len = sizeof(l2_state.gpr);
-    assert(len == sizeof(regs->gpr));
-    memcpy(l2_state.gpr, regs->gpr, len);
-
-    l2_state.lr = regs->link;
-    l2_state.ctr = regs->ctr;
-    l2_state.xer = regs->xer;
-    l2_state.cr = regs->ccr;
-    l2_state.msr = regs->msr;
-    l2_state.nip = regs->nip;
-
-    address_space_unmap(CPU(cpu)->as, regs, len, len, false);
-
-    l2_state.cfar = hv_state.cfar;
-    l2_state.lpidr = hv_state.lpid;
-
-    lpcr_mask = LPCR_DPFD | LPCR_ILE | LPCR_AIL | LPCR_LD | LPCR_MER;
-    lpcr = (env->spr[SPR_LPCR] & ~lpcr_mask) | (hv_state.lpcr & lpcr_mask);
-    lpcr |= LPCR_HR | LPCR_UPRT | LPCR_GTSE | LPCR_HVICE | LPCR_HDICE;
-    lpcr &= ~LPCR_LPES0;
-    l2_state.lpcr = lpcr & pcc->lpcr_mask;
-
-    l2_state.pcr = hv_state.pcr;
-    /* hv_state.amor is not used */
-    l2_state.dpdes = hv_state.dpdes;
-    l2_state.hfscr = hv_state.hfscr;
-    /* TCG does not implement DAWR*, CIABR, PURR, SPURR, IC, VTB, HEIR SPRs*/
-    l2_state.srr0 = hv_state.srr0;
-    l2_state.srr1 = hv_state.srr1;
-    l2_state.sprg0 = hv_state.sprg[0];
-    l2_state.sprg1 = hv_state.sprg[1];
-    l2_state.sprg2 = hv_state.sprg[2];
-    l2_state.sprg3 = hv_state.sprg[3];
-    l2_state.pidr = hv_state.pidr;
-    l2_state.ppr = hv_state.ppr;
-    l2_state.tb_offset = env->tb_env->tb_offset + hv_state.tb_offset;
-
-    /*
-     * Switch to the nested guest environment and start the "hdec" timer.
-     */
-    nested_load_state(cpu, &l2_state);
-
-    hdec = hv_state.hdec_expiry - now;
-    cpu_ppc_hdecr_init(env);
-    cpu_ppc_store_hdecr(env, hdec);
-
-    /*
-     * The hv_state.vcpu_token is not needed. It is used by the KVM
-     * implementation to remember which L2 vCPU last ran on which physical
-     * CPU so as to invalidate process scope translations if it is moved
-     * between physical CPUs. For now TLBs are always flushed on L1<->L2
-     * transitions so this is not a problem.
-     *
-     * Could validate that the same vcpu_token does not attempt to run on
-     * different L1 vCPUs at the same time, but that would be a L1 KVM bug
-     * and it's not obviously worth a new data structure to do it.
-     */
-
-    spapr_cpu->in_nested = true;
-
-    /*
-     * The spapr hcall helper sets env->gpr[3] to the return value, but at
-     * this point the L1 is not returning from the hcall but rather we
-     * start running the L2, so r3 must not be clobbered, so return env->gpr[3]
-     * to leave it unchanged.
-     */
-    return env->gpr[3];
-}
-
-void spapr_exit_nested(PowerPCCPU *cpu, int excp)
-{
-    CPUPPCState *env = &cpu->env;
-    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
-    struct nested_ppc_state l2_state;
-    target_ulong hv_ptr = spapr_cpu->nested_host_state->gpr[4];
-    target_ulong regs_ptr = spapr_cpu->nested_host_state->gpr[5];
-    target_ulong hsrr0, hsrr1, hdar, asdr, hdsisr;
-    struct kvmppc_hv_guest_state *hvstate;
-    struct kvmppc_pt_regs *regs;
-    hwaddr len;
-
-    assert(spapr_cpu->in_nested);
-
-    nested_save_state(&l2_state, cpu);
-    hsrr0 = env->spr[SPR_HSRR0];
-    hsrr1 = env->spr[SPR_HSRR1];
-    hdar = env->spr[SPR_HDAR];
-    hdsisr = env->spr[SPR_HDSISR];
-    asdr = env->spr[SPR_ASDR];
-
-    /*
-     * Switch back to the host environment (including for any error).
-     */
-    assert(env->spr[SPR_LPIDR] != 0);
-    nested_load_state(cpu, spapr_cpu->nested_host_state);
-    env->gpr[3] = env->excp_vectors[excp]; /* hcall return value */
-
-    cpu_ppc_hdecr_exit(env);
-
-    spapr_cpu->in_nested = false;
-
-    g_free(spapr_cpu->nested_host_state);
-    spapr_cpu->nested_host_state = NULL;
-
-    len = sizeof(*hvstate);
-    hvstate = address_space_map(CPU(cpu)->as, hv_ptr, &len, true,
-                                MEMTXATTRS_UNSPECIFIED);
-    if (len != sizeof(*hvstate)) {
-        address_space_unmap(CPU(cpu)->as, hvstate, len, 0, true);
-        env->gpr[3] = H_PARAMETER;
-        return;
-    }
-
-    hvstate->cfar = l2_state.cfar;
-    hvstate->lpcr = l2_state.lpcr;
-    hvstate->pcr = l2_state.pcr;
-    hvstate->dpdes = l2_state.dpdes;
-    hvstate->hfscr = l2_state.hfscr;
-
-    if (excp == POWERPC_EXCP_HDSI) {
-        hvstate->hdar = hdar;
-        hvstate->hdsisr = hdsisr;
-        hvstate->asdr = asdr;
-    } else if (excp == POWERPC_EXCP_HISI) {
-        hvstate->asdr = asdr;
-    }
-
-    /* HEIR should be implemented for HV mode and saved here. */
-    hvstate->srr0 = l2_state.srr0;
-    hvstate->srr1 = l2_state.srr1;
-    hvstate->sprg[0] = l2_state.sprg0;
-    hvstate->sprg[1] = l2_state.sprg1;
-    hvstate->sprg[2] = l2_state.sprg2;
-    hvstate->sprg[3] = l2_state.sprg3;
-    hvstate->pidr = l2_state.pidr;
-    hvstate->ppr = l2_state.ppr;
-
-    /* Is it okay to specify write length larger than actual data written? */
-    address_space_unmap(CPU(cpu)->as, hvstate, len, len, true);
-
-    len = sizeof(*regs);
-    regs = address_space_map(CPU(cpu)->as, regs_ptr, &len, true,
-                                MEMTXATTRS_UNSPECIFIED);
-    if (!regs || len != sizeof(*regs)) {
-        address_space_unmap(CPU(cpu)->as, regs, len, 0, true);
-        env->gpr[3] = H_P2;
-        return;
-    }
-
-    len = sizeof(env->gpr);
-    assert(len == sizeof(regs->gpr));
-    memcpy(regs->gpr, l2_state.gpr, len);
-
-    regs->link = l2_state.lr;
-    regs->ctr = l2_state.ctr;
-    regs->xer = l2_state.xer;
-    regs->ccr = l2_state.cr;
-
-    if (excp == POWERPC_EXCP_MCHECK ||
-        excp == POWERPC_EXCP_RESET ||
-        excp == POWERPC_EXCP_SYSCALL) {
-        regs->nip = l2_state.srr0;
-        regs->msr = l2_state.srr1 & env->msr_mask;
-    } else {
-        regs->nip = hsrr0;
-        regs->msr = hsrr1 & env->msr_mask;
-    }
-
-    /* Is it okay to specify write length larger than actual data written? */
-    address_space_unmap(CPU(cpu)->as, regs, len, len, true);
-}
-
-static void hypercall_register_nested(void)
-{
-    spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
-    spapr_register_hypercall(KVMPPC_H_ENTER_NESTED, h_enter_nested);
-    spapr_register_hypercall(KVMPPC_H_TLB_INVALIDATE, h_tlb_invalidate);
-    spapr_register_hypercall(KVMPPC_H_COPY_TOFROM_GUEST, h_copy_tofrom_guest);
-}
-
 static void hypercall_register_softmmu(void)
 {
     /* DO NOTHING */
 }
 #else
-void spapr_exit_nested(PowerPCCPU *cpu, int excp)
-{
-    g_assert_not_reached();
-}
-
 static target_ulong h_softmmu(PowerPCCPU *cpu, SpaprMachineState *spapr,
                             target_ulong opcode, target_ulong *args)
 {
     g_assert_not_reached();
 }
 
-static void hypercall_register_nested(void)
-{
-    /* DO NOTHING */
-}
-
 static void hypercall_register_softmmu(void)
 {
     /* hcall-pft */
@@ -1991,7 +1579,7 @@ static void hypercall_register_types(void)
 
     spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
 
-    hypercall_register_nested();
+    spapr_register_nested();
 }
 
 type_init(hypercall_register_types)
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
new file mode 100644
index 000000000000..121aa96ddcdd
--- /dev/null
+++ b/hw/ppc/spapr_nested.c
@@ -0,0 +1,395 @@
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "exec/exec-all.h"
+#include "helper_regs.h"
+#include "hw/ppc/ppc.h"
+#include "hw/ppc/spapr.h"
+#include "hw/ppc/spapr_cpu_core.h"
+#include "hw/ppc/spapr_nested.h"
+
+#ifdef CONFIG_TCG
+#define PRTS_MASK      0x1f
+
+static target_ulong h_set_ptbl(PowerPCCPU *cpu,
+                               SpaprMachineState *spapr,
+                               target_ulong opcode,
+                               target_ulong *args)
+{
+    target_ulong ptcr = args[0];
+
+    if (!spapr_get_cap(spapr, SPAPR_CAP_NESTED_KVM_HV)) {
+        return H_FUNCTION;
+    }
+
+    if ((ptcr & PRTS_MASK) + 12 - 4 > 12) {
+        return H_PARAMETER;
+    }
+
+    spapr->nested_ptcr = ptcr; /* Save new partition table */
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_tlb_invalidate(PowerPCCPU *cpu,
+                                     SpaprMachineState *spapr,
+                                     target_ulong opcode,
+                                     target_ulong *args)
+{
+    /*
+     * The spapr virtual hypervisor nested HV implementation retains no L2
+     * translation state except for TLB. And the TLB is always invalidated
+     * across L1<->L2 transitions, so nothing is required here.
+     */
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_copy_tofrom_guest(PowerPCCPU *cpu,
+                                        SpaprMachineState *spapr,
+                                        target_ulong opcode,
+                                        target_ulong *args)
+{
+    /*
+     * This HCALL is not required, L1 KVM will take a slow path and walk the
+     * page tables manually to do the data copy.
+     */
+    return H_FUNCTION;
+}
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
+/*
+ * When this handler returns, the environment is switched to the L2 guest
+ * and TCG begins running that. spapr_exit_nested() performs the switch from
+ * L2 back to L1 and returns from the H_ENTER_NESTED hcall.
+ */
+static target_ulong h_enter_nested(PowerPCCPU *cpu,
+                                   SpaprMachineState *spapr,
+                                   target_ulong opcode,
+                                   target_ulong *args)
+{
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    CPUPPCState *env = &cpu->env;
+    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
+    struct nested_ppc_state l2_state;
+    target_ulong hv_ptr = args[0];
+    target_ulong regs_ptr = args[1];
+    target_ulong hdec, now = cpu_ppc_load_tbl(env);
+    target_ulong lpcr, lpcr_mask;
+    struct kvmppc_hv_guest_state *hvstate;
+    struct kvmppc_hv_guest_state hv_state;
+    struct kvmppc_pt_regs *regs;
+    hwaddr len;
+
+    if (spapr->nested_ptcr == 0) {
+        return H_NOT_AVAILABLE;
+    }
+
+    len = sizeof(*hvstate);
+    hvstate = address_space_map(CPU(cpu)->as, hv_ptr, &len, false,
+                                MEMTXATTRS_UNSPECIFIED);
+    if (len != sizeof(*hvstate)) {
+        address_space_unmap(CPU(cpu)->as, hvstate, len, 0, false);
+        return H_PARAMETER;
+    }
+
+    memcpy(&hv_state, hvstate, len);
+
+    address_space_unmap(CPU(cpu)->as, hvstate, len, len, false);
+
+    /*
+     * We accept versions 1 and 2. Version 2 fields are unused because TCG
+     * does not implement DAWR*.
+     */
+    if (hv_state.version > HV_GUEST_STATE_VERSION) {
+        return H_PARAMETER;
+    }
+
+    if (hv_state.lpid == 0) {
+        return H_PARAMETER;
+    }
+
+    spapr_cpu->nested_host_state = g_try_new(struct nested_ppc_state, 1);
+    if (!spapr_cpu->nested_host_state) {
+        return H_NO_MEM;
+    }
+
+    assert(env->spr[SPR_LPIDR] == 0);
+    assert(env->spr[SPR_DPDES] == 0);
+    nested_save_state(spapr_cpu->nested_host_state, cpu);
+
+    len = sizeof(*regs);
+    regs = address_space_map(CPU(cpu)->as, regs_ptr, &len, false,
+                                MEMTXATTRS_UNSPECIFIED);
+    if (!regs || len != sizeof(*regs)) {
+        address_space_unmap(CPU(cpu)->as, regs, len, 0, false);
+        g_free(spapr_cpu->nested_host_state);
+        return H_P2;
+    }
+
+    len = sizeof(l2_state.gpr);
+    assert(len == sizeof(regs->gpr));
+    memcpy(l2_state.gpr, regs->gpr, len);
+
+    l2_state.lr = regs->link;
+    l2_state.ctr = regs->ctr;
+    l2_state.xer = regs->xer;
+    l2_state.cr = regs->ccr;
+    l2_state.msr = regs->msr;
+    l2_state.nip = regs->nip;
+
+    address_space_unmap(CPU(cpu)->as, regs, len, len, false);
+
+    l2_state.cfar = hv_state.cfar;
+    l2_state.lpidr = hv_state.lpid;
+
+    lpcr_mask = LPCR_DPFD | LPCR_ILE | LPCR_AIL | LPCR_LD | LPCR_MER;
+    lpcr = (env->spr[SPR_LPCR] & ~lpcr_mask) | (hv_state.lpcr & lpcr_mask);
+    lpcr |= LPCR_HR | LPCR_UPRT | LPCR_GTSE | LPCR_HVICE | LPCR_HDICE;
+    lpcr &= ~LPCR_LPES0;
+    l2_state.lpcr = lpcr & pcc->lpcr_mask;
+
+    l2_state.pcr = hv_state.pcr;
+    /* hv_state.amor is not used */
+    l2_state.dpdes = hv_state.dpdes;
+    l2_state.hfscr = hv_state.hfscr;
+    /* TCG does not implement DAWR*, CIABR, PURR, SPURR, IC, VTB, HEIR SPRs*/
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
+
+    hdec = hv_state.hdec_expiry - now;
+    cpu_ppc_hdecr_init(env);
+    cpu_ppc_store_hdecr(env, hdec);
+
+    /*
+     * The hv_state.vcpu_token is not needed. It is used by the KVM
+     * implementation to remember which L2 vCPU last ran on which physical
+     * CPU so as to invalidate process scope translations if it is moved
+     * between physical CPUs. For now TLBs are always flushed on L1<->L2
+     * transitions so this is not a problem.
+     *
+     * Could validate that the same vcpu_token does not attempt to run on
+     * different L1 vCPUs at the same time, but that would be a L1 KVM bug
+     * and it's not obviously worth a new data structure to do it.
+     */
+
+    spapr_cpu->in_nested = true;
+
+    /*
+     * The spapr hcall helper sets env->gpr[3] to the return value, but at
+     * this point the L1 is not returning from the hcall but rather we
+     * start running the L2, so r3 must not be clobbered, so return env->gpr[3]
+     * to leave it unchanged.
+     */
+    return env->gpr[3];
+}
+
+void spapr_exit_nested(PowerPCCPU *cpu, int excp)
+{
+    CPUPPCState *env = &cpu->env;
+    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
+    struct nested_ppc_state l2_state;
+    target_ulong hv_ptr = spapr_cpu->nested_host_state->gpr[4];
+    target_ulong regs_ptr = spapr_cpu->nested_host_state->gpr[5];
+    target_ulong hsrr0, hsrr1, hdar, asdr, hdsisr;
+    struct kvmppc_hv_guest_state *hvstate;
+    struct kvmppc_pt_regs *regs;
+    hwaddr len;
+
+    assert(spapr_cpu->in_nested);
+
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
+    cpu_ppc_hdecr_exit(env);
+
+    spapr_cpu->in_nested = false;
+
+    g_free(spapr_cpu->nested_host_state);
+    spapr_cpu->nested_host_state = NULL;
+
+    len = sizeof(*hvstate);
+    hvstate = address_space_map(CPU(cpu)->as, hv_ptr, &len, true,
+                                MEMTXATTRS_UNSPECIFIED);
+    if (len != sizeof(*hvstate)) {
+        address_space_unmap(CPU(cpu)->as, hvstate, len, 0, true);
+        env->gpr[3] = H_PARAMETER;
+        return;
+    }
+
+    hvstate->cfar = l2_state.cfar;
+    hvstate->lpcr = l2_state.lpcr;
+    hvstate->pcr = l2_state.pcr;
+    hvstate->dpdes = l2_state.dpdes;
+    hvstate->hfscr = l2_state.hfscr;
+
+    if (excp == POWERPC_EXCP_HDSI) {
+        hvstate->hdar = hdar;
+        hvstate->hdsisr = hdsisr;
+        hvstate->asdr = asdr;
+    } else if (excp == POWERPC_EXCP_HISI) {
+        hvstate->asdr = asdr;
+    }
+
+    /* HEIR should be implemented for HV mode and saved here. */
+    hvstate->srr0 = l2_state.srr0;
+    hvstate->srr1 = l2_state.srr1;
+    hvstate->sprg[0] = l2_state.sprg0;
+    hvstate->sprg[1] = l2_state.sprg1;
+    hvstate->sprg[2] = l2_state.sprg2;
+    hvstate->sprg[3] = l2_state.sprg3;
+    hvstate->pidr = l2_state.pidr;
+    hvstate->ppr = l2_state.ppr;
+
+    /* Is it okay to specify write length larger than actual data written? */
+    address_space_unmap(CPU(cpu)->as, hvstate, len, len, true);
+
+    len = sizeof(*regs);
+    regs = address_space_map(CPU(cpu)->as, regs_ptr, &len, true,
+                                MEMTXATTRS_UNSPECIFIED);
+    if (!regs || len != sizeof(*regs)) {
+        address_space_unmap(CPU(cpu)->as, regs, len, 0, true);
+        env->gpr[3] = H_P2;
+        return;
+    }
+
+    len = sizeof(env->gpr);
+    assert(len == sizeof(regs->gpr));
+    memcpy(regs->gpr, l2_state.gpr, len);
+
+    regs->link = l2_state.lr;
+    regs->ctr = l2_state.ctr;
+    regs->xer = l2_state.xer;
+    regs->ccr = l2_state.cr;
+
+    if (excp == POWERPC_EXCP_MCHECK ||
+        excp == POWERPC_EXCP_RESET ||
+        excp == POWERPC_EXCP_SYSCALL) {
+        regs->nip = l2_state.srr0;
+        regs->msr = l2_state.srr1 & env->msr_mask;
+    } else {
+        regs->nip = hsrr0;
+        regs->msr = hsrr1 & env->msr_mask;
+    }
+
+    /* Is it okay to specify write length larger than actual data written? */
+    address_space_unmap(CPU(cpu)->as, regs, len, len, true);
+}
+
+void spapr_register_nested(void)
+{
+    spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
+    spapr_register_hypercall(KVMPPC_H_ENTER_NESTED, h_enter_nested);
+    spapr_register_hypercall(KVMPPC_H_TLB_INVALIDATE, h_tlb_invalidate);
+    spapr_register_hypercall(KVMPPC_H_COPY_TOFROM_GUEST, h_copy_tofrom_guest);
+}
+#else
+void spapr_exit_nested(PowerPCCPU *cpu, int excp)
+{
+    g_assert_not_reached();
+}
+
+void spapr_register_nested(void)
+{
+    /* DO NOTHING */
+}
+#endif
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index c927337da0ed..a313d4b964ad 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -15,6 +15,7 @@ ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files(
   'spapr_vio.c',
   'spapr_events.c',
   'spapr_hcall.c',
+  'spapr_nested.c',
   'spapr_iommu.c',
   'spapr_rtas.c',
   'spapr_pci.c',
-- 
2.41.0


