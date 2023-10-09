Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 426567BD4C0
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 09:54:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpl5S-0002YJ-Qs; Mon, 09 Oct 2023 03:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qpl5R-0002Xl-5t
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 03:53:57 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qpl5P-0001OZ-2j
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 03:53:56 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-53b32dca0bfso5643647a12.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 00:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1696838033; x=1697442833; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TkW6pYijW1k39ZdLIxsnPE3kSE4Jo3hGwRviQ5J5N30=;
 b=GHm2exQme2U7/NnId8kzpmF1d/+vSE8xw2KTWOSE8pa4WVvkIESZxh5sHi6WcJfoL7
 AthVRu31xAnWX4XER6gYaAljnVTb9COFEofmOSlb+fcgzEHsDmS2iJcvJuPAqewg3vWm
 i9iXYWCKACcJapzjzWAfmOEtpZ7HRo1N7q0wdiHBtGQYGhn0eHl3lGJISzj/rftqrCAO
 keD2+QSIpmVbMB7V+m6CDWZu1jATAe5t33IumMF3QapMareYpcpyKK/0ZAQeC+UfW1Jk
 Hxtdl0xiiIspJ4ohRBHSkLgQKc56FNV4eFSVEp0xjE4StxY2pWZTAaybseYHZBYdFhfV
 gwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696838033; x=1697442833;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TkW6pYijW1k39ZdLIxsnPE3kSE4Jo3hGwRviQ5J5N30=;
 b=f1DRDb8JWaVbZyV7c+nCNMvUB65JqYwfEGm6chb1GZxceExTFu/WdSzwbS4I0yVbjc
 Di5n54P3mE/mUsYkZHpm2utuPZatd1moruMQ76tYcD4+EkioaXKD5D2BANNSauRO0xKi
 aHBLGS409859KfSbuH83L2c9b2aaEU4sQISPlVsc2PdGEEiMVgkIN3/xUuK4kCAO7XdN
 Tri7VGNODzXDj4GVAT2JMfzC/6hXkcyvpsOt/TYJLufEJFiF8lHkwAnYLImFDacKEj1V
 mJP/r2Cr7r8+V3tXK6GLtiEu87ak2MQGUpnv+W1e4LZvX6hSf7+AfUU0ifXL5P2Jva3P
 YvUA==
X-Gm-Message-State: AOJu0YxL+LkL+L86osoL1XF8dPuqtO6g4aR1lI0AAZI8PBKGTyBxTopR
 YWVlMEZlQznNIa5uAcQf2IAfhg==
X-Google-Smtp-Source: AGHT+IFOdtw8RWiS9/UzRCUTWQUDMe4dIQVDko9SRgOYUAZgLG4FiDgLKkGPh+CUvaKNBlVgdSlQcQ==
X-Received: by 2002:aa7:d6c8:0:b0:536:1a05:a6d2 with SMTP id
 x8-20020aa7d6c8000000b005361a05a6d2mr10452848edr.17.1696838032539; 
 Mon, 09 Oct 2023 00:53:52 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 i13-20020a056402054d00b005231e3d89efsm5791928edx.31.2023.10.09.00.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 00:53:52 -0700 (PDT)
Date: Mon, 9 Oct 2023 09:53:51 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH] target/riscv: deprecate capital 'Z' CPU properties
Message-ID: <20231009-d0af8d9ee38cdd29e97b4570@orel>
References: <20231007171427.1210117-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007171427.1210117-1-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x533.google.com
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

