Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 257967660CB
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 02:38:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPBAO-0002LG-AV; Thu, 27 Jul 2023 20:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPBAM-0002H0-DT
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 20:17:10 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPBAK-0003ky-JI
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 20:17:10 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bba2318546so12681685ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 17:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690503427; x=1691108227;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C48ZAd0IrnpMpSqrXdJfsJvbUfMrKePokldpfYASTso=;
 b=wqlKnWEAegs+T3b709ruuvGC78k1SsNfeFkz7vDDIzk89+9VEdpP2sOtMxug5A9Dpv
 My5nXgznO6saECsDp94qHqjZDmSch6K7N9f0CBxdVQxognVQqwxCU9OJZ00e86aJUj59
 nzBTap0CaacfYv/6GzhlEF1iBhN5hDL2DRHBIjx1zgDkkvkT09cs6LJuubDmSivtjf8W
 guRYNGP8E4c8UBiLhfA51Y/3WJfb0kmVNIdqwgdKKTfiucVQ7pCrxlMPrhUAzqtt8AJ3
 gdsrQzNr3Fe+b0/0egEMtwCnG+GLUkjLprI4VWgFdGv6Ot/m5DxW3ZX3nPRKU677ayXo
 xGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690503427; x=1691108227;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C48ZAd0IrnpMpSqrXdJfsJvbUfMrKePokldpfYASTso=;
 b=C9HF2QUpONNImEJUGGIimjz8ufKOvdGj7dI12/3dNp9mjiZSJIH8IzZnbU+DpVqpci
 oaEuQh7awmxwdxHyG8wX1xsEQvnxpa4nnhDi83vi/G7fcgb8XeWj2VgQgCt8XNQl4A5D
 vyOF19nTTgoqHzsjrDWCzAhfLIiqHh2C+iXkIsMDUUX+rsJtwl+Hqu+ijnZpz/6VYS9i
 CcJSaBXT33FejUwfzLieeFDKW/NDF6O6SdhSU/oUUNDUD74wJLcdgU7+TlWeSnS0AkSv
 Bw3GxsCwtVVm1MVDG/uefNQwX4+mFQhiO3Dh30lN7EKdr/O80jbEkN3ZFEVSUCkPg/EV
 u4TA==
X-Gm-Message-State: ABy/qLbXv/bSFmCBMG9eY98VNWcIfIYAoclxM5VMKWGgrIwNAvILirke
 EuOMfrx+AX5DA87LtMk9GQndt2bC6DteFraY2Vw=
X-Google-Smtp-Source: APBJJlE6QJIDqlkcMLHdVKyMj1XQFXPvv1Q0+He4wJ0/r/pxq2z6+kZLB3V+sybBflfBFY5YKPmNJQ==
X-Received: by 2002:a17:902:ee4d:b0:1b8:a31b:ac85 with SMTP id
 13-20020a170902ee4d00b001b8a31bac85mr138226plo.41.1690503426784; 
 Thu, 27 Jul 2023 17:17:06 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:943b:b6e1:1f00:9721?
 ([2602:ae:154e:c001:943b:b6e1:1f00:9721])
 by smtp.gmail.com with ESMTPSA id
 2-20020a170902e9c200b001bba27d1b65sm2207459plk.85.2023.07.27.17.17.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 17:17:06 -0700 (PDT)
Message-ID: <3a3c124a-23ca-08fd-661e-53023fc2be6e@linaro.org>
Date: Thu, 27 Jul 2023 17:17:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] target/i386: Truncate ESP when exiting from long mode
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230726081710.1051126-1-ardb@kernel.org>
 <67a8967e-338a-fbd1-1c06-d5a35f2db509@linaro.org>
 <173fb35e-a4c3-4112-afd9-b313c6d95b2e@linaro.org>
 <CAMj1kXGwZFzpU7hcJn625LfBTMB8g6mumvRneKGOabXRc9XtCw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAMj1kXGwZFzpU7hcJn625LfBTMB8g6mumvRneKGOabXRc9XtCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/27/23 14:36, Ard Biesheuvel wrote:
> On Thu, 27 Jul 2023 at 19:56, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 7/26/23 08:01, Richard Henderson wrote:
>>> On 7/26/23 01:17, Ard Biesheuvel wrote:
>>>> Hints welcome on where the architectural behavior is specified, and in particular,
>>>> whether or not other 64-bit GPRs can be relied upon to preserve their full 64-bit
>>>> length values.
>>>
>>> No idea about chapter and verse, but it has the feel of being part and parcel with the
>>> truncation of eip.  While esp is always special, I suspect that none of the GPRs can be
>>> relied on carrying all bits.
>>
>> Coincidentally, I was having a gander at the newly announced APX extension [1],
>> and happened across
>>
>> 3.1.4.1.2 Extended GPR Access (Direct and Indirect)
>>
>>       ... Entering/leaving 64-bit mode via traditional (explicit)
>>       control flow does not directly alter the content of the EGPRs
>>       (EGPRs behave similar to R8-R15 in this regard).
>>
>> which suggests to me that the 8 low registers are squashed to 32-bit
>> on transition to 32-bit IA-32e mode.
>>
>> I still have not found similar language in the main architecture manual.
>>
> 
> Interesting - that matches my observations on those Ice Lake cores:
> RSP will be truncated, but preserving/restoring it to/from R8 across
> the exit from long mode works fine.

Found it:

Volume 1 Basic Architecture
3.4.1.1 General-Purpose Registers in 64-Bit Mode

# Registers only available in 64-bit mode (R8-R15 and XMM8-XMM15)
# are preserved across transitions from 64-bit mode into compatibility mode
# then back into 64-bit mode. However, values of R8-R15 and XMM8-XMM15 are
# undefined after transitions from 64-bit mode through compatibility mode
# to legacy or real mode and then back through compatibility mode to 64-bit mode.


r~

