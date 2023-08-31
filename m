Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EBF78EB7E
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 13:10:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbfYw-0007RF-30; Thu, 31 Aug 2023 07:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbfYt-0007Qc-5N
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 07:10:07 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbfYp-0002Vi-G7
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 07:10:05 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-52a1ce52ef4so875475a12.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 04:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693480201; x=1694085001; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MLGxhhWYt803Q4rh0APvxzzlyTGmOtYrAbTSoQfsVQE=;
 b=crvbqemMaZiqaV60ZmETz2jKr1najqPjKP4dAvyEF14om2HijF8Eg0hnyhredrJh/Y
 YGSRekaR5eCvxNTd10JKVwpdsT7Dk57fih7L7a5fSXhwzT+Q/WrglLgYENSAPx1MCSnl
 XulFxo21UXw6rdbj6EoLHDzT/xMDpUx5SaBXP1SBXRMpZSNDkE0dBdPs1fRlvOxo+pxV
 C1Jl5OiU3AARq9CGmrs/U3LBSylL+Ju0X3POrZgxYjUzyIkkHj/S5twlW7TyS1Klbhpv
 xUAsmnY4QwJiGVZ+6pDV+5lWbIZub4DpM7gW/f4dY2tyJf1UwK+EzFSAFC3nhLtJascI
 xIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693480201; x=1694085001;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MLGxhhWYt803Q4rh0APvxzzlyTGmOtYrAbTSoQfsVQE=;
 b=KdmAn3NlO8idlUFYUP2giUAjiSIm5qjw7nPvOT4uv/MqpAVQmJ2wxF4j+GzsPnldOB
 bobdZQ4X+lv/3aXyAr2E4nsRI3kSAl2yRPIHq1qpoIc3VC5m5V7/c4jZuvwOO0SgvF5g
 wjqNhGi267Jhh3MXKvyca5Vkpo7DbmtUmyDNVV9vDgDsBvQpAnkBZeIbvKvZYGHfU1O5
 piWVY5TJ2JhsS9KM2tnsrpNcsGmD7QK5EXHAZ33a/6xjGMG7ulyaY9VYdVZCwxD5NeM/
 jHEM0nYOW2UzzZYgHqBEUc+DpttBlFXCKmBAAA2GPWvC8ozv5SrHVatOUDMCnpYsKHiB
 CDcQ==
X-Gm-Message-State: AOJu0YynWlTovlxKPWPn6/kUPro+kL2PJNfpnI4j+hVawIyqQdm2JBAP
 +NmlQwkwN1VdG2foIKVSURkDUw==
X-Google-Smtp-Source: AGHT+IFp4b/XCn2376vc6KT+nBtmgdm/seOhmGb69jwvobDVPbH2twIHorvb32OmikLx8MfGw+8j/A==
X-Received: by 2002:aa7:dcd2:0:b0:523:4057:fa6e with SMTP id
 w18-20020aa7dcd2000000b005234057fa6emr3170982edu.42.1693480201537; 
 Thu, 31 Aug 2023 04:10:01 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 r7-20020aa7cb87000000b0052996528b81sm655511edt.45.2023.08.31.04.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 04:10:01 -0700 (PDT)
Date: Thu, 31 Aug 2023 13:10:00 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 09/20] target/riscv/cpu.c: mark extensions arrays as
 'const'
Message-ID: <20230831-aad9959328ec3b97b5446930@orel>
References: <20230825130853.511782-1-dbarboza@ventanamicro.com>
 <20230825130853.511782-10-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825130853.511782-10-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x529.google.com
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

On Fri, Aug 25, 2023 at 10:08:42AM -0300, Daniel Henrique Barboza wrote:
> We'll need to export these arrays to the accelerator classes in the next
> patches. Mark them as 'const' now to minimize changes in the future.

Not to "minimize changes in the future", but "because they should
not be modified at runtime".

> 
> Note that 'riscv_cpu_options' will also be exported, but can't be marked
> as 'const', because the properties are changed via
> qdev_property_add_static().
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index dbf81796d2..4eda853f1d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1381,7 +1381,7 @@ typedef struct RISCVCPUMultiExtConfig {
>      {.name = _name, .offset = CPU_CFG_OFFSET(_prop), \
>       .enabled = _defval}
>  
> -static RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
> +static const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>      /* Defaults for standard extensions */
>      MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
>      MULTI_EXT_CFG_BOOL("Zifencei", ext_ifencei, true),
> @@ -1441,7 +1441,7 @@ static RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> -static RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
> +static const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
>      MULTI_EXT_CFG_BOOL("xtheadba", ext_xtheadba, false),
>      MULTI_EXT_CFG_BOOL("xtheadbb", ext_xtheadbb, false),
>      MULTI_EXT_CFG_BOOL("xtheadbs", ext_xtheadbs, false),
> @@ -1459,7 +1459,7 @@ static RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
>  };
>  
>  /* These are experimental so mark with 'x-' */
> -static RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
> +static const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
>      MULTI_EXT_CFG_BOOL("x-zicond", ext_zicond, false),
>  
>      /* ePMP 0.9.3 */
> @@ -1532,7 +1532,7 @@ static void cpu_get_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
>  }
>  
>  static void cpu_add_multi_ext_prop(Object *cpu_obj,
> -                                   RISCVCPUMultiExtConfig *multi_cfg)
> +                                   const RISCVCPUMultiExtConfig *multi_cfg)
>  {
>      object_property_add(cpu_obj, multi_cfg->name, "bool",
>                          cpu_get_multi_ext_cfg,
> @@ -1568,9 +1568,11 @@ static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
>  #endif
>  
>  static void riscv_cpu_add_multiext_prop_array(Object *obj,
> -                                              RISCVCPUMultiExtConfig *array)
> +                                        const RISCVCPUMultiExtConfig *array)
>  {
> -    for (RISCVCPUMultiExtConfig *prop = array; prop && prop->name; prop++) {
> +    const RISCVCPUMultiExtConfig *prop;
> +
> +    for (prop = array; prop && prop->name; prop++) {
>          cpu_add_multi_ext_prop(obj, prop);
>      }
>  }
> @@ -1594,9 +1596,11 @@ static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *prop_name)
>  }
>  
>  static void riscv_cpu_add_kvm_unavail_prop_array(Object *obj,
> -                                                 RISCVCPUMultiExtConfig *array)
> +                                        const RISCVCPUMultiExtConfig *array)
>  {
> -    for (RISCVCPUMultiExtConfig *prop = array; prop && prop->name; prop++) {
> +    const RISCVCPUMultiExtConfig *prop;
> +
> +    for (prop = array; prop && prop->name; prop++) {
>          riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
>      }
>  }
> @@ -1659,7 +1663,7 @@ static void riscv_init_max_cpu_extensions(Object *obj)
>  {
>      RISCVCPU *cpu = RISCV_CPU(obj);
>      CPURISCVState *env = &cpu->env;
> -    RISCVCPUMultiExtConfig *prop;
> +    const RISCVCPUMultiExtConfig *prop;
>  
>      /* Enable RVG, RVJ and RVV that are disabled by default */
>      set_misa(env, env->misa_mxl, env->misa_ext | RVG | RVJ | RVV);
> -- 
> 2.41.0
> 
>

Other than the commit message change,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

