Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B46C97310FE
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 09:39:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9hZb-0007FA-Qu; Thu, 15 Jun 2023 03:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9hZa-0007Et-3W
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 03:39:14 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9hZY-0004RV-GI
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 03:39:13 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-977d02931d1so213970466b.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jun 2023 00:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686814751; x=1689406751;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QVAmvd7uEBUlqNSORgiMfQhAq4EIg7vNNgU3JjOQwRg=;
 b=vvirandq1tFaCGHUiz+ndSEKNs9kLERLdx5HJTyi2P5/U65Y4tD4VBuirdoXrBgEXB
 OJMi6+8NC6Q3Isklw3i5zCkL8j22/52aMJHSrFKnMVfGqJyRFjMgwaimNu8RS8PmY0Iv
 jfJO6jbZhsGy1MRND/sbclIBY4EYxq1O2oWHZQFP/p9q0mOboC095igmrUdeBjTg0Zn0
 xzBWOQgakMmawf9mfZjEaalW72DQk7yFTtz53WtwQDDwCtuMEngVz6B+Q87guNxJb4a0
 Epb9MpWDUl1Optmeh3G9U+kBmSLSqrxKpB/FDtUFyf0FCP4DOlniV9omhTAeneio89mN
 bxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686814751; x=1689406751;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QVAmvd7uEBUlqNSORgiMfQhAq4EIg7vNNgU3JjOQwRg=;
 b=lNHUv60LSyGphz9qbdD5oAfH+Isir4fdQWQB2b5LeHRjRVgdoLl0Fz32saXuuEQawC
 nIMoUyylojdxhgyPlxarOw3MgSu26iKy7YktKnSHksBfq0xjOiQvM9+/GikI+99sq6Bb
 HqpxN4szSZ1N77qeHDWiG34vTDMEETHTOc3acsdG68IKFcbCMJITb8Nsj5+lYx9EZZwe
 cYm3yTklOHsUvEYHcfdk9Kju1x/P8Bd2HHg9Rjf+1tX2zcjGA9O0v25AL1vp40qLgww+
 IWopYYM5v0i/Is0trgbjrzd6AhUOKZwl0Eifs7u8Tz9t1bIx9ioc5PCYXp5yKQXaFR/9
 Hf6A==
X-Gm-Message-State: AC+VfDxqSIxutwxKeLHC9naOwgD3anEQD7wbJqcl3PNu8ofIOVdcjPSZ
 V3TPvwFCPp65uQKWzXHCrDsPrQ==
X-Google-Smtp-Source: ACHHUZ4dGH50JzCQJQWUUK9zuy6+RZ5P5+q5wKA9trEFSfblDgU/JcLnume9iTifTMDlXMa3azBLtA==
X-Received: by 2002:a17:906:4fd0:b0:96f:d556:b926 with SMTP id
 i16-20020a1709064fd000b0096fd556b926mr15434419ejw.77.1686814750882; 
 Thu, 15 Jun 2023 00:39:10 -0700 (PDT)
Received: from [10.14.201.121] ([213.175.39.66])
 by smtp.gmail.com with ESMTPSA id
 jt5-20020a170906dfc500b0097462d8dc04sm9017565ejc.100.2023.06.15.00.39.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jun 2023 00:39:10 -0700 (PDT)
Message-ID: <86af7052-0c7b-155c-db3a-fd86d8ab30b4@linaro.org>
Date: Thu, 15 Jun 2023 09:39:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/4] target/tricore: Fix ICR.IE offset in RESTORE insn
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20230614165934.1370440-1-kbastian@mail.uni-paderborn.de>
 <20230614165934.1370440-5-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230614165934.1370440-5-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 6/14/23 18:59, Bastian Koppelmann wrote:
> from ISA v1.6.1 onwards the bit position of ICR.IE changed.
> ctx->icr_ie_offset contains the correct value for the ISA version used
> by the vCPU.
> 
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>   target/tricore/translate.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/tricore/translate.c b/target/tricore/translate.c
> index baf13fc205..e4e57130bf 100644
> --- a/target/tricore/translate.c
> +++ b/target/tricore/translate.c
> @@ -7959,7 +7959,8 @@ static void decode_sys_interrupts(DisasContext *ctx)
>       case OPC2_32_SYS_RESTORE:
>           if (has_feature(ctx, TRICORE_FEATURE_16)) {
>               if (ctx->priv == TRICORE_PRIV_SM || ctx->priv == TRICORE_PRIV_UM1) {
> -                tcg_gen_deposit_tl(cpu_ICR, cpu_ICR, cpu_gpr_d[r1], 8, 1);
> +                tcg_gen_deposit_tl(cpu_ICR, cpu_ICR, cpu_gpr_d[r1],
> +                        ctx->icr_ie_offset, 1);
>               } else {
>                   generate_trap(ctx, TRAPC_PROT, TIN1_PRIV);
>               }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Additionally, you need to exit to the main loop, so that exceptions may be recognized 
after re-enabling interrupts.  This is missing from ENABLE as well.


r~

