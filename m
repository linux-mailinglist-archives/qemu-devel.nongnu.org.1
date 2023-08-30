Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7129378D7EC
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 20:07:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbPaU-0002Kv-F1; Wed, 30 Aug 2023 14:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbPaS-0002Kk-BD
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 14:06:40 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbPaP-0003mH-O9
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 14:06:40 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c0ecb9a075so26145525ad.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 11:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693418796; x=1694023596; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wDL4orI0+7bv1IvD/7NcuUQfbs8uxMO+ots1NTtsaBo=;
 b=nXvJkOauJltMZdboY7/sNjMGWGZh7dKBZy7y5MVz3bJMzLhWzURPEdDhhFKNT2vUHW
 94sdk0bnIeURH08kmKKxYKdl4GgX1avjsq6VtNPO1gs1bSwJdVvELsW94ZZKw6D/mj/J
 8hZJpa8lpgdo7r/05HkLhvspJd9nmiJvesKGC7VwWvqmlKQ0uYSYEiU0ONp7sy6t4OJ7
 Wwa08qKzgOAHXRIbd3NKr5BYbq60jb1w5BoovJZTVcZZWK9rLHo/g1Rf5LhyAW7dXn+K
 JkptUYEaAXRvosLSv5YyBue5zM8WqxooHRIXys317GXxgeYUJfpWVJKKygbQZGR2dCR2
 tdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693418796; x=1694023596;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wDL4orI0+7bv1IvD/7NcuUQfbs8uxMO+ots1NTtsaBo=;
 b=XVpeKWTTnGXuye3ntZCtld7Dj7FCNhiBJ30X2Gxp1MF3VoN9X0yMp3m1hiUBlENvQO
 MgqI1fq0LTU/Uo7Q0hmkSMQK6GmAxmG2A3lkVzNMY6OPxetbK4IUBV6hfafaK7Y88Zv8
 RfjXnd0XPTI9wWssu+vrkHefHgV2C80MOaIG/PWjyF3cuQh//Xba8P/sfa7jK1IzDK+a
 PlJENUAzkuRa5dUpSXqAUczoLeYFbVyOhYvSMdmJzPCfu6cWIKmORQYr6feQIlaniweX
 JOm9zrL9C3sHEH/in9sBfM60+ZwkWUKbcBcfqQaJgnb8OtQ1xHWxEJPr0P9+rI9g7HiX
 DUxg==
X-Gm-Message-State: AOJu0YwRs0GZb9wePdxj9ZqRSH2FIN7Sw6TGh86o871AT65u2EqJovgt
 ZAy3xPx1e6PiTT2Xsw2z8+tCKWNlXq1jgYwlh5g=
X-Google-Smtp-Source: AGHT+IH7sxL73JnmM3K+RWOucAwu0Qg8MM+Z3FGb9moOtywI3wWlcOwpCBy3FRe7FvrCFhLPlg8vlA==
X-Received: by 2002:a17:902:d902:b0:1bd:ba57:5a8f with SMTP id
 c2-20020a170902d90200b001bdba575a8fmr2754816plz.13.1693418795797; 
 Wed, 30 Aug 2023 11:06:35 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a170902dace00b001aadd0d7364sm11405900plx.83.2023.08.30.11.06.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 11:06:35 -0700 (PDT)
Message-ID: <74a0aeda-fc07-6e04-092b-772ef154e83a@linaro.org>
Date: Wed, 30 Aug 2023 11:06:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 10/48] target/loongarch: rename lsx_helper.c to
 vec_helper.c
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-11-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-11-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/30/23 01:48, Song Gao wrote:
> Use gen_helper_gvec_* series function.
> and rename lsx_helper.c to vec_helper.c.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/helper.h                     |  642 ++++----
>   .../loongarch/{lsx_helper.c => vec_helper.c}  | 1297 ++++++++---------

These changes are fine, but should be split.

The helper changes can be done with only minimal changes

>   target/loongarch/insn_trans/trans_lsx.c.inc   |  731 +++++-----

here, rather than to 700+ lines at once.

> -static bool gen_vvvv(DisasContext *ctx, arg_vvvv *a,
> -                     void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32,
> -                                  TCGv_i32, TCGv_i32))
> +static bool gen_vvvv(DisasContext *ctx, arg_vvvv *a, int oprsz,
> +                     gen_helper_gvec_4 *fn)

If you omit the oprsz argument within this patch,

> +    tcg_gen_gvec_4_ool(vec_full_offset(a->vd),
> +                       vec_full_offset(a->vj),
> +                       vec_full_offset(a->vk),
> +                       vec_full_offset(a->va),
> +                       oprsz, ctx->vl / 8, oprsz, fn);

hard-coding 16 here instead,

> -TRANS(vhaddw_h_b, LSX, gen_vvv, gen_helper_vhaddw_h_b)
> +TRANS(vhaddw_h_b, LSX, gen_vvv, 16, gen_helper_vhaddw_h_b)

then you do not need all of these changes.

At which point I'll refer you back to my comments vs patches 5 and 6, wherein separate 
gen_vvv and gen_xxx helpers would avoid the need to replicate 16 across all of these lines.


r~