On Sat, Oct 07, 2023 at 02:14:27PM -0300, Daniel Henrique Barboza wrote:
> At this moment there are eleven CPU extension properties that starts
> with capital 'Z': Zifencei, Zicsr, Zihintntl, Zihintpause, Zawrs, Zfa,
> Zfh, Zfhmin, Zve32f, Zve64f and Zve64d. All other extensions are named
> with lower-case letters.
> 
> We want all properties to be named with lower-case letters since it's
> consistent with the riscv-isa string that we create in the FDT. Having
> these 11 properties to be exceptions can be confusing.
> 
> Deprecate all of them. Create their lower-case counterpart to be used as
> maintained CPU properties. When trying to use any deprecated property a
> warning message will be displayed, recommending users to switch to the
> lower-case variant:
> 
> ./build/qemu-system-riscv64 -M virt -cpu rv64,Zifencei=true --nographic
> qemu-system-riscv64: warning: CPU property 'Zifencei' is deprecated. Please use 'zifencei' instead
> 
> This will give users some time to change their scripts before we remove
> the capital 'Z' properties entirely.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  docs/about/deprecated.rst  | 23 ++++++++++++++++++++++
>  target/riscv/cpu.c         | 39 +++++++++++++++++++++++++++-----------
>  target/riscv/cpu.h         |  1 +
>  target/riscv/tcg/tcg-cpu.c | 31 +++++++++++++++++++++++++++++-
>  4 files changed, 82 insertions(+), 12 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 694b878f36..331f10f930 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -378,6 +378,29 @@ of generic CPUs: rv32 and rv64 as default CPUs and 'max' as a feature complete
>  CPU for both 32 and 64 bit builds. Users are then discouraged to use the 'any'
>  CPU type starting in 8.2.
>  
> +RISC-V CPU properties which start with with capital 'Z' (since 8.2)
                                          ^ double with

> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +All RISC-V CPU properties which start with capital 'Z' are being deprecated
> +starting in 8.2. The reason is that they were wrongly added with capital 'Z'
> +in the past. CPU properties were later added with lower-case names, which
> +is the format we want to use from now on.
> +
> +Users which try to use these deprecated properties will receive a warning
> +recommending to switch to their stable counterparts:
> +
> +- "Zifencei" should be replaced with "zifencei"
> +- "Zicsr" should be replaced with "zicsr"
> +- "Zihintntl" should be replaced with "zihintntl"
> +- "Zihintpause" should be replaced with "zihintpause"
> +- "Zawrs" should be replaced with "zawrs"
> +- "Zfa" should be replaced with "zfa"
> +- "Zfh" should be replaced with "zfh"
> +- "Zfhmin" should be replaced with "zfhmin"
> +- "Zve32f" should be replaced with "zve32f"
> +- "Zve64f" should be replaced with "zve64f"
> +- "Zve64d" should be replaced with "zve64d"
> +
>  Block device options
>  ''''''''''''''''''''
>  
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 521bb88538..1cdc3d2609 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1246,17 +1246,17 @@ const char *riscv_get_misa_ext_description(uint32_t bit)
>  const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>      /* Defaults for standard extensions */
>      MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
> -    MULTI_EXT_CFG_BOOL("Zifencei", ext_ifencei, true),
> -    MULTI_EXT_CFG_BOOL("Zicsr", ext_icsr, true),
> -    MULTI_EXT_CFG_BOOL("Zihintntl", ext_zihintntl, true),
> -    MULTI_EXT_CFG_BOOL("Zihintpause", ext_zihintpause, true),
> -    MULTI_EXT_CFG_BOOL("Zawrs", ext_zawrs, true),
> -    MULTI_EXT_CFG_BOOL("Zfa", ext_zfa, true),
> -    MULTI_EXT_CFG_BOOL("Zfh", ext_zfh, false),
> -    MULTI_EXT_CFG_BOOL("Zfhmin", ext_zfhmin, false),
> -    MULTI_EXT_CFG_BOOL("Zve32f", ext_zve32f, false),
> -    MULTI_EXT_CFG_BOOL("Zve64f", ext_zve64f, false),
> -    MULTI_EXT_CFG_BOOL("Zve64d", ext_zve64d, false),
> +    MULTI_EXT_CFG_BOOL("zifencei", ext_ifencei, true),
> +    MULTI_EXT_CFG_BOOL("zicsr", ext_icsr, true),
> +    MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
> +    MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
> +    MULTI_EXT_CFG_BOOL("zawrs", ext_zawrs, true),
> +    MULTI_EXT_CFG_BOOL("zfa", ext_zfa, true),
> +    MULTI_EXT_CFG_BOOL("zfh", ext_zfh, false),
> +    MULTI_EXT_CFG_BOOL("zfhmin", ext_zfhmin, false),
> +    MULTI_EXT_CFG_BOOL("zve32f", ext_zve32f, false),
> +    MULTI_EXT_CFG_BOOL("zve64f", ext_zve64f, false),
> +    MULTI_EXT_CFG_BOOL("zve64d", ext_zve64d, false),
>      MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
>  
>      MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
> @@ -1349,6 +1349,23 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> +/* Deprecated entries marked for future removal */
> +const RISCVCPUMultiExtConfig riscv_cpu_deprecated_exts[] = {
> +    MULTI_EXT_CFG_BOOL("Zifencei", ext_ifencei, true),
> +    MULTI_EXT_CFG_BOOL("Zicsr", ext_icsr, true),
> +    MULTI_EXT_CFG_BOOL("Zihintntl", ext_zihintntl, true),
> +    MULTI_EXT_CFG_BOOL("Zihintpause", ext_zihintpause, true),
> +    MULTI_EXT_CFG_BOOL("Zawrs", ext_zawrs, true),
> +    MULTI_EXT_CFG_BOOL("Zfa", ext_zfa, true),
> +    MULTI_EXT_CFG_BOOL("Zfh", ext_zfh, false),
> +    MULTI_EXT_CFG_BOOL("Zfhmin", ext_zfhmin, false),
> +    MULTI_EXT_CFG_BOOL("Zve32f", ext_zve32f, false),
> +    MULTI_EXT_CFG_BOOL("Zve64f", ext_zve64f, false),
> +    MULTI_EXT_CFG_BOOL("Zve64d", ext_zve64d, false),
> +
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  Property riscv_cpu_options[] = {
>      DEFINE_PROP_UINT8("pmu-num", RISCVCPU, cfg.pmu_num, 16),
>  
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 3f11e69223..e98f5de32e 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -722,6 +722,7 @@ typedef struct RISCVCPUMultiExtConfig {
>  extern const RISCVCPUMultiExtConfig riscv_cpu_extensions[];
>  extern const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[];
>  extern const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[];
> +extern const RISCVCPUMultiExtConfig riscv_cpu_deprecated_exts[];
>  extern Property riscv_cpu_options[];
>  
>  typedef struct isa_ext_data {
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 08b806dc07..00676593f7 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -732,6 +732,25 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
>      }
>  }
>  
> +static bool cpu_ext_is_deprecated(const char *ext_name)
> +{
> +    return isupper(ext_name[0]);
> +}
> +
> +/*
> + * String will be allocated in the heap. Caller is responsible
> + * for freeing it.
> + */
> +static char *cpu_ext_to_lower(const char *ext_name)
> +{
> +    char *ret = g_malloc0(strlen(ext_name) + 1);
> +
> +    strcpy(ret, ext_name);
> +    ret[0] = tolower(ret[0]);
> +
> +    return ret;
> +}
> +
>  static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
>                                    void *opaque, Error **errp)
>  {
> @@ -744,6 +763,13 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
>          return;
>      }
>  
> +    if (cpu_ext_is_deprecated(multi_ext_cfg->name)) {
> +        g_autofree char *lower = cpu_ext_to_lower(multi_ext_cfg->name);
> +
> +        warn_report("CPU property '%s' is deprecated. Please use '%s' instead",
> +                    multi_ext_cfg->name, lower);
> +    }
> +
>      g_hash_table_insert(multi_ext_user_opts,
>                          GUINT_TO_POINTER(multi_ext_cfg->offset),
>                          (gpointer)value);
> @@ -777,13 +803,14 @@ static void cpu_add_multi_ext_prop(Object *cpu_obj,
>                                     const RISCVCPUMultiExtConfig *multi_cfg)
>  {
>      bool generic_cpu = riscv_cpu_is_generic(cpu_obj);
> +    bool deprecated_ext = cpu_ext_is_deprecated(multi_cfg->name);
>  
>      object_property_add(cpu_obj, multi_cfg->name, "bool",
>                          cpu_get_multi_ext_cfg,
>                          cpu_set_multi_ext_cfg,
>                          NULL, (void *)multi_cfg);
>  
> -    if (!generic_cpu) {
> +    if (!generic_cpu || deprecated_ext) {
>          return;
>      }
>  
> @@ -826,6 +853,8 @@ static void riscv_cpu_add_user_properties(Object *obj)
>      riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_vendor_exts);
>      riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_experimental_exts);
>  
> +    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_deprecated_exts);
> +
>      for (Property *prop = riscv_cpu_options; prop && prop->name; prop++) {
>          qdev_property_add_static(DEVICE(obj), prop);
>      }
> -- 
> 2.41.0
> 
>

Other than the text issue,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

