Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C694711B1F
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 02:27:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2LGu-0005nh-5W; Thu, 25 May 2023 20:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LGg-0005FM-O6
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:25:19 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LGe-0002Vf-5A
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:25:18 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5289cf35eeaso1179567a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 17:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685060715; x=1687652715;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WSi54uChc1bxScn90ltnhkKIuwOKxI3xuOvtjdnXSkg=;
 b=EueEQs0vkUM74hVoizweIi9jcRkdiknAnidBm3nPyLEQ+6JVFnRqGW47XI7gt4Lfe3
 c/rnn899JuQLyR1XgmyTE9cVrFzFVdce7jcIyy/ZgtfeKtcG1rpFAdd+7ymN/PWIXTF0
 LTZN3+m/P3TaifA6+aqPemDBw8rMXl2fwPoaLFCX5l5KDTtvARffNW4vT3GQWrTCvg19
 tfJwHUaJC4B5jg/Y78lyt3Y0fGMmV7B2fwlB4okMwY+pbzrOI+vZ0G+TGZ7w2UtP9Sp4
 BGD6c/vSWPmEiOuSRJTd37E2o28m1rVbjQwhs1KmJuWsGCJQnXzZPo4dSJ8WOIaa0Ad3
 pnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685060715; x=1687652715;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WSi54uChc1bxScn90ltnhkKIuwOKxI3xuOvtjdnXSkg=;
 b=I3/WMhs3sw6XA4WYNZMLcZkJvJT9yFOROJdGuRMom0/w5QyQU+K9ThRac7w7vwLZkc
 XGY0Ul689MnmonEnESipfaG+iZlr5IsDbPZeUz9rBuOgdOZLPBU9t/a6C4IA2jdBBLB3
 ljv6ssMKf/MI4XYYdLp51Sny6Nio1wAKTh9g7J4cSVAVjizlPS9vsUbrQqaZs5PAAeQc
 MT4+U+NF7x3aPMg88O8RIIJucTeVFR3PRe2x8D60lvb8H7hE01tlriTev0j7OCe3ntQ4
 +kpu61Yl+yPgjI4bfEk2Z+Ra3b8rMNm1c0D7OgbqKnjdKSsH0CoMFiWwoi15KOSQbMXK
 WUag==
X-Gm-Message-State: AC+VfDzP0uYm2XX+w7u57BLsiP+RGsGv/SKgO4gU3R4Ik9cHIcjeLofi
 15vSvJGeUME/hbh6GYp2WwpRMoEfYdf/2UgZWlY=
X-Google-Smtp-Source: ACHHUZ55EozHChVQNZCQM9TXEiJhxdos/SR+ePUCYr3cpFZ830VfEjqh9hx0A9V89JN3/ZBU5YNcAQ==
X-Received: by 2002:a17:902:d2ce:b0:1af:ea40:34f2 with SMTP id
 n14-20020a170902d2ce00b001afea4034f2mr46696plc.11.1685060714742; 
 Thu, 25 May 2023 17:25:14 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:7ac5:31cc:3997:3a16?
 ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 a17-20020a170902ee9100b001aaf92130b2sm1953678pld.115.2023.05.25.17.25.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 17:25:14 -0700 (PDT)
Message-ID: <2d5049e2-13ee-3875-9691-79da18405768@linaro.org>
Date: Thu, 25 May 2023 17:25:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] tcg: Fix register move type in tcg_out_ld_helper_ret
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20230524200212.1354804-1-richard.henderson@linaro.org>
In-Reply-To: <20230524200212.1354804-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 5/24/23 13:02, Richard Henderson wrote:
> The first move was incorrectly using TCG_TYPE_I32 while the second
> move was correctly using TCG_TYPE_REG.  This prevents a 64-bit host
> from moving all 128-bits of the return value.
> 
> Fixes: ebebea53ef8 ("tcg: Support TCG_TYPE_I128 in tcg_out_{ld,st}_helper_{args,ret}")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index ac30d484f5..2352ca4ade 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -5736,8 +5736,8 @@ static void tcg_out_ld_helper_ret(TCGContext *s, const TCGLabelQemuLdst *ldst,
>       mov[0].dst = ldst->datalo_reg;
>       mov[0].src =
>           tcg_target_call_oarg_reg(TCG_CALL_RET_NORMAL, HOST_BIG_ENDIAN);
> -    mov[0].dst_type = TCG_TYPE_I32;
> -    mov[0].src_type = TCG_TYPE_I32;
> +    mov[0].dst_type = TCG_TYPE_REG;
> +    mov[0].src_type = TCG_TYPE_REG;
>       mov[0].src_ext = TCG_TARGET_REG_BITS == 32 ? MO_32 : MO_64;
>   
>       mov[1].dst = ldst->datahi_reg;

Superseded by
Message-Id: <20230526002334.1760495-1-richard.henderson@linaro.org>

r~

