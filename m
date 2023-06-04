Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D523472186E
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 18:07:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5qEU-0002fN-N7; Sun, 04 Jun 2023 12:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5qEQ-0002eH-H4
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 12:05:26 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5qEO-0001WJ-Pb
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 12:05:26 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5552cbcda35so2715611eaf.1
 for <qemu-devel@nongnu.org>; Sun, 04 Jun 2023 09:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685894722; x=1688486722;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L6cneyvOvNrAv6rJfZCBCpJ/iG065yClEwCDc+5zbIA=;
 b=pWfZJnvRLFmaxbxxrbl41qgtaoe+NgUgb4vy2QL5ZFIvcVgVk1msvxg1f458WNURai
 MBod6fuV2Eb7JlNdHCwKnEyJRvE42NBcBmoNIQxQ9U94sxB/juYFWvBitp9gnXvjVpqA
 0q3uzpeO7cpGAH84R4K9k2kp2NI+Ubjz7vZLVnvjihDsNKZ7lh5+igI9b21FggIW/8mV
 zJ6ABcgNcV6s5QvAsHy82jdOXpQrz+s7e3JZzLG2Ozr63bC1/SXb7LfjAq4YvAh2zuoD
 q8qJWaKu7uya4Ryu0EecEVNe2vpB4XaML5BLZCIFUo7kdANh4t4Ndo9+qLhcSVKVMypV
 Om+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685894722; x=1688486722;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L6cneyvOvNrAv6rJfZCBCpJ/iG065yClEwCDc+5zbIA=;
 b=Bp2K/Vh/z2MSYXXWXUrPj6Iy8wcx3uWDAHozqBsNK1d4GCc9EIKYgU/AP3ApGESCJJ
 hgY0K2T+MN2zsVpXbNmn6PBEPMvBFt8fBp+U6KsKBC8EI2Yz+wPjkYO70ormyyBhM1pr
 BaNGqQMArfeaGlB3P0y19/fmZZzq12X0IaX+Lue5rnGweQzY9fQr5pl9PIGScrg17ab1
 gbYwWaO03gFMIzYvWS6/7XbPBD3fxbhiQI87JKsp5ZGsj2+Gm1M48osP5z7zbdj/d1J9
 u5nJ9+qllBYjZsEglLzvZi2jcuKLVjzUaRYHNiBeH3yOK17txPVbCag1LjoqLNQS9x4a
 UDzg==
X-Gm-Message-State: AC+VfDxy1LWCj2lnixE3bqkpHSA0nHVv/1KT1byWhZJqJKNPw8KpBNhg
 ARlEY3pcJ5FQqTTP2QCtjlwuQQ==
X-Google-Smtp-Source: ACHHUZ6znmK8aQQAW9m1eSYYQFXhXTaZgPeRp4jDgXKKKbbyIvwhiGvIGruXuk4Xl9RYy4wGTtx8lQ==
X-Received: by 2002:a05:6358:c601:b0:128:2e1e:5dbc with SMTP id
 fd1-20020a056358c60100b001282e1e5dbcmr4806906rwb.25.1685894721768; 
 Sun, 04 Jun 2023 09:05:21 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:7d0c:4d62:710d:ff28?
 ([2602:ae:1598:4c01:7d0c:4d62:710d:ff28])
 by smtp.gmail.com with ESMTPSA id
 gx13-20020a17090b124d00b002560ab7a15fsm4258998pjb.36.2023.06.04.09.05.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jun 2023 09:05:21 -0700 (PDT)
Message-ID: <a9cfd044-6c20-e84a-b6ef-0f16c43765e3@linaro.org>
Date: Sun, 4 Jun 2023 09:05:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/4] target/ppc: Fix lqarx to set cpu_reserve
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230604102858.148584-1-npiggin@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230604102858.148584-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 6/4/23 03:28, Nicholas Piggin wrote:
> lqarx does not set cpu_reserve, which causes stqcx. to never succeed.
> Fix this and slightly rearrange gen_load_locked so the two functions
> match more closely.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 94bf2658676 ("target/ppc: Use atomic load for LQ and LQARX")
> Fixes: 57b38ffd0c6 ("target/ppc: Use tcg_gen_qemu_{ld,st}_i128 for LQARX, LQ, STQ")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> cpu_reserve got lost in the parallel part with the first patch, then
> from serial part when it was merged with the parallel by the second
> patch.

Oops, sorry about that.

> 
> Thanks,
> Nick
> 
>   target/ppc/translate.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 3650d2985d..e129cdcb8f 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3583,8 +3583,8 @@ static void gen_load_locked(DisasContext *ctx, MemOp memop)
>   
>       gen_set_access_type(ctx, ACCESS_RES);
>       gen_addr_reg_index(ctx, t0);
> -    tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, memop | MO_ALIGN);
>       tcg_gen_mov_tl(cpu_reserve, t0);
> +    tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, memop | MO_ALIGN);
>       tcg_gen_mov_tl(cpu_reserve_val, gpr);

This change is wrong.  Reserve should not be set if the load faults.

>       tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
>   }
> @@ -3872,6 +3872,7 @@ static void gen_lqarx(DisasContext *ctx)
>       gen_set_access_type(ctx, ACCESS_RES);
>       EA = tcg_temp_new();
>       gen_addr_reg_index(ctx, EA);
> +    tcg_gen_mov_tl(cpu_reserve, EA);
>   
>       /* Note that the low part is always in RD+1, even in LE mode.  */
>       lo = cpu_gpr[rd + 1];

This needs to go lower with the sets of reserve_val*.


r~

