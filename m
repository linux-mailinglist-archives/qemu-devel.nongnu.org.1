Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5937A601A
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 12:49:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiYHv-0002Gm-HW; Tue, 19 Sep 2023 06:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qiYHC-0001v7-1o; Tue, 19 Sep 2023 06:48:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qiYH9-0006Ay-1h; Tue, 19 Sep 2023 06:48:17 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38JAcmVY008333; Tue, 19 Sep 2023 10:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=tsWNd0QQfqUWDWwDzmsYb7xVHFkyKE200GPxTDVF5zU=;
 b=sknbNpog5fFUIMuwW7t51iqvAaY2LvvpzwOu3UrK6Mr/oWYpTdbTACNuoJYZ5L+2clM2
 CUgFqGcA6vJ4IYFZiWLKW42fdq3f5KLVwAlvYqriabIMgvxeehyMv3aHPhDHtqfia83m
 hQRQ167WTUpMzINXoL/LonuRXDJvZ12TQAG16+U1KWNGCj/B7x4RP4sHf1thmFqXHrwD
 QQr0tLxQXYCm80iLL9ay++bR3fOgsQmuNsQl1ZZKqbBgrj+BWqHBer4/O1WVQD3g1umj
 qfvrlloMpl9xv4PNQXTenF78jwCSSo6syUK1F5SWEfgQH7GofaV7X5OY/EKjzmDm5BWm QA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t79sq0faj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 10:48:09 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38JAdlf3010660;
 Tue, 19 Sep 2023 10:48:08 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t79sq0fac-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 10:48:08 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38J9ODN4010018; Tue, 19 Sep 2023 10:48:07 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5rwk32fx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 10:48:07 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38JAm7Gv26149470
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Sep 2023 10:48:07 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8CE258043;
 Tue, 19 Sep 2023 10:48:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2A115805D;
 Tue, 19 Sep 2023 10:48:03 +0000 (GMT)
Received: from [9.109.242.129] (unknown [9.109.242.129])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 19 Sep 2023 10:48:03 +0000 (GMT)
Message-ID: <c0c8e550-82c5-c55d-a916-707454069e55@linux.ibm.com>
Date: Tue, 19 Sep 2023 16:18:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RESEND 06/15] ppc: spapr: Implement nested PAPR hcall -
 H_GUEST_GET_CAPABILITIES
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, danielhb413@gmail.com,
 qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, mikey@neuling.org, vaibhav@linux.ibm.com,
 jniethe5@gmail.com, sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
 <20230906043333.448244-7-harshpb@linux.ibm.com>
 <CVCBD2TBTMXJ.LYNCAVMT7LYB@wheely>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CVCBD2TBTMXJ.LYNCAVMT7LYB@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Jhh8YxT38Os5iC9NqJ6RERyP0wYpKVtY
X-Proofpoint-ORIG-GUID: sFydd6KietiAl5WnDWhYX1fMnpKqOsUl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_05,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 mlxscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190089
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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



On 9/7/23 07:32, Nicholas Piggin wrote:
> On Wed Sep 6, 2023 at 2:33 PM AEST, Harsh Prateek Bora wrote:
>> This patch implements nested PAPR hcall H_GUEST_GET_CAPABILITIES and
>> also enables registration of nested PAPR hcalls whenever an L0 is
>> launched with cap-nested-papr=true. The common registration routine
>> shall be used by future patches for registration of related hcall
>> support
>> being added. This hcall is used by L1 kernel to get the set of guest
>> capabilities that are supported by L0 (Qemu TCG).
> 
> Changelog can drop "This patch". Probably don't have to be so
> detailed here either -- we already established that PAPR hcalls can
> be used with cap-nested-papr in the last patch, we know that L1
> kernels make the hcalls to the vhyp, etc.
> 
> "Introduce the nested PAPR hcall H_GUEST_GET_CAPABILITIES which
> is used to query the capabilities of the API and the L2 guests
> it provides."
> 
> I would squash this with set.
> 

Sure, will update the commit log and squash with set.

