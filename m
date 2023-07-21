Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A19175CBF5
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 17:36:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMsA1-0004mq-NK; Fri, 21 Jul 2023 11:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qMs9x-0004jO-Eb
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 11:35:14 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qMs9t-0006y7-Gi
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 11:35:12 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1b89bc52cd1so12615055ad.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 08:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689953707; x=1690558507;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MgHBUUmrL3W122zNbz7sMFASpNnrgLXhmpTzyN0221Q=;
 b=VBDGWyZ1TjiMiL6ExH1Tgphvj3gP6GkKWG4MrMKOw3AfyWUT87xmrFUm/cxZ+S/dd7
 tXv+wZv8ikiSyH8lfahONVvofxLSxNw79RAWhsGf0B6G4GqJy3QliGy4Epyz/4i7XsQz
 0Q+0wItUmgpZYW4dhJI9enlhVVmVjQ31Ms1Iw8ljb0IXM245w7i99FCwwy9kGajxSP00
 L2uHcAwDuyXr4T+EmWbOgcDO35BHBHG4ez65MQfRJRDJUbo3uuud79MLLcmFRRna/URs
 +IrDSWkkEpuKlKQEQ1VjoWwXp3TuopaoaAMDZqEQtslSt3p0Nn83XKuQqrwJXS9YjmYF
 1mxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689953707; x=1690558507;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MgHBUUmrL3W122zNbz7sMFASpNnrgLXhmpTzyN0221Q=;
 b=aT+dgLnBUP336D0x8gDFcYp8ELXD02sV03XgSp4DtonnLakwkrBbR8FLhPlI65hnoF
 Ae7o7K2PcQTLFGwnONltvxA4EpnZqVfKfLQT3APlaa2NufJP9EWndGRZaeV9tCeal/s6
 5Oz6QtCGFrxYTQ5ggpCTxCO18HOP5Xe1JgeUKUj468CWj/9Kyx77BMJ2WNyx+00S4Tr9
 2CrT0lImo+yH9rUMwVxSDBQgUtqx4onwQ3FxceRXutYnUuusz2gs0iNpDOKy5kjD3s85
 ELHbnw60LXVpq7nLMTu2c0cxmx+7QDxY3M3KtYvizJo1Yuz9XOFFtLYAzeNucaeDV85j
 MFpA==
X-Gm-Message-State: ABy/qLakepo/a1MHOQzAAu14vFFP7x0ENX6+bnqONio3eDnVJ2vfPDyb
 vDigldyBZ1NKNb3BZOBsFII=
X-Google-Smtp-Source: APBJJlFPS07X4twZ1A57VaG14Q0ahIhuj5mloGtczFzBEmDNEbIYdLcR8xNt8q6UW6Cdoe4w/t3q6A==
X-Received: by 2002:a17:902:ab1b:b0:1b9:d2fc:ba9f with SMTP id
 ik27-20020a170902ab1b00b001b9d2fcba9fmr1586904plb.11.1689953707113; 
 Fri, 21 Jul 2023 08:35:07 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4fb3:b780:83f3:10be:78d8:4fc6?
 ([2001:ee0:4fb3:b780:83f3:10be:78d8:4fc6])
 by smtp.gmail.com with ESMTPSA id
 i5-20020a170902c94500b001bb1f0605b2sm3617010pla.214.2023.07.21.08.35.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 08:35:06 -0700 (PDT)
Message-ID: <46f648af-095e-b4ec-4fd4-cb9f413cdab2@gmail.com>
Date: Fri, 21 Jul 2023 22:35:01 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 4/5] intel_iommu: allow Extended Interrupt Mode when
 using userspace APIC
To: Peter Xu <peterx@redhat.com>
Cc: Joao Martins <joao.m.martins@oracle.com>,
 David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>
References: <20230715152224.54757-1-minhquangbui99@gmail.com>
 <20230715152224.54757-5-minhquangbui99@gmail.com>
 <4f5a644e-8341-798a-bfe3-27eeb5816623@oracle.com>
 <adf436ea-8b4a-be24-4df4-7f018975b1e9@gmail.com> <ZLmdWv0YndpUe9iM@x1n>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <ZLmdWv0YndpUe9iM@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.094,
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

