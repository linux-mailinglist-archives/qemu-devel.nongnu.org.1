Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6D472605E
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 15:03:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6snl-0007Qw-3a; Wed, 07 Jun 2023 09:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1q6snB-0007Kh-7D
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 09:01:43 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1q6sn7-00060Q-TR
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 09:01:35 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f6e1394060so61586045e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 06:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1686142892; x=1688734892;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TeJK4NnWaOBltG8XftMyzfx5GPBD+HryeyIHH7RXrqg=;
 b=dUk0bdhKbc0pyOb4Tp3G0wVAnvMd/5JP9dRBaYe41A88lgdhzJlTUTpqK9Y1Rb+Jta
 XZMBYxP/HcaoytfOmCryp4t9XrqtvXjwtsBI/gW7pdOL98hb/0VwLcg0qop0oPmqDeZ3
 dDNoy4ImNxCY06XG7NBn2eMGDMHMztBKS/Lzn+VKa5aRrgAx9X4FdlL6SjySZAdKbF7V
 crJPuYkNAPtNivPXMWkZIc+V+Zfho8QUnRTRtqHgh7wBvlsFuDxC05AQxjt4HAcqMv8z
 S4gzpEE+Uf2s13gAgLof3Wsfct4FaHU4OB7ISYmef4HuRVHLMUMfPgMLc2loByu8wjXm
 8fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686142892; x=1688734892;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TeJK4NnWaOBltG8XftMyzfx5GPBD+HryeyIHH7RXrqg=;
 b=aCFcDXK5boASYJuBzdBRqdA/Fu8TlbV6mOWFieowec7Kgshx/Vu+TbZ+U4ePBWB73h
 5uqgpRXdE/Kw1xPd85GZcNl9yTaP2hLAYQ0s930dwJ7qq2DPMci50tPVA8ke5i5BxMhj
 hPEpktR5lSuV3D5/vakp+r5j/1iCE1AJqSCTmUBK2QAWCK16DeX7fvJR9WlK7b6cHB9d
 IswzECVxnePHHlUeuuLnbHfluU5tQQ4zpXtm8f/qD6qHKKBcNRnWuv+D1cPg72bNPirN
 rpKxPzF8BQKdQkuxOFDbNe1ZRDZvlv9oI6IzQT00xZPZtGQ1LBcd/rCJsrUmbhDASjEq
 X+kA==
X-Gm-Message-State: AC+VfDyPzVwUtjw0VOpJ30GgAFSvr2HPjS1XGUUlqwkkvo4+djhx23Dq
 bRySmcqVZ3yNQy56zPwi6oV4dg==
X-Google-Smtp-Source: ACHHUZ7eTXCorBUCdFbzhy5byziJax2BtKJAjMSpwt3n+RLOp9LPxO/UiPjgNXqT9SauWutKEy4PmQ==
X-Received: by 2002:a7b:c3c9:0:b0:3f7:3526:d96f with SMTP id
 t9-20020a7bc3c9000000b003f73526d96fmr4794994wmj.27.1686142891607; 
 Wed, 07 Jun 2023 06:01:31 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 y12-20020adff14c000000b0030ae7bd1737sm15650670wro.45.2023.06.07.06.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 06:01:31 -0700 (PDT)
Date: Wed, 7 Jun 2023 15:01:30 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 16/16] target/riscv/kvm.c: read/write
 (cbom|cboz)_blocksize in KVM
Message-ID: <20230607-95d85b924e7d8696ba1eac6e@orel>
References: <20230530194623.272652-1-dbarboza@ventanamicro.com>
 <20230530194623.272652-17-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530194623.272652-17-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x331.google.com
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

