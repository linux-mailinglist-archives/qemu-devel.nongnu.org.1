Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDFE826BFB
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 12:03:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMnP7-0005pV-TX; Mon, 08 Jan 2024 06:02:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMnOy-0005ow-Ct
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 06:02:43 -0500
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMnOw-0001LA-LL
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 06:02:40 -0500
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-783182d4a0aso136679785a.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 03:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704711757; x=1705316557; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NSqsY4xRS488oxeXTJoAOWWtoKUK7LC2iyVbmGb1Ma0=;
 b=Rpf+/DlxRcWQpSI8+b76NdJOX9+u7+FA1m94k9F2K6aRfiUMxCDMWRUDZq8OtfiKLI
 tnJTsfH0cUb8crhuqraFVje0tW1dnFhsHLarug5H4unj0z45zac6+a783bu0g1eX2gWK
 DnCflzPCDv0dfeXxHm/0vq5COhrzphLRPaoz+gtA+wLIq3k5mZnrj7YdkXTgJGP8SkSX
 R7rYe3nb/i193X+jMy4ks0uW3aeqdpavniEtkhE7WBCq6GJz9AERdVymWF39981oPz6z
 y6ikgVZmHJkrCM0SMepMpwoBo3UOeFL0ao6lpkB1YXJJYA5F7moD2dUgYUekbrO22SK7
 bxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704711757; x=1705316557;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NSqsY4xRS488oxeXTJoAOWWtoKUK7LC2iyVbmGb1Ma0=;
 b=dRkdNYc11r1Ef7uHb3WtGQpNqOwomB6guPDzWq5TRoTtMnrOYFHYh31ggRAwoOkZXY
 9rih051szFru7KDoleXOF4PWWPofBDCe/c6vo93Xui/lJAEFj8WYuTJvmn78QnCXB9Gr
 E3V3SsruTb5tKcalfPZ6TlZZZIr3fNgl9RBKiHeVNalIdCveppwSSk5UalHstKWMLT3X
 LN1cYQxg5MfSbqLzpE5xRBsjnTBYFZs7U2VwC1yGpjfW3XENolIlZP9RVg+BuwpXE4jS
 n463kRO3MgFXbIn9rXubWuotAWxBwk9cbmFE2jI2u0cCd7iNJvPtLM9AIt+0+CtEPmmS
 VlFQ==
X-Gm-Message-State: AOJu0YzuLw8G+1ag9IKu2mDOsb9x/yjitF8JoM5TK/MCezV76QaASVf3
 Oy8OfCHkvlwGTkKIcyUqX1+CcHYU2SxwgQ==
X-Google-Smtp-Source: AGHT+IG743ysXN6XE8t5pJkaW4EKBRGbcEFJ+8Yj2QXbgpoF7hc6bSW0cdskTMzn5SmsXw6Xa5HoAw==
X-Received: by 2002:a05:620a:13d8:b0:783:1b52:2b6 with SMTP id
 g24-20020a05620a13d800b007831b5202b6mr2389907qkl.151.1704711757535; 
 Mon, 08 Jan 2024 03:02:37 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 c10-20020a05620a164a00b00781663f3161sm2592930qko.85.2024.01.08.03.02.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 03:02:37 -0800 (PST)
Message-ID: <0709ec3c-b217-450f-baac-8774b0dc463c@linaro.org>
Date: Mon, 8 Jan 2024 15:02:31 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 30/33] target/arm: Enable TARGET_PAGE_BITS_VARY for
 AArch64 user-only
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-31-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240102015808.132373-31-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qk1-x72b.google.com
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

On 1/2/24 05:58, Richard Henderson wrote:
> Since aarch64 binaries are generally built for multiple
> page sizes, it is trivial to allow the page size to vary.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu-param.h |  6 ++++-
>   target/arm/cpu.c       | 51 ++++++++++++++++++++++++------------------
>   2 files changed, 34 insertions(+), 23 deletions(-)
> 
> diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
> index f9b462a98f..da3243ab21 100644
> --- a/target/arm/cpu-param.h
> +++ b/target/arm/cpu-param.h
> @@ -19,9 +19,13 @@
>   #endif
>   
>   #ifdef CONFIG_USER_ONLY
> -#define TARGET_PAGE_BITS 12
>   # ifdef TARGET_AARCH64
>   #  define TARGET_TAGGED_ADDRESSES
> +/* Allow user-only to vary page size from 4k */
> +#  define TARGET_PAGE_BITS_VARY
> +#  define TARGET_PAGE_BITS_MIN  12
> +# else
> +#  define TARGET_PAGE_BITS 12
>   # endif
>   #else
>   /*
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 650e09b29c..55c2888f2c 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1788,7 +1788,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>       ARMCPU *cpu = ARM_CPU(dev);
>       ARMCPUClass *acc = ARM_CPU_GET_CLASS(dev);
>       CPUARMState *env = &cpu->env;
> -    int pagebits;
>       Error *local_err = NULL;
>   
>       /* Use pc-relative instructions in system-mode */
> @@ -2079,28 +2078,36 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>              !cpu_isar_feature(aa32_vfp_simd, cpu) ||
>              !arm_feature(env, ARM_FEATURE_XSCALE));
>   
> -    if (arm_feature(env, ARM_FEATURE_V7) &&
> -        !arm_feature(env, ARM_FEATURE_M) &&
> -        !arm_feature(env, ARM_FEATURE_PMSA)) {
> -        /* v7VMSA drops support for the old ARMv5 tiny pages, so we
> -         * can use 4K pages.
> -         */
> -        pagebits = 12;
> -    } else {
> -        /* For CPUs which might have tiny 1K pages, or which have an
> -         * MPU and might have small region sizes, stick with 1K pages.
> -         */
> -        pagebits = 10;
> -    }
> -    if (!set_preferred_target_page_bits(pagebits)) {
> -        /* This can only ever happen for hotplugging a CPU, or if
> -         * the board code incorrectly creates a CPU which it has
> -         * promised via minimum_page_size that it will not.
> -         */
> -        error_setg(errp, "This CPU requires a smaller page size than the "
> -                   "system is using");
> -        return;
> +#ifndef CONFIG_USER_ONLY
> +    {
> +        int pagebits;
> +        if (arm_feature(env, ARM_FEATURE_V7) &&
> +            !arm_feature(env, ARM_FEATURE_M) &&
> +            !arm_feature(env, ARM_FEATURE_PMSA)) {
> +            /*
> +             * v7VMSA drops support for the old ARMv5 tiny pages,
> +             * so we can use 4K pages.
> +             */
> +            pagebits = 12;
> +        } else {
> +            /*
> +             * For CPUs which might have tiny 1K pages, or which have an
> +             * MPU and might have small region sizes, stick with 1K pages.
> +             */
> +            pagebits = 10;
> +        }
> +        if (!set_preferred_target_page_bits(pagebits)) {
> +            /*
> +             * This can only ever happen for hotplugging a CPU, or if
> +             * the board code incorrectly creates a CPU which it has
> +             * promised via minimum_page_size that it will not.
> +             */
> +            error_setg(errp, "This CPU requires a smaller page size "
> +                       "than the system is using");
> +            return;
> +        }
>       }
> +#endif
>   
>       /* This cpu-id-to-MPIDR affinity is used only for TCG; KVM will override it.
>        * We don't support setting cluster ID ([16..23]) (known as Aff2

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

