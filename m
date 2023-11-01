Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B2C7DDE3C
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 10:18:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy7Ld-0006fr-7U; Wed, 01 Nov 2023 05:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qy7LZ-0006fF-Nn
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 05:17:09 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qy7LX-0001o6-FD
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 05:17:09 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32ddfb38c02so4641219f8f.3
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 02:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698830226; x=1699435026; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6b4Hvgmnm6eWMyytQmo8/7NR6aylUfkPbqVZdi3CSKw=;
 b=InaObWJJLP8pmwzk8OG8+HrqL1aJ1UkgbT4pGCtvAxPwau/QnMycAH2suNvIXgmj6I
 pyEhXbwgAKIWLUtFOGv7LQLD4ibp6oghyl1GavjHdwee1Por0BKJ86oy6FxkGUuRfMNf
 sYCbdwsQ1hfl8MK6OswqR4l9W7Zc+NWnoRnG9DmgK6KhxZQivOLW6zKjeQeV2a8aVhjP
 w2AMY3WkSaUk+mRCmZh29oGLZmhEgbcf17oa+5DxiteY3tfnSdKGdrAncRR2CzUWUu04
 KEZQn57InsTjgJrgZZ5Olry1LhZIqLRK0wKU648U4okQ7lpyBAYSorAhpclkgojfEp7p
 zeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698830226; x=1699435026;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6b4Hvgmnm6eWMyytQmo8/7NR6aylUfkPbqVZdi3CSKw=;
 b=XV4vzfVnKsiJgSiksuLk4DUmu5jPn4l081VBpSD+Eb9wIMkokcMLdsDGR5aFFbmd1F
 DLSUdijxIA8+Lv0NcdBhERAcyaP3I/9PHU6h6gsSG30tdrOh8sJLu0ZGEMMg7mrnHMkT
 9C1ToIfd5zVxSFTJcTJjmaM80kyg7Aa/Hs6iAodINGD08KaFm2bleBoVXnbja3AJi0av
 Ag/6zphznLy8+WIX2WpeM+XCWc/FG8kJLAnzohg6hyG82hixnUtP0lfr0V+RbRxCAlEa
 jGTEx9rkIJgZYSt4k1R3rkAoD2CXMNuTN4Wm0TAURkorprAtfr8KjKPB5luauxRb09xT
 RuZg==
X-Gm-Message-State: AOJu0YzOKS7vqP3UKd3xYrr7xsSoQyFeSqPya9p7dHzbdr2mn8q9PjD8
 YvZfw8YnGRzn9Z5+4kmnaMDeKg==
X-Google-Smtp-Source: AGHT+IFObF6w+TiAcO5y6xMn4g07PMmWW8fc+GfEWSHQjL2rXcMAr5sC9vSryP/p9tTlBGjF1sX6kQ==
X-Received: by 2002:a5d:4405:0:b0:32d:c0cd:cc15 with SMTP id
 z5-20020a5d4405000000b0032dc0cdcc15mr10514100wrq.46.1698830225810; 
 Wed, 01 Nov 2023 02:17:05 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 v14-20020adfe4ce000000b0031980783d78sm3651009wrm.54.2023.11.01.02.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 02:17:05 -0700 (PDT)
Date: Wed, 1 Nov 2023 10:17:04 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v7 15/16] target/riscv/tcg: validate profiles during
 finalize
Message-ID: <20231101-937cccb8eb2872360d9b6566@orel>
References: <20231031203916.197332-1-dbarboza@ventanamicro.com>
 <20231031203916.197332-16-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031203916.197332-16-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x433.google.com
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

