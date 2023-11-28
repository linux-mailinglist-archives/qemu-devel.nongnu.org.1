Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B95AF7FB216
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 07:48:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7rs8-0006mR-8i; Tue, 28 Nov 2023 01:47:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7rrz-0006mA-Nu
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 01:46:55 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7rry-0007tS-2O
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 01:46:55 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40b34563987so28874785e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 22:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701154012; x=1701758812; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h0PjY0WHoOlgCesy1ZAomc2Q7r4AO6iN2dgUweHV9zw=;
 b=Xg/s2U8tV64XmSJ5cfnEqCyLN56TRSefs9fsW8jT6tvlS7mIeasISrPsP7GTu+70qz
 fLnQ2Zp9VnndTTYsWNU9U6Tziz0A+39PChagGLddDvXAyryCnXIbG0Nk+GThhxgjW1/f
 fGKaF1jdToUoA3B9DW45V/LOp9+he3kinTnlEwVAhsKRgHqcn957yQL30+NFa8j1s7WT
 uOWgaZwmapvJfX9yn8DB/+9kT6P/UIlRN+HNBO7KYKoV1OG6c08fr6aFVNWFkJJtLXOu
 TqDhTdbz5ufyMpcrLF0OXZvk5UoibP7SKuJisr4YfcVGY3ysJXqbR8QiQKO/puSQ0+/P
 qz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701154012; x=1701758812;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h0PjY0WHoOlgCesy1ZAomc2Q7r4AO6iN2dgUweHV9zw=;
 b=wqYxgr5wiLwo/obFAWFUzsgWR6NhtELn86EEIIrOPlolsKndZecULZPonGGmKZXL2F
 5Ta4ysu0OQsX7jrjHHK4AL+pM7v/Kpyx5m/QdkKdAiRW0LlbFJ0QhqmeEK/1kRgSpFp0
 0+JUXaJY0mFLzBr3CJHjzu6scuDdld/ec7U3p/ElLJx5GvDiCRJK5acxjE1CC1zjUOXg
 2155Bo6GoTWSksHqwKnRLiGE9CitsfMc1SUzSvqF0tY7qDHw9TJ++bZyQx8GlVCFYAqD
 KoHssSjXbi2IgQ44pMLg7RdZquy+vRUis1M9I9f4uII5GNz/gxxlj++OM6qfN2l1khYE
 soqQ==
X-Gm-Message-State: AOJu0YySMaVTbySgWqEL/kNTt+7NQi77htNEohkqc1dJObAZ8Ef6Ldxz
 23kFZVbYABg1GXjK8rqd+MJiag==
X-Google-Smtp-Source: AGHT+IGuLVjmN8UvCrWJLck2yUrDdplonq/4r15+/Y46RZpo7v1qql8cKLQSQIv6tFsOmEt8uy1Yow==
X-Received: by 2002:a05:600c:4f86:b0:40b:305c:9c84 with SMTP id
 n6-20020a05600c4f8600b0040b305c9c84mr12036325wmq.12.1701154012110; 
 Mon, 27 Nov 2023 22:46:52 -0800 (PST)
Received: from [192.168.69.100] (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 j8-20020adfe508000000b00318147fd2d3sm14027125wrm.41.2023.11.27.22.46.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Nov 2023 22:46:51 -0800 (PST)
Message-ID: <f9b24c09-547d-4590-9b73-9c5918ee022c@linaro.org>
Date: Tue, 28 Nov 2023 07:46:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 08/16] target/arm/kvm: Have kvm_arm_pmu_init take
 a ARMCPU argument
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231123183518.64569-1-philmd@linaro.org>
 <20231123183518.64569-9-philmd@linaro.org>
 <802e9dcd-68d2-4c38-95e8-fe99d46b911f@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <802e9dcd-68d2-4c38-95e8-fe99d46b911f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 27/11/23 05:20, Gavin Shan wrote:
> Hi Phil,
> 
> On 11/24/23 05:35, Philippe Mathieu-Daudé wrote:
>> Unify the "kvm_arm.h" API: All functions related to ARM vCPUs
>> take a ARMCPU* argument. Use the CPU() QOM cast macro When
>> calling the generic vCPU API from "sysemu/kvm.h".
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/arm/kvm_arm.h | 4 ++--
>>   hw/arm/virt.c        | 2 +-
>>   target/arm/kvm.c     | 6 +++---
>>   3 files changed, 6 insertions(+), 6 deletions(-)
>>
> 
> One nit below, but I guess it doesn't matter.
> 
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> 
>> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
>> index 0e12a008ab..fde1c45609 100644
>> --- a/target/arm/kvm_arm.h
>> +++ b/target/arm/kvm_arm.h
>> @@ -200,8 +200,8 @@ int kvm_arm_get_max_vm_ipa_size(MachineState *ms, 
>> bool *fixed_ipa);
>>   int kvm_arm_vgic_probe(void);
>> +void kvm_arm_pmu_init(ARMCPU *cpu);
>>   void kvm_arm_pmu_set_irq(CPUState *cs, int irq);
>> -void kvm_arm_pmu_init(CPUState *cs);
> 
> Why the order of the declaration is changed? I guess the reason would be
> kvm_arm_pmu_init() is called prior to kvm_arm_pmu_set_irq().

Yes, exactly. Not worth mentioning IMHO.

Thanks!

Phil.


