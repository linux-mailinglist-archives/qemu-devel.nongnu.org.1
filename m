Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B10ED70FC20
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 19:02:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1rsR-0002XU-4K; Wed, 24 May 2023 13:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1rsO-0002XE-PP
 for qemu-devel@nongnu.org; Wed, 24 May 2023 13:02:16 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1rsL-0002X6-LR
 for qemu-devel@nongnu.org; Wed, 24 May 2023 13:02:15 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-528dd896165so417551a12.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 10:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684947732; x=1687539732;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ywLnbG7wPesMLVjNCkTHwdnzeKOs4xw3gMPE/Y1czLE=;
 b=esn+0GdJWJ//nEICDGUBQAMM4MqhzrauqNglviMjYNF3w0M9xgmGPP+k/3M/S5y+9D
 FKaD9PlYksnIxlCFgDxMhLiISWqiA1rjmoSNoN36zXsokyEYRiK55WQISEruDGDJ7har
 bOS/tADyWGxWF9Pe7zeKdsbROI0xAh0HiSJlnblTn7AVYl4MoI1WlU5LAZI9aYo2XHg6
 6cSPSm6j2vM5fO+rK38cTa2frLVUTxbdRLNUoKwHHpoSwqs6eEg4WwhkyPQrWPUnaQ4A
 S1P9517rR5GFH1sBJKSft6UjyXqJRHMtud8EuIAyc7XogLhMbMQYsB/HYMBW7GvH6+ke
 WTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684947732; x=1687539732;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ywLnbG7wPesMLVjNCkTHwdnzeKOs4xw3gMPE/Y1czLE=;
 b=BCbHyOnMxNACBTn1pTY2dOtImpSiRaOG5AgXHT0eOmxaAPpG8h8YlVXAiUsBDjwJ85
 eqFu1y4Y5elP6YwrqJvppegnMAAoxD0MxymIFYYthp3vEZDATgJ7kbLjAchBwLj/SrcY
 kZXEVowc2iVgR7ucEaP/0raPy8xU25KaRNQAJbTS6ytuZOsj6ukHJxnxVrIQ06D6RUB/
 sKkKSp8Uo0lyuW1WgwAmkxFYF2Z3ayVqMxENGl1mYZyQQa54edLRMQS9A3xBgVSvB+va
 mgqdAfSt7LBhwTBJGI9JlL+g4FrP5rEuocu47Bgs9S0MIcqNhO9/M0HR3C/ATCCmLaNV
 wnog==
X-Gm-Message-State: AC+VfDzQdtC7qryRotFMSOJ6r6yEcGKIRQkFmaJYgn2rX1D8LNvjRoPb
 p+qcoC+S4EUafkqHet3QBMnDnw==
X-Google-Smtp-Source: ACHHUZ7/4lqEBvxcKPcaPWMbRQlQ+rwLFc4iGEusi3bEWS1HK2xZHhPygnu2zHmwL+BuLe0+2lZGUg==
X-Received: by 2002:a17:90a:ea06:b0:255:6c5b:3660 with SMTP id
 w6-20020a17090aea0600b002556c5b3660mr9230978pjy.20.1684947731482; 
 Wed, 24 May 2023 10:02:11 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:6b03:9af2:33c1:3d6b?
 ([2602:ae:1598:4c01:6b03:9af2:33c1:3d6b])
 by smtp.gmail.com with ESMTPSA id
 72-20020a63044b000000b00528da88275bsm8152478pge.47.2023.05.24.10.02.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 10:02:10 -0700 (PDT)
Message-ID: <fd8a711d-7940-c990-bbed-7c4d9a46a664@linaro.org>
Date: Wed, 24 May 2023 10:02:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v12 02/15] accel: collecting TB execution count
Content-Language: en-US
To: "Wu, Fei" <fei2.wu@intel.com>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230518135757.1442654-1-fei2.wu@intel.com>
 <20230518135757.1442654-3-fei2.wu@intel.com>
 <0bf482cc-fb96-0ada-f166-50d99b4952a5@linaro.org>
 <8adea3c0-ca06-1dd0-366b-f7eba9be6890@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <8adea3c0-ca06-1dd0-366b-f7eba9be6890@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
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

On 5/24/23 06:35, Wu, Fei wrote:
> On 5/23/2023 8:45 AM, Richard Henderson wrote:
>> On 5/18/23 06:57, Fei Wu wrote:
>>> +void HELPER(inc_exec_freq)(void *ptr)
>>> +{
>>> +    TBStatistics *stats = (TBStatistics *) ptr;
>>> +    tcg_debug_assert(stats);
>>> +    ++stats->executions.normal;
>>> +}
>> ...
>>> +static inline void gen_tb_exec_count(TranslationBlock *tb)
>>> +{
>>> +    if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
>>> +        TCGv_ptr ptr = tcg_temp_new_ptr();
>>> +        tcg_gen_movi_ptr(ptr, (intptr_t)tb->tb_stats);
>>> +        gen_helper_inc_exec_freq(ptr);
>>> +    }
>>> +}
>>
>> This is 3 host instructions, easily expanded inline:
>>
>> --- a/accel/tcg/translator.c
>> +++ b/accel/tcg/translator.c
>> @@ -11,6 +11,7 @@
>>   #include "qemu/error-report.h"
>>   #include "tcg/tcg.h"
>>   #include "tcg/tcg-op.h"
>> +#include "tcg/tcg-temp-internal.h"
>>   #include "exec/exec-all.h"
>>   #include "exec/gen-icount.h"
>>   #include "exec/log.h"
>> @@ -18,6 +19,30 @@
>>   #include "exec/plugin-gen.h"
>>   #include "exec/replay-core.h"
>>
>> +
>> +static void gen_tb_exec_count(TranslationBlock *tb)
>> +{
>> +    if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
>> +        TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
>> +
>> +        tcg_gen_movi_ptr(ptr, (intptr_t)&tb->tb_stats->executions.normal);
>> +        if (sizeof(tb->tb_stats->executions.normal) == 4) {
>> +            TCGv_i32 t = tcg_temp_ebb_new_i32();
>> +            tcg_gen_ld_i32(t, ptr, 0);
>> +            tcg_gen_addi_i32(t, t, 1);
>> +            tcg_gen_st_i32(t, ptr, 0);
>> +            tcg_temp_free_i32(t);
>> +        } else {
>> +            TCGv_i64 t = tcg_temp_ebb_new_i64();
>> +            tcg_gen_ld_i64(t, ptr, 0);
>> +            tcg_gen_addi_i64(t, t, 1);
>> +            tcg_gen_st_i64(t, ptr, 0);
>> +            tcg_temp_free_i64(t);
>> +        }
>> +        tcg_temp_free_ptr(ptr);
>> +    }
>> +}
>> +
>>   bool translator_use_goto_tb(DisasContextBase *db, target_ulong dest)
>>   {
>>       /* Suppress goto_tb if requested. */
>>
>>
>> I'm not expecially keen on embedding the TBStatistics pointer directly
>> like this; for most hosts we will have to put this constant into the
>> constant pool.  Whereas the pointer already exists at tb->tb_stats, and
>> tb is at a constant displacement prior to the code, so we already have
>> mechanisms for generating pc-relative addresses.
>>
>> However, that's premature optimization.  Let's get it working first.
>>
> Richard, have you reviewed the whole series? I will integrate your
> change to next version.

No, it's difficult to see what's going on.
In your next revision, please remove CONFIG_PROFILER entirely first, which was what I was 
planning to do locally.


r~

