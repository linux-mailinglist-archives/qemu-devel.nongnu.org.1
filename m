Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1341780FB6
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 17:59:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX1sq-0006kQ-Oc; Fri, 18 Aug 2023 11:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX1so-0006bt-6T
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:59:30 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX1sk-00050m-EO
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:59:29 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bdcb800594so8649915ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 08:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692374363; x=1692979163;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R1Rgw9Wi0OJ/Q5yK8AYhV+VudpJMLGVi8f29II1Jnbc=;
 b=DY5++WHSfw3dqZheF+d86USu8QPrcsZiQnvGFAgWnjrjpgSntKHrTlKUp1I668ea5g
 66A2S4uZ3/+PZksWFM6SwTQAKSz86NIR+hT/OknK+972e5GPPdiL2iSzmc/5OLUWLVXR
 qx4xcTQlbLeukoKnspgm9Wp6IhUUHuDWpFDA02qDKmn/1BFzt992YDq09klkj5m+Tzu1
 TFIy39yQ8K5PcnWUMDAxl0KBjXkVYJgBguOIwsEVHD5TQX/KZb/fjygsDuaTeD4VeRQm
 IqjYZoA+wnFLXJVGsUH0QMx1YA1KoAQXappnHzAjzF50mVRTLNIokA/5UCuYbU2hJ/Pr
 4k3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692374363; x=1692979163;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R1Rgw9Wi0OJ/Q5yK8AYhV+VudpJMLGVi8f29II1Jnbc=;
 b=BB0iFn4cJ3RY4jTXR+y9svdyv/22pkVfLs8gllOMV/clAB+GRuoIiJ7kCJOTj6MqE3
 pyBuTe28XzktyDJXdcKTPKm8gJmw1pOruYoEF4d1BxmhCI9vBJptANLk0EdFLM2qk9E2
 6UveepbSdjO0q7+os1Gr6avAa2279FlR3jNpyyzVspIj7zE3IesuYWB6fueK5YlpCXOP
 bII+N8yqrSptvoXTtNFdsowL+LqiZ0ZuZN1JlOeinpIMRCpAfjvlQiaUGAR6HoPL4h/+
 NJpqi4bh1n6AkVXUHZ0YSSttJeO05NrRFWIZzwkj88R+Y5cK+A32YpSfXVOVkQT7FsLt
 DUDw==
X-Gm-Message-State: AOJu0YwPOvWWVXceg3VfeF+jukrhKSk9mYbfAcmGT/6qkCqlTejESzEU
 Q1t8MuUeVNDmVrDrj3oRHFgO3Q==
X-Google-Smtp-Source: AGHT+IH7Bvrok8GVfPQmc1ONRzRaj6VIhb4/2LxPwx5ZeSKWaNBw32RkC5+9nqd8idmihtid4oKfhg==
X-Received: by 2002:a17:902:f7d1:b0:1bb:3406:a612 with SMTP id
 h17-20020a170902f7d100b001bb3406a612mr2560052plw.57.1692374363479; 
 Fri, 18 Aug 2023 08:59:23 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:cf24:6daf:2b9e:7972?
 ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 x21-20020a170902ea9500b001bc39aa63ebsm1932046plb.121.2023.08.18.08.59.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 08:59:23 -0700 (PDT)
Message-ID: <64b018a9-917b-0f83-9d8c-1491f0d676dd@linaro.org>
Date: Fri, 18 Aug 2023 08:59:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/4] target/loongarch: Rename 64-bit specific functions
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Jiajie Chen <c@jia.je>
References: <20230818103425.16271-1-philmd@linaro.org>
 <20230818103425.16271-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230818103425.16271-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.454,
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

On 8/18/23 03:34, Philippe Mathieu-Daudé wrote:
> These functions are specific to loongarch64 cores. Rename
> including the '64' suffix in preparation of supporting
> loongarch32 cores.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/loongarch/cpu.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index dc617be36f..19572e37ad 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -76,7 +76,7 @@ void G_NORETURN do_raise_exception(CPULoongArchState *env,
>       cpu_loop_exit_restore(cs, pc);
>   }
>   
> -static void loongarch_cpu_set_pc(CPUState *cs, vaddr value)
> +static void loongarch64_cpu_set_pc(CPUState *cs, vaddr value)
>   {
>       LoongArchCPU *cpu = LOONGARCH_CPU(cs);
>       CPULoongArchState *env = &cpu->env;
> @@ -84,7 +84,7 @@ static void loongarch_cpu_set_pc(CPUState *cs, vaddr value)
>       env->pc = value;
>   }
>   
> -static vaddr loongarch_cpu_get_pc(CPUState *cs)
> +static vaddr loongarch64_cpu_get_pc(CPUState *cs)
>   {
>       LoongArchCPU *cpu = LOONGARCH_CPU(cs);
>       CPULoongArchState *env = &cpu->env;
> @@ -356,7 +356,7 @@ static bool loongarch_cpu_has_work(CPUState *cs)
>   #endif
>   }

Not 64-bit specific.


r~

