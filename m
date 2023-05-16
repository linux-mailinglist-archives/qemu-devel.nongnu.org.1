Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48506704960
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 11:34:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyr2r-0004yo-UO; Tue, 16 May 2023 05:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1pyr2p-0004ya-L3; Tue, 16 May 2023 05:32:36 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1pyr2o-0004wf-5b; Tue, 16 May 2023 05:32:35 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6ab1a20aa12so5601208a34.1; 
 Tue, 16 May 2023 02:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684229552; x=1686821552;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i2uSHFsybPikPn4UgoCj36ah0HqSDvBLHaM/hSL8Bwo=;
 b=K7MG3N9ZZVBQ/w/xJ11/37Sa9HIydLcFLWkLYjB6hS21SbQ2IBm4mTZmyi/iGZo9GL
 a8nsFIGtfNAPx46PZ+KWyieBfhEqacO1uEHV1SVPnRS/D7Sk9K1GUiRVqX/CS5gy7mK2
 ytCiKKdmNu4XnhihD9XROEJ9A0fRbY8FrXUsWo/aQdW6e1dVgR0IYSeLaVTDyPZjCo4K
 HeJSq41P2GMzgjKj+Eorts4NXQwiTjZCSVJrthIOx76J9PTDoaVEK60fYxdwIRqvyvQo
 xUzOtaBzPY5UQZfb/ZBmoy0afBmO0b7UfF8xrbOfWqJCctVpdtfTXqPPg3uV2wwFPRCK
 tpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684229552; x=1686821552;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i2uSHFsybPikPn4UgoCj36ah0HqSDvBLHaM/hSL8Bwo=;
 b=kKesG70WzWpZ6PcmPLaqBusfbYhk+uHUyRZ4QQoIrx3xFBJq6YL437q3EomXjZDebI
 DJGYSRnmounyZXVarUIsx/od4RrjN+P/rOjvyHLa5LXzTlglOFo4aRPwLiVGrr2AR3Wr
 jptW39ppyYWMJXWA9nm7P/UNkMdBz0s3AcPiHNUWYpXSNHZ9/YvWsEJb2Yh84Xo796uc
 NXhhDLFC8aZEX2/ADsJAhhpB31i/++xJFnNX1H0OVWIhukYZg82s1eqOwwXfsVBCvP7/
 QzWitgH5iJFl34Md8AaEhi7zBBJP/1RV/UotcqXPpisg697C01fugX92vIVOEjxdnm7S
 x83g==
X-Gm-Message-State: AC+VfDw/xafa8SceUHXkM+DoCDwVFiaPJMa8nNLyq4Nh/b7v9vOv+gzK
 OUaU1vC7MaVWqUrQ3xI6lws=
X-Google-Smtp-Source: ACHHUZ5lYwZpHIYZ/qwluaXk/lGS0pvWdUbNR31TiK3jRtmxpmoanCYfnlg6rFWTHOCzpzPPjt2XXA==
X-Received: by 2002:a05:6830:200d:b0:6a6:3a73:95e with SMTP id
 e13-20020a056830200d00b006a63a73095emr14068486otp.35.1684229552411; 
 Tue, 16 May 2023 02:32:32 -0700 (PDT)
Received: from [192.168.68.107] (189-46-207-53.dsl.telesp.net.br.
 [189.46.207.53]) by smtp.gmail.com with ESMTPSA id
 r19-20020a4ae513000000b0051ffe0fe11bsm11671513oot.6.2023.05.16.02.32.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 02:32:32 -0700 (PDT)
Message-ID: <4b7c4c7b-d374-766b-48f1-c6769805f0bc@gmail.com>
Date: Tue, 16 May 2023 06:32:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/9] target/ppc: Fix PMU MMCR0[PMCjCE] bit in hflags
 calculation
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20230515092655.171206-1-npiggin@gmail.com>
 <20230515092655.171206-3-npiggin@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230515092655.171206-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-3.811,
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



On 5/15/23 06:26, Nicholas Piggin wrote:
> A store to MMCR0 with PMCjCE=1 fails to update hflags correctly and
> results in hflags mismatch:
> 
>    qemu: fatal: TCG hflags mismatch (current:0x2408003d rebuilt:0x240a003d)
> 
> This can be reproduced by running perf on a recent machine.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Fixes: c2eff582a32f ("target/ppc: PMU basic cycle count for pseries TCG")

(not sure why I didn't hit this back in 2021)


Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>



> Since v2: new patch.
> 
>   target/ppc/power8-pmu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/ppc/power8-pmu.c b/target/ppc/power8-pmu.c
> index 64a64865d7..29e0012ed6 100644
> --- a/target/ppc/power8-pmu.c
> +++ b/target/ppc/power8-pmu.c
> @@ -236,14 +236,16 @@ void helper_store_mmcr0(CPUPPCState *env, target_ulong value)
>   {
>       bool hflags_pmcc0 = (value & MMCR0_PMCC0) != 0;
>       bool hflags_pmcc1 = (value & MMCR0_PMCC1) != 0;
> +    bool hflags_pmcjce = (value & MMCR0_PMCjCE) != 0;
>   
>       pmu_update_cycles(env);
>   
>       env->spr[SPR_POWER_MMCR0] = value;
>   
> -    /* MMCR0 writes can change HFLAGS_PMCC[01] and HFLAGS_INSN_CNT */
> +    /* MMCR0 writes can change HFLAGS_PMCC[01], PMCjCE, and HFLAGS_INSN_CNT */
>       env->hflags = deposit32(env->hflags, HFLAGS_PMCC0, 1, hflags_pmcc0);
>       env->hflags = deposit32(env->hflags, HFLAGS_PMCC1, 1, hflags_pmcc1);
> +    env->hflags = deposit32(env->hflags, HFLAGS_PMCJCE, 1, hflags_pmcjce);
>   
>       pmu_update_summaries(env);
>   

