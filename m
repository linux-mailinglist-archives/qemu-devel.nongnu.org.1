Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A640E80A1FE
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 12:19:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBYrS-0007Vg-3u; Fri, 08 Dec 2023 06:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBYrP-0007VC-Q9
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 06:17:35 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBYrG-00036M-R7
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 06:17:35 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40b27726369so21174845e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 03:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702034245; x=1702639045; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=liPitGupZmn0k45YRnLxeP/+73+0AA8+GG9ZhJMaDYs=;
 b=wzr3six7/6RSh+snLzwCj9nPs5wuFkPrT8+kgG6ph5xc7BZlUAMw6q+6CUcZFKCAcZ
 ihH2rK+OfJLFdSBBhpMerMs4rbir0sZlIY+XTHdr8H93j+mMDuS4U179HXRa+zaRm1g3
 f80w0mIQTtl+6xR3AiKlTmA1/iyH7yNxT2zRFP02IRcJdr936MYAkT+YI4VyK6fHL+0z
 zUCFTVEeYbmfGrRV6TBvDSKnYCYwxdzwtit9J4bjSTdFWmrHlQORcMS6JTcnCW1uJG37
 LiBWWDAEXVjvyip2xB4PoHrqna3ioYKJDCHWVoSwr8kaHzCIcg8DVUWBhdtyqlie7H1/
 es5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702034245; x=1702639045;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=liPitGupZmn0k45YRnLxeP/+73+0AA8+GG9ZhJMaDYs=;
 b=Kz1eidJGJT2zE8Q0DUrLXQM88rjplRRuXUvEiyW/FdxN/UCefwMxf/NU0vkbPLdrEl
 0moCVOw3FysZ1eGDxM+8fLddxUo13pdQ/B4FIL/0EzeP0z3tNtyFsBEn1v5Np+SoHnxP
 XQDq34SduEMAsTFoDJfGZtGqvrlLoBsmb4mv3h/1m3DrjfK7mkv0IiYcfhV8aUUYJxJF
 PAnYDhd3rEXWiMONoifl/ecIoVNvLuLPx+c6Pg93SLBaPz818G6rCnXDapuwEEhLeFih
 zT+JAYKrka5w/IxJ8igET+fyCbKyQjiC47lyFtnXnATybTAqoHiG5qRcDh30xUKfnpWE
 Uc/A==
X-Gm-Message-State: AOJu0Yy3XxAIWArKPRRfOszU6aGqQry1SHvIDbERpukOSbqljMNlhljO
 KPXitT1omO5NK4fatoUPrlyLbw==
X-Google-Smtp-Source: AGHT+IEIT0+D1waY6ykNny9ZGL4HOLCbNXqxwYksal0W6owwe7cCLkeIZqFGeT7epWnKx7vHmBERhA==
X-Received: by 2002:a05:600c:1906:b0:402:e68f:8896 with SMTP id
 j6-20020a05600c190600b00402e68f8896mr2353407wmq.0.1702034244906; 
 Fri, 08 Dec 2023 03:17:24 -0800 (PST)
Received: from [192.168.69.100] ([176.176.146.181])
 by smtp.gmail.com with ESMTPSA id
 ay35-20020a05600c1e2300b0040b2b38a1fasm2601162wmb.4.2023.12.08.03.17.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Dec 2023 03:17:24 -0800 (PST)
Message-ID: <0c5b33a6-3f0d-4bc2-9627-da04d202b5aa@linaro.org>
Date: Fri, 8 Dec 2023 12:17:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] system/vl: Restrict icount to TCG emulation
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20231207154550.65087-1-philmd@linaro.org>
 <20231207154550.65087-5-philmd@linaro.org>
 <83f260a3-68e5-4041-9e92-d8250c327cf8@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <83f260a3-68e5-4041-9e92-d8250c327cf8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 7/12/23 23:38, Richard Henderson wrote:
> On 12/7/23 07:45, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   stubs/icount.c | 6 ------
>>   system/vl.c    | 6 +++++-
>>   2 files changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/stubs/icount.c b/stubs/icount.c
>> index a5202e2dd9..b060b03a73 100644
>> --- a/stubs/icount.c
>> +++ b/stubs/icount.c
>> @@ -1,5 +1,4 @@
>>   #include "qemu/osdep.h"
>> -#include "qapi/error.h"
>>   #include "sysemu/cpu-timers.h"
>>   /* icount - Instruction Counter API */
>> @@ -10,11 +9,6 @@ void icount_update(CPUState *cpu)
>>   {
>>       abort();
>>   }
>> -void icount_configure(QemuOpts *opts, Error **errp)
>> -{
>> -    /* signal error */
>> -    error_setg(errp, "cannot configure icount, TCG support not 
>> available");
>> -}
>>   int64_t icount_get_raw(void)
>>   {
>>       abort();
>> diff --git a/system/vl.c b/system/vl.c
>> index 2bcd9efb9a..8c99c5f681 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -2270,7 +2270,11 @@ static void user_register_global_props(void)
>>   static int do_configure_icount(void *opaque, QemuOpts *opts, Error 
>> **errp)
>>   {
>> -    icount_configure(opts, errp);
>> +    if (tcg_enabled()) {
>> +        icount_configure(opts, errp);
>> +    } else {
>> +        error_setg(errp, "cannot configure icount, TCG support not 
>> available");
>> +    }
>>       return 0;
>>   }
> 
> This is called before the accelerator is chosen -- even before the set 
> of available accelerators is even found.  Indeed, that's the very next 
> thing that configure_accelerators does.
> 
> OTOH, I don't see why icount_configure is being called so early.

See commit 7f8b6126e7:

     vl: move icount configuration earlier

     Once qemu_tcg_configure is turned into a QOM property setter,
     it will not be able to set a default value for mttcg_enabled.
     Setting the default will move to the TCG instance_init function,
     which currently runs before "-icount" is processed.

     However, it is harmless to do configure_icount for all accelerators;
     we will just fail later if a non-TCG accelerator is selected.  So do
     that.

But few commits after we have 28a0961757 ("vl: merge -accel processing
into configure_accelerators"), so it shouldn't be an issue now. I'll
consolidate.

