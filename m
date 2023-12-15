Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA3A8148F2
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 14:20:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE85r-0001Gb-Bs; Fri, 15 Dec 2023 08:19:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rE85k-0001Fh-NE
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 08:19:03 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rE85X-0003W4-F4
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 08:18:59 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40c6e2a47f6so1619775e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 05:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1702646325; x=1703251125; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=djA7FcnI63J1+fYPQAAehjaBKy14bvVgPKykUF9alwM=;
 b=P5anR9dVPi4BlXnLFDBuCbBMG7kkeOYmXbwEqJr83VGHgVKngP4oz2ZuuKI4B4y1AL
 8ws7tUNAn+ugMDLCQauKeKplPjgU85c/DStCXA73hxiaQG2ThdgK1FFlT9KzCYL+iUHD
 L22BjZoDSRjnHfKG/19NgUmmSkHtRd/5xz3G7vi4prfrwKTmNtbyMFIOrBb/ZVKpp665
 YKo3qxUCGuyjc274IAkBHouf4hiyxkxoeH+BhFtJf3e7hNYdIcImSqah96/NWY2b0xQb
 LZV/r76Q3PAfAet/AD9eIS+iD+sSUH7FmDNo6LsY+cfY6LwL9lrML7SYgSC0O64ojJGJ
 2Iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702646325; x=1703251125;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=djA7FcnI63J1+fYPQAAehjaBKy14bvVgPKykUF9alwM=;
 b=vmUbUHwFF9k+R2zThwQYq9ZgovTprn6XCXpBTVLrDPtQV3RJLVxZtssj/araXLzMw2
 OXYvck3d/unyIqQ8+EauuGyYy2Iw67F1x/AQnHga832aGcn2EntXOuD5JCgOZMUIx+Q1
 7LKfeeP13omrarz7wlx4K2RvGsqzhxv/26YJRJgSCzR7jJU6FNLJFHEgsmC6SVRV2BHn
 8tW2ZsOY+NmVLPie9jNXZanisThKV3dplRwEepFZ16gY2z1NXyX88FgIFN8CuvAT5xEI
 yRFXcKbdh0iZHGfnsz5tu67M8jY7qsq16TIusw9QTTQGU5Nb/8VsCFybItOeS8Z2UOd8
 pkzQ==
X-Gm-Message-State: AOJu0YzYtdgVOpUl6AkJbDA8GkF5CVIrVx9B3j+yq0BnlD7RR1SN0E26
 iwc6dM8i43gJY8QWsqs3HtWBAg==
X-Google-Smtp-Source: AGHT+IGOPwwEq8indyfn2J6nDxEWm3bo3h1DNwFjd/ABisxkb0UT2x2gwuhX21rJ+FpALcVRIs6IbA==
X-Received: by 2002:a05:600c:1ca7:b0:40c:3902:cf17 with SMTP id
 k39-20020a05600c1ca700b0040c3902cf17mr3044056wms.74.1702646325164; 
 Fri, 15 Dec 2023 05:18:45 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a05600c198f00b0040c4620b9fasm20512056wmq.11.2023.12.15.05.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 05:18:44 -0800 (PST)
Date: Fri, 15 Dec 2023 14:18:43 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH for-9.0 4/5] target/riscv/kvm: add RISCV_CONFIG_REG()
Message-ID: <20231215-76ed2a549d7b92118b50eee8@orel>
References: <20231208183835.2411523-1-dbarboza@ventanamicro.com>
 <20231208183835.2411523-5-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208183835.2411523-5-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Dec 08, 2023 at 03:38:34PM -0300, Daniel Henrique Barboza wrote:
> Create a RISCV_CONFIG_REG() macro, similar to what other regs use, to
> hide away some of the boilerplate.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/kvm/kvm-cpu.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 476e5d4b3d..11797338ec 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -88,6 +88,10 @@ static uint64_t kvm_riscv_reg_id_u64(uint64_t type, uint64_t idx)
>  #define RISCV_CSR_REG(env, name)  kvm_riscv_reg_id(env, KVM_REG_RISCV_CSR, \
>                   KVM_REG_RISCV_CSR_REG(name))
>  
> +#define RISCV_CONFIG_REG(env, name) \
> +    kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG, \
> +                     KVM_REG_RISCV_CONFIG_REG(name))
> +
>  #define RISCV_TIMER_REG(name)  kvm_riscv_reg_id_u64(KVM_REG_RISCV_TIMER, \
>                   KVM_REG_RISCV_TIMER_REG(name))
>  
> @@ -756,24 +760,21 @@ static void kvm_riscv_init_machine_ids(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
>      struct kvm_one_reg reg;
>      int ret;
>  
> -    reg.id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
> -                              KVM_REG_RISCV_CONFIG_REG(mvendorid));
> +    reg.id = RISCV_CONFIG_REG(env, mvendorid);
>      reg.addr = (uint64_t)&cpu->cfg.mvendorid;
>      ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
>      if (ret != 0) {
>          error_report("Unable to retrieve mvendorid from host, error %d", ret);
>      }
>  
> -    reg.id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
> -                              KVM_REG_RISCV_CONFIG_REG(marchid));
> +    reg.id = RISCV_CONFIG_REG(env, marchid);
>      reg.addr = (uint64_t)&cpu->cfg.marchid;
>      ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
>      if (ret != 0) {
>          error_report("Unable to retrieve marchid from host, error %d", ret);
>      }
>  
> -    reg.id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
> -                              KVM_REG_RISCV_CONFIG_REG(mimpid));
> +    reg.id = RISCV_CONFIG_REG(env, mimpid);
>      reg.addr = (uint64_t)&cpu->cfg.mimpid;
>      ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
>      if (ret != 0) {
> @@ -788,8 +789,7 @@ static void kvm_riscv_init_misa_ext_mask(RISCVCPU *cpu,
>      struct kvm_one_reg reg;
>      int ret;
>  
> -    reg.id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
> -                              KVM_REG_RISCV_CONFIG_REG(isa));
> +    reg.id = RISCV_CONFIG_REG(env, isa);
>      reg.addr = (uint64_t)&env->misa_ext_mask;
>      ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
>  
> @@ -1094,8 +1094,7 @@ static int kvm_vcpu_set_machine_ids(RISCVCPU *cpu, CPUState *cs)
>      uint64_t id;
>      int ret;
>  
> -    id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
> -                          KVM_REG_RISCV_CONFIG_REG(mvendorid));
> +    id = RISCV_CONFIG_REG(env, mvendorid);
>      /*
>       * cfg.mvendorid is an uint32 but a target_ulong will
>       * be written. Assign it to a target_ulong var to avoid
> @@ -1107,15 +1106,13 @@ static int kvm_vcpu_set_machine_ids(RISCVCPU *cpu, CPUState *cs)
>          return ret;
>      }
>  
> -    id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
> -                          KVM_REG_RISCV_CONFIG_REG(marchid));
> +    id = RISCV_CONFIG_REG(env, marchid);
>      ret = kvm_set_one_reg(cs, id, &cpu->cfg.marchid);
>      if (ret != 0) {
>          return ret;
>      }
>  
> -    id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
> -                          KVM_REG_RISCV_CONFIG_REG(mimpid));
> +    id = RISCV_CONFIG_REG(env, mimpid);
>      ret = kvm_set_one_reg(cs, id, &cpu->cfg.mimpid);
>  
>      return ret;
> -- 
> 2.41.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

