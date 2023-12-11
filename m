Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2659B80DA39
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 20:00:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rClUd-0004KM-4g; Mon, 11 Dec 2023 13:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rClUP-0004JM-7m
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 13:58:49 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rClUI-0003Ls-Ke
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 13:58:47 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-289d988a947so3426793a91.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 10:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702321121; x=1702925921; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VfcAmP3/dpn9dPyKJHCa9ZOX7l5aia6nLSNaLrDGzBA=;
 b=MTqKYfsunEEH4HH57MVCp8+0gl6YXmZxqgbBZKEdxrDwmoNMBfjv3ozULyCC4ohuka
 WCvl5wdBqdErSiAKrlaZP5OeDe7c2s9yAnRQx7j6qpUp+6uXOxZwQZF2Mjd+AkRG9pG5
 11WncmigzXzlO/8ODKKJcYsyEddNmw3nv3aL2Ca8X2NDNaryNkt9Wx6Y6dG01tETG3F3
 war3vSVa3MDzNSaE0YhNIG1YbF8s9mwx5z+rsOLTKJ7+RW/iBLpuqalLbm2+CXQatczr
 05joWhXZbcWCD0iZ+qbcnXg7ktY0gZ1RIG6Y+HzOFaXMyOp2dzZXij9VHESb3MQlIjXn
 DKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702321121; x=1702925921;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VfcAmP3/dpn9dPyKJHCa9ZOX7l5aia6nLSNaLrDGzBA=;
 b=Nf6d3N2eSzmKe8MNBGBLPA3dZlcz6hkNo6+oqhClkgsZwdabBBpglFYncOmFfKbfy9
 r3EhRmyhwYf41OooSqkV/mHk3d45Gi0TmWLui/gd0FCkAcoq9/YkJf/NXAzV83+gtUpb
 lVJVeeyyoe7kOy0sdvcfTnNag9Cq7P7h8RJJEgyI5cFb2EuFzEVRezzvkarPXax6tjAM
 7+AZfxLzi1VulOMrZnFs93DNhgfR7K96Cl5hvKo4w0N62SemDf3dDaH0TNImFOMaBSJ6
 3vGL1Vx2WE20EHUwOZtW8Aec14aGhESPqS8VGKsnlLD1aZDY0YHEFVsOfEZ5SmRscHbr
 kVTw==
X-Gm-Message-State: AOJu0YxX7WxLzpnE50fPYARU7IPDG4d352WOCnq2Chaab7SGFZvWoa89
 LFQHKeQuFUo5ULSncUAN/gU7gw==
X-Google-Smtp-Source: AGHT+IHdiWg/VjXzzr6OyO95MJvOhoK391e9hy08Rh19BFuKxGYtMgxuAg/aTc0nPV9lVUNJmWUM7Q==
X-Received: by 2002:a17:90a:8a03:b0:28a:4f78:e316 with SMTP id
 w3-20020a17090a8a0300b0028a4f78e316mr1991637pjn.53.1702321120858; 
 Mon, 11 Dec 2023 10:58:40 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 pw10-20020a17090b278a00b002867594de40sm8826234pjb.14.2023.12.11.10.58.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 10:58:40 -0800 (PST)
Message-ID: <4172e204-b09a-4673-ae8b-4662c3db5fae@linaro.org>
Date: Mon, 11 Dec 2023 10:58:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/21] target/arm/kvm: Init cap_has_inject_serror_esr in
 kvm_arch_init
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-19-richard.henderson@linaro.org>
 <4889143b-e15e-4834-af2f-ddea2dd63cb6@linaro.org>
 <3c2d3736-4cae-4034-973b-568e80cbf0c3@linaro.org>
 <8cd2093f-dc74-469b-8bac-d290206af116@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <8cd2093f-dc74-469b-8bac-d290206af116@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 12/11/23 10:43, Philippe Mathieu-Daudé wrote:
> On 11/12/23 18:09, Richard Henderson wrote:
>> On 11/24/23 03:54, Philippe Mathieu-Daudé wrote:
>>> On 23/11/23 05:42, Richard Henderson wrote:
>>>> There is no need to do this in kvm_arch_init_vcpu per vcpu.
>>>> Inline kvm_arm_init_serror_injection rather than keep separate.
>>>>
>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>> ---
>>>>   target/arm/kvm_arm.h |  8 --------
>>>>   target/arm/kvm.c     | 13 ++++---------
>>>>   2 files changed, 4 insertions(+), 17 deletions(-)
>>>
>>>
>>>> @@ -562,6 +556,10 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>>>       cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
>>>> +    /* Check whether user space can specify guest syndrome value */
>>>> +    cap_has_inject_serror_esr =
>>>> +        kvm_check_extension(s, KVM_CAP_ARM_INJECT_SERROR_ESR);
>>>> +
>>>>       if (ms->smp.cpus > 256 &&
>>>>           !kvm_check_extension(s, KVM_CAP_ARM_IRQ_LINE_LAYOUT_2)) {
>>>>           error_report("Using more than 256 vcpus requires a host kernel "
>>>> @@ -1948,9 +1946,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>>>       }
>>>>       cpu->mp_affinity = mpidr & ARM64_AFFINITY_MASK;
>>>> -    /* Check whether user space can specify guest syndrome value */
>>>> -    kvm_arm_init_serror_injection(cs);
>>>> -
>>>>       return kvm_arm_init_cpreg_list(cpu);
>>>>   }
>>>
>>>
>>> Just checking, in a heterogeneous setup we still want to keep
>>> these 2 calls per-vCPU, right?
>>
>> There is no hetrogeneous kvm -- every vcpu must match the host cpu.
> 
> So big.LITTLE will never be a KVM thing?

Not as far as I'm aware.  There are even issues *running* on big.LITTLE hosts -- you must 
use taskset to limit qemu to one cpu type, either big or little.


r~

