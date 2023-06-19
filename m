Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53ABD734C7A
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 09:41:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB9V0-0005j4-2E; Mon, 19 Jun 2023 03:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB9Ux-0005iw-Kz
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:40:27 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB9Uw-00047R-2M
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:40:27 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9889952ed18so149186266b.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 00:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687160424; x=1689752424;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lTM2E6KGvTOETyPxiOtyr1Oicep3+1FPpuJ+SAEWWiM=;
 b=b797jYpwQWqM3rbGDLe3LC0dShS5/3QemN9ux37nT2wSQrEQH6yLSzGTZPHTxXGNF7
 Jrxqn+4Ze8uhgMNhuzCxqkCcHKY0vT5sk5HjDJ9BjkQ8Hziczs53b+lFkm6rAbkmjqs8
 yYUIg1HF0U2SRckgydwktQwK6vVgHUPJR2gayyMwfonB/l1Ok000/zLpKx3neneK5bRL
 4U4CI985cWLsMLKuBq0mVbq/yRtodmMeyiBYEpFrEfiOeiptu8RZnad+EADjZahtc2em
 aSGKKk4bX1z/RM/J8gMwyBJR8c0baMmEB4uBfqtqbFPvParf8upway4a1ScIIEb5yYJM
 +BTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687160424; x=1689752424;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lTM2E6KGvTOETyPxiOtyr1Oicep3+1FPpuJ+SAEWWiM=;
 b=F+ZSe/94W0MvxWatJFM+UVKss7VQoxhh29ZHFOZIETXs+fuUjBGdLCEj69Y3+jpnuf
 g2X5Tslg5DbjqlM3Ded621Zb1FI0RvBjWJ5WcOqe06AhwCZq2osfc5SpPo9zZ9r6IaCF
 bwxFJm5NifqAE81FmHGGgxlT6RZq01sk60+HeadTpKF+ycauZtPqSBB5NxKRBcg4IaAR
 CieAEegD88GU7Cub/Nz9cbXx6pkZr3CkqfLE4S84khlljhGqaiyhk0c0ucxLHzeYKioY
 6ozBKNDfM6sbb58fGl5pTtL//VbSDcR7VbEqNLuYVYSkwPFVH585WGK+HghDH4czSDOo
 0bXw==
X-Gm-Message-State: AC+VfDxY8sqlgeCHYM9SrK1Ujbj4auWA48tve7y69lvuRWi5qrWu+xDo
 JKFdtUNzhNoju2jVDEG1gHb9yQ==
X-Google-Smtp-Source: ACHHUZ7hkatloGQ4Mu0PxhHzf6+FbE0+2CRXNZLqBc7tPTwLwV7sW7fuJ3C0xOdJ/bmX5WM3sHqfwg==
X-Received: by 2002:a17:907:9284:b0:974:1ef7:1e88 with SMTP id
 bw4-20020a170907928400b009741ef71e88mr7604570ejc.13.1687160424189; 
 Mon, 19 Jun 2023 00:40:24 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 ja6-20020a170907988600b00987506c21b1sm3154814ejc.219.2023.06.19.00.40.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 00:40:23 -0700 (PDT)
Message-ID: <e137adbf-f1cd-2d2a-a45b-359bacb32c75@linaro.org>
Date: Mon, 19 Jun 2023 09:40:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6/7] target/i386: implement RDPID in TCG
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230618215114.107337-1-pbonzini@redhat.com>
 <20230618215114.107337-7-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230618215114.107337-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62f.google.com
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
> RDPID corresponds to a RDMSR(TSC_AUX); however, it is unprivileged
> so for user-mode emulation we must provide the value that the kernel
> places in the MSR.  For Linux, it is a combination of the current CPU
> and the current NUMA node, both of which can be retrieved with getcpu(2).
> For BSD, just return 0.
> 
> RDTSCP is reimplemented as RDTSC + RDPID ECX; the differences in terms
> of serializability are not relevant to QEMU.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   linux-user/i386/target_cpu.h   |  8 ++++++++
>   linux-user/x86_64/target_cpu.h |  1 +
>   target/i386/cpu.c              | 10 +++++++++-
>   target/i386/helper.h           |  2 +-
>   target/i386/tcg/misc_helper.c  | 21 +++++++++++++++------
>   target/i386/tcg/translate.c    | 15 +++++++++++++--
>   6 files changed, 47 insertions(+), 10 deletions(-)
> 
> diff --git a/linux-user/i386/target_cpu.h b/linux-user/i386/target_cpu.h
> index 52caf788cc3..3539f790222 100644
> --- a/linux-user/i386/target_cpu.h
> +++ b/linux-user/i386/target_cpu.h
> @@ -54,4 +54,12 @@ static inline abi_ulong get_sp_from_cpustate(CPUX86State *state)
>   {
>       return state->regs[R_ESP];
>   }
> +
> +static inline uint32_t get_cpunode(void)
> +{
> +    unsigned cpu, node;
> +    getcpu(&cpu, &node);
> +    return (node << 12) | (cpu & 0xfff);
> +}
> +

What is our minimum glibc version?  This requires 2.29.

Also, not especially fond of the placement.  target/ including linux-user/ header isn't 
nice.  Might as well just place these 3 lines in misc_helper.c to begin.

r~

