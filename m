Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0C574E047
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 23:35:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIyWS-00015A-Rg; Mon, 10 Jul 2023 17:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIyWP-00014u-Ru
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 17:34:18 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIyWO-0004Hb-3z
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 17:34:17 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8fcso36656235e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 14:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689024854; x=1691616854;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1ej/ZrJKNzRK5fJYVnzzMd3SD9pNqf6Q32kwaKd6UBw=;
 b=eC2+KVP1GQOqZ0R217mPiUQUbsk4Y98q+Wv4kFe0u5bOI/Rg4QTtgIHIDqfgEXMPRT
 Z1W+kRaEvyT9r7B2kQFSXjPPNBbv2ysluYPHnySsjK3T27Ts3BoCbL8wjzXx6X1ua7/r
 mgtPSM/bB3iJqhYicqYrUurwBCL9krUTtDfzXy/Yo/BHRs466uvQoGcvHZyyY9Y5oMqn
 Mua8ta08p0etCMOg/iqJA0gXIu11COrUsr/Lq1o5ty+/Gd6fP9gKlFK8g60Y8WjHAvu7
 /GrDvygvZdaPSKOERQ59qQAuM2Gg8oUq9KCOBgoYxWcKlV2fW/gX0sOojqYie2ZGNkUK
 ODng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689024854; x=1691616854;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1ej/ZrJKNzRK5fJYVnzzMd3SD9pNqf6Q32kwaKd6UBw=;
 b=EzljiKSFOGgGotq2g+SJTo07MnpnHcg1IBfue3H7hN4hRP3DrlNyCdI9+w1WUWSHVe
 xpqbEY5aLrob51ml1Xt/cQzxfhtDRMEuddLO5xJSJTALOzxLsenOzRboYrWIibkrars4
 rrAwU2x6Ve3RgqEzdVWhNvrtLX/qQf+DKJ+nsBc+hbU3/uTGURfciX/zxGH9NG0c4AiK
 HJDxWkg6YNIduOwfJBMms3hCsuMxyMm5l0fH6uOBwgMVOuYiSb4V/USNGKCcVzplz/Qy
 htX0rahSdz2AXjx55SKFmYRvM5Zi5iax0RIYIb1qqg12tH7o5TEkpOLMHaM6kADx1axq
 /gqg==
X-Gm-Message-State: ABy/qLYuGe8x++TbPKTiWySksTyOXjbVk0ICZayHh636hQIVv4I2mQAM
 FC0bqPlli+mJAAHqVF+VuyKghakAP+smXvOIxKPC4w==
X-Google-Smtp-Source: APBJJlEpmNYyxJ0L7GJNMaaoY+egkwblzklWtY2qvNQ1Ii6CGlCyFnhPyknuoggRB9EyxsGPRJdmzg==
X-Received: by 2002:a05:600c:4f85:b0:3fb:ebe2:6f5f with SMTP id
 n5-20020a05600c4f8500b003fbebe26f5fmr12460848wmq.13.1689024854272; 
 Mon, 10 Jul 2023 14:34:14 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 u19-20020a05600c00d300b003fc02e8ea68sm8741427wmm.13.2023.07.10.14.34.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 14:34:13 -0700 (PDT)
Message-ID: <bc3e2c9b-a993-f4f1-450f-d3539367a58a@linaro.org>
Date: Mon, 10 Jul 2023 23:34:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] target/mips: Implement Loongson CSR instructions
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: yangxiaojuan@loongson.cn, gaosong@loongson.cn, chenhuacai@kernel.org
References: <20230521214832.20145-1-jiaxun.yang@flygoat.com>
 <20230521214832.20145-2-jiaxun.yang@flygoat.com>
 <d7fc3f2d-d3ff-a59e-7683-80eccbace371@linaro.org>
