Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6998873B2
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Mar 2024 20:15:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnkLt-0000OY-1h; Fri, 22 Mar 2024 15:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rnkLo-0000ND-QR
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 15:14:49 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rnkLj-0006tX-Kt
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 15:14:48 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-513d4559fb4so3130098e87.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 12:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711134882; x=1711739682;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SB5tFJY/veT6GxPPrkEb+vQQHIZAJSKunXoNaMaaDb4=;
 b=DRt3JbG/FiyrQumMBHOJu/P19pI7lX6VLcA8kQgrl7qF5zCIoXclIwJ7iJ6eJRqG+P
 dOFd0XVnqtvy/p+F3nHMc/2zhynZIu5kw7jYvT53dDpMI7IjNQ8mrqpI75SS9evShWkX
 g8K+ULJQki02mie4HbW+sQZ+bEQPwz7Io5nKLixRF1Tk2hz6hsGCsNf30hc1wmGQx89Q
 UvJWsZFz4s+XHNj4CHRAuW3bEqpfAif1FqLvhqHre76YhXBs03hApCNMULSeXv2PgYZK
 GPoT+5r6ZlY8p3uxXojTXQVf4rIiHPEqkPcsq2GXyS+hR+PBSqWcwfjdVIiTpwgFudge
 Zyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711134882; x=1711739682;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SB5tFJY/veT6GxPPrkEb+vQQHIZAJSKunXoNaMaaDb4=;
 b=Ciu7V6Ffdv4Jm5eS9PZxlYEucOhIkI7pK31KLkHWQvg4Kn5w+kdRilr5+ey+dYpKVr
 0kLLC3cw9RQZzK6JEdBOiVSoVr4OsbUqV3gGrJ+29SobP+vLDlVJrwhn2Soer2SEQ0ds
 N4XI1v4DLnb/qVlf2idldMHeJuRwLbLmmmEhEZcW8TJ8OFE5JwGIbfoMu+t5ztUAuN+d
 oe1RRkaZl2Ssy4oGZFo83w+Exh0h+n6lqZ0MbDn6VfCRbKREnA+nd/UY+ZkV6wZuYSxL
 EHpiUWUJIqWMIN8TxlyneUdkSbR4rJVrpfqlpZbMFtHHf7LKzNUyRIKwgXctEblCrolW
 nonA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc8MPzDtCk5+l1YnjC1TN2/KQ9A/ZUV1SW034qSHKBhZ5cl1qDa3e4VuknOf7Q/gxs0q2VYaBEpqNV9USNcFucWAEsAmU=
X-Gm-Message-State: AOJu0YzZ57WCwQEmevC5+pvmMB2eRCYVI/+lp1lOXg2jVI7cnfIvw1x2
 7MM8USKK91iRaYBMtYAEHTqRCYGx0mwqo37wGHdRrmdzXLno0l4+c3NY8JhWsJxx72BwivhkjFD
 l7/BKoY7v9qDsIXWNOEGw7DiDCY73sxkTywYHxg==
X-Google-Smtp-Source: AGHT+IEeEVmivX2+jylcAGxehS1D3F5nwDX4sKFevR6X9XdF7ALDI5T8d4dhxIKnblAcXCHZhxsEpqZdc9mI00B6tYc=
X-Received: by 2002:ac2:561c:0:b0:513:c85e:2848 with SMTP id
 v28-20020ac2561c000000b00513c85e2848mr274576lfd.34.1711134881452; Fri, 22 Mar
 2024 12:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240312135222.3187945-1-fei2.wu@intel.com>
 <20240312135222.3187945-3-fei2.wu@intel.com>
In-Reply-To: <20240312135222.3187945-3-fei2.wu@intel.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Fri, 22 Mar 2024 12:14:30 -0700
Message-ID: <CAHBxVyG186Zo7nAm7o8=vhBtzU+x8ry4_mWwHxuaZ8BasnDyPg@mail.gmail.com>
Subject: Re: [RFC v2 2/2] hw/riscv: Add server platform reference machine
To: Fei Wu <fei2.wu@intel.com>
Cc: pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 andrei.warkentin@intel.com, shaolin.xie@alibaba-inc.com, ved@rivosinc.com, 
 sunilvl@ventanamicro.com, haibo1.xu@intel.com, evan.chai@intel.com, 
 yin.wang@intel.com, tech-server-platform@lists.riscv.org, 
 tech-server-soc@lists.riscv.org, ajones@ventanamicro.com, conor@kernel.org, 
 heinrich.schuchardt@canonical.com, marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=atishp@rivosinc.com; helo=mail-lf1-x131.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Mar 12, 2024 at 6:53=E2=80=AFAM Fei Wu <fei2.wu@intel.com> wrote:
>
> The RISC-V Server Platform specification[1] defines a standardized set
> of hardware and software capabilities, that portable system software,
> such as OS and hypervisors can rely on being present in a RISC-V server
> platform.
>
> A corresponding Qemu RISC-V server platform reference (rvsp-ref for
> short) machine type is added to provide a environment for firmware/OS
> development and testing. The main features included in rvsp-ref are:
>
>  - Based on riscv virt machine type
>  - A new memory map as close as virt machine as possible
>  - A new virt CPU type rvsp-ref-cpu for server platform compliance
>  - AIA
>  - PCIe AHCI
>  - PCIe NIC
>  - No virtio device
>  - No fw_cfg device
>  - No ACPI table provided
>  - Only minimal device tree nodes
>
> [1] https://github.com/riscv-non-isa/riscv-server-platform
>
> Signed-off-by: Fei Wu <fei2.wu@intel.com>
> ---
>  configs/devices/riscv64-softmmu/default.mak |    1 +
>  hw/riscv/Kconfig                            |   12 +
>  hw/riscv/meson.build                        |    1 +
>  hw/riscv/server_platform_ref.c              | 1276 +++++++++++++++++++
>  4 files changed, 1290 insertions(+)
>  create mode 100644 hw/riscv/server_platform_ref.c
>
> diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/device=
s/riscv64-softmmu/default.mak
> index 3f68059448..a1d98e49ef 100644
> --- a/configs/devices/riscv64-softmmu/default.mak
> +++ b/configs/devices/riscv64-softmmu/default.mak
> @@ -10,5 +10,6 @@ CONFIG_SPIKE=3Dy
>  CONFIG_SIFIVE_E=3Dy
>  CONFIG_SIFIVE_U=3Dy
>  CONFIG_RISCV_VIRT=3Dy
> +CONFIG_SERVER_PLATFORM_REF=3Dy
>  CONFIG_MICROCHIP_PFSOC=3Dy
>  CONFIG_SHAKTI_C=3Dy
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 5d644eb7b1..5674589e66 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -48,6 +48,18 @@ config RISCV_VIRT
>      select ACPI
>      select ACPI_PCI
>
> +config SERVER_PLATFORM_REF
> +    bool
> +    select RISCV_NUMA
> +    select GOLDFISH_RTC
> +    select PCI
> +    select PCI_EXPRESS_GENERIC_BRIDGE
> +    select PFLASH_CFI01
> +    select SERIAL
> +    select RISCV_ACLINT
> +    select RISCV_APLIC
> +    select RISCV_IMSIC
> +
>  config SHAKTI_C
>      bool
>      select RISCV_ACLINT
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index 2f7ee81be3..bb3aff91ea 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -4,6 +4,7 @@ riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('n=
uma.c'))
>  riscv_ss.add(files('riscv_hart.c'))
>  riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
>  riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
> +riscv_ss.add(when: 'CONFIG_SERVER_PLATFORM_REF', if_true: files('server_=
platform_ref.c'))
>  riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
>  riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
>  riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
> diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_re=
f.c
> new file mode 100644
> index 0000000000..b552650265
> --- /dev/null
> +++ b/hw/riscv/server_platform_ref.c
> @@ -0,0 +1,1276 @@
> +/*
> + * QEMU RISC-V Server Platform (RVSP) Reference Board
> + *
> + * Copyright (c) 2024 Intel, Inc.
> + *
> + * This board is compliant RISC-V Server platform specification and leve=
raging
> + * a lot of riscv virt code.
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qemu/error-report.h"
> +#include "qemu/guest-random.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-visit-common.h"
> +#include "hw/boards.h"
> +#include "hw/loader.h"
> +#include "hw/sysbus.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/char/serial.h"
> +#include "hw/block/flash.h"
> +#include "hw/ide/pci.h"
> +#include "hw/ide/ahci-pci.h"
> +#include "hw/pci/pci.h"
> +#include "hw/pci-host/gpex.h"
> +#include "hw/core/sysbus-fdt.h"
> +#include "hw/riscv/riscv_hart.h"
> +#include "hw/riscv/boot.h"
> +#include "hw/riscv/numa.h"
> +#include "hw/intc/riscv_aclint.h"
> +#include "hw/intc/riscv_aplic.h"
> +#include "hw/intc/riscv_imsic.h"
> +#include "chardev/char.h"
> +#include "sysemu/device_tree.h"
> +#include "sysemu/runstate.h"
> +#include "sysemu/sysemu.h"
> +#include "sysemu/tcg.h"
> +#include "target/riscv/cpu.h"
> +#include "target/riscv/pmu.h"
> +#include "net/net.h"
> +
> +#define RVSP_CPUS_MAX_BITS             9
> +#define RVSP_CPUS_MAX                  (1 << RVSP_CPUS_MAX_BITS)
> +#define RVSP_SOCKETS_MAX_BITS          2
> +#define RVSP_SOCKETS_MAX               (1 << RVSP_SOCKETS_MAX_BITS)
> +
> +#define RVSP_IRQCHIP_NUM_MSIS 255
> +#define RVSP_IRQCHIP_NUM_SOURCES 96
> +#define RVSP_IRQCHIP_NUM_PRIO_BITS 3
> +#define RVSP_IRQCHIP_MAX_GUESTS_BITS 3
> +#define RVSP_IRQCHIP_MAX_GUESTS ((1U << RVSP_IRQCHIP_MAX_GUESTS_BITS) - =
1U)
> +
> +#define FDT_PCI_ADDR_CELLS    3
> +#define FDT_PCI_INT_CELLS     1
> +#define FDT_APLIC_INT_CELLS   2
> +#define FDT_IMSIC_INT_CELLS   0
> +#define FDT_MAX_INT_CELLS     2
> +#define FDT_MAX_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + =
\
> +                                 1 + FDT_MAX_INT_CELLS)
> +#define FDT_APLIC_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS =
+ \
> +                                 1 + FDT_APLIC_INT_CELLS)
> +
> +#define NUM_SATA_PORTS  6
> +
> +#define SYSCON_RESET     0x1
> +#define SYSCON_POWEROFF  0x2
> +
> +#define TYPE_RVSP_REF_MACHINE MACHINE_TYPE_NAME("rvsp-ref")
> +OBJECT_DECLARE_SIMPLE_TYPE(RVSPMachineState, RVSP_REF_MACHINE)
> +
> +struct RVSPMachineState {
> +    /*< private >*/
> +    MachineState parent;
> +
> +    /*< public >*/
> +    Notifier machine_done;
> +    RISCVHartArrayState soc[RVSP_SOCKETS_MAX];
> +    DeviceState *irqchip[RVSP_SOCKETS_MAX];
> +    PFlashCFI01 *flash[2];
> +
> +    int fdt_size;
> +    int aia_guests;
> +    const MemMapEntry *memmap;
> +};
> +
> +enum {
> +    RVSP_DEBUG,
> +    RVSP_MROM,
> +    RVSP_RESET_SYSCON,
> +    RVSP_RTC,
> +    RVSP_ACLINT,
> +    RVSP_APLIC_M,
> +    RVSP_APLIC_S,
> +    RVSP_UART0,
> +    RVSP_IMSIC_M,
> +    RVSP_IMSIC_S,
> +    RVSP_FLASH,
> +    RVSP_DRAM,
> +    RVSP_PCIE_MMIO,
> +    RVSP_PCIE_PIO,
> +    RVSP_PCIE_ECAM,
> +    RVSP_PCIE_MMIO_HIGH
> +};
> +
> +enum {
> +    RVSP_UART0_IRQ =3D 10,
> +    RVSP_RTC_IRQ =3D 11,
> +    RVSP_PCIE_IRQ =3D 0x20, /* 32 to 35 */
> +};
> +
> +/*
> + * The server soc reference machine physical address space used by some =
of the
> + * devices namely ACLINT, APLIC and IMSIC depend on number of Sockets, n=
umber
> + * of CPUs, and number of IMSIC guest files.
> + *
> + * Various limits defined by RVSP_SOCKETS_MAX_BITS, RVSP_CPUS_MAX_BITS, =
and
> + * RVSP_IRQCHIP_MAX_GUESTS_BITS are tuned for maximum utilization of ser=
ver soc
> + * reference machine physical address space.
> + */
> +
> +#define RVSP_IMSIC_GROUP_MAX_SIZE      (1U << IMSIC_MMIO_GROUP_MIN_SHIFT=
)
> +#if RVSP_IMSIC_GROUP_MAX_SIZE < \
> +    IMSIC_GROUP_SIZE(RVSP_CPUS_MAX_BITS, RVSP_IRQCHIP_MAX_GUESTS_BITS)
> +#error "Can't accomodate single IMSIC group in address space"
> +#endif
> +
> +#define RVSP_IMSIC_MAX_SIZE            (RVSP_SOCKETS_MAX * \
> +                                        RVSP_IMSIC_GROUP_MAX_SIZE)
> +#if 0x4000000 < RVSP_IMSIC_MAX_SIZE
> +#error "Can't accomodate all IMSIC groups in address space"
> +#endif
> +
> +static const MemMapEntry rvsp_ref_memmap[] =3D {
> +    [RVSP_DEBUG] =3D          {        0x0,         0x100 },
> +    [RVSP_MROM] =3D           {     0x1000,        0xf000 },
> +    [RVSP_RESET_SYSCON] =3D   {   0x100000,        0x1000 },
> +    [RVSP_RTC] =3D            {   0x101000,        0x1000 },
> +    [RVSP_ACLINT] =3D         {  0x2000000,       0x10000 },
> +    [RVSP_PCIE_PIO] =3D       {  0x3000000,       0x10000 },
> +    [RVSP_APLIC_M] =3D        {  0xc000000, APLIC_SIZE(RVSP_CPUS_MAX) },
> +    [RVSP_APLIC_S] =3D        {  0xd000000, APLIC_SIZE(RVSP_CPUS_MAX) },
> +    [RVSP_UART0] =3D          { 0x10000000,         0x100 },
> +    [RVSP_FLASH] =3D          { 0x20000000,     0x4000000 },
> +    [RVSP_IMSIC_M] =3D        { 0x24000000, RVSP_IMSIC_MAX_SIZE },
> +    [RVSP_IMSIC_S] =3D        { 0x28000000, RVSP_IMSIC_MAX_SIZE },
> +    [RVSP_PCIE_ECAM] =3D      { 0x30000000,    0x10000000 },
> +    [RVSP_PCIE_MMIO] =3D      { 0x40000000,    0x40000000 },
> +    [RVSP_DRAM] =3D           { 0x80000000, 0xff80000000ull },
> +    [RVSP_PCIE_MMIO_HIGH] =3D { 0x10000000000ull, 0x10000000000ull },
> +};
> +
> +#define RVSP_FLASH_SECTOR_SIZE (256 * KiB)
> +
> +static PFlashCFI01 *rvsp_flash_create(RVSPMachineState *s,
> +                                      const char *name,
> +                                      const char *alias_prop_name)
> +{
> +    /*
> +     * Create a single flash device.  We use the same parameters as
> +     * the flash devices on the ARM virt board.
> +     */
> +    DeviceState *dev =3D qdev_new(TYPE_PFLASH_CFI01);
> +
> +    qdev_prop_set_uint64(dev, "sector-length", RVSP_FLASH_SECTOR_SIZE);
> +    qdev_prop_set_uint8(dev, "width", 4);
> +    qdev_prop_set_uint8(dev, "device-width", 2);
> +    qdev_prop_set_bit(dev, "big-endian", false);
> +    qdev_prop_set_uint16(dev, "id0", 0x89);
> +    qdev_prop_set_uint16(dev, "id1", 0x18);
> +    qdev_prop_set_uint16(dev, "id2", 0x00);
> +    qdev_prop_set_uint16(dev, "id3", 0x00);
> +    qdev_prop_set_string(dev, "name", name);
> +
> +    object_property_add_child(OBJECT(s), name, OBJECT(dev));
> +    object_property_add_alias(OBJECT(s), alias_prop_name,
> +                              OBJECT(dev), "drive");
> +
> +    return PFLASH_CFI01(dev);
> +}
> +
> +static void rvsp_flash_map(PFlashCFI01 *flash,
> +                           hwaddr base, hwaddr size,
> +                           MemoryRegion *sysmem)
> +{
> +    DeviceState *dev =3D DEVICE(flash);
> +
> +    assert(QEMU_IS_ALIGNED(size, RVSP_FLASH_SECTOR_SIZE));
> +    assert(size / RVSP_FLASH_SECTOR_SIZE <=3D UINT32_MAX);
> +    qdev_prop_set_uint32(dev, "num-blocks", size / RVSP_FLASH_SECTOR_SIZ=
E);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    memory_region_add_subregion(sysmem, base,
> +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(de=
v),
> +                                                       0));
> +}
> +
> +static void rvsp_flash_maps(RVSPMachineState *s,
> +                            MemoryRegion *sysmem)
> +{
> +    hwaddr flashsize =3D rvsp_ref_memmap[RVSP_FLASH].size / 2;
> +    hwaddr flashbase =3D rvsp_ref_memmap[RVSP_FLASH].base;
> +
> +    rvsp_flash_map(s->flash[0], flashbase, flashsize, sysmem);
> +    rvsp_flash_map(s->flash[1], flashbase + flashsize, flashsize, sysmem=
);
> +}
> +
> +static void create_pcie_irq_map(RVSPMachineState *s, void *fdt, char *no=
dename,
> +                                uint32_t irqchip_phandle)
> +{
> +    int pin, dev;
> +    uint32_t irq_map_stride =3D 0;
> +    uint32_t full_irq_map[GPEX_NUM_IRQS * GPEX_NUM_IRQS *
> +                          FDT_MAX_INT_MAP_WIDTH] =3D {};
> +    uint32_t *irq_map =3D full_irq_map;
> +
> +    /*
> +     * This code creates a standard swizzle of interrupts such that
> +     * each device's first interrupt is based on it's PCI_SLOT number.
> +     * (See pci_swizzle_map_irq_fn())
> +     *
> +     * We only need one entry per interrupt in the table (not one per
> +     * possible slot) seeing the interrupt-map-mask will allow the table
> +     * to wrap to any number of devices.
> +     */
> +    for (dev =3D 0; dev < GPEX_NUM_IRQS; dev++) {
> +        int devfn =3D dev * 0x8;
> +
> +        for (pin =3D 0; pin < GPEX_NUM_IRQS; pin++) {
> +            int irq_nr =3D RVSP_PCIE_IRQ +
> +                         ((pin + PCI_SLOT(devfn)) % GPEX_NUM_IRQS);
> +            int i =3D 0;
> +
> +            /* Fill PCI address cells */
> +            irq_map[i] =3D cpu_to_be32(devfn << 8);
> +            i +=3D FDT_PCI_ADDR_CELLS;
> +
> +            /* Fill PCI Interrupt cells */
> +            irq_map[i] =3D cpu_to_be32(pin + 1);
> +            i +=3D FDT_PCI_INT_CELLS;
> +
> +            /* Fill interrupt controller phandle and cells */
> +            irq_map[i++] =3D cpu_to_be32(irqchip_phandle);
> +            irq_map[i++] =3D cpu_to_be32(irq_nr);
> +            irq_map[i++] =3D cpu_to_be32(0x4);
> +
> +            if (!irq_map_stride) {
> +                irq_map_stride =3D i;
> +            }
> +            irq_map +=3D irq_map_stride;
> +        }
> +    }
> +
> +    qemu_fdt_setprop(fdt, nodename, "interrupt-map", full_irq_map,
> +                     GPEX_NUM_IRQS * GPEX_NUM_IRQS *
> +                     irq_map_stride * sizeof(uint32_t));
> +
> +    qemu_fdt_setprop_cells(fdt, nodename, "interrupt-map-mask",
> +                           0x1800, 0, 0, 0x7);
> +}
> +
> +static void create_fdt_socket_cpus(RVSPMachineState *s, int socket,
> +                                   char *clust_name, uint32_t *phandle,
> +                                   uint32_t *intc_phandles)
> +{
> +    int cpu;
> +    uint32_t cpu_phandle;
> +    MachineState *ms =3D MACHINE(s);
> +    bool is_32_bit =3D riscv_is_32bit(&s->soc[0]);
> +    uint8_t satp_mode_max;
> +
> +    for (cpu =3D s->soc[socket].num_harts - 1; cpu >=3D 0; cpu--) {
> +        RISCVCPU *cpu_ptr =3D &s->soc[socket].harts[cpu];
> +        g_autofree char *cpu_name =3D NULL;
> +        g_autofree char *core_name =3D NULL;
> +        g_autofree char *intc_name =3D NULL;
> +        g_autofree char *sv_name =3D NULL;
> +
> +        cpu_phandle =3D (*phandle)++;
> +
> +        cpu_name =3D g_strdup_printf("/cpus/cpu@%d",
> +            s->soc[socket].hartid_base + cpu);
> +        qemu_fdt_add_subnode(ms->fdt, cpu_name);
> +
> +        if (cpu_ptr->cfg.satp_mode.supported !=3D 0) {
> +            satp_mode_max =3D satp_mode_max_from_map(cpu_ptr->cfg.satp_m=
ode.map);
> +            sv_name =3D g_strdup_printf("riscv,%s",
> +                                      satp_mode_str(satp_mode_max, is_32=
_bit));
> +            qemu_fdt_setprop_string(ms->fdt, cpu_name, "mmu-type", sv_na=
me);
> +        }
> +
> +        riscv_isa_write_fdt(cpu_ptr, ms->fdt, cpu_name);
> +
> +        if (cpu_ptr->cfg.ext_zicbom) {
> +            qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cbom-block-s=
ize",
> +                                  cpu_ptr->cfg.cbom_blocksize);
> +        }
> +
> +        if (cpu_ptr->cfg.ext_zicboz) {
> +            qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cboz-block-s=
ize",
> +                                  cpu_ptr->cfg.cboz_blocksize);
> +        }
> +
> +        if (cpu_ptr->cfg.ext_zicbop) {
> +            qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cbop-block-s=
ize",
> +                                  cpu_ptr->cfg.cbop_blocksize);
> +        }
> +
> +        qemu_fdt_setprop_string(ms->fdt, cpu_name, "compatible", "riscv"=
);
> +        qemu_fdt_setprop_string(ms->fdt, cpu_name, "status", "okay");
> +        qemu_fdt_setprop_cell(ms->fdt, cpu_name, "reg",
> +            s->soc[socket].hartid_base + cpu);
> +        qemu_fdt_setprop_string(ms->fdt, cpu_name, "device_type", "cpu")=
;
> +        riscv_socket_fdt_write_id(ms, cpu_name, socket);
> +        qemu_fdt_setprop_cell(ms->fdt, cpu_name, "phandle", cpu_phandle)=
;
> +
> +        intc_phandles[cpu] =3D (*phandle)++;
> +
> +        intc_name =3D g_strdup_printf("%s/interrupt-controller", cpu_nam=
e);
> +        qemu_fdt_add_subnode(ms->fdt, intc_name);
> +        qemu_fdt_setprop_cell(ms->fdt, intc_name, "phandle",
> +            intc_phandles[cpu]);
> +        qemu_fdt_setprop_string(ms->fdt, intc_name, "compatible",
> +            "riscv,cpu-intc");
> +        qemu_fdt_setprop(ms->fdt, intc_name, "interrupt-controller", NUL=
L, 0);
> +        qemu_fdt_setprop_cell(ms->fdt, intc_name, "#interrupt-cells", 1)=
;
> +
> +        core_name =3D g_strdup_printf("%s/core%d", clust_name, cpu);
> +        qemu_fdt_add_subnode(ms->fdt, core_name);
> +        qemu_fdt_setprop_cell(ms->fdt, core_name, "cpu", cpu_phandle);
> +    }
> +}
> +
> +static void create_fdt_socket_memory(RVSPMachineState *s,
> +                                     const MemMapEntry *memmap, int sock=
et)
> +{
> +    g_autofree char *mem_name =3D NULL;
> +    uint64_t addr, size;
> +    MachineState *ms =3D MACHINE(s);
> +
> +    addr =3D memmap[RVSP_DRAM].base + riscv_socket_mem_offset(ms, socket=
);
> +    size =3D riscv_socket_mem_size(ms, socket);
> +    mem_name =3D g_strdup_printf("/memory@%lx", (long)addr);
> +    qemu_fdt_add_subnode(ms->fdt, mem_name);
> +    qemu_fdt_setprop_cells(ms->fdt, mem_name, "reg",
> +        addr >> 32, addr, size >> 32, size);
> +    qemu_fdt_setprop_string(ms->fdt, mem_name, "device_type", "memory");
> +    riscv_socket_fdt_write_id(ms, mem_name, socket);
> +}
> +
> +static void create_fdt_socket_aclint(RVSPMachineState *s,
> +                                     const MemMapEntry *memmap, int sock=
et,
> +                                     uint32_t *intc_phandles)
> +{
> +    int cpu;
> +    g_autofree char *name =3D NULL;
> +    unsigned long addr, size;
> +    uint32_t aclint_cells_size;
> +    g_autofree uint32_t *aclint_mtimer_cells =3D NULL;
> +    MachineState *ms =3D MACHINE(s);
> +
> +    aclint_mtimer_cells =3D g_new0(uint32_t, s->soc[socket].num_harts * =
2);
> +
> +    for (cpu =3D 0; cpu < s->soc[socket].num_harts; cpu++) {
> +        aclint_mtimer_cells[cpu * 2 + 0] =3D cpu_to_be32(intc_phandles[c=
pu]);
> +        aclint_mtimer_cells[cpu * 2 + 1] =3D cpu_to_be32(IRQ_M_TIMER);
> +    }
> +    aclint_cells_size =3D s->soc[socket].num_harts * sizeof(uint32_t) * =
2;
> +
> +    addr =3D memmap[RVSP_ACLINT].base +
> +           (RISCV_ACLINT_DEFAULT_MTIMER_SIZE * socket);
> +    size =3D RISCV_ACLINT_DEFAULT_MTIMER_SIZE;
> +
> +    name =3D g_strdup_printf("/soc/mtimer@%lx", addr);
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible",
> +        "riscv,aclint-mtimer");
> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
> +        0x0, addr + RISCV_ACLINT_DEFAULT_MTIME,
> +        0x0, size - RISCV_ACLINT_DEFAULT_MTIME,
> +        0x0, addr + RISCV_ACLINT_DEFAULT_MTIMECMP,
> +        0x0, RISCV_ACLINT_DEFAULT_MTIME);
> +    qemu_fdt_setprop(ms->fdt, name, "interrupts-extended",
> +        aclint_mtimer_cells, aclint_cells_size);
> +    riscv_socket_fdt_write_id(ms, name, socket);
> +}
> +
> +static uint32_t imsic_num_bits(uint32_t count)
> +{
> +    uint32_t ret =3D 0;
> +
> +    while (BIT(ret) < count) {
> +        ret++;
> +    }
> +
> +    return ret;
> +}
> +
> +static void create_fdt_one_imsic(RVSPMachineState *s, hwaddr base_addr,
> +                                 uint32_t *intc_phandles, uint32_t msi_p=
handle,
> +                                 bool m_mode, uint32_t imsic_guest_bits)
> +{
> +    int cpu, socket;
> +    g_autofree char *imsic_name =3D NULL;
> +    MachineState *ms =3D MACHINE(s);
> +    int socket_count =3D riscv_socket_count(ms);
> +    uint32_t imsic_max_hart_per_socket, imsic_addr, imsic_size;
> +    g_autofree uint32_t *imsic_cells =3D NULL;
> +    g_autofree uint32_t *imsic_regs =3D NULL;
> +
> +    imsic_cells =3D g_new0(uint32_t, ms->smp.cpus * 2);
> +    imsic_regs =3D g_new0(uint32_t, socket_count * 4);
> +
> +    for (cpu =3D 0; cpu < ms->smp.cpus; cpu++) {
> +        imsic_cells[cpu * 2 + 0] =3D cpu_to_be32(intc_phandles[cpu]);
> +        imsic_cells[cpu * 2 + 1] =3D cpu_to_be32(m_mode ? IRQ_M_EXT : IR=
Q_S_EXT);
> +    }
> +
> +    imsic_max_hart_per_socket =3D 0;
> +    for (socket =3D 0; socket < socket_count; socket++) {
> +        imsic_addr =3D base_addr + socket * RVSP_IMSIC_GROUP_MAX_SIZE;
> +        imsic_size =3D IMSIC_HART_SIZE(imsic_guest_bits) *
> +                     s->soc[socket].num_harts;
> +        imsic_regs[socket * 4 + 0] =3D 0;
> +        imsic_regs[socket * 4 + 1] =3D cpu_to_be32(imsic_addr);
> +        imsic_regs[socket * 4 + 2] =3D 0;
> +        imsic_regs[socket * 4 + 3] =3D cpu_to_be32(imsic_size);
> +        if (imsic_max_hart_per_socket < s->soc[socket].num_harts) {
> +            imsic_max_hart_per_socket =3D s->soc[socket].num_harts;
> +        }
> +    }
> +
> +    imsic_name =3D g_strdup_printf("/soc/imsics@%lx", (unsigned long)bas=
e_addr);
> +    qemu_fdt_add_subnode(ms->fdt, imsic_name);
> +    qemu_fdt_setprop_string(ms->fdt, imsic_name, "compatible", "riscv,im=
sics");
> +    qemu_fdt_setprop_cell(ms->fdt, imsic_name, "#interrupt-cells",
> +                          FDT_IMSIC_INT_CELLS);
> +    qemu_fdt_setprop(ms->fdt, imsic_name, "interrupt-controller", NULL, =
0);
> +    qemu_fdt_setprop(ms->fdt, imsic_name, "msi-controller", NULL, 0);
> +    qemu_fdt_setprop(ms->fdt, imsic_name, "interrupts-extended",
> +                     imsic_cells, ms->smp.cpus * sizeof(uint32_t) * 2);
> +    qemu_fdt_setprop(ms->fdt, imsic_name, "reg", imsic_regs,
> +                     socket_count * sizeof(uint32_t) * 4);
> +    qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,num-ids",
> +                     RVSP_IRQCHIP_NUM_MSIS);
> +
> +    if (imsic_guest_bits) {
> +        qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,guest-index-bi=
ts",
> +                              imsic_guest_bits);
> +    }
> +
> +    if (socket_count > 1) {
> +        qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,hart-index-bit=
s",
> +                              imsic_num_bits(imsic_max_hart_per_socket))=
;
> +        qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,group-index-bi=
ts",
> +                              imsic_num_bits(socket_count));
> +        qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,group-index-sh=
ift",
> +                              IMSIC_MMIO_GROUP_MIN_SHIFT);
> +    }
> +    qemu_fdt_setprop_cell(ms->fdt, imsic_name, "phandle", msi_phandle);
> +}
> +
> +static void create_fdt_imsic(RVSPMachineState *s, const MemMapEntry *mem=
map,
> +                             uint32_t *phandle, uint32_t *intc_phandles,
> +                             uint32_t *msi_m_phandle, uint32_t *msi_s_ph=
andle)
> +{
> +    *msi_m_phandle =3D (*phandle)++;
> +    *msi_s_phandle =3D (*phandle)++;
> +
> +    /* M-level IMSIC node */
> +    create_fdt_one_imsic(s, memmap[RVSP_IMSIC_M].base, intc_phandles,
> +                         *msi_m_phandle, true, 0);
> +
> +    /* S-level IMSIC node */
> +    create_fdt_one_imsic(s, memmap[RVSP_IMSIC_S].base, intc_phandles,
> +                         *msi_s_phandle, false,
> +                         imsic_num_bits(s->aia_guests + 1));
> +
> +}
> +
> +static void create_fdt_one_aplic(RVSPMachineState *s, int socket,
> +                                 unsigned long aplic_addr, uint32_t apli=
c_size,
> +                                 uint32_t msi_phandle,
> +                                 uint32_t *intc_phandles,
> +                                 uint32_t aplic_phandle,
> +                                 uint32_t aplic_child_phandle,
> +                                 bool m_mode, int num_harts)
> +{
> +    int cpu;
> +    g_autofree char *aplic_name =3D NULL;
> +    g_autofree uint32_t *aplic_cells =3D g_new0(uint32_t, num_harts * 2)=
;
> +    MachineState *ms =3D MACHINE(s);
> +
> +    aplic_cells =3D g_new0(uint32_t, num_harts * 2);
> +
> +    for (cpu =3D 0; cpu < num_harts; cpu++) {
> +        aplic_cells[cpu * 2 + 0] =3D cpu_to_be32(intc_phandles[cpu]);
> +        aplic_cells[cpu * 2 + 1] =3D cpu_to_be32(m_mode ? IRQ_M_EXT : IR=
Q_S_EXT);
> +    }
> +
> +    aplic_name =3D g_strdup_printf("/soc/aplic@%lx", aplic_addr);
> +    qemu_fdt_add_subnode(ms->fdt, aplic_name);
> +    qemu_fdt_setprop_string(ms->fdt, aplic_name, "compatible", "riscv,ap=
lic");
> +    qemu_fdt_setprop_cell(ms->fdt, aplic_name,
> +                          "#interrupt-cells", FDT_APLIC_INT_CELLS);
> +    qemu_fdt_setprop(ms->fdt, aplic_name, "interrupt-controller", NULL, =
0);
> +
> +    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "msi-parent", msi_phandle=
);
> +
> +    qemu_fdt_setprop_cells(ms->fdt, aplic_name, "reg",
> +                           0x0, aplic_addr, 0x0, aplic_size);
> +    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "riscv,num-sources",
> +                          RVSP_IRQCHIP_NUM_SOURCES);
> +
> +    if (aplic_child_phandle) {
> +        qemu_fdt_setprop_cell(ms->fdt, aplic_name, "riscv,children",
> +                              aplic_child_phandle);
> +        qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegate",
> +                               aplic_child_phandle, 0x1,
> +                               RVSP_IRQCHIP_NUM_SOURCES);
> +    }
> +
> +    riscv_socket_fdt_write_id(ms, aplic_name, socket);
> +    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "phandle", aplic_phandle)=
;
> +}
> +
> +static void create_fdt_socket_aplic(RVSPMachineState *s,
> +                                    const MemMapEntry *memmap, int socke=
t,
> +                                    uint32_t msi_m_phandle,
> +                                    uint32_t msi_s_phandle,
> +                                    uint32_t *phandle,
> +                                    uint32_t *intc_phandles,
> +                                    uint32_t *aplic_phandles,
> +                                    int num_harts)
> +{
> +    unsigned long aplic_addr;
> +    uint32_t aplic_m_phandle, aplic_s_phandle;
> +
> +    aplic_m_phandle =3D (*phandle)++;
> +    aplic_s_phandle =3D (*phandle)++;
> +
> +    /* M-level APLIC node */
> +    aplic_addr =3D memmap[RVSP_APLIC_M].base +
> +                 (memmap[RVSP_APLIC_M].size * socket);
> +    create_fdt_one_aplic(s, socket, aplic_addr, memmap[RVSP_APLIC_M].siz=
e,
> +                         msi_m_phandle, intc_phandles,
> +                         aplic_m_phandle, aplic_s_phandle,
> +                         true, num_harts);
> +
> +    /* S-level APLIC node */
> +    aplic_addr =3D memmap[RVSP_APLIC_S].base +
> +                 (memmap[RVSP_APLIC_S].size * socket);
> +    create_fdt_one_aplic(s, socket, aplic_addr, memmap[RVSP_APLIC_S].siz=
e,
> +                         msi_s_phandle, intc_phandles,
> +                         aplic_s_phandle, 0,
> +                         false, num_harts);
> +
> +    aplic_phandles[socket] =3D aplic_s_phandle;
> +}
> +
> +static void create_fdt_pmu(RVSPMachineState *s)
> +{
> +    g_autofree char *pmu_name =3D g_strdup_printf("/pmu");
> +    MachineState *ms =3D MACHINE(s);
> +    RISCVCPU hart =3D s->soc[0].harts[0];
> +
> +    qemu_fdt_add_subnode(ms->fdt, pmu_name);
> +    qemu_fdt_setprop_string(ms->fdt, pmu_name, "compatible", "riscv,pmu"=
);
> +    riscv_pmu_generate_fdt_node(ms->fdt, hart.pmu_avail_ctrs, pmu_name);
> +}
> +
> +static void create_fdt_sockets(RVSPMachineState *s, const MemMapEntry *m=
emmap,
> +                               uint32_t *phandle,
> +                               uint32_t *irq_mmio_phandle,
> +                               uint32_t *irq_pcie_phandle,
> +                               uint32_t *msi_pcie_phandle)
> +{
> +    int socket, phandle_pos;
> +    MachineState *ms =3D MACHINE(s);
> +    uint32_t msi_m_phandle =3D 0, msi_s_phandle =3D 0;
> +    uint32_t xplic_phandles[MAX_NODES];
> +    g_autofree uint32_t *intc_phandles =3D NULL;
> +    int socket_count =3D riscv_socket_count(ms);
> +
> +    qemu_fdt_add_subnode(ms->fdt, "/cpus");
> +    qemu_fdt_setprop_cell(ms->fdt, "/cpus", "timebase-frequency",
> +                          RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
> +    qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
> +    qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#address-cells", 0x1);
> +    qemu_fdt_add_subnode(ms->fdt, "/cpus/cpu-map");
> +
> +    intc_phandles =3D g_new0(uint32_t, ms->smp.cpus);
> +
> +    phandle_pos =3D ms->smp.cpus;
> +    for (socket =3D (socket_count - 1); socket >=3D 0; socket--) {
> +        g_autofree char *clust_name =3D NULL;
> +        phandle_pos -=3D s->soc[socket].num_harts;
> +
> +        clust_name =3D g_strdup_printf("/cpus/cpu-map/cluster%d", socket=
);
> +        qemu_fdt_add_subnode(ms->fdt, clust_name);
> +
> +        create_fdt_socket_cpus(s, socket, clust_name, phandle,
> +                               &intc_phandles[phandle_pos]);
> +
> +        create_fdt_socket_memory(s, memmap, socket);
> +
> +        create_fdt_socket_aclint(s, memmap, socket,
> +            &intc_phandles[phandle_pos]);
> +    }
> +
> +    create_fdt_imsic(s, memmap, phandle, intc_phandles,
> +        &msi_m_phandle, &msi_s_phandle);
> +    *msi_pcie_phandle =3D msi_s_phandle;
> +
> +    phandle_pos =3D ms->smp.cpus;
> +    for (socket =3D (socket_count - 1); socket >=3D 0; socket--) {
> +        phandle_pos -=3D s->soc[socket].num_harts;
> +
> +        create_fdt_socket_aplic(s, memmap, socket,
> +                                msi_m_phandle, msi_s_phandle, phandle,
> +                                &intc_phandles[phandle_pos],
> +                                xplic_phandles,
> +                                s->soc[socket].num_harts);
> +    }
> +
> +    for (socket =3D 0; socket < socket_count; socket++) {
> +        if (socket =3D=3D 0) {
> +            *irq_mmio_phandle =3D xplic_phandles[socket];
> +            *irq_pcie_phandle =3D xplic_phandles[socket];
> +        }
> +        if (socket =3D=3D 1) {
> +            *irq_pcie_phandle =3D xplic_phandles[socket];
> +        }
> +    }
> +
> +    riscv_socket_fdt_write_distance_matrix(ms);
> +}
> +
> +static void create_fdt_pcie(RVSPMachineState *s, const MemMapEntry *memm=
ap,
> +                            uint32_t irq_pcie_phandle,
> +                            uint32_t msi_pcie_phandle)
> +{
> +    g_autofree char *name =3D NULL;
> +    MachineState *ms =3D MACHINE(s);
> +
> +    name =3D g_strdup_printf("/soc/pci@%lx",
> +        (long) memmap[RVSP_PCIE_ECAM].base);
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "#address-cells",
> +        FDT_PCI_ADDR_CELLS);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "#interrupt-cells",
> +        FDT_PCI_INT_CELLS);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "#size-cells", 0x2);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible",
> +        "pci-host-ecam-generic");
> +    qemu_fdt_setprop_string(ms->fdt, name, "device_type", "pci");
> +    qemu_fdt_setprop_cell(ms->fdt, name, "linux,pci-domain", 0);
> +    qemu_fdt_setprop_cells(ms->fdt, name, "bus-range", 0,
> +        memmap[RVSP_PCIE_ECAM].size / PCIE_MMCFG_SIZE_MIN - 1);
> +    qemu_fdt_setprop(ms->fdt, name, "dma-coherent", NULL, 0);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "msi-parent", msi_pcie_phandle)=
;
> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg", 0,
> +        memmap[RVSP_PCIE_ECAM].base, 0, memmap[RVSP_PCIE_ECAM].size);
> +    qemu_fdt_setprop_sized_cells(ms->fdt, name, "ranges",
> +        1, FDT_PCI_RANGE_IOPORT, 2, 0,
> +        2, memmap[RVSP_PCIE_PIO].base, 2, memmap[RVSP_PCIE_PIO].size,
> +        1, FDT_PCI_RANGE_MMIO,
> +        2, memmap[RVSP_PCIE_MMIO].base,
> +        2, memmap[RVSP_PCIE_MMIO].base, 2, memmap[RVSP_PCIE_MMIO].size,
> +        1, FDT_PCI_RANGE_MMIO_64BIT,
> +        2, memmap[RVSP_PCIE_MMIO_HIGH].base,
> +        2, memmap[RVSP_PCIE_MMIO_HIGH].base, 2,
> +           memmap[RVSP_PCIE_MMIO_HIGH].size);
> +
> +    create_pcie_irq_map(s, ms->fdt, name, irq_pcie_phandle);
> +}
> +
> +static void create_fdt_reset(RVSPMachineState *s, const MemMapEntry *mem=
map,
> +                             uint32_t *phandle)
> +{
> +    char *name;
> +    uint32_t test_phandle;
> +    MachineState *ms =3D MACHINE(s);
> +
> +    test_phandle =3D (*phandle)++;
> +    name =3D g_strdup_printf("/soc/reset_syscon@%lx",
> +        (long)memmap[RVSP_RESET_SYSCON].base);
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon");
> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
> +        0x0, memmap[RVSP_RESET_SYSCON].base,
> +        0x0, memmap[RVSP_RESET_SYSCON].size);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "phandle", test_phandle);
> +    test_phandle =3D qemu_fdt_get_phandle(ms->fdt, name);
> +    g_free(name);
> +
> +    name =3D g_strdup_printf("/soc/reboot");
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon-reboot"=
);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "regmap", test_phandle);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "offset", 0x0);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "value", SYSCON_RESET);
> +    g_free(name);
> +
> +    name =3D g_strdup_printf("/soc/poweroff");
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon-powerof=
f");
> +    qemu_fdt_setprop_cell(ms->fdt, name, "regmap", test_phandle);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "offset", 0x0);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "value", SYSCON_POWEROFF);
> +    g_free(name);
> +}
> +
> +static void create_fdt_uart(RVSPMachineState *s, const MemMapEntry *memm=
ap,
> +                            uint32_t irq_mmio_phandle)
> +{
> +    g_autofree char *name =3D NULL;
> +    MachineState *ms =3D MACHINE(s);
> +
> +    name =3D g_strdup_printf("/soc/serial@%lx", (long)memmap[RVSP_UART0]=
.base);
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "ns16550a");
> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
> +        0x0, memmap[RVSP_UART0].base,
> +        0x0, memmap[RVSP_UART0].size);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "clock-frequency", 3686400);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent", irq_mmio_ph=
andle);
> +    qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", RVSP_UART0_IRQ, =
0x4);
> +
> +    qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
> +}
> +
> +static void create_fdt_rtc(RVSPMachineState *s, const MemMapEntry *memma=
p,
> +                           uint32_t irq_mmio_phandle)
> +{
> +    g_autofree char *name =3D NULL;
> +    MachineState *ms =3D MACHINE(s);
> +
> +    name =3D g_strdup_printf("/soc/rtc@%lx", (long)memmap[RVSP_RTC].base=
);
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible",
> +        "google,goldfish-rtc");
> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
> +        0x0, memmap[RVSP_RTC].base, 0x0, memmap[RVSP_RTC].size);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
> +        irq_mmio_phandle);
> +    qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", RVSP_RTC_IRQ, 0x=
4);
> +}
> +
> +static void create_fdt_flash(RVSPMachineState *s, const MemMapEntry *mem=
map)
> +{
> +    MachineState *ms =3D MACHINE(s);
> +    hwaddr flashsize =3D rvsp_ref_memmap[RVSP_FLASH].size / 2;
> +    hwaddr flashbase =3D rvsp_ref_memmap[RVSP_FLASH].base;
> +    g_autofree char *name =3D g_strdup_printf("/flash@%" PRIx64, flashba=
se);
> +
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "cfi-flash");
> +    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
> +                                 2, flashbase, 2, flashsize,
> +                                 2, flashbase + flashsize, 2, flashsize)=
;
> +    qemu_fdt_setprop_cell(ms->fdt, name, "bank-width", 4);
> +}
> +
> +static void finalize_fdt(RVSPMachineState *s)
> +{
> +    uint32_t phandle =3D 1, irq_mmio_phandle =3D 1, msi_pcie_phandle =3D=
 1;
> +    uint32_t irq_pcie_phandle =3D 1;
> +
> +    create_fdt_sockets(s, rvsp_ref_memmap, &phandle, &irq_mmio_phandle,
> +                       &irq_pcie_phandle, &msi_pcie_phandle);
> +
> +    create_fdt_pcie(s, rvsp_ref_memmap, irq_pcie_phandle, msi_pcie_phand=
le);
> +
> +    create_fdt_reset(s, rvsp_ref_memmap, &phandle);
> +
> +    create_fdt_uart(s, rvsp_ref_memmap, irq_mmio_phandle);
> +
> +    create_fdt_rtc(s, rvsp_ref_memmap, irq_mmio_phandle);


We need a minimalistic DT for firmwares which probably don't use rtc, pcie =
etc.
Does EDK2 plan to generate ACPI tables from these DT ? Otherwise, we
can get rid of these.

As Heinrich said, Linux kernels should boot using ACPI only.

> +}
> +
> +static void create_fdt(RVSPMachineState *s, const MemMapEntry *memmap)
> +{
> +    MachineState *ms =3D MACHINE(s);
> +    uint8_t rng_seed[32];
> +
> +    ms->fdt =3D create_device_tree(&s->fdt_size);
> +    if (!ms->fdt) {
> +        error_report("create_device_tree() failed");
> +        exit(1);
> +    }
> +
> +    qemu_fdt_setprop_string(ms->fdt, "/", "model", "riscv-rvsp-ref,qemu"=
);
> +    qemu_fdt_setprop_string(ms->fdt, "/", "compatible", "riscv-rvsp-ref"=
);
> +    qemu_fdt_setprop_cell(ms->fdt, "/", "#size-cells", 0x2);
> +    qemu_fdt_setprop_cell(ms->fdt, "/", "#address-cells", 0x2);
> +
> +    /*
> +     * This versioning scheme is for informing platform fw only. It is n=
either:
> +     * - A QEMU versioned machine type; a given version of QEMU will emu=
late
> +     *   a given version of the platform.
> +     * - A reflection of level of server platform support provided.
> +     *
> +     * machine-version-major: updated when changes breaking fw compatibi=
lity
> +     *                        are introduced.
> +     * machine-version-minor: updated when features are added that don't=
 break
> +     *                        fw compatibility.
> +     *
> +     * It's the same as the scheme in arm sbsa-ref.
> +     */
> +    qemu_fdt_setprop_cell(ms->fdt, "/", "machine-version-major", 0);
> +    qemu_fdt_setprop_cell(ms->fdt, "/", "machine-version-minor", 0);
> +
> +    qemu_fdt_add_subnode(ms->fdt, "/soc");
> +    qemu_fdt_setprop(ms->fdt, "/soc", "ranges", NULL, 0);
> +    qemu_fdt_setprop_string(ms->fdt, "/soc", "compatible", "simple-bus")=
;
> +    qemu_fdt_setprop_cell(ms->fdt, "/soc", "#size-cells", 0x2);
> +    qemu_fdt_setprop_cell(ms->fdt, "/soc", "#address-cells", 0x2);
> +
> +    qemu_fdt_add_subnode(ms->fdt, "/chosen");
> +
> +    /* Pass seed to RNG */
> +    qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
> +    qemu_fdt_setprop(ms->fdt, "/chosen", "rng-seed",
> +                     rng_seed, sizeof(rng_seed));
> +
> +    create_fdt_flash(s, memmap);
> +    create_fdt_pmu(s);
> +
> +}
> +
> +static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
> +                                          DeviceState *irqchip,
> +                                          RVSPMachineState *s)
> +{
> +    DeviceState *dev;
> +    PCIHostState *pci;
> +    PCIDevice *pdev_ahci;
> +    AHCIPCIState *ich9;
> +    DriveInfo *hd[NUM_SATA_PORTS];
> +    MemoryRegion *ecam_alias, *ecam_reg;
> +    MemoryRegion *mmio_alias, *high_mmio_alias, *mmio_reg;
> +    hwaddr ecam_base =3D rvsp_ref_memmap[RVSP_PCIE_ECAM].base;
> +    hwaddr ecam_size =3D rvsp_ref_memmap[RVSP_PCIE_ECAM].size;
> +    hwaddr mmio_base =3D rvsp_ref_memmap[RVSP_PCIE_MMIO].base;
> +    hwaddr mmio_size =3D rvsp_ref_memmap[RVSP_PCIE_MMIO].size;
> +    hwaddr high_mmio_base =3D rvsp_ref_memmap[RVSP_PCIE_MMIO_HIGH].base;
> +    hwaddr high_mmio_size =3D rvsp_ref_memmap[RVSP_PCIE_MMIO_HIGH].size;
> +    hwaddr pio_base =3D rvsp_ref_memmap[RVSP_PCIE_PIO].base;
> +    hwaddr pio_size =3D rvsp_ref_memmap[RVSP_PCIE_PIO].size;
> +    MachineClass *mc =3D MACHINE_GET_CLASS(s);
> +    qemu_irq irq;
> +    int i;
> +
> +    dev =3D qdev_new(TYPE_GPEX_HOST);
> +
> +    /* Set GPEX object properties for the rvsp ref machine */
> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)), PCI_HOST_ECAM_BASE,
> +                            ecam_base, NULL);
> +    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_ECAM_SIZE,
> +                            ecam_size, NULL);
> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)),
> +                             PCI_HOST_BELOW_4G_MMIO_BASE,
> +                             mmio_base, NULL);
> +    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_BELOW_4G_MM=
IO_SIZE,
> +                            mmio_size, NULL);
> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)),
> +                             PCI_HOST_ABOVE_4G_MMIO_BASE,
> +                             high_mmio_base, NULL);
> +    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_ABOVE_4G_MM=
IO_SIZE,
> +                            high_mmio_size, NULL);
> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)), PCI_HOST_PIO_BASE,
> +                            pio_base, NULL);
> +    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_PIO_SIZE,
> +                            pio_size, NULL);
> +
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    ecam_alias =3D g_new0(MemoryRegion, 1);
> +    ecam_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
> +                             ecam_reg, 0, ecam_size);
> +    memory_region_add_subregion(get_system_memory(), ecam_base, ecam_ali=
as);
> +
> +    mmio_alias =3D g_new0(MemoryRegion, 1);
> +    mmio_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> +    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
> +                             mmio_reg, mmio_base, mmio_size);
> +    memory_region_add_subregion(get_system_memory(), mmio_base, mmio_ali=
as);
> +
> +    /* Map high MMIO space */
> +    high_mmio_alias =3D g_new0(MemoryRegion, 1);
> +    memory_region_init_alias(high_mmio_alias, OBJECT(dev), "pcie-mmio-hi=
gh",
> +                             mmio_reg, high_mmio_base, high_mmio_size);
> +    memory_region_add_subregion(get_system_memory(), high_mmio_base,
> +                                high_mmio_alias);
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, pio_base);
> +
> +    for (i =3D 0; i < GPEX_NUM_IRQS; i++) {
> +        irq =3D qdev_get_gpio_in(irqchip, RVSP_PCIE_IRQ + i);
> +
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
> +        gpex_set_irq_num(GPEX_HOST(dev), i, RVSP_PCIE_IRQ + i);
> +    }
> +
> +    pci =3D PCI_HOST_BRIDGE(dev);
> +    pci_init_nic_devices(pci->bus, mc->default_nic);
> +    /* IDE disk setup.  */
> +    pdev_ahci =3D pci_create_simple(pci->bus, -1, TYPE_ICH9_AHCI);
> +    ich9 =3D ICH9_AHCI(pdev_ahci);
> +    g_assert(ARRAY_SIZE(hd) =3D=3D ich9->ahci.ports);
> +    ide_drive_get(hd, ich9->ahci.ports);
> +    ahci_ide_create_devs(&ich9->ahci, hd);
> +
> +    GPEX_HOST(dev)->gpex_cfg.bus =3D PCI_HOST_BRIDGE(GPEX_HOST(dev))->bu=
s;
> +    return dev;
> +}
> +
> +static DeviceState *rvsp_ref_create_aia(int aia_guests,
> +                                        const MemMapEntry *memmap, int s=
ocket,
> +                                        int base_hartid, int hart_count)
> +{
> +    int i;
> +    hwaddr addr;
> +    uint32_t guest_bits;
> +    DeviceState *aplic_s =3D NULL;
> +    DeviceState *aplic_m =3D NULL;
> +    bool msimode =3D true;
> +
> +    /* Per-socket M-level IMSICs */
> +    addr =3D memmap[RVSP_IMSIC_M].base +
> +           socket * RVSP_IMSIC_GROUP_MAX_SIZE;
> +    for (i =3D 0; i < hart_count; i++) {
> +        riscv_imsic_create(addr + i * IMSIC_HART_SIZE(0),
> +                           base_hartid + i, true, 1,
> +                           RVSP_IRQCHIP_NUM_MSIS);
> +    }
> +
> +    /* Per-socket S-level IMSICs */
> +    guest_bits =3D imsic_num_bits(aia_guests + 1);
> +    addr =3D memmap[RVSP_IMSIC_S].base + socket * RVSP_IMSIC_GROUP_MAX_S=
IZE;
> +    for (i =3D 0; i < hart_count; i++) {
> +        riscv_imsic_create(addr + i * IMSIC_HART_SIZE(guest_bits),
> +                           base_hartid + i, false, 1 + aia_guests,
> +                           RVSP_IRQCHIP_NUM_MSIS);
> +    }
> +
> +    /* Per-socket M-level APLIC */
> +    aplic_m =3D riscv_aplic_create(memmap[RVSP_APLIC_M].base +
> +                                 socket * memmap[RVSP_APLIC_M].size,
> +                                 memmap[RVSP_APLIC_M].size,
> +                                 (msimode) ? 0 : base_hartid,
> +                                 (msimode) ? 0 : hart_count,
> +                                 RVSP_IRQCHIP_NUM_SOURCES,
> +                                 RVSP_IRQCHIP_NUM_PRIO_BITS,
> +                                 msimode, true, NULL);
> +
> +    /* Per-socket S-level APLIC */
> +    aplic_s =3D riscv_aplic_create(memmap[RVSP_APLIC_S].base +
> +                                 socket * memmap[RVSP_APLIC_S].size,
> +                                 memmap[RVSP_APLIC_S].size,
> +                                 (msimode) ? 0 : base_hartid,
> +                                 (msimode) ? 0 : hart_count,
> +                                 RVSP_IRQCHIP_NUM_SOURCES,
> +                                 RVSP_IRQCHIP_NUM_PRIO_BITS,
> +                                 msimode, false, aplic_m);
> +
> +    (void)aplic_s;
> +    return aplic_m;
> +}
> +
> +static uint64_t rvsp_reset_syscon_read(void *opaque, hwaddr addr, unsign=
ed size)
> +{
> +    return 0;
> +}
> +
> +static void rvsp_reset_syscon_write(void *opaque, hwaddr addr,
> +                                    uint64_t val64, unsigned int size)
> +{
> +    switch (val64) {
> +    case SYSCON_POWEROFF:
> +        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> +        return;
> +    case SYSCON_RESET:
> +        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +        return;
> +    default:
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps rvsp_reset_syscon_ops =3D {
> +    .read =3D rvsp_reset_syscon_read,
> +    .write =3D rvsp_reset_syscon_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN
> +};
> +
> +static void rvsp_ref_machine_done(Notifier *notifier, void *data)
> +{
> +    RVSPMachineState *s =3D container_of(notifier, RVSPMachineState,
> +                                       machine_done);
> +    const MemMapEntry *memmap =3D rvsp_ref_memmap;
> +    MachineState *machine =3D MACHINE(s);
> +    target_ulong start_addr =3D memmap[RVSP_DRAM].base;
> +    target_ulong firmware_end_addr, kernel_start_addr;
> +    const char *firmware_name =3D riscv_default_firmware_name(&s->soc[0]=
);
> +    uint64_t fdt_load_addr;
> +    uint64_t kernel_entry =3D 0;
> +    BlockBackend *pflash_blk0;
> +
> +    /*
> +     * An user provided dtb must include everything, including
> +     * dynamic sysbus devices. Our FDT needs to be finalized.
> +     */
> +    if (machine->dtb =3D=3D NULL) {
> +        finalize_fdt(s);
> +    }
> +
> +    firmware_end_addr =3D riscv_find_and_load_firmware(machine, firmware=
_name,
> +                                                     start_addr, NULL);
> +
> +    pflash_blk0 =3D pflash_cfi01_get_blk(s->flash[0]);
> +    if (pflash_blk0) {
> +        if (machine->firmware && !strcmp(machine->firmware, "none")) {
> +            /*
> +             * Pflash was supplied but bios is none and not KVM guest,
> +             * let's overwrite the address we jump to after reset to
> +             * the base of the flash.
> +             */
> +            start_addr =3D rvsp_ref_memmap[RVSP_FLASH].base;
> +        } else {
> +            /*
> +             * Pflash was supplied but either KVM guest or bios is not n=
one.
> +             * In this case, base of the flash would contain S-mode payl=
oad.
> +             */
> +            riscv_setup_firmware_boot(machine);
> +            kernel_entry =3D rvsp_ref_memmap[RVSP_FLASH].base;
> +        }
> +    }
> +
> +    if (machine->kernel_filename && !kernel_entry) {
> +        kernel_start_addr =3D riscv_calc_kernel_start_addr(&s->soc[0],
> +                                                         firmware_end_ad=
dr);
> +
> +        kernel_entry =3D riscv_load_kernel(machine, &s->soc[0],
> +                                         kernel_start_addr, true, NULL);
> +    }
> +
> +    fdt_load_addr =3D riscv_compute_fdt_addr(memmap[RVSP_DRAM].base,
> +                                           memmap[RVSP_DRAM].size,
> +                                           machine);
> +    riscv_load_fdt(fdt_load_addr, machine->fdt);
> +
> +    /* load the reset vector */
> +    riscv_setup_rom_reset_vec(machine, &s->soc[0], start_addr,
> +                              rvsp_ref_memmap[RVSP_MROM].base,
> +                              rvsp_ref_memmap[RVSP_MROM].size, kernel_en=
try,
> +                              fdt_load_addr);
> +
> +}
> +
> +static void rvsp_ref_machine_init(MachineState *machine)
> +{
> +    const MemMapEntry *memmap =3D rvsp_ref_memmap;
> +    RVSPMachineState *s =3D RVSP_REF_MACHINE(machine);
> +    MemoryRegion *system_memory =3D get_system_memory();
> +    MemoryRegion *mask_rom =3D g_new(MemoryRegion, 1);
> +    MemoryRegion *reset_syscon_io =3D g_new(MemoryRegion, 1);
> +    DeviceState *mmio_irqchip, *pcie_irqchip;
> +    int i, base_hartid, hart_count;
> +    int socket_count =3D riscv_socket_count(machine);
> +
> +    /* Check socket count limit */
> +    if (RVSP_SOCKETS_MAX < socket_count) {
> +        error_report("number of sockets/nodes should be less than %d",
> +            RVSP_SOCKETS_MAX);
> +        exit(1);
> +    }
> +
> +    if (!tcg_enabled()) {
> +        error_report("'aclint' is only available with TCG acceleration")=
;
> +        exit(1);
> +    }
> +
> +    /* Initialize sockets */
> +    mmio_irqchip =3D pcie_irqchip =3D NULL;
> +    for (i =3D 0; i < socket_count; i++) {
> +        g_autofree char *soc_name =3D g_strdup_printf("soc%d", i);
> +
> +        if (!riscv_socket_check_hartids(machine, i)) {
> +            error_report("discontinuous hartids in socket%d", i);
> +            exit(1);
> +        }
> +
> +        base_hartid =3D riscv_socket_first_hartid(machine, i);
> +        if (base_hartid < 0) {
> +            error_report("can't find hartid base for socket%d", i);
> +            exit(1);
> +        }
> +
> +        hart_count =3D riscv_socket_hart_count(machine, i);
> +        if (hart_count < 0) {
> +            error_report("can't find hart count for socket%d", i);
> +            exit(1);
> +        }
> +
> +        object_initialize_child(OBJECT(machine), soc_name, &s->soc[i],
> +                                TYPE_RISCV_HART_ARRAY);
> +        object_property_set_str(OBJECT(&s->soc[i]), "cpu-type",
> +                                machine->cpu_type, &error_abort);
> +        object_property_set_int(OBJECT(&s->soc[i]), "hartid-base",
> +                                base_hartid, &error_abort);
> +        object_property_set_int(OBJECT(&s->soc[i]), "num-harts",
> +                                hart_count, &error_abort);
> +        sysbus_realize(SYS_BUS_DEVICE(&s->soc[i]), &error_fatal);
> +
> +        /* Per-socket ACLINT MTIMER */
> +        riscv_aclint_mtimer_create(memmap[RVSP_ACLINT].base +
> +                i * RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
> +            RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
> +            base_hartid, hart_count,
> +            RISCV_ACLINT_DEFAULT_MTIMECMP,
> +            RISCV_ACLINT_DEFAULT_MTIME,
> +            RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
> +
> +        /* Per-socket interrupt controller */
> +        s->irqchip[i] =3D rvsp_ref_create_aia(s->aia_guests,
> +                                            memmap, i, base_hartid,
> +                                            hart_count);
> +
> +        /* Try to use different IRQCHIP instance based device type */
> +        if (i =3D=3D 0) {
> +            mmio_irqchip =3D s->irqchip[i];
> +            pcie_irqchip =3D s->irqchip[i];
> +        }
> +        if (i =3D=3D 1) {
> +            pcie_irqchip =3D s->irqchip[i];
> +        }
> +    }
> +
> +    s->memmap =3D rvsp_ref_memmap;
> +
> +    /* register system main memory (actual RAM) */
> +    memory_region_add_subregion(system_memory, memmap[RVSP_DRAM].base,
> +        machine->ram);
> +
> +    /* boot rom */
> +    memory_region_init_rom(mask_rom, NULL, "riscv_rvsp_ref_board.mrom",
> +                           memmap[RVSP_MROM].size, &error_fatal);
> +    memory_region_add_subregion(system_memory, memmap[RVSP_MROM].base,
> +                                mask_rom);
> +
> +    memory_region_init_io(reset_syscon_io, NULL, &rvsp_reset_syscon_ops,
> +                          NULL, "reset_syscon_io",
> +                          memmap[RVSP_RESET_SYSCON].size);
> +    memory_region_add_subregion(system_memory,
> +                                memmap[RVSP_RESET_SYSCON].base,
> +                                reset_syscon_io);
> +
> +    gpex_pcie_init(system_memory, pcie_irqchip, s);
> +
> +    serial_mm_init(system_memory, memmap[RVSP_UART0].base,
> +        0, qdev_get_gpio_in(mmio_irqchip, RVSP_UART0_IRQ), 399193,
> +        serial_hd(0), DEVICE_LITTLE_ENDIAN);
> +
> +    sysbus_create_simple("goldfish_rtc", memmap[RVSP_RTC].base,
> +        qdev_get_gpio_in(mmio_irqchip, RVSP_RTC_IRQ));
> +
> +    for (i =3D 0; i < ARRAY_SIZE(s->flash); i++) {
> +        /* Map legacy -drive if=3Dpflash to machine properties */
> +        pflash_cfi01_legacy_drive(s->flash[i],
> +                                  drive_get(IF_PFLASH, 0, i));
> +    }
> +    rvsp_flash_maps(s, system_memory);
> +
> +    /* load/create device tree */
> +    if (machine->dtb) {
> +        machine->fdt =3D load_device_tree(machine->dtb, &s->fdt_size);
> +        if (!machine->fdt) {
> +            error_report("load_device_tree() failed");
> +            exit(1);
> +        }
> +    } else {
> +        create_fdt(s, memmap);
> +    }
> +
> +    s->machine_done.notify =3D rvsp_ref_machine_done;
> +    qemu_add_machine_init_done_notifier(&s->machine_done);
> +}
> +
> +static void rvsp_ref_machine_instance_init(Object *obj)
> +{
> +    RVSPMachineState *s =3D RVSP_REF_MACHINE(obj);
> +
> +    s->flash[0] =3D rvsp_flash_create(s, "rvsp.flash0", "pflash0");
> +    s->flash[1] =3D rvsp_flash_create(s, "rvsp.flash1", "pflash1");
> +}
> +
> +static char *rvsp_ref_get_aia_guests(Object *obj, Error **errp)
> +{
> +    RVSPMachineState *s =3D RVSP_REF_MACHINE(obj);
> +    char val[32];
> +
> +    sprintf(val, "%d", s->aia_guests);
> +    return g_strdup(val);
> +}
> +
> +static void rvsp_ref_set_aia_guests(Object *obj, const char *val, Error =
**errp)
> +{
> +    RVSPMachineState *s =3D RVSP_REF_MACHINE(obj);
> +
> +    s->aia_guests =3D atoi(val);
> +    if (s->aia_guests < 0 || s->aia_guests > RVSP_IRQCHIP_MAX_GUESTS) {
> +        error_setg(errp, "Invalid number of AIA IMSIC guests");
> +        error_append_hint(errp, "Valid values be between 0 and %d.\n",
> +                          RVSP_IRQCHIP_MAX_GUESTS);
> +    }
> +}
> +
> +static void rvsp_ref_machine_class_init(ObjectClass *oc, void *data)
> +{
> +    char str[128];
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +    static const char * const valid_cpu_types[] =3D {
> +               TYPE_RISCV_CPU_RVSP_REF,
> +       };
> +
> +    mc->desc =3D "RISC-V Server SoC Reference board";
> +    mc->init =3D rvsp_ref_machine_init;
> +    mc->max_cpus =3D RVSP_CPUS_MAX;
> +    mc->default_cpu_type =3D TYPE_RISCV_CPU_RVSP_REF;
> +       mc->valid_cpu_types =3D valid_cpu_types;
> +    mc->pci_allow_0_address =3D true;
> +    mc->default_nic =3D "e1000e";
> +    mc->possible_cpu_arch_ids =3D riscv_numa_possible_cpu_arch_ids;
> +    mc->cpu_index_to_instance_props =3D riscv_numa_cpu_index_to_props;
> +    mc->get_default_cpu_node_id =3D riscv_numa_get_default_cpu_node_id;
> +    mc->numa_mem_supported =3D true;
> +    /* platform instead of architectural choice */
> +    mc->cpu_cluster_has_numa_boundary =3D true;
> +    mc->default_ram_id =3D "riscv_rvsp_ref_board.ram";
> +
> +    object_class_property_add_str(oc, "aia-guests",
> +                                  rvsp_ref_get_aia_guests,
> +                                  rvsp_ref_set_aia_guests);
> +    sprintf(str, "Set number of guest MMIO pages for AIA IMSIC. Valid va=
lue "
> +                 "should be between 0 and %d.", RVSP_IRQCHIP_MAX_GUESTS)=
;
> +    object_class_property_set_description(oc, "aia-guests", str);
> +}
> +
> +static const TypeInfo rvsp_ref_typeinfo =3D {
> +    .name       =3D TYPE_RVSP_REF_MACHINE,
> +    .parent     =3D TYPE_MACHINE,
> +    .class_init =3D rvsp_ref_machine_class_init,
> +    .instance_init =3D rvsp_ref_machine_instance_init,
> +    .instance_size =3D sizeof(RVSPMachineState),
> +};
> +
> +static void rvsp_ref_init_register_types(void)
> +{
> +    type_register_static(&rvsp_ref_typeinfo);
> +}
> +
> +type_init(rvsp_ref_init_register_types)
> --
> 2.34.1
>