On Tue, Oct 31, 2023 at 05:39:15PM -0300, Daniel Henrique Barboza wrote:
> Enabling a profile and then disabling some of its mandatory extensions
> is a valid use. It can be useful for debugging and testing. But the
> common expected use of enabling a profile is to enable all its mandatory
> extensions.
> 
> Add an user warning when mandatory extensions from an enabled profile
> are disabled in the command line. We're also going to disable the
> profile flag in this case since the profile must include all the
> mandatory extensions. This flag can be exposed by QMP to indicate the
> actual profile state after the CPU is realized.
> 
> After this patch, this will throw warnings:
> 
> -cpu rv64,rva22u64=true,zihintpause=false,zicbom=false,zicboz=false
> 
> qemu-system-riscv64: warning: Profile rva22u64 mandates disabled extension zihintpause
> qemu-system-riscv64: warning: Profile rva22u64 mandates disabled extension zicbom
> qemu-system-riscv64: warning: Profile rva22u64 mandates disabled extension zicboz
> 
> Note that the following will NOT throw warnings because the profile is
> being enabled last, hence all its mandatory extensions will be enabled:
> 
> -cpu rv64,zihintpause=false,zicbom=false,zicboz=false,rva22u64=true
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/tcg/tcg-cpu.c | 70 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 544f6dd01d..23007b19e4 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -147,6 +147,27 @@ static int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
>      g_assert_not_reached();
>  }
>  
> +static const char *cpu_cfg_ext_get_name(uint32_t ext_offset)
> +{
> +    const RISCVCPUMultiExtConfig *feat;
> +    const RISCVIsaExtData *edata;
> +
> +    for (edata = isa_edata_arr; edata && edata->name; edata++) {

No need to check edata isn't null since we have the end-of-list, just like
feat isn't checked below.

> +        if (edata->ext_enable_offset == ext_offset) {
> +            return edata->name;
> +        }
> +    }
> +
> +    for (feat = riscv_cpu_named_features; feat->name != NULL; feat++) {
> +        if (feat->offset == ext_offset) {
> +            return feat->name;
> +        }
> +    }
> +
> +    g_assert_not_reached();
> +}
> +
> +

extra blank line here

>  static void cpu_cfg_ext_auto_update(RISCVCPU *cpu, uint32_t ext_offset,
>                                      bool value)
>  {
> @@ -631,6 +652,54 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>      riscv_cpu_disable_priv_spec_isa_exts(cpu);
>  }
>  
> +static void riscv_cpu_validate_profile(RISCVCPU *cpu,
> +                                       RISCVCPUProfile *profile)
> +{
> +    const char *warn_msg = "Profile %s mandates disabled extension %s";
> +    bool send_warn = profile->user_set && profile->enabled;
> +    bool profile_impl = true;
> +    int i;
> +
> +    for (i = 0; misa_bits[i] != 0; i++) {
> +        uint32_t bit = misa_bits[i];
> +
> +        if (!(profile->misa_ext & bit)) {
> +            continue;
> +        }
> +
> +        if (!riscv_has_ext(&cpu->env, bit)) {
> +            profile_impl = false;
> +
> +            if (send_warn) {
> +                warn_report(warn_msg, profile->name,
> +                            riscv_get_misa_ext_name(bit));
> +            }
> +        }
> +    }
> +
> +    for (i = 0; profile->ext_offsets[i] != RISCV_PROFILE_EXT_LIST_END; i++) {
> +        int ext_offset = profile->ext_offsets[i];
> +
> +        if (!isa_ext_is_enabled(cpu, ext_offset)) {
> +            profile_impl = false;
> +
> +            if (send_warn) {
> +                warn_report(warn_msg, profile->name,
> +                            cpu_cfg_ext_get_name(ext_offset));
> +            }
> +        }
> +    }
> +
> +    profile->enabled = profile_impl;
> +}
> +
> +static void riscv_cpu_validate_profiles(RISCVCPU *cpu)
> +{
> +    for (int i = 0; riscv_profiles[i] != NULL; i++) {
> +        riscv_cpu_validate_profile(cpu, riscv_profiles[i]);
> +    }
> +}
> +
>  void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
>  {
>      CPURISCVState *env = &cpu->env;
> @@ -649,6 +718,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
>      }
>  
>      riscv_cpu_validate_named_features(cpu);
> +    riscv_cpu_validate_profiles(cpu);
>  
>      if (cpu->cfg.ext_smepmp && !cpu->cfg.pmp) {
>          /*
> -- 
> 2.41.0
>

Other than the nits,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

