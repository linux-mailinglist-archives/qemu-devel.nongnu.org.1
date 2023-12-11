Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7979980D84D
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 19:44:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rClFb-0003ve-M0; Mon, 11 Dec 2023 13:43:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rClFO-0003tC-Dt
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 13:43:18 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rClFK-00010o-7C
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 13:43:18 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-336221efdceso995324f8f.3
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 10:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702320191; x=1702924991; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i9+ixsVKbFewyO8T5y7IJG5l5rCev7TzkGLfE7lxh4Q=;
 b=vmhGcxdGshCpVU4fBGRtj73lKmXT0PAJy4Q7OXWXXTjtJ3tfwmStcyC57Gzg1kQBkj
 ZiaTiu1BFFX7JHKqagnL59bgBzJqK1yNOLX9esj+nVbJfp3pzGzMogMLp+c4dIwi3PtH
 1L4DLWqWIPCv/jwVGknLT10fQW2VsZcbc2rhwNCWtAA5d57mdR1eM3gygCVjeRaPn4EC
 pXS7GLiqn0x7UtzrSn7Oar8105U5BTKy42g6aE4VPJtTEfmFfxb6kCtQ56ZoMb6lwhPF
 YseadvUlufp8l86FIwhmEszuJq4JYCxPXN+DD62qCsCPcRGR33ldRtqXd7AKywVxBgb7
 5c/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702320191; x=1702924991;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i9+ixsVKbFewyO8T5y7IJG5l5rCev7TzkGLfE7lxh4Q=;
 b=Y/NyfesBsYTGzGw8GqJsgrsHs3h2sS/X4fbSB2JfcilsBhq+CDxdTCCS4tvvhR++/G
 T46Y0cC5LiH/E3H3AwqLcfLA+0AzNRAhZ7q3r9AluorSYyfUCxLqG32BEWPG+sRfTR+j
 DelOtqsJ8ssgD8XUNUV829zOaz6dY9Y25sV1P8jHjCyugfswf+LCKiaAyq/irW82XW1n
 lf7h7C/v60d9ynRnZYcQjbHc4bfhXsBCqr4WlQdf/SWFrlhgSrWWzDFkT6hgA5z/+Jhz
 W3yJFc5FvcXjlTm9q7jDqhm+sTbF7fd7pyiVrrbzbbjFrUqJFYZsrBLXenCHI8br0PuI
 OH8A==
X-Gm-Message-State: AOJu0YwrvqsvOn+zqImksRuM3TguVA0N8eehxhf/L2NDNmQ2Jjt1xOTQ
 /2IkL0Xp+ztWKKMi3oaiTrX6JA==
X-Google-Smtp-Source: AGHT+IEx2ycKjoTxC8JNM1V75KqpTx3R9MzItukpSGhaZk1GTqaJx4ZlZcRGHwl/eAotE3USm3etew==
X-Received: by 2002:a5d:6189:0:b0:333:5461:d8c8 with SMTP id
 j9-20020a5d6189000000b003335461d8c8mr1140804wru.266.1702320190993; 
 Mon, 11 Dec 2023 10:43:10 -0800 (PST)
Received: from [192.168.69.100] (cor91-h02-176-184-30-150.dsl.sta.abo.bbox.fr.
 [176.184.30.150]) by smtp.gmail.com with ESMTPSA id
 f8-20020adff448000000b0033344666878sm9151217wrp.91.2023.12.11.10.43.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 10:43:10 -0800 (PST)
Message-ID: <8cd2093f-dc74-469b-8bac-d290206af116@linaro.org>
Date: Mon, 11 Dec 2023 19:43:08 +0100
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
 <4889143b-e15e-4834-af2f-ddea2dd63cb6@linaro.org>
 <3c2d3736-4cae-4034-973b-568e80cbf0c3@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3c2d3736-4cae-4034-973b-568e80cbf0c3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 11/12/23 18:09, Richard Henderson wrote:
> On 11/24/23 03:54, Philippe Mathieu-Daudé wrote:
>> On 23/11/23 05:42, Richard Henderson wrote:
>>> There is no need to do this in kvm_arch_init_vcpu per vcpu.
>>> Inline kvm_arm_init_serror_injection rather than keep separate.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   target/arm/kvm_arm.h |  8 --------
>>>   target/arm/kvm.c     | 13 ++++---------
>>>   2 files changed, 4 insertions(+), 17 deletions(-)
>>
>>
>>> @@ -562,6 +556,10 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>>       cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
>>> +    /* Check whether user space can specify guest syndrome value */
>>> +    cap_has_inject_serror_esr =
>>> +        kvm_check_extension(s, KVM_CAP_ARM_INJECT_SERROR_ESR);
>>> +
>>>       if (ms->smp.cpus > 256 &&
>>>           !kvm_check_extension(s, KVM_CAP_ARM_IRQ_LINE_LAYOUT_2)) {
>>>           error_report("Using more than 256 vcpus requires a host 
>>> kernel "
>>> @@ -1948,9 +1946,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>>       }
>>>       cpu->mp_affinity = mpidr & ARM64_AFFINITY_MASK;
>>> -    /* Check whether user space can specify guest syndrome value */
>>> -    kvm_arm_init_serror_injection(cs);
>>> -
>>>       return kvm_arm_init_cpreg_list(cpu);
>>>   }
>>
>>
>> Just checking, in a heterogeneous setup we still want to keep
>> these 2 calls per-vCPU, right?
> 
> There is no hetrogeneous kvm -- every vcpu must match the host cpu.

So big.LITTLE will never be a KVM thing?

