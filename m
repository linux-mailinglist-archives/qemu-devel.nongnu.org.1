Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B327C6B87
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 12:52:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqtHX-0001hY-6A; Thu, 12 Oct 2023 06:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qqtHG-0001KW-IK; Thu, 12 Oct 2023 06:50:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qqtHE-00058t-2k; Thu, 12 Oct 2023 06:50:50 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CAlNel007292; Thu, 12 Oct 2023 10:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=oqph8jc2qh030pEnhBFI042bMPGJbX1nDUaTqe/EYV0=;
 b=AOiJDYSO9BDwtkJA4PjH7EcmllwikDSBzBr+NGscRr8elN4KieJ6b7kYR5TnmpFHfm8E
 lDCM6aP20gaociRod++pDsxAw9BvI6FHCGhkQa1EQW6gb+6JuQtfNsguQBvFrQmkvm54
 ofVXmF7esPan3qPVfmCTvwCdKjdyDGO/+h1YjELfvOJFvAZzoaqPGN95KQ4IEaoVsPvq
 0qZKVGoLC+FoBaqEYty/Owzy/rwGFVyts+5s4m0EfHTF0PMWXWw+hWZJbGilB/C2ZZN7
 FjJzpf5qqzUpSi/5plpBJkXbx/vydrXpswPhpCqVzpQnZ4cxJQAO45dbiBPfBEv2OgPu Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpfbr02tu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:43 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CAmblh010719;
 Thu, 12 Oct 2023 10:50:43 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpfbr02tj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:43 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39C8NT0U001270; Thu, 12 Oct 2023 10:50:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkkvk6h4t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:42 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39CAod4n24314384
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Oct 2023 10:50:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9F6220040;
 Thu, 12 Oct 2023 10:50:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E74320043;
 Thu, 12 Oct 2023 10:50:37 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.129])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Oct 2023 10:50:36 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, qemu-devel@nongnu.org, mikey@neuling.org,
 vaibhav@linux.ibm.com, jniethe5@gmail.com, sbhat@linux.ibm.com,
 kconsul@linux.vnet.ibm.com, danielhb413@gmail.com
Subject: [PATCH v2 14/14] spapr: nested: Introduce H_GUEST_RUN_VCPU hcall.
Date: Thu, 12 Oct 2023 16:19:51 +0530
Message-Id: <20231012104951.194876-15-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231012104951.194876-1-harshpb@linux.ibm.com>
References: <20231012104951.194876-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HmUanPXsKbdjjmxryXF4BbOD40aPrsJc
X-Proofpoint-GUID: cyikJG5D0qcGnMkBcLlzJYSAXDx_aFPA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=912
 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0 mlxscore=0
 spamscore=0 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120088
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

The H_GUEST_RUN_VCPU hcall is used to start execution of a Guest VCPU.
The Hypervisor will update the state of the Guest VCPU based on the
input buffer, restore the saved Guest VCPU state, and start its execution.

The Guest VCPU can stop running for numerous reasons including HCALLs,
hypervisor exceptions, or an outstanding Host Partition Interrupt.
The reason that the Guest VCPU stopped running is communicated through
R4 and the output buffer will be filled in with any relevant state.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr_nested.c           | 308 ++++++++++++++++++++++++++++++--
 include/hw/ppc/spapr.h          |   1 +
 include/hw/ppc/spapr_cpu_core.h |   7 +-
 3 files changed, 302 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index e2d0cb5559..d3e7629f63 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -141,6 +141,15 @@ static void nested_save_state(struct nested_ppc_state *save, PowerPCCPU *cpu)
     save->tb_offset = env->tb_env->tb_offset;
 }
 