On Tue, May 30, 2023 at 04:46:23PM -0300, Daniel Henrique Barboza wrote:
> If we don't set a proper cbom_blocksize|cboz_blocksize in the FDT the
> Linux Kernel will fail to detect the availability of the CBOM/CBOZ
> extensions, regardless of the contents of the 'riscv,isa' DT prop.
> 
> The FDT is being written using the cpu->cfg.cbom|z_blocksize attributes,
> so let's use them. We'll also expose them as user flags like it is
> already done with TCG.
> 
> However, in contrast with what happens with TCG, the user is not able to
> set any value that is different from the 'host' value. And KVM can be
> harsh dealing with it: a ENOTSUPP can be thrown for the mere attempt of
> executing kvm_set_one_reg() for these 2 regs.
> 
> We'll read the 'host' value and use it to set these values, regardless of
> user choice. If the user happened to chose a different value, error out.
> We'll also error out if we failed to read the block sizes.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/kvm.c | 94 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 92 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
> index 92b99fe261..7789d835e5 100644
> --- a/target/riscv/kvm.c
> +++ b/target/riscv/kvm.c
> @@ -241,8 +241,16 @@ static void kvm_cpu_cfg_set(RISCVCPU *cpu, RISCVCPUMultiExtConfig *multi_ext,
>                              uint32_t val)
>  {
>      int cpu_cfg_offset = multi_ext->cpu_cfg_offset;
> -    bool *ext_enabled = (void *)&cpu->cfg + cpu_cfg_offset;
> +    uint16_t *blocksize;
> +    bool *ext_enabled;
>  
> +    if (strstr(multi_ext->name, "blocksize")) {
> +        blocksize = (void *)&cpu->cfg + cpu_cfg_offset;
> +        *blocksize = val;
> +        return;
> +    }

We should add 'get' accessors to each property and then always use those
accessors to get the values. Trying to share a single accessor across
properties, using the names to determine their sizes, is basically trying
to reinvent 'get' without the function pointer.

> +
> +    ext_enabled = (void *)&cpu->cfg + cpu_cfg_offset;
>      *ext_enabled = val;
>  }
>  
> @@ -250,8 +258,15 @@ static uint32_t kvm_cpu_cfg_get(RISCVCPU *cpu,
>                                  RISCVCPUMultiExtConfig *multi_ext)
>  {
>      int cpu_cfg_offset = multi_ext->cpu_cfg_offset;
> -    bool *ext_enabled = (void *)&cpu->cfg + cpu_cfg_offset;
> +    uint16_t *blocksize;
> +    bool *ext_enabled;
>  
> +    if (strstr(multi_ext->name, "blocksize")) {
> +        blocksize = (void *)&cpu->cfg + cpu_cfg_offset;
> +        return *blocksize;
> +    }
> +
> +    ext_enabled = (void *)&cpu->cfg + cpu_cfg_offset;
>      return *ext_enabled;
>  }
>  
> @@ -295,6 +310,33 @@ static void kvm_cpu_set_multi_ext_cfg(Object *obj, Visitor *v,
>      kvm_cpu_cfg_set(cpu, multi_ext_cfg, value);
>  }
>  
> +/*
> + * We'll avoid extra complexity by always assuming this
> + * array order with cbom first.
> + */
> +static RISCVCPUMultiExtConfig kvm_cbomz_blksize_cfgs[] = {

Hmm, yet another cfg struct type, and this one is specific to block sizes.
I'd rather we find a way to keep cfg definitions more general and then use
the same struct for all.

> +    {.name = "cbom_blocksize", .cpu_cfg_offset = CPUCFG(cbom_blocksize),
> +     .kvm_reg_id = KVM_REG_RISCV_CONFIG_REG(zicbom_block_size)},
> +    {.name = "cboz_blocksize", .cpu_cfg_offset = CPUCFG(cboz_blocksize),
> +     .kvm_reg_id = KVM_REG_RISCV_CONFIG_REG(zicboz_block_size)},
> +};
> +
> +static void kvm_cpu_set_cbomz_blksize(Object *obj, Visitor *v,
> +                                      const char *name,
> +                                      void *opaque, Error **errp)
> +{
> +    RISCVCPUMultiExtConfig *cbomz_size_cfg = opaque;
> +    RISCVCPU *cpu = RISCV_CPU(obj);
> +    uint16_t value;
> +
> +    if (!visit_type_uint16(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    cbomz_size_cfg->user_set = true;
> +    kvm_cpu_cfg_set(cpu, cbomz_size_cfg, value);
> +}
> +
>  static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVCPU *cpu, CPUState *cs)
>  {
>      CPURISCVState *env = &cpu->env;
> @@ -321,6 +363,45 @@ static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVCPU *cpu, CPUState *cs)
>      }
>  }
>  
> +static void kvm_riscv_finalize_features(RISCVCPU *cpu, CPUState *cs)
> +{
> +    CPURISCVState *env = &cpu->env;
> +    uint64_t id, reg;
> +    int i, ret;
> +
> +    for (i = 0; i < ARRAY_SIZE(kvm_cbomz_blksize_cfgs); i++) {
> +        RISCVCPUMultiExtConfig *cbomz_cfg = &kvm_cbomz_blksize_cfgs[i];
> +        uint64_t host_val;
> +
> +        if ((i == 0 && !cpu->cfg.ext_icbom) ||
> +            (i == 1 && !cpu->cfg.ext_icboz)) {

Rather than the required array order and this magic index stuff, we can
just save the offset of the ext_* boolean in the cfg structure, like we
already do for the *_blocksize, and then check it here.

Also, I think we want to warn here if cbomz_cfg->user_set is set. If the
user set some block size, but disabled the extension, then they should be
told that the block size will be ignored. Letting them know it's ignored
is particularly good to do since we're not validating it. I.e. the user
shouldn't assume the block size they put there is worth anything at all.

> +            continue;
> +        }
> +
> +        id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
> +                              cbomz_cfg->kvm_reg_id);
> +
> +        ret = kvm_get_one_reg(cs, id, &host_val);
> +        if (ret != 0) {
> +            error_report("Unable to read KVM reg val %s, error %d",
> +                         cbomz_cfg->name, ret);
> +            exit(EXIT_FAILURE);
> +        }
> +
> +        if (cbomz_cfg->user_set) {
> +            reg = kvm_cpu_cfg_get(cpu, cbomz_cfg);
> +            if (reg != host_val) {
> +                error_report("Unable to set %s to a different value than "
> +                             "the host (%lu)",
> +                             cbomz_cfg->name, host_val);
> +                exit(EXIT_FAILURE);
> +            }
> +        }
> +
> +        kvm_cpu_cfg_set(cpu, cbomz_cfg, host_val);
> +    }
> +}
> +
>  static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
>  {
>      int i;
> @@ -344,6 +425,14 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
>                              kvm_cpu_set_multi_ext_cfg,
>                              NULL, multi_cfg);
>      }
> +
> +    for (i = 0; i < ARRAY_SIZE(kvm_cbomz_blksize_cfgs); i++) {
> +        RISCVCPUMultiExtConfig *cbomz_size_cfg = &kvm_cbomz_blksize_cfgs[i];
> +
> +        object_property_add(cpu_obj, cbomz_size_cfg->name, "uint16",
> +                            NULL, kvm_cpu_set_cbomz_blksize,
> +                            NULL, cbomz_size_cfg);
> +    }
>  }
>  
>  void kvm_riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
> @@ -856,6 +945,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>  
>      kvm_riscv_update_cpu_misa_ext(cpu, cs);
>      kvm_riscv_update_cpu_cfg_isa_ext(cpu, cs);
> +    kvm_riscv_finalize_features(cpu, cs);
>  
>      return ret;
>  }
> -- 
> 2.40.1
> 
>

Thanks,
drew

