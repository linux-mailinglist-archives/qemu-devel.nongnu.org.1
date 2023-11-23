Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BBB7F60DE
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 14:53:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6A7c-0007iO-9T; Thu, 23 Nov 2023 08:52:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1r6A7Z-0007i7-Se
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 08:51:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1r6A7Y-0000fE-77
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 08:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700747515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yS/lM3ooYobg9EHllWUN9clUC2mosCB0IlbukeEN+0Y=;
 b=NJf/JJXlp/YisIrYWqob8RKiFBSVL1lx6LIJ2uNtWPvJT1CLROwgWH86A3dn8RGo2G7QI0
 lnzLKWLINQzSQ9KI/gZgdRcYotDM5cTDwYAohMlC/BdMlEoU6m+jAi1A59EzHfJ0m/N3OE
 mx2Q8QiQHN31Y/ihwn3R0M0SIBSiYXo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-YzMEJ_hRPKSH3fpSQqCMqg-1; Thu, 23 Nov 2023 08:51:51 -0500
X-MC-Unique: YzMEJ_hRPKSH3fpSQqCMqg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-66da680f422so11625046d6.3
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 05:51:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700747511; x=1701352311;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yS/lM3ooYobg9EHllWUN9clUC2mosCB0IlbukeEN+0Y=;
 b=I2bhWEXapn7k7FxteSysabV1YGTZI7XFpxMZ6s/7nGe4O+drEKMO159RGpIaWQQQ7p
 G9f5pGgz0gBNaXBunVMch4qPw7fFiTIwuu8xDl+DlhT92LARzmzye/w+RdiJTIHIhh8c
 Qyt2WQXAlNqBhiwAPFp7LUeQXSMVRBHzpiHGEgDtHqDbgXTmIHP36YUj0eDda+v79Ccj
 BycBlzZKsiHcL/xyNb8X0c/26k1K/+DwDeFblUX87lv+NQu/b03JA1nz6g2feJXaBAOJ
 IPiNZQu8kgJu0CYVFfJQpj/MR7xh3DMFl0PnEhzeOEnqqT4O/iztCwjuK1hbNa9ORT4M
 V6bQ==
X-Gm-Message-State: AOJu0YwUFm2WgCT66zQ3+2t0fXgQTpCLGrN6FnlcpwEHL8ONNCZm0h1z
 f346JaD1VZe8YRwbSFcjz4yv7ne5B+XYWZruVM/35e7IkB4ZPIQh5z3ULRH9nPws6ckzX54KPCV
 n1G6xJ42/qWOKas8=
X-Received: by 2002:a05:6214:2424:b0:66c:ffda:4a3c with SMTP id
 gy4-20020a056214242400b0066cffda4a3cmr6838849qvb.55.1700747511431; 
 Thu, 23 Nov 2023 05:51:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNt5yG9wDt1nynir/YHMrWufPM1WOQ/L9JWdH5aJjik9zwEgEayVXrC63k6uJ4jbkvxoF9aw==
X-Received: by 2002:a05:6214:2424:b0:66c:ffda:4a3c with SMTP id
 gy4-20020a056214242400b0066cffda4a3cmr6838824qvb.55.1700747511153; 
 Thu, 23 Nov 2023 05:51:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 x18-20020a0cda12000000b00677adcfd261sm508228qvj.89.2023.11.23.05.51.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 05:51:50 -0800 (PST)
Message-ID: <fe8f4ffe-7cc2-48a7-ab9a-998760e8893e@redhat.com>
Date: Thu, 23 Nov 2023 14:51:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ppc/spapr: Initialize max_cpus limit to
 SPAPR_NR_IPIS.
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, npiggin@gmail.com,
 qemu-ppc@nongnu.org
Cc: danielhb413@gmail.com, clg@kaod.org, david@gibson.dropbear.id.au,
 qemu-devel@nongnu.org
References: <20231122092845.973949-1-harshpb@linux.ibm.com>
 <20231122092845.973949-3-harshpb@linux.ibm.com>
 <4eaf8cf4-94b1-425b-a712-c006abb114c3@linaro.org>
 <504a8c39-711c-2fcf-ffc7-396898d5e84b@linux.ibm.com>
 <b79cdaaa-0327-4da7-8be7-b5581139ef47@redhat.com>
 <df35ce9e-46b5-4380-8037-426d54fbf786@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <df35ce9e-46b5-4380-8037-426d54fbf786@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/23/23 11:26, Philippe Mathieu-Daudé wrote:
