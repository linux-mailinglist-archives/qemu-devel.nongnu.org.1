Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 207E582C7FF
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 00:29:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOQwS-0000VO-EU; Fri, 12 Jan 2024 18:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOQwQ-0000VC-Mb
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 18:27:58 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOQwO-0007cM-H5
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 18:27:58 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3bbd6e37a9bso5840230b6e.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 15:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705102075; x=1705706875; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i8PIPvouU+oL2t2YGy6fF6SQDv9+4Agkwj0hp96b5gE=;
 b=GbDnoeN+5Lz1TiW/NLC8ICLF8bkCPoODenxlqxjOgoIjjqA2+zbs8hnJYGKrAQ45ZX
 dNcH11xbU+3PIu06U0hjJsmT+7i0FXGUxoopu3kuSuLKQWomb4XhQ/dMjUnlNIt78WWG
 4MNXw6qwKRR9KNDyXW9ROHIebdNU/L00vBzgn5eY+qYFnG7ME/nrw7cCd9sD5OkTode1
 Jvj/Uy903NtXWHsH8JEo1qz568L7n2/mYGzAocdVJnZXDv52rs6OOL1GLOdO2Sz7fh1B
 QY0rjGVFTFWerQtcZJlKWuDcIgxnj7zAkdAjeSIdN3+r1iY8iiKnW+4BuYmaNs6L1xOR
 jhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705102075; x=1705706875;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i8PIPvouU+oL2t2YGy6fF6SQDv9+4Agkwj0hp96b5gE=;
 b=MiawzUTJQ6iI/Na7ewvlBr8HeOCrzKU9LVTYpttylq4kUqyyb6rqcJlGcAj45ufqoP
 L/H8uiRgL3uF9YiPAzs0ixWqZa5EwY0L3sDIRjVAZmikDg9Z5hBHHzZCA+Njf27HoS4k
 HzFhi0QCUuwJWVQmjJyom63++XzHa5NtJhJMCW332D+Kvoe2SHyiNKCygLRzUaEHDrQL
 uOL9ipNMd71aJQxu0M+btGVjt0oKqMAIVYAeh4rGxYedhV0GmFYDqVComagEmAjYLNfp
 J0nUTc+TOAUW5btNpdsQXCaPRZ/9cM+Z1pO+pOizPiJMVmBAfJXtwaqrRHkrllUzfS6g
 Yzrw==
X-Gm-Message-State: AOJu0YwcaKfgrr3kXLZc5oMFWzBidTx4nJiwa1r4q8m0mCrz82JNuuKU
 oq86uqDa6LeuyXXQ5th/vIXzkel+qiqKSZs/TIxJzOinXq706A==
X-Google-Smtp-Source: AGHT+IHIkxeOiw2LHqZyG/plHGwfCxU/bf7Y26G3qUgdEee9d8McUcN6bLjlCj9lqYeJhxI/IcYQBQ==
X-Received: by 2002:a54:4e8a:0:b0:3bd:62a3:28b9 with SMTP id
 c10-20020a544e8a000000b003bd62a328b9mr1345909oiy.20.1705102074912; 
 Fri, 12 Jan 2024 15:27:54 -0800 (PST)
Received: from ?IPV6:2001:8004:2728:2ad6:e985:c1c8:a4fc:508?
 ([2001:8004:2728:2ad6:e985:c1c8:a4fc:508])
 by smtp.gmail.com with ESMTPSA id
 du25-20020a056a002b5900b006d7903784casm3687869pfb.131.2024.01.12.15.27.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 15:27:54 -0800 (PST)
Message-ID: <eb3adc83-719d-4256-98d1-5da17dd6d0c7@linaro.org>
Date: Sat, 13 Jan 2024 10:27:49 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] hw/hppa: Move software power button address back
 into PDC
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org
References: <20240112102927.35406-1-deller@kernel.org>
 <20240112102927.35406-6-deller@kernel.org>
 <477fa733-0957-4026-ac06-57d76d4b0388@linaro.org> <ZaHAwUC1V3WJpk5T@p100>
 <f2b0458c-f793-4b9d-a0bf-c7af22aaf099@linaro.org>
 <774b5908-c043-4b0b-889b-a964f92d2659@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <774b5908-c043-4b0b-889b-a964f92d2659@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

On 1/13/24 10:15, Helge Deller wrote:
> On 1/13/24 00:11, Richard Henderson wrote:
>> On 1/13/24 09:44, Helge Deller wrote:
>>>> I think it would be better to pass this as a parameter to create_fw_cfg, or
>>>> to drop the translated FW_CFG_IO_BASE parameter and merely pass in translate
>>>> itself.
>>>
>>> Like this?
>>>
>>>
>>> The various operating systems (e.g. Linux, NetBSD) have issues
>>> mapping the power button when it's stored in page zero.
>>> NetBSD even crashes, because it fails to map that page and then
>>> accesses unmapped memory.
>>>
>>> Since we now have a consistent memory mapping of PDC in 32-bit
>>> and 64-bit address space (the lower 32-bits of the address are in
>>> sync) the power button can be moved back to PDC space.
>>>
>>> This patch fixes the power button on Linux, NetBSD and HP-UX.
>>>
>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>> Tested-by: Bruno Haible <bruno@clisp.org>
>>>
>>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>>> index 54ca2fd91a..da85050f60 100644
>>> --- a/hw/hppa/machine.c
>>> +++ b/hw/hppa/machine.c
>>> @@ -36,8 +36,8 @@
>>>   #define MIN_SEABIOS_HPPA_VERSION 12 /* require at least this fw version */
>>> -/* Power button address at &PAGE0->pad[4] */
>>> -#define HPA_POWER_BUTTON (0x40 + 4 * sizeof(uint32_t))
>>> +#define HPA_POWER_BUTTON        (FIRMWARE_END - 0x10)
>>> +static hwaddr soft_power_reg;
>>
>> You've forgotten to remove the global.
> 
> No... I did not forgot it.
> This is still needed by other functions (e.g. hppa_powerdown_req())
> in the same file.

Ah, I missed that.  In which case,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

to the original.


r~

