Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D89DE7821BB
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 05:02:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXvBP-00016n-T0; Sun, 20 Aug 2023 23:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXvBN-00016X-Ir
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 23:02:21 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXvBJ-0001hs-3s
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 23:02:19 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bf078d5f33so21989535ad.3
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 20:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692586935; x=1693191735;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yr+PLO/BidFeUNVmHdRh2GtoQOSnfowD6Wej+zo5dSs=;
 b=vbuHS6SiSnTtYIcoCUFenhPBnUSZpzxcVn+N1clhzWZDZGTyBRgVa43lboaQdeR56o
 cAlQD29m3GiB5fhFE+eFGmhYCaQNKvHqgPqqWh488wyohNJC+hOWKebEf9N5xMCAns9l
 gcnYyKh63qMr4oK5Tk3i9t6oBAk0/KYvD3WHwi5WH3KYZW1qJaGKAz0EIVYDcjUMyRnd
 o19sEwtsctfA+Fe82Aptt7EvHZBnpoPKqJnSXfzLa0W2JfovfaL2kiqGl0CfNvineo+K
 SaWDqoIANDRxk8Wax//Mg/cuVXLetmkcrl8GiDV8TaSvsBHFNrSLAcG0JTmzPSQoS53v
 PNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692586935; x=1693191735;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yr+PLO/BidFeUNVmHdRh2GtoQOSnfowD6Wej+zo5dSs=;
 b=bTFzK+NVgcpcJlyOWSPA7ugtge9+RWXEszUJcpNwqoSdcUJMp0JcZC90u46SYNFl9p
 PnUSsjXQ6MLYwxCwER4V1QVJt3xHRkLjFbSfPlwaImdisL0Y5kf4Ei+CeItG87hOlzeb
 DR/cQOO/gFgRJxxaJOf5SDmRWDJaSMHO7iW6hiyQqQ0HObc+zDfiQdMdSk8h2sb/ZK5p
 i0Ex7/1EVArfrhPQWLzjVJzintmBFNR1FP20iqlyb9UjFEKSn6dWfTfW3nFR3JPZvczk
 /KT8eBUOT7XNdNvcjQuxD0h0IhAPYCOFHuoA6UpmXx+DdaxdqtEjRFzn1k6+Y0oc+1p1
 MNuQ==
X-Gm-Message-State: AOJu0YwAMRsC6CoB3PDurTtz8xSnkr/YF2hrkU0kcYfPP8m2RdSdO2+t
 1EHxLSY/A4/qkfCRjVILWdu5jA==
X-Google-Smtp-Source: AGHT+IHLB/WLfBNWRqM+Tat3TtjsD4MVCRfXMfdn/+DPSragwmoqnglF90KRtbKr/s9snj8fjc5gsQ==
X-Received: by 2002:a17:90b:1d09:b0:262:fe45:860b with SMTP id
 on9-20020a17090b1d0900b00262fe45860bmr4569290pjb.0.1692586935623; 
 Sun, 20 Aug 2023 20:02:15 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:7da6:8db:fd7a:4d62?
 ([2602:47:d483:7301:7da6:8db:fd7a:4d62])
 by smtp.gmail.com with ESMTPSA id
 ep13-20020a17090ae64d00b00262e485156esm6752433pjb.57.2023.08.20.20.02.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 20:02:15 -0700 (PDT)
Message-ID: <420b8a0d-4a36-ff07-e95c-fff3b980d1c2@linaro.org>
Date: Sun, 20 Aug 2023 20:02:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] softfloat: Handle m68k extended precision denormals
 properly
Content-Language: en-US
To: Keith Packard <keithp@keithp.com>, qemu-devel@nongnu.org
References: <20230821003237.376935-1-richard.henderson@linaro.org>
 <877cppkx0r.fsf@keithp.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <877cppkx0r.fsf@keithp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 8/20/23 18:24, Keith Packard wrote:
> 
>> Motorola treats denormals with explicit integer bit set as
>> having unbiased exponent 0, unlike Intel which treats it as
>> having unbiased exponent 1 (like all other IEEE formats).
> 
> Thanks for having a look at this. Your patch fixes a couple of cases,
> but there are further adventures that await if you're interested.
> 
>             x:  0x1p0                      0x3fff 0x80000000 0x00000000
>             y:  0x1p-16383                 0x0000 0x80000000 0x00000000
>     build_mul:  0x1p-16382                 0x0000 0x80000000 0x00000000
>   runtime_mul:  0x1p-16383                 0x0001 0x80000000 0x00000000
> 
> I think the enclosed additional patch fixes this. I've still got 75 fmal
> failures on this target, but the obvious 'multiply is broken' problem
> appears fixed.
> 
>  From b722c92f8329f56f5243496eca3779f1156aff4f Mon Sep 17 00:00:00 2001
> From: Keith Packard <keithp@keithp.com>
> Date: Sun, 20 Aug 2023 18:20:13 -0700
> Subject: [PATCH] softfloat: Handle m68k LDBL_MIN_EXP normal values
> 
> Unlike Intel 80-bit floats, Motorola allows for normal values with a
> zero exponent. Handle that by not setting exponent to 1 when the value
> is normal for this format.
> 
> Signed-off-by: Keith Packard <keithp@keithp.com>
> ---
>   fpu/softfloat-parts.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
> index d0c43c28fb..cea854cdf1 100644
> --- a/fpu/softfloat-parts.c.inc
> +++ b/fpu/softfloat-parts.c.inc
> @@ -288,7 +288,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
>               p->frac_lo &= ~round_mask;
>           }
>   
> -        exp = (p->frac_hi & DECOMPOSED_IMPLICIT_BIT) != 0;
> +        exp = (p->frac_hi & DECOMPOSED_IMPLICIT_BIT) != 0 && !fmt->m68k_denormal;

That does look like a correct change.  I'll fold it in.
Please let us know if you encounter anything else.


r~

