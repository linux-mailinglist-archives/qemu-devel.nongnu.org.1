Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AF4833096
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 23:00:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQwtz-0008OP-15; Fri, 19 Jan 2024 16:59:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQwtr-0008Ns-Bu
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 16:59:44 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQwtj-0006fF-PQ
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 16:59:40 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40e884de7b9so15559755e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 13:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705701573; x=1706306373; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kl1Aj3Nba/TDVWXooCBmkMuMhPrC7ydl0q22iuI5fDI=;
 b=mbKXQMFnakysvl6kgqaBlF306tvkNCz6IRQDZX7eiubBuHNiAvj5X3Nzpi3/llxPxS
 qQaMhfRNSXWr88wH/+Tydf85zsiiLWVIuEgyKIYiGfp5HGWgDCF4hHNdAEdMv40tgo2q
 og9Fbcz8dKVRrwJ1WHFeuy5Q7UAMANmsU7UcgAozY4yoXrWBtQ7ydq8IPzrGoy/Vlt3W
 BpnJF7y1Vnnvv2QrlQBoIseOf38DAFdPokT0unU7shFVCH1Lmc5iJ75I5YvH1koeLjkH
 DADn2RT7i9epyfKvElDB+vIQC4M1WS+EVXnrL69t6rJQbDJutmR6fhHb0DdaD119pZ6i
 ezog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705701573; x=1706306373;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kl1Aj3Nba/TDVWXooCBmkMuMhPrC7ydl0q22iuI5fDI=;
 b=OHjHsQwvtXifgp4yoy/vTFZBJAFT4LqbNcnDaxZy2brP9UPppvceud9xjwy2x8rZA0
 gsjMBbrnQXm50vAWAxQdJTON3X+DDl+3Wzq1Yqnkntb31pWyweMzDVahZSwsXbj5kKeQ
 ua2Ta6QzKc6vCgN0Aj41eDo775cb5b9ND3zwOGxnqZpoz0XG6iqHdkD3MuXzrI+7Utnx
 +8Pdg6vKIOVeHOjiKUJm0wonDed6TiKLk7IyEFMC2JtFwPUowKGDqtTuP5Vo7BDxKb35
 uW6Id6qdhDcZ3x1PTRmOqPDTFIrOaeHPeUcPswt+dOfWv4IHZCv8L0afZ7uBbjbKTPep
 VGSw==
X-Gm-Message-State: AOJu0YzLep4UXC/px4fDF0qZSas070sk7ymDfdcC5YdWhAE+exBEDqmY
 iFfChkWV6MmoUFJlQAxFX9ISwMBKD31nwlo09l1mxpz2uCBPkmcU201bDd/Swtk=
X-Google-Smtp-Source: AGHT+IHuKiptYd6oVoKQcQxgUb0ihObkNMi3b5MMF9+ilpsmFNQE86HdRdEy3BGfynJwNmhEhKjXRg==
X-Received: by 2002:a05:600c:4191:b0:40e:8d64:d9c5 with SMTP id
 p17-20020a05600c419100b0040e8d64d9c5mr221195wmh.83.1705701573274; 
 Fri, 19 Jan 2024 13:59:33 -0800 (PST)
Received: from [192.168.1.67] (91-163-26-170.subs.proxad.net. [91.163.26.170])
 by smtp.gmail.com with ESMTPSA id
 fk4-20020a05600c0cc400b0040e7efb1ff2sm16173025wmb.37.2024.01.19.13.59.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jan 2024 13:59:32 -0800 (PST)
Message-ID: <fdb51ece-8520-45f0-aec4-f6c1c7388168@linaro.org>
Date: Fri, 19 Jan 2024 22:59:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/38] target/s390x: Use TCG_COND_TSTNE for
 CC_OP_{TM,ICM}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-s390x <qemu-s390x@nongnu.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
 <20240110224408.10444-15-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240110224408.10444-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/1/24 23:43, Richard Henderson wrote:
> These are all test-and-compare type instructions.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c | 18 +++++++-----------
>   1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
> index 62ab2be8b1..ae4e7b27ec 100644
> --- a/target/s390x/tcg/translate.c
> +++ b/target/s390x/tcg/translate.c
> @@ -754,10 +754,10 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
>       case CC_OP_TM_64:
>           switch (mask) {
>           case 8:
> -            cond = TCG_COND_EQ;
> +            cond = TCG_COND_TSTEQ;
>               break;
>           case 4 | 2 | 1:
> -            cond = TCG_COND_NE;
> +            cond = TCG_COND_TSTNE;
>               break;
>           default:
>               goto do_dynamic;
> @@ -768,11 +768,11 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
>       case CC_OP_ICM:
>           switch (mask) {
>           case 8:
> -            cond = TCG_COND_EQ;
> +            cond = TCG_COND_TSTEQ;
>               break;
>           case 4 | 2 | 1:
>           case 4 | 2:
> -            cond = TCG_COND_NE;
> +            cond = TCG_COND_TSTNE;
>               break;
>           default:
>               goto do_dynamic;
> @@ -854,18 +854,14 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
>           c->u.s64.a = cc_dst;
>           c->u.s64.b = tcg_constant_i64(0);
>           break;
> +
>       case CC_OP_LTGT_64:
>       case CC_OP_LTUGTU_64:
> -        c->u.s64.a = cc_src;
> -        c->u.s64.b = cc_dst;
> -        break;
> -
>       case CC_OP_TM_32:
>       case CC_OP_TM_64:
>       case CC_OP_ICM:
> -        c->u.s64.a = tcg_temp_new_i64();
> -        c->u.s64.b = tcg_constant_i64(0);
> -        tcg_gen_and_i64(c->u.s64.a, cc_src, cc_dst);
> +        c->u.s64.a = cc_src;
> +        c->u.s64.b = cc_dst;
>           break;
>   
>       case CC_OP_ADDU:

To the best of my s390x knowledge:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


