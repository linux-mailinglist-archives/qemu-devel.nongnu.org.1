Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 213677229CB
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 16:51:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6BXa-0006qO-Pu; Mon, 05 Jun 2023 10:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6BXT-0006mD-Bq
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 10:50:32 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6BXR-0005wy-DD
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 10:50:30 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-30aea656e36so4066036f8f.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 07:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685976627; x=1688568627;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=INd3xj2HjCQeZy2RoCxlMHmqMkPCld9F6WHYJy7VYds=;
 b=Drv813+m9g7K+idvxwWb5wmScI957CzuheokEZeSwo9s2yu4y7ggAAmwncJQQrcIeT
 Ans3N1sN6xi2HBljZsyqB1PgYrgBFmSksRz9KZ9cnP+lV55zY/HfDUqDWHhgCckaZRfm
 qMkKuj7xs+qs8G8OWEVyMheqnGP3wA+fOcLs4QoakdNa4BgB1sSteXzIh+YcZqDUNmkF
 zTYslrKuihiu65QZir76aLmj8tY93sUHquM7c86k5AgwNAjtT7k0Ym4f6NPdN7/PU9Dy
 aAKDLfPqmvsSXpRQWR7UpAvqTWGb9Pvc/iLOR+AV9Toov7+ibD4h4GicOMtQXfouxpgy
 CJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685976627; x=1688568627;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=INd3xj2HjCQeZy2RoCxlMHmqMkPCld9F6WHYJy7VYds=;
 b=IdgITFYYZtUOgEBQHU6WHye/hEufc3XG5c8h97bjoFz0yyQwZn/+oB9F19u49Xw3Ii
 8APZTqQEA1qSrlLZ2kYgO3O8bQslBYhTLNwYbul7+KFSHa2snzosIQuGhkCagbnUUESB
 /w2sAhDLHZxOxmBOx7HQnpDiEFProktixb8e+2Cgh4cH7htlQwovRuFGlBdpFAFY8v5+
 i5M2NCce9yQC3FUMnYvlZEKWirFjdOmVDYXCocXfk5VTdNm7ef+E/p6jz34J02IZiBQC
 e+oSUYCutBT0YUoms0UAijawl4iJUlU7fjxlGq01hzx9NxAiWLfRHSXypIb3C93ll1KT
 qn3A==
X-Gm-Message-State: AC+VfDywgy8umvWJdwmpHJ+VqJ5uPPYylYGkjxyvCCD2xFeuNhRRLNZs
 y13VmFQHKN0sn+/HDjdeaD3oew==
X-Google-Smtp-Source: ACHHUZ49Rz/EmVHTdWwQk7njc1hzYR8rwctW2DCCKeGPhx3m/SYD74QxqiDOTkAp/EBA5R1Aq9GXwQ==
X-Received: by 2002:adf:dc01:0:b0:30a:ee20:249a with SMTP id
 t1-20020adfdc01000000b0030aee20249amr4641907wri.6.1685976627651; 
 Mon, 05 Jun 2023 07:50:27 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a5d650b000000b00307972e46fasm9924941wru.107.2023.06.05.07.50.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 07:50:27 -0700 (PDT)
Message-ID: <82dc9979-ad75-c09b-2d76-ae20bab36085@linaro.org>
Date: Mon, 5 Jun 2023 16:50:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] target/sh4: Emit insn_start for each insn in gUSA region
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ysato@users.sourceforge.jp, Anton Johansson <anjo@rev.ng>
References: <20230603165530.1189588-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230603165530.1189588-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 3/6/23 18:55, Richard Henderson wrote:
> Fixes an assert in tcg_gen_code that we don't accidentally
> eliminate an insn_start during optimization.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> Test case is tests/tcg/multiarch/testthread.c; the assert for
> equality is new with
> 
> https://lore.kernel.org/qemu-devel/20230531040330.8950-26-richard.henderson@linaro.org/

Cc'ing Anton.

> 
> 
> r~
> ---
>   target/sh4/translate.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index efd889d9d3..49c87d7a01 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -2144,9 +2144,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
>   
>       /* The entire region has been translated.  */
>       ctx->envflags &= ~TB_FLAG_GUSA_MASK;
> -    ctx->base.pc_next = pc_end;
> -    ctx->base.num_insns += max_insns - 1;
> -    return;
> +    goto done;
>   
>    fail:
>       qemu_log_mask(LOG_UNIMP, "Unrecognized gUSA sequence %08x-%08x\n",
> @@ -2163,8 +2161,19 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
>          purposes of accounting within the TB.  We might as well report the
>          entire region consumed via ctx->base.pc_next so that it's immediately
>          available in the disassembly dump.  */
> +
> + done:
>       ctx->base.pc_next = pc_end;
>       ctx->base.num_insns += max_insns - 1;
> +
> +    /*
> +     * Emit insn_start to cover each of the insns in the region.
> +     * This matches an assert in tcg.c making sure that we have
> +     * tb->icount * insn_start.
> +     */
> +    for (i = 1; i < max_insns; ++i) {
> +        tcg_gen_insn_start(pc + i * 2, ctx->envflags);
> +    }
>   }
>   #endif
>   


