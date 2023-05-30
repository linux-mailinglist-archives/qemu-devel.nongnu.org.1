Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A710716ACB
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 19:23:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q432h-00018D-SF; Tue, 30 May 2023 13:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q432f-00010N-6v
 for qemu-devel@nongnu.org; Tue, 30 May 2023 13:21:53 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q432d-0002WS-HP
 for qemu-devel@nongnu.org; Tue, 30 May 2023 13:21:52 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso603160a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 10:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685467310; x=1688059310;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=50B0/Lj2G2z68eOzMBX+iLv4/VTkFzw+BlWgQOL3hnw=;
 b=bns5VUQPdQJnhAQvEB6VCo+9rpT2JrTwC6z0CjXDA0yORvYa9oglK8b8W4YOIDZNVb
 EsLZueLeT0te7olH1FInTk2IW9euC9HSTqvPRs2W1quq+71hGcD+cszyL6nN3e0ahg74
 quZMcq4kkbWmVTwC9ZhJVTYdwQkzie37Mvt/TIZIw8m+GwwF/y0063ZdHQeHgQLBsqM0
 cAJ0AilDr5MmUJXaEUOodPSSnHSuk2+A0/Js9k+B8nkR0inJElY3D1XbzBfq7WBJ5vki
 msQ65D68+5JlkURVTbWWIvtW4d2csDT2ExdLK5KQss5HKIT3p+gZSb2PPE1E9YO5YrBR
 xVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685467310; x=1688059310;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=50B0/Lj2G2z68eOzMBX+iLv4/VTkFzw+BlWgQOL3hnw=;
 b=bL3d4DrcFdZE87xsyMLeZEXEhlFBY4AZAr+uNOWf4rnx/6C9mGniUHY3Foh2zmJ2Fm
 A+7G/Ihj56GUYTL2pOqmWKDpjtKF3HNE8guvtdcxEx9cLJUkaWoNNd7+VkfIcNrwhueE
 MejM0RcX+Cgr5iI7jtGQxyOzCY08Nm++jMDUBoRZAYEJXw19HNGeiC29pTmP4T3cXPRE
 7l/IdSr/obyqLXhpQne1f62kwf0VIQV+uk/46Np9fV0XHPeGanlwfCMxNSjwhspvFU58
 s7reEvOYbt4wa1Tl+sBF+8RaDhWBPCF682mimCiqob1viqTfVRWFtK08zKQRCbK/i7oG
 k6SQ==
X-Gm-Message-State: AC+VfDy8Wc4koYy99GfaaYPYD9xUCosLDZROguDnQUm1MOkr8cvFKKWS
 HBxrSUlJQS6amxvBenMrDE8bfirO4QXXB22fVls=
X-Google-Smtp-Source: ACHHUZ6jlD0WtVyUADgjVQ7Hwm5EuaNx1ptUws3lqCtJN9oO7cstkYw2tA1lkVL5SaTBLJ1X8kG1JA==
X-Received: by 2002:a17:902:e811:b0:1b0:61dc:db67 with SMTP id
 u17-20020a170902e81100b001b061dcdb67mr3204680plg.30.1685467309851; 
 Tue, 30 May 2023 10:21:49 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:35a2:c45d:7485:f488?
 ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 i12-20020a170902eb4c00b0019a773419a6sm5478538pli.170.2023.05.30.10.21.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 10:21:49 -0700 (PDT)
Message-ID: <44d4f3e3-2c3e-f3a3-8917-72399a084356@linaro.org>
Date: Tue, 30 May 2023 10:21:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] target/arm: use x86 intrinsics to implement AES
 instructions
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20230530135204.2903761-1-ardb@kernel.org>
 <666b4b6c-380e-142e-9348-823006b35312@linaro.org>
 <CAMj1kXEE3X=m9X9DkMu885w=Vperp100NWcJ33XOTDm0O+1sWQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAMj1kXEE3X=m9X9DkMu885w=Vperp100NWcJ33XOTDm0O+1sWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 5/30/23 09:58, Ard Biesheuvel wrote:
> On Tue, 30 May 2023 at 18:43, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 5/30/23 06:52, Ard Biesheuvel wrote:
>>> +#ifdef __x86_64__
>>> +    if (have_aes()) {
>>> +        __m128i *d = (__m128i *)rd;
>>> +
>>> +        *d = decrypt ? _mm_aesdeclast_si128(rk.vec ^ st.vec, (__m128i){})
>>> +                     : _mm_aesenclast_si128(rk.vec ^ st.vec, (__m128i){});
>>
>> Do I correctly understand that the ARM xor is pre-shift
>>
>>> +        return;
>>> +    }
>>> +#endif
>>> +
>>>        /* xor state vector with round key */
>>>        rk.l[0] ^= st.l[0];
>>>        rk.l[1] ^= st.l[1];
>>
>> (like so)
>>
>> whereas the x86 xor is post-shift
>>
>>> void glue(helper_aesenclast, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
>>> {
>>>      int i;
>>>      Reg st = *v;
>>>      Reg rk = *s;
>>>
>>>      for (i = 0; i < 8 << SHIFT; i++) {
>>>          d->B(i) = rk.B(i) ^ (AES_sbox[st.B(AES_shifts[i & 15] + (i & ~15))]);
>>>      }
>>
>> (like so, from target/i386/ops_sse.h)?
>>
> 
> Indeed. Using the primitive operations defined in the AES paper, we
> basically have the following for n rounds of AES (for n in {10, 12,
> 14})
> 
> for (n-1 rounds) {
>    AddRoundKey
>    ShiftRows
>    SubBytes
>    MixColumns
> }
> AddRoundKey
> ShiftRows
> SubBytes
> AddRoundKey
> 
> AddRoundKey is just XOR, but it is incorporated into the instructions
> that combine a couple of these steps.
> 
> So on x86, we have
> 
> aesenc:
>    ShiftRows
>    SubBytes
>    MixColumns
>    AddRoundKey
> 
> aesenclast:
>    ShiftRows
>    SubBytes
>    AddRoundKey
> 
> and on ARM we have
> 
> aese:
>    AddRoundKey
>    ShiftRows
>    SubBytes
> 
> aesmc:
>    MixColumns
> 
> 
>> What might help: could we do the reverse -- emulate the x86 aesdeclast instruction with
>> the aarch64 aesd instruction?
>>
> 
> Help in what sense? To emulate the x86 instructions on a ARM host?

Well that too.  I meant help me understand the two primitives.

> But yes, aesenclast can be implement using aese in a similar way,
> i.e., by passing a {0} vector as the round key into the instruction,
> and performing the XOR explicitly using the real round key afterwards.

Excellent, thanks.


r~

