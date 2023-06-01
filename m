Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A78D8719F02
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 16:04:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4iub-0007UY-8b; Thu, 01 Jun 2023 10:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4iti-0007Oe-Vw
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:03:34 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4itf-0003YO-55
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:03:25 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-64d4e45971bso562117b3a.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 07:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685628201; x=1688220201;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SUATEKcctSsLaiOkBY+jb2BrM4lpyLUdPg7pAFrPWwo=;
 b=y7a1G43LEuQldTbe0xiq0MxZUnSWZkv+OuArpmN7EmJKBZAK6uGQD0ZHcNFVrEP87f
 JCfogGbpFXo17oo/3NCY3aJMKhh27QlcEFjq+WOrmzmgvP7ZQw0SrxEbE6U/bx9ojNuU
 JMCYK87zBGg0QQ2H9+IGw3lXwsAsjAwwEcGbMHkWlmU5hyx1/mufHJJjuohoI6+KbJYz
 cxuu9MqPql2n0vPINubfDDACsRTCjqxzXXzMLGTAr6tQcb5yDw3NEkU2Bwm5UBbl6N2d
 1nJjaMil5tQaFTVLvd/uz922qphxRO8Agga/s4zcRpc2aFhgVTsnVb+mqOvGPDhHMOCW
 P7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685628201; x=1688220201;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SUATEKcctSsLaiOkBY+jb2BrM4lpyLUdPg7pAFrPWwo=;
 b=BL6Y9xBFSJy6a0hxETt0MyqenX4ikLtNAmEDVWpgbNd8Y40jL5JgBMR4BPHekLa84p
 hWmE6OX++nwoWMquaAP8cB8T8uPHVLqejfD6HPoCYk6kLkhp43YOCvp0mqakhRmii1ly
 peIvPseORHJLd5UalqIrscMVoBixABkJttPSJhrbfdVxlBXtWc0kNM0mr6xmLWEhb6pW
 mKGW/jCOpZn5nFJ8B6LIFJZHthbDtJBjfW+ScUXzKp4netQx4GA8wb8X0mkEWgf6u0RX
 13XgQn30agzChaGGOlSZiVY07Le1H4TSg2q4E0CKdsMlt27P51gaAXu3EZBkXn3oBwnc
 ipEg==
X-Gm-Message-State: AC+VfDwSkBjVog9yeEArts+hFDqzNcYtPgzuc+cQyJY3rJ2d0iM13NkC
 nIrBLwHbKoVJvgZhy9hXvYTlHA==
X-Google-Smtp-Source: ACHHUZ4+yNthzEkILtsyHbdE4Tq2rHdsiowkJmke54YpsVba5Axp+urSgk1UwMbZnrK01uBkIgzlSg==
X-Received: by 2002:a05:6a00:2d90:b0:625:efa4:4c01 with SMTP id
 fb16-20020a056a002d9000b00625efa44c01mr7305692pfb.3.1685628201456; 
 Thu, 01 Jun 2023 07:03:21 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c935:f07f:4b59:7091?
 ([2602:ae:1598:4c01:c935:f07f:4b59:7091])
 by smtp.gmail.com with ESMTPSA id
 x13-20020aa793ad000000b0064550f76efesm5147593pff.29.2023.06.01.07.03.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 07:03:20 -0700 (PDT)
Message-ID: <1b8dceed-548f-d155-b4fb-80e76408db7d@linaro.org>
Date: Thu, 1 Jun 2023 07:03:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 03/10] accel: collecting TB execution count
Content-Language: en-US
To: "Wu, Fei" <fei2.wu@intel.com>, alex.bennee@linaro.org,
 qemu-devel@nongnu.org
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-4-fei2.wu@intel.com>
 <fe705139-31e9-974b-4e45-2f0c653359da@linaro.org>
 <2ef489e6-4412-d792-7a33-153a30db3289@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <2ef489e6-4412-d792-7a33-153a30db3289@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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

