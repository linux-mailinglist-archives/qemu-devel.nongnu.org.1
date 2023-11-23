Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAE27F5A73
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 09:48:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r65NY-0002Ko-1Q; Thu, 23 Nov 2023 03:48:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1r65NU-0002Kb-Tz
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 03:48:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1r65NP-0006UW-Uy
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 03:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700729278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rtI4RdtmqMegzF7DUfYhnmkN+XPIdDf3Olk0p1+kEMI=;
 b=AcBa5CXSphH+3eHcPYWqw6Emt2rjQn8EH6LQQqPmi7dVgCX3qZLpxFjdCX+xzNApDT2TOb
 yMr7Ty3A3GK6XIOF+l8YsFtn/ytgGq2zMZO5T0Nxn6eyYbRH0F/s/1mmCuKvrC2mu2INYc
 7Z4tyIVf0/9uvQCldwNwpw/cBwuqraQ=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-qn4BTE_MPJ6ci-be6OVmEQ-1; Thu, 23 Nov 2023 03:47:56 -0500
X-MC-Unique: qn4BTE_MPJ6ci-be6OVmEQ-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3b565a98473so873444b6e.1
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 00:47:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700729275; x=1701334075;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rtI4RdtmqMegzF7DUfYhnmkN+XPIdDf3Olk0p1+kEMI=;
 b=MWFwNl+2WeOeN5oOc1wvpJHxZ2VB3BSHTvNZu0FP+X5C5G50SEgpu0lxXUKu9PWdZ6
 5cEtuid6xYJPDhh3nbrRE0o7vw+mQ+rDcO+Sm5YCj25vfjDj/p+tQBvLiDRGVn5sOwQG
 Ye0gUqvcUNfbe0vmx/3YajTQzP1hLFOnyVROo+WaIfRqdRexTQToKcCq7ML1pdblLbyo
 g/UkfdcwzpwbxFxx7jQDcImZX23JT4ZtqJZ3o69fmPL4KUxlk51u62qHk4u9ftiy6qge
 AQF++YaX+lHEcHWkeUkpI3Yd3tw9xEG6U01k57P/xsVjkSaxOvQdWmIpcklHDpOhAbWO
 Rw+g==
X-Gm-Message-State: AOJu0Yy3HLCC4GJ3pVrHvw5ggL+wc6XjwXvCcevx0iYUjm3WmqCNubuK
 KAyhXTzaJWuiTYoUyejqEx3PkPO/OzNAHE8alhc4iitndm2swgswvnHikzFKAMOK3MYf9N645uc
 k7AEpyNUTgYvQEck=
X-Received: by 2002:a05:6358:24a6:b0:16b:406c:a005 with SMTP id
 m38-20020a05635824a600b0016b406ca005mr5302430rwc.28.1700729275505; 
 Thu, 23 Nov 2023 00:47:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFprgbZq+mCikaDlN/8JQU2Rno5+/Nj0Gw7D/bVtK8nUXCpnlCw7JU+XNEF4QG3QySWi9FdQ==
X-Received: by 2002:a05:6358:24a6:b0:16b:406c:a005 with SMTP id
 m38-20020a05635824a600b0016b406ca005mr5302413rwc.28.1700729275181; 
 Thu, 23 Nov 2023 00:47:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 g23-20020ac84817000000b0041eef6cacf4sm319360qtq.81.2023.11.23.00.47.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 00:47:54 -0800 (PST)
Message-ID: <b79cdaaa-0327-4da7-8be7-b5581139ef47@redhat.com>
Date: Thu, 23 Nov 2023 09:47:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ppc/spapr: Initialize max_cpus limit to
 SPAPR_NR_IPIS.
Content-Language: en-US
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: danielhb413@gmail.com, clg@kaod.org, david@gibson.dropbear.id.au,
 qemu-devel@nongnu.org
References: <20231122092845.973949-1-harshpb@linux.ibm.com>
 <20231122092845.973949-3-harshpb@linux.ibm.com>
 <4eaf8cf4-94b1-425b-a712-c006abb114c3@linaro.org>
 <504a8c39-711c-2fcf-ffc7-396898d5e84b@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <504a8c39-711c-2fcf-ffc7-396898d5e84b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 11/23/23 06:03, Harsh Prateek Bora wrote:
> Hi Philippe,
> 
> On 11/22/23 16:46, Philippe Mathieu-Daudé wrote:
>> Hi Harsh,
>>
>> On 22/11/23 10:28, Harsh Prateek Bora wrote:
>>> Initialize the machine specific max_cpus limit as per the maximum range
>>> of CPU IPIs available. Keeping between 4096 to 8192 will throw IRQ not
>>> free error due to XIVE/XICS limitation and keeping beyond 8192 will hit
>>> assert in tcg_region_init or spapr_xive_claim_irq.
>>>
>>> Logs:
>>>
>>> Without patch fix:
>>>
>>> [root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=4097
>>> qemu-system-ppc64: IRQ 4096 is not free
>>> [root@host build]#
>>>
>>> On LPAR:
>>> [root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=8193
>>> **
>>> ERROR:../tcg/region.c:774:tcg_region_init: assertion failed:
>>> (region_size >= 2 * page_size)
>>> Bail out! ERROR:../tcg/region.c:774:tcg_region_init: assertion failed:
>>> (region_size >= 2 * page_size)
>>> Aborted (core dumped)
>>> [root@host build]#
>>>
>>> On x86:
>>> [root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=8193
>>> qemu-system-ppc64: ../hw/intc/spapr_xive.c:596: spapr_xive_claim_irq:
>>> Assertion `lisn < xive->nr_irqs' failed.
>>> Aborted (core dumped)
>>> [root@host build]#
>>>
>>> With patch fix:
>>> [root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=4097
>>> qemu-system-ppc64: Invalid SMP CPUs 4097. The max CPUs supported by
>>> machine 'pseries-8.2' is 4096
>>> [root@host build]#
>>>
>>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>> ---
>>>   hw/ppc/spapr.c | 9 +++------
>>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>> index df09aa9d6a..0de11a4458 100644
>>> --- a/hw/ppc/spapr.c
>>> +++ b/hw/ppc/spapr.c
>>> @@ -4647,13 +4647,10 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>>>       mc->block_default_type = IF_SCSI;
>>>       /*
>>> -     * Setting max_cpus to INT32_MAX. Both KVM and TCG max_cpus values
>>> -     * should be limited by the host capability instead of hardcoded.
>>> -     * max_cpus for KVM guests will be checked in kvm_init(), and TCG
>>> -     * guests are welcome to have as many CPUs as the host are capable
>>> -     * of emulate.
>>> +     * While KVM determines max cpus in kvm_init() using kvm_max_vcpus(),
>>> +     * In TCG the limit is restricted by the range of CPU IPIs available.
>>>        */
>>> -    mc->max_cpus = INT32_MAX;
>>> +    mc->max_cpus = SPAPR_NR_IPIS;
>>
>> Is SPAPR_NR_IPIS also the upper limit for KVM?
> 
> In KVM mode, the limit is restricted to what is supported by KVM which is checked using kvm_ioctl via wrappers in kvm_init and appears to be evaluating to 2048. So, having a larger default works for both case.

QEMU sets the number of cpus with KVM ioctls :

	KVM_DEV_XICS_NR_SERVERS
	KVM_DEV_XIVE_NR_SERVERS

This is important for the host since the interrupt controller is then
configured with these values through FW.

The default value is indeed 2K but this is large and wastes a lot of
HW resources, page mappings, etc.

Thanks,

C.




