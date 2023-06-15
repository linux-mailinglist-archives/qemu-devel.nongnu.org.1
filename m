Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2CA730E6A
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 06:53:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9exY-0000mt-9e; Thu, 15 Jun 2023 00:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1q9exV-0000mf-Lr; Thu, 15 Jun 2023 00:51:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1q9exT-0000ib-IZ; Thu, 15 Jun 2023 00:51:45 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35F4gE2o026732; Thu, 15 Jun 2023 04:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=W91DZ1GSv5a788GeZ0KTEFwHtw5B4RDwPHwVeqC+Lqk=;
 b=KgKR0zgWQ8dADVv736j0QV42f1GS3E65i4Zq6j7TawuydXL0hWtbzAe03u+EfLbzz0pM
 zq8MVJ7FxRNVV3/5JY6EV3y4vP1J6daQpBFYXyA8JRlIXWSKJ60nHmSRYU+jYdg/ZwJ1
 rMbz4TkBn/YnBrLpWqgjoU4QUn3M1/cE0TgnGtSDO6ybzmjF9tyUdAhWXDcrhOd6rJsM
 4QqCJlP7jC6WBUk0MrlubWngyqclKMgE8Q/T3bBwKKR3dh85v+vLeIogtnYQ5e7nxqe9
 2fjfPvxqB7zhMkEH5TiYydWORAfON3m7Cu5iJ5T9sO+kg1b498DacrFIFR2Ans5WijY5 cg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7uug86mq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Jun 2023 04:51:38 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35F4gUEZ027207;
 Thu, 15 Jun 2023 04:51:38 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7uug86me-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Jun 2023 04:51:38 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35F3KB6x012063;
 Thu, 15 Jun 2023 04:51:37 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
 by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3r4gt6f7mb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Jun 2023 04:51:37 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35F4pZU23146258
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Jun 2023 04:51:36 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A554A5803F;
 Thu, 15 Jun 2023 04:51:35 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C72A58055;
 Thu, 15 Jun 2023 04:51:34 +0000 (GMT)
Received: from [9.109.242.129] (unknown [9.109.242.129])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 Jun 2023 04:51:33 +0000 (GMT)
Message-ID: <30b061d3-83e1-eb96-4404-ffb9559b3684@linux.ibm.com>
Date: Thu, 15 Jun 2023 10:21:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/4] ppc/spapr: Add a nested state struct
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20230608091344.88685-1-npiggin@gmail.com>
 <20230608091344.88685-3-npiggin@gmail.com>
 <f350a17c-5164-93ed-446f-1925ced02f10@linux.ibm.com>
 <CTCCRNIC7LCM.383MVI3UNIDK4@wheely>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CTCCRNIC7LCM.383MVI3UNIDK4@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BLdxK2Gjb6R57PjXLgf92T8xigF6WypB
X-Proofpoint-ORIG-GUID: 4OBziDZ0DV-V9TrXEyM_V8UmT0jV9nlb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_02,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 mlxlogscore=967 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150037
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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



