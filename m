Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2CB80D34B
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 18:10:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCjmf-0001gU-83; Mon, 11 Dec 2023 12:09:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCjme-0001g4-2r
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:09:32 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCjma-0000UI-53
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:09:29 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6ceb2501f1bso3810266b3a.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 09:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702314566; x=1702919366; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sc1qgl70OVlwSYNp8DPvzNbv+pahk/dG2J+Svd8VVm4=;
 b=PmWJ0X4YEpZU37N4vYCBLJmqQFQKBwIU5bg36j/EB2VuPsA82f6RoES3JxLbvm6vYw
 o3RfI41YaCwkpQJh0EdIbipA5mKdjPQqbXAWQiG6L593aD3zHWYvfCD9qHroesx74hhU
 V8ZYO/HJ0+4Mo0To31pGCEMs4AuH70O2cKljUMsGDXXv7T7njiHlvOYd4ijKuZkVWLhe
 s0H4AUTjk6xEA74L0FJv9pWE/31dAwnix5P1PV4h2+kB1LMRePTaWdYIqW4mP6Jakukb
 5t19icptZ/6oZRQbVijujY4Z4SgbChL4/+T0/8S+7lO18AzsJYQR5pF01jrrAiCHiVYV
 6Fww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702314566; x=1702919366;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sc1qgl70OVlwSYNp8DPvzNbv+pahk/dG2J+Svd8VVm4=;
 b=pZJ5j+441Am6F9jUN1m7znaTBLPBNA0PKY6q7CQTXzdQr3uIdhggjQzkuPICHlUlYE
 AMEsk3G5UlKQ5B+2Oo4psMpk+cpbTnbq8Hd/d1n6EwZRzZ/Yv28Iimeza47Bjs7wEsdF
 CnW57m/ibGZO51+fZgWhAaPyCHdQRAFkLKeh7E4hT1WkMGNcO1syc/Yush5v7UNxufle
 yMIzR1a2PyGkn+yfxQsENMAr+2lce5z1HpbIjWR+/I+7BkCJi+tUePsrvIoZnbClhd/G
 uOujauRA38qlA2oYqhwwfKnEh7oPxwaFcvBFFw71b/vX/4B/+mAODUFvg7L5zP2qHEGB
 HddA==
X-Gm-Message-State: AOJu0YyKr18XT+jxd3T0AkojtpyVchlBCOkLaK5NV0klGJztx63GAwAh
 azBiWz/gz3NqezdtiiBzGDmK8A==
X-Google-Smtp-Source: AGHT+IE4M+DE3hBCkye9F8pHS772vfgtu1FvV1fNroikKiI73F3D1bZd/yUxeYm/Y1Y5O4VNVeF6KQ==
X-Received: by 2002:a05:6a00:194d:b0:6ce:4927:2811 with SMTP id
 s13-20020a056a00194d00b006ce49272811mr5640987pfk.22.1702314566032; 
 Mon, 11 Dec 2023 09:09:26 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a654102000000b005c65ed23b65sm5546397pgp.94.2023.12.11.09.09.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 09:09:25 -0800 (PST)
Message-ID: <3c2d3736-4cae-4034-973b-568e80cbf0c3@linaro.org>
Date: Mon, 11 Dec 2023 09:09:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/21] target/arm/kvm: Init cap_has_inject_serror_esr in
 kvm_arch_init
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-19-richard.henderson@linaro.org>
 <4889143b-e15e-4834-af2f-ddea2dd63cb6@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <4889143b-e15e-4834-af2f-ddea2dd63cb6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 11/24/23 03:54, Philippe Mathieu-Daudé wrote:
> On 23/11/23 05:42, Richard Henderson wrote:
>> There is no need to do this in kvm_arch_init_vcpu per vcpu.
>> Inline kvm_arm_init_serror_injection rather than keep separate.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/kvm_arm.h |  8 --------
>>   target/arm/kvm.c     | 13 ++++---------
>>   2 files changed, 4 insertions(+), 17 deletions(-)
> 
> 
>> @@ -562,6 +556,10 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>       cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
>> +    /* Check whether user space can specify guest syndrome value */
>> +    cap_has_inject_serror_esr =
>> +        kvm_check_extension(s, KVM_CAP_ARM_INJECT_SERROR_ESR);
>> +
>>       if (ms->smp.cpus > 256 &&
>>           !kvm_check_extension(s, KVM_CAP_ARM_IRQ_LINE_LAYOUT_2)) {
>>           error_report("Using more than 256 vcpus requires a host kernel "
>> @@ -1948,9 +1946,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>       }
>>       cpu->mp_affinity = mpidr & ARM64_AFFINITY_MASK;
>> -    /* Check whether user space can specify guest syndrome value */
>> -    kvm_arm_init_serror_injection(cs);
>> -
>>       return kvm_arm_init_cpreg_list(cpu);
>>   }
> 
> 
> Just checking, in a heterogeneous setup we still want to keep
> these 2 calls per-vCPU, right?

There is no hetrogeneous kvm -- every vcpu must match the host cpu.


r~


>      if (kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PSCI_0_2)) {
>          cpu->psci_version = QEMU_PSCI_VERSION_0_2;
>          cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_PSCI_0_2;
>      }
> 
>      if (!kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PMU_V3)) {
>          cpu->has_pmu = false;
>      }




