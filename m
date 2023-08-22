Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB50783A36
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 08:56:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLJI-0006FI-Nm; Tue, 22 Aug 2023 02:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLJH-0006FA-3x
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 02:56:15 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLJE-00074Z-Us
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 02:56:14 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fe12baec61so41569345e9.2
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 23:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692687370; x=1693292170;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9tAn08org2kv6oAgYDAWTvHv3hRHNTLfE2o1ynw7EQg=;
 b=bcfU1gPtIm3m588bt2mZdonHieatz4HvJXTFq9jhFqjkvktD9yaSQg/qxz9VnojOii
 vnvs0cOouJIlzHApu6bdV9JZ3nAkn0+hH1ixN/BsqGKcD+hScGMSkf18uWI3noSjBMzo
 LOmoklgiVnqUOTboOeKcC4CSEc4c26/er9AIRkoWZT3O5lJYTYVoVGO63WXm0YAlPT0Q
 Leg9PvZyj9lPVy4VQCHh8D5fl892l0JnE84Jq5hACE95XryekRyWXb0Fpwo+xwqzHhHB
 3RxloXoHrIMoe5ERCCOqKcF3kW8GSdC8+V1RK7JUjFHeeZTO61EL9+2Ujdh/t1F9uhTq
 +qog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692687370; x=1693292170;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9tAn08org2kv6oAgYDAWTvHv3hRHNTLfE2o1ynw7EQg=;
 b=lhRgJeohfWwVYQAoBBoY0GiTgvHSeawzZ0Aq4jFonRd+SiN7mzWxyaJE0ANCfiitlr
 1s2GHQoh093by2l94mTYxISO10uJteznzoNw21QvbjLuVTcSYUxhUlGv7JOgmJyAnFps
 DZgclVMJdmMTsi+Kyw10AWOoIOAABoELc6xEVqkye7dfT+zYqX//kwkAxHeg676z22Yx
 QB83HEU1ZuQ+S2CNdz3QQBeGZIV+xc7Z/CGUSCMbre363zU5VvMh/i0nww1Vsnf7/ucW
 XANXpMBorr+Kh6iXk2KXf/bp57t2MQF0W37az5PVtB+ztXSc+hVuZ+YMHi3EBiMwOct3
 Rcuw==
X-Gm-Message-State: AOJu0YyGWIuAUOerU1WijIFPJOE6B9Q95V4YqGQMZj5Ytzdi/C+qkPfg
 3JHWTLgPsV/gSfhS+SnTBZsecQ==
X-Google-Smtp-Source: AGHT+IHivFMZHCSzHtbKxWP3KCIKHpMUGtEl4tRIizJkdAyAhiefNF56DqNdS9zr5w1EKqjyUv4Z/w==
X-Received: by 2002:a05:6000:1363:b0:31a:ea9f:1aa6 with SMTP id
 q3-20020a056000136300b0031aea9f1aa6mr6593419wrz.47.1692687370659; 
 Mon, 21 Aug 2023 23:56:10 -0700 (PDT)
Received: from [10.2.0.2] ([37.19.214.4]) by smtp.gmail.com with ESMTPSA id
 e1-20020adff341000000b003177f57e79esm14758659wrp.88.2023.08.21.23.56.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 23:56:10 -0700 (PDT)
Message-ID: <8a37fa1d-e967-30be-1cb0-bcb0c8196792@linaro.org>
Date: Tue, 22 Aug 2023 08:56:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v4 09/15] target/loongarch: Add LoongArch32 cpu la132
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, c@jia.je, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, yijun@loongson.cn, shenjinyang@loongson.cn
References: <20230822032724.1353391-1-gaosong@loongson.cn>
 <20230822032724.1353391-10-gaosong@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230822032724.1353391-10-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.374,
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

On 22/8/23 05:27, Song Gao wrote:
> From: Jiajie Chen <c@jia.je>
> 
> Add LoongArch32 cpu la132.
> 
> Due to lack of public documentation of la132, it is currently a
> synthetic LoongArch32 cpu model. Details need to be added in the future.
> 
> Signed-off-by: Jiajie Chen <c@jia.je>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/cpu.c | 30 ++++++++++++++++++++++++++++++

Thanks for splitting the hw/ patch out, ...

>   1 file changed, 30 insertions(+)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 67eb6c3135..d3c3e0d8a1 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -440,6 +440,35 @@ static void loongarch_la464_initfn(Object *obj)
>       env->CSR_ASID = FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
>   }
>   
> +static void loongarch_la132_initfn(Object *obj)
> +{
> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
> +    CPULoongArchState *env = &cpu->env;
> +
> +    int i;
> +
> +    for (i = 0; i < 21; i++) {
> +        env->cpucfg[i] = 0x0;
> +    }
> +
> +    cpu->dtb_compatible = "loongarch,Loongson-1C103";
> +    env->cpucfg[0] = 0x148042;  /* PRID */

... and filling the PRid register.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


