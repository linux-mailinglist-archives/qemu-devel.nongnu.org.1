Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A9070E275
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:51:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1VDf-0005mH-I1; Tue, 23 May 2023 12:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1VDb-0005dK-DU
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:50:41 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1VDZ-0005GW-BV
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:50:38 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-30a4ebbda56so3599366f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684860626; x=1687452626;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ohn4MQP12enQ1CEXWZdKBWrJYwnd5m4xki335o4hucs=;
 b=E7ESbRI1un2zYz9cWOxMYk7QdNK7U8aOG0EYa+x2cAF5ctUR+deM7VAe7aoKrc59oo
 t9jF7ladOaTIk7+lH/d9JuS168YY5iPp+qpkkin3FIiwp/pEw/dXsXt4gvHInxoXTu3W
 aYLxgfS2VknS//lNzpXjhsor5zVqykQfRMjS144q6x+LWjBaRxdAmbQEwelAJ8rCZ956
 oRB4tvNwQjr/n8pEtWMXfaR4i3YKSjS/aRUGFmdFe0TxRteiJcv9TECzdX4LAFltzXlZ
 njN1AaUJ3fkxUNo9orAjwHNAfCt4mI4/BMqwTmrctQDpYjlt9doS0ZJHiUoN4uwINPn5
 oiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684860626; x=1687452626;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ohn4MQP12enQ1CEXWZdKBWrJYwnd5m4xki335o4hucs=;
 b=f1CVDdEPtO2BbyXghtzAf7bKLtcKIdqJAEO212zVacIi6JWXHHSLRlsy3Qmx1G5Gs8
 XVEkQhzGs/dSDyAvwMySnIwqw2hjf975Pi5QE95FZAsA0WFbN35pCD9GUqjIlHXTtwZr
 T/ZO3AdhjduKQGd+qfZ0F/g5t2zCmuKhlTAAOfH2Jr760uQ9S88k1M0OZIWjfmWB9PEx
 vsDh91ysvwiGmXXAz06TGeNh79VwnEt0/tP3rL+JxUsDiXrJ+lcPfTDeHVfAGla756O8
 mYGaTzizcHkXBTRdD8HN6P451PiF5xF+7YYi61TgrTNbcdb1CuKxeVhXG4nCTxnq1wiQ
 HBNA==
X-Gm-Message-State: AC+VfDwRZ060KlKUoLcJRM5YNfNmt1bFJFjRUA+EOOT/821WZp4p69BS
 8XVipZ7nu0bhW3TneEQkSwWtqZUgK/UKNaK2E40=
X-Google-Smtp-Source: ACHHUZ78OjoyZ8sd4b+Nu2oa1UfkT0QL9YQ37Q4Y0kCxWQvZE1qWEtP4IrX4iyJ2w4xkBjqlgGloXQ==
X-Received: by 2002:adf:ee05:0:b0:305:fbfb:c7d7 with SMTP id
 y5-20020adfee05000000b00305fbfbc7d7mr9888333wrn.44.1684860626566; 
 Tue, 23 May 2023 09:50:26 -0700 (PDT)
Received: from [192.168.1.102] (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr.
 [176.184.48.94]) by smtp.gmail.com with ESMTPSA id
 o16-20020a5d62d0000000b002fb60c7995esm11779080wrv.8.2023.05.23.09.50.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 09:50:26 -0700 (PDT)
Message-ID: <983abb4a-780c-356f-e17a-064676e00b5a@linaro.org>
Date: Tue, 23 May 2023 18:50:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 45/52] tcg: Define IN_TCG
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
 <20230523135322.678948-46-richard.henderson@linaro.org>
 <45d83422-6222-22cc-dbc4-238ad0e3e8e2@linaro.org>
In-Reply-To: <45d83422-6222-22cc-dbc4-238ad0e3e8e2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 23/5/23 18:45, Philippe Mathieu-Daudé wrote:
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
> 

Just noticed that in the last patch of this series (52/52):
https://lore.kernel.org/qemu-devel/20230523135322.678948-53-richard.henderson@linaro.org/

