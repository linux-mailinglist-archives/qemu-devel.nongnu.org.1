Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1877358F6
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 15:54:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFKw-0005SH-F3; Mon, 19 Jun 2023 09:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBFKt-0005Rw-UQ
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 09:54:27 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBFKs-0008Rm-8Z
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 09:54:27 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-982a0232bdcso574652866b.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 06:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687182865; x=1689774865;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9lLwy27m6/bOV10TzIoobGu46pwKRFpktlflZ0/jQXA=;
 b=E3AAi8FLPMOk0V4vUDro7QpQb/nFWFIwYfdgb0Pc42msOA/ieXubd39Oo3mvF0agb/
 JLfZoDYjU04zNN4iAVYMb5RtDeDq9rdK2za5TOYX+yQldU2yonuzLdgfiI+0xuUkICV7
 ArDx/RV5LUj7taY0nRfRrxYJ3xUPOphR5iHEvCXRnFn5JdXmlMJvzbF6sEk/s6Ibvimo
 nA08g1fPqFydHqbqGZ5KbEXGJP/mv+yXmBEDy0C+8zIO6Ealzn8ry4GgkECSnq0JS/iF
 rU06eTyefbTmv1mvmu0qoP1U3ehazHy5svtVyHg/r5wCRbRCnz6ztRS4NEXFdlqH5U2H
 rYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687182865; x=1689774865;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9lLwy27m6/bOV10TzIoobGu46pwKRFpktlflZ0/jQXA=;
 b=I0FbAkX8eiXITnKwstBQsy+6rEliuyIQDq6nlsZA4r6tlt7wpSQpoo4z9eESjplyve
 BGTK3ipDcZmPliMqEqgwnNX0Rinn2wEVbIPmnLTf81srlUzIKqKSqr/GkJ9ADXoJmOvG
 w2CMhfmjwTeWnPs6VP3zLr0C7R4WRiCNI1rgVmKYlMnlMiS53yHK4j/hpwZiyktLIHLx
 +A7lEwtqkHO4Tj+tpDJ8TbYeuBgf9mAXCQr7lJg8DXGXDJ8nfCZ8fK6hn5PzJx8Wfp/2
 qfkaQh01xra4pDvNqttyUseKY1fjT1Nv3UYU8BfPNN/p/nnZM7Gw1XOppfThTU9PV13M
 mtpA==
X-Gm-Message-State: AC+VfDxNgRLv4qlg15Pi8s3cmUsnKt30Crp2CHhv8SAxDh6MWAcPL7Ce
 1T97RwoCnXKwKEuvI7IX6vMb/g==
X-Google-Smtp-Source: ACHHUZ5lNeohsVJHOt0VXL7EDt/RC5bGbhRIxElSfBb7wuGGmC1WQr+hZFHm72zUrVfkzYjcLTRPPg==
X-Received: by 2002:a17:907:78e:b0:982:7545:efb6 with SMTP id
 xd14-20020a170907078e00b009827545efb6mr9812230ejb.66.1687182864472; 
 Mon, 19 Jun 2023 06:54:24 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 x14-20020a170906804e00b009884f015a44sm2721166ejw.49.2023.06.19.06.54.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 06:54:24 -0700 (PDT)
Message-ID: <e0825fab-e4cb-7551-949b-6c1dfc3d0a44@linaro.org>
Date: Mon, 19 Jun 2023 15:54:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 12/12] target/arm: Allow users to set the number of VFP
 registers
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 "open list:ARM cores" <qemu-arm@nongnu.org>, qemu-devel@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230607043943.1837186-1-clg@kaod.org>
 <20230607043943.1837186-13-clg@kaod.org>
 <955C217E-FE0F-41E2-8E97-9AFD8C4A0DBE@ynddal.dk>
 <CAFEAcA-siVrV0NWOZYR10UanT-Rrh37CqJ7Xm83Y90eGV91jSw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-siVrV0NWOZYR10UanT-Rrh37CqJ7Xm83Y90eGV91jSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/19/23 15:41, Peter Maydell wrote:
> On Mon, 19 Jun 2023 at 13:47, Mads Ynddal <mads@ynddal.dk> wrote:
>>
>> Sorry, if this has already been acknowledged, but I couldn't find it on the
>> mailinglist.
>>
>> This commit seems to break compatibility with macOS accelerator hvf when
>> virtualizing ARM CPUs.
>>
>> It breaks the VM on boot-up with the message "ARM CPUs must have both VFP-D32
>> and Neon or neither". I haven't looked into what VFP-D32 and Neon are, but the
>> same VM worked on earlier versions of QEMU.
>>
>> It can be reproduced with the following:
>>
>> qemu-system-aarch64 \
>>    -nodefaults \
>>    -display "none" \
>>    -machine "virt" \
>>    -accel "hvf" \
>>    -cpu "host" \
>>    -serial "mon:stdio"
>> qemu-system-aarch64: ARM CPUs must have both VFP-D32 and Neon or neither
>>
>>
>> If you fix/work on this issue in a separate thread/patch, you can add
>> reported-by, so I'll automatically follow and help test it:
>>
>> Reported-by: Mads Ynddal <mads@ynddal.dk>
>>
> 
> 
>>> @@ -1406,6 +1409,22 @@ void arm_cpu_post_init(Object *obj)
>>>          }
>>>      }
>>>
>>> +    if (cpu->has_vfp && cpu_isar_feature(aa32_simd_r32, cpu)) {
>>> +        cpu->has_vfp_d32 = true;
>>> +        if (!kvm_enabled()) {
> 
> Probably this should be "if (!kvm_enabled() && !hvf_enabled())".
> Is that sufficient to fix the regression ? (I have a feeling it
> isn't, but we might as well test...)

Yes, insufficient.  But I'm also changing these to tcg || qtest.

> 
>>> +            /*
>>> +             * The permitted values of the SIMDReg bits [3:0] on
>>> +             * Armv8-A are either 0b0000 and 0b0010. On such CPUs,
>>> +             * make sure that has_vfp_d32 can not be set to false.
>>> +             */
>>> +            if (!(arm_feature(&cpu->env, ARM_FEATURE_V8) &&
>>> +                  !arm_feature(&cpu->env, ARM_FEATURE_M))) {
>>> +                qdev_property_add_static(DEVICE(obj),
>>> +                                         &arm_cpu_has_vfp_d32_property);
>>> +            }
>>> +        }
>>> +    }
>>> +
>>>      if (arm_feature(&cpu->env, ARM_FEATURE_NEON)) {
>>>          cpu->has_neon = true;
>>>          if (!kvm_enabled()) {
>>> @@ -1672,6 +1691,19 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>>>          return;
>>>      }
>>>
>>> +    if (cpu->has_vfp_d32 != cpu->has_neon) {
>>> +        error_setg(errp, "ARM CPUs must have both VFP-D32 and Neon or neither");
>>> +        return;
>>> +    }
> 
> The other thing I see looking again at this code is that it
> doesn't account for CPUs which don't have AArch32 support
> at all. The MVFR0 register which the aa32_simd_r32 feature
> test is looking at is an AArch32 register, and the test
> will not return a sensible answer on an AArch64-only CPU.

This is the problem.  The code needs restructuring (which I am about to test).

> On the other side of this, target/arm/hvf/hvf.c always
> sets ARM_FEATURE_NEON, which I think is probably not
> correct given that Neon is also an AArch32-only thing.

At one time NEON also meant AdvSIMD, though we have now changed aa64 to the isar test.  We 
could probably get rid of NEON now too, with just a little more cleanup.


r~