> On 23/11/23 09:47, Cédric Le Goater wrote:
>> On 11/23/23 06:03, Harsh Prateek Bora wrote:
>>> Hi Philippe,
>>>
>>> On 11/22/23 16:46, Philippe Mathieu-Daudé wrote:
>>>> Hi Harsh,
>>>>
>>>> On 22/11/23 10:28, Harsh Prateek Bora wrote:
>>>>> Initialize the machine specific max_cpus limit as per the maximum range
>>>>> of CPU IPIs available. Keeping between 4096 to 8192 will throw IRQ not
>>>>> free error due to XIVE/XICS limitation and keeping beyond 8192 will hit
>>>>> assert in tcg_region_init or spapr_xive_claim_irq.
>>>>>
>>>>> Logs:
>>>>>
>>>>> Without patch fix:
>>>>>
>>>>> [root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=4097
>>>>> qemu-system-ppc64: IRQ 4096 is not free
>>>>> [root@host build]#
>>>>>
>>>>> On LPAR:
>>>>> [root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=8193
>>>>> **
>>>>> ERROR:../tcg/region.c:774:tcg_region_init: assertion failed:
>>>>> (region_size >= 2 * page_size)
>>>>> Bail out! ERROR:../tcg/region.c:774:tcg_region_init: assertion failed:
>>>>> (region_size >= 2 * page_size)
>>>>> Aborted (core dumped)
>>>>> [root@host build]#
>>>>>
>>>>> On x86:
>>>>> [root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=8193
>>>>> qemu-system-ppc64: ../hw/intc/spapr_xive.c:596: spapr_xive_claim_irq:
>>>>> Assertion `lisn < xive->nr_irqs' failed.
>>>>> Aborted (core dumped)
>>>>> [root@host build]#
>>>>>
>>>>> With patch fix:
>>>>> [root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=4097
>>>>> qemu-system-ppc64: Invalid SMP CPUs 4097. The max CPUs supported by
>>>>> machine 'pseries-8.2' is 4096
>>>>> [root@host build]#
>>>>>
>>>>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>>>> ---
>>>>>   hw/ppc/spapr.c | 9 +++------
>>>>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>>> index df09aa9d6a..0de11a4458 100644
>>>>> --- a/hw/ppc/spapr.c
>>>>> +++ b/hw/ppc/spapr.c
>>>>> @@ -4647,13 +4647,10 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>>>>>       mc->block_default_type = IF_SCSI;
>>>>>       /*
>>>>> -     * Setting max_cpus to INT32_MAX. Both KVM and TCG max_cpus values
>>>>> -     * should be limited by the host capability instead of hardcoded.
>>>>> -     * max_cpus for KVM guests will be checked in kvm_init(), and TCG
>>>>> -     * guests are welcome to have as many CPUs as the host are capable
>>>>> -     * of emulate.
>>>>> +     * While KVM determines max cpus in kvm_init() using kvm_max_vcpus(),
>>>>> +     * In TCG the limit is restricted by the range of CPU IPIs available.
>>>>>        */
>>>>> -    mc->max_cpus = INT32_MAX;
>>>>> +    mc->max_cpus = SPAPR_NR_IPIS;
>>>>
>>>> Is SPAPR_NR_IPIS also the upper limit for KVM?
>>>
>>> In KVM mode, the limit is restricted to what is supported by KVM which is checked using kvm_ioctl via wrappers in kvm_init and appears to be evaluating to 2048. So, having a larger default works for both case.
>>
>> QEMU sets the number of cpus with KVM ioctls :
>>
>>      KVM_DEV_XICS_NR_SERVERS
>>      KVM_DEV_XIVE_NR_SERVERS
>>
>> This is important for the host since the interrupt controller is then
>> configured with these values through FW.
>>
>> The default value is indeed 2K but this is large and wastes a lot of
>> HW resources, page mappings, etc.
> 
> I was wondering if one day KVM raise its limit to 5k, then the
> machine will clamp to 4k, and someone will have to debug that.
> Not a big deal ;)

Changing the number of CPUs will require some work in Linux first.
I think we (as ppc) tried to push it to 8K but there was some push
back upstream. Anyhow, there are DT issues also, memory layout, etc.
It won't happen without being noticed I am sure :)

Anyhow, If we need more IPIs to support more CPUs, the IRQ number
space will need an extra range after the device range to preserve
compatibility.

Thanks,

C.


