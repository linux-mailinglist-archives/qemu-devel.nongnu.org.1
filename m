Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0548173632F
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 07:30:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBTvl-0000Vy-2X; Tue, 20 Jun 2023 01:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBTvZ-0000VP-Lb
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 01:29:17 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBTvW-0006i3-Td
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 01:29:16 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-51a4088c4ebso3926459a12.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 22:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687238953; x=1689830953;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nUNvLlQuX/1rUTR3tYvJA9ij78Oo4/UkdB8XUk4U0us=;
 b=NDzRAS+6NfMR7Ks6y+n9cP+6luNZfCKLG808MrbhUnMnOIXyANvyf22nFNyn2KSsCH
 DKxSJGszYCiC1ktmXJ3XEUeHmOLW/6jwtBrHpbEo5ZGtou/uRaBUymkDZb+k0+gM828O
 9K2cUN+Qylfi1VE/JjybMTDBt2hwiyAsqolaA2m9u5vQ83VutiI1oGjKlz6u8A9NVe0c
 swJE4+KRMj5uIwdfaZ/LddQ0ftVm261rwm+XBX8rwxqm12JjiMXYgFu536iBKusuAGzd
 sy32g+AGBhpcC9nVofVs8n9PLsjtGutKLrq57QJih1p3LGtWSNPG2IdfdrzRmAxUJPqd
 6Akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687238953; x=1689830953;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nUNvLlQuX/1rUTR3tYvJA9ij78Oo4/UkdB8XUk4U0us=;
 b=T9/bJgp/8VDZVzruPPfTohPHyfpk42NN+UEZNUAk9rqtyeBfKrGjAtXt/R9KXvRxmh
 HUX+7cFmSrGugGhP2GonTbytrLz0IrzD7WAs+8i+VeFMpcAkwpn/KyllBlrzU/liA/jr
 6y5pas7Yfv93sCAilNJs41pzXtlBUarEQVlrUlndSGsz0N5ZKnD6AvJrnJSo/zYU4ZBa
 +N1VwLaOZQAXUxdZaB1Ub7Lel06vNd4ate1MDjQ4Ih0w6Qoh21fBNHMxD4FGug8AyQD3
 7UUJ9xR9umzYYOBFsJ47O/9c620TJuMIokQx+Jncv62kC/xuccf1DqKDUhuouiEQay5p
 A3UA==
X-Gm-Message-State: AC+VfDwhtrWs1F1q47WwhtJ4fC2VW3RetdIFLJMAOiwC/hoeySVdzPaf
 xgjJWY1gGpSI+bHQDOnpd+K8DQ==
X-Google-Smtp-Source: ACHHUZ6HhmqBnhQ+Opm8hy/t+1fYIhmGLjt1ybpt7PonO/hwzcFBXlsjB0eh1he0P0JSUnoVLeTu5g==
X-Received: by 2002:a17:907:7e95:b0:987:350e:771a with SMTP id
 qb21-20020a1709077e9500b00987350e771amr8463390ejc.72.1687238952838; 
 Mon, 19 Jun 2023 22:29:12 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 l24-20020a1709060e1800b009871016d520sm658791eji.42.2023.06.19.22.29.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 22:29:12 -0700 (PDT)
Message-ID: <6222171f-13b6-cf5a-8431-eb68b4e8b764@linaro.org>
Date: Tue, 20 Jun 2023 07:29:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] target/arm: Restructure has_vfp_d32 test
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mads Ynddal <mads@ynddal.dk>
References: <20230619140216.402530-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230619140216.402530-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

On 19/6/23 16:02, Richard Henderson wrote:
> One cannot test for feature aa32_simd_r32 without first
> testing if AArch32 mode is supported at all.  This leads to
> 
> qemu-system-aarch64: ARM CPUs must have both VFP-D32 and Neon or neither
> 
> for Apple M1 cpus.
> 
> We already have a check for ARMv8-A never setting vfp-d32 true,
> so restructure the code so that AArch64 avoids the test entirely.
> 
> Reported-by: Mads Ynddal <mads@ynddal.dk>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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

Shouldn't we also change:

-- >8 --
@@ -1431,7 +1431,7 @@ void arm_cpu_post_init(Object *obj)

      if (arm_feature(&cpu->env, ARM_FEATURE_NEON)) {
          cpu->has_neon = true;
-        if (!kvm_enabled()) {
+        if (tcg_enabled() || qtest_enabled()) {
              qdev_property_add_static(DEVICE(obj), 
&arm_cpu_has_neon_property);
          }
      }
---

?

