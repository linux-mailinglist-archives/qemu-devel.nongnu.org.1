Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 138467FBB40
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 14:18:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7xyR-0004D0-Os; Tue, 28 Nov 2023 08:18:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7xyB-00047Y-VX
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:17:44 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7xy9-0003XJ-Q8
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:17:43 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a0f49b31868so290651966b.3
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 05:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701177460; x=1701782260; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bwxZDlHBiD+VLowaqxssuHA2MKwz/h8deXxxB5iLqkI=;
 b=AyfrqTxW+/zkXcN+l88cLgcJ9v9oHHXrG1RijRpNDRwDDopg2j0Ec8FSabYQfcHFFb
 WtMV7YGynrhvELsj2Yx0zrye9FWd+JKcdWZghY0IGrzabq+XQheQDhk35cY0xJBKl+a9
 3nvu9yNqI7p6DiRBDxc+H++n+gKDmYVkWKWxGY3dTb//Q3Nu9D4TrqVxQciBhlIzOkNw
 0+Wf4h6HC2KoSqJ9cu+5/WeqlK9MvmXg4L7jtp7AeM9twR1TQj4Vlaij1GikUNfig/Yc
 WZ3chAlBUOGBFM6Md+5UToePQNqXYTJ9d9/+1p1S9xrSTeeoRcaN7yhR2eD7euGb7OJQ
 IaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701177460; x=1701782260;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bwxZDlHBiD+VLowaqxssuHA2MKwz/h8deXxxB5iLqkI=;
 b=GREysT4bchPSOR+HgaWij5TbuQtog9bd+lcoMW6230eBKIsIkhUwyUasivLnRi2Iq7
 z5QSua0e3MeUPH+SAAfl/vb3UhjIqJQyn2WFYt1fSBEXyqI8oxm7MsLbwHyYtCrG5fj0
 RvfDmzSzuz1oZ60ZnB1UJTF8o4aVb6kNjHJz7YV8bEcNRn97OGmCqJlzX3Z4Jq0n8VUA
 7c3jJ74OAuYAQmS5rjZ1zFwuxtDmeLrqDhGj8r0T20ZVg+b1xylz8pLCG3V4X3HyKKyv
 l+ugj+3XM31OJyG9aPl2eShMKh4kcCVIYIq+6b8fxhwvurZEIfWlq/8Z+QhKmtNDgCUb
 /Wtg==
X-Gm-Message-State: AOJu0Ywfu6/XsCR8Ly0NcaiPDHbnxNhgp6O/SnGmxP36jqFMIt4Gzlqr
 tGpmiJNcKrDILMqN9EqgJwtiPg==
X-Google-Smtp-Source: AGHT+IHvvunmYF61SeCfdV6MHkQ5DSA7Yxa9KrlVWP7l/YaVsH2vAALrRpvyhlbl4eO374KERKe6Eg==
X-Received: by 2002:a17:906:2409:b0:9fd:4bed:72af with SMTP id
 z9-20020a170906240900b009fd4bed72afmr10834664eja.72.1701177460234; 
 Tue, 28 Nov 2023 05:17:40 -0800 (PST)
Received: from [192.168.69.100] (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 pw11-20020a17090720ab00b00a0f1025b17asm2511005ejb.130.2023.11.28.05.17.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 05:17:39 -0800 (PST)
Message-ID: <6800d44e-5c0f-4e36-8496-0a602d47d597@linaro.org>
Date: Tue, 28 Nov 2023 14:17:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] avr: Fix wrong initial value of stack pointer
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Gihun Nam <gihun.nam@outlook.com>, qemu-devel@nongnu.org
Cc: Michael Rolnik <mrolnik@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <PH0P222MB0010877445B594724D40C924DEBDA@PH0P222MB0010.NAMP222.PROD.OUTLOOK.COM>
 <e63b3129-9b42-46d5-877d-da6dcb2ec133@linaro.org>
In-Reply-To: <e63b3129-9b42-46d5-877d-da6dcb2ec133@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 27/11/23 20:22, Philippe Mathieu-Daudé wrote:
> Hi Gihun,
> 
> On 27/11/23 03:54, Gihun Nam wrote:
>> The current implementation initializes the stack pointer of AVR devices
>> to 0. Although older AVR devices used to be like that, newer ones set
>> it to RAMEND.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1525
>> Signed-off-by: Gihun Nam <gihun.nam@outlook.com>
>> ---
>> Edit code to use QOM property and add more description to commit message
>> about the changes
>>
>> Thanks for the detailed help, Mr. Peter!
>>
>> P.S. I don't understand how replies work with git send-email, so
>>       if I've done something wrong, please bear with me.
>>
>>   hw/avr/atmega.c  |  4 ++++
>>   target/avr/cpu.c | 10 +++++++++-
>>   target/avr/cpu.h |  3 +++
>>   3 files changed, 16 insertions(+), 1 deletion(-)


>> diff --git a/target/avr/cpu.h b/target/avr/cpu.h
>> index 8a17862737..7960c5c57a 100644
>> --- a/target/avr/cpu.h
>> +++ b/target/avr/cpu.h
>> @@ -145,6 +145,9 @@ struct ArchCPU {
>>       CPUState parent_obj;
>>       CPUAVRState env;
>> +
>> +    /* Initial value of stack pointer */
>> +    uint32_t init_sp;
> 
> Hmm the stack is 16-bit wide. I suppose AVRCPU::sp is 32-bit
> wide because tcg_global_mem_new_i32() forces us to (the smaller
> TCG register is 16-bit).
> 
> Preferably using uint16_t/DEFINE_PROP_UINT16/qdev_prop_set_uint16:
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Since this is a fix, I'll queue the patch as it is. We can reduce
the property to 16-bit later, if we find it helpful.

Thanks!

Phil.


