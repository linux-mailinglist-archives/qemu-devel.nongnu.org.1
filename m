Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCD1791902
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 15:44:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd9rc-0008R4-Hm; Mon, 04 Sep 2023 09:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd9ra-0008Qh-9d
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 09:43:34 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd9rX-0003zS-VA
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 09:43:34 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-99c3d3c3db9so228341366b.3
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 06:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693835010; x=1694439810; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f5gJGVqrlSeBvbT8wDuFPneP9PS9Ap5c60pUdhWj/1g=;
 b=onrer4DOGaTOiyZCD5oYx0VfenBv9ZNLk8+3X2uLFEeLFqz3Ru+Qht4udUdJ7MnmEQ
 n4CEQZBvqRUv4IuYZmR16Y5IjTZ+G3M9ujhxb+TAPwjVWP0nwx/sQl6SiWxqcAZpyKG5
 RYiUZjFtqhpedCrFycaysVp1hsvYeh1I4KUoEO+chGJwDrgwcYiD7gsWlPlzaOsKsuj/
 4Bcd+tYHDLumY/280pBmQQeCWsdshVGN610IwAqSHXOC2EpWMVAMLRh66N892ucjtA6b
 hHemtyIAZeOj/orsG96nHa6NOgiuV6/fkkn1E8sL6JpeBCTGc0kR23YVX9NRhpOJAa9p
 oqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693835010; x=1694439810;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f5gJGVqrlSeBvbT8wDuFPneP9PS9Ap5c60pUdhWj/1g=;
 b=Q5EV5y4SY5+B9OZqCRFuaj1nt+58Z7l2ti11l6KXA8zbWx0ChDgQfo4N9tZe2tDZMe
 +egc6SMPMr/sZ0cJ0McNgGq4NJgTMOaF5IUZonb8X2qQJMco2SC7Gwdj2NWZBZ8IMCyF
 IoHV6We648+MGwP3rsYsvE6OEmXiWItERHrMXDVRphYck3JhqF2XAt85sXldCOBCehw9
 znOT1Lyhu1SERTkcQ6AtliEu2o6aS/+odtSBV+ezZivBPyP4lOEl+WjRGAwWDlYd7nmf
 +03DMLzZQxAEwsR4XlTMAOSM2nmVI7znxJyrido17wYLoCMB/bTWn0qtCWsJ5wDP1Ayp
 ofvg==
X-Gm-Message-State: AOJu0YyY2JCYzCVnLNhiAIuWyTpK4jsqivzMRr2rbyGty28g1xjyWBgK
 26LXO8Lz5ac1P7+BdI4rCyxmRA==
X-Google-Smtp-Source: AGHT+IEayKzsFdONfTDgJQTz2lzK1Hv/KT4rI4AD4K19/V03MlRp8J8ARMaQnecpWTsfHk7ts1ZlVw==
X-Received: by 2002:a17:906:212:b0:9a1:f6e0:12f4 with SMTP id
 18-20020a170906021200b009a1f6e012f4mr7867176ejd.15.1693835010245; 
 Mon, 04 Sep 2023 06:43:30 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 j24-20020a170906051800b0099bcdfff7cbsm6148985eja.160.2023.09.04.06.43.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 06:43:29 -0700 (PDT)
Message-ID: <01d89654-99fe-8a14-e753-698f4025c106@linaro.org>
Date: Mon, 4 Sep 2023 15:43:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 07/13] target/i386: Allow elision of kvm_enable_x2apic()
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, kvm@vger.kernel.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20230904124325.79040-1-philmd@linaro.org>
 <20230904124325.79040-8-philmd@linaro.org>
 <4b7bb33a-625d-5ad4-2110-c575b173aad9@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <4b7bb33a-625d-5ad4-2110-c575b173aad9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 4/9/23 15:40, Paolo Bonzini wrote:
> On 9/4/23 14:43, Philippe Mathieu-Daudé wrote:
>> Call kvm_enabled() before kvm_enable_x2apic() to
>> let the compiler elide its call.
>>
>> Suggested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/i386/intel_iommu.c      | 2 +-
>>   hw/i386/x86.c              | 2 +-
>>   target/i386/kvm/kvm-stub.c | 7 -------
>>   3 files changed, 2 insertions(+), 9 deletions(-)


>> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
>> index a88a126123..d2920af792 100644
>> --- a/hw/i386/x86.c
>> +++ b/hw/i386/x86.c
>> @@ -136,7 +136,7 @@ void x86_cpus_init(X86MachineState *x86ms, int 
>> default_cpu_version)
>>        * With KVM's in-kernel lapic: only if X2APIC API is enabled.
>>        */
>>       if (x86ms->apic_id_limit > 255 && !xen_enabled() &&
>> -        (!kvm_irqchip_in_kernel() || !kvm_enable_x2apic())) {
>> +        kvm_enabled() && (!kvm_irqchip_in_kernel() || 
>> !kvm_enable_x2apic())) {
> 
> This "!xen && kvm" expression can be simplified.
> 
> I am queuing the series with this squashed in:
> 
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index d2920af792d..3e86cf3060f 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -129,14 +129,11 @@ void x86_cpus_init(X86MachineState *x86ms, int 
> default_cpu_version)
>                                                         ms->smp.max_cpus 
> - 1) + 1;
> 
>       /*
> -     * Can we support APIC ID 255 or higher?
> -     *
> -     * Under Xen: yes.
> -     * With userspace emulated lapic: no
> -     * With KVM's in-kernel lapic: only if X2APIC API is enabled.
> +     * Can we support APIC ID 255 or higher?  With KVM, that requires
> +     * both in-kernel lapic and X2APIC userspace API.
>        */
> -    if (x86ms->apic_id_limit > 255 && !xen_enabled() &&
> -        kvm_enabled() && (!kvm_irqchip_in_kernel() || 
> !kvm_enable_x2apic())) {
> +    if (x86ms->apic_id_limit > 255 && kvm_enabled() &&
> +        (!kvm_irqchip_in_kernel() || !kvm_enable_x2apic())) {
>           error_report("current -smp configuration requires kernel "
>                        "irqchip and X2APIC API support.");
>           exit(EXIT_FAILURE);
> 
> Paolo

Thank you!