In-Reply-To: <d7fc3f2d-d3ff-a59e-7683-80eccbace371@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 10/7/23 22:11, Philippe Mathieu-Daudé wrote:
> On 21/5/23 23:48, Jiaxun Yang wrote:
>> Loongson introduced CSR instructions since 3A4000, which looks
>> similar to IOCSR and CPUCFG instructions we seen in LoongArch.
>>
>> Unfortunately we don't have much document about those instructions,
>> bit fields of CPUCFG instructions and IOCSR registers can be found
>> at 3A4000's user manual, while instruction encodings can be found
>> at arch/mips/include/asm/mach-loongson64/loongson_regs.h from
>> Linux Kernel.
>>
>> Our predefined CPUCFG bits are differ from actual 3A4000, since
>> we can't emulate all CPUCFG features present in 3A4000 for now,
>> we just enable bits for what we have in TCG.
>>
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>   target/mips/cpu-defs.c.inc           |  9 ++++
>>   target/mips/cpu.c                    |  8 ++++
>>   target/mips/cpu.h                    | 40 ++++++++++++++++
>>   target/mips/helper.h                 |  4 ++
>>   target/mips/internal.h               |  2 +
>>   target/mips/tcg/lcsr.decode          | 17 +++++++
>>   target/mips/tcg/lcsr_translate.c     | 69 ++++++++++++++++++++++++++++
>>   target/mips/tcg/meson.build          |  2 +
>>   target/mips/tcg/op_helper.c          | 16 +++++++
>>   target/mips/tcg/sysemu/lcsr_helper.c | 45 ++++++++++++++++++
>>   target/mips/tcg/sysemu/meson.build   |  4 ++
>>   target/mips/tcg/sysemu_helper.h.inc  |  8 ++++
>>   target/mips/tcg/translate.c          |  3 ++
>>   target/mips/tcg/translate.h          |  7 +++
>>   14 files changed, 234 insertions(+)
>>   create mode 100644 target/mips/tcg/lcsr.decode
>>   create mode 100644 target/mips/tcg/lcsr_translate.c
>>   create mode 100644 target/mips/tcg/sysemu/lcsr_helper.c
> 
> 
>> @@ -1162,6 +1192,10 @@ typedef struct CPUArchState {
>>       QEMUTimer *timer; /* Internal timer */
>>       Clock *count_clock; /* CP0_Count clock */
>>       target_ulong exception_base; /* ExceptionBase input to the core */
>> +
>> +    /* Loongson IOCSR memory */
>> +    AddressSpace address_space_iocsr;
>> +    MemoryRegion system_iocsr;
>>   } CPUMIPSState;
> 
> Guarding to avoid on user emulation:
> 
> ../target/mips/cpu.h:1198:22: error: field ‘as’ has incomplete type
>   1198 |         AddressSpace as;
>        |                      ^~
> ../target/mips/cpu.h:1199:22: error: field ‘mr’ has incomplete type
>   1199 |         MemoryRegion mr;
>        |                      ^~
> 

and:

../../target/mips/cpu.c: In function ‘mips_cpu_initfn’:
../../target/mips/cpu.c:513:9: error: implicit declaration of function 
‘memory_region_init_io’ [-Werror=implicit-function-declaration]
   513 |         memory_region_init_io(&env->iocsr.mr, OBJECT(cpu), NULL,
       |         ^~~~~~~~~~~~~~~~~~~~~
../../target/mips/cpu.c:513:9: error: nested extern declaration of 
‘memory_region_init_io’ [-Werror=nested-externs]
../../target/mips/cpu.c:513:35: error: ‘CPUMIPSState’ {aka ‘struct 
CPUArchState’} has no member named ‘iocsr’
   513 |         memory_region_init_io(&env->iocsr.mr, OBJECT(cpu), NULL,
       |                                   ^~
../../target/mips/cpu.c:515:9: error: implicit declaration of function 
‘address_space_init’ [-Werror=implicit-function-declaration]
   515 |         address_space_init(&env->iocsr.as,
       |         ^~~~~~~~~~~~~~~~~~
../../target/mips/cpu.c:515:9: error: nested extern declaration of 
‘address_space_init’ [-Werror=nested-externs]
../../target/mips/cpu.c:515:32: error: ‘CPUMIPSState’ {aka ‘struct 
CPUArchState’} has no member named ‘iocsr’
   515 |         address_space_init(&env->iocsr.as,
       |                                ^~
../../target/mips/cpu.c:516:33: error: ‘CPUMIPSState’ {aka ‘struct 
CPUArchState’} has no member named ‘iocsr’
   516 |                             &env->iocsr.mr, "IOCSR");
       |                                 ^~
cc1: all warnings being treated as errors

:(