On 6/14/23 17:26, Nicholas Piggin wrote:
> On Fri Jun 9, 2023 at 5:09 PM AEST, Harsh Prateek Bora wrote:
>>
>>
>> On 6/8/23 14:43, Nicholas Piggin wrote:
>>> Rather than use a copy of CPUPPCState to store the host state while
>>> the environment has been switched to the L2, use a new struct for
>>> this purpose.
>>>
>>> Have helper functions to save and load this host state.
>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>>    hw/ppc/spapr_hcall.c            | 150 ++++++++++++++++++++++++--------
>>>    include/hw/ppc/spapr_cpu_core.h |   5 +-
>>>    2 files changed, 115 insertions(+), 40 deletions(-)
>>>
>>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>>> index 0582b524d1..d5b8d54692 100644
>>> --- a/hw/ppc/spapr_hcall.c
>>> +++ b/hw/ppc/spapr_hcall.c
>>> @@ -1546,6 +1546,112 @@ static target_ulong h_copy_tofrom_guest(PowerPCCPU *cpu,
>>>        return H_FUNCTION;
>>>    }
>>>    
>>> +struct nested_ppc_state {
>>> +    uint64_t gpr[32];
>>> +    uint64_t lr;
>>> +    uint64_t ctr;
>>> +    uint64_t cfar;
>>> +    uint64_t msr;
>>> +    uint64_t nip;
>>> +    uint32_t cr;
>>> +
>>> +    uint64_t xer;
>>> +
>>> +    uint64_t lpcr;
>>> +    uint64_t lpidr;
>>> +    uint64_t pidr;
>>> +    uint64_t pcr;
>>> +    uint64_t dpdes;
>>> +    uint64_t hfscr;
>>> +    uint64_t srr0;
>>> +    uint64_t srr1;
>>> +    uint64_t sprg0;
>>> +    uint64_t sprg1;
>>> +    uint64_t sprg2;
>>> +    uint64_t sprg3;
>>> +    uint64_t ppr;
>>> +
>>> +    int64_t tb_offset;
>>> +};
>>> +
>>
>> <snip>
>>
>>> +static void nested_load_state(PowerPCCPU *cpu, struct nested_ppc_state *load)
>>> +{
>>> +    CPUState *cs = CPU(cpu);
>>> +    CPUPPCState *env = &cpu->env;
>>> +
>>> +    memcpy(env->gpr, load->gpr, sizeof(env->gpr));
>>> +
>>> +    env->lr = load->lr;
>>> +    env->ctr = load->ctr;
>>> +    env->cfar = load->cfar;
>>> +    env->msr = load->msr;
>>> +    env->nip = load->nip;
>>> +
>>> +    ppc_set_cr(env, load->cr);
>>> +    cpu_write_xer(env, load->xer);
>>> +
>>> +    env->spr[SPR_LPCR] = load->lpcr;
>>> +    env->spr[SPR_LPIDR] = load->lpidr;
>>> +    env->spr[SPR_PCR] = load->pcr;
>>> +    env->spr[SPR_DPDES] = load->dpdes;
>>> +    env->spr[SPR_HFSCR] = load->hfscr;
>>> +    env->spr[SPR_SRR0] = load->srr0;
>>> +    env->spr[SPR_SRR1] = load->srr1;
>>> +    env->spr[SPR_SPRG0] = load->sprg0;
>>> +    env->spr[SPR_SPRG1] = load->sprg1;
>>> +    env->spr[SPR_SPRG2] = load->sprg2;
>>> +    env->spr[SPR_SPRG3] = load->sprg3;
>>> +    env->spr[SPR_BOOKS_PID] = load->pidr;
>>> +    env->spr[SPR_PPR] = load->ppr;
>>> +
>>> +    env->tb_env->tb_offset = load->tb_offset;
>>> +
>>> +    /*
>>> +     * MSR updated, compute hflags and possible interrupts.
>>> +     */
>>> +    hreg_compute_hflags(env);
>>> +    ppc_maybe_interrupt(env);
>>> +
>>> +    /*
>>> +     * Nested HV does not tag TLB entries between L1 and L2, so must
>>> +     * flush on transition.
>>> +     */
>>> +    tlb_flush(cs);
>>> +    env->reserve_addr = -1; /* Reset the reservation */
>>> +}
>>> +
>>
>> <snip>
>>
>>> @@ -1766,34 +1872,8 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
>>>        address_space_unmap(CPU(cpu)->as, regs, len, len, true);
>>>    
>>>    out_restore_l1:
>>> -    memcpy(env->gpr, spapr_cpu->nested_host_state->gpr, sizeof(env->gpr));
>>> -    env->lr = spapr_cpu->nested_host_state->lr;
>>> -    env->ctr = spapr_cpu->nested_host_state->ctr;
>>> -    memcpy(env->crf, spapr_cpu->nested_host_state->crf, sizeof(env->crf));
>>> -    env->cfar = spapr_cpu->nested_host_state->cfar;
>>> -    env->xer = spapr_cpu->nested_host_state->xer;
>>> -    env->so = spapr_cpu->nested_host_state->so;
>>> -    env->ca = spapr_cpu->nested_host_state->ca;
>>> -    env->ov = spapr_cpu->nested_host_state->ov;
>>> -    env->ov32 = spapr_cpu->nested_host_state->ov32;
>>> -    env->ca32 = spapr_cpu->nested_host_state->ca32;
>>
>> Above fields so, ca, ov, ov32, ca32 are not taken care in
>> nested_load_state, ca being introduced in previous patch.
> 
> They should be, by cpu_write_xer.
> 
I see. In that case, do we really need the previous 1/4 patch?

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> Thanks,
> Nick
> 

