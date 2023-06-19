Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDCD734C4E
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 09:24:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB9F9-0002VD-Ra; Mon, 19 Jun 2023 03:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB9F4-0002Us-Ul
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:24:03 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB9F3-0000Lf-CP
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:24:02 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-514ab6cb529so8151679a12.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 00:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687159440; x=1689751440;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DaqL6z9XLMM/jxSA2GJ2YzYmp2DX/OSx+GWIuQwhVkY=;
 b=AhGDn5OqKYgHhMnVXcavuYRVtciPT7SqS7U6duWV88YGNBiuHIU4w7QPZED68iUAXv
 zj1DJ+2GIIVjwRZKsz0OWYrMhrVLbenKZmHT6kVYhG6nNL/ABLO11PGvVwUqmzx4AlVG
 e44nk7ve/fumjCIRwZGsFz53bcS7lzhg/EQEHprZtv7xpZy4ZWFsfbOFuC1c4Hj3vNCJ
 mHR0/XaesIl/BrNQV3OWEdrZX7vkC7m7geeVkE8AN5fJmdPW7WdXigXuhDftiZrW2XF+
 I53jIbIyaW73cAQ2QUWVYYo6lh/N6q+BjpgxDU97NnQC5fv1+EiZYznEDVGSwyx0mucx
 vFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687159440; x=1689751440;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DaqL6z9XLMM/jxSA2GJ2YzYmp2DX/OSx+GWIuQwhVkY=;
 b=dNNighFNMPO+MA/T5sRWJDel2syLvm9PoTAE8YL8SDcoJ5hDmgVVuac4wdLwBHqyT0
 f4457aCjBzxlJTr4pY6uWa0lwms2KufFLR7Ejr9QnI+7Rl5e73w9ous4mvA/jpT7156B
 s9Lcg2ZamLrNE68J/v8Lx4RAdUvbx537jOq9SdJh3SzNT3vWJdtJL8aEoZE38pYCAr02
 cbFvvVBUfhBYguc+h6wfvj4jHBu25tYPZETxUM+37tOusNBpphuu4MZnqOAh4NJffjOg
 ul5VSZDiF67ulGXnzL1xfYKKRdMSINEdoDcHfdnW5Sgo27Vg9HQhR2qHcLiAGmscV5LG
 7aUg==
X-Gm-Message-State: AC+VfDyD4rr3ceO6gWRMmo263CpZ06oR3OgBPf9imOyf7bOtAjjf5rp+
 snhC9WvpoSUUJCVqYkMLKjkxFrAvEtxolyVMgdzByhHB
X-Google-Smtp-Source: ACHHUZ5TimbA3iZo2mB3jnFxEkHyIKIU77EpqNuo6J/n1xAgYQt8ZbN1dt234G70TwQRzOYRUdphFQ==
X-Received: by 2002:aa7:de19:0:b0:51a:32e1:804a with SMTP id
 h25-20020aa7de19000000b0051a32e1804amr8107085edv.10.1687159439833; 
 Mon, 19 Jun 2023 00:23:59 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 k17-20020a05640212d100b0051a4049b96csm3045254edx.76.2023.06.19.00.23.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 00:23:59 -0700 (PDT)
Message-ID: <ca4c84b4-9ad4-96a1-6ce9-59b5b1d37059@linaro.org>
Date: Mon, 19 Jun 2023 09:23:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/7] target/i386: TCG supports RDSEED
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230618215114.107337-1-pbonzini@redhat.com>
 <20230618215114.107337-4-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230618215114.107337-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x530.google.com
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

On 6/18/23 23:51, Paolo Bonzini wrote:
> TCG implements RDSEED, and in fact uses qcrypto_random_bytes which is
> secure enough to match hardware behavior.  Expose it to guests.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/cpu.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

TCG protects both RDRAND and RDSEED with CPUID_EXT_RDRAND.
I guess we should use CPUID_7_0_EBX_RDSEED for RDSEED?


r~

> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index ff3dcd02dcb..fc4246223d4 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -657,11 +657,10 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
>             CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ADX | \
>             CPUID_7_0_EBX_PCOMMIT | CPUID_7_0_EBX_CLFLUSHOPT |            \
>             CPUID_7_0_EBX_CLWB | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_FSGSBASE | \
> -          CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_AVX2)
> +          CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_RDSEED)
>             /* missing:
>             CPUID_7_0_EBX_HLE
> -          CPUID_7_0_EBX_INVPCID, CPUID_7_0_EBX_RTM,
> -          CPUID_7_0_EBX_RDSEED */
> +          CPUID_7_0_EBX_INVPCID, CPUID_7_0_EBX_RTM */
>   #define TCG_7_0_ECX_FEATURES (CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU | \
>             /* CPUID_7_0_ECX_OSPKE is dynamic */ \
>             CPUID_7_0_ECX_LA57 | CPUID_7_0_ECX_PKS | CPUID_7_0_ECX_VAES)


