Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3698F744C6B
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 08:13:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFqJS-00025L-VY; Sun, 02 Jul 2023 02:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFqJQ-00025D-QS
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 02:11:56 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFqJP-0004af-2b
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 02:11:56 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fbab0d0b88so27196075e9.0
 for <qemu-devel@nongnu.org>; Sat, 01 Jul 2023 23:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688278312; x=1690870312;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CrYWJHPWwT1D2stiXXy4saxLqIvQivug7B/RJ9s8HQ4=;
 b=ufdp9szN+mb5jBBNbTGEdddZxFLMqW/fqGgWzs7CEtyumvK7+eig9kWl6XXlgE0Vvs
 0idTz7ypOv7YXKKcFIUqRQh5Hw9688KrtHVN/t5/r5oohVnS/Bk+e3SRw8ECtcz/xQzk
 EQDlom+yUKRcGZu6qIybYSgUgdOTclHnIyURlvhr7zDpY5SoOTM/cKNldF3bIrln9ieC
 yUzcmEIV3yyyGont9Qs+e6ZJz/MUeSQ5JQ4Y+N8/PKKSOw+rquXv1YqVr2+vPAx9ebRV
 wQ9wyU62CmE411xGcK+8bc1TyA5NTuhMDXKimhHss+e4lFMReRh9YVzSOaDqO5SEcvhD
 2fCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688278312; x=1690870312;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CrYWJHPWwT1D2stiXXy4saxLqIvQivug7B/RJ9s8HQ4=;
 b=F/b5JDZFzKke0UnpG/0OvarQjcCG2AQNsrOUrhcSt0K9sv41p8Kjlx5KGZYSxk09c0
 FrkGiknKZHQItThciQ1wEDHIJXPQ2xzAmeljd8qyvdvhhMrcdu7v7NZAMtpTsi4HtKHf
 Ae6I5eLjY/B/267WA9WzT8wl7b7T+7soWHo46Sl3DBhw4u6RzvCCeZY0lUWFktorK+4L
 9DpobK3O1ph2WZf3T/ILDgEfDJzYZAh3M/r/wx6Sp3D015+WeEvITQOwczc9rXxNGnA9
 g+PUlj35IkOOtVwovHi0oDgA7fdQFNj7as1pB786F8VQuo3b5EbL2ENfPJYDg6fxN3Up
 qnjg==
X-Gm-Message-State: AC+VfDyyVtjB0dfEuqhUlbQkc8tfrow8FxTyTvKimFN0DzigqUurC55l
 RAj6rc7SP/2epQAGHRZCS0MFXepP2orCcODmlW/iwA==
X-Google-Smtp-Source: ACHHUZ5n5MmaOL4W6KCfOHpbFZVwmtkyeGkNWHezux9oTQdEn8LbSgcq1ewPGQbAKXPThGkGM3Nlqg==
X-Received: by 2002:a05:600c:84c7:b0:3f9:c9f4:acf1 with SMTP id
 er7-20020a05600c84c700b003f9c9f4acf1mr10207003wmb.7.1688278312175; 
 Sat, 01 Jul 2023 23:11:52 -0700 (PDT)
Received: from [192.168.1.25] (91.232.79.188.dynamic.jazztel.es.
 [188.79.232.91]) by smtp.gmail.com with ESMTPSA id
 n19-20020a7bc5d3000000b003fbd04ecdc6sm3232139wmk.5.2023.07.01.23.11.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jul 2023 23:11:51 -0700 (PDT)
Message-ID: <5eb0a8b4-d5ff-7fdf-f509-bd7aaf05a8c9@linaro.org>
Date: Sun, 2 Jul 2023 08:11:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 09/46] target/loongarch: Implement xvhaddw/xvhsubw
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230630075904.45940-1-gaosong@loongson.cn>
 <20230630075904.45940-10-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630075904.45940-10-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/30/23 09:58, Song Gao wrote:
> --- a/target/loongarch/lsx_helper.c
> +++ b/target/loongarch/vec_helper.c
> @@ -14,20 +14,18 @@
>   #include "tcg/tcg.h"
>   #include "vec.h"
>   
> -#define DO_ADD(a, b)  (a + b)
> -#define DO_SUB(a, b)  (a - b)
> -
>   #define DO_ODD_EVEN(NAME, BIT, E1, E2, DO_OP)                        \
> -void HELPER(NAME)(CPULoongArchState *env,                            \
> +void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz,            \
>                     uint32_t vd, uint32_t vj, uint32_t vk)             \
>   {                                                                    \
> -    int i;                                                           \
> +    int i, len;                                                      \
>       VReg *Vd = &(env->fpr[vd].vreg);                                 \
>       VReg *Vj = &(env->fpr[vj].vreg);                                 \
>       VReg *Vk = &(env->fpr[vk].vreg);                                 \
>       typedef __typeof(Vd->E1(0)) TD;                                  \
>                                                                        \
> -    for (i = 0; i < LSX_LEN/BIT; i++) {                              \
> +    len = (oprsz == 16) ? LSX_LEN : LASX_LEN;                        \
> +    for (i = 0; i < len / BIT ; i++) {                               \
>           Vd->E1(i) = DO_OP((TD)Vj->E2(2 * i + 1), (TD)Vk->E2(2 * i)); \
>       }                                                                \
>   }

It would be better to use the gen_helper_gvec_3 function signature:

void HELPER(name)(void *vd, void *vj, void *vk, uint32_t desc)
{
     VReg *Vd = vd, ...;
     int oprsz = simd_oprsz(desc);

     for (i = 0; i < oprsz / (BIT / 8); i++) {
         ...
     }
}

You should do the file rename and the conversion of the existing LSX operations in a 
separate patch.

> @@ -44,13 +42,17 @@ void HELPER(vhaddw_q_d)(CPULoongArchState *env,
>       VReg *Vk = &(env->fpr[vk].vreg);
>   
>       Vd->Q(0) = int128_add(int128_makes64(Vj->D(1)), int128_makes64(Vk->D(0)));
> +    if (oprsz == 32) {
> +        Vd->Q(1) = int128_add(int128_makes64(Vj->D(3)),
> +                              int128_makes64(Vk->D(2)));
> +    }

Better as a loop, and all the rest.


r~

