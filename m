Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 188CD7808D6
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 11:43:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWvzU-0001Ti-7x; Fri, 18 Aug 2023 05:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWvzR-0001TF-F7
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:41:57 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWvzP-0002fe-3R
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:41:57 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5256d74dab9so846015a12.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 02:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692351713; x=1692956513;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z1ppo6spZJQfYTL6kPuIGp83eMOxd5+64o3AAPvh3YA=;
 b=JylZdctwuqxYN4NPWAFwXo1Sp2i5ZmtDmFVosaqNLR/PGBaGXFIczLCVGD6w2iHlVG
 /OAO9O+xG2Zmf91CRF1n2PBYJ5CaEXVKrJb7hUgpOoANBxeaw0gCCDpJeDa+jVh52ubx
 BcFzrICRtHwFSuIndASHEPBdf0L0EZJ1K9YWav1X8WU4mOLsQt+tig5EwIEF1Qo4tl/L
 m6Do9u9jWdrruJ/adTHhocEFfKelKzOxDH8q6jimu9dlEMsPtZP/37PXcZY/mSLTMlHX
 8K/bnrW090+w72p9SL7dblvDqcsHK7DPmqedQmZslq6QE+XT5nXbLsrmvUjnb6pOtBCP
 vPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692351713; x=1692956513;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z1ppo6spZJQfYTL6kPuIGp83eMOxd5+64o3AAPvh3YA=;
 b=KIZUCFQeKHPYqRkStENT8emdio3oipHT82BuucYFvsbadekGKNPI8nRZOIYj6lm1we
 sv7+3Rrilvafa/eOtBeKNpxdnT9auF9HPmnHpW2X6esXpbFoE19Ybtx11+frlEBtD1gh
 SBKazcqXi44k452wvOdTNTJHtGSISKYtsoi79keRmb9ffJyaEFKuJI5Pdwatvm+0+fK0
 nslBLJ9HjlU3CcCxffJZpqS6kwgfId++e0wpvsAUZbS5Bjw1lOhMhrYncBxtYcoRBZih
 oe2T1hb6VgDQdd2n6KYSF94NsE8niK+pG/kTcfNNbh3ZIUk88dmuggbQoqlYtuxoF4Sp
 QbKA==
X-Gm-Message-State: AOJu0YzeQsSuhKf9ozw1brLOTJzHL+/+tbfV+9QA1442+7NsSzXmUY4m
 qUrENyDj9Avt8QD7P8WZxYlR5w==
X-Google-Smtp-Source: AGHT+IG330vnATtTurgBVlAwT0RBtLEtLgYVQJVzAzYiSzmSmR1KymK6fdB4j2LBIVYr40InTAwBrw==
X-Received: by 2002:a17:906:2254:b0:99e:8a1:9df7 with SMTP id
 20-20020a170906225400b0099e08a19df7mr1655060ejr.74.1692351713487; 
 Fri, 18 Aug 2023 02:41:53 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.184.114])
 by smtp.gmail.com with ESMTPSA id
 q20-20020a17090622d400b0099cce6f7d50sm972909eja.64.2023.08.18.02.41.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 02:41:52 -0700 (PDT)
Message-ID: <095e6d5a-a19d-abc0-4a9a-d23dddd33755@linaro.org>
Date: Fri, 18 Aug 2023 11:41:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 08/18] target/loongarch: Truncate high 32 bits of
 address in VA32 mode
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, c@jia.je, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, yijun@loongson.cn, shenjinyang@loongson.cn
References: <20230817093121.1053890-1-gaosong@loongson.cn>
 <20230817093121.1053890-9-gaosong@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230817093121.1053890-9-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.01,
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

On 17/8/23 11:31, Song Gao wrote:
> From: Jiajie Chen <c@jia.je>
> 
> When running in VA32 mode(!LA64 or VA32L[1-3] matching PLV), virtual
> address is truncated to 32 bits before address mapping.
> 
> Signed-off-by: Jiajie Chen <c@jia.je>
> Co-authored-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/cpu.c                        | 16 ++++----
>   target/loongarch/cpu.h                        |  9 +++++
>   target/loongarch/gdbstub.c                    |  2 +-
>   .../loongarch/insn_trans/trans_atomic.c.inc   |  5 ++-
>   .../loongarch/insn_trans/trans_branch.c.inc   |  3 +-
>   .../loongarch/insn_trans/trans_fmemory.c.inc  | 30 ++++-----------
>   target/loongarch/insn_trans/trans_lsx.c.inc   | 38 +++++--------------
>   .../loongarch/insn_trans/trans_memory.c.inc   | 34 +++++------------
>   target/loongarch/op_helper.c                  |  4 +-
>   target/loongarch/translate.c                  | 32 ++++++++++++++++
>   10 files changed, 85 insertions(+), 88 deletions(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 30dd70571a..bd980790f2 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -81,7 +81,7 @@ static void loongarch_cpu_set_pc(CPUState *cs, vaddr value)
>       LoongArchCPU *cpu = LOONGARCH_CPU(cs);
>       CPULoongArchState *env = &cpu->env;
>   
> -    env->pc = value;
> +    set_pc(env, value);

Shouldn't we use CPUClass::set_pc() instead?

>   }


> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 0e02257f91..9f550793ca 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -442,6 +442,15 @@ static inline bool is_va32(CPULoongArchState *env)
>       return va32;
>   }
>   
> +static inline void set_pc(CPULoongArchState *env, uint64_t value)
> +{
> +    if (is_va32(env)) {
> +        env->pc = (uint32_t)value;

That would become loongarch32_cpu_set_pc().

> +    } else {
> +        env->pc = value;

This is the current loongarch_cpu_set_pc().

> +    }
> +}



