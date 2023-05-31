Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DB6718827
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 19:10:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4PJj-0002xP-6c; Wed, 31 May 2023 13:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4PJh-0002wf-JN
 for qemu-devel@nongnu.org; Wed, 31 May 2023 13:08:57 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4PJg-0004xZ-03
 for qemu-devel@nongnu.org; Wed, 31 May 2023 13:08:57 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-256c8bed212so1192053a91.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 10:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685552934; x=1688144934;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sBMrABB9Qj89rgVrPECZc5SgBeBIp80s+Map8XvbmnA=;
 b=kH0+eb8E0suzs1M6Tjepu9Bf5AIuv2LaO17PvdL2bxYdnV2ylYCRIdpSw6CX3B9in2
 UJ/s8EsI+FizdBZergS43J1TNphGFaZpWaiFL7YY/xPr2MYGMY6I35Ko60SjzbcbwH7y
 6kGHoXIWKCMXEIXxH7SlBa9sjRX0T68jaY+4X87Rw9glt7TG/+H6OwYHdji/bwYdkZ8E
 aNTigaixxLn8fSOZarFqyxvgwaRcA2iNkHRDISmejJvzjT3nVBe9hcMnnl+Zq/MIx4F4
 6tkp/W1K4gvXvYxegVnq6XJ6CyxMFhLyocuUKUoYnOJyLfoO78llUm109K+bwpabBHOk
 Fqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685552934; x=1688144934;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sBMrABB9Qj89rgVrPECZc5SgBeBIp80s+Map8XvbmnA=;
 b=gW7vwaS7nf1tK54AQJ3/ON7vXH1wMBcWSDmifPs2si2iejNEisU7Q9GWzg0fXDF4sy
 dqdasUYy2iGw/1t2RFS+Iq7mL1B4zpARY1PhyBCGDBdJuZFvzCOx1qfgt10XIBK1pbYu
 h4okqEVI5RS3dxCrUVTgJyCT8lNVeZpx3BjB0k6Z85j+C2ZbtlhL3gdsFTqTAO0zgZJz
 AmtFhzj/ExBFOQrlB/MBk0p8sJ9jWuNR2Lt6kBYlOEfvGWxMjWfH71p70gRe6HKbuVdh
 uETaO8IKS+eFwqwc2v4pRxd+/oTfbGdup6+fKUfpLaPweW3qJxTPTykes5z4MrEUUyaj
 MxRg==
X-Gm-Message-State: AC+VfDzEItmydFHVxIfTEnz2MVsi6ObvK3wkNtyOQs3wFAOpi5XdZejn
 /i4NZhZnfiPV+WmC0Bs9PfPdhg==
X-Google-Smtp-Source: ACHHUZ74PaikpnuvV4qwCII57TIQj17aSJw+XSMX75ptji8Qj2xkf7fnW3huEHscDoMArssWQokhIw==
X-Received: by 2002:a17:90a:8b92:b0:258:817a:814e with SMTP id
 z18-20020a17090a8b9200b00258817a814emr950347pjn.28.1685552933695; 
 Wed, 31 May 2023 10:08:53 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a654848000000b0050f85ef50d1sm1438903pgs.26.2023.05.31.10.08.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 10:08:53 -0700 (PDT)
Message-ID: <c8499cae-befb-7130-3114-350ee97bf49d@linaro.org>
Date: Wed, 31 May 2023 10:08:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/2] Implement AES on ARM using x86 instructions and vv
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20230531112239.3164777-1-ardb@kernel.org>
 <722d7683-80b4-bb23-3ca2-77f8de23b801@linaro.org>
 <CAMj1kXEH4zFcOZGz0HvTbpcMUup+cyZEr0JQxH1uXpGcbAc6ow@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAMj1kXEH4zFcOZGz0HvTbpcMUup+cyZEr0JQxH1uXpGcbAc6ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 5/31/23 09:47, Ard Biesheuvel wrote:
> On Wed, 31 May 2023 at 18:33, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 5/31/23 04:22, Ard Biesheuvel wrote:
>>> Use the host native instructions to implement the AES instructions
>>> exposed by the emulated target. The mapping is not 1:1, so it requires a
>>> bit of fiddling to get the right result.
>>>
>>> This is still RFC material - the current approach feels too ad-hoc, but
>>> given the non-1:1 correspondence, doing a proper abstraction is rather
>>> difficult.
>>>
>>> Changes since v1/RFC:
>>> - add second patch to implement x86 AES instructions on ARM hosts - this
>>>     helps illustrate what an abstraction should cover.
>>> - use cpuinfo framework to detect host support for AES instructions.
>>> - implement ARM aesimc using x86 aesimc directly
>>>
>>> Patch #1 produces a 1.5-2x speedup in tests using the Linux kernel's
>>> tcrypt benchmark (mode=500)
>>>
>>> Patch #2 produces a 2-3x speedup. The discrepancy is most likely due to
>>> the fact that ARM uses two instructions to implement a single AES round,
>>> whereas x86 only uses one.
>>
>> Thanks.  I spent some time yesterday looking at this, with an encrypted disk test case and
>> could only measure 0.6% and 0.5% for total overhead of decrypt and encrypt respectively.
>>
> 
> I don't understand what 'overhead' means in this context. Are you
> saying you saw barely any improvement?

I saw, without changes, just over 1% of total system emulation time was devoted to aes, 
which gives an upper limit to the runtime improvement possible there.  But I'll have a 
look at tcrypt.

> aesenc_MC() can be implemented on x86 the way I did in patch #!, using
> aesdeclast+aesenc

Oh, nice.  I have not read the actual patches yet.

>> ppc64:
>>
>>       asm("lxvd2x 32,0,%1;"
>>           "lxvd2x 33,0,%2;"
>>           "vcipher 0,0,1;"
>>           "stxvd2x 32,0,%0"
>>           : : "r"(o), "r"(i), "r"(k), : "memory", "v0", "v1", "v2");
>>
>> ppc64le:
>>
>>       unsigned char le[16] = {8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7};
>>       asm("lxvd2x 32,0,%1;"
>>           "lxvd2x 33,0,%2;"
>>           "lxvd2x 34,0,%3;"
>>           "vperm 0,0,0,2;"
>>           "vperm 1,1,1,2;"
>>           "vcipher 0,0,1;"
>>           "vperm 0,0,0,2;"
>>           "stxvd2x 32,0,%0"
>>           : : "r"(o), "r"(i), "r"(k), "r"(le) : "memory", "v0", "v1", "v2");
>>
>> There are also differences in their AES_Te* based C routines as well, which made me wonder
>> if we are handling host endianness differences correctly in emulation right now.  I think
>> I should most definitely add some generic-ish tests for this...
>>
> 
> The above kind of sums it up, no? Or isn't this working code?

It sums up the problem.  It works to produce the same output as the x86 instructions, with 
input bytes in the same order.  It shows that we have to extra careful emulating vcipher 
etc, and should have unit tests.


r~


