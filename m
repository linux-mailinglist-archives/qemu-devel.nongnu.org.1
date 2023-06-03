Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8336721032
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 15:35:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5ROh-0000EM-SH; Sat, 03 Jun 2023 09:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5ROg-0000E7-4t
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 09:34:22 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5ROe-0003PW-ET
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 09:34:21 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f6e4554453so28792235e9.3
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 06:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685799259; x=1688391259;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fqzrg7UhpedlmRsSPgjUclk6i3m2IqMRayJsxpNop3I=;
 b=YQwVVQuf+9pDJGaaQFm22L4OZVXPblJ9jPDd3uy9/T5iVWptYhUGGRqcWG+1g0/cLs
 wJeaOlYRgpszsfpnqErcHVQoCTS83uw4g+3VXmjwGf0zL23Em5ZTNVU9soCEsRlwMlNa
 +pOUFN9n0JcuXDUOm8mCT0SefFS/OxPeQXyGuJq2FsyoEoBJyF0ccQtzDpV+BS3k7KWk
 /5KWJSRSo+MmMUi5O6m418EY9rBHEjNiD7ZbHQLUJHMnmeX+m83JWhHITK8JWoVo4FFn
 +oa0Ec5YfEOqzMd9sI0e/XI1ZG2W7YeUF1Rl3Zy+S+CIe7X7fq/T3YtOb73u93NNRK8U
 82oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685799259; x=1688391259;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fqzrg7UhpedlmRsSPgjUclk6i3m2IqMRayJsxpNop3I=;
 b=J6oHxZLDmXGUN3TyjFqfhwaBWNoxX1MqXP6TBqmx76FxVUJIaivYUEh2xcvsBNq01P
 H4Uej4rwzXAGPTNeu3k1anc8qcQVvgw63xen9+BAx0i8jN4fqtYY9kKR0P7sKUxowkDz
 fUazalNm8QAr3g6HmEZN5uP1WO10yQFPnq5Ms0ndz5l7ykQkvi+TZ8D1yEwITYhSKYGp
 ZRrOKlxR+sq7j7wxVOwF9Xw0D123B/b7tkjJUJNWXc0As8uoVcIqzTJQlwQFj0v138m3
 IuBQ8oXlVpYvd1P6X3A+R6c9m4hOr0gWDDVLJE1TlbbX4oL3i3O5QJy624PNVrWGCmX7
 WMuQ==
X-Gm-Message-State: AC+VfDyhEIKYMJ1dwM0Aui4HzLemyH9TxlW0OOioQYAA5UEt0W3lcLyW
 6A482+yUEgQvIqSxm0gbFbw/KcOC864GUmLlZRM=
X-Google-Smtp-Source: ACHHUZ41iekCTY3uTdzPZQBqNQJaP7cAeBWemkSgWw0kPtDTLR9bkswp07NHoFSGtaoNIDqGqUZAWw==
X-Received: by 2002:a05:600c:2219:b0:3f6:8f5:f9ee with SMTP id
 z25-20020a05600c221900b003f608f5f9eemr3492630wml.26.1685799258931; 
 Sat, 03 Jun 2023 06:34:18 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.157.140])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a5d4c91000000b0030647449730sm4558649wrs.74.2023.06.03.06.34.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Jun 2023 06:34:18 -0700 (PDT)
Message-ID: <5b2b575f-5566-0dda-5e31-3f00e94ca764@linaro.org>
Date: Sat, 3 Jun 2023 15:34:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 23/48] tcg: Split helper-gen.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-24-richard.henderson@linaro.org>
 <ab5b8c14-b85c-5f97-981a-f1ad85d30318@linaro.org>
 <556eef64-dc5f-7039-8b1b-35fef2c06959@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <556eef64-dc5f-7039-8b1b-35fef2c06959@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 3/6/23 06:09, Richard Henderson wrote:
> On 6/2/23 14:17, Philippe Mathieu-Daudé wrote:
>> On 31/5/23 06:03, Richard Henderson wrote:
>>> Create helper-gen-common.h without the target specific portion.
>>> Use that in tcg-op-common.h.  Reorg headers in target/arm to
>>> ensure that helper-gen.h is included before helper-info.c.inc.
>>> All other targets are already correct in this regard.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   include/exec/helper-gen-common.h |  17 ++++++
>>>   include/exec/helper-gen.h        | 101 ++-----------------------------
>>>   include/tcg/tcg-op-common.h      |   2 +-
>>>   include/exec/helper-gen.h.inc    | 101 +++++++++++++++++++++++++++++++
>>>   target/arm/tcg/translate.c       |   8 +--
>>>   5 files changed, 126 insertions(+), 103 deletions(-)
>>>   create mode 100644 include/exec/helper-gen-common.h
>>>   create mode 100644 include/exec/helper-gen.h.inc
>>
>>
>>> diff --git a/include/exec/helper-gen.h.inc 
>>> b/include/exec/helper-gen.h.inc
>>> new file mode 100644
>>> index 0000000000..83bfa5b23f
>>> --- /dev/null
>>> +++ b/include/exec/helper-gen.h.inc
>>> @@ -0,0 +1,101 @@
>>> +/*
>>> + * Helper file for declaring TCG helper functions.
>>> + * This one expands generation functions for tcg opcodes.
>>> + * Define HELPER_H for the header file to be expanded,
>>> + * and static inline to change from global file scope.
>>> + */
>>> +
>>> +#include "tcg/tcg.h"
>>> +#include "tcg/helper-info.h"
>>> +#include "exec/helper-head.h"
>>> +
>>> +#define DEF_HELPER_FLAGS_0(name, flags, 
>>> ret)                            \
>>> +extern TCGHelperInfo glue(helper_info_, 
>>> name);                          \
>>> +static inline void glue(gen_helper_, 
>>> name)(dh_retvar_decl0(ret))        \
>>> +{                                                                       \
>>> +    tcg_gen_call0(&glue(helper_info_, name), 
>>> dh_retvar(ret));           \
>>> +}
>> [...]
>>
>> File not guarded for multiple inclusions, otherwise:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> That is why it is named ".h.inc", because it *is* included multiple times.

Oh right, thanks.


