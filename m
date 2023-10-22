Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 942987D20A1
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 03:31:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quNHa-0003kr-Jb; Sat, 21 Oct 2023 21:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quNHY-0003kV-FT
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 21:29:32 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quNHW-0002mB-Q2
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 21:29:32 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1e10507a4d6so1675093fac.1
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 18:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697938169; x=1698542969; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gUdIwM9a9fzr4xrCKGrW+zLWuchdXV1ltRHAYLtkHYA=;
 b=If5RALHKOlMm+Tr26hLniqLpqYEUUyM8FuFy9MlCnI8fG8rTitbaXaygwDmgadP92w
 oKRdT10waPs5PCSGxZDQf6R0ICzEeRcniqbqxcoimIAR6z3k22gG/EmCZYvrleAfQFV9
 ntwSE7l33PzELM+bc75P1kinToTAmzqZDsBalo/Lq8TnnAr33WF9fF6XjJYUzElg0/fD
 2PnSg1383K5aWfjls2mUtXx5f8Na+4YImIm6VLG2BV8t0pcD3pGPS1+e+NDXB+NJ3dmo
 1SvzirXPTxyO0GuIXSltsVf0TfvzhZN268vkURvDO9cHsYhWKn9YlrCK0B7ybDgOGSuB
 ysnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697938169; x=1698542969;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gUdIwM9a9fzr4xrCKGrW+zLWuchdXV1ltRHAYLtkHYA=;
 b=NJxFhTRIw1Baz7p+wm61gh7HAj1L5W42RviA9AgeD9JgJtcoOfPHS6X0i27IIuZmCr
 0NLe41QlMA69sAODVsN85EnWRmJjDdi/uc+DMAIzDb0WHxWfZjy5ilTNjNvtw81mmWen
 UO3z7kGMDClddp+mrPWhawRX/8t8mEOHnq9dpe98NShGzYov4T6gReF1xXW0jLIcA8GC
 BGIZl36vbXGhm76rHJEMTyogHmDEr6aCKCOwrccnSg4wvNjEgv2WBVMhdU86jCwjDFa4
 9f3EuP+J1qnTCPLsCStJV/hi455FO++cRRgjhbDCrqVJ8m5Lij59E45TlhwR8zir6NXp
 weQg==
X-Gm-Message-State: AOJu0Yz5bLbSSvaOu/e5RAHCUE9umMcHmuNqhV5ggupaWGp0M6fCj1d+
 OyDLu3kY+L7gSll4qxnRIHw0DA==
X-Google-Smtp-Source: AGHT+IH1coVxyX2mYckc1U9SljQgaLjdE02GWqTSN2NMDaAv4DBSsTI40Zvi6weoifROdpiediVDzA==
X-Received: by 2002:a05:6871:2312:b0:1e9:a434:58a5 with SMTP id
 sf18-20020a056871231200b001e9a43458a5mr6475934oab.46.1697938169265; 
 Sat, 21 Oct 2023 18:29:29 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 nk19-20020a17090b195300b00268b9862343sm5312836pjb.24.2023.10.21.18.29.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Oct 2023 18:29:28 -0700 (PDT)
Message-ID: <4339bf9e-ad25-41b7-91cd-1da8c65d782d@linaro.org>
Date: Sat, 21 Oct 2023 18:29:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] target/i386: Use tcg_gen_ext_tl
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, laurent@vivier.eu, ysato@users.sourceforge.jp,
 kbastian@mail.uni-paderborn.de, jcmvbkbc@gmail.com
References: <20231019182921.1772928-1-richard.henderson@linaro.org>
 <20231019182921.1772928-4-richard.henderson@linaro.org>
 <5f54e3e1-1c90-0249-04f4-df522e292abe@linaro.org>
 <03ba02fd-fade-4409-be16-2f81a5690b4c@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <03ba02fd-fade-4409-be16-2f81a5690b4c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

On 10/21/23 00:59, Paolo Bonzini wrote:
> On 10/19/23 23:57, Philippe Mathieu-Daudé wrote:
>> On 19/10/23 20:29, Richard Henderson wrote:
>>> -    default:
>>> +    if (memop_size(size) == TARGET_LONG_BITS) {
>>>           return src;
>>>       }
> 
> Any opinions about adding something like this on top?
> 
> ------------------------- 8< -------------------------------
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] include, target/i386: define and use MO_TL

Yes, that looks fine.

>   static TCGv gen_ext_tl(TCGv dst, TCGv src, MemOp size, bool sign)
>   {
> -    if (memop_size(size) == TARGET_LONG_BITS) {
> +    if (size == MO_TL) {

Yep.

> I can add it in my x86 series if desirable ...

That's probably fine; you may well get your PR in before my next.

>>> +    tcg_gen_ext_tl(dst, src, size | (sign ? MO_SIGN : 0));
>>> +    return dst;
>>>   }
>>
>> While here, I'd rename 'size' -> 'mop'. Regardless,
> 
> Not sure about that, because "size" should be just the low bits of MemOp (the MO_SIGN bit 
> is passed separately).

Agreed.


r~


