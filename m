Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DDC729098
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 09:10:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7WFg-0001xs-Bh; Fri, 09 Jun 2023 03:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1q7WFd-0001x5-FF; Fri, 09 Jun 2023 03:09:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1q7WFb-0007E6-EU; Fri, 09 Jun 2023 03:09:37 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3596kcrv027999; Fri, 9 Jun 2023 07:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=dNDwiSdxxcv/3wkKmrTQ4LFRFpgI7WJPBpSPLePn6qE=;
 b=Ub88yGB1HPKsHZZ3NPtV27xMz0PDlwW8KZbAk57EKl7Sf3Qk7z5l/1AQu+laXLFlBMef
 L+3MvRR8AlH7v/j96KzDGIfJGTsdDsbfAA/W8weQrRLvXjGdu/uDNsnaouMNmBBCz19F
 rpa22sRZqEWWbQkfYhupOMvXu9krBCwgaGSp6EVDDwfLPySo26P7r5qy+ARs8fQUOHrW
 119QZKeVb8w/ZdlesNpfKW3AwVgQZNPWeH09dZXq6gEUoTW9IIRV0CBEBe0nxN+ue1SW
 q+66WCLMaN5RwAkERERwKzV5SOUvTaVaFZuxEmNkcF3P0VZ6GA462/BPetsjt96SieVl Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r3y420f0j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Jun 2023 07:09:33 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 359760Io029426;
 Fri, 9 Jun 2023 07:09:32 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r3y420exy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Jun 2023 07:09:32 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3594WfeY002033;
 Fri, 9 Jun 2023 07:09:30 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
 by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3r2a76kc5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Jun 2023 07:09:30 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35979Sk046858612
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Jun 2023 07:09:28 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5AA3D5805D;
 Fri,  9 Jun 2023 07:09:28 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A38E758057;
 Fri,  9 Jun 2023 07:09:26 +0000 (GMT)
Received: from [9.171.48.82] (unknown [9.171.48.82])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 Jun 2023 07:09:26 +0000 (GMT)
Message-ID: <f350a17c-5164-93ed-446f-1925ced02f10@linux.ibm.com>
Date: Fri, 9 Jun 2023 12:39:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/4] ppc/spapr: Add a nested state struct
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20230608091344.88685-1-npiggin@gmail.com>
 <20230608091344.88685-3-npiggin@gmail.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20230608091344.88685-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: H_3vjsApVk4VEiXC53FlRegQeEP2MuFN
X-Proofpoint-GUID: sGp5t4G1ultLIUJGr5w7YCDF3HGxyHCR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_04,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=940 phishscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090062
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 6/8/23 14:43, Nicholas Piggin wrote:
> Rather than use a copy of CPUPPCState to store the host state while
> the environment has been switched to the L2, use a new struct for
> this purpose.
> 
> Have helper functions to save and load this host state.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/ppc/spapr_hcall.c            | 150 ++++++++++++++++++++++++--------
>   include/hw/ppc/spapr_cpu_core.h |   5 +-
>   2 files changed, 115 insertions(+), 40 deletions(-)
> 
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 0582b524d1..d5b8d54692 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1546,6 +1546,112 @@ static target_ulong h_copy_tofrom_guest(PowerPCCPU *cpu,
>       return H_FUNCTION;
>   }
>   
> +struct nested_ppc_state {
> +    uint64_t gpr[32];
> +    uint64_t lr;
> +    uint64_t ctr;
> +    uint64_t cfar;
> +    uint64_t msr;
> +    uint64_t nip;
> +    uint32_t cr;
> +
> +    uint64_t xer;
> +
> +    uint64_t lpcr;
> +    uint64_t lpidr;
> +    uint64_t pidr;
> +    uint64_t pcr;
> +    uint64_t dpdes;
> +    uint64_t hfscr;
> +    uint64_t srr0;
> +    uint64_t srr1;
> +    uint64_t sprg0;
> +    uint64_t sprg1;
> +    uint64_t sprg2;
> +    uint64_t sprg3;
> +    uint64_t ppr;
> +
> +    int64_t tb_offset;
> +};
> +

<snip>

> +static void nested_load_state(PowerPCCPU *cpu, struct nested_ppc_state *load)
> +{
> +    CPUState *cs = CPU(cpu);
> +    CPUPPCState *env = &cpu->env;
> +
> +    memcpy(env->gpr, load->gpr, sizeof(env->gpr));
> +
> +    env->lr = load->lr;
> +    env->ctr = load->ctr;
> +    env->cfar = load->cfar;
> +    env->msr = load->msr;
> +    env->nip = load->nip;
> +
> +    ppc_set_cr(env, load->cr);
> +    cpu_write_xer(env, load->xer);
> +
> +    env->spr[SPR_LPCR] = load->lpcr;
> +    env->spr[SPR_LPIDR] = load->lpidr;
> +    env->spr[SPR_PCR] = load->pcr;
> +    env->spr[SPR_DPDES] = load->dpdes;
> +    env->spr[SPR_HFSCR] = load->hfscr;
> +    env->spr[SPR_SRR0] = load->srr0;
> +    env->spr[SPR_SRR1] = load->srr1;
> +    env->spr[SPR_SPRG0] = load->sprg0;
> +    env->spr[SPR_SPRG1] = load->sprg1;
> +    env->spr[SPR_SPRG2] = load->sprg2;
> +    env->spr[SPR_SPRG3] = load->sprg3;
> +    env->spr[SPR_BOOKS_PID] = load->pidr;
> +    env->spr[SPR_PPR] = load->ppr;
> +
> +    env->tb_env->tb_offset = load->tb_offset;
> +
> +    /*
> +     * MSR updated, compute hflags and possible interrupts.
> +     */
> +    hreg_compute_hflags(env);
> +    ppc_maybe_interrupt(env);
> +
> +    /*
> +     * Nested HV does not tag TLB entries between L1 and L2, so must
> +     * flush on transition.
> +     */
> +    tlb_flush(cs);
> +    env->reserve_addr = -1; /* Reset the reservation */
> +}
> +

