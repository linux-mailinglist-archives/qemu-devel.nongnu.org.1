Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCA27A5E8D
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:50:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiXME-0000nD-9D; Tue, 19 Sep 2023 05:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qiXMA-0000gE-CO; Tue, 19 Sep 2023 05:49:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qiXM7-0000I5-Jo; Tue, 19 Sep 2023 05:49:22 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38J9cjGC032633; Tue, 19 Sep 2023 09:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=fURjsIl3HyBJcJ2zowgQTTDU7W8XvwyDfVlBrESQgFo=;
 b=IBJAWG0zUJYQfoV3ejSJQ0MhbW1VySNX3pSnCFQhc4KsZtpStv1DyaM20HitgzFPjtxe
 y7lWnYqaMpeur/NNQRO388Ll9RhDKi1GfqTu7NSG0BSF/sXcbQJ9sn7EYMM7NgjAjRLh
 ZIRYm45dMUq270Zh7JtMA9HAJG2BAxe0JIHTuk9TudfKunzTVmfcOKlISLhA3r69RdZV
 WgOvbmea5KSOz0jXSiYaIZJUvFpciWEumT6oUHAVohVqu0LWkeuQ6yKw+6RdmYUzdGWA
 CImefws6VG6rtsSn0kZ/5eXRk927HTpk0cft4Xcfq60BeQKq3uG6O1Q3OPynpvP0DkLA Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t77n32uv0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 09:49:13 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38J9fVR2009860;
 Tue, 19 Sep 2023 09:49:13 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t77n32uue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 09:49:13 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38J8ie3N031173; Tue, 19 Sep 2023 09:49:11 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t5r6kjv9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 09:49:11 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38J9nAQe64094590
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Sep 2023 09:49:10 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9345958055;
 Tue, 19 Sep 2023 09:49:10 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8EA1B58043;
 Tue, 19 Sep 2023 09:49:07 +0000 (GMT)
Received: from [9.109.242.129] (unknown [9.109.242.129])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 19 Sep 2023 09:49:07 +0000 (GMT)
Message-ID: <94e35dd1-8cfd-8f9e-ccb1-deac2cb5dc2c@linux.ibm.com>
Date: Tue, 19 Sep 2023 15:19:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RESEND 05/15] ppc: spapr: Introduce cap-nested-papr for
 nested PAPR API
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, danielhb413@gmail.com,
 qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, mikey@neuling.org, vaibhav@linux.ibm.com,
 jniethe5@gmail.com, sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
 <20230906043333.448244-6-harshpb@linux.ibm.com>
 <CVCB3AO11TVE.1KOGDT31E576V@wheely>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CVCB3AO11TVE.1KOGDT31E576V@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GF4DgWnnP7u2EOadO_k3kkAzd6aF7fUX
X-Proofpoint-ORIG-GUID: oTzKXcfKWHRSb6wVRjkh4ashXEsbj0HC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_04,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 clxscore=1015 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190080
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



On 9/7/23 07:19, Nicholas Piggin wrote:
> On Wed Sep 6, 2023 at 2:33 PM AEST, Harsh Prateek Bora wrote:
>> This patch introduces a new cmd line option cap-nested-papr to enable
>> support for nested PAPR API by setting the nested.api version accordingly.
>> It requires the user to launch the L0 Qemu in TCG mode and then L1 Linux
>> can then launch the nested guest in KVM mode. Unlike cap-nested-hv,
>> this is meant for nested guest on pseries (PowerVM) where L0 retains
>> whole state of the nested guest. Both APIs are thus mutually exclusive.
>> Support for related hcalls is being added in next set of patches.
> 
> This changelog could use some work too.
> 
> "Introduce a SPAPR capability cap-nested-papr with provides a nested
(s/with/which?)
> HV facility to the guest. This is similar to cap-nested-hv, but uses
> a different (incompatible) API and so they are mutually exclusive."
> 
We may want to emphasize that nested virtualization on Power uses only 
this new API, whereas the other API was targeted towards PowerNV but 
never became part of the PAPR spec?

> You could add some documentation to say recent Linux pseries guests
> support both, and explain more about KVM and PowerVM support there too,
> if it is relevant.
> 

Sure, will update.

