Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A77B2710D07
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 15:12:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Al5-0002xr-Jn; Thu, 25 May 2023 09:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2Al2-0002xS-Rb
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:11:56 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2Al0-0000gP-9F
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:11:56 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-64d44b198baso749965b3a.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 06:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685020312; x=1687612312;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9nEw0i3svy3owmXta/WAnGCXtLgDMd0eef9xrBPQLus=;
 b=zJR59yTErsPWiSQXdDTnunt3VwRtbU3c83CCCYljRusoV65AHE8cEzWSlBhoWc8pbM
 GYk/0XK9fAdpQpkKZJcsvfndMQQZDzkaqvYNPHve6dlobS5hnKyoCj912wUfvRqmdotu
 9EUSGe1/mxx1tf/PWO8qIToK/6kVXglitzOtd3Ld8h+UsKrWg0SgjZzw+2nSNxhE15Q3
 GoL6COhC0RYrcecTZC+10GSZefrTjr9YQ46nsJwSCEZcedi0KRNylgzYtkKLKVGUvmby
 bk/A8Noytw0JcxrMFKDD+tA2z5lTuU7ozfoil+s60mr4gGn7sm6+A63u6ZAJQNIvjZL8
 tFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685020312; x=1687612312;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9nEw0i3svy3owmXta/WAnGCXtLgDMd0eef9xrBPQLus=;
 b=ZUWA5AV03YSQw//0UPqKR41lQ+CproplDKumx+avfTn6oEuj4RDOc9BgLR4bT4mDIK
 P+9klVYKufiTooftuAoG7K1ZnCX+AIygreZtlKQdNugXZqIzm2WeKsm7pp5WINXnWIUw
 TBxJeVak8McNUcEomQrVRqvfyPwmulLZHfmteBSJ9gXZO13KeC4J9zqjdn+WmLdpsEGc
 klD77EXM2Il8AR3CNPswiRl29ekdFwN+1a/QJLUyIL7UWOLn/K0L1jVEm5bMBAmPKFaj
 +HGOwfOtMro/2SeQMG7eoxtvT55GRdHkoelS8utBjN0nwvGF0VX+ZNGdwEAQAKCAj8Te
 iL/g==
X-Gm-Message-State: AC+VfDyIqirdyjkZYVbhWhAUAt4qoNUtwZbzrzM/TZoVl6rH9bHNFyVs
 7O5IWmqGDHVQzHWRkRdcLnsWhw==
X-Google-Smtp-Source: ACHHUZ730YSlV3mMJJYXZSXBC773C3q8B5p/Pp4frcDZvmeFyUr9KOPv2m3NLOxgFq8sn77ekqARQg==
X-Received: by 2002:a05:6a00:3917:b0:63f:2959:a271 with SMTP id
 fh23-20020a056a00391700b0063f2959a271mr3959794pfb.6.1685020312454; 
 Thu, 25 May 2023 06:11:52 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:7ac5:31cc:3997:3a16?
 ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 t6-20020aa79386000000b0064f45b20703sm1182208pfe.64.2023.05.25.06.11.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 06:11:51 -0700 (PDT)
Message-ID: <17eba1f4-f768-6dd9-5503-01901cf21a53@linaro.org>
Date: Thu, 25 May 2023 06:11:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] tests/decode: Emit TAP
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20230524173815.1148653-1-richard.henderson@linaro.org>
 <CAFEAcA9+BGdG6bShPQ+SZzJNOjMAMJ2fVYqpcvR4vOVums+dMQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA9+BGdG6bShPQ+SZzJNOjMAMJ2fVYqpcvR4vOVums+dMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 5/25/23 03:00, Peter Maydell wrote:
> On Wed, 24 May 2023 at 18:38, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> We currently print FAIL for the failure of a succ_* test, but don't
>> return a failure exit code.  Instead, convert the script to emit
>> Test Anything Protocol, which gives visibility into each subtest
>> as well as not relying on exit codes.
>>
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tests/decode/check.sh | 36 ++++++++++++++++++++++++++----------
>>   tests/meson.build     |  1 +
>>   2 files changed, 27 insertions(+), 10 deletions(-)
>>
>> diff --git a/tests/decode/check.sh b/tests/decode/check.sh
>> index 95445a0115..a3d879a099 100755
>> --- a/tests/decode/check.sh
>> +++ b/tests/decode/check.sh
>> @@ -4,21 +4,37 @@
>>
>>   PYTHON=$1
>>   DECODETREE=$2
>> -E=0
>> +E_FILES=`echo err_*.decode`
>> +S_FILES=`echo succ_*.decode`
> 
> If you run shellcheck on this script it produces some
> style complaints. Notably:
> 
>   * $(...) is better than `...`
>   * j=$(($j + 1))  is better than j=`expr $j + 1`
> 
> At least some of its "missing quoting" complaints are
> also legitimate, notably on $PYTHON and $DECODETREE.

"Better" in what sense?  Also, this is /bin/sh, not /bin/bash, so I'm never certain what 
I'm really allowed to use.

I was already half tempted to convert the script to python anyway...


r~


