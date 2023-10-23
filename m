Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C8A7D435B
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 01:40:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv4Wx-0007ON-1j; Mon, 23 Oct 2023 19:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv4Wu-0007GN-Gr
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:40:16 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv4Wr-0001jz-Hd
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:40:16 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6b497c8575aso3867743b3a.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 16:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698104412; x=1698709212; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2HEktXQvp1PeDKZyFAXjp7xMi1M1nFgLaCnx9Tup0dA=;
 b=cdbJJ++8pK8r4ACwP6xeWqANv8llapTMvbDFPZHyjfzCDu6fPX2fFuLg1+0FS/QqnJ
 ApGCDC5fx20KRp2Fm1kUNQNsqtBmiKJyzn63Fkm8NXSsYDBZh4wcesu2DqcpLDzAi7JS
 eciMpwwGY+eBq9/2DzTIVx0W2je3jmneqiMLEuIzbikxUCo5nqahqSXDlb/Ul3vtoPk7
 3wEKT29BjA/TvIIZ8JsGj8cx5mJHCZc0K+Zh5aazP1m1hm5JHbCWzPcAyhJA8WXya6/t
 zD1H1ngOBeVJH0PKSnIDnhKNgm5QVaPa8Uts/J/51emzL0JBDd7jumcjtUtwkaUGwEK/
 WVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698104412; x=1698709212;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2HEktXQvp1PeDKZyFAXjp7xMi1M1nFgLaCnx9Tup0dA=;
 b=T5sknZuDm++YXp9U+j63KAILzKSrEmlEhpDv529G3E8KUfnCfhjg8JTsZGaHwRrYf2
 wtMevTRpu07TNHrpF584PfrpRPzDEgAtmNxG2Z/t4oWMKi/TUSEkoCQcMfAEo1jwsUYr
 JhEIypLkCzEeps5hfSfSMryj8TCtbfTGtYqC7Z2W3PFNVs8g+BsxhLUjWZZri7yBz1TI
 A15mhUw0fC5U3gjqGmpUEn4B9lbDSFF9pRV1n/GkFG+2SUl4aKIvIPTKDD80Xwo9nMtr
 L7uqwMSelY9tPwKb+tM/nlRxOVmSG5x2NW844Ug3uarnYh4OaxpLCvlIEC1+MawKHocO
 hV5w==
X-Gm-Message-State: AOJu0YzTLqNjagLpZBIH8w7vrM02dvaeNDmu+SyTIp3MDokGMhUisUO4
 PcKGBc+t17Ojm9jZAtaNDVneEw==
X-Google-Smtp-Source: AGHT+IEZooLIYmrT3qlJH4Zhfl2oFzeAcNbO5oiRR5XI4PgDJPrDQ8kkZQ2NjuTx72ZtY/mF1W3iHg==
X-Received: by 2002:aa7:842a:0:b0:6bc:f819:fcf0 with SMTP id
 q10-20020aa7842a000000b006bcf819fcf0mr10071566pfn.1.1698104412243; 
 Mon, 23 Oct 2023 16:40:12 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 p26-20020aa79e9a000000b006bfb8a34c64sm1711555pfq.88.2023.10.23.16.40.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 16:40:11 -0700 (PDT)
Message-ID: <32e1a175-bc84-479c-a451-25f48eaed376@linaro.org>
Date: Mon, 23 Oct 2023 16:40:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] target/ppc: Use tcg_gen_extract_i32
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20231023160944.10692-1-philmd@linaro.org>
 <20231023160944.10692-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231023160944.10692-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/23/23 09:09, Philippe Mathieu-Daudé wrote:
> Inspired-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/translate.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 329da4d518..c6e1f7c2ca 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4802,16 +4802,14 @@ static void gen_mtcrf(DisasContext *ctx)
>               TCGv_i32 temp = tcg_temp_new_i32();
>               crn = ctz32(crm);
>               tcg_gen_trunc_tl_i32(temp, cpu_gpr[rS(ctx->opcode)]);
> -            tcg_gen_shri_i32(temp, temp, crn * 4);
> -            tcg_gen_andi_i32(cpu_crf[7 - crn], temp, 0xf);
> +            tcg_gen_extract_i32(cpu_crf[7 - crn], temp, crn * 4, 4);
>           }
>       } else {
>           TCGv_i32 temp = tcg_temp_new_i32();
>           tcg_gen_trunc_tl_i32(temp, cpu_gpr[rS(ctx->opcode)]);
>           for (crn = 0 ; crn < 8 ; crn++) {
>               if (crm & (1 << crn)) {
> -                    tcg_gen_shri_i32(cpu_crf[7 - crn], temp, crn * 4);
> -                    tcg_gen_andi_i32(cpu_crf[7 - crn], cpu_crf[7 - crn], 0xf);
> +                    tcg_gen_extract_i32(cpu_crf[7 - crn], temp, crn * 4, 4);

Might as well fix indentation here.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

>               }
>           }
>       }


