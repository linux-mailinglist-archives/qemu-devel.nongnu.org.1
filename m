Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8181F78EA0F
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:19:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbekF-0001iY-N2; Thu, 31 Aug 2023 06:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbekC-0001fI-U4
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:17:45 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbek9-000646-Vo
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:17:44 -0400
Received: by mail-lj1-x244.google.com with SMTP id
 38308e7fff4ca-2bd0d135ca3so12522711fa.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693477060; x=1694081860; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W5Kv+jhpnD31nudOXQSXbz+VjLF+EmEAtBRSqSr/qio=;
 b=pZSqeqUKuSbZtA+46xOSo9UiY6Q2yZwGkg2XFMsWxdtRDEedO/HdcFizgN6NdW6pKO
 rtGD04MF3mMzYG2AU78Gqq/5lNPyvp5+3B+4Zs0H2TyUGQGQpovthzijI3JzaMGv+Pcm
 y/hkUmA7BdAlmuhTZDYJqRk2TalPon3uSi6VgC8+ZZh+oGx7/3mtW3+vLFQqLU1dHkz5
 z3G8y9wjCW8zyL9zEW/9U0eFGo44fstq+L+OoA0W5qENfIlWSDIchPcfO0XXWpGFqS3O
 iHpZI3tnktY7bEw6DWT0aiIedWJeZqBykGDW06dwyK6dotbtARehDKLJ4F8quFNPbbw1
 UzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693477060; x=1694081860;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W5Kv+jhpnD31nudOXQSXbz+VjLF+EmEAtBRSqSr/qio=;
 b=FBZ4diluJnzIGFXNttdlW6o54xBHLFsDO/B93ZeMxScxqr1o+ty5c2HnrrWgmUetMN
 YqON4uI6Ssn9g+5z1dTrApoFtn8IW6Smt4CGBbKikcL9DK8/ganRFoB28rljKT9Go3/C
 k6djJExRb4N9W6tXHAGrn/SWKshe8BKzsNrASAbUwCL7JjSX2dhuQN2Kr70BS6F7zTWX
 SylhgOkQdYYUOL08VxA8IM6D0OIASszdoPCqkZcsnaKqcCS4o9YD70UDZ29TZgmy6ThB
 3ufP2AYnb2JbjCxNkEOQBqPCy+3CHYu1wuLjdgOWAHf5jVCAPO9ECRSbwOhryStO0frz
 Bmhw==
X-Gm-Message-State: AOJu0Yw++seYrvN1njQ92eQ4dO2IRFkIRpLww8bXoOQypPJZLbrNNGCs
 v87hGCAiRt4B/ujolHGF9NoinA==
X-Google-Smtp-Source: AGHT+IFmm77ZeHdb1VSILjUhU9gRqkB+Uz3QD+5/hua10XpuOA0zo71XpvnK819VOi4DBIz/99OTQA==
X-Received: by 2002:a2e:9397:0:b0:2bc:e1a3:fbaa with SMTP id
 g23-20020a2e9397000000b002bce1a3fbaamr4113925ljh.22.1693477059435; 
 Thu, 31 Aug 2023 03:17:39 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 r22-20020a170906365600b009a5f1d1564dsm585326ejb.126.2023.08.31.03.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 03:17:38 -0700 (PDT)
Date: Thu, 31 Aug 2023 12:17:37 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 01/20] target/riscv: introduce TCG AccelCPUClass
Message-ID: <20230831-8468b3a793485bb070b5eb6b@orel>
References: <20230825130853.511782-1-dbarboza@ventanamicro.com>
 <20230825130853.511782-2-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825130853.511782-2-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=ajones@ventanamicro.com; helo=mail-lj1-x244.google.com
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

