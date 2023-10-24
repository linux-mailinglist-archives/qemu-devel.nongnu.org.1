Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 326BD7D4B5B
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 10:59:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvDFA-0005Rs-Ib; Tue, 24 Oct 2023 04:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvDF8-0005RB-HH
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:58:30 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvDF6-0007o6-Q6
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:58:30 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4081ccf69dcso29710895e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 01:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698137907; x=1698742707; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IhtaODJUGadKNkK1mymg9lGk/EiqATC/XjHbDQ5G2kE=;
 b=eJWv+GGQ0sNJJlG+bkzcSzFUepuEGeQVudiJpxa2gHP/NNROtekaj3MZobgdzWpak2
 /keFGpfvoYgeYE+CPcS29spzgLtw68nTYktbBrvvGJn9MSPLVvKefzgmLxhJEaE4nmSe
 AbWa0FDUqT+RMF7V5HZhb4J5c7m1zgMJEj11hpfEvaLg4dGBDLpn40riUA/jcclpU0JF
 8yOtsWR1imvcqpcdUdABRhgsLpcqqIEsME/VZh3ewoM1NF29EiSIVImN/lbgwOoku97b
 d/pe85oSmyV1bGZzCwwoJtRX30MSRs4vIUytvBseDE4UtyCtnQTfroMhn0jrSrb3PL2o
 mUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698137907; x=1698742707;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IhtaODJUGadKNkK1mymg9lGk/EiqATC/XjHbDQ5G2kE=;
 b=mHL4QKF8SmkK2twzSChQkDrJl3Bz6ZVIUy3+N2PeGwvbE4gABjTMYCjRfxbdI/H4P+
 VAVZsPTQrZ9r1RtkOOCdiHujcQr7C2BcpgUavHBeEFIbPcl8H8vLBo+fR4gj6PhPqbdZ
 Db8xQuC1EJ8Az0/RxxumX3lkhkUftibbxX1T+sXYXvvPjJazfFctoHCir+PiCsXmncQf
 m0YwnmgY4BPm5SL7Ocj4iAI6dWA4Th9sjSaYQhe4IL/n45DVNPKPmYOSrigS6gXPw1R7
 Zga2PCRPLZQw1+Yess0RSxRXHf43ZT4RiZ4Xk/nMhBTAqHpFCvkO0uIzSBdGFS9G6CSn
 JJrA==
X-Gm-Message-State: AOJu0YwicRTZMUtY0Kt0MS0NyM8PMHX9RCWE4GekmNLQY78dX1J9kcER
 01mMueacFhfvxP0AQ/kAyHw7Eg==
X-Google-Smtp-Source: AGHT+IEXCbDurUWIRB13wQf8bdQqJ53Q4YZKe9+TNBtDrMojNfRjK9AoZ8ajbhmbM+iJ1rydn2GNXg==
X-Received: by 2002:a05:600c:2a15:b0:400:5962:6aa9 with SMTP id
 w21-20020a05600c2a1500b0040059626aa9mr13953822wme.11.1698137907247; 
 Tue, 24 Oct 2023 01:58:27 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 b13-20020a05600c11cd00b0040770ec2c19sm16157123wmi.10.2023.10.24.01.58.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 01:58:26 -0700 (PDT)
Message-ID: <27ceaa42-538c-b923-6c8c-f790302694f6@linaro.org>
Date: Tue, 24 Oct 2023 10:58:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 8/9] target/cris: Use tcg_gen_sextract_tl
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20231023160944.10692-1-philmd@linaro.org>
 <20231023160944.10692-9-philmd@linaro.org>
 <db537981-e8ee-419c-9bc1-d9092ec60deb@linaro.org>
 <1668b930-e79b-d84a-f0c1-b0fca9b3baaa@linaro.org>
In-Reply-To: <1668b930-e79b-d84a-f0c1-b0fca9b3baaa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 24/10/23 10:53, Philippe Mathieu-Daudé wrote:
> On 24/10/23 02:26, Richard Henderson wrote:
>> On 10/23/23 09:09, Philippe Mathieu-Daudé wrote:
>>> Inspired-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> RFC: please double-check bits
>>> ---
>>>   target/cris/translate.c | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/target/cris/translate.c b/target/cris/translate.c
>>> index 65b07e1d80..3a161f8f73 100644
>>> --- a/target/cris/translate.c
>>> +++ b/target/cris/translate.c
>>> @@ -336,8 +336,7 @@ static void t_gen_cris_mstep(TCGv d, TCGv a, TCGv 
>>> b, TCGv ccs)
>>>        */
>>>       t = tcg_temp_new();
>>>       tcg_gen_shli_tl(d, a, 1);
>>> -    tcg_gen_shli_tl(t, ccs, 31 - 3);
>>> -    tcg_gen_sari_tl(t, t, 31);
>>> +    tcg_gen_sextract_tl(t, ccs, 3, 1);
>>
>> tcg_gen_sextract_tl(t, ccs, ctz32(N_FLAG), 1);
>>
>> Also, it appears t_gen_cris_mstep consumes CCS without making sure 
>> that it is up-to-date.
> 
> Do you mean we first need to call cris_evaluate_flags?
> 
> -- >8 --
> diff --git a/target/cris/translate.c b/target/cris/translate.c
> index 3a161f8f73..5eb68b8a63 100644
> --- a/target/cris/translate.c
> +++ b/target/cris/translate.c
> @@ -177,6 +177,8 @@ static const int preg_sizes[] = {
>   #define t_gen_movi_env_TN(member, c) \
>       t_gen_mov_env_TN(member, tcg_constant_tl(c))
> 
> +static void cris_evaluate_flags(DisasContext *dc);
> +
>   static inline void t_gen_mov_TN_preg(TCGv tn, int r)
>   {
>       assert(r >= 0 && r <= 15);
> @@ -325,7 +327,7 @@ static void t_gen_cris_dstep(TCGv d, TCGv a, TCGv b)
>       tcg_gen_movcond_tl(TCG_COND_GEU, d, d, b, t, d);
>   }
> 
> -static void t_gen_cris_mstep(TCGv d, TCGv a, TCGv b, TCGv ccs)
> +static void t_gen_cris_mstep(DisasContext *dc, TCGv d, TCGv a, TCGv b, 
> TCGv ccs)
>   {
>       TCGv t;
> 
> @@ -335,6 +337,7 @@ static void t_gen_cris_mstep(TCGv d, TCGv a, TCGv b, 
> TCGv ccs)
>        *    d += s;
>        */
>       t = tcg_temp_new();
> +    cris_evaluate_flags(dc);
>       tcg_gen_shli_tl(d, a, 1);
>       tcg_gen_sextract_tl(t, ccs, 3, 1);

Err, to be applied before this patch #8.

>       tcg_gen_and_tl(t, t, b);
> @@ -702,7 +705,7 @@ static void cris_alu_op_exec(DisasContext *dc, int op,
>           t_gen_cris_dstep(dst, a, b);
>           break;
>       case CC_OP_MSTEP:
> -        t_gen_cris_mstep(dst, a, b, cpu_PR[PR_CCS]);
> +        t_gen_cris_mstep(dc, dst, a, b, cpu_PR[PR_CCS]);
>           break;
>       case CC_OP_BOUND:
>           tcg_gen_movcond_tl(TCG_COND_LEU, dst, a, b, a, b);
> ---
> 


