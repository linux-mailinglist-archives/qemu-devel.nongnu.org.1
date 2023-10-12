Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC557C6B09
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 12:25:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqsrR-0001El-Fa; Thu, 12 Oct 2023 06:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qqsrO-0001EJ-Px; Thu, 12 Oct 2023 06:24:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qqsrL-0006g4-E7; Thu, 12 Oct 2023 06:24:06 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CAFxnh004573; Thu, 12 Oct 2023 10:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=jkGuNpzq6D9PeJfnOMCipZJYNt3g6+XyY3AJ1FShEoQ=;
 b=QkmKt4wOxTQ1lQClwyPqwd8AlpC1O9r7jX3XpY6W56Tco8ju/yUCY5t3DEuzw7uR8iOu
 6pA3ltV//h1sfKhW4YERg1RTTfnOU0RVTxTtMzzfhtoqGSYrRDsYiW61kflKp+E6pLd0
 w1vP0uRYzjKaYHBQWEPzDPudyiy+kfq68Rl5cQA/NupRwuK8gCa4feni/ZZ5lW3VOsh8
 6o3j34JD/MwIU6rLe+vt0YByTTY5Xms9qJl994VBOIGpuhyWSYHJnW4KWQKjhspinnPp
 C4uLe8h0fhRCUAN97edPbInZAW4i/aRqT8cL5XrYVnHfNg7204fr+C2LLiL/YHdm93BL VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpeb097k2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:23:55 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CAEwdG000519;
 Thu, 12 Oct 2023 10:23:54 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpeb097jb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:23:54 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39C9mjvp025883; Thu, 12 Oct 2023 10:23:53 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkjnnpt56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:23:53 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39CANqb611469502
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Oct 2023 10:23:52 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23D6958059;
 Thu, 12 Oct 2023 10:23:52 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5DEA58043;
 Thu, 12 Oct 2023 10:23:48 +0000 (GMT)
Received: from [9.109.242.129] (unknown [9.109.242.129])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Oct 2023 10:23:48 +0000 (GMT)
Message-ID: <1422e2ad-b45b-5fe9-e2f3-df6f278bcba2@linux.ibm.com>
Date: Thu, 12 Oct 2023 15:53:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RESEND 13/15] ppc: spapr: Implement nested PAPR hcall -
 H_GUEST_RUN_VCPU
To: Nicholas Piggin <npiggin@gmail.com>, danielhb413@gmail.com,
 qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, mikey@neuling.org, vaibhav@linux.ibm.com,
 jniethe5@gmail.com, sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
 <20230906043333.448244-14-harshpb@linux.ibm.com>
 <CVCDS2JE96GO.28S7VHXGJSODJ@wheely>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CVCDS2JE96GO.28S7VHXGJSODJ@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TkbYG35N2_Lt7gPkiPsj9oEnxcFWUYE1
