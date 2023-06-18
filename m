Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F11073473E
	for <lists+qemu-devel@lfdr.de>; Sun, 18 Jun 2023 19:35:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAwIr-0006Qy-Lv; Sun, 18 Jun 2023 13:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qAwIp-0006Qp-PT
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 13:35:03 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qAwIo-0008Ee-0h
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 13:35:03 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f8d5262dc8so18474635e9.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jun 2023 10:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687109700; x=1689701700;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JGVkija+bOiSBW82FMOQ2yZn0YWF9WH/aJeJ1f08A+4=;
 b=HqwkBY78th2LTJwzCmTTCKHhQm1WKzUa7kqMMnjx+nIdzXEeo1l3zI1oYt5G76XLdU
 q13clLWPIbqbUCgozKUk2JO75f2f0pHi9FrPJDw1eJBb9WNo556JgD2CQdnVMv5GhUmI
 hPwkOvbavfY6X2l2mjdnPYFoGxu0HPkxRNFfkXButpTrwYGkqriK0Fs3ULjY/zk71j5g
 GDi7ySdv9gdK3n/vPgUCi0y5g92lHiQq6iWmHoFWk8nglMzAcSmlrAo7U3Q86Iv/Hlj4
 Y4yYexpNjRPczvb9lsNSR6mP7eyTGKLK+NFqH+nQLZOJgHZjLUaw/GeH5lrHsav4yiTm
 fJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687109700; x=1689701700;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JGVkija+bOiSBW82FMOQ2yZn0YWF9WH/aJeJ1f08A+4=;
 b=B41Ld3zSLCpVBwN5zXVti45V18BWITJTUS+DimfdrWqPmf46/8vRczpvovRxR9unDW
 hr+4EHw1tzNaYqKKtEEf9EBPO83+gQD/UhkTj0yvrZvCTQ0uFjUspDijaFX6DRALd/SR
 EY2zxJubDkO8VE7UHqHg3I++nkwvq4keohxnvsQ4YEvk/6tv+qCw4VLFgLNe8O7BYueH
 KUFCTI7b+f5bMEPep/bG21aYGBMI0vo2nOPDBQhoWBOqgbtfhwBFonODeugvHn2GP/Cp
 KD6Zyo2b1asMnWr8/nyzWRsL5q+BM1/K+koOubuUnuu0fwGUexXDjYOm2uU6TjG9Munw
 KxNQ==
X-Gm-Message-State: AC+VfDxXYtfHJf2iJ1LVb49Cgl3Y7O2rgxBDi1mhvxfX0wpTRtJhXl3a
 iWcwLwGMQZJE1mjRuJmCcdIdyw==
X-Google-Smtp-Source: ACHHUZ6OKXTKywSV9xThjTCfpzg1VwhXhWxyq6FzUIdoi/fqn+YJJ49A0jEn47p8c6NOLizM6SytqQ==
X-Received: by 2002:a05:600c:1ca7:b0:3f9:b0db:9ff1 with SMTP id
 k39-20020a05600c1ca700b003f9b0db9ff1mr389090wms.11.1687109700071; 
 Sun, 18 Jun 2023 10:35:00 -0700 (PDT)
Received: from [192.168.69.129] (mon75-h03-176-184-51-101.dsl.sta.abo.bbox.fr.
 [176.184.51.101]) by smtp.gmail.com with ESMTPSA id
 hn10-20020a05600ca38a00b003f60eb72cf5sm8435057wmb.2.2023.06.18.10.34.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jun 2023 10:34:59 -0700 (PDT)
Message-ID: <c5838f5d-ed6e-7cf4-9abd-22151b69d16e@linaro.org>
Date: Sun, 18 Jun 2023 19:34:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 7/8] target/tricore: Honour privilege changes on PSW
 write
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20230616152808.1499082-1-kbastian@mail.uni-paderborn.de>
 <20230616152808.1499082-8-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230616152808.1499082-8-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

On 6/16/23 17:28, Bastian Koppelmann wrote:
> the CPU can change the privilege level by writing the corresponding bits
> in PSW. If this happens all instructions after this 'mtcr' in the TB are
> translated with the wrong privilege level. So we have to exit to the
> cpu_loop() and start translating again with the new privilege level.
> 
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
> v1 -> v2:
>      - Removed helper_psw_write() calling cpu_loop_exit().
>        Instead we unconditionally exit for each write to psw.
> 
> 
>   target/tricore/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
> 
> diff --git a/target/tricore/translate.c b/target/tricore/translate.c
> index 71e3842601..5f9bc2b558 100644
> --- a/target/tricore/translate.c
> +++ b/target/tricore/translate.c
> @@ -333,7 +333,6 @@ static void gen_swapmsk(DisasContext *ctx, int reg, TCGv ea)
>       tcg_gen_mov_tl(cpu_gpr_d[reg], temp);
>   }
>   
> -
>   /* We generate loads and store to core special function register (csfr) through
>      the function gen_mfcr and gen_mtcr. To handle access permissions, we use 3
>      makros R, A and E, which allow read-only, all and endinit protected access.
> @@ -381,6 +380,7 @@ static inline void gen_mtcr(DisasContext *ctx, TCGv r1,
>           /* since we're caching PSW make this a special case */
>           if (offset == 0xfe04) {
>               gen_helper_psw_write(cpu_env, r1);
> +            ctx->base.is_jmp = DISAS_EXIT_UPDATE;
>           } else {
>               switch (offset) {
>   #include "csfr.h.inc"


