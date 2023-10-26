Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 665957D871C
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 19:00:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw3hh-0006ex-JR; Thu, 26 Oct 2023 12:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qw3hd-0006eC-GO
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 12:59:26 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qw3hb-0003lo-Pi
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 12:59:25 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-68fb85afef4so1079317b3a.1
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 09:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698339562; x=1698944362; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DBkj7xoCqFR+gs9+BLOzaL0PiwOF/bnHdJIhuJWVg4k=;
 b=ABwtOBuJXyZsyHoRwPMySZFqA/MyPWm5SQaMUy0GMRwxY5Ravs5BGns9kBdPLhrX0y
 cBYJ1ejdOlRI4yZ0abaa7C3VnU+HNHeUdSJGDvt8kkgga0RTA/Vf3AfQvTMAW6RSyW3v
 VJPnahPHzqgOMPv2VBw63HcxCm4NOF0ZodsAy/o0ld5GaM71rxUuR5Elq3fASgXYTUFR
 W4UZSb4LMliOTomHfqdr36CowwhXbsupWANnfZ3lh1mLXhEQhRao7frxM11FSK1iP//T
 +W27KnD/U4MAeklNR0GHfPdMFQgmOsT1ffFalPLcPvm1ZaWwaa+v9AT631x0E9mGcRoA
 Ezrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698339562; x=1698944362;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DBkj7xoCqFR+gs9+BLOzaL0PiwOF/bnHdJIhuJWVg4k=;
 b=agRbvEBhtjMVaoUeH+DWGSfe3bgadqCPKlGPOIZo39PoS9u3DOn1FtrqorXuZaMrfG
 Q94Tj1GkWmdF5ADvhXJ3orueCS/Qv1btjbq7gpBXX8bM4H184xDwTVhDrGlethNTmoSn
 u61feBg/MjywaKTfEwPX63EcjbzXeqof/EgdxHgFqorPXJQ3m0LUnurL/Ne1DlECHxw3
 wN6JqM2ZLmFkp6NuTuNpxmZEwa7eXaww10HcOCCknceXmmhIvl5v2mcJQIod9aWZhJfG
 sQRFuSmcooUrIzE0IrWuR4+K1vwZt2rqKv44NzWbYL+1h0BBKTahn2QvSkwNWGui6iGr
 RmCA==
X-Gm-Message-State: AOJu0Yxkem5LjVU1A37HgPoc+tR8N6t3fehnfD6PCbDQrNByBaOSKfxI
 7H4Emq0W5TtjpZQpUlxNmuVDyA==
X-Google-Smtp-Source: AGHT+IFOa8ex7lP2yvryb/M6KGp0qV+Rr05KZXQ7bA0fbFtk6frMrQBWKVWXK38Btj8DCXW5pSs21Q==
X-Received: by 2002:a05:6a00:987:b0:6b1:704f:2078 with SMTP id
 u7-20020a056a00098700b006b1704f2078mr49694pfg.33.1698339562134; 
 Thu, 26 Oct 2023 09:59:22 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 e29-20020aa7981d000000b00690daae925bsm11378745pfl.51.2023.10.26.09.59.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Oct 2023 09:59:21 -0700 (PDT)
Message-ID: <105dbb04-78d8-4a6d-a12a-d8aec1942034@linaro.org>
Date: Thu, 26 Oct 2023 09:59:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 47/65] target/hppa: Remove TARGET_REGISTER_BITS
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20231020204331.139847-1-richard.henderson@linaro.org>
 <20231020204331.139847-48-richard.henderson@linaro.org>
 <c8b85257-01da-95c9-1622-909a67522437@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <c8b85257-01da-95c9-1622-909a67522437@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/20/23 14:31, Philippe Mathieu-Daudé wrote:
>> diff --git a/target/hppa/machine.c b/target/hppa/machine.c
>> index 0c0bba68c0..ab34b72910 100644
>> --- a/target/hppa/machine.c
>> +++ b/target/hppa/machine.c
>> @@ -21,21 +21,12 @@
>>   #include "cpu.h"
>>   #include "migration/cpu.h"
>> -#if TARGET_REGISTER_BITS == 64
>>   #define qemu_put_betr   qemu_put_be64
>>   #define qemu_get_betr   qemu_get_be64
>>   #define VMSTATE_UINTTR_V(_f, _s, _v) \
>>       VMSTATE_UINT64_V(_f, _s, _v)
>>   #define VMSTATE_UINTTR_ARRAY_V(_f, _s, _n, _v) \
>>       VMSTATE_UINT64_ARRAY_V(_f, _s, _n, _v)
> 
> Total 6 uses, let's use in place, removing the
> definitions.

I had meant to go back and remove these, thanks for the reminder.
I didn't realize there were so few uses.  I will just fold this in.

> IIUC for TARGET_REGISTER_BITS == 32 we need:
> 
> -- >8 --
>   static const VMStateDescription vmstate_env = {
>       .name = "env",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>       .fields = vmstate_env_fields,
>   };

You're right -- a version bump is required.  I will simply do this unconditionally, as the 
effort of back-compat is not warranted for this target.

I also need to handle the TLB format change for pa2.0.
(There's an existing comment about that!)


r~

