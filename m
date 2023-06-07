Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76043725DF7
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 14:07:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6rvZ-0004Rr-SD; Wed, 07 Jun 2023 08:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1q6rvW-0004RE-12
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 08:06:10 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1q6rvP-0001bP-Q2
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 08:06:09 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3063433fa66so6134564f8f.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 05:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1686139561; x=1688731561;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FZ4FML1tFN3OExSPfgzW8aebCXGWtZ6fFJO7EWxdwZE=;
 b=SghoNl1sq2qa0xOs4wg7wDmXVNjin8yPki5RrxQ/w1vQBJUtKTtI3EQvNSv4nvmQl3
 DGWVrDFouHMpSrEu0kOURP2NIw5DCsq9NtpSUkZsVdGxPUCFAbR2oXqWwVwWwM+IVlie
 gthLE05Q6hFL22qT482mXwRsD7WSlOdjqtrQKj549r3O2iaAX5c/IDmCnObetq8lpJii
 PcRA53hQ55eAm4MqjY1fuFVdmM/Djfh2y3ECLxg4sj1T1CSHOKF+4KZ20HHZNf4pLEDg
 MUf009ne8Iv1k4hqBOw8gTPvmWlT/sPI+0Av3k/q8DDnmkiBMiam9ro7PQ/W6IijzlKF
 rkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686139561; x=1688731561;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZ4FML1tFN3OExSPfgzW8aebCXGWtZ6fFJO7EWxdwZE=;
 b=L5eBNO92soDuMJeBt3XQveTY4Xaz15s5VvP6csm+PGJXUMQZxDLy1K5P/oDwzpDO6G
 6Efh6Fr8jg3WNT5dJKvDIg5Dj/yEfxYELaPCsOgp6lJ8ZsfjHFTdmzoLk3xlmshMJy60
 /Rh+YSAa41JqoR/jgZFz/KwcBDMhQJ/TQOS52TZr+hAKDigu2NGNrlk2DwiRnpFfreZ6
 MbilCEXakO1LQ834wV6Shsgqsr8g2TlMm1C2EqUhQ6Aj2sVZqPXkGxSy3Mr+f5BMbcmt
 7fkersl+CnfvqZLj1swnISs9o5D3hr15zWJi89EtOau6eQw/yPdTKey2u3PWrsP1aLvd
 BOHQ==
X-Gm-Message-State: AC+VfDz78jcyI7lGFTUPHQBDZCHOlo50WU8BN/9Clh6tunZMqySMtLfL
 Le9ziFoxtjoBJR2TCODjPCtuqw==
X-Google-Smtp-Source: ACHHUZ6sMmKfLfS10cxTf3ncn3PWzvua6QhUjCpFLZZdKfIZw+dqh5Qkgy8JuNivasn+RVKfxX5G9Q==
X-Received: by 2002:a5d:53cd:0:b0:307:86fb:dae2 with SMTP id
 a13-20020a5d53cd000000b0030786fbdae2mr4014363wrw.67.1686139561389; 
 Wed, 07 Jun 2023 05:06:01 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a5d5451000000b0030631f199f9sm15278043wrv.34.2023.06.07.05.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 05:06:00 -0700 (PDT)
Date: Wed, 7 Jun 2023 14:05:59 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 12/16] target/riscv/kvm.c: update KVM MISA bits
Message-ID: <20230607-c99f4cbc55fb2f02b4a26023@orel>
References: <20230530194623.272652-1-dbarboza@ventanamicro.com>
 <20230530194623.272652-13-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530194623.272652-13-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x435.google.com
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

