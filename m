Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D08720DB8
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 06:09:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5IZg-0002qS-SM; Sat, 03 Jun 2023 00:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5IZe-0002q9-RI
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 00:09:06 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5IZd-0002Gp-9X
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 00:09:06 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-ba8afcc82c0so3123771276.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 21:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685765344; x=1688357344;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=392+YZX0IEIe6vhi0vB+/u6T/szTI5DfHplIY7Dm7nA=;
 b=H12qk9thWr5OMxSJcEazCuzosVZb70Ft4sEUQ3H4g+kRhA5c/lEAfHxj02V8ctzIQT
 8E/xD3FVVEmiIah1pXtGUKIZ9UPZliyeGhplR4vAxtyLSRNq1b5XzsDhN3lHUCO+LRMT
 PfatnkGzo7F/y9BFNQGsXLPUE/9OVHEFKEUOoWNwHCcAy/smfR8CVkCqHY4ibcDQBc4K
 t2qDt2ehwN3F7OcKvpyIt3E7iC4Lch0m9nNjNEY7ma5m2mFpcokbHmXiih2KGIOZFbj+
 gr393R21mEVF3v3ev5Y8L7163YEWNdrOVQi4meyYcke2AnnETdwWb77zsqt+QF7DJr5p
 Bpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685765344; x=1688357344;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=392+YZX0IEIe6vhi0vB+/u6T/szTI5DfHplIY7Dm7nA=;
 b=Gm7THA3sXbaFZ6kiJKggc6g8eyblyW1ysfQIwZef72NG++QPdsxjE74ibRnTI5NniB
 S4ZsAU87NF2tiX0mGHajcapRBALi4Wl+qtpD8KxAQyfcswmF//WpK1mJUvMUyy1H1lAP
 YVVGdKmiF3RRX4E7iwntprY+XM3S1AqLP40Icz9dx/RMCnLV7nejE32nslxlHcn7LgSW
 x9bjpiAs2ZBsZPPoHKReqM7ZCTg67pyd+iL5DJ5eoH3FIS/2tHwuDuY0wIOjKHp+Af7D
 /7xmH6EkVT6H5O6rCplYJVXnOdCYKYQmcseeu99u4+HFpLQcklvYLMtywJJ2VQgpLrzi
 bDAQ==
X-Gm-Message-State: AC+VfDzhmXso2d9Fg49YGM5EX9CvqsUQPjPxxRuwl7zQwqp3VByyOYr0
 5vgy9vx8VkVIXi+2RU8WiliaiA==
X-Google-Smtp-Source: ACHHUZ7OJ6TRuW6sdWpHcGC5DD1YDoVleeTacMrb/9kLZUJXXFDzBwKpZgdPMjzUuuKm9DrO9WLvSQ==
X-Received: by 2002:a25:d457:0:b0:bac:b478:d215 with SMTP id
 m84-20020a25d457000000b00bacb478d215mr5468703ybf.9.1685765343868; 
 Fri, 02 Jun 2023 21:09:03 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:66a6:82c2:d794:68f6?
 ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170902d50300b001a673210cf4sm2154991plg.74.2023.06.02.21.09.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 21:09:03 -0700 (PDT)
Message-ID: <556eef64-dc5f-7039-8b1b-35fef2c06959@linaro.org>
Date: Fri, 2 Jun 2023 21:09:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 23/48] tcg: Split helper-gen.h
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-24-richard.henderson@linaro.org>
 <ab5b8c14-b85c-5f97-981a-f1ad85d30318@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ab5b8c14-b85c-5f97-981a-f1ad85d30318@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb2e.google.com
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

On 6/2/23 14:17, Philippe Mathieu-Daudé wrote:
> On 31/5/23 06:03, Richard Henderson wrote:
>> Create helper-gen-common.h without the target specific portion.
>> Use that in tcg-op-common.h.  Reorg headers in target/arm to
>> ensure that helper-gen.h is included before helper-info.c.inc.
>> All other targets are already correct in this regard.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/exec/helper-gen-common.h |  17 ++++++
>>   include/exec/helper-gen.h        | 101 ++-----------------------------
>>   include/tcg/tcg-op-common.h      |   2 +-
>>   include/exec/helper-gen.h.inc    | 101 +++++++++++++++++++++++++++++++
>>   target/arm/tcg/translate.c       |   8 +--
>>   5 files changed, 126 insertions(+), 103 deletions(-)
>>   create mode 100644 include/exec/helper-gen-common.h
>>   create mode 100644 include/exec/helper-gen.h.inc
> 
> 
>> diff --git a/include/exec/helper-gen.h.inc b/include/exec/helper-gen.h.inc
>> new file mode 100644
>> index 0000000000..83bfa5b23f
>> --- /dev/null
>> +++ b/include/exec/helper-gen.h.inc
>> @@ -0,0 +1,101 @@
>> +/*
>> + * Helper file for declaring TCG helper functions.
>> + * This one expands generation functions for tcg opcodes.
>> + * Define HELPER_H for the header file to be expanded,
>> + * and static inline to change from global file scope.
>> + */
>> +
>> +#include "tcg/tcg.h"
>> +#include "tcg/helper-info.h"
>> +#include "exec/helper-head.h"
>> +
>> +#define DEF_HELPER_FLAGS_0(name, flags, ret)                            \
>> +extern TCGHelperInfo glue(helper_info_, name);                          \
>> +static inline void glue(gen_helper_, name)(dh_retvar_decl0(ret))        \
>> +{                                                                       \
>> +    tcg_gen_call0(&glue(helper_info_, name), dh_retvar(ret));           \
>> +}
> [...]
> 
> File not guarded for multiple inclusions, otherwise:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

That is why it is named ".h.inc", because it *is* included multiple times.


r~

