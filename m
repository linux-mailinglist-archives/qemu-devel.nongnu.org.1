Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0288D73645A
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 09:20:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBVel-0005On-B8; Tue, 20 Jun 2023 03:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBVeg-0005LZ-FT
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 03:19:59 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBVec-0006OW-Og
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 03:19:57 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9875c2d949eso527591266b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 00:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687245588; x=1689837588;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yhtF8z0ppmNV1niZXvzfL2WVmvMTDQ7j4oO0+pxYj2o=;
 b=G3D6/8sCdpH5X6/65wwCvqF8KIdmcA8t+t7V0YCw4Ei/tCNIzWtVBWid11gEbUaV4e
 xkiuZQdzx9GTxTl6qKyq4qP8DIZek3zEmV8d0ax5LrrfyvoPta3MVf0BYm/G00XSLXl+
 NXLNQTBrSwSivKk+jo2vI9ciYhDBzhvBQYoaNhDd89qlzJjpRga5OqXVyKkrcIUJwt0Q
 2KVNNGBPARfkdDaCE5vNMU/KicUiuWs4rnGgdurTUM07uJf/cLcGJO7iU6Gy6Z2INhQA
 qofF4BaaERItmyvhkE9yfE+Rv0EVVd2rCmHogOr7EIeBt8W0WKUU/DLQudAogODK4Ozq
 6qZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687245588; x=1689837588;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yhtF8z0ppmNV1niZXvzfL2WVmvMTDQ7j4oO0+pxYj2o=;
 b=B1pUVg0/PLS0k4DxH5nU7Wv3snAGlxBiEbz9kLG5RmNfK6taNas5ZoK+R0wzJP84ek
 erZ4mh+GSan80NQY+DxuZeWBFUqXdAc53DPRK/wfzsh8oZWO8ZCEucs8bsw7hR8rsA6w
 4AgHao27Vs+jO+DJCRmAZ0QSH4icb5bOnfH9BCFRob0hEY66RWojV9vuFKI2jONH2rgJ
 GKwdWNMRNfIKg0VK4b9UP/h3i4Z0UPmztzLUNJ6i4CQknO8yVE5D0iCfmAEmOag5lfmj
 XzhA5IcTeC7LHOyhXScMiKrtkfl6aTMyav/+Gqqu0Vg2XC/ciUCdydBm0bPAJAi86nZC
 zXCg==
X-Gm-Message-State: AC+VfDx8y+HFCNQWdvvC2qRJ6GUBFpibon3evaK4nOCX1Dg/qeQOkOVp
 32IpHyJFj1gA38q1OlhanRFVhg==
X-Google-Smtp-Source: ACHHUZ6A7JNcK3lcrf9ARg7vr9v25AZ8PQXhXEZoLBdu56UeMLdRcp3Dxuk5XjyeJnbqnIw31ioZpA==
X-Received: by 2002:a17:907:9621:b0:988:803d:24d9 with SMTP id
 gb33-20020a170907962100b00988803d24d9mr6884477ejc.22.1687245587764; 
 Tue, 20 Jun 2023 00:19:47 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 bv24-20020a170906b1d800b00987cd2db33fsm824031ejb.131.2023.06.20.00.19.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 00:19:47 -0700 (PDT)
Message-ID: <bd29541d-3458-821a-7c2d-baf3645ddcfd@linaro.org>
Date: Tue, 20 Jun 2023 09:19:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] target/arm: Restructure has_vfp_d32 test
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mads Ynddal <mads@ynddal.dk>
References: <20230619140216.402530-1-richard.henderson@linaro.org>
 <6222171f-13b6-cf5a-8431-eb68b4e8b764@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <6222171f-13b6-cf5a-8431-eb68b4e8b764@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62b.google.com
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

On 6/20/23 07:29, Philippe Mathieu-Daudé wrote:
> On 19/6/23 16:02, Richard Henderson wrote:
>> One cannot test for feature aa32_simd_r32 without first
>> testing if AArch32 mode is supported at all.  This leads to
>>
>> qemu-system-aarch64: ARM CPUs must have both VFP-D32 and Neon or neither
>>
>> for Apple M1 cpus.
>>
>> We already have a check for ARMv8-A never setting vfp-d32 true,
>> so restructure the code so that AArch64 avoids the test entirely.
>>
>> Reported-by: Mads Ynddal <mads@ynddal.dk>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/cpu.c | 28 +++++++++++++++-------------
>>   1 file changed, 15 insertions(+), 13 deletions(-)
>>
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index 353fc48567..706dbd37b1 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -1402,25 +1402,27 @@ void arm_cpu_post_init(Object *obj)
>>        * KVM does not currently allow us to lie to the guest about its
>>        * ID/feature registers, so the guest always sees what the host has.
>>        */
>> -    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)
>> -        ? cpu_isar_feature(aa64_fp_simd, cpu)
>> -        : cpu_isar_feature(aa32_vfp, cpu)) {
>> -        cpu->has_vfp = true;
>> -        if (!kvm_enabled()) {
>> -            qdev_property_add_static(DEVICE(obj), &arm_cpu_has_vfp_property);
>> +    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
>> +        if (cpu_isar_feature(aa64_fp_simd, cpu)) {
>> +            cpu->has_vfp = true;
>> +            cpu->has_vfp_d32 = true;
>> +            if (tcg_enabled() || qtest_enabled()) {
>> +                qdev_property_add_static(DEVICE(obj),
>> +                                         &arm_cpu_has_vfp_property);
>> +            }
>>           }
>> -    }
>> -
>> -    if (cpu->has_vfp && cpu_isar_feature(aa32_simd_r32, cpu)) {
>> -        cpu->has_vfp_d32 = true;
>> -        if (!kvm_enabled()) {
>> +    } else if (cpu_isar_feature(aa32_vfp, cpu)) {
>> +        cpu->has_vfp = true;
>> +        if (cpu_isar_feature(aa32_simd_r32, cpu)) {
>> +            cpu->has_vfp_d32 = true;
>>               /*
>>                * The permitted values of the SIMDReg bits [3:0] on
>>                * Armv8-A are either 0b0000 and 0b0010. On such CPUs,
>>                * make sure that has_vfp_d32 can not be set to false.
>>                */
>> -            if (!(arm_feature(&cpu->env, ARM_FEATURE_V8) &&
>> -                  !arm_feature(&cpu->env, ARM_FEATURE_M))) {
>> +            if ((tcg_enabled() || qtest_enabled())
>> +                && !(arm_feature(&cpu->env, ARM_FEATURE_V8)
>> +                     && !arm_feature(&cpu->env, ARM_FEATURE_M))) {
>>                   qdev_property_add_static(DEVICE(obj),
>>                                            &arm_cpu_has_vfp_d32_property);
>>               }
> 
> Shouldn't we also change:
> 
> -- >8 --
> @@ -1431,7 +1431,7 @@ void arm_cpu_post_init(Object *obj)
> 
>       if (arm_feature(&cpu->env, ARM_FEATURE_NEON)) {
>           cpu->has_neon = true;
> -        if (!kvm_enabled()) {
> +        if (tcg_enabled() || qtest_enabled()) {
>               qdev_property_add_static(DEVICE(obj), &arm_cpu_has_neon_property);
>           }
>       }
> ---
> 
> ?

Yes, I missed that, being just out of view.  :-)

r~



