Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1658D7D17EC
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 23:20:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwu6-0000TD-9Y; Fri, 20 Oct 2023 17:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtwu0-0000SO-6P
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 17:19:29 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtwty-0008F4-2q
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 17:19:27 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9c2a0725825so193808666b.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 14:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697836764; x=1698441564; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ib+JITab3xwyMO1LJ0opSISh0jTZte2Lbb5Da/hyI+k=;
 b=eSkEIR0WsuJA7IlxG/I4W8c6UqhedciTd0cClTitDvIEF3jI3ftRgBmcoVuiJLz4Q/
 QxeZ8Tbohe1TPHYSjGGBymid6VP+vTPTVG5tPnXNJACEiRHZfCmOhwdAEk4khrg0xCzY
 BURoGkyCDq4Egr6jYIT4As7GLKjiTA+xBMesXZiaS6KlAmjzo/y2Ftq+dabi34SI5MV9
 RDBv3uIkwLlxwwO6ipe6s1CcTrABjjRi7fWBYeDgrEqk5ll4+dHMRfzR1GJiU9xH4Oev
 ln1qY5536MZRT+CvyVanJf5mTUt5Ay2aIMH3JQ4DeO0gNaGhnXG1dw1gLmsgXOORcSeC
 t9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697836764; x=1698441564;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ib+JITab3xwyMO1LJ0opSISh0jTZte2Lbb5Da/hyI+k=;
 b=NnVLDGz9dyI3uOWkxyV3Y5NIquVcqtGPF1n8JrhTderUjZ7Z2GbGM7RGKxEvW7bVzV
 rZVC9enyjpxsWFasgvZnu08sNLqign5JrfoP20Y8qBd9iUhSGJi6PFDXTG+Gly0MB4Lb
 dy/pI71n5czecULKGQ39NJDkrvW7xRk8oRG+3EZvQ7Iu0LaIP552FEE/VBaZeY0Ioe3E
 FVshRYTOKUVJeip8j5+BkDeb/s8RtMRtQg+GlLHGxaUZtvNgxNmm2YtXdAVrKXHsN/qG
 /nQiYZTiu2NCgwJtvQL1Kl6rfewN8mcsQeShLvPG9MpYfIy7nurNhuskreC+OZLeTIiy
 S/Rw==
X-Gm-Message-State: AOJu0YxLYrDwpZyt7ZvbfSlYtNK3JFrC8bmrMQi0ynrCFRHps3mDtfh0
 BzmEHqlBhFHUdSCrNjOOqmJr+A==
X-Google-Smtp-Source: AGHT+IFUgKjpEdhH9MtHDJ0JXZhB8mnoGzHoSt40xwBgDZnXR3iR7zE+irqeRr5PAwIbiZ9hsBOwAw==
X-Received: by 2002:a17:906:fe04:b0:9c4:8a30:8428 with SMTP id
 wy4-20020a170906fe0400b009c48a308428mr2035874ejb.47.1697836764162; 
 Fri, 20 Oct 2023 14:19:24 -0700 (PDT)
Received: from [192.168.69.115] (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 f26-20020a170906085a00b009ad8796a6aesm2196210ejd.56.2023.10.20.14.19.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 14:19:23 -0700 (PDT)
Message-ID: <3a5c1f46-9dda-ec60-1f08-a65a2391c0c6@linaro.org>
Date: Fri, 20 Oct 2023 23:19:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 13/65] target/hppa: Introduce TYPE_HPPA64_CPU
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20231020204331.139847-1-richard.henderson@linaro.org>
 <20231020204331.139847-14-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231020204331.139847-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 20/10/23 22:42, Richard Henderson wrote:
> Prepare for the qemu binary supporting both pa10 and pa20
> at the same time.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/cpu-qom.h   |  1 +
>   target/hppa/cpu.h       |  5 +++++
>   target/hppa/cpu.c       | 34 +++++++++++++++++++---------------
>   target/hppa/translate.c |  2 ++
>   4 files changed, 27 insertions(+), 15 deletions(-)


> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index 1644297bf8..192aae268d 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -207,20 +207,24 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
>       cc->tcg_ops = &hppa_tcg_ops;
>   }
>   
> -static const TypeInfo hppa_cpu_type_info = {
> -    .name = TYPE_HPPA_CPU,
> -    .parent = TYPE_CPU,
> -    .instance_size = sizeof(HPPACPU),
> -    .instance_align = __alignof(HPPACPU),
> -    .instance_init = hppa_cpu_initfn,
> -    .abstract = false,
> -    .class_size = sizeof(HPPACPUClass),
> -    .class_init = hppa_cpu_class_init,
> +static const TypeInfo hppa_cpu_type_infos[] = {
> +    {
> +        .name = TYPE_HPPA_CPU,
> +        .parent = TYPE_CPU,
> +        .instance_size = sizeof(HPPACPU),
> +        .instance_align = __alignof(HPPACPU),
> +        .instance_init = hppa_cpu_initfn,
> +        .abstract = false,
> +        .class_size = sizeof(HPPACPUClass),
> +        .class_init = hppa_cpu_class_init,
> +    },
> +#ifdef TARGET_HPPA64
> +    {
> +        .name = TYPE_HPPA64_CPU,
> +        .parent = TYPE_HPPA_CPU,
> +        .instance_init = hppa64_cpu_initfn,

hppa64_cpu_initfn() is never declared and removed in patch #29,
remnant from old branch? Otherwise,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

(and thanks for converting to DEFINE_TYPES).

> +    },
> +#endif
>   };


