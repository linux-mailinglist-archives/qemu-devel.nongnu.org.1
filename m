Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE2B806EEA
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 12:50:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAqOZ-0001eM-2U; Wed, 06 Dec 2023 06:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAqOW-0001dz-Ff
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 06:48:48 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAqOU-00074Z-K7
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 06:48:48 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a00c200782dso95208466b.1
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 03:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701863325; x=1702468125; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uaaChIsfdDTa+nGnyTnK4jDGD3vjpPfqxoAIZJ3M9ug=;
 b=WwRcUzIcr4l5fjscHko+JjQWG8hYFNaF9hnA26M4Gh0uEXU+/YIeoD+muqjc2K5dd7
 65wG9VuzEHlEoC2gN4r7IDnH9Bc43lgtZAzZRPpYSrhNTaaIMhPK2xBDSPhH80bGVJ7p
 M3LhFMhsMiWtJyz4Ey9/6LMmhj0/p8VH8+NOC+P//FjmETaGV5m9U+uD2OfPpYbkPYlh
 Q8xmrePan/duSCOc+jGmvXW6sU4N/imvGFBXOmb1V9g16LFiRPlHKC42am+IDAOC7HAe
 rBINTK8Jj0e9hJBRdCz/3fUDbch7EMTlyrLLtjnATJYkGQelq4GC409pDieezGthjJZ5
 4qKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701863325; x=1702468125;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uaaChIsfdDTa+nGnyTnK4jDGD3vjpPfqxoAIZJ3M9ug=;
 b=kdPFYZfqO70KHX5j976YauDj5VBuuiFIpCwN+7ajvu4xQBGiUqeFMgE+2CLMwPbIV1
 QmlNm22LpPTgezYFfO2aVhRkG0IKmLG2zM7ZGlQ1gzkQWsN/uriyGVv/bd0Ty20Q1Ywu
 2m/AtnUTxPytabHLk3EoeZ9M8F0u0bVWCY1zlwX/8muF4JxUcLIetD4K+SAdEmvRUlmc
 sD+Wur5Gw5KxcSMA6rHX8YbM4Qtiw9Z7coI9tX3yGZP+McXY6HzWxO6nWiKQqkTRjqoL
 ioIiOkx9rV7JVZSdwaepfc9eb4ks+Pmse5eIA4KbwA3gukGyoDbTyUsHJQQ/QYyvUkOj
 kDFQ==
X-Gm-Message-State: AOJu0Yzt/x0ZTrO+ft7hR3QvPcPpPgUTkfH/gY67R4zQL7IACObdvNey
 TNf+uhkIRAdS/dW68zpsMUJWTg==
X-Google-Smtp-Source: AGHT+IFq73Dx3oTOlnwUtGRWueTbMuTaB87Oif2jdjZeL3l9m8lupjmI3NzFkFWMAmbepPgPxNh7Aw==
X-Received: by 2002:a17:906:4e18:b0:a19:d40a:d21f with SMTP id
 z24-20020a1709064e1800b00a19d40ad21fmr246840eju.235.1701863325091; 
 Wed, 06 Dec 2023 03:48:45 -0800 (PST)
Received: from [192.168.69.100] (tal33-h02-176-184-38-132.dsl.sta.abo.bbox.fr.
 [176.184.38.132]) by smtp.gmail.com with ESMTPSA id
 ty6-20020a170907c70600b00a1ddb5a2f7esm480249ejc.60.2023.12.06.03.48.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Dec 2023 03:48:44 -0800 (PST)
Message-ID: <4e78f214-43ee-4c3a-ba49-d3b54aff8737@linaro.org>
Date: Wed, 6 Dec 2023 12:48:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-8.2?] i386/sev: Avoid SEV-ES crash due to missing
 MSR_EFER_LMA bit
Content-Language: en-US
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, kvm@vger.kernel.org,
 Lara Lazier <laramglazier@gmail.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
References: <20231205222816.1152720-1-michael.roth@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231205222816.1152720-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

Hi Michael,

