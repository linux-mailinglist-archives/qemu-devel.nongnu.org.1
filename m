Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4006479A42A
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 09:09:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfb25-0000XS-I2; Mon, 11 Sep 2023 03:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qfb22-0000Pe-Cd
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:08:26 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qfb1z-0000M3-Vy
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:08:26 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-313e742a787so2469229f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 00:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694416102; x=1695020902; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sOXOBaJi10Q+yYRAq3y/0OmKs1lKOb7/2wk2wmWVBII=;
 b=juiMydWuKUyJHl0CeMkUA3tNAMVyx2kkZAuW7j/9wAk8wnMUwQY5eZL/CXD5VZOVN0
 xXe/yv4Zf744Y0b/rOxHJCPM+t6vGZB8Tnme4bA6CXd7E7e74PoTTHSMzc4+LYeEoszr
 ibaEvzmT3f2w9RpDDai6TTsII2jYLl6SSvP95jfssp1HNPKpTTekCts4bWoyjsxpgaTf
 Rw/v8VcqJvJcJHOvW3sFNCco9HyCrhLH56HDoOyZQdM3oqFlyD7gDuAQDA96SNubF2sx
 5GEbcdehPXhRaL3VA4ddk38I7yHJkcAMkL7Tm99BPAqgyFkz9TStGks3/vbUOZ6p3zrZ
 2LYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694416102; x=1695020902;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sOXOBaJi10Q+yYRAq3y/0OmKs1lKOb7/2wk2wmWVBII=;
 b=in5JPIOF9AFaelTh/kYH6xF9jvZtdRc2Okv4xSLy6iTAYTiUEUFwpmRe8lNNp2y9OW
 YRJZ3qf8hHBnimNLtYLRz3tvI8AUG4T7sT5QZ63e4ZnJLj2+VwyutXBdCFuYet1fnEwS
 jdzN1bUJp5SB/dTTWMTd+G0KyCHwatYmo02/rWwRTvFO+j4rm7QCiFvY9kqO1LE/hDFP
 ulsHgvLOHJD23UyYTPWETeueudu8YJBmyxtEMLPMuWLDzJa1Kn93uMqCR5wXJoTRwOKZ
 /hkLqNUW2TTEMfhGOw/xc1cpZVEbJvlUaXqGJlRCx6tSC7ltq8LL27al0D5Ss0QxZ+gl
 CZAw==
X-Gm-Message-State: AOJu0YyLV3VgEsLFsits8IW5APY1wivyaE/2N/8d2Is/PAMqEbfwLuGk
 Ywxar4azeLJtf34DiZzKP16HYw==
X-Google-Smtp-Source: AGHT+IHvjvUkFrSzMgVpzjHPp9WpWSwpxulh0hEgO2b+Dbut9hiCqLu5PRBlgonaKErc3oGYiAqFVg==
X-Received: by 2002:adf:cf02:0:b0:30e:56b3:60fe with SMTP id
 o2-20020adfcf02000000b0030e56b360femr5792951wrj.4.1694416101784; 
 Mon, 11 Sep 2023 00:08:21 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 o21-20020adfa115000000b0031f9bdb79dasm3683435wro.61.2023.09.11.00.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 00:08:21 -0700 (PDT)
Date: Mon, 11 Sep 2023 09:08:15 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, philmd@linaro.org
Subject: Re: [PATCH v2 05/19] target/riscv/cpu.c: add .instance_post_init()
Message-ID: <20230911-8dd0ed634180a4146b982df1@orel>
References: <20230906091647.1667171-1-dbarboza@ventanamicro.com>
 <20230906091647.1667171-6-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906091647.1667171-6-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x42f.google.com
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

On Wed, Sep 06, 2023 at 06:16:32AM -0300, Daniel Henrique Barboza wrote:
> All generic CPUs call riscv_cpu_add_user_properties(). The 'max' CPU
> calls riscv_init_max_cpu_extensions(). Both can be moved to a common
> instance_post_init() callback, implemented in riscv_cpu_post_init(),
> called by all CPUs. The call order then becomes:
> 
> riscv_cpu_init() -> cpu_init() of each CPU -> .instance_post_init()
> 
> In the near future riscv_cpu_post_init() will call the init() function
> of the current accelerator, providing a hook for KVM and TCG accel
> classes to change the init() process of the CPU.

