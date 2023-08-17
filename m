Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 657A07800BF
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 00:06:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWl7B-0005BT-Op; Thu, 17 Aug 2023 18:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWl71-0005BI-1a
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 18:05:03 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWl6y-0000E0-Nb
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 18:05:02 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bef089ac8aso2443755ad.2
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 15:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692309899; x=1692914699;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HoULJOCHMuV/YzdDdCXXJhGcACVsYiG6Y0K1IRxFiUM=;
 b=O2rCdLj5E09CUMsMhitl1ggO+fCakGU0fjrx6HLIb/uwkpQg6RJE0U3ZZ+V49FWtNS
 C0QT3Tu6sQc5DSar6eg8k2e3rmrT/QLQFE0F4aIYMca9jx5mJKURRIf4vRJlry9wT+X4
 AWzAUN7/FEB/uBaTskGwrPZ13M9ctuwci6k8yZgVVpqv3/k8lBSLrG9rwvG+pXMIPVQp
 650uWS04JOpoB05U+cBFFYNOojyJLz1Aw5aR8PM9t1qGyxmHim6sPUJPcqk4FJtZV1XA
 cZmoCbrieKSVF+SN4Ua9S7WVhALs3oJ0ITEpPzVWQDholx/314sgtG+KHJpoSbFwnJeZ
 kfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692309899; x=1692914699;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HoULJOCHMuV/YzdDdCXXJhGcACVsYiG6Y0K1IRxFiUM=;
 b=jaGD7QnT7oF32GiVnLUZb9xLFAL2Df+4IlH+0slIBFTDmXG8cMTzfgfYSgg2nHCa/D
 GoM5a2g4BXAP+UsUfjo3g20mxiugC4yF24ULt9ehy9LLfjrGKW55QDq6wr7lAvyp9NE9
 H8Iw+OWRPxbrmErG347MlKKN4m4BaR4HrrMYxhXNSX/8zkVEGQWZXY4WKZcu29cbbKBK
 HC3VNEnIrWoYPc1Ot5sPUgwjDlE7iukjhX/74MZXp89z0SxhGAFxvzBiMy9rnuaSRz5B
 YLs3s5MtNwy75w2oz/zMuJUk3ssRRSWaisa3TITlcoath6zHQHObB/Na1E2uIMdi19JL
 cOaQ==
X-Gm-Message-State: AOJu0YwC9FpTVh0mjAleQR7GEx8cyJjjbZ7Vd74rYsCJgo8vLmNpEp7x
 PyDeoMvP5a5WlEB7mNlx/3Q8qc6a0lXDljWCi5U=
X-Google-Smtp-Source: AGHT+IGUhN3WVe84deOhFyk/60mIQjV6kxLK7VwZzKp8/+f6ZSHcvgz1gPsxXwX/KM3gxZe0aqxpsw==
X-Received: by 2002:a17:90a:3d0d:b0:26d:1eec:1fc4 with SMTP id
 h13-20020a17090a3d0d00b0026d1eec1fc4mr761737pjc.19.1692309898855; 
 Thu, 17 Aug 2023 15:04:58 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:12cd:355a:c01e:3596?
 ([2602:47:d483:7301:12cd:355a:c01e:3596])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a170902ee0200b001bbb1eec92esm242273plb.281.2023.08.17.15.04.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Aug 2023 15:04:58 -0700 (PDT)
Message-ID: <6740b717-c163-752f-2f6d-601faf46cb12@linaro.org>
Date: Thu, 17 Aug 2023 15:04:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] tcg/i386: Drop BYTEH deposits for 64-bit
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20230816145547.477974-1-richard.henderson@linaro.org>
 <20230816145547.477974-2-richard.henderson@linaro.org>
 <CAFEAcA94YWgNRi_6Z8Ww5b6O2GncB-cqF-X8yr31UzFJEwJQXw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA94YWgNRi_6Z8Ww5b6O2GncB-cqF-X8yr31UzFJEwJQXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.01,
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

On 8/17/23 08:44, Peter Maydell wrote:
> On Wed, 16 Aug 2023 at 16:01, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> It is more useful to allow low-part deposits into all registers
>> than to restrict allocation for high-byte deposits.
> 
>>   #define TCG_TARGET_deposit_i32_valid(ofs, len) \
>> -    (((ofs) == 0 && (len) == 8) || ((ofs) == 8 && (len) == 8) || \
>> -     ((ofs) == 0 && (len) == 16))
>> +    (((ofs) == 0 && ((len) == 8 || (len) == 16)) || \
>> +     (TCG_TARGET_REG_BITS == 32 && (ofs) == 8 && (len) == 8))
>>   #define TCG_TARGET_deposit_i64_valid    TCG_TARGET_deposit_i32_valid
> 
> 
>> @@ -2752,7 +2751,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
>>           if (args[3] == 0 && args[4] == 8) {
>>               /* load bits 0..7 */
>>               tcg_out_modrm(s, OPC_MOVB_EvGv | P_REXB_R | P_REXB_RM, a2, a0);
>> -        } else if (args[3] == 8 && args[4] == 8) {
>> +        } else if (TCG_TARGET_REG_BITS == 32 && args[3] == 8 && args[4] == 8) {
> 
> Should we assert(TCG_TARGET_REG_BITS == 32) rather than making it part of the
> condition?

The if/else chain ends in g_assert_not_reached().

> If I understand the change to the deposit_i32_valid macro above, we
> should never get here with 8, 8 if TCG_TARGET_REG_BITS is 64.

Correct.


r~