+static void nested_post_state_update(CPUPPCState *env, CPUState *cs)
+{
+    hreg_compute_hflags(env);
+    ppc_maybe_interrupt(env);
+    tlb_flush(cs);
+    env->reserve_addr = -1; /* Reset the reservation */
+
+}
+
 static void nested_load_state(PowerPCCPU *cpu, struct nested_ppc_state *load)
 {
     CPUState *cs = CPU(cpu);
@@ -172,19 +181,7 @@ static void nested_load_state(PowerPCCPU *cpu, struct nested_ppc_state *load)
     env->spr[SPR_PPR] = load->ppr;
 
     env->tb_env->tb_offset = load->tb_offset;
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
+    nested_post_state_update(env, cs);
 }
 
 /*
@@ -426,6 +423,9 @@ static void spapr_exit_nested_hv(PowerPCCPU *cpu, int excp)
     address_space_unmap(CPU(cpu)->as, regs, len, len, true);
 }
 
+static
+void spapr_exit_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cpu, int excp);
+
 void spapr_exit_nested(PowerPCCPU *cpu, int excp)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
@@ -434,6 +434,10 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
     assert(spapr_cpu->in_nested);
     if (spapr->nested.api == NESTED_API_KVM_HV) {
         spapr_exit_nested_hv(cpu, excp);
+    } else if (spapr->nested.api == NESTED_API_PAPR) {
+        spapr_exit_nested_papr(spapr, cpu, excp);
+    } else {
+        g_assert_not_reached();
     }
 }
 
@@ -1455,6 +1459,283 @@ static target_ulong h_guest_get_state(PowerPCCPU *cpu,
     return h_guest_getset_state(cpu, spapr, args, false);
 }
 
+static void restore_common_regs(CPUPPCState *dst, CPUPPCState *src)
+{
+    memcpy(dst->gpr, src->gpr, sizeof(dst->gpr));
+    memcpy(dst->crf, src->crf, sizeof(dst->crf));
+    memcpy(dst->vsr, src->vsr, sizeof(dst->vsr));
+    dst->nip = src->nip;
+    dst->msr = src->msr;
+    dst->lr  = src->lr;
+    dst->ctr = src->ctr;
+    dst->cfar = src->cfar;
+    cpu_write_xer(dst, src->xer);
+    ppc_store_vscr(dst, ppc_get_vscr(src));
+    ppc_store_fpscr(dst, src->fpscr);
+    memcpy(dst->spr, src->spr, sizeof(dst->spr));
+}
+
+static void exit_nested_restore_vcpu(PowerPCCPU *cpu, int excp,
+                                     SpaprMachineStateNestedGuestVcpu *vcpu)
+{
+    CPUPPCState *env = &cpu->env;
+    target_ulong now, hdar, hdsisr, asdr;
+
+    assert(sizeof(env->gpr) == sizeof(vcpu->env.gpr)); /* sanity check */
+
+    now = cpu_ppc_load_tbl(env); /* L2 timebase */
+    now -= vcpu->tb_offset; /* L1 timebase */
+    vcpu->dec_expiry_tb = now - cpu_ppc_load_decr(env);
+    /* backup hdar, hdsisr, asdr if reqd later below */
+    hdar   = vcpu->env.spr[SPR_HDAR];
+    hdsisr = vcpu->env.spr[SPR_HDSISR];
+    asdr   = vcpu->env.spr[SPR_ASDR];
+
+    restore_common_regs(&vcpu->env, env);
+
+    if (excp == POWERPC_EXCP_MCHECK ||
+        excp == POWERPC_EXCP_RESET ||
+        excp == POWERPC_EXCP_SYSCALL) {
+        vcpu->env.nip = env->spr[SPR_SRR0];
+        vcpu->env.msr = env->spr[SPR_SRR1] & env->msr_mask;
+    } else {
+        vcpu->env.nip = env->spr[SPR_HSRR0];
+        vcpu->env.msr = env->spr[SPR_HSRR1] & env->msr_mask;
+    }
+
+    /* hdar, hdsisr, asdr should be retained unless certain exceptions */
+    if ((excp != POWERPC_EXCP_HDSI) && (excp != POWERPC_EXCP_HISI)) {
+        vcpu->env.spr[SPR_ASDR] = asdr;
+    } else if (excp != POWERPC_EXCP_HDSI) {
+        vcpu->env.spr[SPR_HDAR]   = hdar;
+        vcpu->env.spr[SPR_HDSISR] = hdsisr;
+    }
+}
+
+static int get_exit_ids(uint64_t srr0, uint16_t ids[16])
+{
+    int nr;
+
+    switch (srr0) {
+    case 0xc00:
+        nr = 10;
+        ids[0] = GSB_VCPU_GPR3;
+        ids[1] = GSB_VCPU_GPR4;
+        ids[2] = GSB_VCPU_GPR5;
+        ids[3] = GSB_VCPU_GPR6;
+        ids[4] = GSB_VCPU_GPR7;
+        ids[5] = GSB_VCPU_GPR8;
+        ids[6] = GSB_VCPU_GPR9;
+        ids[7] = GSB_VCPU_GPR10;
+        ids[8] = GSB_VCPU_GPR11;
+        ids[9] = GSB_VCPU_GPR12;
+        break;
+    case 0xe00:
+        nr = 5;
+        ids[0] = GSB_VCPU_SPR_HDAR;
+        ids[1] = GSB_VCPU_SPR_HDSISR;
+        ids[2] = GSB_VCPU_SPR_ASDR;
+        ids[3] = GSB_VCPU_SPR_NIA;
+        ids[4] = GSB_VCPU_SPR_MSR;
+        break;
+    case 0xe20:
+        nr = 4;
+        ids[0] = GSB_VCPU_SPR_HDAR;
+        ids[1] = GSB_VCPU_SPR_ASDR;
+        ids[2] = GSB_VCPU_SPR_NIA;
+        ids[3] = GSB_VCPU_SPR_MSR;
+        break;
+    case 0xe40:
+        nr = 3;
+        ids[0] = GSB_VCPU_SPR_HEIR;
+        ids[1] = GSB_VCPU_SPR_NIA;
+        ids[2] = GSB_VCPU_SPR_MSR;
+        break;
+    case 0xf80:
+        nr = 3;
+        ids[0] = GSB_VCPU_SPR_HFSCR;
+        ids[1] = GSB_VCPU_SPR_NIA;
+        ids[2] = GSB_VCPU_SPR_MSR;
+        break;
+    default:
+        nr = 0;
+        break;
+    }
+
+    return nr;
+}
+
+static void exit_process_output_buffer(PowerPCCPU *cpu,
+                                      SpaprMachineStateNestedGuest *guest,
+                                      target_ulong vcpuid,
+                                      target_ulong *r3)
+{
+    SpaprMachineStateNestedGuestVcpu *vcpu = &guest->vcpu[vcpuid];
+    struct guest_state_request gsr;
+    struct guest_state_buffer *gsb;
+    struct guest_state_element *element;
+    struct guest_state_element_type *type;
+    int exit_id_count = 0;
+    uint16_t exit_cause_ids[16];
+    hwaddr len;
+
+    len = vcpu->runbufout.size;
+    gsb = address_space_map(CPU(cpu)->as, vcpu->runbufout.addr, &len, true,
+                            MEMTXATTRS_UNSPECIFIED);
+    if (!gsb || len != vcpu->runbufout.size) {
+        address_space_unmap(CPU(cpu)->as, gsb, len, true, len);
+        *r3 = H_P2;
+        return;
+    }
+
+    exit_id_count = get_exit_ids(*r3, exit_cause_ids);
+
+    /* Create a buffer of elements to send back */
+    gsb->num_elements = cpu_to_be32(exit_id_count);
+    element = gsb->elements;
+    for (int i = 0; i < exit_id_count; i++) {
+        type = guest_state_element_type_find(exit_cause_ids[i]);
+        assert(type);
+        element->id = cpu_to_be16(exit_cause_ids[i]);
+        element->size = cpu_to_be16(type->size);
+        element = guest_state_element_next(element, NULL, NULL);
+    }
+    gsr.gsb = gsb;
+    gsr.len = VCPU_OUT_BUF_MIN_SZ;
+    gsr.flags = 0; /* get + never guest wide */
+    getset_state(guest, vcpuid, &gsr);
+
+    address_space_unmap(CPU(cpu)->as, gsb, len, true, len);
+    return;
+}
+
+static
+void spapr_exit_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cpu, int excp)
+{
+    CPUState *cs = CPU(cpu);
+    CPUPPCState *env = &cpu->env;
+    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
+    target_ulong r3_return = env->excp_vectors[excp]; /* hcall return value */
+    target_ulong lpid = 0, vcpuid = 0;
+    struct SpaprMachineStateNestedGuestVcpu *vcpu = NULL;
+    struct SpaprMachineStateNestedGuest *guest = NULL;
+
+    lpid = spapr_cpu->nested_papr_host->gpr[5];
+    vcpuid = spapr_cpu->nested_papr_host->gpr[6];
+    guest = spapr_get_nested_guest(spapr, lpid);
+    assert(guest);
+    spapr_nested_vcpu_check(guest, vcpuid, false);
+    vcpu = &guest->vcpu[vcpuid];
+
+    exit_nested_restore_vcpu(cpu, excp, vcpu);
+    /* do the output buffer for run_vcpu*/
+    exit_process_output_buffer(cpu, guest, vcpuid, &r3_return);
+
+    assert(env->spr[SPR_LPIDR] != 0);
+    restore_common_regs(env, spapr_cpu->nested_papr_host);
+    env->tb_env->tb_offset -= vcpu->tb_offset;
+    env->gpr[3] = H_SUCCESS;
+    env->gpr[4] = r3_return;
+    nested_post_state_update(env, cs);
+    cpu_ppc_hdecr_exit(env);
+
+    spapr_cpu->in_nested = false;
+    g_free(spapr_cpu->nested_papr_host);
+    spapr_cpu->nested_papr_host = NULL;
+}
+
+static void nested_papr_restore_l2_state(PowerPCCPU *cpu,
+                                         CPUPPCState *env,
+                                         SpaprMachineStateNestedGuestVcpu *vcpu,
+                                         target_ulong now)
+{
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    target_ulong lpcr, lpcr_mask, hdec;
+    lpcr_mask = LPCR_DPFD | LPCR_ILE | LPCR_AIL | LPCR_LD | LPCR_MER;
+
+    assert(vcpu);
+    assert(sizeof(env->gpr) == sizeof(vcpu->env.gpr));
+    restore_common_regs(env, &vcpu->env);
+    lpcr = (env->spr[SPR_LPCR] & ~lpcr_mask) |
+           (vcpu->env.spr[SPR_LPCR] & lpcr_mask);
+    lpcr |= LPCR_HR | LPCR_UPRT | LPCR_GTSE | LPCR_HVICE | LPCR_HDICE;
+    lpcr &= ~LPCR_LPES0;
+    env->spr[SPR_LPCR] = lpcr & pcc->lpcr_mask;
+
+    hdec = vcpu->hdecr_expiry_tb - now;
+    cpu_ppc_store_decr(env, vcpu->dec_expiry_tb - now);
+    cpu_ppc_hdecr_init(env);
+    cpu_ppc_store_hdecr(env, hdec);
+
+    env->tb_env->tb_offset += vcpu->tb_offset;
+}
+
+static void nested_papr_run_vcpu(PowerPCCPU *cpu,
+                                 uint64_t lpid,
+                                 SpaprMachineStateNestedGuestVcpu *vcpu)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    CPUState *cs = CPU(cpu);
+    CPUPPCState *env = &cpu->env;
+    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
+    target_ulong now = cpu_ppc_load_tbl(env);
+
+    assert(env->spr[SPR_LPIDR] == 0);
+    assert(spapr->nested.api); /* ensure API version is initialized */
+    spapr_cpu->nested_papr_host = g_try_new(CPUPPCState, 1);
+    assert(spapr_cpu->nested_papr_host);
+    memcpy(spapr_cpu->nested_papr_host, env, sizeof(CPUPPCState));
+
+    nested_papr_restore_l2_state(cpu, env, vcpu, now);
+    env->spr[SPR_LPIDR] = lpid; /* post restore l2 state */
+
+    spapr_cpu->in_nested = true;
+
+    nested_post_state_update(env, cs);
+}
+
+static target_ulong h_guest_run_vcpu(PowerPCCPU *cpu,
+                                     SpaprMachineState *spapr,
+                                     target_ulong opcode,
+                                     target_ulong *args)
+{
+    CPUPPCState *env = &cpu->env;
+    target_ulong flags = args[0];
+    target_ulong lpid = args[1];
+    target_ulong vcpuid = args[2];
+    struct SpaprMachineStateNestedGuestVcpu *vcpu;
+    struct guest_state_request gsr;
+    SpaprMachineStateNestedGuest *guest;
+
+    if (flags) /* don't handle any flags for now */
+        return H_PARAMETER;
+
+    guest = spapr_get_nested_guest(spapr, lpid);
+    if (!guest) {
+        return H_P2;
+    }
+    if (!spapr_nested_vcpu_check(guest, vcpuid, true)) {
+        return H_P3;
+    }
+
+    if (guest->parttbl[0] == 0) {
+        /* At least need a partition scoped radix tree */
+        return H_NOT_AVAILABLE;
+    }
+
+    vcpu = &guest->vcpu[vcpuid];
+
+    /* Read run_vcpu input buffer to update state */
+    gsr.buf = vcpu->runbufin.addr;
+    gsr.len = vcpu->runbufin.size;
+    gsr.flags = GUEST_STATE_REQUEST_SET; /* Thread wide + writing */
+    if (!map_and_getset_state(cpu, guest, vcpuid, &gsr)) {
+        nested_papr_run_vcpu(cpu, lpid, vcpu);
+    }
+
+    return env->gpr[3];
+}
+
 void spapr_register_nested(void)
 {
     spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
@@ -1473,6 +1754,7 @@ void spapr_register_nested_papr(void)
     spapr_register_hypercall(H_GUEST_CREATE_VCPU     , h_guest_create_vcpu);
     spapr_register_hypercall(H_GUEST_SET_STATE       , h_guest_set_state);
     spapr_register_hypercall(H_GUEST_GET_STATE       , h_guest_get_state);
+    spapr_register_hypercall(H_GUEST_RUN_VCPU        , h_guest_run_vcpu);
 }
 #else
 void spapr_exit_nested(PowerPCCPU *cpu, int excp)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index b9a67895bb..e278ddc7cf 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -594,6 +594,7 @@ struct SpaprMachineState {
 #define H_GUEST_CREATE_VCPU      0x474
 #define H_GUEST_GET_STATE        0x478
 #define H_GUEST_SET_STATE        0x47C
+#define H_GUEST_RUN_VCPU         0x480
 #define H_GUEST_DELETE           0x488
 
 #define MAX_HCALL_OPCODE         H_GUEST_DELETE
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
index 9c8c59f173..a9749a2df1 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -53,7 +53,12 @@ typedef struct SpaprCpuState {
 
     /* Fields for nested-HV support */
     bool in_nested; /* true while the L2 is executing */
-    struct nested_ppc_state *nested_hv_host; /* holds the L1 state while L2 executes */
+    union {
+        /* holds the L1 state while L2 executes */
+        struct nested_ppc_state *nested_hv_host;
+        CPUPPCState             *nested_papr_host;
+    };
+
 } SpaprCpuState;
 
 static inline SpaprCpuState *spapr_cpu_state(PowerPCCPU *cpu)
-- 
2.39.3