Yes, this seems to be what x86 does, so presumably it'll work for riscv
too.

> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 42 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 7569955c7e..4c6d595067 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -427,8 +427,6 @@ static void riscv_max_cpu_init(Object *obj)
>      mlx = MXL_RV32;
>  #endif
>      set_misa(env, mlx, 0);
> -    riscv_cpu_add_user_properties(obj);
> -    riscv_init_max_cpu_extensions(obj);
>      env->priv_ver = PRIV_VERSION_LATEST;
>  #ifndef CONFIG_USER_ONLY
>      set_satp_mode_max_supported(RISCV_CPU(obj), mlx == MXL_RV32 ?
> @@ -442,7 +440,6 @@ static void rv64_base_cpu_init(Object *obj)
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
>      /* We set this in the realise function */
>      set_misa(env, MXL_RV64, 0);
> -    riscv_cpu_add_user_properties(obj);
>      /* Set latest version of privileged specification */
>      env->priv_ver = PRIV_VERSION_LATEST;
>  #ifndef CONFIG_USER_ONLY
> @@ -566,7 +563,6 @@ static void rv128_base_cpu_init(Object *obj)
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
>      /* We set this in the realise function */
>      set_misa(env, MXL_RV128, 0);
> -    riscv_cpu_add_user_properties(obj);
>      /* Set latest version of privileged specification */
>      env->priv_ver = PRIV_VERSION_LATEST;
>  #ifndef CONFIG_USER_ONLY
> @@ -579,7 +575,6 @@ static void rv32_base_cpu_init(Object *obj)
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
>      /* We set this in the realise function */
>      set_misa(env, MXL_RV32, 0);
> -    riscv_cpu_add_user_properties(obj);
>      /* Set latest version of privileged specification */
>      env->priv_ver = PRIV_VERSION_LATEST;
>  #ifndef CONFIG_USER_ONLY
> @@ -1215,6 +1210,37 @@ static void riscv_cpu_set_irq(void *opaque, int irq, int level)
>  }
>  #endif /* CONFIG_USER_ONLY */
>  
> +static bool riscv_cpu_is_dynamic(Object *cpu_obj)
> +{
> +    return object_dynamic_cast(cpu_obj, TYPE_RISCV_DYNAMIC_CPU) != NULL;
> +}
> +
> +static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
> +{
> +    return object_dynamic_cast(cpu_obj, TYPE_RISCV_CPU_MAX) != NULL;
> +}
> +
> +static bool riscv_cpu_has_user_properties(Object *cpu_obj)
> +{
> +    if (kvm_enabled() &&
> +        object_dynamic_cast(cpu_obj, TYPE_RISCV_CPU_HOST) != NULL) {
> +        return true;
> +    }
> +
> +    return riscv_cpu_is_dynamic(cpu_obj);
> +}
> +
> +static void riscv_cpu_post_init(Object *obj)
> +{
> +    if (riscv_cpu_has_user_properties(obj)) {
> +        riscv_cpu_add_user_properties(obj);
> +    }
> +
> +    if (riscv_cpu_has_max_extensions(obj)) {
> +        riscv_init_max_cpu_extensions(obj);
> +    }
> +}
> +
>  static void riscv_cpu_init(Object *obj)
>  {
>      RISCVCPU *cpu = RISCV_CPU(obj);
> @@ -1770,11 +1796,6 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
>  };
>  #endif
>  
> -static bool riscv_cpu_is_dynamic(Object *cpu_obj)
> -{
> -    return object_dynamic_cast(cpu_obj, TYPE_RISCV_DYNAMIC_CPU) != NULL;
> -}
> -
>  static void cpu_set_mvendorid(Object *obj, Visitor *v, const char *name,
>                                void *opaque, Error **errp)
>  {
> @@ -2011,6 +2032,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>          .instance_size = sizeof(RISCVCPU),
>          .instance_align = __alignof__(RISCVCPU),
>          .instance_init = riscv_cpu_init,
> +        .instance_post_init = riscv_cpu_post_init,
>          .abstract = true,
>          .class_size = sizeof(RISCVCPUClass),
>          .class_init = riscv_cpu_class_init,
> -- 
> 2.41.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

