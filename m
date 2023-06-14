Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4EA72FF1B
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 14:52:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Pxu-00076e-En; Wed, 14 Jun 2023 08:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q9PxX-0006zL-1f
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 08:50:48 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q9PxO-00053m-Qb
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 08:50:43 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5147e8972a1so11345561a12.0
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 05:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686747029; x=1689339029;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bXSMApsqR9nj6eluBiAWfFP4Ryk6/8mLT2/aayiv1qI=;
 b=bvRLT0xwqYSWqrD1/t/ouc8sw6cpDLYnE39GPbvmwZepbpEP87gPXWuv3zZXKh1m6U
 Wvm7SKryVJvR1msEjsZ9P4Qrl2nrp7TrTb+QYHuSYp8znWqJArW86Em2taynLCf0vyJS
 CxK0HSpdgWJL/yiDQX6Hksf4esxO/ZbvY3V5aefchW9Dyh9KKKseskSW5cR3VogcTCNo
 dvl92OF2ky0yiWbkienYV6byXvrZ++mhFAkSZJM7W/sLKfiKIDAuDM/tinQKd5d4wHgC
 uWkPIM5EjM0sZ7XHCkjRDR+FLVunASHHkb9S9Z+Ta8l2Y7fPsyy4IohM4i0AfeNnTjLP
 /Ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686747029; x=1689339029;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bXSMApsqR9nj6eluBiAWfFP4Ryk6/8mLT2/aayiv1qI=;
 b=G313l84HeBr8CuURoux6PJY7xG9Hn4+rAI97uH3gGln6Y2oVkutI6CDz74/9cvAgUq
 /VwMK8yOOSGth9regGZlc2cVsZaXJJHO+HCoFPQ0ZRS0YaGuSxVyfwtrhJywqgQ07O7u
 3fFjn+ZTabq4VD16i6o4/tgNQuBNhrWK0s5mYhJvRq6fEnUHoJWVqaEc3chG+YLFN7Qe
 CajDAr2+uLSV/pF43JUPzqHHBZVL1dWy3zXHdm3qTC45hj5bw+rRqO8U4Nq4Qe0Z3o9n
 jsOzINB7pt2qmGYuD6rqtrnb3pxyWiwuYqQ7Y1EzSZFIY2FjxzUvHZn79I6Ll27crdaT
 N1KQ==
X-Gm-Message-State: AC+VfDy+UT0DZz+6fHxASSHokke4+gWo9fYsitJnQb+SvGm03wQ/RhGE
 ypM1Bzs/d0Htpn6OXNjt6yfjBg==
X-Google-Smtp-Source: ACHHUZ4ML69RlGWRyUm/EQS4S2aMTM4PHSZ0CjVFAIh2KvKfCP3sdgdx3qDlMv7lWRzsrGjwvDinkw==
X-Received: by 2002:aa7:ca52:0:b0:514:a0e9:3deb with SMTP id
 j18-20020aa7ca52000000b00514a0e93debmr9512536edt.23.1686747028732; 
 Wed, 14 Jun 2023 05:50:28 -0700 (PDT)
Received: from [10.14.201.118] ([213.175.39.66])
 by smtp.gmail.com with ESMTPSA id
 t18-20020aa7d4d2000000b0051873c201a0sm2168871edr.26.2023.06.14.05.50.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 05:50:28 -0700 (PDT)
Message-ID: <3f50cb09-1460-522c-dedc-02b1b99ce9a9@linaro.org>
Date: Wed, 14 Jun 2023 14:50:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v2 24/26] target/arm/tcg: Inline 'exec/helper-proto.h'
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230611085846.21415-1-philmd@linaro.org>
 <20230611085846.21415-25-philmd@linaro.org>
 <d4fddb7c-b0a1-6a52-b15d-e86f025c72ee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <d4fddb7c-b0a1-6a52-b15d-e86f025c72ee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 14/6/23 07:03, Richard Henderson wrote:
> On 6/11/23 10:58, Philippe Mathieu-Daudé wrote:
>> +++ b/target/arm/tcg/vec_helper.c
>> @@ -19,12 +19,15 @@
>>   #include "qemu/osdep.h"
>>   #include "cpu.h"
>> -#include "exec/helper-proto.h"
>>   #include "tcg/tcg-gvec-desc.h"
>>   #include "fpu/softfloat.h"
>>   #include "qemu/int128.h"
>>   #include "vec_internal.h"
>> +#define HELPER_H "helper.h"
>> +#include "exec/helper-proto.h.inc"
>> +#undef  HELPER_H
>> +
>>   #define HELPER_H "tcg/helper-vfp.h.inc"
>>   #include "exec/helper-proto.h.inc"
>>   #undef  HELPER_H
>> diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
>> index cbd78cc810..51f8e92ff7 100644
>> --- a/target/arm/vfp_helper.c
>> +++ b/target/arm/vfp_helper.c
>> @@ -19,7 +19,6 @@
>>   #include "qemu/osdep.h"
>>   #include "cpu.h"
>> -#include "exec/helper-proto.h"
>>   #include "internals.h"
>>   #ifdef CONFIG_TCG
>>   #include "qemu/log.h"
>> @@ -32,6 +31,10 @@
>>   #ifdef CONFIG_TCG
>> +#define HELPER_H "helper.h"
>> +#include "exec/helper-proto.h.inc"
>> +#undef  HELPER_H
>> +
>>   #define HELPER_H "tcg/helper-vfp.h.inc"
>>   #include "exec/helper-proto.h.inc"
>>   #undef  HELPER_H
> 
> Are these really required, or are you simply replacing what you removed?

We get:

../../target/arm/tcg/vec_helper.c:268:6: error: no previous prototype 
for function 'helper_gvec_qrdmlah_s16' [-Werror,-Wmissing-prototypes]
../../target/arm/tcg/vec_helper.c:293:6: error: no previous prototype 
for function 'helper_gvec_qrdmlsh_s16' [-Werror,-Wmissing-prototypes]
...

../../target/arm/vfp_helper.c:511:10: error: no previous prototype for 
function 'helper_set_rmode' [-Werror,-Wmissing-prototypes]
../../target/arm/vfp_helper.c:1127:10: error: no previous prototype for 
function 'helper_fjcvtzs' [-Werror,-Wmissing-prototypes]
...

../../target/arm/tcg/m_helper.c:581:9: error: call to undeclared 
function 'helper_exception_internal'; ISO C99 and later do not support 
implicit function declarations [-Wimplicit-function-declaration]

../../target/arm/tcg/helper-a64.c:831:9: error: call to undeclared 
function 'helper_rebuild_hflags_a32'; ISO C99 and later do not support 
implicit function declarations [-Wimplicit-function-declaration]

../../target/arm/tcg/psci.c:174:9: error: call to undeclared function 
'helper_wfi'; ISO C99 and later do not support implicit function 
declarations [-Wimplicit-function-declaration]

../../target/arm/tcg/tlb_helper.c:168:6: error: no previous prototype 
for function 'helper_exception_pc_alignment' [-Werror,-Wmissing-prototypes]

../../target/arm/tcg/crypto_helper.c:73:12: error: function cannot 
return function type 'void (void *, void *, void *, uint32_t)' (aka 
'void (void *, void *, void *, unsigned int)')
void HELPER(crypto_aese)(void *vd, void *vn, void *vm, uint32_t desc)

Do we need more tcg/helper-foo.h.inc?
- gvec / simd / crypto
- exception / wfi