>>
>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   hw/ppc/spapr.c         |  2 ++
>>   hw/ppc/spapr_caps.c    | 48 ++++++++++++++++++++++++++++++++++++++++++
>>   include/hw/ppc/spapr.h |  5 ++++-
>>   3 files changed, 54 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 0aa9f21516..cbab7a825f 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -2092,6 +2092,7 @@ static const VMStateDescription vmstate_spapr = {
>>           &vmstate_spapr_cap_fwnmi,
>>           &vmstate_spapr_fwnmi,
>>           &vmstate_spapr_cap_rpt_invalidate,
>> +        &vmstate_spapr_cap_nested_papr,
>>           NULL
>>       }
>>   };
>> @@ -4685,6 +4686,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>>       smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_WORKAROUND;
>>       smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = 16; /* 64kiB */
>>       smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
>> +    smc->default_caps.caps[SPAPR_CAP_NESTED_PAPR] = SPAPR_CAP_OFF;
>>       smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
>>       smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_ON;
>>       smc->default_caps.caps[SPAPR_CAP_FWNMI] = SPAPR_CAP_ON;
>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
>> index a3a790b026..d3b9f107aa 100644
>> --- a/hw/ppc/spapr_caps.c
>> +++ b/hw/ppc/spapr_caps.c
>> @@ -491,6 +491,44 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
>>       }
>>   }
>>   
>> +static void cap_nested_papr_apply(SpaprMachineState *spapr,
>> +                                    uint8_t val, Error **errp)
>> +{
>> +    ERRP_GUARD();
>> +    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
>> +    CPUPPCState *env = &cpu->env;
>> +
>> +    if (!val) {
>> +        /* capability disabled by default */
>> +        return;
>> +    }
>> +
>> +    if (tcg_enabled()) {
>> +        if (!(env->insns_flags2 & PPC2_ISA300)) {
>> +            error_setg(errp, "Nested-PAPR only supported on POWER9 and later");
>> +            error_append_hint(errp,
>> +                              "Try appending -machine cap-nested-papr=off\n");
>> +            return;
>> +        }
>> +        spapr->nested.api = NESTED_API_PAPR;
> 
> I'm not seeing any mutual exclusion with the other cap here. What if
> you enable them both? Lucky dip?
> 
> It would actually be nice to enable both even if you just choose the
> mode after the first hcall is made. I think you could actually support
> both (even concurrently) quite easily.
> 
> For now this is probably okay if you fix mutex.
> 

Thanks for catching this. Will fix.

> 
>> +    } else if (kvm_enabled()) {
>> +        /*
>> +         * this gets executed in L1 qemu when L2 is launched,
>> +         * needs kvm-hv support in L1 kernel.
>> +         */
>> +        if (!kvmppc_has_cap_nested_kvm_hv()) {
>> +            error_setg(errp,
>> +                       "KVM implementation does not support Nested-HV");
>> +            error_append_hint(errp,
>> +                              "Try appending -machine cap-nested-hv=off\n");
>> +        } else if (kvmppc_set_cap_nested_kvm_hv(val) < 0) {
>> +            error_setg(errp, "Error enabling cap-nested-hv with KVM");
>> +            error_append_hint(errp,
>> +                              "Try appending -machine cap-nested-hv=off\n");
>> +        }
> 
> This is just copy and pasted from the other cap, isn't it?
> 
Yeh, error logs needs to be rephrased.

>> +    }
>> +}
>> +
>>   static void cap_large_decr_apply(SpaprMachineState *spapr,
>>                                    uint8_t val, Error **errp)
>>   {
>> @@ -736,6 +774,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>>           .type = "bool",
>>           .apply = cap_nested_kvm_hv_apply,
>>       },
>> +    [SPAPR_CAP_NESTED_PAPR] = {
>> +        .name = "nested-papr",
>> +        .description = "Allow Nested PAPR (Phyp)",
>> +        .index = SPAPR_CAP_NESTED_PAPR,
>> +        .get = spapr_cap_get_bool,
>> +        .set = spapr_cap_set_bool,
>> +        .type = "bool",
>> +        .apply = cap_nested_papr_apply,
>> +    },
> 
> Should scrub "Phyp". "Phyp" and PowerVM also doesn't mean anything for
> us really. We both implement PAPR. "Nested PAPR" is jibberish for a user
> as well -- "Allow Nested KVM-HV (PAPR API)" or similar might be a bit
> better.
> 
I think "Allow Nested-HV (PAPR API)" may be better since L0 is the 
hypervisor here which takes care of nested guests. We may want to avoid 
the term "Nested KVM" which usually means KVM on KVM as hypervisor.
Also, AFAIK, the former API never became part of PAPR spec, not sure if 
it is appropriate to say - both implement PAPR ?

regards,
Harsh

> Thanks,
> Nick
> 
>>       [SPAPR_CAP_LARGE_DECREMENTER] = {
>>           .name = "large-decr",
>>           .description = "Allow Large Decrementer",
>> @@ -920,6 +967,7 @@ SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
>>   SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
>>   SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MAXPAGESIZE);
>>   SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
>> +SPAPR_CAP_MIG_STATE(nested_papr, SPAPR_CAP_NESTED_PAPR);
>>   SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>>   SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
>>   SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index c8b42af430..8a6e9ce929 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -81,8 +81,10 @@ typedef enum {
>>   #define SPAPR_CAP_RPT_INVALIDATE        0x0B
>>   /* Support for AIL modes */
>>   #define SPAPR_CAP_AIL_MODE_3            0x0C
>> +/* Nested PAPR */
>> +#define SPAPR_CAP_NESTED_PAPR           0x0D
>>   /* Num Caps */
>> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_AIL_MODE_3 + 1)
>> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_NESTED_PAPR + 1)
>>   
>>   /*
>>    * Capability Values
>> @@ -1005,6 +1007,7 @@ extern const VMStateDescription vmstate_spapr_cap_sbbc;
>>   extern const VMStateDescription vmstate_spapr_cap_ibs;
>>   extern const VMStateDescription vmstate_spapr_cap_hpt_maxpagesize;
>>   extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
>> +extern const VMStateDescription vmstate_spapr_cap_nested_papr;
>>   extern const VMStateDescription vmstate_spapr_cap_large_decr;
>>   extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
>>   extern const VMStateDescription vmstate_spapr_cap_fwnmi;
> 