(Cc'ing Lara, Vitaly and Maxim)

On 5/12/23 23:28, Michael Roth wrote:
> Commit 7191f24c7fcf ("accel/kvm/kvm-all: Handle register access errors")
> added error checking for KVM_SET_SREGS/KVM_SET_SREGS2. In doing so, it
> exposed a long-running bug in current KVM support for SEV-ES where the
> kernel assumes that MSR_EFER_LMA will be set explicitly by the guest
> kernel, in which case EFER write traps would result in KVM eventually
> seeing MSR_EFER_LMA get set and recording it in such a way that it would
> be subsequently visible when accessing it via KVM_GET_SREGS/etc.
> 
> However, guests kernels currently rely on MSR_EFER_LMA getting set
> automatically when MSR_EFER_LME is set and paging is enabled via
> CR0_PG_MASK. As a result, the EFER write traps don't actually expose the
> MSR_EFER_LMA even though it is set internally, and when QEMU
> subsequently tries to pass this EFER value back to KVM via
> KVM_SET_SREGS* it will fail various sanity checks and return -EINVAL,
> which is now considered fatal due to the aforementioned QEMU commit.
> 
> This can be addressed by inferring the MSR_EFER_LMA bit being set when
> paging is enabled and MSR_EFER_LME is set, and synthesizing it to ensure
> the expected bits are all present in subsequent handling on the host
> side.
> 
> Ultimately, this handling will be implemented in the host kernel, but to
> avoid breaking QEMU's SEV-ES support when using older host kernels, the
> same handling can be done in QEMU just after fetching the register
> values via KVM_GET_SREGS*. Implement that here.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Cc: kvm@vger.kernel.org
> Fixes: 7191f24c7fcf ("accel/kvm/kvm-all: Handle register access errors")

This 'Fixes:' tag is misleading, since as you mentioned this commit
only exposes the issue.

Commit d499f196fe ("target/i386: Added consistency checks for EFER")
or around it seems more appropriate.

Is this feature easily testable on our CI, on a x86 runner with KVM
access?

> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
> v2:
>    - Add handling for KVM_GET_SREGS, not just KVM_GET_SREGS2
> 
>   target/i386/kvm/kvm.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 11b8177eff..8721c1bf8f 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -3610,6 +3610,7 @@ static int kvm_get_sregs(X86CPU *cpu)
>   {
>       CPUX86State *env = &cpu->env;
>       struct kvm_sregs sregs;
> +    target_ulong cr0_old;
>       int ret;
>   
>       ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_SREGS, &sregs);
> @@ -3637,12 +3638,18 @@ static int kvm_get_sregs(X86CPU *cpu)
>       env->gdt.limit = sregs.gdt.limit;
>       env->gdt.base = sregs.gdt.base;
>   
> +    cr0_old = env->cr[0];
>       env->cr[0] = sregs.cr0;
>       env->cr[2] = sregs.cr2;
>       env->cr[3] = sregs.cr3;
>       env->cr[4] = sregs.cr4;
>   
>       env->efer = sregs.efer;
> +    if (sev_es_enabled() && env->efer & MSR_EFER_LME) {
> +        if (!(cr0_old & CR0_PG_MASK) && env->cr[0] & CR0_PG_MASK) {
> +            env->efer |= MSR_EFER_LMA;
> +        }
> +    }
>   
>       /* changes to apic base and cr8/tpr are read back via kvm_arch_post_run */
>       x86_update_hflags(env);
> @@ -3654,6 +3661,7 @@ static int kvm_get_sregs2(X86CPU *cpu)
>   {
>       CPUX86State *env = &cpu->env;
>       struct kvm_sregs2 sregs;
> +    target_ulong cr0_old;
>       int i, ret;
>   
>       ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_SREGS2, &sregs);
> @@ -3676,12 +3684,18 @@ static int kvm_get_sregs2(X86CPU *cpu)
>       env->gdt.limit = sregs.gdt.limit;
>       env->gdt.base = sregs.gdt.base;
>   
> +    cr0_old = env->cr[0];
>       env->cr[0] = sregs.cr0;
>       env->cr[2] = sregs.cr2;
>       env->cr[3] = sregs.cr3;
>       env->cr[4] = sregs.cr4;
>   
>       env->efer = sregs.efer;
> +    if (sev_es_enabled() && env->efer & MSR_EFER_LME) {
> +        if (!(cr0_old & CR0_PG_MASK) && env->cr[0] & CR0_PG_MASK) {
> +            env->efer |= MSR_EFER_LMA;
> +        }
> +    }
>   
>       env->pdptrs_valid = sregs.flags & KVM_SREGS2_FLAGS_PDPTRS_VALID;
>   


