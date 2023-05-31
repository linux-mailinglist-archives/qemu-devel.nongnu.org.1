Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E7F718778
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 18:34:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Ol5-00050o-Ci; Wed, 31 May 2023 12:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Ol3-00050C-4q
 for qemu-devel@nongnu.org; Wed, 31 May 2023 12:33:09 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Ol1-00073q-HE
 for qemu-devel@nongnu.org; Wed, 31 May 2023 12:33:08 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-256c8bed212so1162354a91.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 09:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685550785; x=1688142785;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E9XdHN4DR4rz/qIpPKcoMHbODMY2jSHgCvZ+yzeKQIg=;
 b=H5PRwFMLmxOq2+z0A1V3HP9uVsS/wm1F5igR+3xg1e//smln5Bdw8FMYxPAwYgjRDj
 SUYYxQueob14ehRT8M6eMlTPqbbLtYwQOoW1Kjsucc2Ecraj43YbfuKyngFrNxRhS0vP
 VDxv0PDu9HkSmPlq+f9JYDWqhuDYlYLhN5XXcU9bp/2GdJXNpkiC4guEcRpJtGxfniLM
 Y99cILqlo9jgmhX2gpY7F0ByWT8EPtRApCkrO5kILr+9CrkET1yPFbUN+iOP+9fpaRsp
 2gQR1S/EOr7u7pXVAgtxzulw0/pb6pRFA/MZI7xt3QAWVAbV1Lj1/Vtkimx9C0oW7KnE
 JOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685550785; x=1688142785;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E9XdHN4DR4rz/qIpPKcoMHbODMY2jSHgCvZ+yzeKQIg=;
 b=drjKQv0MXTGcLRUZYd5Y46mS9a7UZkoAKMOgsFJjgAb1foGH4agp7VWi++IXDfPG+r
 ZH8Scc9VsTYnxn8rlgn6OlzbtpU5ScsgGdrjneDMSs6kYAnbwbM/RNUj08Dm4twaBhwc
 9JiCFQlPrdVvMHkJCG0Db4YJnG+biQ7/rfFE7V7vj7onwPZpX73X5ly/UoBIXb5ria3x
 DxJNcrO1ykmtYJGVy5gZzkx/Yx/1jnQCELj8ucE0xiLDWXCQFztJKHFqN1Dlfy0Qx8vM
 LYiNvIcPvbBi7Qgkqne/2HylM7VhDxeTH/Wxqp0p7SFuOXQDzLPVbQ5lvsjxaQSgzHoH
 pGRg==
X-Gm-Message-State: AC+VfDxw06PaqurPbxr+bR/Y8Z3ULPtPMlk98MwIPobLTvZ0qb5Ex9ZC
 eU3HnUYV9Fk0mCqg99tz/BI1ow==
X-Google-Smtp-Source: ACHHUZ4HRGKYn93Fv0m5ktmypcweIU0KhfCXWhKiuQ3X1OL5VgTUi9Z6/4Ukjolt4c2kZFIYqXAB2A==
X-Received: by 2002:a17:90a:a00d:b0:256:2c8e:3008 with SMTP id
 q13-20020a17090aa00d00b002562c8e3008mr4422940pjp.48.1685550785334; 
 Wed, 31 May 2023 09:33:05 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 gp18-20020a17090adf1200b00250ad795d72sm1439921pjb.44.2023.05.31.09.33.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 09:33:04 -0700 (PDT)
Message-ID: <722d7683-80b4-bb23-3ca2-77f8de23b801@linaro.org>
Date: Wed, 31 May 2023 09:33:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/2] Implement AES on ARM using x86 instructions and vv
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20230531112239.3164777-1-ardb@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230531112239.3164777-1-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/31/23 04:22, Ard Biesheuvel wrote:
> Use the host native instructions to implement the AES instructions
> exposed by the emulated target. The mapping is not 1:1, so it requires a
> bit of fiddling to get the right result.
> 
> This is still RFC material - the current approach feels too ad-hoc, but
> given the non-1:1 correspondence, doing a proper abstraction is rather
> difficult.
> 
> Changes since v1/RFC:
> - add second patch to implement x86 AES instructions on ARM hosts - this
>    helps illustrate what an abstraction should cover.
> - use cpuinfo framework to detect host support for AES instructions.
> - implement ARM aesimc using x86 aesimc directly
> 
> Patch #1 produces a 1.5-2x speedup in tests using the Linux kernel's
> tcrypt benchmark (mode=500)
> 
> Patch #2 produces a 2-3x speedup. The discrepancy is most likely due to
> the fact that ARM uses two instructions to implement a single AES round,
> whereas x86 only uses one.

Thanks.  I spent some time yesterday looking at this, with an encrypted disk test case and 
could only measure 0.6% and 0.5% for total overhead of decrypt and encrypt respectively.

> As for the design of an abstraction: I imagine we could introduce a
> host/aes.h API that implements some building blocks that the TCG helper
> implementation could use.

Indeed.  I was considering interfaces like

/* Perform SubBytes + ShiftRows on state. */
Int128 aesenc_SB_SR(Int128 state);

/* Perform MixColumns on state. */
Int128 aesenc_MC(Int128 state);

/* Perform SubBytes + ShiftRows + MixColumns on state. */
Int128 aesenc_SB_SR_MC(Int128 state);

/* Perform SubBytes + ShiftRows + MixColumns + AddRoundKey. */
Int128 aesenc_SB_SR_MC_AK(Int128 state, Int128 roundkey);

and so forth for aesdec as well.  All but aesenc_MC should be implementable on x86 and 
Power7, and all of them on aarch64.

> I suppose it really depends on whether there is a third host
> architecture that could make use of this, and how its AES instructions
> map onto the primitive AES ops above.

There is Power6 (v{,n}cipher{,last}) and RISC-V Zkn (aes64{es,esm,ds,dsm,im})

I got hung up yesterday was understanding the different endian requirements of x86 vs Power.

ppc64:

     asm("lxvd2x 32,0,%1;"
         "lxvd2x 33,0,%2;"
         "vcipher 0,0,1;"
         "stxvd2x 32,0,%0"
         : : "r"(o), "r"(i), "r"(k), : "memory", "v0", "v1", "v2");

ppc64le:

     unsigned char le[16] = {8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7};
     asm("lxvd2x 32,0,%1;"
         "lxvd2x 33,0,%2;"
         "lxvd2x 34,0,%3;"
         "vperm 0,0,0,2;"
         "vperm 1,1,1,2;"
         "vcipher 0,0,1;"
         "vperm 0,0,0,2;"
         "stxvd2x 32,0,%0"
         : : "r"(o), "r"(i), "r"(k), "r"(le) : "memory", "v0", "v1", "v2");

There are also differences in their AES_Te* based C routines as well, which made me wonder 
if we are handling host endianness differences correctly in emulation right now.  I think 
I should most definitely add some generic-ish tests for this...


r~

