Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B51770B532
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 08:40:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0zDD-0000yO-1Y; Mon, 22 May 2023 02:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0zD8-0000v1-Ub
 for qemu-devel@nongnu.org; Mon, 22 May 2023 02:40:03 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0zCu-0007qz-KJ
 for qemu-devel@nongnu.org; Mon, 22 May 2023 02:40:02 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f6042d610fso7972095e9.1
 for <qemu-devel@nongnu.org>; Sun, 21 May 2023 23:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684737587; x=1687329587;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ziJGrcpZMFVJf/Djn7qKg2eNeHrS7yl4PYZwZSIWiJU=;
 b=HwDP2Jdb5+HHRmfBShsKl6HELCNBQ53W42jh8657QViYUHvrOZJbQnZg+i5mv+OTVj
 Y6MSNjZDjESOQP2QAONORE1D9EBC8bXGMYzn418hO2TBgULGP4uInvHVY7fqyoQ7Hkxh
 1z74H1TuydPhbX5ApKJpWm+bF2VQH0IFmFpfRjfVj+VikOvBwsV2h521R1+L96xK7wid
 +keaUZmyGgOB2R3Nrsz4olv9qgZIUgRyUiEp1TWeAfkP7Pie5yFJYYUSM4ejjxGvcPjv
 c88VfLYQ4vBM5ScsKJfweDl6ntIaUIKugKfLfJQ9a45Mdzo/2XO3wBwq8uOXwyJRYmNP
 w8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684737587; x=1687329587;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ziJGrcpZMFVJf/Djn7qKg2eNeHrS7yl4PYZwZSIWiJU=;
 b=KZntherIFVAg9qLowroPSSlVXdQHgcJS7D1BLDvxqo8euB1RYaH5en7q1rXCgZx6Ab
 1zbdTbwWThUPBf2XStnhC9GkPsQNo6X61WiLTIoVmXLrYA6xqLeFCwJHJx8MEKmI2ifI
 ltXv140mtDZE+HLiWEzSMQAIRkV/MKYidt2GS0BsIx0sk4TCy/Yx4IxGZTPhKu8E1wIt
 jp5bXabXYEF+N30NYmWJxtnX4w8PkWmQZz16QaE+I08oGjvKRh5mcWY72VqpPgSx2ozL
 qbd8SWC1V1ExoMLBHeE8Q+VXLhqcDawOuLZWaySW8raVGab6C7JwEB21vNijw4aDRhqC
 QREA==
X-Gm-Message-State: AC+VfDyW23ecIMMWa+dK3/Ecl9NnsM9I1qNJ05s33g1peGtRGXSFuXvn
 AxJQzXbxKHBgEVncMti7/yScpQ==
X-Google-Smtp-Source: ACHHUZ5SiBH90Oi1H7gqeZGfdMYcPyOhQBUjVeS1csUuOS4ouGrRXv0QUqHKh/H9OdZoiz4BEuf/hA==
X-Received: by 2002:a7b:c8ce:0:b0:3f6:15f:e401 with SMTP id
 f14-20020a7bc8ce000000b003f6015fe401mr2745309wml.37.1684737586898; 
 Sun, 21 May 2023 23:39:46 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.153.164])
 by smtp.gmail.com with ESMTPSA id
 m39-20020a05600c3b2700b003f07ef4e3e0sm26340707wms.0.2023.05.21.23.39.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 May 2023 23:39:46 -0700 (PDT)
Message-ID: <5a8ef696-5833-5a6d-7b60-e946f0bdcdb7@linaro.org>
Date: Mon, 22 May 2023 08:39:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 16/27] accel/tcg: Unify cpu_{ld,st}*_{be,le}_mmu
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
 <20230520162634.3991009-17-richard.henderson@linaro.org>
 <8d6e67d7-52c0-aa60-76cb-bf70d586cf7a@linaro.org>
 <015fb09b-6f34-dec4-d241-8fc5c9a44d7e@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <015fb09b-6f34-dec4-d241-8fc5c9a44d7e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 21/5/23 17:00, Richard Henderson wrote:
> On 5/21/23 04:15, Philippe Mathieu-Daudé wrote:
>> Hi Richard,
>>
>> On 20/5/23 18:26, Richard Henderson wrote:
>>> With the current structure of cputlb.c, there is no difference
>>> between the little-endian and big-endian entry points, aside
>>> from the assert.  Unify the pairs of functions.
>>>
>>> The only use of the functions with explicit endianness was in
>>> target/sparc64, and that was only to satisfy the assert.
>>
>> I'm having hard time to follow all the handling of the various
>> ASI definitions from target/sparc/asi.h. ...
>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   include/exec/cpu_ldst.h     |  58 ++-----
>>>   accel/tcg/cputlb.c          | 122 +++-----------
>>>   accel/tcg/user-exec.c       | 322 ++++++++++--------------------------
>>>   target/arm/tcg/m_helper.c   |   4 +-
>>>   target/sparc/ldst_helper.c  |  18 +-
>>>   accel/tcg/ldst_common.c.inc |  24 +--
>>>   6 files changed, 137 insertions(+), 411 deletions(-)
>>
>>
>>> diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
>>> index 7972d56a72..981a47d8bb 100644
>>> --- a/target/sparc/ldst_helper.c
>>> +++ b/target/sparc/ldst_helper.c
>>> @@ -1334,25 +1334,13 @@ uint64_t helper_ld_asi(CPUSPARCState *env, 
>>> target_ulong addr,
>>
>>
>> Shouldn't we propagate the ASI endianness?
> 
> Already done in translate, get_asi():
> 
>          /* The little-endian asis all have bit 3 set.  */
>          if (asi & 8) {
>              memop ^= MO_BSWAP;
>          }

Just in front of my eyes 🤦‍♂️ So:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Maybe amend the commit description "The ASI endianness is
already taken care of in get_asi() ..."?


While looking at get_asi(), ASI_FL16_* cases overwrite
'memop', possibly discarding MO_ALIGN bit. Maybe this can't
happen.

