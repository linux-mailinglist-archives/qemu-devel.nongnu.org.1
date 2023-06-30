Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7AC743CB7
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:26:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE6g-0006qL-A5; Fri, 30 Jun 2023 09:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE6c-0006fR-3e
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:24:10 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE6a-0003r1-AH
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:24:09 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fba5a8af2cso18772235e9.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688131447; x=1690723447;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XcrqOs7jhyg4WP0KzDf5XnM+cYYEbHQBa1mTd/EFauU=;
 b=ty0V331LgCQQMQFkp+1ceSMIzL68K0PhW00nVs3D1bZ1YdOOr7dCZ6godQPZSIt8Cf
 o2nBZE/h9PZmWi3U1qdzpGdX9l3VjMJZc8XRazSTOVMORhO/IgvAzVkyfTNJ5LzSSlT2
 GMCm49LvK8eXUZyqab8lrk+Gi84JspUyAB7OrrtG9S6gSFmruUwXjBzLKJPJucQE6Yk4
 KFveYba8RPnNDe24a07sj0t8bGGuwDrYrrZA8BqxY5ZqLgnD+9EdC9KzI+mm94UyjHat
 hXlMxfRm8IJYd+g1l3tBcX9cykKQqQiOSIVMqm3dbhsIxd7pliej8aHhDxpKxKSaxDeX
 IjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688131447; x=1690723447;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XcrqOs7jhyg4WP0KzDf5XnM+cYYEbHQBa1mTd/EFauU=;
 b=LJMrSHtw6/6Iv8WKHAku4TgaIpPSPRq2S4ntHScFoNthCe6+J/4RCfi4mrUVsf8Dhk
 noe5egCVrDA4PQbqorczEnGf72bZOZkQzchopjh2ExcpQxzd2hFiUeBHaw7+DpneqIC0
 KNN4lBFsfab2X+ksb5Jt9bOhgEAo4FToDr8HDG0zHpn/VZcxni4YxZ++Z8mpXZk42x4S
 gh+nZnpp4tFSsi/djR4S2KoBEcbS1YGrqHnxfAh8+BUf46nBUacPT9c2rZakfqsBt1Hs
 8KNJCI6alTAA4L6zGuiDS6YxTy/tXtoc6pJLYjV39+ftYaTuQkKnOecGxzna3cSvjjUT
 /P+g==
X-Gm-Message-State: AC+VfDxzkbw681XEhgciqH2mdHXo9mOtNqbHi5E3YMkDNW6Z0nnKTEc+
 7Y0CGkytD2nyXtXns5oWcmfMYH9WpBU4XDMckzyl/Q==
X-Google-Smtp-Source: ACHHUZ7cf9w1LEow5YCcAdJsjjeyuPPSMyaQk+kyQTh8mPJ6UBMcVsDvdL/VCib1CHC16V6pXB9NPQ==
X-Received: by 2002:a05:600c:cf:b0:3fb:a102:6d7a with SMTP id
 u15-20020a05600c00cf00b003fba1026d7amr1803736wmm.28.1688131446680; 
 Fri, 30 Jun 2023 06:24:06 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 v14-20020a1cf70e000000b003f9b2c602c0sm22037595wmh.37.2023.06.30.06.24.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 06:24:06 -0700 (PDT)
Message-ID: <018c47b2-6cbe-8aca-2b6d-86541b05194f@linaro.org>
Date: Fri, 30 Jun 2023 15:24:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 3/5] tcg: add perfmap and jitdump
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 "Vanderson M . do Rosario" <vandersonmr2@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230116223637.3512814-1-richard.henderson@linaro.org>
 <20230116223637.3512814-4-richard.henderson@linaro.org>
 <e1112615-0e6c-e0ea-aa60-1d94d1da26ea@linaro.org>
 <e122d115-0d0f-59d2-b593-2210ca1118df@linaro.org>
 <9d6b93c20340059f1a2fbea4a7a531e2e35ba34d.camel@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <9d6b93c20340059f1a2fbea4a7a531e2e35ba34d.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/30/23 14:39, Ilya Leoshkevich wrote:
> On Thu, 2023-06-29 at 14:59 +0200, Richard Henderson wrote:
>> On 6/29/23 13:31, Philippe Mathieu-Daudé wrote:
>>>> diff --git a/tcg/tcg.c b/tcg/tcg.c
>>>> index da91779890..9b7df71e7a 100644
>>>> --- a/tcg/tcg.c
>>>> +++ b/tcg/tcg.c
>>>> @@ -61,6 +61,7 @@
>>>>    #include "exec/log.h"
>>>>    #include "tcg/tcg-ldst.h"
>>>>    #include "tcg-internal.h"
>>>> +#include "accel/tcg/perf.h"
>>>
>>> Is it OK to include an header from QEMU's accel/tcg/ here?
>>> I thought we wanted to keep tcg/ kinda independant (or maybe
>>> this is already too late and this isn't a concern anymore).
>>
>> It's not ideal, no.  Perf really should live in tcg/.
>>
>>
>> r~
> 
> This would require to somehow get rid of this:
> 
> #if defined(TARGET_I386)
>              q[insn].address -= tb->cs_base;
> #endif
> 
> I'll try to come up with a patch.

Just drop it?  Did you really want EIP instead of the full virtual address?
It only makes a difference for 16-bit mode anyway.


r~

