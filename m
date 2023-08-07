Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D0F7728E5
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 17:17:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT1yw-0000dt-NV; Mon, 07 Aug 2023 11:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT1yo-0000da-Qm
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:17:12 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT1yj-00020B-Up
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:17:10 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-564d6aa9abdso1359197a12.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 08:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691421424; x=1692026224;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gs37I4OG3tTrPJkJyb61IXsysU0DLUywMc+yODNkydU=;
 b=aisGgD8Traj0OMqO9EQDMVRN8xUzfumwiYgEhcvmKIGochS6eKpwFfgC/M32+Ojtxy
 fOmI9e0fTPs4fg/2esnwrxtiDdz104C68jRQRYiD1x82+BMHKwpAOrGU+XxsgMcWgI62
 1WsJJZxmTtqR8JB2odXXRYGLBi5RuCKq41lpjNTdl7mRKMbpXVKF3CWmyyANLnDwpz5H
 xMJVFFYuyXgDR55KtaoohvwXlRwGhGzUjHg42nbHlmGAt1CQW5qjkotQR/QmkaoIWB/I
 xHQchKAm5UEmMHzZ0G9h986ORSk+eiz+JvB+xzSBoda5tjwRYoXvTI8qAqtML+/TjvNd
 mUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691421424; x=1692026224;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gs37I4OG3tTrPJkJyb61IXsysU0DLUywMc+yODNkydU=;
 b=lFErd8WX9TVrk6ewAV2s8PkilU6aKBb2ShJY0efKVtNCPrdi4dgK5jJJKC0pRGYzVI
 lkRtYL62PmOHz6r+02F/TkmYNqi5rJMuAapDJroPVK7d1iF0xMrQTB6qWFZjLqJzrXiz
 THUpcEtErI6qXhhy2e5VkWsk0ohx94BM8TvyY8rIxgoDYn7hXIqAR+D1HWuOVt52NPGv
 b5Ne5ntEDrl69BI3HXIvxTFxrnndsSm2yxBvAqzn19a56CjzimwNcyzgo3K/r/D0C2mW
 W1mccEfdnsv16YY1sY1j2/zoBcb2ubzNLCa3p+KBnaWWUo1rJjQ2Jll860Tpu4DMc56N
 S+Gg==
X-Gm-Message-State: AOJu0Yy5IG5UNweKcPNa9GxTJw0RXvqTmskEaR/Q3+/BfFj1TvKUo2Gx
 kiBifVNCqdt9MsNodAlZplxfo8yieS1Kmwj4dOA=
X-Google-Smtp-Source: AGHT+IF+bQRkoZx3+lqG0zstc2eh/vhAIWokMi33Ma2F4lSX2/m41X2eQsWDxP/zJqn41rZ3/yJ46Q==
X-Received: by 2002:a17:90a:889:b0:268:2af6:e48c with SMTP id
 v9-20020a17090a088900b002682af6e48cmr8769577pjc.4.1691421423908; 
 Mon, 07 Aug 2023 08:17:03 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:e306:567a:e0a1:341?
 ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 br8-20020a17090b0f0800b0026801e06ac1sm6205412pjb.30.2023.08.07.08.17.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 08:17:03 -0700 (PDT)
Message-ID: <111c8d4a-7d4e-bccb-a185-6053278a2248@linaro.org>
Date: Mon, 7 Aug 2023 08:17:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/6] target/loongarch: Add loongarch32 cpu la132
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>
References: <20230807094505.2030603-1-c@jia.je>
 <20230807094505.2030603-3-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230807094505.2030603-3-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/7/23 02:45, Jiajie Chen wrote:
> Add la132 as a loongarch32 cpu type and allow virt machine to be used
> with la132 instead of la464.
> 
> Signed-off-by: Jiajie Chen <c@jia.je>
> ---
>   hw/loongarch/virt.c    |  5 -----
>   target/loongarch/cpu.c | 41 +++++++++++++++++++++++++++++++++++++++++
>   target/loongarch/cpu.h | 11 +++++++++++
>   3 files changed, 52 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index e19b042ce8..af15bf5aaa 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -798,11 +798,6 @@ static void loongarch_init(MachineState *machine)
>           cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
>       }
>   
> -    if (!strstr(cpu_model, "la464")) {
> -        error_report("LoongArch/TCG needs cpu type la464");
> -        exit(1);
> -    }
> -
>       if (ram_size < 1 * GiB) {
>           error_report("ram_size must be greater than 1G.");
>           exit(1);
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index ad93ecac92..d31efe86da 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -362,6 +362,8 @@ static void loongarch_la464_initfn(Object *obj)
>       CPULoongArchState *env = &cpu->env;
>       int i;
>   
> +    env->mode = LA64;
> +
>       for (i = 0; i < 21; i++) {
>           env->cpucfg[i] = 0x0;
>       }
> @@ -439,6 +441,20 @@ static void loongarch_la464_initfn(Object *obj)
>       env->CSR_ASID = FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
>   }
>   
> +static void loongarch_la132_initfn(Object *obj)
> +{
> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
> +    CPULoongArchState *env = &cpu->env;
> +
> +    env->mode = LA32;
> +
> +    cpu->dtb_compatible = "loongarch,Loongson-3C103";
> +
> +    uint32_t data = 0;
> +    data = FIELD_DP32(data, CPUCFG1, ARCH, 1); /* LA32 */
> +    env->cpucfg[1] = data;
> +}

This is missing quite a lot of other initialization.  I would expect this to look more 
like loongarch_la464_initfn with quite a lot of CPUCFG settings.

This patch should be sorted after support for LA32 is added to the translator, so that 
when bisecting it is not possible to select this cpu when support is not present.


r~


