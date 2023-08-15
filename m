Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D112677CFE1
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 18:08:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVwaE-0000KF-JW; Tue, 15 Aug 2023 12:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qVwaC-0000Jv-Hf
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 12:07:48 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qVwaA-0005mk-S8
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 12:07:48 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68879c4cadeso58566b3a.2
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 09:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692115665; x=1692720465;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gzOztbuw2e+WqX5I3bUMqVSJY51MV1TiKq6hzOG1XxI=;
 b=rxVk1qBOsM9sfGL/bkfkyNKacDfSUPBygqQEEyb2+hFmya9H8JpXrescUbKkhjVKZo
 ySHvUl6SPAMRCsCRhwd4GW9JNRQTD6rxa+JL40NXT87+NoXRkjNUl4C1f1H/MJCGJAv5
 pn9W3WnQojvER2sOV7NQb17JFtrcyIR7kdee92CL5kCQTvKIi3zQqQ9LvZ8xGE432PEt
 4PowQdH76gw87bpDUZByf7IdvvME/eX9XAOvP70aEHknlEERJXiq/dYt0hCiFjLHo/LC
 jw2aFICkdhz/CZQ9aokp7ZA6p43yKGspMmdEwTWyU8ReO5gJqsffS1a3Xix+UlrrVxNO
 WHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692115665; x=1692720465;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gzOztbuw2e+WqX5I3bUMqVSJY51MV1TiKq6hzOG1XxI=;
 b=lbJR2QDsXH3OcRP9Jw+B6/iN5IR7UssHusFKQ6Ea3SvOTi9wAjpXtlfoPNWdsRT2XG
 l7j46f9Snf/nIMAoKBZ0ThUb13b/xVErpmU7NyxYyQeP0twGsd2fmoyfFqDHVA/debwV
 eaOmykqMHTuifQ3oaNkBu9SURqEkUElw39AHGv0juJZ7Xoc7kKaljsBaP9HQS3+vBMgw
 DE8+0zt2oOOIlXPAbhZslvk3OLk77NcSrwCTjDGFXS9TseLaxcvHY+oumvsFWYG320Ks
 srsRgW0YaTYNfJhfnbmcwfaJ63UDLQRBxffIvfOTkx6Vl3vBi6zPk/dss3q+v0Tpxel8
 JXLw==
X-Gm-Message-State: AOJu0YxeIORyFHw3I+QSaNs/sMLtS8Mt76beyQTnPMvZ7T+11UziEa6x
 zfouk8YLNgkmyyLnLFXQH+8hXg==
X-Google-Smtp-Source: AGHT+IEG7vcp0zvfZHkrObwM0j187xAIXUOdLzvjrNmrx6HEA7YFwi9+X7qcG+0hwRPumJ9ka7IG4A==
X-Received: by 2002:a05:6a21:7746:b0:134:951c:aca3 with SMTP id
 bc6-20020a056a21774600b00134951caca3mr10262521pzc.22.1692115665054; 
 Tue, 15 Aug 2023 09:07:45 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:8d06:f27b:d26c:91c1?
 ([2602:47:d483:7301:8d06:f27b:d26c:91c1])
 by smtp.gmail.com with ESMTPSA id
 x28-20020aa793bc000000b00682a9325ffcsm9578601pff.5.2023.08.15.09.07.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Aug 2023 09:07:44 -0700 (PDT)
Message-ID: <bdea1e60-9368-4a56-66f5-26269033b5d9@linaro.org>
Date: Tue, 15 Aug 2023 09:07:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] tcg/ppc: Enable direct branching tcg_out_goto_tb with
 TCG_REG_TB
To: Jordan Niethe <jniethe5@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, bgray@linux.ibm.com
References: <20230815050117.34731-1-jniethe5@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230815050117.34731-1-jniethe5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.045,
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

On 8/14/23 22:01, Jordan Niethe wrote:
> Direct branch patching was disabled when using TCG_REG_TB in commit
> 736a1588c1 ("tcg/ppc: Fix race in goto_tb implementation"). Commit
> 7502f89c74 ("tcg/ppc: Use prefixed instructions for tcg_out_goto_tb")
> used the support for pc relative ISAv3.1 instructions to re-enable
> direct branch patching on POWER10.
> 
> The issue with direct branch patching with TCG_REG_TB is the lack of
> synchronization between the new TCG_REG_TB being established and the
> direct branch being patched in.
> 
> If each translation block is responsible for establishing its own
> TCG_REG_TB then there can be no synchronization issue.

That's a good idea, and can be used for other things...

It also begs the question of whether power10 should continue to use TCG_REG_TB, loading 
the address with PADDI.  Or whether power9 should, like power10, disable USE_REG_TB and 
use ADDPCIS throughout.

I imagine it depends on usage frequency, whether use of TCG_REG_TB allows 1 insn, where 
addpcis requires 2 insns and prefixed insns require 2 or 3 insn slots (depending on 
alignment).


> +        tcg_out32(s, MFSPR | RT(TCG_REG_TMP1) | LR);
> +        /* bcl 20,31,$+4 (Preferred form for getting nia.) */
> +        tcg_out32(s, BC | BO_ALWAYS | BI(7, CR_SO) | 0x4 | LK);
> +        tcg_out32(s, MFSPR | RT(TCG_REG_TB) | LR);
> +        tcg_out32(s, ADDI | TAI(TCG_REG_TB, TCG_REG_TB, -8));
> +        tcg_out32(s, MTSPR | RS(TCG_REG_TMP1) | LR);

Don't need to save/restore LR.  It is saved in the prologue and may be clobbered within 
the tb itself (as we do for calls).

> @@ -2678,6 +2693,12 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
>       tcg_out32(s, MTSPR | RS(TCG_REG_TMP1) | CTR);
>       tcg_out32(s, BCCTR | BO_ALWAYS);
>       set_jmp_reset_offset(s, which);
> +
> +    /* For the unlinked case, need to reset TCG_REG_TB.  */
> +    if (USE_REG_TB) {
> +        tcg_out_movi_int(s, TCG_TYPE_I64, TCG_REG_TB,
> +                         (tcg_target_long)s->code_buf, true);
> +    }
>   }

Actually, we don't.  The only time we arrive here is when an unlinked TB branches to 
itself.  TCG_REG_TB is still valid.

> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index ddfe9a96cb..20698131c2 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -6010,6 +6010,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
>           tcg_malloc(sizeof(uint64_t) * s->gen_tb->icount * start_words);
>   
>       num_insns = -1;
> +#ifdef TCG_TARGET_NEED_ENTER_TB
> +    tcg_out_enter_tb(s);
> +#endif

Better would be to not have the ifdef, and add this symbol as an empty function in all 
other tcg backends.

I might play around with this a bit.


r~


