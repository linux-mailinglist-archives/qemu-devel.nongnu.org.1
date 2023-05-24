Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F38870EA38
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 02:28:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1cL5-0005D0-U1; Tue, 23 May 2023 20:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1cL3-0005Cc-QE
 for qemu-devel@nongnu.org; Tue, 23 May 2023 20:26:49 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1cL2-0000fl-6C
 for qemu-devel@nongnu.org; Tue, 23 May 2023 20:26:49 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1ae763f9c0bso2373645ad.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 17:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684888006; x=1687480006;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s0B2h9izgA+k2mfVDOmCiF+WjBKBcoW1TtiyQVaHa84=;
 b=jv7vmPUkjENAMpVGfzh1CA85dVv0s90ixtWZx0flrRY9WAR3Dl8kt3rL6ijovRVNza
 rIfJzuvxEKjIAC6GNadi64LuSaq+Bun8A/SX+V+ejqQ9iVJly76SvSUMgGXRdHDdOhL0
 MZ32Epm3TOvW+41cI5ye5RtIgJT9graVsUvE8uTgCZUpzL54prTEfZAF20O7HwLQ3wNB
 eSqM8IDNc1vilYtI448jRLwjb+ZNN7AHUEtATL3kTUrlOSq40PHlRzzrbpXkBtMRWQgS
 DqmNWlqPUIB5eCP3saqmsnAir7Wv/1TF0hAdOERutfZ872jEUocLRwSr2xdV4/tmP7Gi
 1ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684888006; x=1687480006;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s0B2h9izgA+k2mfVDOmCiF+WjBKBcoW1TtiyQVaHa84=;
 b=JgQQPsK3RM4u9ns8IobJ1BlIVuwLcjRVk8JaZTNmpF+9XFIifQgYzYrh7OXk/HMZLI
 gvwn69dQXrHclv9gTdBqX87qmlHgcOlOcdt1vnO1Gda6iMNRLfuMM62QgA1KujRpZOBB
 HZFM8BP8wvmdl2+ToUwLWRVnx2Fq8k9nlFbJAKC9DhpHSz7HtLQYYjVdoIgl5CNfvSIs
 SmEWukQmKKtm/PR1UmKpjq7NANj4axe0ma1vj9YrwZtdR4sAB5VwXhwgToYTXr9jFQQF
 LcJz+X5S701ubq/P2C9yETegTUkYK8rweoFKx08ABAfXowCl3zSiyphpDisnxlLrRj/o
 UjLA==
X-Gm-Message-State: AC+VfDzd8DXwr7DzobiVLFCGDGei1+GSYx7mgqFEbdPPWSOx4lj3egoR
 lEQwcdyHWTR3VlN98qlp17m/Dw==
X-Google-Smtp-Source: ACHHUZ6Y7EmBMhRbTq9ojbbJb/RDpeCyHoybCl0/qb/JHlCg/8sq48fAXR+TRjgEKVxmu6rDmq2uxA==
X-Received: by 2002:a17:903:2796:b0:1ac:65ab:cf7b with SMTP id
 jw22-20020a170903279600b001ac65abcf7bmr16057997plb.9.1684888006407; 
 Tue, 23 May 2023 17:26:46 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 p2-20020a170902eac200b001a661000398sm7381972pld.103.2023.05.23.17.26.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 17:26:45 -0700 (PDT)
Message-ID: <d2ce1e82-a46e-0ef3-6583-bd88c22b3022@linaro.org>
Date: Tue, 23 May 2023 17:26:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 45/52] tcg: Define IN_TCG
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
 <20230523135322.678948-46-richard.henderson@linaro.org>
 <45d83422-6222-22cc-dbc4-238ad0e3e8e2@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <45d83422-6222-22cc-dbc4-238ad0e3e8e2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 09:45, Philippe Mathieu-Daudé wrote:
> On 23/5/23 15:53, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/region.c      | 2 ++
>>   tcg/tcg-common.c  | 2 ++
>>   tcg/tcg-op-gvec.c | 2 ++
>>   tcg/tcg-op-ldst.c | 2 ++
>>   tcg/tcg-op-vec.c  | 2 ++
>>   tcg/tcg-op.c      | 2 ++
>>   tcg/tcg.c         | 2 ++
>>   7 files changed, 14 insertions(+)
>>
>> diff --git a/tcg/region.c b/tcg/region.c
>> index bef4c4756f..34ac124081 100644
>> --- a/tcg/region.c
>> +++ b/tcg/region.c
>> @@ -22,6 +22,8 @@
>>    * THE SOFTWARE.
>>    */
>> +#define IN_TCG
>> +
>>   #include "qemu/osdep.h"
>>   #include "qemu/units.h"
>>   #include "qemu/madvise.h"
>> diff --git a/tcg/tcg-common.c b/tcg/tcg-common.c
>> index 35e7616ae9..678ab482f7 100644
>> --- a/tcg/tcg-common.c
>> +++ b/tcg/tcg-common.c
>> @@ -22,6 +22,8 @@
>>    * THE SOFTWARE.
>>    */
>> +#define IN_TCG
>> +
>>   #include "qemu/osdep.h"
>>   #include "tcg/tcg.h"
> 
> [...]
> 
> Could this be enforced via meson instead? Smth like:
> 
>    static_library(tcgcommon.fa,
>                   [tcgcommon_ss.sources()],
>                   c_args: [-DIN_TCG], ...)

Actually, it's rubbish now.  I think this was meant for exec/poison.h, but I'm not 
currently using it there.

r~


