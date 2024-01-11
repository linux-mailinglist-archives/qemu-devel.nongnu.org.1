Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D12E482A90C
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 09:25:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNqMq-0002Bq-P7; Thu, 11 Jan 2024 03:24:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNqMn-0002Bf-F2
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:24:45 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNqMj-00041Y-B5
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:24:43 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e5508ecb9so24120245e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 00:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704961473; x=1705566273; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UiS8Fe/nvj38yR2ZAycUfZm6/z0wvuXM572J0ZZxDEE=;
 b=d2Cmad6lNj53K5/lSqKJr64BpeX9jdc9O/hBJIt+CaEMFzbvECTrvIz1PI9dcka3IU
 HgQeOySTud70jwAlIuFpZ9KU+Edw10ghcLwOZpULFQdb+zagWFi2S7CedX5d4yq48aT0
 WC1eTc36sYFbJ0EsIGKZ08Mzsejb6ixUE0zDP+I+ZDm18bI+9NYJ7BkAVhKeglnVkkPf
 LTxryMp8PPdp6XiGPHs4gyAQQfqIqn75KV2t53k7awXfIsHRrzC/MT0oyEdsZ6lSHaYq
 N7VDsF+LczQXOp/sLMfCggsgskf9Fzgug3UNini09cU511IsBroBS4msCMaWMegrhVBN
 zEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704961473; x=1705566273;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UiS8Fe/nvj38yR2ZAycUfZm6/z0wvuXM572J0ZZxDEE=;
 b=lFZJe1XxdBqpWu6U+ayRKEhweoKNPEGwdgpo1PTFmtqkJawxgwyOgLIITa0uCA/+S+
 /wN69fJbJdTikIHF5xJqbybvFe++wwt2SQXTA5521wLVHwEmiYWpNIf/9Grqi2ww0uHE
 QtKgtiTY2p/vflJL/A1tSU1XDaruLznpjp0bHBrqAYggAvnQj6PO2a9/8ZJBtauXhWUb
 WwNrDK6W/vaHTWSHUdT/JeteU8mQ2+TuqLeh/k/zKM5/+5Iei8hRkujVr7t2lMbzhEgu
 l6+bOICC1f3AzcbuZYm+a0FqlZNMJZHTsu1g0RpaFCCotNT6bEtujcXsUSP3r4k8rV8+
 wbwA==
X-Gm-Message-State: AOJu0Yy2aceQkMV0if5avzVeeOq0KDaB69XWgZUkZkYrowebxc0flXJb
 uK0EFupLrsS+6bQzDvcXv8guImWX9Tlc+WsoXr6DJAejNoTD6w==
X-Google-Smtp-Source: AGHT+IE/ox9iJCiI10ELEo4ak+2IqWis5Qi8qRLpVO4Gd0kawTAWHpLvZF7untxbOwtn8D/D5PYWSg==
X-Received: by 2002:a05:600c:3581:b0:40d:6f89:a839 with SMTP id
 p1-20020a05600c358100b0040d6f89a839mr206921wmq.30.1704961472684; 
 Thu, 11 Jan 2024 00:24:32 -0800 (PST)
Received: from [192.168.207.175] (83.red-88-28-3.dynamicip.rima-tde.net.
 [88.28.3.83]) by smtp.gmail.com with ESMTPSA id
 s17-20020a05600c45d100b0040d3db8186fsm980382wmo.5.2024.01.11.00.24.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 00:24:32 -0800 (PST)
Message-ID: <b732f8c9-8077-400f-8364-621eb561bf12@linaro.org>
Date: Thu, 11 Jan 2024 09:24:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9b] target/loongarch: Implement set vcpu intr for kvm
Content-Language: en-US
To: gaosong <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>,
 xianglai li <lixianglai@loongson.cn>
References: <20240105075804.1228596-9-zhaotianrui@loongson.cn>
 <20240110094152.52138-2-philmd@linaro.org>
 <a9ebc41a-64b6-3662-23ff-452bd98052f9@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a9ebc41a-64b6-3662-23ff-452bd98052f9@loongson.cn>
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

On 11/1/24 03:29, gaosong wrote:
> Hi,
> 
> 在 2024/1/10 下午5:41, Philippe Mathieu-Daudé 写道:
>> From: Tianrui Zhao <zhaotianrui@loongson.cn>
>>
>> Implement loongarch kvm set vcpu interrupt interface,
>> when a irq is set in vcpu, we use the KVM_INTERRUPT
>> ioctl to set intr into kvm.
>>
>> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
>> Signed-off-by: xianglai li <lixianglai@loongson.cn>
>> Reviewed-by: Song Gao <gaosong@loongson.cn>
>> Message-ID: <20240105075804.1228596-9-zhaotianrui@loongson.cn>
>> [PMD: Split from bigger patch, part 2]
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/loongarch/kvm/kvm_loongarch.h | 16 ++++++++++++++++
>>   target/loongarch/cpu.c               |  9 ++++++++-
>>   target/loongarch/kvm/kvm.c           | 15 +++++++++++++++
>>   target/loongarch/trace-events        |  1 +
>>   4 files changed, 40 insertions(+), 1 deletion(-)
>>   create mode 100644 target/loongarch/kvm/kvm_loongarch.h


>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>> index d9f8661cfd..d3a8a2f521 100644
>> --- a/target/loongarch/cpu.c
>> +++ b/target/loongarch/cpu.c
>> @@ -12,6 +12,7 @@
>>   #include "qemu/module.h"
>>   #include "sysemu/qtest.h"
>>   #include "sysemu/tcg.h"
>> +#include "sysemu/kvm.h"
>>   #include "exec/exec-all.h"
>>   #include "cpu.h"
>>   #include "internals.h"
>> @@ -21,6 +22,10 @@
>>   #include "sysemu/reset.h"
>>   #endif
>>   #include "vec.h"
>> +#ifdef CONFIG_KVM
>> +#include "kvm/kvm_loongarch.h"
> 
> This broken  tcg 'loongarch64-softmmu' build on X86 host, :-[
> 
> ../target/loongarch/cpu.c: In function ‘loongarch_cpu_set_irq’:
> ../target/loongarch/cpu.c:122:9: error: implicit declaration of function 
> ‘kvm_loongarch_set_interrupt’ [-Werror=implicit-function-declaration]
>    122 |         kvm_loongarch_set_interrupt(cpu, irq, level);
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../target/loongarch/cpu.c:122:9: error: nested extern declaration of 
> ‘kvm_loongarch_set_interrupt’ [-Werror=nested-externs]
> ../target/loongarch/cpu.c: In function ‘loongarch_cpu_reset_hold’:
> ../target/loongarch/cpu.c:557:9: error: implicit declaration of function 
> ‘kvm_arch_reset_vcpu’; did you mean ‘kvm_arch_init_vcpu’? 
> [-Werror=implicit-function-declaration]
>    557 |         kvm_arch_reset_vcpu(env);
>        |         ^~~~~~~~~~~~~~~~~~~
>        |         kvm_arch_init_vcpu
> ../target/loongarch/cpu.c:557:9: error: nested extern declaration of 
> ‘kvm_arch_reset_vcpu’ [-Werror=nested-externs]
> cc1: all warnings being treated as errors
> 
> I will move it out of  '#ifdef CONFIG_KVM'

Oh, right.

(Sorry I only tested on loongarch64 host).

Thanks!

Phil.

