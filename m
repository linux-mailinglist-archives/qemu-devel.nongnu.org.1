Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4D59DB09C
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Nov 2024 02:07:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGSzD-0005ne-0N; Wed, 27 Nov 2024 20:06:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tGSzA-0005n1-8y; Wed, 27 Nov 2024 20:06:24 -0500
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tGSz6-00053D-5R; Wed, 27 Nov 2024 20:06:23 -0500
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b65db9b69fso18281885a.2; 
 Wed, 27 Nov 2024 17:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732755978; x=1733360778; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZjamOHGRD7keqIMA1aF/S18k8hB8aEPvkSJqPqHyRN0=;
 b=Po969uA2DadF3A6fOII4dbJvFFPts5yHWkW4glxoF/gOEABoMlYAUmObv6bMOaNTfL
 dQAKri1wvRXKPFgvQtW4VD5LtQsS4D17HKchRFEGaJ1zFO/uYtwYa1S9wWjG3+OeNImE
 8HtVxXLUlwaOxQpqzxVh4cXzGS5wLEPPJg83GwkjZPM79eXmi62VCFqn28hLlXCpyBNT
 w9Kwnnfm/otZFgw+meDy5MHE4F3nPJP2KGdbqsTX9dBGdearKCM0AKXNcezpuK3KtxqB
 Y6Nnb9mk8gvuClp5khmaOrPMcLUWkX9v62Y8SpxL9edigVBXOpTypeoJPOW8wsIvzfFj
 V8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732755978; x=1733360778;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZjamOHGRD7keqIMA1aF/S18k8hB8aEPvkSJqPqHyRN0=;
 b=O9+yPGMJzrvvO5k0ynonc+tkLde6wB2M5xPw2LZSbx6z7/oceNfCaUaVSk11z8nbbq
 UX09M5RSGA2ApuwWgHGr1YF+3eoSeaRQhPhFkUYwk1f4KislasFkSo+ulg2NtP/g2ZAb
 kAd+YZjmhMJn+9gwIzFTJBJxxH1A8s5rZD+xmuefc0hVviWzuZMsB5Y1OZ5NKw40BmHs
 kIoSatsY/AxKZo0UIzQ5uzIKNIsBC95Hg2MRJwCP/M5N7t4vUcbJvKb2Ey0gfZeLLzE/
 3rOZfDoV3Q6IVhzB1t6LDBEUCrwawPQDEox/kGN8hvv9sR/sE4NACmUZa9d0RQXJEVPh
 Zomw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlvRr1rWrnSmQksaUKTcQH3OsRZDYJmfwzKz6Vb0217nVcqZ9SGvVcSi1sQ9CO4jUumUDeeJZQ19oQ@nongnu.org
X-Gm-Message-State: AOJu0YyFdxvyN9TJdynNFoe3C9WFtSMYvnkIGq/VKQzbhdnRJSoiPHGV
 tXRKBvzmyfPeoESItSu0CtjboZSLG8lVewxfK6lYCsvTbQUDcNU6F6i4+M0FJ+szp7q4AuCgOn2
 /OM0eikS4yED0lU/6bxoPrAVvoJg=
X-Gm-Gg: ASbGncsIpV15w7b0cfaso/7QimH0C1R5feEcgilvVVjklnraOzgwQakwLpyn+2XmMmV
 HoTAzznZ/GKXgxD3WEkqaM9IiDwKTszbmc6R1EtgtY9LisGR9V9IhvV+Rx22S8A==
X-Google-Smtp-Source: AGHT+IHj4VAPpRzeAdfyE1SP6jeuKUG9jvwFS7o+fMIkzGaHn9t+Z587d2Ss8+DUPM3c1OQMUtYuYl0J5JiLfTeywmM=
X-Received: by 2002:a05:620a:458c:b0:7b1:5680:164b with SMTP id
 af79cd13be357-7b67c29f938mr590056385a.26.1732755978209; Wed, 27 Nov 2024
 17:06:18 -0800 (PST)
