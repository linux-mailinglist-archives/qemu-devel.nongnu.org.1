Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3632959CAC
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Aug 2024 15:02:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgkyG-0008GA-IV; Wed, 21 Aug 2024 09:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <git@dprinz.de>) id 1sgkxf-0006tC-Nh
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 09:01:21 -0400
Received: from mail.dprinz.de ([178.254.36.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <git@dprinz.de>) id 1sgkxY-0005ex-Lv
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 09:01:12 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A484A111AB; Wed, 21 Aug 2024 15:00:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dprinz.de; s=dkim;
 t=1724245253; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=gBRRq7r+/R2YJTqHyWPF+VgN7CM/drcyF7xePxt7xM0=;
 b=uztu1ZVXZOYw2nGmwhfgc0dMvCllh2ogC1Ca5kCsLRJ2VHsSGi5xYL7Ss6U4gVpjtHX4wa
 HTIullnP2ZLIiIkEfLeQhAG+L5Y5D8OpovVOmd/ONEdCdJa5uo9qKINJeJkUu2EVkpmTbv
 iIphQz7dE+VIhGuXK49VaktkfOr02ouRb0/nHg1c0HdXOfIzdDXTN0JSu6j3zWEhKhrd0v
 k40ttlB1oje51US4a+6i41XrjwDzrY5yOyq5s93zQOvAMkjMLEuNBR43w8kMqwxIE1rGEU
 dLpVD7VN5HFMJAgRr86AhsdfhAboXzV6j2yQWRbySFBBr9k74yZBSSIgk354Eg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Aug 2024 15:00:36 +0200
Message-Id: <D3LLXABB7UZ1.1RHBKW1GU9I3D@dp-laptop>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Marcel Apfelbaum"
 <marcel.apfelbaum@gmail.com>, "Igor Mammedov" <imammedo@redhat.com>,
 "Dominic Prinz" <git@dprinz.de>
Subject: Re: [PATCH v2] hw/acpi/ich9: Add periodic and swsmi timer
From: "Dominic Prinz" <git@dprinz.de>
To: <qemu-devel@nongnu.org>
X-Mailer: aerc 0.8.2
References: <20240730145240-mutt-send-email-mst@kernel.org>
 <1e4d59a49e7f2e02cf522e799a7bf5f3fa3fba1f.1722414006.git.git@dprinz.de>
In-Reply-To: <1e4d59a49e7f2e02cf522e799a7bf5f3fa3fba1f.1722414006.git.git@dprinz.de>
X-Last-TLS-Session-Version: TLSv1.3
Received-SPF: pass client-ip=178.254.36.89; envelope-from=git@dprinz.de;
 helo=mail.dprinz.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Ping

https://patchew.org/QEMU/1e4d59a49e7f2e02cf522e799a7bf5f3fa3fba1f.172241400=
6.git.git@dprinz.de/
https://lore.kernel.org/qemu-devel/1e4d59a49e7f2e02cf522e799a7bf5f3fa3fba1f=
.1722414006.git.git@dprinz.de/

On Wed Jul 31, 2024 at 10:28 AM CEST, Dominic Prinz wrote:
> This patch implements the periodic and the swsmi ICH9 chipset timer. They=
 are
> especially useful when prototyping UEFI firmware (e.g. with EDK2's OVMF)
> using QEMU.
>
> For backwards compatibility, the compat properties "x-smi-swsmi-timer",
> and "x-smi-periodic-timer" are introduced.
>
> Additionally, writes to the SMI_STS register are enabled for the
> corresponding two bits.
>
> Signed-off-by: Dominic Prinz <git@dprinz.de>
> ---
> Changes since previous version:
>   - Ensured backwards compatablity by introducing two compat properties
>   - Introduced write mask for SMI_STS register to make future work easier
>
>  hw/acpi/ich9.c                | 23 +++++++++
>  hw/acpi/ich9_timer.c          | 93 +++++++++++++++++++++++++++++++++++
>  hw/acpi/meson.build           |  2 +-
>  hw/i386/pc.c                  |  2 +
>  hw/isa/lpc_ich9.c             | 14 ++++++
>  include/hw/acpi/ich9.h        |  6 +++
>  include/hw/acpi/ich9_timer.h  | 23 +++++++++
>  include/hw/southbridge/ich9.h |  4 ++
>  8 files changed, 166 insertions(+), 1 deletion(-)
>  create mode 100644 hw/acpi/ich9_timer.c
>  create mode 100644 include/hw/acpi/ich9_timer.h
>
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index 02d8546bd3..c15e5b8281 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -35,6 +35,7 @@
>  #include "sysemu/runstate.h"
>  #include "hw/acpi/acpi.h"
>  #include "hw/acpi/ich9_tco.h"
> +#include "hw/acpi/ich9_timer.h"
> =20
>  #include "hw/southbridge/ich9.h"
>  #include "hw/mem/pc-dimm.h"
> @@ -108,6 +109,18 @@ static void ich9_smi_writel(void *opaque, hwaddr add=
r, uint64_t val,
>          }
>          pm->smi_en &=3D ~pm->smi_en_wmask;
>          pm->smi_en |=3D (val & pm->smi_en_wmask);
> +        if (pm->swsmi_timer_enabled) {
> +            ich9_pm_update_swsmi_timer(pm, pm->smi_en &
> +                                               ICH9_PMIO_SMI_EN_SWSMI_EN=
);
> +        }
> +        if (pm->periodic_timer_enabled) {
> +            ich9_pm_update_periodic_timer(pm, pm->smi_en &
> +                                                  ICH9_PMIO_SMI_EN_PERIO=
DIC_EN);
> +        }
> +        break;
> +    case 4:
> +        pm->smi_sts &=3D ~pm->smi_sts_wmask;
> +        pm->smi_sts |=3D (val & pm->smi_sts_wmask);
>          break;
>      }
>  }
> @@ -286,6 +299,8 @@ static void pm_powerdown_req(Notifier *n, void *opaqu=
e)
> =20
>  void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_ir=
q)
>  {
> +    pm->smi_sts_wmask =3D 0;
> +
>      memory_region_init(&pm->io, OBJECT(lpc_pci), "ich9-pm", ICH9_PMIO_SI=
ZE);
>      memory_region_set_enabled(&pm->io, false);
>      memory_region_add_subregion(pci_address_space_io(lpc_pci),
> @@ -305,6 +320,14 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs =
*pm, qemu_irq sci_irq)
>                            "acpi-smi", 8);
>      memory_region_add_subregion(&pm->io, ICH9_PMIO_SMI_EN, &pm->io_smi);
> =20
> +    if (pm->swsmi_timer_enabled) {
> +        ich9_pm_swsmi_timer_init(pm);
> +    }
> +
> +    if (pm->periodic_timer_enabled) {
> +        ich9_pm_periodic_timer_init(pm);
> +    }
> +
>      if (pm->enable_tco) {
>          acpi_pm_tco_init(&pm->tco_regs, &pm->io);
>      }
> diff --git a/hw/acpi/ich9_timer.c b/hw/acpi/ich9_timer.c
> new file mode 100644
> index 0000000000..5b1c910156
> --- /dev/null
> +++ b/hw/acpi/ich9_timer.c
> @@ -0,0 +1,93 @@
> +/*
> + * QEMU ICH9 Timer emulation
> + *
> + * Copyright (c) 2024 Dominic Prinz <git@dprinz.de>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/core/cpu.h"
> +#include "hw/pci/pci.h"
> +#include "hw/southbridge/ich9.h"
> +#include "qemu/timer.h"
> +
> +#include "hw/acpi/ich9_timer.h"
> +
> +void ich9_pm_update_swsmi_timer(ICH9LPCPMRegs *pm, bool enable)
> +{
> +    uint16_t swsmi_rate_sel;
> +    int64_t expire_time;
> +    ICH9LPCState *lpc;
> +
> +    if (enable) {
> +        lpc =3D container_of(pm, ICH9LPCState, pm);
> +        swsmi_rate_sel =3D
> +            (pci_get_word(lpc->d.config + ICH9_LPC_GEN_PMCON_3) & 0xc0) =
>> 6;
> +
> +        if (swsmi_rate_sel =3D=3D 0) {
> +            expire_time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 1500=
000LL;
> +        } else {
> +            expire_time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +                          8 * (1 << swsmi_rate_sel) * 1000000LL;
> +        }
> +
> +        timer_mod(pm->swsmi_timer, expire_time);
> +    } else {
> +        timer_del(pm->swsmi_timer);
> +    }
> +}
> +
> +static void ich9_pm_swsmi_timer_expired(void *opaque)
> +{
> +    ICH9LPCPMRegs *pm =3D opaque;
> +
> +    pm->smi_sts |=3D ICH9_PMIO_SMI_STS_SWSMI_STS;
> +    ich9_generate_smi();
> +
> +    ich9_pm_update_swsmi_timer(pm, pm->smi_en & ICH9_PMIO_SMI_EN_SWSMI_E=
N);
> +}
> +
> +void ich9_pm_swsmi_timer_init(ICH9LPCPMRegs *pm)
> +{
> +    pm->smi_sts_wmask |=3D ICH9_PMIO_SMI_STS_SWSMI_STS;
> +    pm->swsmi_timer =3D
> +        timer_new_ns(QEMU_CLOCK_VIRTUAL, ich9_pm_swsmi_timer_expired, pm=
);
> +}
> +
> +void ich9_pm_update_periodic_timer(ICH9LPCPMRegs *pm, bool enable)
> +{
> +    uint16_t per_smi_sel;
> +    int64_t expire_time;
> +    ICH9LPCState *lpc;
> +
> +    if (enable) {
> +        lpc =3D container_of(pm, ICH9LPCState, pm);
> +        per_smi_sel =3D pci_get_word(lpc->d.config + ICH9_LPC_GEN_PMCON_=
1) & 3;
> +        expire_time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +                      8 * (1 << (3 - per_smi_sel)) * NANOSECONDS_PER_SEC=
OND;
> +
> +        timer_mod(pm->periodic_timer, expire_time);
> +    } else {
> +        timer_del(pm->periodic_timer);
> +    }
> +}
> +
> +static void ich9_pm_periodic_timer_expired(void *opaque)
> +{
> +    ICH9LPCPMRegs *pm =3D opaque;
> +
> +    pm->smi_sts =3D ICH9_PMIO_SMI_STS_PERIODIC_STS;
> +    ich9_generate_smi();
> +
> +    ich9_pm_update_periodic_timer(pm,
> +                                  pm->smi_en & ICH9_PMIO_SMI_EN_PERIODIC=
_EN);
> +}
> +
> +void ich9_pm_periodic_timer_init(ICH9LPCPMRegs *pm)
> +{
> +    pm->smi_sts_wmask |=3D ICH9_PMIO_SMI_STS_PERIODIC_STS;
> +    pm->periodic_timer =3D
> +        timer_new_ns(QEMU_CLOCK_VIRTUAL, ich9_pm_periodic_timer_expired,=
 pm);
> +}
> diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
> index fa5c07db90..7f8ccc9b7a 100644
> --- a/hw/acpi/meson.build
> +++ b/hw/acpi/meson.build
> @@ -24,7 +24,7 @@ acpi_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_true: fi=
les('pci-bridge.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_PCIHP', if_true: files('pcihp.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_PCIHP', if_false: files('acpi-pci-hotplug=
-stub.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_VIOT', if_true: files('viot.c'))
> -acpi_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('ich9.c', 'ich9_tco=
.c'))
> +acpi_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('ich9.c', 'ich9_tco=
.c', 'ich9_timer.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_ERST', if_true: files('erst.c'))
>  acpi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c'), if_false: fil=
es('ipmi-stub.c'))
>  acpi_ss.add(when: 'CONFIG_PC', if_false: files('acpi-x86-stub.c'))
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index c74931d577..a97b1b1f57 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -85,6 +85,8 @@ GlobalProperty pc_compat_9_0[] =3D {
>      { TYPE_X86_CPU, "guest-phys-bits", "0" },
>      { "sev-guest", "legacy-vm-type", "on" },
>      { TYPE_X86_CPU, "legacy-multi-node", "on" },
> +    { "ICH9-LPC", "x-smi-swsmi-timer", "off" },
> +    { "ICH9-LPC", "x-smi-periodic-timer", "off" },
>  };
>  const size_t pc_compat_9_0_len =3D G_N_ELEMENTS(pc_compat_9_0);
> =20
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index bd727b2320..ab17b76f54 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -43,6 +43,7 @@
>  #include "hw/southbridge/ich9.h"
>  #include "hw/acpi/acpi.h"
>  #include "hw/acpi/ich9.h"
> +#include "hw/acpi/ich9_timer.h"
>  #include "hw/pci/pci_bus.h"
>  #include "hw/qdev-properties.h"
>  #include "sysemu/runstate.h"
> @@ -531,6 +532,15 @@ ich9_lpc_pmcon_update(ICH9LPCState *lpc)
>      uint16_t gen_pmcon_1 =3D pci_get_word(lpc->d.config + ICH9_LPC_GEN_P=
MCON_1);
>      uint16_t wmask;
> =20
> +    if (lpc->pm.swsmi_timer_enabled) {
> +        ich9_pm_update_swsmi_timer(
> +            &lpc->pm, lpc->pm.smi_en & ICH9_PMIO_SMI_EN_SWSMI_EN);
> +    }
> +    if (lpc->pm.periodic_timer_enabled) {
> +        ich9_pm_update_periodic_timer(
> +            &lpc->pm, lpc->pm.smi_en & ICH9_PMIO_SMI_EN_PERIODIC_EN);
> +    }
> +
>      if (gen_pmcon_1 & ICH9_LPC_GEN_PMCON_1_SMI_LOCK) {
>          wmask =3D pci_get_word(lpc->d.wmask + ICH9_LPC_GEN_PMCON_1);
>          wmask &=3D ~ICH9_LPC_GEN_PMCON_1_SMI_LOCK;
> @@ -826,6 +836,10 @@ static Property ich9_lpc_properties[] =3D {
>                        ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT, true),
>      DEFINE_PROP_BIT64("x-smi-cpu-hotunplug", ICH9LPCState, smi_host_feat=
ures,
>                        ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT, true),
> +    DEFINE_PROP_BOOL("x-smi-swsmi-timer", ICH9LPCState,
> +                     pm.swsmi_timer_enabled, true),
> +    DEFINE_PROP_BOOL("x-smi-periodic-timer", ICH9LPCState,
> +                     pm.periodic_timer_enabled, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
> index 2faf7f0cae..245fe08dc2 100644
> --- a/include/hw/acpi/ich9.h
> +++ b/include/hw/acpi/ich9.h
> @@ -46,6 +46,7 @@ typedef struct ICH9LPCPMRegs {
>      uint32_t smi_en;
>      uint32_t smi_en_wmask;
>      uint32_t smi_sts;
> +    uint32_t smi_sts_wmask;
> =20
>      qemu_irq irq;      /* SCI */
> =20
> @@ -68,6 +69,11 @@ typedef struct ICH9LPCPMRegs {
>      bool smm_compat;
>      bool enable_tco;
>      TCOIORegs tco_regs;
> +
> +    bool swsmi_timer_enabled;
> +    bool periodic_timer_enabled;
> +    QEMUTimer *swsmi_timer;
> +    QEMUTimer *periodic_timer;
>  } ICH9LPCPMRegs;
> =20
>  #define ACPI_PM_PROP_TCO_ENABLED "enable_tco"
> diff --git a/include/hw/acpi/ich9_timer.h b/include/hw/acpi/ich9_timer.h
> new file mode 100644
> index 0000000000..5112df4385
> --- /dev/null
> +++ b/include/hw/acpi/ich9_timer.h
> @@ -0,0 +1,23 @@
> +/*
> + * QEMU ICH9 Timer emulation
> + *
> + * Copyright (c) 2024 Dominic Prinz <git@dprinz.de>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef HW_ACPI_ICH9_TIMER_H
> +#define HW_ACPI_ICH9_TIMER_H
> +
> +#include "hw/acpi/ich9.h"
> +
> +void ich9_pm_update_swsmi_timer(ICH9LPCPMRegs *pm, bool enable);
> +
> +void ich9_pm_swsmi_timer_init(ICH9LPCPMRegs *pm);
> +
> +void ich9_pm_update_periodic_timer(ICH9LPCPMRegs *pm, bool enable);
> +
> +void ich9_pm_periodic_timer_init(ICH9LPCPMRegs *pm);
> +
> +#endif
> diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.=
h
> index fd01649d04..6c60017024 100644
> --- a/include/hw/southbridge/ich9.h
> +++ b/include/hw/southbridge/ich9.h
> @@ -196,8 +196,12 @@ struct ICH9LPCState {
>  #define ICH9_PMIO_GPE0_LEN                      16
>  #define ICH9_PMIO_SMI_EN                        0x30
>  #define ICH9_PMIO_SMI_EN_APMC_EN                (1 << 5)
> +#define ICH9_PMIO_SMI_EN_SWSMI_EN               (1 << 6)
>  #define ICH9_PMIO_SMI_EN_TCO_EN                 (1 << 13)
> +#define ICH9_PMIO_SMI_EN_PERIODIC_EN            (1 << 14)
>  #define ICH9_PMIO_SMI_STS                       0x34
> +#define ICH9_PMIO_SMI_STS_SWSMI_STS             (1 << 6)
> +#define ICH9_PMIO_SMI_STS_PERIODIC_STS          (1 << 14)
>  #define ICH9_PMIO_TCO_RLD                       0x60
>  #define ICH9_PMIO_TCO_LEN                       32
> =20
> --=20
> 2.34.1


