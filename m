Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8073720DA7
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 05:37:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5I3u-0002NR-2p; Fri, 02 Jun 2023 23:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5I3s-0002Mw-2y
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 23:36:16 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5I3q-0006d7-Cl
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 23:36:15 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-651e298be3fso2367927b3a.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 20:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685763373; x=1688355373;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mDsfvf1+p0GoT0FUE1p6K4Sj2425cLlNDFN+q1Wg/PI=;
 b=LwynO/YBL05ke2QwBtnzClH6Cdza5ZR+xkGZcdrIJgqSAT3PFczQcB0F+XVSCOu34D
 hKcrUQmR+n+1fc7C8gu91qyFHNyAfa6e3gFQ8o4yJ++t9V9u3oDgwTR4vkj4gQxwMJ8I
 Zfcy7dK2RcEX7tUiHqFnZbgORdvJb6p5bXj+R2d80rQyL1VQHM94s99MUbPPAQWoVhZM
 Tei8lYW/VfHPe6nvFL8BV14RSrAUHm51hF+UkttsTUrOHHO5un2wolyfoRFiZqJoY2GC
 TjMtEv1YMGgv2OFWpPfPbUjhsLTQ0vE8z+l0AC9+hzfJPIBcThsSMbrOvCYWtCv/pEYh
 lY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685763373; x=1688355373;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mDsfvf1+p0GoT0FUE1p6K4Sj2425cLlNDFN+q1Wg/PI=;
 b=NuLJgSnpen8nyA8Ox9O5ChP67f/ThdTnbKkE5ItfiOpNCHTd7ZoaRdqncMcBPdhTd/
 uYA18a0xQDJsiyAxb1W3UDms8s1gJRCBXIjQ+xelm2+HwPH4Ilb9/aWw4qXmDgsjfSLW
 FcVxEjjObvoTkzZXNT92TRNyexA7ZcZoJ04xNZB8RGNd7E5JC3+K16YvzTHQsZ+VdtDu
 lw/PR5E1srmQow8XWIw7O27nrm7GF5QQMrdMKTtaFJYra1EjMVqFbccX+hhHlNWkTghQ
 Df2dHTv3vfRpSfzgKyeyDUwN1/ibegm2bfm9aNIyGggWbqZoj7BbWEpIZf9bTb13aMl3
 RcUg==
X-Gm-Message-State: AC+VfDzqYyPK5txIv3SQ5KEuh6MdKcaK68P6avYDVpMWrgMgL3lt/tDw
 hxiVIv2w4l0potS2uorYMKE6iw==
X-Google-Smtp-Source: ACHHUZ45712OCqLrVT8GQIk7lPMTJ0RrYkCPuAfqjXPCFIAHtE+xBSO55Ja1LR8mXvhKO6I22qoDiw==
X-Received: by 2002:a05:6a21:2d8d:b0:10c:9e35:857a with SMTP id
 ty13-20020a056a212d8d00b0010c9e35857amr568914pzb.49.1685763372664; 
 Fri, 02 Jun 2023 20:36:12 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:66a6:82c2:d794:68f6?
 ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a62b616000000b00642c5ef6050sm1631899pff.173.2023.06.02.20.36.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 20:36:12 -0700 (PDT)
Message-ID: <2efebc48-1180-6220-cda7-ec9503a2e416@linaro.org>
Date: Fri, 2 Jun 2023 20:36:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] target/arm: Fix return value from LDSMIN/LDSMAX 8/16 bit
 atomics
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20230602142219.1999756-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602142219.1999756-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/2/23 07:22, Peter Maydell wrote:
> The atomic memory operations are supposed to return the old memory
> data value in the destination register.  This value is not
> sign-extended, even if the operation is the signed minimum or
> maximum.  (In the pseudocode for the instructions the returned data
> value is passed to ZeroExtend() to create the value in the register.)
> 
> We got this wrong because we were doing a 32-to-64 zero extend on the
> result for 8 and 16 bit data values, rather than the correct amount
> of zero extension.
> 
> Fix the bug by using ext8u and ext16u for the MO_8 and MO_16 data
> sizes rather than ext32u.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index 741a6087399..075553e15f5 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -3401,8 +3401,22 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
>        */
>       fn(tcg_rt, clean_addr, tcg_rs, get_mem_index(s), mop);
>   
> -    if ((mop & MO_SIGN) && size != MO_64) {
> -        tcg_gen_ext32u_i64(tcg_rt, tcg_rt);
> +    if (mop & MO_SIGN) {
> +        switch (size) {
> +        case MO_8:
> +            tcg_gen_ext8u_i64(tcg_rt, tcg_rt);
> +            break;
> +        case MO_16:
> +            tcg_gen_ext16u_i64(tcg_rt, tcg_rt);
> +            break;
> +        case MO_32:
> +            tcg_gen_ext32u_i64(tcg_rt, tcg_rt);
> +            break;
> +        case MO_64:
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }

This reminds me that we have a function in tcg to handle this switch, but it isn't 
exposed.  I keep meaning to do that...

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