<snip>

> @@ -1766,34 +1872,8 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
>       address_space_unmap(CPU(cpu)->as, regs, len, len, true);
>   
>   out_restore_l1:
> -    memcpy(env->gpr, spapr_cpu->nested_host_state->gpr, sizeof(env->gpr));
> -    env->lr = spapr_cpu->nested_host_state->lr;
> -    env->ctr = spapr_cpu->nested_host_state->ctr;
> -    memcpy(env->crf, spapr_cpu->nested_host_state->crf, sizeof(env->crf));
> -    env->cfar = spapr_cpu->nested_host_state->cfar;
> -    env->xer = spapr_cpu->nested_host_state->xer;
> -    env->so = spapr_cpu->nested_host_state->so;
> -    env->ca = spapr_cpu->nested_host_state->ca;
> -    env->ov = spapr_cpu->nested_host_state->ov;
> -    env->ov32 = spapr_cpu->nested_host_state->ov32;
> -    env->ca32 = spapr_cpu->nested_host_state->ca32;

Above fields so, ca, ov, ov32, ca32 are not taken care in 
nested_load_state, ca being introduced in previous patch.

regards,
Harsh
> -    env->msr = spapr_cpu->nested_host_state->msr;
> -    env->nip = spapr_cpu->nested_host_state->nip;
> -
>       assert(env->spr[SPR_LPIDR] != 0);
> -    env->spr[SPR_LPCR] = spapr_cpu->nested_host_state->spr[SPR_LPCR];
> -    env->spr[SPR_LPIDR] = spapr_cpu->nested_host_state->spr[SPR_LPIDR];
> -    env->spr[SPR_PCR] = spapr_cpu->nested_host_state->spr[SPR_PCR];
> -    env->spr[SPR_DPDES] = 0;
> -    env->spr[SPR_HFSCR] = spapr_cpu->nested_host_state->spr[SPR_HFSCR];
> -    env->spr[SPR_SRR0] = spapr_cpu->nested_host_state->spr[SPR_SRR0];
> -    env->spr[SPR_SRR1] = spapr_cpu->nested_host_state->spr[SPR_SRR1];
> -    env->spr[SPR_SPRG0] = spapr_cpu->nested_host_state->spr[SPR_SPRG0];
> -    env->spr[SPR_SPRG1] = spapr_cpu->nested_host_state->spr[SPR_SPRG1];
> -    env->spr[SPR_SPRG2] = spapr_cpu->nested_host_state->spr[SPR_SPRG2];
> -    env->spr[SPR_SPRG3] = spapr_cpu->nested_host_state->spr[SPR_SPRG3];
> -    env->spr[SPR_BOOKS_PID] = spapr_cpu->nested_host_state->spr[SPR_BOOKS_PID];
> -    env->spr[SPR_PPR] = spapr_cpu->nested_host_state->spr[SPR_PPR];
> +    nested_load_state(cpu, spapr_cpu->nested_host_state);
>   
>       /*
>        * Return the interrupt vector address from H_ENTER_NESTED to the L1
> @@ -1801,14 +1881,8 @@ out_restore_l1:
>        */
>       env->gpr[3] = r3_return;
>   
> -    env->tb_env->tb_offset -= spapr_cpu->nested_tb_offset;
>       spapr_cpu->in_nested = false;
>   
> -    hreg_compute_hflags(env);
> -    ppc_maybe_interrupt(env);
> -    tlb_flush(cs);
> -    env->reserve_addr = -1; /* Reset the reservation */
> -
>       g_free(spapr_cpu->nested_host_state);
>       spapr_cpu->nested_host_state = NULL;
>   }
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
> index b560514560..69a52e39b8 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -41,6 +41,8 @@ void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip,
>                                  target_ulong r1, target_ulong r3,
>                                  target_ulong r4);
>   
> +struct nested_ppc_state;
> +
>   typedef struct SpaprCpuState {
>       uint64_t vpa_addr;
>       uint64_t slb_shadow_addr, slb_shadow_size;
> @@ -51,8 +53,7 @@ typedef struct SpaprCpuState {
>   
>       /* Fields for nested-HV support */
>       bool in_nested; /* true while the L2 is executing */
> -    CPUPPCState *nested_host_state; /* holds the L1 state while L2 executes */
> -    int64_t nested_tb_offset; /* L1->L2 TB offset */
> +    struct nested_ppc_state *nested_host_state; /* holds the L1 state while L2 executes */
>   } SpaprCpuState;
>   
>   static inline SpaprCpuState *spapr_cpu_state(PowerPCCPU *cpu)

