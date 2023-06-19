Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B88735D1A
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 19:37:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBIoC-0007N5-PI; Mon, 19 Jun 2023 13:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qBIo9-0007GY-TL
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 13:36:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qBIo7-0007T3-Sg
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 13:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687196210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9c0fDv2n9UlfrrTU9seC2619iV9waHiBiRl5dDvu5bk=;
 b=AM/Ry0w6NysRlM0taRgq97fEbXAgF9RClLHgyQe9yN4QUDqBoRPilquDItmzeVvCtIhiEB
 k1GKHVog7FRmAX2cOl5/4Dyu7j9ltdpeck9it3tT3ohFO2SCe8np/mgQCLJLkjByzra/h4
 +Qwg/xZBOe0R8iSp4FFft6ixfz9Deqo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-DkcwqsS1NeKCAJSC_XdTZw-1; Mon, 19 Jun 2023 13:36:48 -0400
X-MC-Unique: DkcwqsS1NeKCAJSC_XdTZw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4ec817fb123so2263767e87.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 10:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687196207; x=1689788207;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9c0fDv2n9UlfrrTU9seC2619iV9waHiBiRl5dDvu5bk=;
 b=Opu3BIvVI69IN/gw4RTNVlppNbtjl3OS6RnUoEHiVRQL2eEUJJIlgz/4GyetZkZv0R
 Sji1yYHqIvLGntpRoXAaQ4cN23cAlNAagbAkYgTRSM+d2kRne9QLaD6KnEBpo+ZZtfzb
 8GO+dWMb4NwXAXt02VRGt9jpi8OBtBSsa+9B+UdriK0pkWKp7FbspAHkG8gKDCVhgw/0
 iU1OrAw3a5YxYCbHoWqSZ8GN4FBhY2rCfPjiqlfFfxYbv0YqdMj40XXDvlcgh0phefh0
 McRvGxHeYqPDq5Ea7xg5sat1t3anuEFrLtCYbhDntNgzzw14E6rY/wJx8NkyBV9WKWEO
 6Lsg==
X-Gm-Message-State: AC+VfDzc1FhrW3fpazAPIgQ/lpr7vytM5/n6N7lrBYbvEm9qAlp9+KCG
 bSYM6OAmvR6KGaKZ5I35ovIzfMEzWiNzpeo9pX0ufHTXP6JGY8Sm1R0AJ9YhiVtDiK82v3iMK+g
 f9S4ElbvfubJRZ38=
X-Received: by 2002:a19:da19:0:b0:4f8:4719:1f4a with SMTP id
 r25-20020a19da19000000b004f847191f4amr5073386lfg.7.1687196206833; 
 Mon, 19 Jun 2023 10:36:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4WarSymGj3ipMB52HVcL3APWvRnUown3AI//HI/AocoVqJA879ELWyliJ9pypNEW1QGN6psg==
X-Received: by 2002:a19:da19:0:b0:4f8:4719:1f4a with SMTP id
 r25-20020a19da19000000b004f847191f4amr5073376lfg.7.1687196206404; 
 Mon, 19 Jun 2023 10:36:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 n22-20020a7bcbd6000000b003f908ee3091sm6710817wmi.3.2023.06.19.10.36.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 10:36:46 -0700 (PDT)
Message-ID: <682ff90d-3de5-7f12-25b0-edf252d20c95@redhat.com>
Date: Mon, 19 Jun 2023 19:36:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] target/arm: Restructure has_vfp_d32 test
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mads Ynddal <mads@ynddal.dk>
References: <20230619140216.402530-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20230619140216.402530-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/19/23 16:02, Richard Henderson wrote:
> One cannot test for feature aa32_simd_r32 without first
> testing if AArch32 mode is supported at all.  This leads to
> 
> qemu-system-aarch64: ARM CPUs must have both VFP-D32 and Neon or neither
> 
> for Apple M1 cpus.

The orangepi5 board I use didn't have that kind problem.

> We already have a check for ARMv8-A never setting vfp-d32 true,
> so restructure the code so that AArch64 avoids the test entirely.
> 
> Reported-by: Mads Ynddal <mads@ynddal.dk>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Cédric Le Goater <clg@kaod.org>


Thanks for the fix,

C.

> ---
>   target/arm/cpu.c | 28 +++++++++++++++-------------
>   1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 353fc48567..706dbd37b1 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1402,25 +1402,27 @@ void arm_cpu_post_init(Object *obj)
>        * KVM does not currently allow us to lie to the guest about its
>        * ID/feature registers, so the guest always sees what the host has.
>        */
> -    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)
> -        ? cpu_isar_feature(aa64_fp_simd, cpu)
> -        : cpu_isar_feature(aa32_vfp, cpu)) {
> -        cpu->has_vfp = true;
> -        if (!kvm_enabled()) {
> -            qdev_property_add_static(DEVICE(obj), &arm_cpu_has_vfp_property);
> +    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
> +        if (cpu_isar_feature(aa64_fp_simd, cpu)) {
> +            cpu->has_vfp = true;
> +            cpu->has_vfp_d32 = true;
> +            if (tcg_enabled() || qtest_enabled()) {
> +                qdev_property_add_static(DEVICE(obj),
> +                                         &arm_cpu_has_vfp_property);
> +            }
>           }
> -    }
> -
> -    if (cpu->has_vfp && cpu_isar_feature(aa32_simd_r32, cpu)) {
> -        cpu->has_vfp_d32 = true;
> -        if (!kvm_enabled()) {
> +    } else if (cpu_isar_feature(aa32_vfp, cpu)) {
> +        cpu->has_vfp = true;
> +        if (cpu_isar_feature(aa32_simd_r32, cpu)) {
> +            cpu->has_vfp_d32 = true;
>               /*
>                * The permitted values of the SIMDReg bits [3:0] on
>                * Armv8-A are either 0b0000 and 0b0010. On such CPUs,
>                * make sure that has_vfp_d32 can not be set to false.
>                */
> -            if (!(arm_feature(&cpu->env, ARM_FEATURE_V8) &&
> -                  !arm_feature(&cpu->env, ARM_FEATURE_M))) {
> +            if ((tcg_enabled() || qtest_enabled())
> +                && !(arm_feature(&cpu->env, ARM_FEATURE_V8)
> +                     && !arm_feature(&cpu->env, ARM_FEATURE_M))) {
>                   qdev_property_add_static(DEVICE(obj),
>                                            &arm_cpu_has_vfp_d32_property);
>               }


