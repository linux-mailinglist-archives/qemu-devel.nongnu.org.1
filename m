Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E49F0774069
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:02:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQ5r-0006oT-2F; Tue, 08 Aug 2023 13:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTQ5l-0006ni-Bs
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:01:57 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTQ5j-0001Je-6b
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:01:57 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bb9e6c2a90so51520115ad.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691514114; x=1692118914;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xmzDpmTTwpXam9wqXKNk57K30hO9VOQ5tB1eaQaTSOU=;
 b=j4vYLcZwUaofVU7+hiw2zz4ZZtBUYv48Poqh5SobhxOfWzhbp15f36MmHV9BhHJfxe
 fVL9Npy9yi9k4xoov9YZtQo+pCnH1uP+0ZwjOUpf2waczdWB3iTPG28Ph7Z+REQ+eiqD
 6de6ld9MGAELVLZJwG78KCqVpr0RW+Jswm0qv8Tv6hJraHJikyj4EFF28MFgmocg/2Bx
 y1Br+y7E3gnl2UbBxMDYXAk8vz4vICqZBKv0G/CfKFReB5IfDYgITHNEN+woICvall2N
 tC1hFe6vvRh2OB0lYiJSeh3i+KKuxGYGJptqLhlbbbUL8mY+8XIxR5hskt8Ug99Gcwh9
 Hhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514114; x=1692118914;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xmzDpmTTwpXam9wqXKNk57K30hO9VOQ5tB1eaQaTSOU=;
 b=jiFubSaSDpQjz5ZwT2kE13tx9eMlGKOeAhd6HYLwi1AHF7TydUaFszQ4u7NuKR6HSY
 rKIloT2fALZ5JQAV3yZHb4s1DBSnOM9vVxSSDF2tEuutD/DMHC46UXcDcQ3VTB00lWBl
 RstyapTDzBii2egtFEmhVe3eUzzibOX1FE2SsT3qJUuV79LziKqrPr69roqrYPsT4Ll6
 XLmnPMS8CX1WI4rsLha3vnFhph59K69V/N9wuQTb6l3st4UmiM7Os+Ilvyu/9HQFiGof
 CL84iKU+fsr/OYh1hblQPpQBn/3mR79TpswzVXzIYH0ndBnqxlAtkYi6nxjRi4sLlfCj
 bIlA==
X-Gm-Message-State: AOJu0YywqyEwHFNKEBPbQB69NvsEJdJMlgCKL0X4JmfMmfk9nv/g4soB
 F7in0Jjb2HhkNSWff8KHSwjc3g==
X-Google-Smtp-Source: AGHT+IFq2C4/30U+MjmQ5li0bWG4Ro6H0Prp3w/LVmq//oG0XknhdRG67pArSAqQ1jprD5QaYIQQrA==
X-Received: by 2002:a17:903:44a:b0:1bb:cf4e:ccd with SMTP id
 iw10-20020a170903044a00b001bbcf4e0ccdmr256674plb.28.1691514113447; 
 Tue, 08 Aug 2023 10:01:53 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 w21-20020a170902a71500b001b558c37f91sm9231257plq.288.2023.08.08.10.01.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 10:01:53 -0700 (PDT)
Message-ID: <68c43230-1198-5d46-5450-26b8f61bd09b@linaro.org>
Date: Tue, 8 Aug 2023 10:01:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 01/11] target/loongarch: Add macro to check current arch
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, gaosong@loongson.cn,
 i.qemu@xen0n.name
References: <20230808015506.1705140-1-c@jia.je>
 <20230808015506.1705140-2-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808015506.1705140-2-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/7/23 18:54, Jiajie Chen wrote:
> Add macro to check if the current cpucfg[1].arch equals to 1(LA32) or
> 2(LA64).
> 
> Signed-off-by: Jiajie Chen <c@jia.je>
> ---
>   target/loongarch/cpu.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index fa371ca8ba..bf0da8d5b4 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -132,6 +132,13 @@ FIELD(CPUCFG1, HP, 24, 1)
>   FIELD(CPUCFG1, IOCSR_BRD, 25, 1)
>   FIELD(CPUCFG1, MSG_INT, 26, 1)
>   
> +/* cpucfg[1].arch */
> +#define CPUCFG1_ARCH_LA32        1
> +#define CPUCFG1_ARCH_LA64        2
> +
> +#define LOONGARCH_CPUCFG_ARCH(env, mode) \
> +  (FIELD_EX32(env->cpucfg[1], CPUCFG1, ARCH) == CPUCFG1_ARCH_##mode)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

But in using this recall that 0 is a defined value for "simplified la32", so

    !LOONGARCH_CPUCFG_ARCH(env, LA64)

may not in future equal

    LOONGARCH_CPUCFG_ARCH(env, LA32)

it someone ever decides to implement this simplified version. (We emulate very small 
embedded Arm cpus, so it's not out of the question that you may want to emulate the very 
smallest LoongArch cpus.)

It might be easier to just define

static inline bool is_la64(CPULoongArch64 *env)
{
     return FIELD_EX32(env->cpucfg[1], CPUCFG1, ARCH) == CPUCFG1_ARCH_LA64;
}


r~

