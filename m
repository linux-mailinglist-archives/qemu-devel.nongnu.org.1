Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 782F17B63CE
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:10:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnaU7-00008m-BD; Tue, 03 Oct 2023 04:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qnaU2-00008O-La
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:10:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qnaU0-00054b-Qo
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696320619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vh/YCtF+dGAZ5rnghQLdg6loEpCFIC3ozp430luF9tA=;
 b=W2cOIQBoTx41HX1dt3ZzgAwqxnwzSfAD/yglEWicgNOQ0X1b834Ag90IUFMhq5oBsT8Ur3
 ED9MPICMmtRU8I9fVvSCgSADYhemFsRDoNi4kkK3KQTYfLlzj15Zb/Nm3/WKBuXba5P5zh
 YHjZQqpZGCy67ved+IYxza0UgmOz2rc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-oHEPwi5SNhK5B9HI_2kJZQ-1; Tue, 03 Oct 2023 04:10:18 -0400
X-MC-Unique: oHEPwi5SNhK5B9HI_2kJZQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7740c0e88ffso92368785a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696320617; x=1696925417;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vh/YCtF+dGAZ5rnghQLdg6loEpCFIC3ozp430luF9tA=;
 b=wnxWM8nnepHS7+iXf/BD9ge7wODW6z6+hoG7SGYOjSZRiFuOG3eBUCH4XJ3bdDrOEt
 cM7zBFwfDcE39iN2zPOO9+GzhGyTIf4tWXULuNQeWm20RohZKbglLw7pV9vxEqulAqZm
 KEe1FRJQpp3FBMDx9rPvpK5ypajvi85KYEwEbE7s+Tpkg742iXd8kbMtSVnEDSmww9pB
 NK+hJSJTPbGqJGd+w1h0V4XBEPzG+aWc85ImSzwKbPL9kOIo2zZuhnR/Vlpm4w63wobS
 4bub1jsRSBlr+2wGmglDNfuVd7gneEbyM/MVgL1z8zPm+KF3Y2fu9HO0NJmF9nW5Xmmo
 v3/Q==
X-Gm-Message-State: AOJu0YwWjmJW2nVRuMCvDykInenjn+a95WnglCI2WUdoBjxpwnaaLfdb
 sWMOW5bRoSMw5sBhuPAhy7piyhvy7956ouaoV7FSAGLyNGZFvd/+N1IkzuK4gz+fsy2ckVlsWlJ
 j38PSn5GTXtwo0KA=
X-Received: by 2002:a05:620a:288c:b0:76c:de57:7b61 with SMTP id
 j12-20020a05620a288c00b0076cde577b61mr14961655qkp.25.1696320617485; 
 Tue, 03 Oct 2023 01:10:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMzWlrHmhcbSfDJ2AUms7hlLSuBubf0k+8NXY0vVGGmau2id+7gqEVO9oEO3r3xudKbkO/mA==
X-Received: by 2002:a05:620a:288c:b0:76c:de57:7b61 with SMTP id
 j12-20020a05620a288c00b0076cde577b61mr14961650qkp.25.1696320617171; 
 Tue, 03 Oct 2023 01:10:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 k8-20020a05620a142800b0076cc4610d0asm259908qkj.85.2023.10.03.01.10.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 01:10:16 -0700 (PDT)
Message-ID: <3176d279-1ad4-4282-f56e-8008fa9e1d50@redhat.com>
Date: Tue, 3 Oct 2023 10:10:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RESEND 06/15] ppc: spapr: Implement nested PAPR hcall -
 H_GUEST_GET_CAPABILITIES
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, danielhb413@gmail.com,
 qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, mikey@neuling.org, vaibhav@linux.ibm.com,
 jniethe5@gmail.com, sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
 <20230906043333.448244-7-harshpb@linux.ibm.com>
 <CVCBD2TBTMXJ.LYNCAVMT7LYB@wheely>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <CVCBD2TBTMXJ.LYNCAVMT7LYB@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.321, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/7/23 04:02, Nicholas Piggin wrote:
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

Ah. I was going to say the opposit since on an LPAR :

Architecture:            ppc64le
   Byte Order:            Little Endian
CPU(s):                  192
   On-line CPU(s) list:   0-191
Model name:              POWER10 (architected), altivec supported
   Model:                 2.0 (pvr 0080 0200)
   Thread(s) per core:    8
   Core(s) per socket:    6
   Socket(s):             4
Virtualization features:
   Hypervisor vendor:     pHyp   <-----
   Virtualization type:   para



C.


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
> 