On 7/21/23 03:47, Peter Xu wrote:
> On Mon, Jul 17, 2023 at 11:29:56PM +0700, Bui Quang Minh wrote:
>> On 7/17/23 17:47, Joao Martins wrote:
>>> +Peter, +Jason (intel-iommu maintainer/reviewer)
> 
> Thanks for copying me, Joan.
> 
>>>
>>> On 15/07/2023 16:22, Bui Quang Minh wrote:
>>>> As userspace APIC now supports x2APIC, intel interrupt remapping
>>>> hardware can be set to EIM mode when userspace local APIC is used.
>>>>
>>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>>>> ---
>>>>    hw/i386/intel_iommu.c | 11 -----------
>>>>    1 file changed, 11 deletions(-)
>>>>
>>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>>> index dcc334060c..5e576f6059 100644
>>>> --- a/hw/i386/intel_iommu.c
>>>> +++ b/hw/i386/intel_iommu.c
>>>> @@ -4043,17 +4043,6 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>>>>                          && x86_iommu_ir_supported(x86_iommu) ?
>>>>                                                  ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>>>>        }
>>>> -    if (s->intr_eim == ON_OFF_AUTO_ON && !s->buggy_eim) {
>>>> -        if (!kvm_irqchip_is_split()) {
>>>> -            error_setg(errp, "eim=on requires accel=kvm,kernel-irqchip=split");
>>>> -            return false;
>>>> -        }
>>>> -        if (!kvm_enable_x2apic()) {
>>>> -            error_setg(errp, "eim=on requires support on the KVM side"
>>>> -                             "(X2APIC_API, first shipped in v4.7)");
>>>> -            return false;
>>>> -        }
>>>> -    }
>>> Given commit 20ca47429e ('Revert "intel_iommu: Fix irqchip / X2APIC
>>> configuration checks"'), won't we regress behaviour again  for the accel=kvm
>>> case by dropping the kvm_enable_x2apic() call here?
>>>
>>> Perhaps if we support userspace APIC with TCG the check just needs to be redone
>>> to instead avoid always requiring kvm e.g.:
>>>
>>> if (kvm_irqchip_in_kernel()) {
>>>       error_setg(errp, "eim=on requires accel=kvm,kernel-irqchip=split"
>>>                  "(X2APIC_API, first shipped in v4.7)");
>>> }
>>>
>>> if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
>>>       error_setg(errp, "eim=on requires support on the KVM side"
>>>                  "(X2APIC_API, first shipped in v4.7)");
>>>       return false;
>>> }
>>
>> Thank you for your review. I think the check for kvm_irqchip_in_kernel() is
>> not correct, AFAIK, kvm_irqchip_is_split() == true also means
>> kvm_irqchip_in_kernel() == true on x86. To check if kernel-irqchip = on, we
>> need to do something like in x86_iommu_realize
>>
>>      bool irq_all_kernel = kvm_irqchip_in_kernel() &&
>> !kvm_irqchip_is_split();
>>
>> The original check for !kvm_irqchip_is_split means emulated/userspace APIC.
>> It's because to reach that check x86_iommu_ir_supported(...) == true and
>> x86_iommu_ir_supported(...) == true is not supported when kernel-irqchip =
>> on (there is a check for this in x86_iommu_realize)
>>
>> So I think we need to change the check to
>>
>>      if (s->intr_eim == ON_OFF_AUTO_ON && !s->buggy_eim) {
>>          if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
>>              error_setg(errp, "eim=on requires support on the KVM side"
>>                               "(X2APIC_API, first shipped in v4.7)");
>>              return false;
>>          }
>>      }
>>
>> Is it OK?
> 
> Mostly to me, except that we may also want to keep failing if all irq chips
> are in kernel?

Yes, that behavior does not change after this patch. x86_iommu_realize 
in the parent type TYPE_X86_IOMMU_DEVICE fails when interrupt remapping 
is on and all irq chips are in kernel already.

     static void x86_iommu_realize(DeviceState *dev, Error **errp)
     {
         /* ... */
         /* Both Intel and AMD IOMMU IR only support "kernel-irqchip 
{off|split}" */
         if (x86_iommu_ir_supported(x86_iommu) && irq_all_kernel) {
             error_setg(errp, "Interrupt Remapping cannot work with "
                          "kernel-irqchip=on, please use 'split|off'.");
             return;
         }
         /* ... */
     }


So in case we reach here in with the interrupt remapping is on and 
decide whether eim is on or not, it cannot be that irq chips are all in 
kernel.

Thanks,
Quang Minh.

