Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B167F5C46
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 11:27:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r66vN-0004ho-US; Thu, 23 Nov 2023 05:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r66vE-0004fE-UP
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 05:27:01 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r66vC-0005BF-Df
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 05:26:59 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40842752c6eso4155225e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 02:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700735217; x=1701340017; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xs0+Af+0qW4iKdDxGSOBfroR4pY1ftXvrBogdumSwEk=;
 b=Vjo0CyH6hsIZNMkIse8xy6LFXIvZqYM9ZxSRU7x/UwxVapox2bbXW2HlsUiNO4CltV
 c0CCsIWk0PddsUjPhnA5nEoMJ1FN92Tp4bdPI+2luCVHuICPXH209R6+4/v3aM6uT7VP
 CeDvH12LK1BIhPZeqKowwR9rcp5mfHwGHWBN4MzwJ2O0iQdCJXtgmb3MCF9a9/DShS9z
 6bQjgD1Ozd8jQ+j1Un9t3ZmOnVDW85VNzsuF8C3Y3XnbzbitvCrkFcKgnrcQ1C8uJIhj
 2I1Mkz0L/5TsM9n9ZFcgQAAWCvwFeb49TfF8i9tZ9P7+bQVOLqG1CzHu0i3ZQGvII8VH
 iheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700735217; x=1701340017;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xs0+Af+0qW4iKdDxGSOBfroR4pY1ftXvrBogdumSwEk=;
 b=YWvpyHrC9NDrsUdfiyDwh76X1xg3DWNTXpp7rg7z+VzDZV+i90ErhpQvyyKION9Msg
 AiTAkAmi9g+YUDivqiAKNiTE/Tq0nDkjxDhVoY+oUkSQraGOPWXoG8m61M/554KEjyob
 s6uN0fZrSmB2wyRSGhgcOeMHs2Gps3VejPDQkuDmw8stSLHVL9NOqBgxFcTcoGucygrK
 8lPo/qRuIl8v+wTb4LoFMykpGnSwfadbn+RPiLt+laEwy0z3bVhP4hNp9bziQ82XAqIS
 8cxlKf4jLE3kQrlh71Rxy6oiNLuGINzTR9EkARblg5UdEjJXoOsD+dYZdmJ2I/Rlm38r
 Wpeg==
X-Gm-Message-State: AOJu0Yy5R+Osg0vgl/KMtl1DetPZ3YF4aANXZ0sORJ1un+RLl2SMLXIe
 CrqAVfkAIAdEIcgrcySHJvp8eQ==
X-Google-Smtp-Source: AGHT+IFiig9F1KbkGFdOpcTQ2P45LFLGDwqwtIbY5IoqyEq3mHlN8b+L1jF5heX4Xz5V3Qrs50kIYg==
X-Received: by 2002:a05:600c:358f:b0:40b:3721:c3cf with SMTP id
 p15-20020a05600c358f00b0040b3721c3cfmr759582wmq.21.1700735216955; 
 Thu, 23 Nov 2023 02:26:56 -0800 (PST)
Received: from [192.168.69.100] ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 a4-20020adfeec4000000b0033130644c87sm1267619wrp.54.2023.11.23.02.26.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 02:26:55 -0800 (PST)
Message-ID: <df35ce9e-46b5-4380-8037-426d54fbf786@linaro.org>
Date: Thu, 23 Nov 2023 11:26:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ppc/spapr: Initialize max_cpus limit to
 SPAPR_NR_IPIS.
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, npiggin@gmail.com,
 qemu-ppc@nongnu.org
Cc: danielhb413@gmail.com, clg@kaod.org, david@gibson.dropbear.id.au,
 qemu-devel@nongnu.org
References: <20231122092845.973949-1-harshpb@linux.ibm.com>
 <20231122092845.973949-3-harshpb@linux.ibm.com>
 <4eaf8cf4-94b1-425b-a712-c006abb114c3@linaro.org>
 <504a8c39-711c-2fcf-ffc7-396898d5e84b@linux.ibm.com>
 <b79cdaaa-0327-4da7-8be7-b5581139ef47@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b79cdaaa-0327-4da7-8be7-b5581139ef47@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 23/11/23 09:47, Cédric Le Goater wrote:
