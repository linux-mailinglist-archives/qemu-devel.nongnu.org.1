Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC987888ED
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 15:48:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZX9j-0006MX-Hd; Fri, 25 Aug 2023 09:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZX9K-0006M4-Ac
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:46:54 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZX9H-0006gt-Rv
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 09:46:53 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3a751d2e6ecso684981b6e.0
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 06:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692971210; x=1693576010;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jx20pixflgyvDK8YaQtzR0YVsu1/I1hWFSlEFbsUCN4=;
 b=nRoms1wDisiX9ASGGFB5vpZhGHrQ5SC9H9Zkm0sN29mwp3LHMuYOwv43QErbrTYAyW
 Cp7JcoUCr7YFXTATFDceENzReMtUZYcEt1VvW3R1eyQjxq0QsALOSp6oZl2AvDAF3QyD
 iR/Ffoq2Pqzb+YhBwkzZ73XWJKMZ1xUg+A9eryop3GYDJwIoWyNd59Gm5LqgJblmFnMD
 UxLVHFIEWS3C/dJkknWcElbzaPUHMHdQtR8o5WSDLxiEwRlZDweCXtXiArxaEb0dtknK
 eFfl61Ck4Ej8HEi7zsMdo1UIGta2avY//v1vVSEwTPtgMay3vyrPs17p2XOPABxrQHJK
 gWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692971210; x=1693576010;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jx20pixflgyvDK8YaQtzR0YVsu1/I1hWFSlEFbsUCN4=;
 b=SF3E8lZJ24E+n25Mio0vyjZgjElGOtZJubfdQSJBZLrvQyh4cjkd1X9OnNAkGzIIB9
 z3y13v2lWG6EeHQC5TcT1ddxSwzR0C/N6fTt2FY9OqGF5BNwaW4w6tRYrHA+ADO+IAv4
 q0KLiEAhlCZv/6BmuQ1bqk9yeRsF4jECvPRfRfqTNSGPIOcmkMNYY5FM/T9Tf9dNnCPE
 7Dr+0BvInoxmSHGrHK7LlpGyjh5/7WO8Ni/2KJMaoJLxveB7KmA6H+S7NEyi4G3z/d2y
 NG7k2F3Rs+N8M+m/+WbAtr6yCtRQOOOHmYwD2YzflMZD/uGyXpM+vbmYnLHRGQw0WGZn
 9lGw==
X-Gm-Message-State: AOJu0YwEB22yBIqcYm6ItbdYcBVYeJ0C+QpCL0do9awBlfdDR3nQPtnX
 7ieZSM0LpuCd0TYUQ6CdC2wGBA==
X-Google-Smtp-Source: AGHT+IHpUiXXOM+AsxFG+ddtqALH7P7v/vfhJzHq4019jyenxXkFCTDCozD2XJsGEMES/xnb3uqp6Q==
X-Received: by 2002:a05:6808:901:b0:3a7:82e8:8fd1 with SMTP id
 w1-20020a056808090100b003a782e88fd1mr2667347oih.20.1692971210551; 
 Fri, 25 Aug 2023 06:46:50 -0700 (PDT)
Received: from [192.168.68.108] ([179.93.21.19])
 by smtp.gmail.com with ESMTPSA id
 bi25-20020a056808189900b003a48ed3564bsm732525oib.50.2023.08.25.06.46.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 06:46:50 -0700 (PDT)
Message-ID: <18c74a22-c4bc-248e-eeef-3120959cf45a@ventanamicro.com>
Date: Fri, 25 Aug 2023 10:46:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 2/3] target/riscv: Add API list_cpu_props
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com, palmer@dabbelt.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 richard.henderson@linaro.org, pbonzini@redhat.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, qemu-riscv@nongnu.org, ajones@ventanamicro.com
References: <20230825121651.1534-1-zhiwei_liu@linux.alibaba.com>
 <20230825121651.1534-3-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230825121651.1534-3-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x233.google.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.57,
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



On 8/25/23 09:16, LIU Zhiwei wrote:
> This API used for output current configuration for one specified CPU.
> Currently only RISC-V frontend implements this API.
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>   cpu.c                     |  8 ++++++++
>   include/exec/cpu-common.h |  1 +
>   target/riscv/cpu.c        | 10 ++++++++++
>   target/riscv/cpu.h        |  2 ++
>   4 files changed, 21 insertions(+)
> 
> diff --git a/cpu.c b/cpu.c
> index e1a9239d0f..03a313cd72 100644
> --- a/cpu.c
> +++ b/cpu.c
> @@ -299,6 +299,14 @@ void list_cpus(void)
>   #endif
>   }
>   
> +void list_cpu_props(CPUState *cs)
> +{
> +    /* XXX: implement xxx_cpu_list_props for targets that still miss it */
> +#if defined(cpu_list_props)
> +    cpu_list_props(cs);
> +#endif
> +}
> +
>   #if defined(CONFIG_USER_ONLY)
>   void tb_invalidate_phys_addr(hwaddr addr)
>   {
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 87dc9a752c..b3160d9218 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -166,5 +166,6 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
>   
>   /* vl.c */
>   void list_cpus(void);
> +void list_cpu_props(CPUState *);
>   
>   #endif /* CPU_COMMON_H */
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 6b93b04453..3ea18de06f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2226,6 +2226,16 @@ void riscv_cpu_list(void)
>       g_slist_free(list);
>   }
>   
> +void riscv_cpu_list_props(CPUState *cs)
> +{
> +    char *enabled_isa;
> +
> +    enabled_isa = riscv_isa_string(RISCV_CPU(cs));
> +    qemu_printf("Enable extension:\n");

I suggest "Enabled extensions". LGTM otherwise.

Daniel

> +    qemu_printf("\t%s\n", enabled_isa);
> +    /* TODO: output all user configurable options and all possible extensions */
> +}
> +
>   #define DEFINE_CPU(type_name, initfn)      \
>       {                                      \
>           .name = type_name,                 \
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 6ea22e0eea..af1d47605b 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -443,9 +443,11 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                           bool probe, uintptr_t retaddr);
>   char *riscv_isa_string(RISCVCPU *cpu);
>   void riscv_cpu_list(void);
> +void riscv_cpu_list_props(CPUState *cs);
>   void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp);
>   
>   #define cpu_list riscv_cpu_list
> +#define cpu_list_props riscv_cpu_list_props
>   #define cpu_mmu_index riscv_cpu_mmu_index
>   
>   #ifndef CONFIG_USER_ONLY

