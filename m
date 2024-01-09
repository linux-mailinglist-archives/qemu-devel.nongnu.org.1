Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6B08289DE
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 17:20:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNEoz-00068J-8V; Tue, 09 Jan 2024 11:19:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNEov-00067Q-Vm
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 11:19:18 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNEop-0002Q0-9D
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 11:19:17 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3bbc649c275so1839659b6e.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 08:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704817148; x=1705421948; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1dko2ugyINyAxo2yixt/cMKPzRHEdNPTFVD0NslkG5k=;
 b=PjxewLQBe0YGmAM8grHNrMvFlJtQAUyvzGJsBimnYew2eijLwiK/jo+1jgoSWZgi6f
 5D7neyqcL3pT/9Jb5MD+FNYa02GcOwVRqYaW7CW1c9dvJv8Upe0YfAbLD0p1qMfuf5Dc
 MDX0f04KPk/eRt3yKh8r2jnQsnw/Y1B0sWx1Gr0vPK6Zltg+ToKJdBMUBXDQdJQuDLlv
 beIJo8MMQ/K3w3JcqABoHSvoLxeOEHlN7FmrSCmkfaeFFbgo+mFJSaZl14jLUBePtc9V
 jz1bmsovCS173pHt6xdMl2rVS1Rl3ygbgD8YYkHhoxXgXkdnwtJ9uvQYgGHOpT8zUYGB
 W6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704817148; x=1705421948;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1dko2ugyINyAxo2yixt/cMKPzRHEdNPTFVD0NslkG5k=;
 b=I0ZnU8+G0+nRArtPf8L3NeLDqhldfZ5TiJX6R/1yGOtZzDUfjohi8Mf3sRAnwp6jlS
 kahcFCR/95lJffUjtNP2CRpvjCFpOdtwPZpaIvtW8PfmoSVL8bl//3J71INqMb7KC7dv
 dFDkwNfprHsU3LijM92ANPbntu+SVUNjUefg4DWX7SKctsxXUOEzYWlAp/Io7spUAG4R
 RAHKP0MptKQEzmkku6vtdW3fMmEglYowusX79/3G1flh8l2pSXxFThSZCiHVPpB4itrR
 Xx9K5BG3b4yuS4GGl6UEsvj/H8ErfhRPqHE22EUdle4O/o6aNr9tqZf7jLd7cGqkSllI
 A4bA==
X-Gm-Message-State: AOJu0YzjeS9N6draxuqWYyG/kJUyXVexNKKd0pXt4WDpEwgXOA3doODB
 xStvPkJt1hU1tiUJ/BCyiN3d66ZBOFedQA==
X-Google-Smtp-Source: AGHT+IFhXbLyWrCFKgx5QuX9hm1lSeSvG9gx3B8bcdNpmnBT3edYpXzm5fG0F5RKa8rZLBagCkCjsw==
X-Received: by 2002:a05:6808:14e:b0:3bc:10ed:1b4b with SMTP id
 h14-20020a056808014e00b003bc10ed1b4bmr2852793oie.103.1704817148140; 
 Tue, 09 Jan 2024 08:19:08 -0800 (PST)
Received: from [192.168.47.227] ([172.58.111.136])
 by smtp.gmail.com with ESMTPSA id
 a2-20020aca1a02000000b003bbe24202acsm381290oia.21.2024.01.09.08.18.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 08:19:07 -0800 (PST)
Message-ID: <f8056d9d-803a-47b9-9e2e-007d164829b0@linaro.org>
Date: Wed, 10 Jan 2024 03:18:49 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] target/hppa: Fix PDC address translation on PA2.0
 with PSW.W=0
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, deller@kernel.org, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Bruno Haible <bruno@clisp.org>,
 "Nelson H . F . Beebe" <beebe@math.utah.edu>
References: <20240107132237.50553-1-deller@kernel.org>
 <20240107132237.50553-5-deller@kernel.org>
 <48cc72dd-bf52-4cd2-a5e1-d7d1a7e08dd1@linaro.org>
 <9c8e5d0a-99e7-4332-bf69-a7e56a62c2e3@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <9c8e5d0a-99e7-4332-bf69-a7e56a62c2e3@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 1/9/24 22:22, Helge Deller wrote:
> On 1/9/24 10:14, Richard Henderson wrote:
>> On 1/8/24 00:22, deller@kernel.org wrote:
>>> From: Helge Deller <deller@gmx.de>
>>>
>>> Fix the address translation for PDC space on PA2.0 if PSW.W=0.
>>> Basically, for any address in the 32-bit PDC range from 0xf0000000 to
>>> 0xf1000000 keep the lower 32-bits and just set the upper 32-bits to
>>> 0xfffffff0.
>>>
>>> This mapping fixes the emulated power button in PDC space for 32- and
>>> 64-bit machines and is how the physical C3700 machine seems to map
>>> PDC.
>>>
>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>> ---
>>>   target/hppa/mem_helper.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
>>> index 08abd1a9f9..011b192406 100644
>>> --- a/target/hppa/mem_helper.c
>>> +++ b/target/hppa/mem_helper.c
>>> @@ -56,7 +56,7 @@ hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr)
>>>           addr = (int32_t)addr;
>>>       } else {
>>>           /* PDC address space */
>>> -        addr &= MAKE_64BIT_MASK(0, 24);
>>> +        addr = (uint32_t)addr;
>>>           addr |= -1ull << (TARGET_PHYS_ADDR_SPACE_BITS - 4);
>>>       }
>>>       return addr;
>>
>> I believe this to be incorrect, as it contradicts Figures H-10 and H-11.
> 
> Yes, but that seems to be how it's really implemented on physical hardware.
> We have seen other figures as well, which didn't reflect the real world either.
> IMHO we can revert if it really turns out to be wrong and when we
> get a better solution.

What evidence?  So far, all I can see is for your seabios button, which doesn't run on 
physical hardware.

In any case, there is a comment just above pointing to the spec, which you are now 
deviating from.  You need to expand that comment to say why and how.


r~

