Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D93A808985
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 14:53:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBEmu-00067K-8C; Thu, 07 Dec 2023 08:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBEmp-00066Z-V2
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 08:51:32 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBEmm-0004ZO-JV
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 08:51:31 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33338c47134so879514f8f.1
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 05:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701957086; x=1702561886; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=toSc5f8mQug4/bHFu4YFeCu8eE/7YMHHibYjwd+EuR8=;
 b=heEwPiuUK3Jt/dg20NmdYeOutja+bolN2yGiLuBky69yQb3BMSLMsTq+njW3iowlCp
 pumdb6eTIKx3Rd78FlcZUJHyfhwqGmWhAWpkjgZ/a0lUx2wpSdfwUxho87Ti42irZ1lh
 2MU9lADm1mCXPNGOfUIXLiLNkaeB5AOOd/vjOLk4LkSyPcIo86Oi1qXM/dFzjfd55TAR
 fDZtQ82vzEc/2IqHaKi/r1kn5NAnhBeGZqCsFlKB5JA/8Yy+cTbH7hZycLCien4rbbJq
 mhCzFfpRXMHDUwWobI6v5IEV0KieirhcbaJQA5htJlq2OVdP5hd5VGyau1J1V54D8Xsl
 RswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701957086; x=1702561886;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=toSc5f8mQug4/bHFu4YFeCu8eE/7YMHHibYjwd+EuR8=;
 b=tNbEMbmB5+0cRhuD9YGbbTRygHqwxWhxEBMGVu/Wy0OGVkqO/xsnAdKUDKNX3jFR8c
 nUM/KuED5iOqRCUMnLaHx8lCcw1cozMPy0Uj8iXtGtVHjmAiaMuITPlpXvk7NtmGZEMU
 8Bjvs2+k3WY1XiL/KKyThy7CQlFw4WSNUOqZ54vctjaHnt7yUF33cmU/hYSaP4EtwFcw
 U9qDo6hDUiSuuY/Dp7NnT8mozE1kayfvKjwhsroQjngWymbfpyA/dNw95naENBmYbEx2
 L51+oVnXcaBX156rX7pkXtCEgjM+EHmnRkaFXDH17uyVLxu1DCFGQ3OzhjLzd0Pn3tp9
 J5vA==
X-Gm-Message-State: AOJu0YxFGAPyNu1YnMDc+sqkIF93WSKnmHy2Rvst2L+qSNblqezBKsqR
 1tU123tSLEDGNY683jaDbPy4XmONCVvk1jTLUOo=
X-Google-Smtp-Source: AGHT+IHbGQOfNGStSh+82TI+fS7ih6L3YE65mRFH8rVbdQ1zfHpW9YFpGY7Fmv4/RwLnPybCK5qKmg==
X-Received: by 2002:a5d:4447:0:b0:334:b3d0:c300 with SMTP id
 x7-20020a5d4447000000b00334b3d0c300mr837078wrr.32.1701957086042; 
 Thu, 07 Dec 2023 05:51:26 -0800 (PST)
Received: from [192.168.69.100] ([176.187.202.111])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a056000104f00b00333320cf08bsm1491076wrx.102.2023.12.07.05.51.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Dec 2023 05:51:25 -0800 (PST)
Message-ID: <8665d22d-6606-49b4-91a9-124ca68775b2@linaro.org>
Date: Thu, 7 Dec 2023 14:51:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] sysemu/replay: Restrict icount to system emulation
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-arm <qemu-arm@nongnu.org>
References: <20231207102632.33634-1-philmd@linaro.org>
 <20231207102632.33634-4-philmd@linaro.org>
 <41f23b62-15ae-4e1e-98ee-a3cbcf0f7789@linaro.org>
In-Reply-To: <41f23b62-15ae-4e1e-98ee-a3cbcf0f7789@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 7/12/23 14:46, Philippe Mathieu-Daudé wrote:
> On 7/12/23 11:26, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/sysemu/cpu-timers.h |  2 +-
>>   include/sysemu/replay.h     |  9 ++++++---
>>   stubs/icount.c              | 19 -------------------
>>   3 files changed, 7 insertions(+), 23 deletions(-)
>>
>> diff --git a/include/sysemu/cpu-timers.h b/include/sysemu/cpu-timers.h
>> index 2e786fe7fb..188f67ee90 100644
>> --- a/include/sysemu/cpu-timers.h
>> +++ b/include/sysemu/cpu-timers.h
>> @@ -24,7 +24,7 @@ void cpu_timers_init(void);
>>    * 1 = Enabled - Fixed conversion of insn to ns via "shift" option
>>    * 2 = Enabled - Runtime adaptive algorithm to compute shift
>>    */
>> -#ifdef CONFIG_TCG
>> +#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>>   extern int use_icount;
>>   #define icount_enabled() (use_icount)
>>   #else
>> diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
>> index 02fa75c783..8102fa54f0 100644
>> --- a/include/sysemu/replay.h
>> +++ b/include/sysemu/replay.h
>> @@ -1,6 +1,3 @@
>> -#ifndef SYSEMU_REPLAY_H
>> -#define SYSEMU_REPLAY_H
>> -
>>   /*
>>    * QEMU replay (system interface)
>>    *
>> @@ -11,6 +8,12 @@
>>    * See the COPYING file in the top-level directory.
>>    *
>>    */
>> +#ifndef SYSEMU_REPLAY_H
>> +#define SYSEMU_REPLAY_H
>> +
>> +#ifdef CONFIG_USER_ONLY
>> +#error Cannot include this header from user emulation
>> +#endif
>>   #include "exec/replay-core.h"
>>   #include "qapi/qapi-types-misc.h"
>> diff --git a/stubs/icount.c b/stubs/icount.c
>> index c39a65da92..ec8d150069 100644
>> --- a/stubs/icount.c
>> +++ b/stubs/icount.c
>> @@ -5,30 +5,11 @@
>>   int use_icount;
>> -void icount_update(CPUState *cpu)
>> -{
>> -    abort();
>> -}
>>   int64_t icount_get_raw(void)
>>   {
>>       abort();
>>       return 0;
>>   }
>> -int64_t icount_get(void)
>> -{
>> -    abort();
>> -    return 0;
>> -}
>> -int64_t icount_to_ns(int64_t icount)
>> -{
>> -    abort();
>> -    return 0;
>> -}
> 
> Build failure on HVF due to:
> 
>    pmu_init()
>     -> pm_events[]
>      -> INST_RETIRED
>       -> instructions_ns_per()
>        -> icount_to_ns()
> 
> So we need to keep the icount_to_ns() stub until we restrict
> ARM PMU code to TCG.

Alternatively, we can use as a preliminary patch:

-- >8 --
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 20e13215bb..48ab1e0523 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -939,11 +939,13 @@ static bool instructions_supported(CPUARMState *env)

  static uint64_t instructions_get_count(CPUARMState *env)
  {
+    assert(icount_enabled());
      return (uint64_t)icount_get_raw();
  }

  static int64_t instructions_ns_per(uint64_t icount)
  {
+    assert(icount_enabled());
      return icount_to_ns((int64_t)icount);
  }
  #endif
---