MIME-Version: 1.0
References: <20241125134739.18189-1-sai.pavan.boddu@amd.com>
In-Reply-To: <20241125134739.18189-1-sai.pavan.boddu@amd.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 28 Nov 2024 11:05:52 +1000
Message-ID: <CAKmqyKMiX9AVP9tiu=EdDbeshBBTJJB54_kT39r8BmisRTEyWg@mail.gmail.com>
Subject: Re: [PATCH v5] hw/riscv: Add Microblaze V generic board
To: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Simek Michal <michal.simek@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Iglesias Francisco <francisco.iglesias@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=alistair23@gmail.com; helo=mail-qk1-x732.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

On Mon, Nov 25, 2024 at 11:47=E2=80=AFPM Sai Pavan Boddu
<sai.pavan.boddu@amd.com> wrote:
>
> Add a basic board with interrupt controller (intc), timer, serial
> (uartlite), small memory called LMB@0 (128kB) and DDR@0x80000000
> (configured via command line eg. -m 2g).
> This is basic configuration which matches HW generated out of AMD Vivado
> (design tools). But initial configuration is going beyond what it is
> configured by default because validation should be done on other
> configurations too. That's why wire also additional uart16500, axi
> ethernet(with axi dma).
> GPIOs, i2c and qspi is also listed for completeness.
>
> IRQ map is: (addr)
> 0 - timer (0x41c00000)
> 1 - uartlite (0x40600000)
> 2 - i2c (0x40800000)
> 3 - qspi (0x44a00000)
> 4 - uart16550 (0x44a10000)
> 5 - emaclite (0x40e00000)
> 6 - timer2 (0x41c10000)
> 7 - axi emac (0x40c00000)
> 8 - axi dma (0x41e00000)
> 9 - axi dma
> 10 - gpio (0x40000000)
> 11 - gpio2 (0x40010000)
> 12 - gpio3 (0x40020000)
>
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> Changes for V2:
>     Make changes to support -cpu switch
>     Remove setting of default board
>     Include doc to toctree
>     Remove setting of 'imac' extensions as they are available by
>     default.
> Chages for V3:
>     Replace virt with generic
>     Update doc with supported riscv extensions
>     Change base CPU to TYPE_RISCV_CPU_BASE
> Changes for V4:
>     Improved the doc based on comments
>     Disabled support for Double-Precision and Hypervisor extensions
>     Updated Maintainers file at riscv machine space.
> Changes for V5:
>     Rebase over riscv-to-apply.next branch.
>
>  MAINTAINERS                                |   6 +
>  docs/system/riscv/microblaze-v-generic.rst |  42 +++++
>  docs/system/target-riscv.rst               |   1 +
>  hw/riscv/microblaze-v-generic.c            | 184 +++++++++++++++++++++
>  hw/riscv/Kconfig                           |   8 +
>  hw/riscv/meson.build                       |   1 +
>  6 files changed, 242 insertions(+)
>  create mode 100644 docs/system/riscv/microblaze-v-generic.rst
>  create mode 100644 hw/riscv/microblaze-v-generic.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index acc7405aed2..100a138d8f2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1619,6 +1619,12 @@ F: docs/system/riscv/sifive_u.rst
>  F: hw/*/*sifive*.c
>  F: include/hw/*/*sifive*.h
>
> +AMD Microblaze-V Generic Board
> +M: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
> +S: Maintained
> +F: hw/riscv/microblaze-v-generic.c
> +F: docs/system/riscv/microblaze-v-generic.rst
> +
>  RX Machines
>  -----------
>  rx-gdbsim
> diff --git a/docs/system/riscv/microblaze-v-generic.rst b/docs/system/ris=
cv/microblaze-v-generic.rst
> new file mode 100644
> index 00000000000..5606f88d570
> --- /dev/null
> +++ b/docs/system/riscv/microblaze-v-generic.rst
> @@ -0,0 +1,42 @@
> +Microblaze-V generic board (``amd-microblaze-v-generic``)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +The AMD MicroBlaze=E2=84=A2 V processor is a soft-core RISC-V processor =
IP for AMD
> +adaptive SoCs and FPGAs. The MicroBlaze=E2=84=A2 V processor is based on=
 the 32-bit (or
> +64-bit) RISC-V instruction set architecture (ISA) and contains interface=
s
> +compatible with the classic MicroBlaze=E2=84=A2 V processor (i.e it is a=
 drop in
> +replacement for the classic MicroBlaze=E2=84=A2 processor in existing RT=
L designs).
> +More information can be found in below document.
> +
> +https://docs.amd.com/r/en-US/ug1629-microblaze-v-user-guide/MicroBlaze-V=
-Architecture
> +
> +The MicroBlaze=E2=84=A2 V generic board in QEMU has following supported =
devices:
> +
> +    - timer
> +    - uartlite
> +    - uart16550
> +    - emaclite
> +    - timer2
> +    - axi emac
> +    - axi dma
> +
> +The MicroBlaze=E2=84=A2 V core in QEMU has the following configuration:
> +
> +    - RV32I base integer instruction set
> +    - "Zicsr" Control and Status register instructions
> +    - "Zifencei" instruction-fetch
> +    - Extensions: m, a, f, c
> +
> +Running
> +"""""""
> +Below is an example command line for launching mainline U-boot
> +(xilinx_mbv32_defconfig) on the Microblaze-V generic board.
> +
> +.. code-block:: bash
> +
> +   $ qemu-system-riscv32 -M amd-microblaze-v-generic \
> +     -display none \
> +     -device loader,addr=3D0x80000000,file=3Du-boot-spl.bin,cpu-num=3D0 =
\
> +     -device loader,addr=3D0x80200000,file=3Du-boot.img \
> +     -serial mon:stdio \
> +     -device loader,addr=3D0x83000000,file=3Dsystem.dtb \
> +     -m 2g
> diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
> index ba195f1518a..95457af130b 100644
> --- a/docs/system/target-riscv.rst
> +++ b/docs/system/target-riscv.rst
> @@ -66,6 +66,7 @@ undocumented; you can get a complete list by running
>  .. toctree::
>     :maxdepth: 1
>
> +   riscv/microblaze-v-generic
>     riscv/microchip-icicle-kit
>     riscv/shakti-c
>     riscv/sifive_u
> diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-gene=
ric.c
> new file mode 100644
> index 00000000000..427e3baca7b
> --- /dev/null
> +++ b/hw/riscv/microblaze-v-generic.c
> @@ -0,0 +1,184 @@
> +/*
> + * QEMU model of Microblaze V generic board.
> + *
> + * based on hw/microblaze/petalogix_ml605_mmu.c
> + *
> + * Copyright (c) 2011 Michal Simek <monstr@monstr.eu>
> + * Copyright (c) 2011 PetaLogix
> + * Copyright (c) 2009 Edgar E. Iglesias.
> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Written by Sai Pavan Boddu <sai.pavan.boddu@amd.com
> + *     and by Michal Simek <michal.simek@amd.com>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qapi/error.h"
> +#include "cpu.h"
> +#include "hw/sysbus.h"
> +#include "sysemu/sysemu.h"
> +#include "net/net.h"
> +#include "hw/boards.h"
> +#include "hw/char/serial-mm.h"
> +#include "exec/address-spaces.h"
> +#include "hw/char/xilinx_uartlite.h"
> +#include "hw/misc/unimp.h"
> +
> +#define LMB_BRAM_SIZE (128 * KiB)
> +#define MEMORY_BASEADDR 0x80000000
> +#define INTC_BASEADDR 0x41200000
> +#define TIMER_BASEADDR 0x41c00000
> +#define TIMER_BASEADDR2 0x41c10000
> +#define UARTLITE_BASEADDR 0x40600000
> +#define ETHLITE_BASEADDR 0x40e00000
> +#define UART16550_BASEADDR 0x44a10000
> +#define AXIENET_BASEADDR 0x40c00000
> +#define AXIDMA_BASEADDR 0x41e00000
> +#define GPIO_BASEADDR 0x40000000
> +#define GPIO_BASEADDR2 0x40010000
> +#define GPIO_BASEADDR3 0x40020000
> +#define I2C_BASEADDR 0x40800000
> +#define QSPI_BASEADDR 0x44a00000
> +
> +#define TIMER_IRQ           0
> +#define UARTLITE_IRQ        1
> +#define UART16550_IRQ       4
> +#define ETHLITE_IRQ         5
> +#define TIMER_IRQ2          6
> +#define AXIENET_IRQ         7
> +#define AXIDMA_IRQ1         8
> +#define AXIDMA_IRQ0         9
> +
> +static void mb_v_generic_init(MachineState *machine)
> +{
> +    ram_addr_t ram_size =3D machine->ram_size;
> +    DeviceState *dev, *dma, *eth0;
> +    Object *ds, *cs;
> +    int i;
> +    RISCVCPU *cpu;
> +    hwaddr ddr_base =3D MEMORY_BASEADDR;
> +    MemoryRegion *phys_lmb_bram =3D g_new(MemoryRegion, 1);
> +    MemoryRegion *phys_ram =3D g_new(MemoryRegion, 1);
> +    qemu_irq irq[32];
> +    MemoryRegion *sysmem =3D get_system_memory();
> +
> +    cpu =3D RISCV_CPU(object_new(machine->cpu_type));
> +    object_property_set_bool(OBJECT(cpu), "h", false, NULL);
> +    object_property_set_bool(OBJECT(cpu), "d", false, NULL);
> +    qdev_realize(DEVICE(cpu), NULL, &error_abort);
> +    /* Attach emulated BRAM through the LMB.  */
> +    memory_region_init_ram(phys_lmb_bram, NULL,
> +                           "mb_v.lmb_bram", LMB_BRAM_SIZE,
> +                           &error_fatal);
> +    memory_region_add_subregion(sysmem, 0x00000000, phys_lmb_bram);
> +
> +    memory_region_init_ram(phys_ram, NULL, "mb_v.ram",
> +                           ram_size, &error_fatal);
> +    memory_region_add_subregion(sysmem, ddr_base, phys_ram);
> +
> +    dev =3D qdev_new("xlnx.xps-intc");
> +    qdev_prop_set_uint32(dev, "kind-of-intr",
> +                         1 << UARTLITE_IRQ);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, INTC_BASEADDR);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
> +                       qdev_get_gpio_in(DEVICE(cpu), 11));
> +    for (i =3D 0; i < 32; i++) {
> +        irq[i] =3D qdev_get_gpio_in(dev, i);
> +    }
> +
> +    /* Uartlite */
> +    dev =3D qdev_new(TYPE_XILINX_UARTLITE);
> +    qdev_prop_set_chr(dev, "chardev", serial_hd(0));
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, UARTLITE_BASEADDR);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[UARTLITE_IRQ]);
> +
> +    /* Full uart */
> +    serial_mm_init(sysmem, UART16550_BASEADDR + 0x1000, 2,
> +                   irq[UART16550_IRQ], 115200, serial_hd(1),
> +                   DEVICE_LITTLE_ENDIAN);
> +
> +    /* 2 timers at irq 0 @ 100 Mhz.  */
> +    dev =3D qdev_new("xlnx.xps-timer");
> +    qdev_prop_set_uint32(dev, "one-timer-only", 0);
> +    qdev_prop_set_uint32(dev, "clock-frequency", 100000000);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, TIMER_BASEADDR);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
> +
> +    /* 2 timers at irq 3 @ 100 Mhz.  */
> +    dev =3D qdev_new("xlnx.xps-timer");
> +    qdev_prop_set_uint32(dev, "one-timer-only", 0);
> +    qdev_prop_set_uint32(dev, "clock-frequency", 100000000);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, TIMER_BASEADDR2);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ2]);
> +
> +    /* Emaclite */
> +    dev =3D qdev_new("xlnx.xps-ethernetlite");
> +    qemu_configure_nic_device(dev, true, NULL);
> +    qdev_prop_set_uint32(dev, "tx-ping-pong", 0);
> +    qdev_prop_set_uint32(dev, "rx-ping-pong", 0);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ETHLITE_BASEADDR);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[ETHLITE_IRQ]);
> +
> +    /* axi ethernet and dma initialization. */
> +    eth0 =3D qdev_new("xlnx.axi-ethernet");
> +    dma =3D qdev_new("xlnx.axi-dma");
> +
> +    /* FIXME: attach to the sysbus instead */
> +    object_property_add_child(qdev_get_machine(), "xilinx-eth", OBJECT(e=
th0));
> +    object_property_add_child(qdev_get_machine(), "xilinx-dma", OBJECT(d=
ma));
> +
> +    ds =3D object_property_get_link(OBJECT(dma),
> +                                  "axistream-connected-target", NULL);
> +    cs =3D object_property_get_link(OBJECT(dma),
> +                                  "axistream-control-connected-target", =
NULL);
> +    qemu_configure_nic_device(eth0, true, NULL);
> +    qdev_prop_set_uint32(eth0, "rxmem", 0x1000);
> +    qdev_prop_set_uint32(eth0, "txmem", 0x1000);
> +    object_property_set_link(OBJECT(eth0), "axistream-connected", ds,
> +                             &error_abort);
> +    object_property_set_link(OBJECT(eth0), "axistream-control-connected"=
, cs,
> +                             &error_abort);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(eth0), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(eth0), 0, AXIENET_BASEADDR);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(eth0), 0, irq[AXIENET_IRQ]);
> +
> +    ds =3D object_property_get_link(OBJECT(eth0),
> +                                  "axistream-connected-target", NULL);
> +    cs =3D object_property_get_link(OBJECT(eth0),
> +                                  "axistream-control-connected-target", =
NULL);
> +    qdev_prop_set_uint32(dma, "freqhz", 100000000);
> +    object_property_set_link(OBJECT(dma), "axistream-connected", ds,
> +                             &error_abort);
> +    object_property_set_link(OBJECT(dma), "axistream-control-connected",=
 cs,
> +                             &error_abort);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, AXIDMA_BASEADDR);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dma), 0, irq[AXIDMA_IRQ0]);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dma), 1, irq[AXIDMA_IRQ1]);
> +
> +    /* unimplemented devices */
> +    create_unimplemented_device("gpio", GPIO_BASEADDR, 0x10000);
> +    create_unimplemented_device("gpio2", GPIO_BASEADDR2, 0x10000);
> +    create_unimplemented_device("gpio3", GPIO_BASEADDR3, 0x10000);
> +    create_unimplemented_device("i2c", I2C_BASEADDR, 0x10000);
> +    create_unimplemented_device("qspi", QSPI_BASEADDR, 0x10000);
> +}
> +
> +static void mb_v_generic_machine_init(MachineClass *mc)
> +{
> +    mc->desc =3D "AMD Microblaze-V generic platform";
> +    mc->init =3D mb_v_generic_init;
> +    mc->min_cpus =3D 1;
> +    mc->max_cpus =3D 1;
> +    mc->default_cpu_type =3D TYPE_RISCV_CPU_BASE;
> +    mc->default_cpus =3D 1;
> +}
> +
> +DEFINE_MACHINE("amd-microblaze-v-generic", mb_v_generic_machine_init)
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 2e88467c4ab..e6a0ac1fa1d 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -25,6 +25,14 @@ config MICROCHIP_PFSOC
>      select SIFIVE_PLIC
>      select UNIMP
>
> +config MICROBLAZE_V
> +    bool
> +    default y
> +    depends on RISCV32 || RISCV64
> +    select XILINX
> +    select XILINX_AXI
> +    select XILINX_ETHLITE
> +
>  config OPENTITAN
>      bool
>      default y
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index 3be13d77748..3c7e083aca1 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -11,5 +11,6 @@ riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spik=
e.c'))
>  riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_p=
fsoc.c'))
>  riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
>  riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c',=
 'riscv-iommu-pci.c', 'riscv-iommu-sys.c'))
> +riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-g=
eneric.c'))
>
>  hw_arch +=3D {'riscv': riscv_ss}
> --
> 2.34.1
>

