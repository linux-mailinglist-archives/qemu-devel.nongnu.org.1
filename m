Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CC67B8585
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:41:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo4ve-00023g-4C; Wed, 04 Oct 2023 12:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qo4vc-00023G-L9
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:40:52 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qo4va-0005eA-S7
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:40:52 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c87a85332bso5704775ad.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 09:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696437649; x=1697042449; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o97dIzY+wFB7gls2DScRGaQk48ccwDJeGF2jVr7xCjg=;
 b=af0qOLr4MMFw7rQkAmOr9N5waa2atwn2JsqVvnYAIi+2P4GDT75s6Ysg83ubcGOOLz
 ePhnXapKmCRffvJ8qGzxZP167ETcbGuFHYWzkexXAMNvgTczVCW2kBxZmbIVSI1f9hdN
 HYzq5ui9DP5u6eApi1F+STHCJwJaLeKKwPtty1bdAjQQCg2lHWnTBRjVQOCVclJ51j0b
 Cj3C8mjiJMLlzSeHhIM2yl2JRWbw06oWe5bGtfvFh6Of7ddRMp+8ybt+lKUKxOa5bCui
 MbqqIeD43wazwDbjEnwo6A5RLstfb77qJfLFTvRbnjhGYCdlKsvnrVXoglsi2PqDTz7k
 1DOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696437649; x=1697042449;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o97dIzY+wFB7gls2DScRGaQk48ccwDJeGF2jVr7xCjg=;
 b=mvmU4vG/rQ2rkPFaQnrcKQ3d8vJ4gbINr3Lx2fx7s+ytZ03vJVr+umymAxcDW6oSw5
 Qh7JZNRB85RrMrxtdO6K/gONkz/ncL+9j0+yeNm0ciLfJSHC0DFwmRiat8Wx/B4RD4rw
 2qRnODVMqGSj4QD8+JNSwZrYSusFQ3d/y7dUpJdelOMBGUf00kja7ZfLw24TiPVM/XBw
 bHaF1XF6Hmeu2TAUGuoRx1To4tNlEftadDgdk2Z6f9oVJUTBsRbNfuj2uZOxlkqX/3LD
 kH/unYOAdy8eIcGfU4uX5e0eavTr9G+wyQCdZs6EDnww8Z1Pygz+P8jg6f8sxC5Cxt4i
 ca/Q==
X-Gm-Message-State: AOJu0YxlqB8phtmUWBGuwmCa6q6Iz/eOUYNLw2ky9pygcUEq39VKCq4G
 deRKIzy0lbyGzL7EkQR+bcc=
X-Google-Smtp-Source: AGHT+IHSoclzZxnCxR5lkN0VLtD/DYZaE4ZP1g1FxtEElWfmVFIr+rkSVYSNRsse4sLBPvoKtpjKJg==
X-Received: by 2002:a17:902:ab82:b0:1c4:387a:3259 with SMTP id
 f2-20020a170902ab8200b001c4387a3259mr2947141plr.46.1696437648865; 
 Wed, 04 Oct 2023 09:40:48 -0700 (PDT)
Received: from ?IPV6:2001:ee0:50f4:9050:320e:6006:517:e141?
 ([2001:ee0:50f4:9050:320e:6006:517:e141])
 by smtp.gmail.com with ESMTPSA id
 y5-20020a1709029b8500b001b8b2b95068sm3930467plp.204.2023.10.04.09.40.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 09:40:48 -0700 (PDT)