X-Proofpoint-GUID: uZVpdkvLAd4jAdkZWT76ppfcgiXYU57N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 clxscore=1015 spamscore=0 mlxscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120085
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 9/7/23 09:25, Nicholas Piggin wrote:
> On Wed Sep 6, 2023 at 2:33 PM AEST, Harsh Prateek Bora wrote:
>> Once the L1 has created a nested guest and its associated VCPU, it can
>> request for the execution of nested guest by setting its initial state
>> which can be done either using the h_guest_set_state or using the input
>> buffers along with the call to h_guest_run_vcpu(). On guest exit, L0
>> uses output buffers to convey the exit cause to the L1. L0 takes care of
>> switching context from L1 to L2 during guest entry and restores L1 context
>> on guest exit.
>>
>> Unlike nested-hv, L2 (nested) guest's entire state is retained with
>> L0 after guest exit and restored on next entry in case of nested-papr.
>>
>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>> Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   hw/ppc/spapr_nested.c           | 471 +++++++++++++++++++++++++++-----
>>   include/hw/ppc/spapr_cpu_core.h |   7 +-
>>   include/hw/ppc/spapr_nested.h   |   6 +
>>   3 files changed, 408 insertions(+), 76 deletions(-)
>>
>> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
>> index 67e389a762..3605f27115 100644
>> --- a/hw/ppc/spapr_nested.c
>> +++ b/hw/ppc/spapr_nested.c
>> @@ -12,6 +12,17 @@
>>   #ifdef CONFIG_TCG
>>   #define PRTS_MASK      0x1f
>>   
>> +static void exit_nested_restore_vcpu(PowerPCCPU *cpu, int excp,
>> +                                     SpaprMachineStateNestedGuestVcpu *vcpu);
>> +static void exit_process_output_buffer(PowerPCCPU *cpu,
>> +                                      SpaprMachineStateNestedGuest *guest,
>> +                                      target_ulong vcpuid,
>> +                                      target_ulong *r3);
>> +static void restore_common_regs(CPUPPCState *dst, CPUPPCState *src);
>> +static bool vcpu_check(SpaprMachineStateNestedGuest *guest,
>> +                       target_ulong vcpuid,
>> +                       bool inoutbuf);
>> +
>>   static target_ulong h_set_ptbl(PowerPCCPU *cpu,
>>                                  SpaprMachineState *spapr,
>>                                  target_ulong opcode,
>> @@ -187,21 +198,21 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
>>           return H_PARAMETER;
>>       }
>>   
>> -    spapr_cpu->nested_host_state = g_try_new(struct nested_ppc_state, 1);
>> -    if (!spapr_cpu->nested_host_state) {
>> +    spapr_cpu->nested_hv_host = g_try_new(struct nested_ppc_state, 1);
>> +    if (!spapr_cpu->nested_hv_host) {
>>           return H_NO_MEM;
>>       }
> 
> Don't rename existing thing in the same patch as adding new thing.
> 

Sure, renaming in a separate patch before this patch.

>>   
>>       assert(env->spr[SPR_LPIDR] == 0);
>>       assert(env->spr[SPR_DPDES] == 0);
>> -    nested_save_state(spapr_cpu->nested_host_state, cpu);
>> +    nested_save_state(spapr_cpu->nested_hv_host, cpu);
>>   
>>       len = sizeof(*regs);
>>       regs = address_space_map(CPU(cpu)->as, regs_ptr, &len, false,
>>                                   MEMTXATTRS_UNSPECIFIED);
>>       if (!regs || len != sizeof(*regs)) {
>>           address_space_unmap(CPU(cpu)->as, regs, len, 0, false);
>> -        g_free(spapr_cpu->nested_host_state);
>> +        g_free(spapr_cpu->nested_hv_host);
>>           return H_P2;
>>       }
>>   
>> @@ -276,105 +287,146 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
>>   
>>   void spapr_exit_nested(PowerPCCPU *cpu, int excp)
>>   {
>> +    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>> +    CPUState *cs = CPU(cpu);
> 
> I think it would be worth seeing how it looks to split these into
> original and papr functions rather than try mash them together.
> 

Yeh, that really sounds better approach. Updated patch to keep nested-hv 
code untouched and keeping both API code flows isolated.

>>       CPUPPCState *env = &cpu->env;
>>       SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
>> +    target_ulong r3_return = env->excp_vectors[excp]; /* hcall return value */
>>       struct nested_ppc_state l2_state;
>> -    target_ulong hv_ptr = spapr_cpu->nested_host_state->gpr[4];
>> -    target_ulong regs_ptr = spapr_cpu->nested_host_state->gpr[5];
>> -    target_ulong hsrr0, hsrr1, hdar, asdr, hdsisr;
>> +    target_ulong hv_ptr, regs_ptr;
>> +    target_ulong hsrr0 = 0, hsrr1 = 0, hdar = 0, asdr = 0, hdsisr = 0;
>>       struct kvmppc_hv_guest_state *hvstate;
>>       struct kvmppc_pt_regs *regs;
>>       hwaddr len;
>> +    target_ulong lpid = 0, vcpuid = 0;
>> +    struct SpaprMachineStateNestedGuestVcpu *vcpu = NULL;
>> +    struct SpaprMachineStateNestedGuest *guest = NULL;
>>   
>>       assert(spapr_cpu->in_nested);
>> -
>> -    nested_save_state(&l2_state, cpu);
>> -    hsrr0 = env->spr[SPR_HSRR0];
>> -    hsrr1 = env->spr[SPR_HSRR1];
>> -    hdar = env->spr[SPR_HDAR];
>> -    hdsisr = env->spr[SPR_HDSISR];
>> -    asdr = env->spr[SPR_ASDR];
>> +    if (spapr->nested.api == NESTED_API_KVM_HV) {
>> +        nested_save_state(&l2_state, cpu);
>> +        hsrr0 = env->spr[SPR_HSRR0];
>> +        hsrr1 = env->spr[SPR_HSRR1];
>> +        hdar = env->spr[SPR_HDAR];
>> +        hdsisr = env->spr[SPR_HDSISR];
>> +        asdr = env->spr[SPR_ASDR];
>> +    } else if (spapr->nested.api == NESTED_API_PAPR) {
>> +        lpid = spapr_cpu->nested_papr_host->gpr[5];
>> +        vcpuid = spapr_cpu->nested_papr_host->gpr[6];
>> +        guest = spapr_get_nested_guest(spapr, lpid);
>> +        assert(guest);
>> +        vcpu_check(guest, vcpuid, false);
>> +        vcpu = &guest->vcpu[vcpuid];
>> +
>> +        exit_nested_restore_vcpu(cpu, excp, vcpu);
>> +        /* do the output buffer for run_vcpu*/
>> +        exit_process_output_buffer(cpu, guest, vcpuid, &r3_return);
>> +    } else
>> +        g_assert_not_reached();
>>   
>>       /*
>>        * Switch back to the host environment (including for any error).
>>        */
>>       assert(env->spr[SPR_LPIDR] != 0);
>> -    nested_load_state(cpu, spapr_cpu->nested_host_state);
>> -    env->gpr[3] = env->excp_vectors[excp]; /* hcall return value */
>>   
>> -    cpu_ppc_hdecr_exit(env);
>> +    if (spapr->nested.api == NESTED_API_KVM_HV) {
>> +        nested_load_state(cpu, spapr_cpu->nested_hv_host);
>> +        env->gpr[3] = r3_return;
>> +    } else if (spapr->nested.api == NESTED_API_PAPR) {
>> +        restore_common_regs(env, spapr_cpu->nested_papr_host);
>> +        env->tb_env->tb_offset -= vcpu->tb_offset;
>> +        env->gpr[3] = H_SUCCESS;
>> +        env->gpr[4] = r3_return;
>> +        hreg_compute_hflags(env);
>> +        ppc_maybe_interrupt(env);
>> +        tlb_flush(cs);
>> +        env->reserve_addr = -1; /* Reset the reservation */
> 
> There's a bunch of stuff that's getting duplicated anyway, so
> it's actually not clear that this maze of if statements makes
> it simpler to see that nothing is missed.
> 

Yeh, refactored to keep separate routines for both nested-hv and 
nested-papr to avoid touching existing logic for nested-hv API.

>> +    }
>>   
>> -    spapr_cpu->in_nested = false;
>> +    cpu_ppc_hdecr_exit(env);
>>   
>> -    g_free(spapr_cpu->nested_host_state);
>> -    spapr_cpu->nested_host_state = NULL;
>> +    if (spapr->nested.api == NESTED_API_KVM_HV) {
>> +        hv_ptr = spapr_cpu->nested_hv_host->gpr[4];
>> +        regs_ptr = spapr_cpu->nested_hv_host->gpr[5];
>> +
>> +        len = sizeof(*hvstate);
>> +        hvstate = address_space_map(CPU(cpu)->as, hv_ptr, &len, true,
>> +                                    MEMTXATTRS_UNSPECIFIED);
>> +        if (len != sizeof(*hvstate)) {
>> +            address_space_unmap(CPU(cpu)->as, hvstate, len, 0, true);
>> +            env->gpr[3] = H_PARAMETER;
>> +            return;
>> +        }
>>   
>> -    len = sizeof(*hvstate);
>> -    hvstate = address_space_map(CPU(cpu)->as, hv_ptr, &len, true,
>> -                                MEMTXATTRS_UNSPECIFIED);
>> -    if (len != sizeof(*hvstate)) {
>> -        address_space_unmap(CPU(cpu)->as, hvstate, len, 0, true);
>> -        env->gpr[3] = H_PARAMETER;
>> -        return;
>> -    }
>> +        hvstate->cfar = l2_state.cfar;
>> +        hvstate->lpcr = l2_state.lpcr;
>> +        hvstate->pcr = l2_state.pcr;
>> +        hvstate->dpdes = l2_state.dpdes;
>> +        hvstate->hfscr = l2_state.hfscr;
>> +
>> +        if (excp == POWERPC_EXCP_HDSI) {
>> +            hvstate->hdar = hdar;
>> +            hvstate->hdsisr = hdsisr;
>> +            hvstate->asdr = asdr;
>> +        } else if (excp == POWERPC_EXCP_HISI) {
>> +            hvstate->asdr = asdr;
>> +        }
>>   
>> -    hvstate->cfar = l2_state.cfar;
>> -    hvstate->lpcr = l2_state.lpcr;
>> -    hvstate->pcr = l2_state.pcr;
>> -    hvstate->dpdes = l2_state.dpdes;
>> -    hvstate->hfscr = l2_state.hfscr;
>> +        /* HEIR should be implemented for HV mode and saved here. */
>> +        hvstate->srr0 = l2_state.srr0;
>> +        hvstate->srr1 = l2_state.srr1;
>> +        hvstate->sprg[0] = l2_state.sprg0;
>> +        hvstate->sprg[1] = l2_state.sprg1;
>> +        hvstate->sprg[2] = l2_state.sprg2;
>> +        hvstate->sprg[3] = l2_state.sprg3;
>> +        hvstate->pidr = l2_state.pidr;
>> +        hvstate->ppr = l2_state.ppr;
>> +
>> +        /* Is it okay to specify write len larger than actual data written? */
>> +        address_space_unmap(CPU(cpu)->as, hvstate, len, len, true);
>> +
>> +        len = sizeof(*regs);
>> +        regs = address_space_map(CPU(cpu)->as, regs_ptr, &len, true,
>> +                                    MEMTXATTRS_UNSPECIFIED);
>> +        if (!regs || len != sizeof(*regs)) {
>> +            address_space_unmap(CPU(cpu)->as, regs, len, 0, true);
>> +            env->gpr[3] = H_P2;
>> +            return;
>> +        }
>>   
>> -    if (excp == POWERPC_EXCP_HDSI) {
>> -        hvstate->hdar = hdar;
>> -        hvstate->hdsisr = hdsisr;
>> -        hvstate->asdr = asdr;
>> -    } else if (excp == POWERPC_EXCP_HISI) {
>> -        hvstate->asdr = asdr;
>> -    }
>> +        len = sizeof(env->gpr);
>> +        assert(len == sizeof(regs->gpr));
>> +        memcpy(regs->gpr, l2_state.gpr, len);
>>   
>> -    /* HEIR should be implemented for HV mode and saved here. */
>> -    hvstate->srr0 = l2_state.srr0;
>> -    hvstate->srr1 = l2_state.srr1;
>> -    hvstate->sprg[0] = l2_state.sprg0;
>> -    hvstate->sprg[1] = l2_state.sprg1;
>> -    hvstate->sprg[2] = l2_state.sprg2;
>> -    hvstate->sprg[3] = l2_state.sprg3;
>> -    hvstate->pidr = l2_state.pidr;
>> -    hvstate->ppr = l2_state.ppr;
>> +        regs->link = l2_state.lr;
>> +        regs->ctr = l2_state.ctr;
>> +        regs->xer = l2_state.xer;
>> +        regs->ccr = l2_state.cr;
>>   
>> -    /* Is it okay to specify write length larger than actual data written? */
>> -    address_space_unmap(CPU(cpu)->as, hvstate, len, len, true);
>> +        if (excp == POWERPC_EXCP_MCHECK ||
>> +            excp == POWERPC_EXCP_RESET ||
>> +            excp == POWERPC_EXCP_SYSCALL) {
>> +            regs->nip = l2_state.srr0;
>> +            regs->msr = l2_state.srr1 & env->msr_mask;
>> +        } else {
>> +            regs->nip = hsrr0;
>> +            regs->msr = hsrr1 & env->msr_mask;
>> +        }
>>   
>> -    len = sizeof(*regs);
>> -    regs = address_space_map(CPU(cpu)->as, regs_ptr, &len, true,
>> -                                MEMTXATTRS_UNSPECIFIED);
>> -    if (!regs || len != sizeof(*regs)) {
>> -        address_space_unmap(CPU(cpu)->as, regs, len, 0, true);
>> -        env->gpr[3] = H_P2;
>> -        return;
>> +        /* Is it okay to specify write len larger than actual data written? */
>> +        address_space_unmap(CPU(cpu)->as, regs, len, len, true);
>>       }
>>   
>> -    len = sizeof(env->gpr);
>> -    assert(len == sizeof(regs->gpr));
>> -    memcpy(regs->gpr, l2_state.gpr, len);
>> -
>> -    regs->link = l2_state.lr;
>> -    regs->ctr = l2_state.ctr;
>> -    regs->xer = l2_state.xer;
>> -    regs->ccr = l2_state.cr;
>> +    spapr_cpu->in_nested = false;
>>   
>> -    if (excp == POWERPC_EXCP_MCHECK ||
>> -        excp == POWERPC_EXCP_RESET ||
>> -        excp == POWERPC_EXCP_SYSCALL) {
>> -        regs->nip = l2_state.srr0;
>> -        regs->msr = l2_state.srr1 & env->msr_mask;
>> +    if (spapr->nested.api == NESTED_API_KVM_HV) {
>> +        g_free(spapr_cpu->nested_hv_host);
>> +        spapr_cpu->nested_hv_host = NULL;
>>       } else {
>> -        regs->nip = hsrr0;
>> -        regs->msr = hsrr1 & env->msr_mask;
>> +        g_free(spapr_cpu->nested_papr_host);
>> +        spapr_cpu->nested_papr_host = NULL;
>>       }
>>   
>> -    /* Is it okay to specify write length larger than actual data written? */
>> -    address_space_unmap(CPU(cpu)->as, regs, len, len, true);
>>   }
>>   
>>   SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *spapr,
>> @@ -1372,6 +1424,274 @@ static target_ulong h_guest_get_state(PowerPCCPU *cpu,
>>       return h_guest_getset_state(cpu, spapr, args, false);
>>   }
>>   
>> +static void restore_common_regs(CPUPPCState *dst, CPUPPCState *src)
>> +{
>> +    memcpy(dst->gpr, src->gpr, sizeof(dst->gpr));
>> +    memcpy(dst->crf, src->crf, sizeof(dst->crf));
>> +    memcpy(dst->vsr, src->vsr, sizeof(dst->vsr));
>> +    dst->nip = src->nip;
>> +    dst->msr = src->msr;
>> +    dst->lr  = src->lr;
>> +    dst->ctr = src->ctr;
>> +    dst->cfar = src->cfar;
>> +    cpu_write_xer(dst, src->xer);
>> +    ppc_store_vscr(dst, ppc_get_vscr(src));
>> +    ppc_store_fpscr(dst, src->fpscr);
>> +    memcpy(dst->spr, src->spr, sizeof(dst->spr));
>> +}
>> +
>> +static void restore_l2_state(PowerPCCPU *cpu,
>> +                             CPUPPCState *env,
>> +                             struct SpaprMachineStateNestedGuestVcpu *vcpu,
>> +                             target_ulong now)
>> +{
>> +    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>> +    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
>> +    target_ulong lpcr, lpcr_mask, hdec;
>> +    lpcr_mask = LPCR_DPFD | LPCR_ILE | LPCR_AIL | LPCR_LD | LPCR_MER;
>> +
>> +    if (spapr->nested.api == NESTED_API_PAPR) {
>> +        assert(vcpu);
>> +        assert(sizeof(env->gpr) == sizeof(vcpu->env.gpr));
>> +        restore_common_regs(env, &vcpu->env);
>> +        lpcr = (env->spr[SPR_LPCR] & ~lpcr_mask) |
>> +               (vcpu->env.spr[SPR_LPCR] & lpcr_mask);
>> +        lpcr |= LPCR_HR | LPCR_UPRT | LPCR_GTSE | LPCR_HVICE | LPCR_HDICE;
>> +        lpcr &= ~LPCR_LPES0;
>> +        env->spr[SPR_LPCR] = lpcr & pcc->lpcr_mask;
>> +
>> +        hdec = vcpu->env.tb_env->hdecr_expiry_tb - now;
>> +        cpu_ppc_store_decr(env, vcpu->dec_expiry_tb - now);
>> +        cpu_ppc_hdecr_init(env);
>> +        cpu_ppc_store_hdecr(env, hdec);
>> +
>> +        env->tb_env->tb_offset += vcpu->tb_offset;
>> +    }
>> +}
>> +
>> +static void enter_nested(PowerPCCPU *cpu,
>> +                         uint64_t lpid,
>> +                         struct SpaprMachineStateNestedGuestVcpu *vcpu)
> 
> That's not good since we have h_enter_nested for the old API. Really
> have to be a bit more consistent with using papr_ for naming I think.
> And you don't have to call this enter_nested anyway, papr_run_vcpu is
> okay too since that matches the API call. Can just add a comment /*
> Enter the L2 VCPU, equivalent to h_enter_nested */ if you think that's
> needed.
> 

Make sense, renaming it to spapr_nested_run_vcpu().

>> +{
>> +    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>> +    CPUState *cs = CPU(cpu);
>> +    CPUPPCState *env = &cpu->env;
>> +    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
>> +    target_ulong now = cpu_ppc_load_tbl(env);
>> +
>> +    assert(env->spr[SPR_LPIDR] == 0);
>> +    assert(spapr->nested.api); /* ensure API version is initialized */
>> +    spapr_cpu->nested_papr_host = g_try_new(CPUPPCState, 1);
>> +    assert(spapr_cpu->nested_papr_host);
>> +    memcpy(spapr_cpu->nested_papr_host, env, sizeof(CPUPPCState));
>> +
>> +    restore_l2_state(cpu, env, vcpu, now);
>> +    env->spr[SPR_LPIDR] = lpid; /* post restore_l2_state */
>> +
>> +    spapr_cpu->in_nested = true;
>> +
>> +    hreg_compute_hflags(env);
>> +    ppc_maybe_interrupt(env);
>> +    tlb_flush(cs);
>> +    env->reserve_addr = -1; /* Reset the reservation */
> 
>         ^^^
>         This is the kind of block that could be pulled into a
>         common helper function. There's 3-4 copies now?

Yeh, introducing helper nested_post_state_update() for this block.

>> +
>> +}
>> +
>> +static target_ulong h_guest_run_vcpu(PowerPCCPU *cpu,
>> +                                     SpaprMachineState *spapr,
>> +                                     target_ulong opcode,
>> +                                     target_ulong *args)
>> +{
>> +    CPUPPCState *env = &cpu->env;
>> +    target_ulong flags = args[0];
>> +    target_ulong lpid = args[1];
>> +    target_ulong vcpuid = args[2];
>> +    struct SpaprMachineStateNestedGuestVcpu *vcpu;
>> +    struct guest_state_request gsr;
>> +    SpaprMachineStateNestedGuest *guest;
>> +
>> +    if (flags) /* don't handle any flags for now */
>> +        return H_PARAMETER;
>> +
>> +    guest = spapr_get_nested_guest(spapr, lpid);
>> +    if (!guest) {
>> +        return H_P2;
>> +    }
>> +    if (!vcpu_check(guest, vcpuid, true)) {
>> +        return H_P3;
>> +    }
>> +
>> +    if (guest->parttbl[0] == 0) {
>> +        /* At least need a partition scoped radix tree */
>> +        return H_NOT_AVAILABLE;
>> +    }
>> +
>> +    vcpu = &guest->vcpu[vcpuid];
>> +
>> +    /* Read run_vcpu input buffer to update state */
>> +    gsr.buf = vcpu->runbufin.addr;
>> +    gsr.len = vcpu->runbufin.size;
>> +    gsr.flags = GUEST_STATE_REQUEST_SET; /* Thread wide + writing */
>> +    if (!map_and_getset_state(cpu, guest, vcpuid, &gsr)) {
>> +        enter_nested(cpu, lpid, vcpu);
>> +    }
>> +
>> +    return env->gpr[3];
>> +}
>> +
>> +struct run_vcpu_exit_cause run_vcpu_exit_causes[] = {
>> +    { .nia = 0x980,
>> +      .count = 0,
>> +    },
>> +    { .nia = 0xc00,
>> +      .count = 10,
>> +      .ids = {
>> +          GSB_VCPU_GPR3,
>> +          GSB_VCPU_GPR4,
>> +          GSB_VCPU_GPR5,
>> +          GSB_VCPU_GPR6,
>> +          GSB_VCPU_GPR7,
>> +          GSB_VCPU_GPR8,
>> +          GSB_VCPU_GPR9,
>> +          GSB_VCPU_GPR10,
>> +          GSB_VCPU_GPR11,
>> +          GSB_VCPU_GPR12,
>> +      },
>> +    },
>> +    { .nia = 0xe00,
>> +      .count = 5,
>> +      .ids = {
>> +          GSB_VCPU_SPR_HDAR,
>> +          GSB_VCPU_SPR_HDSISR,
>> +          GSB_VCPU_SPR_ASDR,
>> +          GSB_VCPU_SPR_NIA,
>> +          GSB_VCPU_SPR_MSR,
>> +      },
>> +    },
>> +    { .nia = 0xe20,
>> +      .count = 4,
>> +      .ids = {
>> +          GSB_VCPU_SPR_HDAR,
>> +          GSB_VCPU_SPR_ASDR,
>> +          GSB_VCPU_SPR_NIA,
>> +          GSB_VCPU_SPR_MSR,
>> +      },
>> +    },
>> +    { .nia = 0xe40,
>> +      .count = 3,
>> +      .ids = {
>> +          GSB_VCPU_SPR_HEIR,
>> +          GSB_VCPU_SPR_NIA,
>> +          GSB_VCPU_SPR_MSR,
>> +      },
>> +    },
>> +    { .nia = 0xea0,
>> +      .count = 0,
>> +    },
>> +    { .nia = 0xf80,
>> +      .count = 3,
>> +      .ids = {
>> +          GSB_VCPU_SPR_HFSCR,
>> +          GSB_VCPU_SPR_NIA,
>> +          GSB_VCPU_SPR_MSR,
>> +      },
>> +    },
>> +};
>> +
>> +static struct run_vcpu_exit_cause *find_exit_cause(uint64_t srr0)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(run_vcpu_exit_causes); i++)
>> +        if (srr0 == run_vcpu_exit_causes[i].nia) {
>> +            return &run_vcpu_exit_causes[i];
>> +        }
>> +
>> +    printf("%s: srr0:0x%016lx\n", __func__, srr0);
>> +    return NULL;
>> +}
> 
> This is another weird control flow thing, also unclear why it's used
> here. Here: 52 lines vs 76, no new struct, simpler for the compiler
> to understand and optimise.
> 
> int get_exit_ids(uint64_t srr0, uint16_t ids[16])
> {
>      int nr;
> 
>      switch (srr0) {
>      case 0xc00:
>          nr = 10;
>          ids[0] = GSP_VCPU_GPR3;
>          ids[1] = GSP_VCPU_GPR4;
>          ids[2] = GSP_VCPU_GPR5;
>          ids[3] = GSP_VCPU_GPR6;
>          ids[4] = GSP_VCPU_GPR7;
>          ids[5] = GSP_VCPU_GPR8;
>          ids[6] = GSP_VCPU_GPR9;
>          ids[7] = GSP_VCPU_GPR10;
>          ids[8] = GSP_VCPU_GPR11;
>          ids[9] = GSP_VCPU_GPR12;
>          break;
>      case 0xe00:
>          nr = 5;
>          ids[0] = GSP_VCPU_HDAR;
>          ids[1] = GSP_VCPU_HDSISR;
>          ids[2] = GSP_VCPU_ASDR;
>          ids[3] = GSP_VCPU_NIA;
>          ids[4] = GSP_VCPU_MSR;
>          break;
>      case 0xe20:
>          nr = 4;
>          ids[0] = GSP_VCPU_HDAR;
>          ids[1] = GSP_VCPU_ASDR;
>          ids[2] = GSP_VCPU_NIA;
>          ids[3] = GSP_VCPU_MSR;
>          break;
>      case 0xe40:
>          nr = 3;
>          ids[0] = GSP_VCPU_HEIR;
>          ids[1] = GSP_VCPU_NIA;
>          ids[2] = GSP_VCPU_MSR;
>          break;
>      case 0xf80:
>          nr = 3;
>          ids[0] = GSP_VCPU_HFSCR;
>          ids[1] = GSP_VCPU_NIA;
>          ids[2] = GSP_VCPU_MSR;
>          break;
>      default:
>          nr = 0;
>          break;
>      }
> 
>      return nr;
> }
> 

This is really simpler and nice. Updated code as suggested. Thanks.

>> +
>> +static void exit_nested_restore_vcpu(PowerPCCPU *cpu, int excp,
>> +                                     SpaprMachineStateNestedGuestVcpu *vcpu)
>> +{
>> +    CPUPPCState *env = &cpu->env;
>> +    target_ulong now, hdar, hdsisr, asdr;
>> +
>> +    assert(sizeof(env->gpr) == sizeof(vcpu->env.gpr)); /* sanity check */
>> +
>> +    now = cpu_ppc_load_tbl(env); /* L2 timebase */
>> +    now -= vcpu->tb_offset; /* L1 timebase */
>> +    vcpu->dec_expiry_tb = now - cpu_ppc_load_decr(env);
>> +    /* backup hdar, hdsisr, asdr if reqd later below */
>> +    hdar   = vcpu->env.spr[SPR_HDAR];
>> +    hdsisr = vcpu->env.spr[SPR_HDSISR];
>> +    asdr   = vcpu->env.spr[SPR_ASDR];
>> +
>> +    restore_common_regs(&vcpu->env, env);
>> +
>> +    if (excp == POWERPC_EXCP_MCHECK ||
>> +        excp == POWERPC_EXCP_RESET ||
>> +        excp == POWERPC_EXCP_SYSCALL) {
>> +        vcpu->env.nip = env->spr[SPR_SRR0];
>> +        vcpu->env.msr = env->spr[SPR_SRR1] & env->msr_mask;
>> +    } else {
>> +        vcpu->env.nip = env->spr[SPR_HSRR0];
>> +        vcpu->env.msr = env->spr[SPR_HSRR1] & env->msr_mask;
>> +    }
>> +
>> +    /* hdar, hdsisr, asdr should be retained unless certain exceptions */
>> +    if ((excp != POWERPC_EXCP_HDSI) && (excp != POWERPC_EXCP_HISI)) {
>> +        vcpu->env.spr[SPR_ASDR] = asdr;
>> +    } else if (excp != POWERPC_EXCP_HDSI) {
>> +        vcpu->env.spr[SPR_HDAR]   = hdar;
>> +        vcpu->env.spr[SPR_HDSISR] = hdsisr;
>> +    }
>> +}
>> +
>> +static void exit_process_output_buffer(PowerPCCPU *cpu,
>> +                                      SpaprMachineStateNestedGuest *guest,
>> +                                      target_ulong vcpuid,
>> +                                      target_ulong *r3)
>> +{
>> +    SpaprMachineStateNestedGuestVcpu *vcpu = &guest->vcpu[vcpuid];
>> +    struct guest_state_request gsr;
>> +    struct guest_state_buffer *gsb;
>> +    struct guest_state_element *element;
>> +    struct guest_state_element_type *type;
>> +    struct run_vcpu_exit_cause *exit_cause;
>> +    hwaddr len;
>> +    int i;
>> +
>> +    len = vcpu->runbufout.size;
>> +    gsb = address_space_map(CPU(cpu)->as, vcpu->runbufout.addr, &len, true,
>> +                            MEMTXATTRS_UNSPECIFIED);
>> +    if (!gsb || len != vcpu->runbufout.size) {
>> +        address_space_unmap(CPU(cpu)->as, gsb, len, 0, true);
>> +        *r3 = H_P2;
>> +        return;
>> +    }
>> +
>> +    exit_cause = find_exit_cause(*r3);
>> +
>> +    /* Create a buffer of elements to send back */
>> +    gsb->num_elements = cpu_to_be32(exit_cause->count);
>> +    element = gsb->elements;
>> +    for (i = 0; i < exit_cause->count; i++) {
>> +        type = guest_state_element_type_find(exit_cause->ids[i]);
>> +        assert(type);
>> +        element->id = cpu_to_be16(exit_cause->ids[i]);
>> +        element->size = cpu_to_be16(type->size);
>> +        element = guest_state_element_next(element, NULL, NULL);
>> +    }
>> +    gsr.gsb = gsb;
>> +    gsr.len = VCPU_OUT_BUF_MIN_SZ;
>> +    gsr.flags = 0; /* get + never guest wide */
>> +    getset_state(guest, vcpuid, &gsr);
>> +
>> +    address_space_unmap(CPU(cpu)->as, gsb, len, len, true);
>> +    return;
>> +}
>> +
>>   void spapr_register_nested(void)
>>   {
>>       spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
>> @@ -1388,6 +1708,7 @@ void spapr_register_nested_phyp(void)
>>       spapr_register_hypercall(H_GUEST_CREATE_VCPU     , h_guest_create_vcpu);
>>       spapr_register_hypercall(H_GUEST_SET_STATE       , h_guest_set_state);
>>       spapr_register_hypercall(H_GUEST_GET_STATE       , h_guest_get_state);
>> +    spapr_register_hypercall(H_GUEST_RUN_VCPU        , h_guest_run_vcpu);
>>   }
>>   
>>   #else
>> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
>> index 69a52e39b8..09855f69aa 100644
>> --- a/include/hw/ppc/spapr_cpu_core.h
>> +++ b/include/hw/ppc/spapr_cpu_core.h
>> @@ -53,7 +53,12 @@ typedef struct SpaprCpuState {
>>   
>>       /* Fields for nested-HV support */
>>       bool in_nested; /* true while the L2 is executing */
>> -    struct nested_ppc_state *nested_host_state; /* holds the L1 state while L2 executes */
>> +    union {
>> +        /* nested-hv needs minimal set of regs as L1 stores L2 state */
>> +        struct nested_ppc_state *nested_hv_host;
>> +        /* In nested-papr, L0 retains entire L2 state, so keep it all safe. */
>> +        CPUPPCState *nested_papr_host;
>> +    };
> 
> This IMO still shouldn't be a CPUPPCState, but extending
> nested_ppc_state. Differences between nested APIs should not
> be here either, but inside the nested_ppc_state structure.
> 

I think for now, we can have it as CPUPPCState * since we do make use of
existing helper routines which takes env and operate on various regs it
contains. Since nested PAPR API holds entire L2 state, not sure if its
worth extending nested_ppc_state which was initially meant to store a
minimal sub-state, as now it will be duplicating most of CPUPPCState
members. Having said that, I am open to any optimizations that can be
taken as a follow-up patch and shouldnt be a blocker to have this
initial API feature committed and stablised. Hope you agree.

regards,
Harsh

> Thanks,
> Nick
> 
>>   } SpaprCpuState;
>>   
>>   static inline SpaprCpuState *spapr_cpu_state(PowerPCCPU *cpu)
>> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
>> index eaee624b87..ca5d28c06e 100644
>> --- a/include/hw/ppc/spapr_nested.h
>> +++ b/include/hw/ppc/spapr_nested.h
>> @@ -358,6 +358,12 @@ struct guest_state_request {
>>       uint16_t flags;
>>   };
>>   
>> +struct run_vcpu_exit_cause {
>> +    uint64_t nia;
>> +    uint64_t count;
>> +    uint16_t ids[10]; /* max ids supported by run_vcpu_exit_causes */
>> +};
>> +
>>   /*
>>    * Register state for entering a nested guest with H_ENTER_NESTED.
>>    * New member must be added at the end.
> 

