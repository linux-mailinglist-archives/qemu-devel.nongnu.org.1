Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAA178ED07
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 14:27:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbgkU-0001Lz-Lr; Thu, 31 Aug 2023 08:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbgkS-0001LR-2p
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:26:08 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbgkO-0004vH-OW
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:26:07 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50078eba7afso1526445e87.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 05:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693484762; x=1694089562; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jmg1muTNDFku5XTLBhCGZ/qrXfjl/1eaMRkwPou14A4=;
 b=orkXQSNqiD16HXenCCfKXpwoSM8ht+RzEREwKX7VMP0F6sp5UNdkwykHAiIKUUCM0h
 xbfx6r3irDKqwmvqZm2NcUfeAgRDUnQlXiz0K1R5cebORtyUEupUWkaWAkGW7DmcRimV
 DLkT6vNAuiDKKwbKp+8q2cHS8wPewPfTYFGh+TtUMxpTxXvpGivZ/eccGl3mnvxheZEj
 qBh3iFx8VJQUzNwCwtFH+paoo5biIv2mmo+2cgU7/VR27d7EgMjjjJbju9z30/jupTlX
 rjvwOqmS+kjGEF1GUzHxJItTzaihpWA0tCxBEb9FHIswM42DMzViv/TothhcGt/P1yml
 L4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693484762; x=1694089562;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jmg1muTNDFku5XTLBhCGZ/qrXfjl/1eaMRkwPou14A4=;
 b=cXKXIEwwMv8XsYIwPkjM+eEvatnLIlkcc7ErjTk6W3lEtOznrXWoG2VM7j2ENBVsgg
 W99dXUHMUwYd7R5k9JJwj19X/HluJf9HU2VP3SlIWy1JGxmlHeoeKEnD3Qb50zeVnTg2
 A1aZMdZFhUROLolQpNl0sfWHyxTDtepKEIhLbWb2SCP6WWGqyPs/IBF3/cb/vdwWxIFL
 xkGM1XYHO6YuNDCgy4NYqMiZ8bY+sBt1Drgg6Rnj5qBrgUijt4kJEeJixmsZQX7Dcy0n
 peL2rB4dUBwXbVG6uxC7h1p+NpaLia/ZSlmDmxZp9XLn2pHG3piwd3QoAARlpHLobw8i
 in+g==
X-Gm-Message-State: AOJu0Yzmo7oTVnWFw99lp5y6K0M8SLYZziH3R5bBjrEbHDh8Ic1bPN6Y
 t93TmsXtEE/yogsZAU3CdpGrWg==
X-Google-Smtp-Source: AGHT+IGdo1Bn91KxWY7qOHQZalrq036805zaS7iIR2+y+0uWdpKEki9OXyE8xJjIegAga5vMMLAhFQ==
X-Received: by 2002:a19:6504:0:b0:500:9a15:9054 with SMTP id
 z4-20020a196504000000b005009a159054mr2105182lfb.20.1693484761851; 
 Thu, 31 Aug 2023 05:26:01 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 p11-20020a056402074b00b005231e1780aasm726496edy.91.2023.08.31.05.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 05:26:01 -0700 (PDT)
Date: Thu, 31 Aug 2023 14:25:55 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 19/20] target/riscv: add 'tcg_supported' class property
Message-ID: <20230831-79ff6b097d4806caf9f8a5ff@orel>
References: <20230825130853.511782-1-dbarboza@ventanamicro.com>
 <20230825130853.511782-20-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825130853.511782-20-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=ajones@ventanamicro.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Aug 25, 2023 at 10:08:52AM -0300, Daniel Henrique Barboza wrote:
> This property indicates if a CPU supports TCG acceleration. All CPUs but
> the 'host' CPU supports it.
> 
> The error in tcg_cpu_realizefn() can now be made generic in case more
> non-TCG CPUs are added in the future.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu-qom.h     |  1 +
>  target/riscv/cpu.c         | 10 ++++++++++
>  target/riscv/cpu.h         |  1 +
>  target/riscv/tcg/tcg-cpu.c |  7 +++++--
>  4 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 7c76dc0dcc..e86b76f9fe 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -71,5 +71,6 @@ struct RISCVCPUClass {
>      ResettablePhases parent_phases;
>  
>      bool user_extension_properties;
> +    bool tcg_supported;
>  };
>  #endif /* RISCV_CPU_QOM_H */
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 6817f94c2c..f749ea2a2e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -625,6 +625,14 @@ static void rv32_imafcu_nommu_cpu_init(Object *obj)
>  }
>  #endif
>  
> +char *riscv_cpu_get_name(RISCVCPUClass *rcc)
> +{
> +    const char *typename = object_class_get_name(OBJECT_CLASS(rcc));
> +
> +    return g_strndup(typename,
> +                     strlen(typename) - strlen("-" TYPE_RISCV_CPU));
                                                  RISCV_CPU_TYPE_SUFFIX

Could also add the assert like x86 has in x86_cpu_class_get_model_name()

> +}
> +
>  static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
>  {
>      ObjectClass *oc;
> @@ -1637,6 +1645,7 @@ static void riscv_dynamic_cpu_class_init(ObjectClass *c, void *data)
>      RISCVCPUClass *rcc = RISCV_CPU_CLASS(c);
>  
>      rcc->user_extension_properties = true;
> +    rcc->tcg_supported = true;

Rather than add this tcg_supported to most (all but 'host'?) cpus, what
about doing what x86 does and create an 'accel_uses_host_cpuid()' function
which is checked in realize?

>  }
>  
>  static void riscv_vendor_cpu_class_init(ObjectClass *c, void *data)
> @@ -1644,6 +1653,7 @@ static void riscv_vendor_cpu_class_init(ObjectClass *c, void *data)
>      RISCVCPUClass *rcc = RISCV_CPU_CLASS(c);
>  
>      rcc->user_extension_properties = false;
> +    rcc->tcg_supported = true;
>  }
>  
>  #define DEFINE_DYNAMIC_CPU(type_name, initfn) \
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 4254f04684..1e6ecf52ee 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -732,6 +732,7 @@ typedef struct isa_ext_data {
>  extern const RISCVIsaExtData isa_edata_arr[];
>  
>  void riscv_add_satp_mode_properties(Object *obj);
> +char *riscv_cpu_get_name(RISCVCPUClass *rcc);
>  
>  /* CSR function table */
>  extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 6c91978920..a13796c597 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -554,11 +554,14 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>  static bool tcg_cpu_realizefn(CPUState *cs, Error **errp)
>  {
>      RISCVCPU *cpu = RISCV_CPU(cs);
> +    RISCVCPUClass *rcc = RISCV_CPU_GET_CLASS(cpu);
>      CPURISCVState *env = &cpu->env;
>      Error *local_err = NULL;
>  
> -    if (object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_CPU_HOST)) {
> -        error_setg(errp, "'host' CPU is not compatible with TCG acceleration");
> +    if (!rcc->tcg_supported) {
> +        g_autofree char *name = riscv_cpu_get_name(rcc);
> +        error_setg(errp, "'%s' CPU is not compatible with TCG acceleration",
> +                   name);
>          return false;
>      }
>  
> -- 
> 2.41.0
> 
>

Thanks,
drew

