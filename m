Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 941C575692A
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 18:31:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLR73-0005KC-4N; Mon, 17 Jul 2023 12:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qLR6s-0005Jz-DU
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 12:30:06 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qLR6p-0001Xn-Le
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 12:30:06 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6b9defb366eso290653a34.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 09:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689611402; x=1692203402;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kzumRxpe7OV4cHt2z4WaE55tMoB7SFnfq9lmJz7W1vo=;
 b=NKxKDSGtHRWZwBbgzINmZdynJueKEKzf5VST8+/rbiR/fGHIOFSzjqvBLz/I+HbD2F
 xJaTPXduNz2FnJLIh9j1CHlDYAQDw2YmieVeJTjXFIhFgofCODd2OHPGegsaEB4+bgyJ
 K7xsrbrzeoPF1FiZeH3ogn9cXH9uAEOzonaM4nNLSJAaYaZgj107KKNzlr5nMNmT6S3O
 rTrowM/fkvY0N4jL0jua0HasXYbGYumd2s6DxmWsAKSjSrzFPDJu+yJ/8CtH874t13QP
 1H9xa85G10JHCc/NzFYzCaF6a0kWyEhofGA16eDy7hhmCr9bu8C+/+3p1n8ntLkl4kPy
 jW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689611402; x=1692203402;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kzumRxpe7OV4cHt2z4WaE55tMoB7SFnfq9lmJz7W1vo=;
 b=SJQ1gV5AemtefS/kiH04HjEIDuOxV9q3+sFHCwF3kwb2nxzroPfVBsWZ1GTQWr4WBA
 +duuWThsxVsJC324qRjGa22x+dLNor63/x1yQMUm7eSVKDMvMKsk4X78Ig73QNEkLdrJ
 0dlQvCpa4XKgQyh9p5e8dSHGiEdKuVD/1KMK07nkZL99NKmey05bbQ19SWZV1Ew42z7T
 0b79YOrj8SD1sMjk5b++L1qt4CObODNsMF/wVPXg3Ax42n3RD15efwAdSgUqf0r+LyQf
 q447bs19vwudJwIBv+JkrPwJByMaoegLi1gJHerEGOdW2FgNViW2LN4YQ3IHaI9zFv+7
 V3Fw==
X-Gm-Message-State: ABy/qLYU2V0bNRph5Sk6tYk497Z+MBPfcXxWDL5RiVRPJvOJR1Mvdr6x
 mEi5a9PBTlo6ELUtN50Q43M=
X-Google-Smtp-Source: APBJJlEQiDDyvzF3EohCfBvriE9W7YTQqLJaTkex5XN2wPstS1eRPas5SJ2q63uKJtbwiEmG8nUSCg==
X-Received: by 2002:a05:6830:138b:b0:6b1:5f4a:f52d with SMTP id
 d11-20020a056830138b00b006b15f4af52dmr11200519otq.22.1689611401888; 
 Mon, 17 Jul 2023 09:30:01 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4fb3:b780:92a3:418a:c0a9:6803?
 ([2001:ee0:4fb3:b780:92a3:418a:c0a9:6803])
 by smtp.gmail.com with ESMTPSA id
 s11-20020a63b40b000000b0055fe64fd3f4sm32640pgf.9.2023.07.17.09.29.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 09:30:01 -0700 (PDT)
Message-ID: <adf436ea-8b4a-be24-4df4-7f018975b1e9@gmail.com>
Date: Mon, 17 Jul 2023 23:29:56 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 4/5] intel_iommu: allow Extended Interrupt Mode when
 using userspace APIC
To: Joao Martins <joao.m.martins@oracle.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Peter Xu
 <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20230715152224.54757-1-minhquangbui99@gmail.com>
 <20230715152224.54757-5-minhquangbui99@gmail.com>
 <4f5a644e-8341-798a-bfe3-27eeb5816623@oracle.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <4f5a644e-8341-798a-bfe3-27eeb5816623@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=minhquangbui99@gmail.com; helo=mail-ot1-x329.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.097,
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

On 7/17/23 17:47, Joao Martins wrote:
> +Peter, +Jason (intel-iommu maintainer/reviewer)
> 
> On 15/07/2023 16:22, Bui Quang Minh wrote:
>> As userspace APIC now supports x2APIC, intel interrupt remapping
>> hardware can be set to EIM mode when userspace local APIC is used.
>>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   hw/i386/intel_iommu.c | 11 -----------
>>   1 file changed, 11 deletions(-)
>>
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index dcc334060c..5e576f6059 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -4043,17 +4043,6 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>>                         && x86_iommu_ir_supported(x86_iommu) ?
>>                                                 ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>>       }
>> -    if (s->intr_eim == ON_OFF_AUTO_ON && !s->buggy_eim) {
>> -        if (!kvm_irqchip_is_split()) {
>> -            error_setg(errp, "eim=on requires accel=kvm,kernel-irqchip=split");
>> -            return false;
>> -        }
>> -        if (!kvm_enable_x2apic()) {
>> -            error_setg(errp, "eim=on requires support on the KVM side"
>> -                             "(X2APIC_API, first shipped in v4.7)");
>> -            return false;
>> -        }
>> -    }
>>   
> Given commit 20ca47429e ('Revert "intel_iommu: Fix irqchip / X2APIC
> configuration checks"'), won't we regress behaviour again  for the accel=kvm
> case by dropping the kvm_enable_x2apic() call here?
> 
> Perhaps if we support userspace APIC with TCG the check just needs to be redone
> to instead avoid always requiring kvm e.g.:
> 
> if (kvm_irqchip_in_kernel()) {
>      error_setg(errp, "eim=on requires accel=kvm,kernel-irqchip=split"
>                 "(X2APIC_API, first shipped in v4.7)");
> }
> 
> if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
>      error_setg(errp, "eim=on requires support on the KVM side"
>                 "(X2APIC_API, first shipped in v4.7)");
>      return false;
> }

Thank you for your review. I think the check for kvm_irqchip_in_kernel() 
is not correct, AFAIK, kvm_irqchip_is_split() == true also means 
kvm_irqchip_in_kernel() == true on x86. To check if kernel-irqchip = on, 
we need to do something like in x86_iommu_realize

     bool irq_all_kernel = kvm_irqchip_in_kernel() && 
!kvm_irqchip_is_split();

The original check for !kvm_irqchip_is_split means emulated/userspace 
APIC. It's because to reach that check x86_iommu_ir_supported(...) == 
true and x86_iommu_ir_supported(...) == true is not supported when 
kernel-irqchip = on (there is a check for this in x86_iommu_realize)

So I think we need to change the check to

     if (s->intr_eim == ON_OFF_AUTO_ON && !s->buggy_eim) {
         if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
             error_setg(errp, "eim=on requires support on the KVM side"
                              "(X2APIC_API, first shipped in v4.7)");
             return false;
         }
     }

Is it OK?

Thanks,
Quang Minh.