> On 11/23/23 06:03, Harsh Prateek Bora wrote:
>> Hi Philippe,
>>
>> On 11/22/23 16:46, Philippe Mathieu-Daudé wrote:
>>> Hi Harsh,
>>>
>>> On 22/11/23 10:28, Harsh Prateek Bora wrote:
>>>> Initialize the machine specific max_cpus limit as per the maximum range
>>>> of CPU IPIs available. Keeping between 4096 to 8192 will throw IRQ not
>>>> free error due to XIVE/XICS limitation and keeping beyond 8192 will hit
>>>> assert in tcg_region_init or spapr_xive_claim_irq.
>>>>
>>>> Logs:
>>>>
>>>> Without patch fix:
>>>>
>>>> [root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=4097
>>>> qemu-system-ppc64: IRQ 4096 is not free
>>>> [root@host build]#
>>>>
>>>> On LPAR:
>>>> [root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=8193
>>>> **
>>>> ERROR:../tcg/region.c:774:tcg_region_init: assertion failed:
>>>> (region_size >= 2 * page_size)
>>>> Bail out! ERROR:../tcg/region.c:774:tcg_region_init: assertion failed:
>>>> (region_size >= 2 * page_size)
>>>> Aborted (core dumped)
>>>> [root@host build]#
>>>>
>>>> On x86:
>>>> [root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=8193
>>>> qemu-system-ppc64: ../hw/intc/spapr_xive.c:596: spapr_xive_claim_irq:
>>>> Assertion `lisn < xive->nr_irqs' failed.
>>>> Aborted (core dumped)
>>>> [root@host build]#
>>>>
>>>> With patch fix:
>>>> [root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=4097
>>>> qemu-system-ppc64: Invalid SMP CPUs 4097. The max CPUs supported by
>>>> machine 'pseries-8.2' is 4096
>>>> [root@host build]#
>>>>
>>>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>>> ---
>>>>   hw/ppc/spapr.c | 9 +++------
>>>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>> index df09aa9d6a..0de11a4458 100644
>>>> --- a/hw/ppc/spapr.c
>>>> +++ b/hw/ppc/spapr.c
>>>> @@ -4647,13 +4647,10 @@ static void 
>>>> spapr_machine_class_init(ObjectClass *oc, void *data)
>>>>       mc->block_default_type = IF_SCSI;
>>>>       /*
>>>> -     * Setting max_cpus to INT32_MAX. Both KVM and TCG max_cpus values
>>>> -     * should be limited by the host capability instead of hardcoded.
>>>> -     * max_cpus for KVM guests will be checked in kvm_init(), and TCG
>>>> -     * guests are welcome to have as many CPUs as the host are capable
>>>> -     * of emulate.
>>>> +     * While KVM determines max cpus in kvm_init() using 
>>>> kvm_max_vcpus(),
>>>> +     * In TCG the limit is restricted by the range of CPU IPIs 
>>>> available.
>>>>        */
>>>> -    mc->max_cpus = INT32_MAX;
>>>> +    mc->max_cpus = SPAPR_NR_IPIS;
>>>
>>> Is SPAPR_NR_IPIS also the upper limit for KVM?
>>
>> In KVM mode, the limit is restricted to what is supported by KVM which 
>> is checked using kvm_ioctl via wrappers in kvm_init and appears to be 
>> evaluating to 2048. So, having a larger default works for both case.
> 
> QEMU sets the number of cpus with KVM ioctls :
> 
>      KVM_DEV_XICS_NR_SERVERS
>      KVM_DEV_XIVE_NR_SERVERS
> 
> This is important for the host since the interrupt controller is then
> configured with these values through FW.
> 
> The default value is indeed 2K but this is large and wastes a lot of
> HW resources, page mappings, etc.

I was wondering if one day KVM raise its limit to 5k, then the
machine will clamp to 4k, and someone will have to debug that.
Not a big deal ;)


