Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F35DD72483B
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 17:52:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6YyU-0008Qz-3J; Tue, 06 Jun 2023 11:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1q6YyS-0008Qo-4r
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 11:51:56 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1q6YyQ-0003Zq-7T
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 11:51:55 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f61530506aso63958835e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 08:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1686066712; x=1688658712;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TbTdaWu1m9avIjIGTy7j45NwK9boTghc8cd4i5AVLqs=;
 b=IoGFhfYmIxCUrMfhIBcly2yDjHo3qeIAEHvE6/0yLX99ROcYv+PMdO20UxdhIwUEEe
 oJ/Zw3bAPGuE787G8esFPGrGQ2uBfPWVxxfcthAnEWhIsiUGtujfN3oa3tiAsrZuPxjw
 2cwthAp1ZOlNtub1ciyX+fH+X2FSJym0ycftZCJFEKwm1YZozUKU1qXT8ySka9tmW6hy
 RHt8OsIMcuNGqvHXPkiBgtbBNyP9i+0bEf5WY/sV2hJ5jRMkF3S4+1NFFBaXF2kQvEj/
 EJWXDgJDvkMr5bsYEPrA/tJ6s4QcB8xKQ8jv1PZuq4TmXxB+NhCV07LnSeBCr25wFpFC
 s0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686066712; x=1688658712;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TbTdaWu1m9avIjIGTy7j45NwK9boTghc8cd4i5AVLqs=;
 b=QmYy++xAGGqEkQG+wWMNlDJsN6oSXBaBFZTaX6cc7sK/fzOwYlMRW/iRBUdpeBXS+Q
 6DLYgfOkknRD65TLnQbVH/8i14oSY/DJQzcfaBypWE1DbZ2JJNkA0L5n/YThX0+xZDrn
 QxVlq74tb5E6Wu3ix9LkNdW2120TjTGvIhq5TKFS9R4ji40/KZ1UzGxNu78RjaAjMunf
 9Jk/BgXkMGQqs7xeUsQKVgnDc2XcS21P4murOI1K0FaNkpF9y6eSvxMTQiY4b6n+SLeo
 0/MAESiT8Pox+eo/ACYBmLnUL0Ww7pVGQbXZ4d3lGKYem60txrs7MeUpxpWPrkuOhltl
 w9pw==
X-Gm-Message-State: AC+VfDxzGw9DH7aVA6DjyAb3YoddQqsBYpDQymxcIrG26IEpe75OT3Qd
 dYAFdmhNMu8FAP7c3s5PyP1GTQ==
X-Google-Smtp-Source: ACHHUZ5jf2bSLm4BNtwjU/nSvnZJmMBG43fcC54+HcgCbKk0nlE3JggG5mJ31fGU35docSUEnpAypw==
X-Received: by 2002:a7b:ce11:0:b0:3f7:3991:61e5 with SMTP id
 m17-20020a7bce11000000b003f7399161e5mr2964300wmc.4.1686066712475; 
 Tue, 06 Jun 2023 08:51:52 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a056000104300b003062ad45243sm12956198wrx.14.2023.06.06.08.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 08:51:52 -0700 (PDT)
Date: Tue, 6 Jun 2023 17:51:51 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 08/16] target/riscv: handle mvendorid/marchid/mimpid for
 KVM CPUs
Message-ID: <20230606-233d35581a6a5b7be768cfc0@orel>
References: <20230530194623.272652-1-dbarboza@ventanamicro.com>
 <20230530194623.272652-9-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530194623.272652-9-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, May 30, 2023 at 04:46:15PM -0300, Daniel Henrique Barboza wrote:
> After changing user validation for mvendorid/marchid/mimpid to guarantee
> that the value is validated on user input time, coupled with the work in
> fetching KVM default values for them by using a scratch CPU, we're
> certain that the values in cpu->cfg.(mvendorid|marchid|mimpid) are
> already good to be written back to KVM.
> 
> There's no need to write the values back for 'host' type CPUs since the
> values can't be changed, so let's do that just for generic CPUs.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/kvm.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
> index cd2974c663..602727cdfd 100644
> --- a/target/riscv/kvm.c
> +++ b/target/riscv/kvm.c
> @@ -495,6 +495,33 @@ void kvm_arch_init_irq_routing(KVMState *s)
>  {
>  }
>  
> +static int kvm_vcpu_set_machine_ids(RISCVCPU *cpu, CPUState *cs)
> +{
> +    CPURISCVState *env = &cpu->env;
> +    uint64_t id;
> +    int ret;
> +
> +    id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
> +                          KVM_REG_RISCV_CONFIG_REG(mvendorid));
> +    ret = kvm_set_one_reg(cs, id, &cpu->cfg.mvendorid);
> +    if (ret != 0) {
> +        return ret;
> +    }
> +
> +    id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
> +                          KVM_REG_RISCV_CONFIG_REG(marchid));
> +    ret = kvm_set_one_reg(cs, id, &cpu->cfg.marchid);
> +    if (ret != 0) {
> +        return ret;
> +    }
> +
> +    id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
> +                          KVM_REG_RISCV_CONFIG_REG(mimpid));
> +    ret = kvm_set_one_reg(cs, id, &cpu->cfg.mimpid);
> +
> +    return ret;
> +}
> +
>  int kvm_arch_init_vcpu(CPUState *cs)
>  {
>      int ret = 0;
> @@ -513,6 +540,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      }
>      env->misa_ext = isa;
>  
> +    if (!object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_CPU_HOST)) {
> +        ret = kvm_vcpu_set_machine_ids(cpu, cs);
> +    }
> +
>      return ret;
>  }
>  
> -- 
> 2.40.1
> 
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

