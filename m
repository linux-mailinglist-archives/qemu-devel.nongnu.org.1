Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B297262A9
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:21:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6u0j-0002pF-14; Wed, 07 Jun 2023 10:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5JAy=B3=kaod.org=clg@ozlabs.org>)
 id 1q6u0g-0002oD-Jd; Wed, 07 Jun 2023 10:19:38 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5JAy=B3=kaod.org=clg@ozlabs.org>)
 id 1q6u0e-0003PR-IY; Wed, 07 Jun 2023 10:19:38 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QbqGt1mRRz4x4H;
 Thu,  8 Jun 2023 00:19:34 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QbqGq5XTsz4x41;
 Thu,  8 Jun 2023 00:19:31 +1000 (AEST)
Message-ID: <4b3a30cf-9f28-14cd-5cff-a25d2b510ca8@kaod.org>
Date: Wed, 7 Jun 2023 16:19:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 12/12] target/arm: Allow users to set the number of VFP
 registers
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230607043943.1837186-1-clg@kaod.org>
 <20230607043943.1837186-13-clg@kaod.org>
 <CACPK8Xce052zza6XvQYijhPEL7NDqS3cKW0x3r0DGiJENYXDGw@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CACPK8Xce052zza6XvQYijhPEL7NDqS3cKW0x3r0DGiJENYXDGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=5JAy=B3=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.091, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/7/23 13:06, Joel Stanley wrote:
> On Wed, 7 Jun 2023 at 04:40, Cédric Le Goater <clg@kaod.org> wrote:
>>
>> Cortex A7 CPUs with an FPU implementing VFPv4 without NEON support
>> have 16 64-bit FPU registers and not 32 registers. Let users set the
>> number of VFP registers with a CPU property.
>>
>> The primary use case of this property is for the Cortex A7 of the
>> Aspeed AST2600 SoC.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> 
> You saw a crash with a buildroot image without this change, as I recall?

yes, when compiled with VFPv4d32 support, user space crashes on real HW.

Thanks,

C.

> 
> The logic is a bit hard to follow but it is good to see a fix.
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
>> ---
>>   target/arm/cpu.h        |  2 ++
>>   hw/arm/aspeed_ast2600.c |  2 ++
>>   target/arm/cpu.c        | 32 ++++++++++++++++++++++++++++++++
>>   3 files changed, 36 insertions(+)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index d469a2637b32..79f1a96ddf39 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -916,6 +916,8 @@ struct ArchCPU {
>>       bool has_pmu;
>>       /* CPU has VFP */
>>       bool has_vfp;
>> +    /* CPU has 32 VFP registers */
>> +    bool has_vfp_d32;
>>       /* CPU has Neon */
>>       bool has_neon;
>>       /* CPU has M-profile DSP extension */
>> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
>> index 1bf12461481c..a8b3a8065a11 100644
>> --- a/hw/arm/aspeed_ast2600.c
>> +++ b/hw/arm/aspeed_ast2600.c
>> @@ -316,6 +316,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>>                                   &error_abort);
>>           object_property_set_bool(OBJECT(&s->cpu[i]), "neon", false,
>>                                   &error_abort);
>> +        object_property_set_bool(OBJECT(&s->cpu[i]), "vfp-d32", false,
>> +                                &error_abort);
>>           object_property_set_link(OBJECT(&s->cpu[i]), "memory",
>>                                    OBJECT(s->memory), &error_abort);
>>
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index 5182ed0c9113..74fe6ae78192 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -1275,6 +1275,9 @@ static Property arm_cpu_cfgend_property =
>>   static Property arm_cpu_has_vfp_property =
>>               DEFINE_PROP_BOOL("vfp", ARMCPU, has_vfp, true);
>>
>> +static Property arm_cpu_has_vfp_d32_property =
>> +            DEFINE_PROP_BOOL("vfp-d32", ARMCPU, has_vfp_d32, true);
>> +
>>   static Property arm_cpu_has_neon_property =
>>               DEFINE_PROP_BOOL("neon", ARMCPU, has_neon, true);
>>
>> @@ -1406,6 +1409,22 @@ void arm_cpu_post_init(Object *obj)
>>           }
>>       }
>>
>> +    if (cpu->has_vfp && cpu_isar_feature(aa32_simd_r32, cpu)) {
>> +        cpu->has_vfp_d32 = true;
>> +        if (!kvm_enabled()) {
>> +            /*
>> +             * The permitted values of the SIMDReg bits [3:0] on
>> +             * Armv8-A are either 0b0000 and 0b0010. On such CPUs,
>> +             * make sure that has_vfp_d32 can not be set to false.
>> +             */
>> +            if (!(arm_feature(&cpu->env, ARM_FEATURE_V8) &&
>> +                  !arm_feature(&cpu->env, ARM_FEATURE_M))) {
>> +                qdev_property_add_static(DEVICE(obj),
>> +                                         &arm_cpu_has_vfp_d32_property);
>> +            }
>> +        }
>> +    }
>> +
>>       if (arm_feature(&cpu->env, ARM_FEATURE_NEON)) {
>>           cpu->has_neon = true;
>>           if (!kvm_enabled()) {
>> @@ -1672,6 +1691,19 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>>           return;
>>       }
>>
>> +    if (cpu->has_vfp_d32 != cpu->has_neon) {
>> +        error_setg(errp, "ARM CPUs must have both VFP-D32 and Neon or neither");
>> +        return;
>> +    }
>> +
>> +   if (!cpu->has_vfp_d32) {
>> +        uint32_t u;
>> +
>> +        u = cpu->isar.mvfr0;
>> +        u = FIELD_DP32(u, MVFR0, SIMDREG, 1); /* 16 registers */
>> +        cpu->isar.mvfr0 = u;
>> +    }
>> +
>>       if (!cpu->has_vfp) {
>>           uint64_t t;
>>           uint32_t u;
>> --
>> 2.40.1
>>