On Fri, Aug 25, 2023 at 10:08:34AM -0300, Daniel Henrique Barboza wrote:
> target/riscv/cpu.c needs to handle all possible accelerators (TCG and
> KVM at this moment) during both init() and realize() time. This forces
> us to resort to a lot of "if tcg" and "if kvm" throughout the code,
> which isn't wrong, but can get cluttered over time. Splitting
> acceleration specific code from cpu.c to its own file will help to
> declutter the existing code and it will also make it easier to support
> KVM/TCG only builds in the future.
> 
> We'll start by adding a new subdir called 'tcg' and a new file called
> 'tcg-cpu.c'. This file will be used to introduce a new accelerator class
> for TCG acceleration in RISC-V, allowing us to center all TCG exclusive
> code in its file instead of using 'cpu.c' for everything. This design is
> inpired by the work Claudio Fontana did in x86 a few years ago in commit
> f5cc5a5c1 ("i386: split cpu accelerators from cpu.c, using
> AccelCPUClass").
> 
> To avoid moving too much code at once we'll start by adding the new file
> and TCG AccelCPUClass declaration. The 'class_init' from the accel class
> will init 'tcg_ops', relieving the common riscv_cpu_class_init() from
> doing it.
> 
> 'riscv_tcg_ops' is being exported from 'cpu.c' for now to avoid having
> to deal with moving code and files around right now. We'll focus on
> decoupling the realize() logic first.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c           |  5 +---
>  target/riscv/cpu.h           |  4 +++
>  target/riscv/meson.build     |  2 ++
>  target/riscv/tcg/meson.build |  2 ++
>  target/riscv/tcg/tcg-cpu.c   | 57 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 66 insertions(+), 4 deletions(-)
>  create mode 100644 target/riscv/tcg/meson.build
>  create mode 100644 target/riscv/tcg/tcg-cpu.c
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 21ebdbf084..38dcbc4dd2 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2275,9 +2275,7 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
>  };
>  #endif
>  
> -#include "hw/core/tcg-cpu-ops.h"
> -
> -static const struct TCGCPUOps riscv_tcg_ops = {
> +const struct TCGCPUOps riscv_tcg_ops = {
>      .initialize = riscv_translate_init,
>      .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
>      .restore_state_to_opc = riscv_restore_state_to_opc,
> @@ -2436,7 +2434,6 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
>  #endif
>      cc->gdb_arch_name = riscv_gdb_arch_name;
>      cc->gdb_get_dynamic_xml = riscv_gdb_get_dynamic_xml;
> -    cc->tcg_ops = &riscv_tcg_ops;
>  
>      object_class_property_add(c, "mvendorid", "uint32", cpu_get_mvendorid,
>                                cpu_set_mvendorid, NULL, NULL);
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 577abcd724..b84b62f84e 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -707,6 +707,10 @@ enum riscv_pmu_event_idx {
>      RISCV_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS = 0x10021,
>  };
>  
> +/* Export tcg_ops until we move everything to tcg/tcg-cpu.c */
> +#include "hw/core/tcg-cpu-ops.h"
> +extern const struct TCGCPUOps riscv_tcg_ops;
> +
>  /* CSR function table */
>  extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
>  
> diff --git a/target/riscv/meson.build b/target/riscv/meson.build
> index 660078bda1..f0486183fa 100644
> --- a/target/riscv/meson.build
> +++ b/target/riscv/meson.build
> @@ -38,5 +38,7 @@ riscv_system_ss.add(files(
>    'riscv-qmp-cmds.c',
>  ))
>  
> +subdir('tcg')
> +
>  target_arch += {'riscv': riscv_ss}
>  target_softmmu_arch += {'riscv': riscv_system_ss}
> diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
> new file mode 100644
> index 0000000000..061df3d74a
> --- /dev/null
> +++ b/target/riscv/tcg/meson.build
> @@ -0,0 +1,2 @@
> +riscv_ss.add(when: 'CONFIG_TCG', if_true: files(
> +  'tcg-cpu.c'))
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> new file mode 100644
> index 0000000000..1ad27a26aa
> --- /dev/null
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -0,0 +1,57 @@
> +/*
> + * riscv TCG cpu class initialization
> + *
> + * Copyright (c) 2023 Ventana Micro Systems Inc.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "qemu/accel.h"
> +#include "hw/core/accel-cpu.h"
> +
> +static void tcg_cpu_init_ops(AccelCPUClass *accel_cpu, CPUClass *cc)
> +{
> +    /*
> +     * All cpus use the same set of operations.
> +     * riscv_tcg_ops is being imported from cpu.c for now.
> +     */
> +    cc->tcg_ops = &riscv_tcg_ops;
> +}
> +
> +static void tcg_cpu_class_init(CPUClass *cc)
> +{
> +    cc->init_accel_cpu = tcg_cpu_init_ops;
> +}
> +
> +static void tcg_cpu_accel_class_init(ObjectClass *oc, void *data)
> +{
> +    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
> +
> +    acc->cpu_class_init = tcg_cpu_class_init;
> +}
> +
> +static const TypeInfo tcg_cpu_accel_type_info = {
> +    .name = ACCEL_CPU_NAME("tcg"),
> +
> +    .parent = TYPE_ACCEL_CPU,
> +    .class_init = tcg_cpu_accel_class_init,
> +    .abstract = true,
> +};

need blank line here

> +static void tcg_cpu_accel_register_types(void)
> +{
> +    type_register_static(&tcg_cpu_accel_type_info);
> +}
> +type_init(tcg_cpu_accel_register_types);
> -- 
> 2.41.0
> 
>

Appears to be consistent with target/i386/tcg/tcg-cpu.c, so

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

