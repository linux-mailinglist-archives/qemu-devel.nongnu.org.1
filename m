Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3BE7AA840
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 07:26:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjYfF-0003Et-UV; Fri, 22 Sep 2023 01:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qjYfD-0003EU-Q4; Fri, 22 Sep 2023 01:25:15 -0400
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qjYfA-0003GC-MQ; Fri, 22 Sep 2023 01:25:14 -0400
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-49334907238so708421e0c.3; 
 Thu, 21 Sep 2023 22:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695360310; x=1695965110; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OqCaPE5KVSolibf2EkvgvspLP99MpNTudZFPxJdlExg=;
 b=msJi0518XpIxon66olCZiStLb2uPukjDPLKiJEUPVx1XaUxuXRXHkRGwEUqoB2IYUk
 8xYQ7lmcnNyUx3+okkE9q1Fx0DVRas/6yvKi/cM6CyZh4ds5EUX7zDuug1Az8oCN+aeV
 G16M2FaWBCqrm5aZWQCBEfaEXaNiRiftOVIQII96m6q5qZ4g3PqZk4Y063I1+fE068Fw
 IB2dYjrWSQLsNw79WqPR7AafJ/sB1o1CRpj3hb3NnLd653evwLS4yJuHQEoelybuQq7Z
 V1j64+GaocQGG8QkB2JvIYkMucsGoxUUqKyGg8FUoJYh7VeHJaAXVhym//2lfGr+9FK+
 J3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695360310; x=1695965110;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OqCaPE5KVSolibf2EkvgvspLP99MpNTudZFPxJdlExg=;
 b=qZiYuZjdopEox0xvyWaMEpeJMybxCOqSuSK47fJmsm4ajr1wRDTXKQu//EBinAg9Ex
 Ohmh/1mj/fPg6ljUN9fxVdCtier3L/1rOZ2IAzN1W+3srxe8mjUhJ0BimdMS02qIAqH5
 1pFHnpomfXoZVey5qfl7OPTXpAJapDeBhJw7erraYcIeXJ51M/5l7ADfZkLxFmnyH1A2
 eg87Tv0FFPY/lt+lQ95x8rV/YmIFjaEWy5d4/BMxZ8OW7HJjdWRWz5kS1oTYGSuyE5of
 xke2yOSJpVFIM0DfNXZWW8a82bdIt+M1soaWyD/RpQTyMzhkwQw4bnjUzkwtaJmvNh2A
 Pmhg==
X-Gm-Message-State: AOJu0Ywaimb64FjV9IFHBkEABjQoJ//GYHo5D92oacfZGSxZlGpRqIXG
 UMz8UEzNgmJHN0N/uu3GN6i0MBFT3a0dat9uZLM=
X-Google-Smtp-Source: AGHT+IGAltDmdoVAUi1jhVPMhMMV0sEnhW2kfylMLh0DsZfmVMCiPD9ge4I+doqmlTklKkx2ZxgbvBVNelQwXdws7TY=
X-Received: by 2002:a1f:e3c7:0:b0:495:d35e:f64b with SMTP id
 a190-20020a1fe3c7000000b00495d35ef64bmr6949026vkh.3.1695360309954; Thu, 21
 Sep 2023 22:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230920112020.651006-1-dbarboza@ventanamicro.com>
 <20230920112020.651006-2-dbarboza@ventanamicro.com>
In-Reply-To: <20230920112020.651006-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 22 Sep 2023 15:24:43 +1000
Message-ID: <CAKmqyKNj7YUfUZGw_4-5nsRanyL6WMxsBAgPy1mqx4DZHNmcfQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/19] target/riscv: introduce TCG AccelCPUClass
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, philmd@linaro.org, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Sep 20, 2023 at 9:22=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
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
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c           |  5 +---
>  target/riscv/cpu.h           |  4 +++
>  target/riscv/meson.build     |  2 ++
>  target/riscv/tcg/meson.build |  2 ++
>  target/riscv/tcg/tcg-cpu.c   | 58 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 67 insertions(+), 4 deletions(-)
>  create mode 100644 target/riscv/tcg/meson.build
>  create mode 100644 target/riscv/tcg/tcg-cpu.c
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 2644638b11..e72c49c881 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2288,9 +2288,7 @@ static const struct SysemuCPUOps riscv_sysemu_ops =
=3D {
>  };
>  #endif
>
> -#include "hw/core/tcg-cpu-ops.h"
> -
> -static const struct TCGCPUOps riscv_tcg_ops =3D {
> +const struct TCGCPUOps riscv_tcg_ops =3D {
>      .initialize =3D riscv_translate_init,
>      .synchronize_from_tb =3D riscv_cpu_synchronize_from_tb,
>      .restore_state_to_opc =3D riscv_restore_state_to_opc,
> @@ -2449,7 +2447,6 @@ static void riscv_cpu_class_init(ObjectClass *c, vo=
id *data)
>  #endif
>      cc->gdb_arch_name =3D riscv_gdb_arch_name;
>      cc->gdb_get_dynamic_xml =3D riscv_gdb_get_dynamic_xml;
> -    cc->tcg_ops =3D &riscv_tcg_ops;
>
>      object_class_property_add(c, "mvendorid", "uint32", cpu_get_mvendori=
d,
>                                cpu_set_mvendorid, NULL, NULL);
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 7d6cfb07ea..16a2dfa8c7 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -707,6 +707,10 @@ enum riscv_pmu_event_idx {
>      RISCV_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS =3D 0x10021,
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
>  target_arch +=3D {'riscv': riscv_ss}
>  target_softmmu_arch +=3D {'riscv': riscv_system_ss}
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
> index 0000000000..0326cead0d
> --- /dev/null
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -0,0 +1,58 @@
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
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
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
> +    cc->tcg_ops =3D &riscv_tcg_ops;
> +}
> +
> +static void tcg_cpu_class_init(CPUClass *cc)
> +{
> +    cc->init_accel_cpu =3D tcg_cpu_init_ops;
> +}
> +
> +static void tcg_cpu_accel_class_init(ObjectClass *oc, void *data)
> +{
> +    AccelCPUClass *acc =3D ACCEL_CPU_CLASS(oc);
> +
> +    acc->cpu_class_init =3D tcg_cpu_class_init;
> +}
> +
> +static const TypeInfo tcg_cpu_accel_type_info =3D {
> +    .name =3D ACCEL_CPU_NAME("tcg"),
> +
> +    .parent =3D TYPE_ACCEL_CPU,
> +    .class_init =3D tcg_cpu_accel_class_init,
> +    .abstract =3D true,
> +};
> +
> +static void tcg_cpu_accel_register_types(void)
> +{
> +    type_register_static(&tcg_cpu_accel_type_info);
> +}
> +type_init(tcg_cpu_accel_register_types);
> --
> 2.41.0
>
>