Message-ID: <d7e14546-96e0-4ee2-928e-bd4035f09b89@gmail.com>
Date: Wed, 4 Oct 2023 23:40:43 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] Support x2APIC mode with TCG accelerator
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, David Woodhouse <dwmw2@infradead.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Joao Martins <joao.m.martins@oracle.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20230926160637.27995-1-minhquangbui99@gmail.com>
 <1e402165-24bd-7380-a5a7-c32fe33e457d@gmail.com>
 <20231004025051-mutt-send-email-mst@kernel.org>
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20231004025051-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 10/4/23 13:51, Michael S. Tsirkin wrote:
> On Tue, Sep 26, 2023 at 11:23:53PM +0700, Bui Quang Minh wrote:
>> On 9/26/23 23:06, Bui Quang Minh wrote:
>>
>>> Version 8 changes,
>>> - Patch 2, 4:
>>>     + Rebase to master and resolve conflicts in these 2 patches
>>
>> The conflicts when rebasing is due to the commit 9926cf34de5fa15da
>> ("target/i386: Allow elision of kvm_enable_x2apic()"). AFAIK, this commit
>> adds kvm_enabled() before kvm_enable_x2apic() in the and (&&) expression so
>> that when kvm_enabled() is known to be false at the compile time
>> (CONFIG_KVM_IS_POSSIBLE is undefined), the compiler can omit the
>> kvm_enable_x2apic() in the and expression.
>>
>> In patch 2, I simply combine the change logic in patch 2 with logic in the
>> commit 9926cf34de5fa15da.
>>
>> In patch 4, the end result of version 8 is the same as version 7. I don't
>> think we need to add the kvm_enabled() to make the expression become
>>
>> 	if (kvm_enabled() && kvm_irqchip_is_split() && !kvm_enable_x2apic())
>>
>> Because when CONFIG_KVM_IS_POSSIBLE is undefined, kvm_irqchip_is_split() is
>> known to be false at the compile time too so just keep the expression as
>>
>> 	if (kvm_irqchip_is_split() && !kvm_enable_x2apic())
>>
>> is enough.
>>
>>> git range-diff feat/tcg-x2apic-v7~5..feat/tcg-x2apic-v7
>> feat/tcg-x2apic-v8~5..feat/tcg-x2apic-v8
>>
>> 1:  c1d197a230 = 1:  f6e3918e0f i386/tcg: implement x2APIC registers MSR
>> access
>> 2:  dd96cb0238 ! 2:  54d44a15b6 apic: add support for x2APIC mode
>>      @@ Commit message
>>
>>        ## hw/i386/x86.c ##
>>       @@ hw/i386/x86.c: void x86_cpus_init(X86MachineState *x86ms, int
>> default_cpu_version)
>>      -      * Can we support APIC ID 255 or higher?
>>      -      *
>>      -      * Under Xen: yes.
>>      --     * With userspace emulated lapic: no
>>      -+     * With userspace emulated lapic: checked later in
>> apic_common_set_id.
>>      -      * With KVM's in-kernel lapic: only if X2APIC API is enabled.
>>      +      * both in-kernel lapic and X2APIC userspace API.
>>             */
>>      -     if (x86ms->apic_id_limit > 255 && !xen_enabled() &&
>>      +     if (x86ms->apic_id_limit > 255 && kvm_enabled() &&
>>       -        (!kvm_irqchip_in_kernel() || !kvm_enable_x2apic())) {
>>       +        kvm_irqchip_in_kernel() && !kvm_enable_x2apic()) {
>>                error_report("current -smp configuration requires kernel "
>> 3:  31a5c555a6 = 3:  eb080d1e2c apic, i386/tcg: add x2apic transitions
>> 4:  d78b5c43b4 ! 4:  59f028f119 intel_iommu: allow Extended Interrupt Mode
>> when using userspace APIC
>>      @@ hw/i386/intel_iommu.c: static bool vtd_decide_config(IntelIOMMUState
>> *s, Error *
>>       -            error_setg(errp, "eim=on requires
>> accel=kvm,kernel-irqchip=split");
>>       -            return false;
>>       -        }
>>      --        if (!kvm_enable_x2apic()) {
>>      +-        if (kvm_enabled() && !kvm_enable_x2apic()) {
>>       +        if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
>>                    error_setg(errp, "eim=on requires support on the KVM side"
>>                                     "(X2APIC_API, first shipped in v4.7)");
>> 5:  51f558035d = 5:  bc95c3cb60 amd_iommu: report x2APIC support to the
>> operating system
>>
>> As the change is minor and does not change the main logic, I keep the
>> Reviewed-by and Acked-by tags.
>>
>> Thank you,
>> Quang Minh.
> 
> 
> 
> Causes some build failures:
> 
> https://gitlab.com/mstredhat/qemu/-/jobs/5216377483
> /builds/mstredhat/qemu/build/../hw/intc/apic.c:1023: undefined reference to `raise_exception_ra'

raise_exception_ra is tcg specific so the builds are failed as tcg is 
disabled. I will remove the use of raise_exception_ra, the invalid 
register read just returns 0, invalid register write has no effect 
without raising the exception anymore. The APIC state invalid transition 
does not raise exception either, just don't change the APIC state. As a 
side effect, we fail some more KVM unit test of invalid APIC state 
transition, as they expect to catch exception in these cases. I think 
it's not a big problem. What's your opinion?

Thank you,
Quang Minh.

