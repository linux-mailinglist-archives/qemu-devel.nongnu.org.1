Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF8071EFE0
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:58:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4kCB-0004by-S1; Thu, 01 Jun 2023 11:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4kC7-0004al-KS
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:26:31 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4kBj-0003SI-9u
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:26:31 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-651f2f38634so284676b3a.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 08:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685633164; x=1688225164;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Op1fcO/KreHhs6nVLwSa9byRMpmdLVPcA9LfX4O4UwM=;
 b=leQYftY+trsk4uI4mRqyn47xYAG0PeZzn/s4r1n7dt0V7V/gzXYqBpSTCzZG659rbh
 IQjeniPK/EO8Dm8HPUUQT11z7BwMFcOwWKb98RuwS3DJRXRaMMPX6QYcOfzqKTxfF5hZ
 M2SR2JuHnDT1iNqVU9LIln+To2J2mZvO41QnJ21e+JDd13glIwewNFUbfAEYqDUgceYx
 vKS11DugbcQU+E7pJEv88QynnQT3/rOe+s29jW7H9hlCHbhIBPmDbnybfyaFbno3ZT7l
 EPEQMfrHrBPwaznjUIXMPEvdA/Uns7OJC06lmXav80BP0f0vrtAiJNdt63LoK4mS8sFn
 Xj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685633164; x=1688225164;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Op1fcO/KreHhs6nVLwSa9byRMpmdLVPcA9LfX4O4UwM=;
 b=NcPGFjcr4eIibjvdj06b7mpGMKhcKim8Uwc11XpQCu8MP8/Ou7QAL5xT315zjvkJSp
 w975vwAt6SGpSFXRPt2YGxSzF4AZ/vPYrSwVY4Edd8CJblYKOWsosR1tqNs5I0mzazfK
 o8wD0tfntG/c5rq3J9QiYgTmUAmiuhzF+T8VTixO6sT4ulotnAEBFquuZEYMKMTWfpCV
 z70SvS1aUtQCE8m1wcV+iUCqz7rCyiUbc0xja1BMuE16ukJCYSzmbjzaw+4m5PkdFf04
 v36yP7PRnfMBb+iEslebPiBDaTnbM+Ec6sFNarWW2/uCIc5brFAuR9xVgI11vMvJijCJ
 MnVw==
X-Gm-Message-State: AC+VfDykQmkbMjyYMwG9xIf+K9ygp0YVsfnHTcCzVSVayNFU6G1BK9Q1
 nvxtmAFqoFO4PuxVet5IK4YmsA==
X-Google-Smtp-Source: ACHHUZ6t2oYdzN0befqhSkJT/y+3kECHcPsW7wI2gYmkwUbjCT7mcAG+etT9WZE+DtwnQVxG+3/cKA==
X-Received: by 2002:a05:6a00:1693:b0:64f:e997:5107 with SMTP id
 k19-20020a056a00169300b0064fe9975107mr12465730pfc.1.1685633164018; 
 Thu, 01 Jun 2023 08:26:04 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c935:f07f:4b59:7091?
 ([2602:ae:1598:4c01:c935:f07f:4b59:7091])
 by smtp.gmail.com with ESMTPSA id
 a3-20020aa780c3000000b0064ff855751fsm4836896pfn.4.2023.06.01.08.26.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 08:26:03 -0700 (PDT)
Message-ID: <1ee7584b-7cb5-44f3-eeca-cb93a143e7f2@linaro.org>
Date: Thu, 1 Jun 2023 08:26:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v13 04/10] accel/tcg: add jit stats and time to
 TBStatistics
Content-Language: en-US
To: "Wu, Fei" <fei2.wu@intel.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "Vanderson M . do Rosario"
 <vandersonmr2@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
References: <20230529114947.2123652-1-fei2.wu@intel.com>
 <20230529114947.2123652-5-fei2.wu@intel.com>
 <98196efc-213f-3351-1564-5008ccd90f36@linaro.org>
 <ddc552ba-c95d-4b31-01d2-a6d70a978f1c@intel.com>
 <a6a88248-4142-baa6-dc86-b6d471477384@intel.com> <87cz2idt3m.fsf@linaro.org>
 <ec09d167-18af-9170-3d35-2d55fa6112d8@intel.com> <87bkhzbdrx.fsf@linaro.org>
 <810dbb1d-50d5-8f69-fe07-62afa7d63465@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <810dbb1d-50d5-8f69-fe07-62afa7d63465@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/1/23 05:48, Wu, Fei wrote:
> On 6/1/2023 7:51 PM, Alex Bennée wrote:
>>
>> "Wu, Fei" <fei2.wu@intel.com> writes:
>>
>>> On 5/30/2023 6:08 PM, Alex Bennée wrote:
>>>>
>>>> "Wu, Fei" <fei2.wu@intel.com> writes:
>>>>
>>>>> On 5/30/2023 1:01 PM, Wu, Fei wrote:
>>>>>> On 5/30/2023 12:07 PM, Richard Henderson wrote:
>>>>>>> On 5/29/23 04:49, Fei Wu wrote:
>> <snip>
>>> ----------------
>>> IN:
>>> Priv: 1; Virt: 0
>>>
>>> 0xffffffff800abe14:  864a              mv                      a2,s2
>>> 0xffffffff800abe16:  85ce              mv                      a1,s3
>>> 0xffffffff800abe18:  8526              mv                      a0,s1
>>> 0xffffffff800abe1a:  46bd              addi                    a3,zero,15
>>> 0xffffffff800abe1c:  fffff097          auipc                   ra,-4096
>>>                # 0xffffffff800aae1c
>>> 0xffffffff800abe20:  cc0080e7          jalr                    ra,ra,-832
>>> ------------------------------
>>>
>>> Look at the tb with phys:0x2abe14, although the first time IR takes
>>> 75274ns, but in the second command we can see it takes much less time
>>> (Note IR time is accumulated).
>>>
>>> So if the time for the same TB is not consistent, and the deviation
>>> could be dominated by system events such as memory allocation instead of
>>> codegen itself (?), I think it's less useful.
>>>
>>> Alex, regarding dropping time profile, do you mean remove TB_JIT_TIME
>>> completely?
>>
>> I think so - perf would do a better job of separating system events from
>> the core code as it has better visibility of the whole system.
>>
> OK, got it.
> 
> Richard, can we reach the agreement here? If yes, I will remove
> TB_JIT_TIME and all the time stuffs (dev_time, cpu_exec_time)
> completely. We can still add it back if it proves to be useful. The only
> concern is that tbstats replaces CONFIG_PROFILER but drops this function
> from it.

Yes, I'm quite happy to drop all of the time stuff.


r~