>>
>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   hw/ppc/spapr_caps.c           |  1 +
>>   hw/ppc/spapr_nested.c         | 35 +++++++++++++++++++++++++++++++++++
>>   include/hw/ppc/spapr_nested.h |  6 ++++++
>>   3 files changed, 42 insertions(+)
>>
>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
>> index d3b9f107aa..cbe53a79ec 100644
>> --- a/hw/ppc/spapr_caps.c
>> +++ b/hw/ppc/spapr_caps.c
>> @@ -511,6 +511,7 @@ static void cap_nested_papr_apply(SpaprMachineState *spapr,
>>               return;
>>           }
>>           spapr->nested.api = NESTED_API_PAPR;
>> +        spapr_register_nested_phyp();
>>       } else if (kvm_enabled()) {
>>           /*
>>            * this gets executed in L1 qemu when L2 is launched,
> 
> Hmm, this doesn't match nested HV registration. If you want to register
> the hcalls in the cap apply, can you move spapr_register_nested()
> there first? It may make more sense to go in as a dummy function with
> the cap patch first, since you don't introduce all hcalls together.
> 
> Also phyp->papr. Scrub for phyp please.

Sure, will do.

> 
>> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
>> index a669470f1a..37f3a49be2 100644
>> --- a/hw/ppc/spapr_nested.c
>> +++ b/hw/ppc/spapr_nested.c
>> @@ -6,6 +6,7 @@
>>   #include "hw/ppc/spapr.h"
>>   #include "hw/ppc/spapr_cpu_core.h"
>>   #include "hw/ppc/spapr_nested.h"
>> +#include "cpu-models.h"
>>   
>>   #ifdef CONFIG_TCG
>>   #define PRTS_MASK      0x1f
>> @@ -375,6 +376,29 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
>>       address_space_unmap(CPU(cpu)->as, regs, len, len, true);
>>   }
>>   
>> +static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
>> +                                             SpaprMachineState *spapr,
>> +                                             target_ulong opcode,
>> +                                             target_ulong *args)
>> +{
>> +    CPUPPCState *env = &cpu->env;
>> +    target_ulong flags = args[0];
>> +
>> +    if (flags) { /* don't handle any flags capabilities for now */
>> +        return H_PARAMETER;
>> +    }
>> +
>> +    if ((env->spr[SPR_PVR] & CPU_POWERPC_POWER_SERVER_MASK) ==
>> +        (CPU_POWERPC_POWER9_BASE))
>> +        env->gpr[4] = H_GUEST_CAPABILITIES_P9_MODE;
>> +
>> +    if ((env->spr[SPR_PVR] & CPU_POWERPC_POWER_SERVER_MASK) ==
>> +        (CPU_POWERPC_POWER10_BASE))
>> +        env->gpr[4] = H_GUEST_CAPABILITIES_P10_MODE;
>> +
>> +    return H_SUCCESS;
>> +}
>> +
>>   void spapr_register_nested(void)
>>   {
>>       spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
>> @@ -382,6 +406,12 @@ void spapr_register_nested(void)
>>       spapr_register_hypercall(KVMPPC_H_TLB_INVALIDATE, h_tlb_invalidate);
>>       spapr_register_hypercall(KVMPPC_H_COPY_TOFROM_GUEST, h_copy_tofrom_guest);
>>   }
>> +
>> +void spapr_register_nested_phyp(void)
>> +{
>> +    spapr_register_hypercall(H_GUEST_GET_CAPABILITIES, h_guest_get_capabilities);
>> +}
>> +
>>   #else
>>   void spapr_exit_nested(PowerPCCPU *cpu, int excp)
>>   {
>> @@ -392,4 +422,9 @@ void spapr_register_nested(void)
>>   {
>>       /* DO NOTHING */
>>   }
>> +
>> +void spapr_register_nested_phyp(void)
>> +{
>> +    /* DO NOTHING */
>> +}
>>   #endif
>> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
>> index f8db31075b..ce198e9f70 100644
>> --- a/include/hw/ppc/spapr_nested.h
>> +++ b/include/hw/ppc/spapr_nested.h
>> @@ -189,6 +189,11 @@
>>   /* End of list of Guest State Buffer Element IDs */
>>   #define GSB_LAST                GSB_VCPU_SPR_ASDR
>>   
>> +/* Bit masks to be used in nested PAPR API */
>> +#define H_GUEST_CAPABILITIES_COPY_MEM 0x8000000000000000
>> +#define H_GUEST_CAPABILITIES_P9_MODE  0x4000000000000000
>> +#define H_GUEST_CAPABILITIES_P10_MODE 0x2000000000000000
> 
> See introducing these defines with the patch that uses them isn't so
> bad :)
> 

It's better indeed:)

regards,
Harsh

> Thanks,
> Nick
> 
>> +
>>   typedef struct SpaprMachineStateNestedGuest {
>>       unsigned long vcpus;
>>       struct SpaprMachineStateNestedGuestVcpu *vcpu;
>> @@ -331,6 +336,7 @@ struct nested_ppc_state {
>>   };
>>   
>>   void spapr_register_nested(void);
>> +void spapr_register_nested_phyp(void);
>>   void spapr_exit_nested(PowerPCCPU *cpu, int excp);
>>   
>>   #endif /* HW_SPAPR_NESTED_H */
> 