On Tue, May 30, 2023 at 04:46:19PM -0300, Daniel Henrique Barboza wrote:
> Our design philosophy with KVM properties can be resumed in two main
> decisions based on KVM interface availability and what the user wants to
> do:
> 
> - if the user disables an extension that the host KVM module doesn't
> know about (i.e. it doesn't implement the kvm_get_one_reg() interface),
> keep booting the CPU. This will avoid users having to deal with issues
> with older KVM versions while disabling features they don't care;
> 
> - for any other case we're going to error out immediately. If the user
> wants to enable a feature that KVM doesn't know about this a problem that
> is worth aborting - the user must know that the feature wasn't enabled
> in the hart. Likewise, if KVM knows about the extension, the user wants
> to enable/disable it, and we fail to do it so, that's also a problem we
> can't shrug it off.
> 
> For MISA bits we're going to be a little more conservative: we won't
> even try enabling bits that aren't already available in the host. The
> ioctl() is so likely to fail that's not worth trying. This check is
> already done in the previous patch, in kvm_cpu_set_misa_ext_cfg(), thus
> we don't need to worry about it now.
> 
> In kvm_riscv_update_cpu_misa_ext() we'll go through every potential user
> option and do as follows:
> 
> - if the user didn't set the property or set to the same value of the
> host, do nothing;
> 
> - Disable the given extension in KVM. If it fails we need to verify the
> error code. -EINVAL indicates that KVM doesn't know about the reg, so
> re-enable the extension in env->misa_ext and keep booting. If it fails

We shouldn't "re-enable the extension in env->misa_ext..." when the
extension isn't supported by KVM for any reason. But, assuming EINVAL
is only returned when KVM doesn't support the extension (I wish it
returned ENOENT instead), then we'll never get EINVAL here in update
anyway. env->misa_ext is initialized to what KVM supports, so it
wouldn't have had this unsupported extension bit set in the first
place, meaning 'user_set' wouldn't get set at property setting time
either.

> for any other reason we're going to exit out.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/kvm.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
> index 6afd56cda5..bb1dafe263 100644
> --- a/target/riscv/kvm.c
> +++ b/target/riscv/kvm.c
> @@ -166,6 +166,42 @@ static void kvm_cpu_set_misa_ext_cfg(Object *obj, Visitor *v,
>                 "enabled in the host", misa_ext_cfg->name);
>  }
>  
> +static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
> +{
> +    CPURISCVState *env = &cpu->env;
> +    uint64_t id, reg;
> +    int i, ret;
> +
> +    for (i = 0; i < ARRAY_SIZE(kvm_misa_ext_cfgs); i++) {
> +        RISCVCPUMisaExtConfig *misa_cfg = &kvm_misa_ext_cfgs[i];
> +
> +        if (!misa_cfg->user_set) {
> +            continue;
> +        }
> +
> +        /* If we're here we're going to disable the MISA bit */
> +        reg = 0;
> +        id = kvm_riscv_reg_id(env, KVM_REG_RISCV_ISA_EXT,
> +                              misa_cfg->kvm_reg_id);
> +        ret = kvm_set_one_reg(cs, id, &reg);
> +        if (ret != 0) {
> +            if (ret == -EINVAL) {
> +                /*
> +                 * KVM doesn't know how to handle this bit. Since
> +                 * it's an extension that the user wants to disable,
> +                 * do not error out.
> +                 */
> +                continue;

This case can be replaced with a comment explaining we don't ever
expect EINVAL here at update time, since user_set will never be
true for user-disabled extensions which KVM doesn't support.

> +            } else {
> +                error_report("Unable to set KVM reg %s, error %d",
> +                             misa_cfg->name, ret);
> +                exit(EXIT_FAILURE);
> +            }
> +        }
> +        env->misa_ext &= ~misa_cfg->misa_bit;
> +    }
> +}
> +
>  static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
>  {
>      int i;
> @@ -632,8 +668,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
>  
>      if (!object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_CPU_HOST)) {
>          ret = kvm_vcpu_set_machine_ids(cpu, cs);
> +        if (ret != 0) {
> +            return ret;
> +        }
>      }
>  
> +    kvm_riscv_update_cpu_misa_ext(cpu, cs);
> +
>      return ret;
>  }
>  
> -- 
> 2.40.1
> 
>

Thanks,
drew

