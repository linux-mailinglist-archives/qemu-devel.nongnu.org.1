Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ED77E9C40
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 13:37:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2WAN-0003cq-Hh; Mon, 13 Nov 2023 07:35:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2WAB-0003YJ-2G
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 07:35:36 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2WA5-0002QB-Im
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 07:35:34 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9e61e969b1aso437885366b.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 04:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699878927; x=1700483727; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ia/tsK/XVp0x3vQZrQZFvbtYuuciPC9nhEC7lglCsYY=;
 b=Q4b48uI+PccWH18NxyB0N8bH1DWwugZlu6e/RHnCHg+ZFNNmPy071lfbtWJMF7LhwC
 BjVSmopTMwJleFOGxn/6gvgFdXbcOS3KywA2Ymp3NIjca/DmbOJh0CgDZ/S0yWmdfLWe
 vdX6T23xITzVwdmWMF3uXhSGCvKXlaoEPhakHQjwJF/vnbilD1MgIR31SJWKtf5sfUGT
 0DaIxXfPahhB8jJUEcXKyqVZv7++d9kFdtHmjeKYXbM3lANI9xoNwFFUBYCV7pV8vyh8
 CSUTvg7TuUAS0V9Kr9tFHtynsQqrNlYa4I9bjUI3a+uUAXpfo6eKvLGxHdda2WT/O5cg
 FaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699878927; x=1700483727;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ia/tsK/XVp0x3vQZrQZFvbtYuuciPC9nhEC7lglCsYY=;
 b=XGga5Rtr5plJisSBTa1fH/XxREw5JGk+hDwVYwkZq6mdzpXB7F3gZHAIJf8rCzihRQ
 dux3phwF9FAw6VAIiB0EhPnrRq5LgnvRKk5NLBb4k0vVa2uuyfbTOiCUF1v1uSzW9MHd
 qbFr1okaoFuD7Ykzi9iA80JNz908k9XW4IBTADna/Vjhxh73QNNwSAOxrMVFL4jqKFAl
 3dR1RhAsgzpEeY1NXqXa6dsIBYNJjmMVl/FnRdViivYrrodTvg6qzLqIRqTvckQhyW7A
 DJXZw1F9clQc/yHfeyACIGVnPLinBfI7uvoRqaMBsvTka9B/uovBET8zZDhHKpbDJUXy
 rAAQ==
X-Gm-Message-State: AOJu0YwsklxZHx0AYHdCWzxgfB+am6hrDgCB33p0e61bqhFCpJJ0yFr4
 wjYEm3T1e4jaMJnEUemztbldyQ==
X-Google-Smtp-Source: AGHT+IFQaogNdrczEjN0VWEwuX8oMZTkXH15D/KG8cCjM7zzN18EwLQuddf0gQweR8qNw9gR3NUEYg==
X-Received: by 2002:a17:906:6c4:b0:9e4:121c:c292 with SMTP id
 v4-20020a17090606c400b009e4121cc292mr3124326ejb.77.1699878927282; 
 Mon, 13 Nov 2023 04:35:27 -0800 (PST)
Received: from [192.168.69.100] ([176.164.221.204])
 by smtp.gmail.com with ESMTPSA id
 cw18-20020a170906c79200b0099bd7b26639sm3982057ejb.6.2023.11.13.04.35.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 04:35:26 -0800 (PST)
Message-ID: <c175edde-c7cf-4529-8346-4a100fa45446@linaro.org>
Date: Mon, 13 Nov 2023 13:35:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] host/include/generic/host/atomic128: Fix compilation
 problem with Clang 17
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
References: <20231108085954.313071-1-thuth@redhat.com>
 <b5945b9e-f696-4a71-b358-b95a5aaa7da9@linaro.org>
 <9b48b790-4705-4716-809f-1f24ced24833@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9b48b790-4705-4716-809f-1f24ced24833@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

On 13/11/23 11:34, Thomas Huth wrote:
> On 08/11/2023 18.57, Richard Henderson wrote:
>> On 11/8/23 00:59, Thomas Huth wrote:
>>> When compiling QEMU with Clang 17 on a s390x, the compilation fails:
>>>
>>> In file included from ../accel/tcg/cputlb.c:32:
>>> In file included from /root/qemu/include/exec/helper-proto-common.h:10:
>>> In file included from /root/qemu/include/qemu/atomic128.h:62:
>>> /root/qemu/host/include/generic/host/atomic128-ldst.h:68:15: error:
>>>   __sync builtin operation MUST have natural alignment (consider 
>>> using __
>>> atomic). [-Werror,-Wsync-alignment]
>>>     68 |     } while (!__sync_bool_compare_and_swap_16(ptr_align, 
>>> old, new.i));
>>>        |               ^
>>> In file included from ../accel/tcg/cputlb.c:32:
>>> In file included from /root/qemu/include/exec/helper-proto-common.h:10:
>>> In file included from /root/qemu/include/qemu/atomic128.h:61:
>>> /root/qemu/host/include/generic/host/atomic128-cas.h:36:11: error:
>>>   __sync builtin operation MUST have natural alignment (consider 
>>> using __a
>>> tomic). [-Werror,-Wsync-alignment]
>>>     36 |     r.i = __sync_val_compare_and_swap_16(ptr_align, c.i, n.i);
>>>        |           ^
>>> 2 errors generated.
>>>
>>> It's arguably a bug in Clang since we already use 
>>> __builtin_assume_aligned()
>>> to tell the compiler that the pointer is properly aligned. But 
>>> according to
>>> https://github.com/llvm/llvm-project/issues/69146 it seems like the 
>>> Clang
>>> folks don't see an easy fix on their side and recommend to use a type
>>> declared with __attribute__((aligned(16))) to work around this problem.
>>>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1934
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   host/include/generic/host/atomic128-cas.h  | 2 +-
>>>   host/include/generic/host/atomic128-ldst.h | 2 +-
>>>   include/qemu/int128.h                      | 1 +
>>>   3 files changed, 3 insertions(+), 2 deletions(-)
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> I just noticed that this new type needs to be declared for the #else 
> part, too, otherwise the compilation breaks with --enable-tcg-interpreter :
> 
> diff --git a/include/qemu/int128.h b/include/qemu/int128.h
> --- a/include/qemu/int128.h
> +++ b/include/qemu/int128.h
> @@ -225,6 +225,7 @@ static inline Int128 int128_rems(Int128 a, Int128 b)
>   #else /* !CONFIG_INT128 */
> 
>   typedef struct Int128 Int128;
> +typedef struct Int128 __attribute__((aligned(16))) Int128Aligned;

Indeed.

> 
>   /*
>    * We guarantee that the in-memory byte representation of an
> 
> I'll add that when picking up the patch.

LGTM.

