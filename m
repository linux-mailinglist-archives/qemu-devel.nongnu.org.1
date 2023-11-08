Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDD77E52E9
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 10:53:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0fFN-00035Q-Jf; Wed, 08 Nov 2023 04:53:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fFH-00035G-Uf
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 04:53:12 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fFF-0001iq-4p
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 04:53:11 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40806e40fccso41787605e9.2
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 01:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699437187; x=1700041987; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dXmSpakQ8awKSzuiPGTsAU5woIujaWleALqwuKHBD5o=;
 b=SSE2CfseqKm434WfN2d+xNtNSL6Ts3kcTYi/5WSEGz4GMV8zbVMzM1lRYyNosE0Wiy
 jilZByeQvDE4apFaHHaEk174ca4YWS3/MMG2xyW0gIvfPmteIXaEkEiWHfUbyEUAv637
 Sn1Z7oxTTQ8R/gEY7dPnKgMGY9IJ7ITkE5Xg0LbAzRHRhixgHLpqZDY2n2pjUkdmC4N4
 V4/X8KS0eXFQIy+lNhGUCVolP0KnxAm8C2YvVx50hhlCn7UC4Q1w8alS1GJ/9RGM6rQM
 cV4su9mgmwkDWLgTuaIxcYmIGTZTrlSzGiM+YwgEvPxfMFo6GUt6UUCnHsrG5y2D46IC
 BxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699437187; x=1700041987;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dXmSpakQ8awKSzuiPGTsAU5woIujaWleALqwuKHBD5o=;
 b=qFxvVZ2A9U8w0q20HvbNZHyEYOyeMy6lJrddgC87I6y/WHtrqdD+flyPfocUtNvjD7
 FrbwOKOTIB8Dku7QCLKr3NaZm8zLQvZB3tGIzvDjnzbgcDUXROEOLHK81ZLDWvOJSeK7
 0CH8J11P4runQpOzF8cRqjdcenEus1RNSRaiKGznB6AgT+T55GluLfb82RVNc0QubMMa
 1qoz2T4RnWihCl6/BUvlvJkC8JL3iS1CDKMk7JWgyzqzSUMb/aF/l9/ur1w6c0jEYX21
 Esw8DfsT7ph5CcmlsVAa0EYo7De8zJTg1STNpxcEBReltPFPdYxtrpouWeY1I7K7aWIJ
 I/cg==
X-Gm-Message-State: AOJu0Ywf/BERhQqHvWs7980V0emDraBFwrgnbFk3h1erBMyoZhyWCDRc
 MnqsE4iznBCLlTj3BANxewOddg==
X-Google-Smtp-Source: AGHT+IEXtgOvmftfX2L4z1ZyxzG3x3O2Zr/cn4Bt7ypnS6ALf36XovLjn7jgHnkWguZrTCTlrCxN5w==
X-Received: by 2002:a05:600c:470c:b0:408:5a1c:9de7 with SMTP id
 v12-20020a05600c470c00b004085a1c9de7mr1382841wmo.7.1699437187323; 
 Wed, 08 Nov 2023 01:53:07 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 g20-20020a05600c4c9400b004065e235417sm17918057wmp.21.2023.11.08.01.53.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 01:53:06 -0800 (PST)
Message-ID: <cb819430-74b2-46e5-a375-9ef1a0dae645@linaro.org>
Date: Wed, 8 Nov 2023 10:53:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 8/9] target/loongarch: Implement set vcpu intr for kvm
Content-Language: en-US
To: xianglai li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, maobibo@loongson.cn, zhaotianrui@loongson.cn,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 richard.henderson@linaro.org, peter.maydell@linaro.org,
 yangxiaojuan@loongson.cn
References: <20231108014141.2590657-1-lixianglai@loongson.cn>
 <20231108014141.2590657-9-lixianglai@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231108014141.2590657-9-lixianglai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 8/11/23 02:41, xianglai li wrote:
> From: Tianrui Zhao <zhaotianrui@loongson.cn>
> 
> Implement loongarch kvm set vcpu interrupt interface,
> when a irq is set in vcpu, we use the KVM_INTERRUPT
> ioctl to set intr into kvm.
> 
> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
> Signed-off-by: xianglai li <lixianglai@loongson.cn>
> ---
>   target/loongarch/cpu.c           | 18 +++++++++++++-----
>   target/loongarch/kvm-stub.c      | 13 +++++++++++++
>   target/loongarch/kvm.c           | 15 +++++++++++++++
>   target/loongarch/kvm_loongarch.h | 13 +++++++++++++
>   target/loongarch/trace-events    |  1 +
>   5 files changed, 55 insertions(+), 5 deletions(-)
>   create mode 100644 target/loongarch/kvm-stub.c
>   create mode 100644 target/loongarch/kvm_loongarch.h
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 0a4d1a9778..3073f1548d 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -20,6 +20,11 @@
>   #include "sysemu/reset.h"
>   #include "tcg/tcg.h"
>   #include "vec.h"
> +#include "sysemu/kvm.h"
> +#include "kvm_loongarch.h"
> +#ifdef CONFIG_KVM
> +#include <linux/kvm.h>
> +#endif
>   
>   const char * const regnames[32] = {
>       "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
> @@ -108,12 +113,15 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
>           return;
>       }
>   
> -    env->CSR_ESTAT = deposit64(env->CSR_ESTAT, irq, 1, level != 0);
> -
> -    if (FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS)) {
> -        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> +    if (kvm_enabled()) {
> +        kvm_loongarch_set_interrupt(cpu, irq, level);

Since you guard this call with kvm_enabled(), ...

>       } else {
> -        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> +        env->CSR_ESTAT = deposit64(env->CSR_ESTAT, irq, 1, level != 0);
> +        if (FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS)) {
> +            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> +        } else {
> +            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> +        }
>       }
>   }
>   
> diff --git a/target/loongarch/kvm-stub.c b/target/loongarch/kvm-stub.c
> new file mode 100644
> index 0000000000..d38c30ec78
> --- /dev/null
> +++ b/target/loongarch/kvm-stub.c
> @@ -0,0 +1,13 @@
> +/*
> + * QEMU KVM LoongArch specific function stubs
> + *
> + * Copyright (c) 2023 Loongson Technology Corporation Limited
> + */
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "kvm_loongarch.h"
> +
> +int kvm_loongarch_set_interrupt(LoongArchCPU *cpu, int irq, int level)
> +{
> +   g_assert_not_reached();

... this stub shouldn't be required.

Have you tested a TCG-only build? Then a KVM-only one?

> +}


> diff --git a/target/loongarch/kvm_loongarch.h b/target/loongarch/kvm_loongarch.h
> new file mode 100644
> index 0000000000..cdef980eec
> --- /dev/null
> +++ b/target/loongarch/kvm_loongarch.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * QEMU LoongArch kvm interface
> + *
> + * Copyright (c) 2023 Loongson Technology Corporation Limited
> + */
> +
> +#ifndef QEMU_KVM_LOONGARCH_H
> +#define QEMU_KVM_LOONGARCH_H
> +

Missing:

#include "cpu.h"

to get the LoongArchCPU type declaration.

> +int  kvm_loongarch_set_interrupt(LoongArchCPU *cpu, int irq, int level);
> +
> +#endif

Regards,

Phil.

