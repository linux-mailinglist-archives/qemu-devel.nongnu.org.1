Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDC575DBFD
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 13:48:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNB4r-0001Ss-Dh; Sat, 22 Jul 2023 07:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNB4o-0001SQ-VE
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 07:47:11 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNB4n-0004lK-56
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 07:47:10 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31751d7d96eso13554f8f.1
 for <qemu-devel@nongnu.org>; Sat, 22 Jul 2023 04:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690026427; x=1690631227;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xTnh49j03+UFmLnHyoaIEmCaZnJMGNY5vU+4DQW1iDY=;
 b=ygzyOfQWzh7dnofI9PRUpqtswZlHP93lQM+0dbnz+lpnvNePWGqOb0GjH/riha8Ufg
 pqqXhqd/dkwda4p0HqKHq6gll0nclVSv9qpr9RDxdQa7p1034jAc2kDSK9adqLYVdJ9Y
 GAwBcFc2FPpCtG5b4yomfEyhZfDJGcmccwbd5vY48hcPuXcNFqQi7YhrG+s9NSqC14Oo
 mSWzdcVA3SxTCHlic4yDmDMGddIpP7Yvs2MHzW07gqfC/4tkP9K6N57zU+lKQdwNacoW
 egDzZOf4b3PHroq4ONax9NQHPytpDzmRYyCSSyeWra+hQMw+EjRGkdNwk9+JvtRex0+Z
 RQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690026427; x=1690631227;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xTnh49j03+UFmLnHyoaIEmCaZnJMGNY5vU+4DQW1iDY=;
 b=SFcJjeFUTPSdgIl0DNzKmeCdeDHKZfZtzHCs80f96ZI3LmGQsNk7tpDjfT7EkDmXv7
 Akc4zctqhVaSsi3NT05exR4m5JTWla64+Dmrxuo+c8g+QTiHeO2EVPGB0z2rOd2vG0Rn
 CyoGJ3YPf3b0sGunrVqmpI4tOZrj7HSYCoMAKevFQYz5Y6GV1c8AbS3Lct3M18DFr0Nc
 F845WMy9vfDtcVQ4ZG8fTE8NMH4e7oclzLVLU121oHFCt5MNfTDh3K9s/0S2bsPVxNcr
 YZd1enQHBe2MYzprOLBLeEM9Rw96CNfTHJ5ZmGhokoKuHZjsrJjZ1IiK7TPFXr+6DUZ1
 ldTg==
X-Gm-Message-State: ABy/qLbBGJYQAWsFcp9PNyACPRknLIl+vTRp/YavLxNtuPOIZLC8lrVS
 dOtp8vDRMapu2yIx6L4RACFhfqKSWjkdhXNPXdzGmg==
X-Google-Smtp-Source: APBJJlGWkYi32esrTykg0YHWZBpJ/2c/0dawyhRR+3Ogoedp+G3SOZWqFhZk5XOYQFfRevOYKPX6SQ==
X-Received: by 2002:a5d:4e8f:0:b0:314:2ea7:af4a with SMTP id
 e15-20020a5d4e8f000000b003142ea7af4amr3816770wru.13.1690026427232; 
 Sat, 22 Jul 2023 04:47:07 -0700 (PDT)
Received: from [172.20.1.187]
 (179.181-106-213.static.virginmediabusiness.co.uk. [213.106.181.179])
 by smtp.gmail.com with ESMTPSA id
 u6-20020a05600c00c600b003fbb5142c4bsm8028431wmm.18.2023.07.22.04.47.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Jul 2023 04:47:06 -0700 (PDT)
Message-ID: <270eee6c-8917-5697-80be-0b8aa390ff25@linaro.org>
Date: Sat, 22 Jul 2023 12:47:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 17/18] host/include/i386: Implement clmul.h
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, ardb@kernel.org
References: <20230713211435.13505-1-richard.henderson@linaro.org>
 <20230713211435.13505-18-richard.henderson@linaro.org>
 <e55cdccbd4bee15a091ae47b99a3d98c9d2654f5.camel@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e55cdccbd4bee15a091ae47b99a3d98c9d2654f5.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
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

On 7/19/23 12:52, Ilya Leoshkevich wrote:
> On Thu, 2023-07-13 at 22:14 +0100, Richard Henderson wrote:
>> Detect PCLMUL in cpuinfo; implement the accel hooks.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   host/include/i386/host/cpuinfo.h        |   1 +
>>   host/include/i386/host/crypto/clmul.h   | 187
>> ++++++++++++++++++++++++
>>   host/include/x86_64/host/crypto/clmul.h |   1 +
>>   util/cpuinfo-i386.c                     |   1 +
>>   4 files changed, 190 insertions(+)
>>   create mode 100644 host/include/i386/host/crypto/clmul.h
>>   create mode 100644 host/include/x86_64/host/crypto/clmul.h
> 
> ...
> 
>> diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
>> index 3a7b7e0ad1..c6f6364826 100644
>> --- a/util/cpuinfo-i386.c
>> +++ b/util/cpuinfo-i386.c
>> @@ -39,6 +39,7 @@ unsigned __attribute__((constructor))
>> cpuinfo_init(void)
>>           info |= (c & bit_SSE4_1 ? CPUINFO_SSE4 : 0);
>>           info |= (c & bit_MOVBE ? CPUINFO_MOVBE : 0);
>>           info |= (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
>> +        info |= (c & bit_PCLMULQDQ ? CPUINFO_PCLMUL : 0);
> 
> I wanted to give this a try, but my cpuid.h has only
> bit_VPCLMULQDQ, and I don't see it in [1] either.

Should have been bit_PCLMUL (VPCLMULQDQ is for the 256- and 512-bit inputs).  I'll have to 
track down why this compiled for me.

> Where is this supposed to come from? Does qemu/cpuid.h need an update?

Yes, an update is required.


r~

