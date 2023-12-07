Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C82658084FA
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 10:52:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBB2h-0004KB-IQ; Thu, 07 Dec 2023 04:51:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBB2g-0004Jo-4E
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 04:51:38 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBB2e-00065I-Ih
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 04:51:37 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3332ad5b3e3so701145f8f.2
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 01:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701942695; x=1702547495; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OMT9mpdp7J8SxTG46vTrcXPkxPvBldEv57N5K/BFzi8=;
 b=dTnPnBNUtlE/HY5YtC6Qs1zW/m28ng1Ho3txobKxtTxw/u1fgivq+36h95td7aPHvb
 dTloDoGz0kapdruFbYaOXqEvW/U+2MpfDAF0RC1EdTYN1WQDZkw0R6lmWfZ9AYdvH/27
 uUetaIdWwhNfzcMZSfOueklliEdBvddQku7bSLw6yYsrMc/+8mZaAU71YMK9feYDlgZY
 xu6L2ifl2NJY04HmKARg2djF+fMs+KVs+8EiON2Nn+gjJB6aA8LjAo3xN9ehOgBFeUiH
 UoU5ucKNEn7i7YA7dsqVTevn48Y49K+9iqbny6ScQfpu9+H8LNdOK6s+idI4sIjZi9xw
 61pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701942695; x=1702547495;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OMT9mpdp7J8SxTG46vTrcXPkxPvBldEv57N5K/BFzi8=;
 b=GaDa9MTGfNYKRajSacED2QAWaG/dicnafz5QbPOQHCb115mte28cVJRq0OKArf9VB3
 8x/Q4gLBs+9qaYg9LhaXgWlHkJEBfYXkVDiWlN54P2EPwg1osaMrgeJ1jJTZZBDjMUXt
 Z26rvRFCU3j5WJPp5ogu9e1MdZ7zYRDQxOF8UmicxiJ/8o6xjG3tORssWwsQRWS/nnXD
 7FoXHIA/qt1Yb1GUD5yglPy9i+agtXi0k1zRiL+UCVJwgaAm+2L/FJ2HAuzOheSEbjZO
 ZCDYTr/Jippsqag38E/j8Pt7h8geZkyirFC1lWxie1cNAWc3t/FBaXnT4gsrCDQkQ2+3
 t0vA==
X-Gm-Message-State: AOJu0YyGFryHofu9+e1O8R5vsvAEWdSBVUgnepmC3xtd8dKM+4qJOSlC
 Ie1LUUGlmD/s20QqqHCPJZ3IHw==
X-Google-Smtp-Source: AGHT+IE0D515kI5UgajXXEKqkREafxovTvsciUZpifTqN0t+BNyUX7bPyKCobK3yBrS2Gpl9O6nk9Q==
X-Received: by 2002:a5d:456c:0:b0:333:d065:a8bc with SMTP id
 a12-20020a5d456c000000b00333d065a8bcmr1246434wrc.57.1701942694692; 
 Thu, 07 Dec 2023 01:51:34 -0800 (PST)
Received: from [192.168.69.100] ([176.187.202.111])
 by smtp.gmail.com with ESMTPSA id
 i3-20020adffdc3000000b00333504001acsm994871wrs.15.2023.12.07.01.51.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Dec 2023 01:51:34 -0800 (PST)
Message-ID: <06ed276a-4e57-49d1-a4e7-7a14d1fbd12a@linaro.org>
Date: Thu, 7 Dec 2023 10:51:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 3/5] tcg: add perfmap and jitdump
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 "Vanderson M . do Rosario" <vandersonmr2@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20230116223637.3512814-1-richard.henderson@linaro.org>
 <20230116223637.3512814-4-richard.henderson@linaro.org>
 <e1112615-0e6c-e0ea-aa60-1d94d1da26ea@linaro.org>
 <e122d115-0d0f-59d2-b593-2210ca1118df@linaro.org>
 <9d6b93c20340059f1a2fbea4a7a531e2e35ba34d.camel@linux.ibm.com>
 <018c47b2-6cbe-8aca-2b6d-86541b05194f@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <018c47b2-6cbe-8aca-2b6d-86541b05194f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Ilya,

On 30/6/23 15:24, Richard Henderson wrote:
> On 6/30/23 14:39, Ilya Leoshkevich wrote:
>> On Thu, 2023-06-29 at 14:59 +0200, Richard Henderson wrote:
>>> On 6/29/23 13:31, Philippe Mathieu-Daudé wrote:
>>>>> diff --git a/tcg/tcg.c b/tcg/tcg.c
>>>>> index da91779890..9b7df71e7a 100644
>>>>> --- a/tcg/tcg.c
>>>>> +++ b/tcg/tcg.c
>>>>> @@ -61,6 +61,7 @@
>>>>>    #include "exec/log.h"
>>>>>    #include "tcg/tcg-ldst.h"
>>>>>    #include "tcg-internal.h"
>>>>> +#include "accel/tcg/perf.h"
>>>>
>>>> Is it OK to include an header from QEMU's accel/tcg/ here?
>>>> I thought we wanted to keep tcg/ kinda independant (or maybe
>>>> this is already too late and this isn't a concern anymore).
>>>
>>> It's not ideal, no.  Perf really should live in tcg/.
>>>
>>>
>>> r~
>>
>> This would require to somehow get rid of this:
>>
>> #if defined(TARGET_I386)
>>              q[insn].address -= tb->cs_base;
>> #endif
>>
>> I'll try to come up with a patch.
> 
> Just drop it?  Did you really want EIP instead of the full virtual address?
> It only makes a difference for 16-bit mode anyway.

Any update here? Have you tried 'perf' on non-x86 hosts?
There is a "This replicates the restore_state_to_opc() logic"
comment but only x86 restore_state_to_opc() logic is used,
so I'm rather confused here.

Thanks,

Phil.


