Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E6778EBF2
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 13:26:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbfod-0004TY-BH; Thu, 31 Aug 2023 07:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbfob-0004TH-LH
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 07:26:21 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbfoY-0006Ie-DO
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 07:26:20 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-99bfcf4c814so80003366b.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 04:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693481176; x=1694085976; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tLcHiqeAenZ6NsEuxaGG6Y80bSaQpZCgG3oLob0+r3c=;
 b=Gw+Z87IYPfqsjOxHhTaj4O7R0wdywswx4AUu4bnpAxamrMfJ1ITNoBjx/6t2N1mdhl
 1QAt+u/LdKfDcYhAOWsNL4FS/Lqt7yu6bMYD7l1ssL3TwZSTgx4Y8yerXyjNK++KhJi9
 fa07zM729zTr7bPbwP47ebsBCfVQcq5w2VV1ZXKCvpYSBIsWzb4KCTJx/3UD5YuSQ+D/
 wUquQ+xnuqCcl0SQYWpTxH2CLzhKr2PtE7nBayLr4sLZ0xsH9xcx3VFAbXop2uBKAuPo
 xSvzx4KuEH0+S8FE8IBChucCZfn07gTlBUKlsZamr0hsFPGljZWGjyqL9ol3+5YWCi7d
 g96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693481176; x=1694085976;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tLcHiqeAenZ6NsEuxaGG6Y80bSaQpZCgG3oLob0+r3c=;
 b=COTrOAS4jc7KK7rajmMOOb21D5AhX3ZnZLledyc6sYvBY8fxbAprr5zCJgaVYHII6s
 CVLqtdsAy9VErxhmt/zcmKr4fXz2/1UA8ZaUzK4aDQ8C316arEFAttwPi/L68dco/AwS
 Bu8nhT0X2/SvENMGgjSDLvdZm1e6C3gYs8idhE1TMkgRATYFz6HV4H8v9zze7+rZg7n+
 grZ4/DOA8uzhH3VSQa3t/yIu6QOpwoXjIkyXC4hNb5VClXMrgcgWH7tw8ILnk5U/V1/O
 0K4I9ezKuzeRFnoJ1bvaZNvezzV3ckkYZmGhTvpHKE26lRgWmbukTjsXXx+Ds68ZhGVn
 11qw==
X-Gm-Message-State: AOJu0Yw/smSXKw6RfDW1jObQT+nmhOGV30R5bXrJsMAvjJMTUlTVZmCx
 8X6zs+gJ1u5DaRJSubUqKZdv3w==
X-Google-Smtp-Source: AGHT+IFw1Yxs5GDvRtx5w7XhO7vbgBHI9g2iqfeP5ktR215z3Gg1YCdq5wAwOeFZVS/bQI/R7BHGUw==
X-Received: by 2002:a17:906:d2:b0:9a2:276d:d83c with SMTP id
 18-20020a17090600d200b009a2276dd83cmr3407937eji.18.1693481176181; 
 Thu, 31 Aug 2023 04:26:16 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 jw26-20020a17090776ba00b00982a92a849asm657851ejc.91.2023.08.31.04.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 04:26:15 -0700 (PDT)
Date: Thu, 31 Aug 2023 13:26:14 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 11/20] target/riscv: introduce KVM AccelCPUClass
Message-ID: <20230831-8ace82713569aa6d2109302b@orel>
References: <20230825130853.511782-1-dbarboza@ventanamicro.com>
 <20230825130853.511782-12-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825130853.511782-12-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62b.google.com
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

