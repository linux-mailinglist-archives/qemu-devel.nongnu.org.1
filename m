Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AB1779411
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:14:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUUli-0005V4-Ue; Fri, 11 Aug 2023 12:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUUlg-0005Us-C6
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:13:40 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUUle-000276-OV
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:13:40 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bc65360648so18887235ad.1
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691770417; x=1692375217;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U40VVzRPiGUHBehgWJ63pfapSpubtbDafAekeIJeXLo=;
 b=s1ZUlf2gNpGBXuRAmYrRCKdfxRpEPE1MRk0m7gaHOyoT0G6O14/nUwOD2sqVRAvtmg
 P/bxJxUoWIRF/cwmNa2lCWNYUyVVjhNiau4/3MS/iqipXmDjVi8OJXyiU+SdDis1BJsv
 Iqp+wFNnYSQmjjjU1TZOdeUAHNSWw6odsQkKpZs0bYizXI51MnrHokJxdHKCfazIn4Jy
 BCDuXt7ut+lnc6grxBbnR4zFNIbrR778blp8JtK+zSBjkK/OwQ5Qaf4oRX8xqAu6+5MX
 4R1ux3GL1/I7sbPfqX1GXPWR6+gTddC7ZhnY/wYBHP4PumU4ASRqliXuwzuVBZQPjs3/
 Q2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691770417; x=1692375217;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U40VVzRPiGUHBehgWJ63pfapSpubtbDafAekeIJeXLo=;
 b=AFG6q+z2mOtlr017vY1oTSQW9XF6fpIyXlcp0x1cRa2iTQOoUh/1I3n+cxXgBKHc3Q
 nBuXQp/vn5CK66qy88jZoF9GXalmDD3NOfgaKpIPEDdPmK3K2L8pya5RUdvP1Fg0NL88
 /RZUaQ1ZhOkwwOtp4M7tohzeHjYpB+1pi20inNtiphRArCfblV6niICo8/X99zLRrf8g
 nIalmPTmMXh7rT52ZBpRefBTrSNj0cziQB0GrksFEukzatbNWegIFeZhNhgT5tq2Ba73
 RO1mnZXKBA1HsFk1ZfRoHvkSTkCgSRLu5KawOdaDspOTsNnU3TpwxLQKhHMP4fLNpWaz
 mMhw==
X-Gm-Message-State: AOJu0YwXe51AmM04JjYF2WKLCjgt+swotGFgnsjBuYfV6tBoJtUr8Azr
 hN1yreVplK1tN/WAdklL2+wUXw==
X-Google-Smtp-Source: AGHT+IE1+WwtJq74UTPWeMaQ/BP5lvd5FQeQpmjsvEoIlsjvRg7/JATC9M8ElVbG6LWxO0JKpZXfyA==
X-Received: by 2002:a17:902:bcc4:b0:1b3:d4d5:beb2 with SMTP id
 o4-20020a170902bcc400b001b3d4d5beb2mr2274505pls.9.1691770417441; 
 Fri, 11 Aug 2023 09:13:37 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:e773:351d:2db2:8a8a?
 ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 m8-20020a170902db0800b001b801044466sm4126183plx.114.2023.08.11.09.13.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Aug 2023 09:13:36 -0700 (PDT)
Message-ID: <dc7bd910-fdff-74a8-12a2-0fd2cf814b9f@linaro.org>
Date: Fri, 11 Aug 2023 09:13:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 6/8] target/loongarch: Add avail_LAM to check atomic
 instructions
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn, c@jia.je
References: <20230811100208.271649-1-gaosong@loongson.cn>
 <20230811100208.271649-7-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230811100208.271649-7-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.972,
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

On 8/11/23 03:02, Song Gao wrote:
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/insn_trans/trans_atomic.c.inc | 12 ++++++++++++
>   target/loongarch/translate.h                   |  1 +
>   2 files changed, 13 insertions(+)
> 
> diff --git a/target/loongarch/insn_trans/trans_atomic.c.inc b/target/loongarch/insn_trans/trans_atomic.c.inc
> index 194818d74d..867d09375a 100644
> --- a/target/loongarch/insn_trans/trans_atomic.c.inc
> +++ b/target/loongarch/insn_trans/trans_atomic.c.inc
> @@ -9,6 +9,10 @@ static bool gen_ll(DisasContext *ctx, arg_rr_i *a, MemOp mop)
>       TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
>       TCGv t0 = make_address_i(ctx, src1, a->imm);
>   
> +    if (!avail_LAM(ctx)) {
> +        return true;
> +    }
> +
>       tcg_gen_qemu_ld_i64(dest, t0, ctx->mem_idx, mop);
>       tcg_gen_st_tl(t0, cpu_env, offsetof(CPULoongArchState, lladdr));
>       tcg_gen_st_tl(dest, cpu_env, offsetof(CPULoongArchState, llval));
> @@ -25,6 +29,10 @@ static bool gen_sc(DisasContext *ctx, arg_rr_i *a, MemOp mop)
>       TCGv t0 = tcg_temp_new();
>       TCGv val = tcg_temp_new();
>   
> +    if (!avail_LAM(ctx)) {
> +        return true;
> +    }
> +
>       TCGLabel *l1 = gen_new_label();
>       TCGLabel *done = gen_new_label();

I think these two are wrong.  LAM says "AM* atomic memory instructions".
I think LL/SC are always available.

>   
> @@ -53,6 +61,10 @@ static bool gen_am(DisasContext *ctx, arg_rrr *a,
>       TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
>       TCGv val = gpr_src(ctx, a->rk, EXT_NONE);
>   
> +    if (!avail_LAM(ctx)) {
> +        return true;
> +    }

While correct, I think it would be better style to use LAM instead of ALL in the 
TRANS(am*) instructions.


r~

