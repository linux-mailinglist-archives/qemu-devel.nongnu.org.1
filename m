Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6645C777CC3
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 17:53:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU7yY-00061y-L7; Thu, 10 Aug 2023 11:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU7yX-00061q-BE
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:53:25 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU7yV-0006o0-PJ
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:53:25 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31768ce2e81so1041537f8f.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 08:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691682802; x=1692287602;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3i6hx8m+Aih9MHDimlyT/kZDY0ptqV38TDAXRGskueM=;
 b=kSikDV4wrWcLVmuJIWyY7EL3IluqL+nyKbAVK/TkcktQL3kCxTkUZSiz7HUnQf59DB
 p6dKHVXHwtsVGB09W2T2yufk2xEG5iq48bVsdqw/XHQTfzA+IdzP1iN2rSlOBdjgXfZv
 sJryF6TDDKou8ULWm+LUJnfGV/0861DV5HDSNJ571623gpPoLSDbBxOZ1wSzCH8Z+4Y9
 B+zMj7sTXtwv1FBkK/vSYcAPns8zp8guLSZ8esN/KISBQTGQsuJDWyEOhtRy07rkwAmU
 wIAAxW3+mHPFEA48ltdWHEWAgmgwZ+UY1X3sBSpXEJfIk1yb09+1ORG1HksYqA88krkt
 y/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691682802; x=1692287602;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3i6hx8m+Aih9MHDimlyT/kZDY0ptqV38TDAXRGskueM=;
 b=ks/5nNaW/zxrpBAsNufP1ZXyoN7xVnBxTbqpGckhw9sOEaQS0PIC+4Bun+Kde4z4vl
 xeIHllHglfp6BY/EBj1uI03Rka2YUGYOu4Nu4rWwy8C/rZveFSk3JQkqOs6TlA+3uUav
 GKrWvuBQqO7RClLOG32RHlj/OHhZ0C8Pd4xOC6r7u8L/ZgN3PM/2rN9CgXShm0S+zu2j
 ijFDw3GXa6CUS5k+TgO+7dJ/Xf5MZbQnJ2eKkfbX3568r5bxuf7+pe2TGQAbStM7LJcp
 TG+80T8p4/wgEmVuQXMc96oabMLewjrzlYkk5ocng4DOkgxHq2x6jHvUdl4YLsjFDcCS
 nBOA==
X-Gm-Message-State: AOJu0YzOpAGetAHyFdfhEj67+JIHvtqCoVQE2zf78NSJDAM1Oe13X0Xr
 YNea8YlqTh3hAm02M5f74hrF5AuUj+avAit9WnI=
X-Google-Smtp-Source: AGHT+IFLSWXrlRW+/c0n2ci6CfKXuOUuu1j/e0yS346W7PlmhwnEpiTN2m72OzS4yeDz7BA/PoGkDQ==
X-Received: by 2002:adf:ef83:0:b0:317:55de:d8 with SMTP id
 d3-20020adfef83000000b0031755de00d8mr2538239wro.14.1691682801990; 
 Thu, 10 Aug 2023 08:53:21 -0700 (PDT)
Received: from [192.168.69.115] (tre93-h02-176-184-7-255.dsl.sta.abo.bbox.fr.
 [176.184.7.255]) by smtp.gmail.com with ESMTPSA id
 l17-20020a05600012d100b00314329f7d8asm2584387wrx.29.2023.08.10.08.53.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 08:53:21 -0700 (PDT)
Message-ID: <de3548d1-1885-4131-f6f9-d78bb9b50a16@linaro.org>
Date: Thu, 10 Aug 2023 17:53:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1] accel/tcg: Avoid reading too much in
 load_atom_{2,4}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20230810154802.16663-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230810154802.16663-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.156,
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

On 10/8/23 17:48, Richard Henderson wrote:
> When load_atom_extract_al16_or_al8 is inexpensive, we want to use
> it early, in order to avoid the overhead of required_atomicity.
> However, we must not read past the end of the page.
> 
> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---


> diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
> index e5c590a499..5d92485a49 100644
> --- a/accel/tcg/ldst_atomicity.c.inc
> +++ b/accel/tcg/ldst_atomicity.c.inc
> @@ -404,7 +404,10 @@ static uint16_t load_atom_2(CPUArchState *env, uintptr_t ra,
>           return load_atomic2(pv);
>       }
>       if (HAVE_ATOMIC128_RO) {
> -        return load_atom_extract_al16_or_al8(pv, 2);
> +        intptr_t left_in_page = pi | TARGET_PAGE_MASK;
> +        if (likely(left_in_page <= -16)) {
> +            return load_atom_extract_al16_or_al8(pv, 2);
> +        }
>       }
>   
>       atmax = required_atomicity(env, pi, memop);
> @@ -443,7 +446,10 @@ static uint32_t load_atom_4(CPUArchState *env, uintptr_t ra,
>           return load_atomic4(pv);
>       }
>       if (HAVE_ATOMIC128_RO) {
> -        return load_atom_extract_al16_or_al8(pv, 4);
> +        intptr_t left_in_page = pi | TARGET_PAGE_MASK;
> +        if (likely(left_in_page <= -16)) {
> +            return load_atom_extract_al16_or_al8(pv, 4);
> +        }
>       }

Makes sense, so to the best of my knowledge:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