On 5/31/23 22:44, Wu, Fei wrote:
> On 6/1/2023 8:05 AM, Richard Henderson wrote:
>> On 5/30/23 01:35, Fei Wu wrote:
>>> From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>
>>>
>>> If a TB has a TBS (TBStatistics) with the TB_EXEC_STATS
>>> enabled, then we instrument the start code of this TB
>>> to atomically count the number of times it is executed.
>>> We count both the number of "normal" executions and atomic
>>> executions of a TB.
>>>
>>> The execution count of the TB is stored in its respective
>>> TBS.
>>>
>>> All TBStatistics are created by default with the flags from
>>> default_tbstats_flag.
>>>
>>> [Richard Henderson created the inline gen_tb_exec_count]
>>>
>>> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
>>> Message-Id: <20190829173437.5926-3-vandersonmr2@gmail.com>
>>> [AJB: Fix author]
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>>> ---
>>>    accel/tcg/cpu-exec.c          |  6 ++++++
>>>    accel/tcg/tb-stats.c          |  6 ++++++
>>>    accel/tcg/tcg-runtime.c       |  1 +
>>>    accel/tcg/translate-all.c     |  7 +++++--
>>>    accel/tcg/translator.c        | 25 +++++++++++++++++++++++++
>>>    include/exec/gen-icount.h     |  1 +
>>>    include/exec/tb-stats-flags.h |  5 +++++
>>>    include/exec/tb-stats.h       | 13 +++++++++++++
>>>    8 files changed, 62 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>>> index 0e741960da..c0d8f26237 100644
>>> --- a/accel/tcg/cpu-exec.c
>>> +++ b/accel/tcg/cpu-exec.c
>>> @@ -25,6 +25,7 @@
>>>    #include "trace.h"
>>>    #include "disas/disas.h"
>>>    #include "exec/exec-all.h"
>>> +#include "exec/tb-stats.h"
>>>    #include "tcg/tcg.h"
>>>    #include "qemu/atomic.h"
>>>    #include "qemu/rcu.h"
>>> @@ -562,7 +563,12 @@ void cpu_exec_step_atomic(CPUState *cpu)
>>>                mmap_unlock();
>>>            }
>>>    +        if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
>>> +            tb->tb_stats->executions.atomic++;
>>> +        }
>>> +
>>>            cpu_exec_enter(cpu);
>>> +
>>>            /* execute the generated code */
>>>            trace_exec_tb(tb, pc);
>>>            cpu_tb_exec(cpu, tb, &tb_exit);
>>> diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
>>> index f988bd8a31..143a52ef5c 100644
>>> --- a/accel/tcg/tb-stats.c
>>> +++ b/accel/tcg/tb-stats.c
>>> @@ -22,6 +22,7 @@ enum TBStatsStatus {
>>>    };
>>>      static enum TBStatsStatus tcg_collect_tb_stats;
>>> +static uint32_t default_tbstats_flag;
>>>      void init_tb_stats_htable(void)
>>>    {
>>> @@ -56,3 +57,8 @@ bool tb_stats_collection_paused(void)
>>>    {
>>>        return tcg_collect_tb_stats == TB_STATS_PAUSED;
>>>    }
>>> +
>>> +uint32_t get_default_tbstats_flag(void)
>>> +{
>>> +    return default_tbstats_flag;
>>> +}
>>
>> What is the purpose of this function, instead of a global variable?
>> What is the meaning of 'default' in its name?
>>
> tbs have their specific settings, e.g. after 'filter' cmd:
> * the last_search tbs has their stats_enabled kept
> * tbs not in the list sets their flag to TB_PAUSED

How does this affect anything at all?

We are not *checking* the tb->tb_stats->stats_enabled bit except at code generation time, 
not code execution time.  Therefore nothing ever reads the TB_PAUSED bit (or, 
correspondingly, the clearing of the other bits).  The setting of the bit is permanent.

> yes, it might looks better. But there is no correctness issue either as
> it checks if the specific bit is enabled during collecting stats.

No, it does not.  See above.


r~

