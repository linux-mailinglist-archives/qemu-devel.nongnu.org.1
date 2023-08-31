Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 600D078EEB4
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:34:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhoC-0003Wx-Sz; Thu, 31 Aug 2023 09:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbho9-0003UE-Vk
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:34:02 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbho7-0000tp-FR
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:34:01 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2bcc14ea414so15247571fa.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 06:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693488838; x=1694093638; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ag5il6EoQMejfBFCS9wNY3JqKZxpgtJyyFdNUkOeKFo=;
 b=hItmaciFVETuINPI4UFSZmST1o2wFaCIsdJTlxCsWt/4mJIxHUbxadY+4eSl3ZU+4J
 Ol/hkZKa1P2EnNm5x64kDSLclqQ0GQTeaWSRw2zUE7z5smVPaF2rUUsrQpfjfnagbU3l
 O1QiricT+NYSuGuV4GNFLJwJNOYRAmfe4+j1FMilt7UBhR/J8qIVMt1caopStCK9jtcG
 C9YneMEMsZkuSTmf2lVkvjIGTcihqp7EQuJB8v7juWJ1d4kyNxnGNad2wLnnMqJtf00A
 1+gpn+uNQh64FNPiCWPDdn0ytFCkDWxw1XaA2iOQfSGtg9mEVFpQPn7gzdTLji7soo7h
 il1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693488838; x=1694093638;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ag5il6EoQMejfBFCS9wNY3JqKZxpgtJyyFdNUkOeKFo=;
 b=XbVPPslJ1LNX12a5uV7USGKoiUaKbXgJ6WdyYv6YivPBrxQpWSwURIKxreBKrjBRMD
 J1kfouxkRi1j4y5VZ/5hhq7yT5RCIDArsABGL0PBIzW6GrhHcAUy75KKAQ85Mhc8djhV
 LxY/Y8MAHSTvqr6eAQ54Cw0YSv7dvEa9/lSYckrRcAOHhaLbxOzDm1J92QAfbA8vvav7
 imxCgJxmOVi8wwNu/FeWDAVCBm5Vq34hBgORoPTomaPcKYcDlsQwu+VyzZ/WF0gogbPe
 2loC0+iPSqc7DyjvyxurEzcOQtOBqZPJpwxuQy9dnyGPLoLJMIlxFMzwx08SnowFvICW
 pKnA==
X-Gm-Message-State: AOJu0YyDMi/utkKcpyaR5U9mu3XonoqNJaXcLDvbWNlxueQELaPaaZkU
 vx/fa519a13PvXTgYX+6pVX9Yg==
X-Google-Smtp-Source: AGHT+IEu7qyflH+mUVqoDkhm089c3ubLpOHE6XW3k40g76JG7d6DmqRy0e0E2LCWqn/JUCVDxQa3Pg==
X-Received: by 2002:a2e:95d2:0:b0:2bc:f1a1:29d9 with SMTP id
 y18-20020a2e95d2000000b002bcf1a129d9mr3783822ljh.2.1693488837719; 
 Thu, 31 Aug 2023 06:33:57 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1709060ac700b0098d2d219649sm778260ejf.174.2023.08.31.06.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 06:33:57 -0700 (PDT)
Date: Thu, 31 Aug 2023 15:33:56 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH RESEND v8 15/20] target/riscv/cpu.c: introduce
 cpu_cfg_ext_auto_update()
Message-ID: <20230831-51eeb5c42e9b3466b8cf6afb@orel>
References: <20230824221440.484675-1-dbarboza@ventanamicro.com>
 <20230824221440.484675-16-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824221440.484675-16-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=ajones@ventanamicro.com; helo=mail-lj1-x22f.google.com
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

On Thu, Aug 24, 2023 at 07:14:35PM -0300, Daniel Henrique Barboza wrote:
> During realize() time we're activating a lot of extensions based on some
> criteria, e.g.:
> 
>     if (cpu->cfg.ext_zk) {
>         cpu->cfg.ext_zkn = true;
>         cpu->cfg.ext_zkr = true;
>         cpu->cfg.ext_zkt = true;
>     }
> 
> This practice resulted in at least one case where we ended up enabling
> something we shouldn't: RVC enabling zca/zcd/zcf when using a CPU that
> has priv_spec older than 1.12.0.
> 
> We're also not considering user choice. There's no way of doing it now
> but this is about to change in the next few patches.
> 
> cpu_cfg_ext_auto_update() will check for priv version mismatches before
> enabling extensions. If we have a mismatch between the current priv
> version and the extension we want to enable, do not enable it. In the
> near future, this same function will also consider user choice when
> deciding if we're going to enable/disable an extension or not.
> 
> For now let's use it to handle zca/zcd/zcf enablement if RVC is enabled.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c | 44 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ddbf82f859..c56abf8395 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -177,6 +177,44 @@ static void isa_ext_update_enabled(RISCVCPU *cpu, uint32_t ext_offset,
>      *ext_enabled = en;
>  }
>  
> +static int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
> +{
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(isa_edata_arr); i++) {
> +        if (isa_edata_arr[i].ext_enable_offset != ext_offset) {
> +            continue;
> +        }
> +
> +        return isa_edata_arr[i].min_version;
> +    }
> +
> +    /* Default to oldest priv spec if no match found */
> +    return PRIV_VERSION_1_10_0;

This seems backwards to me. If we don't know for how long an extension
has been ratified, then it seems like the default should be "Well, I
guess it's new". Or, we could assert here to ensure we don't have any
extensions having their minimum version checked which are missing version
information. An assert also makes sense for the case that an invalid
ext_offset was passed to this function.

> +}
> +
> +static void cpu_cfg_ext_auto_update(RISCVCPU *cpu, uint32_t ext_offset,
> +                                    bool value)
> +{
> +    CPURISCVState *env = &cpu->env;
> +    bool prev_val = isa_ext_is_enabled(cpu, ext_offset);
> +    int min_version;
> +
> +    if (prev_val == value) {
> +        return;
> +    }
> +
> +    if (value && env->priv_ver != PRIV_VERSION_LATEST) {
> +        /* Do not enable it if priv_ver is older than min_version */
> +        min_version = cpu_cfg_ext_get_min_version(ext_offset);
> +        if (env->priv_ver < min_version) {
> +            return;
> +        }
> +    }
> +
> +    isa_ext_update_enabled(cpu, ext_offset, value);
> +}
> +
>  const char * const riscv_int_regnames[] = {
>      "x0/zero", "x1/ra",  "x2/sp",  "x3/gp",  "x4/tp",  "x5/t0",   "x6/t1",
>      "x7/t2",   "x8/s0",  "x9/s1",  "x10/a0", "x11/a1", "x12/a2",  "x13/a3",
> @@ -1268,12 +1306,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>  
>      /* zca, zcd and zcf has a PRIV 1.12.0 restriction */
>      if (riscv_has_ext(env, RVC) && env->priv_ver >= PRIV_VERSION_1_12_0) {
> -        cpu->cfg.ext_zca = true;
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
>          if (riscv_has_ext(env, RVF) && env->misa_mxl_max == MXL_RV32) {
> -            cpu->cfg.ext_zcf = true;
> +            cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
>          }
>          if (riscv_has_ext(env, RVD)) {
> -            cpu->cfg.ext_zcd = true;
> +            cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcd), true);
>          }
>      }
>  
> -- 
> 2.41.0
> 
>

Thanks,
drew

