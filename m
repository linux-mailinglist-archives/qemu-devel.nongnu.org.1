Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE737F7323
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 12:55:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6UlH-00030t-OK; Fri, 24 Nov 2023 06:54:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6UlF-00030b-E0
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 06:54:17 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6UlD-0004Lk-Pf
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 06:54:17 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32f8441dfb5so1220752f8f.0
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 03:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700826854; x=1701431654; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6zd0EDpWvWkHd4A3NuoSsBYTtYaDeUl7VdJhsvIOjQs=;
 b=ysI/Huc3FDaBr6zE3wNsjRMxI0HLpgWmm7++2l8CDILKPLoYErGEM4xNyngDw+Wos4
 +7DG9oKAx7Cv10LPdUIwXnnpzdj/RFkMpgCG+yn7at8PZKfLgmgm0qdrqaPeaFLXmXMa
 IAfpEtBN7OagLrFtrnkP0JyIMgUBMNhUxrs+U8fdVFGgkG+Kp1v0X4E+TgiyCbJyIBmV
 mgx9MK+xuzVdcJM16x8pYanmCqqntQ4iZxb1SXtd781Fw1EpOu/v0H2AmPeSpo7XWZDf
 tjIX3MV3Xhv3jsSCv0Ig8jAohmx8ZvVy6IEAgAz6nZK17p8fixu5G6c/lzxtBs+MewLs
 Vg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700826854; x=1701431654;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6zd0EDpWvWkHd4A3NuoSsBYTtYaDeUl7VdJhsvIOjQs=;
 b=GQFdncIPFN8ZEFPgnZ8qMpVozLUCkgrTIKwlv40fDHKPUqkiM0BgmbrDabqE3E2CQt
 6+9X8stVS2z0nBsvHBnYkKJxMNK6m+PjMx8Dpj8RlhIxcBYxaVFj1qtC6xLKbEf76ZKX
 v42y0aB1D01GGUKGgvNtEf5eAYhHj8X1u0yVPc7SEDgtXcCjUl+Wul6t+EZxpyCkL6et
 x+Lz/0AcSYC3RgVyl9WkFLgRKvaXSdjYKhEY/697RhH/j0j8wh37aYwpfs18RvSylW7E
 nTYnhQlsRQ6e3OrAQwQ4Ezf6CcoS4kEmYV5aIfImQlh89l6bueHI7Ocp/5K9q8oe1LsA
 IVsg==
X-Gm-Message-State: AOJu0YwV+BCbrrrMnHO6NSryEIhTEl7r4bneygRsScXf24Kmcb+EbVeb
 Bsi91MXjqJSVCokyvTdSiIlffg==
X-Google-Smtp-Source: AGHT+IHpev0RrJokQRNrkSLnmRD3aUQFTvr/wSxAcpmWvipZORPUFHweY/JSIy7WcaCb1M1WwNJXag==
X-Received: by 2002:a05:6000:b4c:b0:332:caa9:72b2 with SMTP id
 dk12-20020a0560000b4c00b00332caa972b2mr2089355wrb.3.1700826854265; 
 Fri, 24 Nov 2023 03:54:14 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.17])
 by smtp.gmail.com with ESMTPSA id
 w3-20020a5d5443000000b003140f47224csm4130175wrv.15.2023.11.24.03.54.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 03:54:13 -0800 (PST)
Message-ID: <4889143b-e15e-4834-af2f-ddea2dd63cb6@linaro.org>
Date: Fri, 24 Nov 2023 12:54:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/21] target/arm/kvm: Init cap_has_inject_serror_esr in
 kvm_arch_init
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-19-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231123044219.896776-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 23/11/23 05:42, Richard Henderson wrote:
> There is no need to do this in kvm_arch_init_vcpu per vcpu.
> Inline kvm_arm_init_serror_injection rather than keep separate.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm_arm.h |  8 --------
>   target/arm/kvm.c     | 13 ++++---------
>   2 files changed, 4 insertions(+), 17 deletions(-)


> @@ -562,6 +556,10 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>   
>       cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
>   
> +    /* Check whether user space can specify guest syndrome value */
> +    cap_has_inject_serror_esr =
> +        kvm_check_extension(s, KVM_CAP_ARM_INJECT_SERROR_ESR);
> +
>       if (ms->smp.cpus > 256 &&
>           !kvm_check_extension(s, KVM_CAP_ARM_IRQ_LINE_LAYOUT_2)) {
>           error_report("Using more than 256 vcpus requires a host kernel "
> @@ -1948,9 +1946,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
>       }
>       cpu->mp_affinity = mpidr & ARM64_AFFINITY_MASK;
>   
> -    /* Check whether user space can specify guest syndrome value */
> -    kvm_arm_init_serror_injection(cs);
> -
>       return kvm_arm_init_cpreg_list(cpu);
>   }


Just checking, in a heterogeneous setup we still want to keep
these 2 calls per-vCPU, right?

     if (kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PSCI_0_2)) {
         cpu->psci_version = QEMU_PSCI_VERSION_0_2;
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_PSCI_0_2;
     }

     if (!kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PMU_V3)) {
         cpu->has_pmu = false;
     }


