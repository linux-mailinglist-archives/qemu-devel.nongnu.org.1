Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BB09F8EC5
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Dec 2024 10:16:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOZ5y-0004lH-8J; Fri, 20 Dec 2024 04:14:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tOZ5v-0004kk-N9; Fri, 20 Dec 2024 04:14:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tOZ5t-0000Ts-Va; Fri, 20 Dec 2024 04:14:51 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK3r4BJ023355;
 Fri, 20 Dec 2024 09:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SASqpJ
 T7jisuBikFJBytQQkYKhjzEKcN68Y0zU2Z7gQ=; b=XKMU2WtUvlgbav07BtbZHu
 TGHOLP7Rrk6AJ1YHp09UvkmG4hpoZFz2oopoMzSahj6mGCoKllA1pN4EQXDIh9Io
 Hssjz7eH1pu/c3ICH79NYzKKRlfgDQqZRFnkeR70SEbEsfUQ6cW9mtaCUODcVw5/
 RVfEiWD24Vk6SXaAkTKgSGWXrKjWK+zoqsbwLJtX7tJXKnGkv1TOH34nO01ovh2N
 7xtj42/PIANhLWHIQdA3I583NSlwHmZzfqn0WtjDGWC1QcIGUlUHhgbCNpuodAqC
 F2QhKtEdPFHIIY60WASb9rQo+GUr/aFiL0zZqxILCHbifLuokAQ9UZF+clmji03A
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43n12h984g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Dec 2024 09:14:45 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BK92SYF017589;
 Fri, 20 Dec 2024 09:14:45 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43n12h984d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Dec 2024 09:14:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK6YBRT011249;
 Fri, 20 Dec 2024 09:14:44 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hpjkh6ud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Dec 2024 09:14:44 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BK9EhTE65143286
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Dec 2024 09:14:43 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7DF4058055;
 Fri, 20 Dec 2024 09:14:43 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F381958043;
 Fri, 20 Dec 2024 09:14:41 +0000 (GMT)
Received: from [9.124.215.200] (unknown [9.124.215.200])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Dec 2024 09:14:41 +0000 (GMT)
Message-ID: <4b3897e1-c9dd-45aa-bb6f-d8679fc78d25@linux.ibm.com>
Date: Fri, 20 Dec 2024 14:44:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] spapr: Fix vpa dispatch count for record-replay
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20241219034035.1826173-1-npiggin@gmail.com>
 <20241219034035.1826173-3-npiggin@gmail.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20241219034035.1826173-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rMtWBZn1G0BWswRwNGyi5MAy_yx_QLDL
X-Proofpoint-GUID: oetLEx1oUNOsOTfTg0nyK8YfWkiqdeI1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0
 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0 mlxlogscore=952
 lowpriorityscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200074
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.116, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Nick,

On 12/19/24 09:10, Nicholas Piggin wrote:
> The dispatch count is a field in guest memory that the hypervisor
> increments when preempting and dispatching the guest. This was not
> being done deterministically with respect to icount, because tcg
> exec exit is not deterministic (e.g., an async event could cause it).
> 
> Change vpa dispatch count increment to keep track of whether the
> vCPU is considered dispatched or not, and only consider it preempted
> when calling cede / confer / join / stop-self / etc.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   include/hw/ppc/spapr_cpu_core.h |  3 +++
>   hw/ppc/spapr.c                  | 36 ++-------------------------------
>   hw/ppc/spapr_hcall.c            | 33 ++++++++++++++++++++++++++++++
>   hw/ppc/spapr_rtas.c             |  1 +
>   4 files changed, 39 insertions(+), 34 deletions(-)
> 

<snipped>

> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 5e1d020e3df..907e09c2c36 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -487,6 +487,36 @@ static target_ulong h_register_vpa(PowerPCCPU *cpu, SpaprMachineState *spapr,
>       return ret;
>   }
>   
> +void vpa_dispatch(CPUState *cs, SpaprCpuState *spapr_cpu, bool dispatch)
> +{
> +    uint32_t counter;
> +
> +    if (!dispatch) {
> +        assert(spapr_cpu->dispatched);
> +    } else {
> +        assert(!spapr_cpu->dispatched);
> +    }

Would it look better as:
        assert(!(dispatch == spapr_cpu->dispatched));

> +    spapr_cpu->dispatched = dispatch;
> +
> +    return;

Returning here unconditionally makes below code unreachable.

> +
> +    if (!spapr_cpu->vpa_addr) {
> +        return;
> +    }

This could be moved to beginning or just after assert.

regards,
Harsh

> +
> +    /* These are only called by TCG, KVM maintains dispatch state */
> +    counter = ldl_be_phys(cs->as, spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER);
> +    counter++;
> +    if ((counter & 1) != dispatch) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "VPA: incorrect dispatch counter value for "
> +                      "%s partition %u, correcting.\n",
> +                      dispatch ? "preempted" : "running", counter);
> +        counter++;
> +    }
> +    stl_be_phys(cs->as, spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER, counter);
> +}
> +
>   static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
>                              target_ulong opcode, target_ulong *args)
>   {
> @@ -505,6 +535,7 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
>   
>       if (!cpu_has_work(cs)) {
>           cs->halted = 1;
> +        vpa_dispatch(cs, spapr_cpu, false);
>           cs->exception_index = EXCP_HLT;
>           cs->exit_request = 1;
>           ppc_maybe_interrupt(env);
> @@ -531,6 +562,8 @@ static target_ulong h_confer_self(PowerPCCPU *cpu)
>       cs->exit_request = 1;
>       ppc_maybe_interrupt(&cpu->env);
>   
> +    vpa_dispatch(cs, spapr_cpu, false);
> +
>       return H_SUCCESS;
>   }
>   
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index f329693c554..8ce42302234 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -216,6 +216,7 @@ static void rtas_stop_self(PowerPCCPU *cpu, SpaprMachineState *spapr,
>        */
>       env->spr[SPR_PSSCR] |= PSSCR_EC;
>       cs->halted = 1;
> +    vpa_dispatch(cs, spapr_cpu_state(cpu), false);
>       ppc_store_lpcr(cpu, env->spr[SPR_LPCR] & ~pcc->lpcr_pm);
>       kvmppc_set_reg_ppc_online(cpu, 0);
>       qemu_cpu_kick(cs);

