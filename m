Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFE678077E
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 10:52:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWvD7-0003qB-CD; Fri, 18 Aug 2023 04:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWvD5-0003q0-39
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 04:51:59 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWvD0-0003SM-L8
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 04:51:58 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4fe48d0ab0fso900110e87.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 01:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692348713; x=1692953513;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9ct5v1vsopfYbpIktsovlfO/wAJ1jigcygAVVqsEsCE=;
 b=EOY35TczKA1Nk1OzEnUxGAfBaCJOqcWkj+WolOg9OfYy/CuKiBvtSH5lSodWEazb4a
 nfUqdLdXv10SbHbxTQDWtVylVXesxuIsp46GwAUQf961j+BrehroL23CGL4PXI00y3uh
 j3zpP0Wy19OB2wbtC3rZVJJvcMjlEMXS9fgwgvS5XSiDX9SpakaPQK7GswoPeUlhrbMD
 psTF1fKpaHXwrD+JJVbxPFpk+RCuFX0J9LhLwKcI8+CMKIaO1Le+5QGLy5mSMUnKaZ5l
 Rc1RFfBMEAKvARMzvHIa4NPpUV+ZUskb5FKJn+sqFvPbi5WzwijZx4SgJ3UCeJOcIfle
 /cPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692348713; x=1692953513;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9ct5v1vsopfYbpIktsovlfO/wAJ1jigcygAVVqsEsCE=;
 b=VaCPsc1Z3svMZf2OnV7x+gygOvjvHrlE7cLdQ9KMlUJifwFRnHylrPBlaABvc2M436
 kQzO7xR/NhXL4ont2TBsOzIj6/OrQckwVUhGPgOHIkhZikT11swTPNmTu5Q0MFZa8kTh
 GtTX5zxl7LkrevqGGGOPhZ4vKxWFeRPrbDiYVu911ddixS4ljm7QQ50H2PP7DgH0/gu5
 LuRHfA8/0kJ3NEL7SuhrwrxA720+OE2HqNz2Bmvwe7cM5mhDLgE1lBLJCcbTm5eFoQzt
 WFuarRBys+WmFOtj9pQOjWG1UX6sWeRLnbKiiGW+EuX8CHl/P3FJvXL+nu7yHrNeiipG
 QqCQ==
X-Gm-Message-State: AOJu0YxaddPysw0H9W2nUWbxXnPCSZWdCH81BoobF5aDymKej6lQ0Tfa
 tsbr/28y4LA07l1P2UhEZsU8upyQp4LgvtvGFak=
X-Google-Smtp-Source: AGHT+IHpYWs1U6lvO5hnijnG1pqokKawpKQDu9srrO53ySwA/YPR00tabIcvhv3ed7CVeteQU5e7AA==
X-Received: by 2002:a05:6512:b96:b0:4fb:94c6:fd63 with SMTP id
 b22-20020a0565120b9600b004fb94c6fd63mr1558719lfv.17.1692348712518; 
 Fri, 18 Aug 2023 01:51:52 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.184.114])
 by smtp.gmail.com with ESMTPSA id
 z12-20020aa7cf8c000000b005256d4d58a6sm840324edx.18.2023.08.18.01.51.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 01:51:52 -0700 (PDT)
Message-ID: <05e574af-50e0-e71c-2e88-ab7fafd71155@linaro.org>
Date: Fri, 18 Aug 2023 10:51:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 02/18] target/loongarch: Add new object class for
 loongarch32 cpus
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>,
 richard.henderson@linaro.org, Jiajie Chen <c@jia.je>
Cc: qemu-devel@nongnu.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn,
 yijun@loongson.cn, shenjinyang@loongson.cn
References: <20230817093121.1053890-1-gaosong@loongson.cn>
 <20230817093121.1053890-3-gaosong@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230817093121.1053890-3-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

Hi Jiajie, Song,

(+Huacai)

On 17/8/23 11:31, Song Gao wrote:
> From: Jiajie Chen <c@jia.je>
> 
> Add object class for future loongarch32 cpus. It is derived from the
> loongarch64 object class.

Is it how the architecture design happened? IIUC per [*] it seems
the arch was designed as a whole then adapted per segment (32/R,64).
So from a QOM PoV better would be to have a abstract 'common' parent
objs/classes, then derive 32/64 from it.
IMHO this matters for the maintainability of target/loongarch/, but
if this isn't important then I won't object much to this series.

Regards,

Phil.

[*] 
https://lore.kernel.org/linux-arch/20210706041820.1536502-1-chenhuacai@loongson.cn/

> Signed-off-by: Jiajie Chen <c@jia.je>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/cpu.c | 19 +++++++++++++++++++
>   target/loongarch/cpu.h |  1 +
>   2 files changed, 20 insertions(+)


> @@ -750,6 +760,15 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
>           .class_size = sizeof(LoongArchCPUClass),
>           .class_init = loongarch_cpu_class_init,
>       },
> +    {
> +        .name = TYPE_LOONGARCH32_CPU,
> +        .parent = TYPE_LOONGARCH_CPU,
> +        .instance_size = sizeof(LoongArchCPU),
> +
> +        .abstract = true,
> +        .class_size = sizeof(LoongArchCPUClass),
> +        .class_init = loongarch32_cpu_class_init,
> +    },
>       DEFINE_LOONGARCH_CPU_TYPE("la464", loongarch_la464_initfn),
>   };
>   
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 5a71d64a04..2af4c414b0 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -382,6 +382,7 @@ struct ArchCPU {
>   };
>   
>   #define TYPE_LOONGARCH_CPU "loongarch-cpu"
> +#define TYPE_LOONGARCH32_CPU "loongarch32-cpu"
>   
>   OBJECT_DECLARE_CPU_TYPE(LoongArchCPU, LoongArchCPUClass,
>                           LOONGARCH_CPU)


