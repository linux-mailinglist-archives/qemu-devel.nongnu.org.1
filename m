Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4727C95ED
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 20:21:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrjEh-0005e8-Vv; Sat, 14 Oct 2023 14:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qrjEf-0005UX-Ca
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 14:19:37 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qrjEc-0002Ec-Mz
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 14:19:37 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-577fff1cae6so2217418a12.1
 for <qemu-devel@nongnu.org>; Sat, 14 Oct 2023 11:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1697307573; x=1697912373; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lz5nXpNHVnrReUt/9Y7H0nwyZV2SplzvEfkBbUUI23I=;
 b=mPc8cRa2Mp/hUfT9mJNoX+/O20E8PFAKg65AIYaLokD9moR8GtIxHLiaBfKGYRPbJn
 abzeFV8lq+tnWt5cLsHQalTPL32d1NoTw5TTZFgAum0vGCJdsb3UkOgbLEmBk96+v/45
 YuAUyfThfw6AYoAq7K03EkTRECDBI3Hj2D265yG03+bsV9ZlSzYHfRDTVF/nHH6puwFX
 qtPK5eu1914ithpX64C22gJPn+8ZeEQR2A5Zgn5vlVLVNKdEO98Cq+hZHVNJsNfjKXFE
 gJeb0IiDY3NBGqEl25Ber1AizOrepRLyRqP7RrBMzu2WDzeAvLdw/00nh0YoKG+4mj0N
 QQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697307573; x=1697912373;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lz5nXpNHVnrReUt/9Y7H0nwyZV2SplzvEfkBbUUI23I=;
 b=RVugueS5/oq0DjNIpYOsrU8AvsOVLoQBAaSafjiur9fbrA7WA8sv/bh4J5ivDB2O2K
 pr+kocEnqhQcg1GFvuQuuUS/j32Wz3iEY89/VCAwZe9vXe1M70xF9J51oAoZpM2wH5n4
 oS+yqmVeMG1VAHaPJlJKJi0t/lfuMw8G8OVeKhE9b3S4a5rBnLWKGmoMxJ1kWTCmRIwz
 B1TUwyYYjtqwk36Y7aBXXBD5mWr3RUxuQt2ZRS8C5D6UYc1lP7kRKyKRvkDtxknKh/ut
 XvF0mqVu4o8d2RdUcMlsGv8mnGyzErhzmkph3BeNKdK7Gx4AAw7Vh5MmLCKbVMnCkU8r
 lfcg==
X-Gm-Message-State: AOJu0Yyv2vdbIw1iGKVch8fHEt240sYOLuVZe/RoPZD81CvS5Gs9EupY
 yCMASkWbU0GjhXAAWCrZRx0JIQ==
X-Google-Smtp-Source: AGHT+IFFXYF1aEV92pro/V3voMiwzkmAfnvLgh4Lw0RFLq8Fh/Y9japeyW7GgUMLMLW5z+0CwM4Ttg==
X-Received: by 2002:a05:6a20:7287:b0:15d:4cf1:212e with SMTP id
 o7-20020a056a20728700b0015d4cf1212emr4715260pzk.4.1697307573160; 
 Sat, 14 Oct 2023 11:19:33 -0700 (PDT)
Received: from [192.168.68.107] ([177.45.186.249])
 by smtp.gmail.com with ESMTPSA id
 j6-20020aa78d06000000b0069342d58ea0sm15697209pfe.90.2023.10.14.11.19.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 11:19:32 -0700 (PDT)
Message-ID: <6a06acfc-3ca0-402e-8a98-bdd1a22bdf0d@ventanamicro.com>
Date: Sat, 14 Oct 2023 15:19:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/riscv: Initialize gdb_core_xml_file only
 once
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <20231014033545.15220-1-akihiko.odaki@daynix.com>
 <20231014033545.15220-3-akihiko.odaki@daynix.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231014033545.15220-3-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52e.google.com
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



On 10/14/23 00:35, Akihiko Odaki wrote:
> gdb_core_xml_file was assigned each time a CPU is instantiated before
> this change.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   target/riscv/cpu.c         | 5 +++++
>   target/riscv/tcg/tcg-cpu.c | 4 ----
>   2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ac4a6c7eec..a811215150 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1575,6 +1575,11 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
>       cc->get_pc = riscv_cpu_get_pc;
>       cc->gdb_read_register = riscv_cpu_gdb_read_register;
>       cc->gdb_write_register = riscv_cpu_gdb_write_register;
> +#ifdef TARGET_RISCV64
> +    cc->gdb_core_xml_file = "riscv-64bit-cpu.xml";
> +#elif defined(TARGET_RISCV32)
> +    cc->gdb_core_xml_file = "riscv-32bit-cpu.xml";
> +#endif
>       cc->gdb_num_core_regs = 33;
>       cc->gdb_stop_before_watchpoint = true;
>       cc->disas_set_info = riscv_cpu_disas_set_info;
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index e0cbc56320..626fb2acea 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -150,8 +150,6 @@ static void riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
>   
>   static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
>   {
> -    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
> -    CPUClass *cc = CPU_CLASS(mcc);
>       CPURISCVState *env = &cpu->env;
>   
>       /* Validate that MISA_MXL is set properly. */
> @@ -159,11 +157,9 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
>   #ifdef TARGET_RISCV64
>       case MXL_RV64:
>       case MXL_RV128:
> -        cc->gdb_core_xml_file = "riscv-64bit-cpu.xml";
>           break;
>   #elif defined(TARGET_RISCV32)
>       case MXL_RV32:
> -        cc->gdb_core_xml_file = "riscv-32bit-cpu.xml";
>           break;


Hmmm the issue here is that, in patch 1, you added an "elif defined(TARGET_RISCV32)"
based on an assumption that you changed here since there's no more gdb_core files being
set.

My suggestion is to use patch 1 from v1, where you removed the misa_mxl_max == misa_mxl
check at the end of this function. And then in this patch you can remove this function
altogether since you're assigning gdb_core in riscv_cpu_class_init() and the function will
be left doing nothing of note.


Thanks,

Daniel

>   #endif
>       default:

