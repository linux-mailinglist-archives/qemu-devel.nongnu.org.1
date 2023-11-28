Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6347FBF40
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 17:34:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r810p-0003Dh-Iz; Tue, 28 Nov 2023 11:32:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r810l-0003Cv-BN
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 11:32:35 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r810j-0006US-Ks
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 11:32:35 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-409299277bbso42638865e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 08:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701189152; x=1701793952; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bNKRMYmINpsSlrXvXENhkC5ZeItWHoTEmmBes48qrjQ=;
 b=sHg739kovrETeNVS5mEb0V/5dGQEQiydlo4wJrThYXaO8cea9uM1l+PqMHdF3M+2qt
 jypizY97RGYegOBtJv1SdrwzWyTGDdqbFrhu9UeRK2FuD8an25ZHIKmDB989mkQP9TZt
 GriQcKdTZNx+97H71b5+68vQ9cV/PUeZyoqGydGFczOcH6b0+xuXuYMIkE5JNY7117d8
 wAkTGrql5AVHEGRthT/FbXOqTprmKv4vbawX1yEM6IUz5LwU58PRBvgv8gNy04cOmytA
 ZgsofGihz1SOp2Usr6XbqNTgqO5zihmJWfPIWrT0aCo/O9zpKIoO7HKoCFPU8Cm0jDgp
 rH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701189152; x=1701793952;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bNKRMYmINpsSlrXvXENhkC5ZeItWHoTEmmBes48qrjQ=;
 b=t/fDot8HIA/smVDEqBIBAyt+IEgReLxb64yQHF2012vSv86M5lI4DndJbNYZkXg/iJ
 8ElKovISp+Td3o/tRHp1lIVXDqglRyq9ZlECaWBZmxmleedUN0171nKWq+2jZV1T62lI
 W4dAJUh9txbvwDrGdm80KmSEwRx/kLx0+DD6IgaZGHURStyVMoJdvviN49rXnnAh/Q+x
 6U4blqGlLGPiRvFZLgJQ/61UbO8IZjlLhtCJvF7DX2+4t8RQW7kUy+wA4wDG8aJpaZBp
 aRq7ajcy4qfYqBsaoayMLtBiQgWFJbUHREHeXG/FLXHxnniYN+9CcEygW8Aa6cVuw1RE
 xLDA==
X-Gm-Message-State: AOJu0YwORQ1UES5aTw7e+IeaiqIYc//BgVQtnO10uLeN//Rb4fQFd9uk
 Cet4LdnN3Kua7RKdRd+C7p/4ZA==
X-Google-Smtp-Source: AGHT+IH8D04lQywwrCC2NBcXK59xPLsh+brirZkYcvwGzWujioOkIG3NIdhKRYLvK56uNi4GSMdcuw==
X-Received: by 2002:a05:6000:401f:b0:332:eee9:6e7f with SMTP id
 cp31-20020a056000401f00b00332eee96e7fmr8793270wrb.56.1701189151745; 
 Tue, 28 Nov 2023 08:32:31 -0800 (PST)
Received: from [192.168.69.100] (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 df2-20020a5d5b82000000b003317796e0e3sm15189715wrb.65.2023.11.28.08.32.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 08:32:31 -0800 (PST)
Message-ID: <45d6b8c5-9499-418b-873b-bc408c796d70@linaro.org>
Date: Tue, 28 Nov 2023 17:32:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 05/11] target/arm: Move GTIMER definitions to
 'cpu-defs.h'
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20231122183048.17150-1-philmd@linaro.org>
 <20231122183048.17150-6-philmd@linaro.org>
 <74fee177-71d9-4303-9692-b4a496047a03@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <74fee177-71d9-4303-9692-b4a496047a03@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 28/11/23 15:02, Richard Henderson wrote:
> On 11/22/23 12:30, Philippe Mathieu-Daudé wrote:
>> To allow GTIMER_* definitions to be used by non-ARM specific
>> hardware models, move them to a new target agnostic "cpu-defs.h"
>> header.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/arm/cpu-defs.h | 19 +++++++++++++++++++
>>   target/arm/cpu.h      |  8 +-------
>>   hw/arm/bcm2836.c      |  1 +
>>   3 files changed, 21 insertions(+), 7 deletions(-)
>>   create mode 100644 target/arm/cpu-defs.h
>>
>> diff --git a/target/arm/cpu-defs.h b/target/arm/cpu-defs.h
>> new file mode 100644
>> index 0000000000..1ad76aff14
>> --- /dev/null
>> +++ b/target/arm/cpu-defs.h
>> @@ -0,0 +1,19 @@
>> +/*
>> + * ARM "target agnostic" CPU definitions
>> + *
>> + *  Copyright (c) 2003 Fabrice Bellard
>> + *
>> + * SPDX-License-Identifier: LGPL-2.1-or-later
>> + */
>> +
>> +#ifndef ARM_CPU_DEFS_H
>> +#define ARM_CPU_DEFS_H
>> +
>> +#define GTIMER_PHYS     0
>> +#define GTIMER_VIRT     1
>> +#define GTIMER_HYP      2
>> +#define GTIMER_SEC      3
>> +#define GTIMER_HYPVIRT  4
>> +#define NUM_GTIMERS     5
>> +
>> +#endif
> 
> Hmm.  cpu-defs.h is pretty generic.
> Without looking forward in the patch series, perhaps better as gtimer.h?

- target specific parameters used by accel/ (stay) in "cpu-param.h"
   (Ideally the single header included by accel/)

- target accelerator implementation details (stay) in "cpu.h"
   Shouldn't be used outside of target/

- architecture definitions in "arch-defs.h"
   (used by target/ and hw/)

- QEMU specific implementation details in "cpu-qom.h"
   (mostly used by hw/)

> 
> Is hw/arm/bcm2836.c really "non-arm-specific"?  Or did you mean 
> "non-ARMCPU-specific"?

I'd like to eventually have it instantiate a CPU which is not ARM based.