On Fri, Aug 25, 2023 at 10:08:44AM -0300, Daniel Henrique Barboza wrote:
> Add a KVM accelerator class like we did with TCG. The difference is
> that, at least for now, we won't be using a realize() implementation for
> this accelerator.
> 
> We'll start by assiging kvm_riscv_cpu_add_kvm_properties(), renamed to
> kvm_cpu_instance_init(), as a 'cpu_instance_init' implementation. Change
> riscv_cpu_post_init() to invoke accel_cpu_instance_init(), which will go
> through the 'cpu_instance_init' impl of the current acceleration (if
> available) and execute it. The end result is that the KVM initial setup,
> i.e. starting registers and adding its specific properties, will be done
> via this hook.
> 
> riscv_cpu_add_user_properties() is still being called via the common
> post_init() function, thus we still need the "if kvm then return" logic
> inside it for now. We'll deal with it when TCG accel class get its own
> 'cpu_instance_init' implementation.
> 
> riscv_add_satp_mode_properties() is now being exported from cpu.c since
> it's a common helper between KVM and TCG.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c       |  8 ++---
>  target/riscv/cpu.h       |  1 +
>  target/riscv/kvm.c       | 64 +++++++++++++++++++++++++++-------------
>  target/riscv/kvm_riscv.h |  1 -
>  4 files changed, 49 insertions(+), 25 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 58b0ef2af8..04c6bfaeef 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1112,7 +1112,7 @@ static void cpu_riscv_set_satp(Object *obj, Visitor *v, const char *name,
>      satp_map->init |= 1 << satp;
>  }
>  
> -static void riscv_add_satp_mode_properties(Object *obj)
> +void riscv_add_satp_mode_properties(Object *obj)
>  {
>      RISCVCPU *cpu = RISCV_CPU(obj);
>  
> @@ -1199,6 +1199,8 @@ static void riscv_cpu_post_init(Object *obj)
>      RISCVCPU *cpu = RISCV_CPU(obj);
>      RISCVCPUClass *rcc = RISCV_CPU_GET_CLASS(cpu);
>  
> +    accel_cpu_instance_init(CPU(obj));
> +
>      if (rcc->user_extension_properties) {
>          riscv_cpu_add_user_properties(obj);
>      }
> @@ -1561,12 +1563,10 @@ static void riscv_cpu_add_multiext_prop_array(Object *obj,
>  static void riscv_cpu_add_user_properties(Object *obj)
>  {
>  #ifndef CONFIG_USER_ONLY
> -    riscv_add_satp_mode_properties(obj);
> -
>      if (kvm_enabled()) {
> -        kvm_riscv_cpu_add_kvm_properties(obj);
>          return;
>      }
> +    riscv_add_satp_mode_properties(obj);
>  #endif
>  
>      riscv_cpu_add_misa_properties(obj);
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index b9c4bea3f7..950c2301f2 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -726,6 +726,7 @@ extern const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[];
>  extern Property riscv_cpu_options[];
>  
>  void riscv_cpu_add_misa_properties(Object *cpu_obj);
> +void riscv_add_satp_mode_properties(Object *obj);
>  
>  /* CSR function table */
>  extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
> diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
> index 7e67121456..3c4fa43cee 100644
> --- a/target/riscv/kvm.c
> +++ b/target/riscv/kvm.c
> @@ -31,6 +31,7 @@
>  #include "sysemu/kvm_int.h"
>  #include "cpu.h"
>  #include "trace.h"
> +#include "hw/core/accel-cpu.h"
>  #include "hw/pci/pci.h"
>  #include "exec/memattrs.h"
>  #include "exec/address-spaces.h"
> @@ -1262,26 +1263,6 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
>      kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
>  }
>  
> -void kvm_riscv_cpu_add_kvm_properties(Object *obj)
> -{
> -    DeviceState *dev = DEVICE(obj);
> -
> -    riscv_init_user_properties(obj);
> -    riscv_cpu_add_misa_properties(obj);
> -
> -    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_extensions);
> -    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_vendor_exts);
> -    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_experimental_exts);
> -
> -    for (Property *prop = riscv_cpu_options; prop && prop->name; prop++) {
> -        /* Check if KVM created the property already */
> -        if (object_property_find(obj, prop->name)) {
> -            continue;
> -        }
> -        qdev_property_add_static(dev, prop);
> -    }
> -}
> -
>  static void riscv_host_cpu_init(Object *obj)
>  {
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
> @@ -1310,3 +1291,46 @@ static const TypeInfo riscv_kvm_cpu_type_infos[] = {
>  };
>  
>  DEFINE_TYPES(riscv_kvm_cpu_type_infos)
> +
> +static void kvm_cpu_instance_init(CPUState *cs)
> +{
> +    Object *obj = OBJECT(RISCV_CPU(cs));
> +    DeviceState *dev = DEVICE(obj);
> +
> +    riscv_init_user_properties(obj);
> +
> +    riscv_add_satp_mode_properties(obj);
> +    riscv_cpu_add_misa_properties(obj);
> +
> +    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_extensions);
> +    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_vendor_exts);
> +    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_experimental_exts);
> +
> +    for (Property *prop = riscv_cpu_options; prop && prop->name; prop++) {
> +        /* Check if we have a specific KVM handler for the option */
> +        if (object_property_find(obj, prop->name)) {
> +            continue;
> +        }
> +        qdev_property_add_static(dev, prop);
> +    }
> +}
> +
> +static void kvm_cpu_accel_class_init(ObjectClass *oc, void *data)
> +{
> +    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
> +
> +    acc->cpu_instance_init = kvm_cpu_instance_init;
> +}
> +
> +static const TypeInfo kvm_cpu_accel_type_info = {
> +    .name = ACCEL_CPU_NAME("kvm"),
> +
> +    .parent = TYPE_ACCEL_CPU,
> +    .class_init = kvm_cpu_accel_class_init,
> +    .abstract = true,
> +};

blank line here

> +static void kvm_cpu_accel_register_types(void)
> +{
> +    type_register_static(&kvm_cpu_accel_type_info);
> +}
> +type_init(kvm_cpu_accel_register_types);
> diff --git a/target/riscv/kvm_riscv.h b/target/riscv/kvm_riscv.h
> index 81e08b8359..a0ea1a7505 100644
> --- a/target/riscv/kvm_riscv.h
> +++ b/target/riscv/kvm_riscv.h
> @@ -19,7 +19,6 @@
>  #ifndef QEMU_KVM_RISCV_H
>  #define QEMU_KVM_RISCV_H
>  
> -void kvm_riscv_cpu_add_kvm_properties(Object *obj);
>  void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
>  void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
>  void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
> -- 
> 2.41.0
> 
>

I'll wait for v2 to complete the review of this one.

Thanks,
drew

