Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E399471C5
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Aug 2024 01:25:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sakaT-0007r8-He; Sun, 04 Aug 2024 19:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sakaQ-0007p8-B6; Sun, 04 Aug 2024 19:24:26 -0400
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sakaL-00059D-UE; Sun, 04 Aug 2024 19:24:26 -0400
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-49299adf8adso3009743137.2; 
 Sun, 04 Aug 2024 16:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722813860; x=1723418660; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mB6n6PAH6i6HE7i3+hszmBqwfDqc3syxKl5LpWkwbIE=;
 b=YVXEC3FREhiFxoOBgkq2ok1FF3fQgKMI0uyjfTayYyx7AOxqTdnQ0TV0p9lbUePcDZ
 Rw+WtyCujrdEDVv7oxNTnuJFc310SHwcfBk9ty1KodNURgJmbXGzTUOeQSI4MbPKkv4k
 jM5P4nPAUUXWTAMF5gpZmzWKu1d2FwMwHLKrskYxqAce0TsU925yfYRu8ylCxMuAVqcF
 1W+AvUcE1IdSAFAMKoj5K7I8M/VP5VtY4TSWVa3xa25De7el7r0uZ2FfhzvaRLIV82xG
 ZBEK0CgwOQI+sYRhHZgcUK3kSPrwGLBGLPHm7dIIuF59OTZ47k1IjVOSZaZUCGyZrsRB
 H2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722813860; x=1723418660;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mB6n6PAH6i6HE7i3+hszmBqwfDqc3syxKl5LpWkwbIE=;
 b=VpQVZuybL4rhqoI4qbmVmo/2392WW0+JlLvde6JgIOA7tew4kjV+i8UPoDJjo4sBWA
 boNImhe5QHT106keeGV3T9N3VlvPWRgZHcky7LfOsC4GxmA3szvcXRCwepBpjROwt/6h
 r9+Iei1JMUiqW72mFiT6sJ60uOcfKnoyJ1ylH8fkjXp1hJZOMi5QfZ4YaqKsXs8BegV9
 i5VT4sWv86QlVF4WQq6/av0G5tyhsubAm0x4NYR7j31ogszadcXwgZrgLXK4FOl8j+yJ
 KuBkMeIiUwxEvYwND9lrASNwkn2nmWNyyFOXz0c78YEXgKvYo7b7rhuy1KOeRKJHNNb/
 GNMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2mB0ELQhZUc1IqeY+KErtHdUK4At1Icbqg7J9WPvNcHMWZtWYXHkg8IIlj+NgvcOsEPpwak0M6jj4H3uQxEcqVBMlyag=
X-Gm-Message-State: AOJu0YyJrAJ3Q5GHKQ3HjhcRTTdQXafW/CQAho/p+LN+tSMDIWyICHZ5
 0TsQO7mSonm5RWbhLOo7qiXyI6ff63TPW3Xkmf5pkD+UkAAORCJ05r9JBwE8wprf6O2wDeGTWgc
 ZvURvZpRwsWlnPwgykoEBxIUUYpuF8oIa
X-Google-Smtp-Source: AGHT+IHJaCAi7m1r8m5W7SP0Hk8OoqzU/ycno1d5DfP3ZsijoADr/hO5DjqrfA8TtLjCG+SwpcwaIcDBIUARWOIEX9w=
X-Received: by 2002:a05:6102:dd3:b0:48f:4218:4d06 with SMTP id
 ada2fe7eead31-4945bf04cf3mr12413657137.28.1722813859481; Sun, 04 Aug 2024
 16:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240801154334.1009852-1-dbarboza@ventanamicro.com>
 <20240801154334.1009852-4-dbarboza@ventanamicro.com>
In-Reply-To: <20240801154334.1009852-4-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Aug 2024 09:23:53 +1000
Message-ID: <CAKmqyKNd0r0O2emU7xBV28O0z5Gb0_QxEMkMEJVd6D-yMHUz5w@mail.gmail.com>
Subject: Re: [PATCH for-9.2 v6 03/12] hw/riscv: add RISC-V IOMMU base emulation
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, jason.chien@sifive.com, frank.chang@sifive.com, 
 ajones@ventanamicro.com, Tomasz Jeznach <tjeznach@rivosinc.com>, 
 Sebastien Boeuf <seb@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e31;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe31.google.com
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

On Fri, Aug 2, 2024 at 1:47=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> The RISC-V IOMMU specification is now ratified as-per the RISC-V
> international process. The latest frozen specifcation can be found at:
>
> https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv=
-iommu.pdf
>
> Add the foundation of the device emulation for RISC-V IOMMU. It includes
> support for s-stage (sv32, sv39, sv48, sv57 caps) and g-stage (sv32x4,
> sv39x4, sv48x4, sv57x4 caps).
>
> Other capabilities like ATS and DBG support will be added incrementally
> in the next patches.
>
> Co-developed-by: Sebastien Boeuf <seb@rivosinc.com>
> Signed-off-by: Sebastien Boeuf <seb@rivosinc.com>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/Kconfig            |    4 +
>  hw/riscv/meson.build        |    1 +
>  hw/riscv/riscv-iommu-bits.h |   14 +
>  hw/riscv/riscv-iommu.c      | 2017 +++++++++++++++++++++++++++++++++++
>  hw/riscv/riscv-iommu.h      |  148 +++
>  hw/riscv/trace-events       |   12 +
>  hw/riscv/trace.h            |    1 +
>  include/hw/riscv/iommu.h    |   36 +
>  meson.build                 |    1 +
>  9 files changed, 2234 insertions(+)
>  create mode 100644 hw/riscv/riscv-iommu.c
>  create mode 100644 hw/riscv/riscv-iommu.h
>  create mode 100644 hw/riscv/trace-events
>  create mode 100644 hw/riscv/trace.h
>  create mode 100644 include/hw/riscv/iommu.h
>
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index a2030e3a6f..f69d6e3c8e 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -1,3 +1,6 @@
> +config RISCV_IOMMU
> +    bool
> +
>  config RISCV_NUMA
>      bool
>
> @@ -47,6 +50,7 @@ config RISCV_VIRT
>      select SERIAL
>      select RISCV_ACLINT
>      select RISCV_APLIC
> +    select RISCV_IOMMU
>      select RISCV_IMSIC
>      select SIFIVE_PLIC
>      select SIFIVE_TEST
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index f872674093..cbc99c6e8e 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -10,5 +10,6 @@ riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('s=
ifive_u.c'))
>  riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
>  riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_p=
fsoc.c'))
>  riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
> +riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c')=
)
>
>  hw_arch +=3D {'riscv': riscv_ss}
> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> index 9d9512ca71..6f1b9ab61b 100644
> --- a/hw/riscv/riscv-iommu-bits.h
> +++ b/hw/riscv/riscv-iommu-bits.h
> @@ -69,6 +69,14 @@ struct riscv_iommu_pq_record {
>  /* 5.3 IOMMU Capabilities (64bits) */
>  #define RISCV_IOMMU_REG_CAP             0x0000
>  #define RISCV_IOMMU_CAP_VERSION         GENMASK_ULL(7, 0)
> +#define RISCV_IOMMU_CAP_SV32            BIT_ULL(8)
> +#define RISCV_IOMMU_CAP_SV39            BIT_ULL(9)
> +#define RISCV_IOMMU_CAP_SV48            BIT_ULL(10)
> +#define RISCV_IOMMU_CAP_SV57            BIT_ULL(11)
> +#define RISCV_IOMMU_CAP_SV32X4          BIT_ULL(16)
> +#define RISCV_IOMMU_CAP_SV39X4          BIT_ULL(17)
> +#define RISCV_IOMMU_CAP_SV48X4          BIT_ULL(18)
> +#define RISCV_IOMMU_CAP_SV57X4          BIT_ULL(19)
>  #define RISCV_IOMMU_CAP_MSI_FLAT        BIT_ULL(22)
>  #define RISCV_IOMMU_CAP_MSI_MRIF        BIT_ULL(23)
>  #define RISCV_IOMMU_CAP_T2GPA           BIT_ULL(26)
> @@ -80,7 +88,9 @@ struct riscv_iommu_pq_record {
>
>  /* 5.4 Features control register (32bits) */
>  #define RISCV_IOMMU_REG_FCTL            0x0008
> +#define RISCV_IOMMU_FCTL_BE             BIT(0)
>  #define RISCV_IOMMU_FCTL_WSI            BIT(1)
> +#define RISCV_IOMMU_FCTL_GXL            BIT(2)
>
>  /* 5.5 Device-directory-table pointer (64bits) */
>  #define RISCV_IOMMU_REG_DDTP            0x0010
> @@ -203,6 +213,8 @@ struct riscv_iommu_dc {
>  #define RISCV_IOMMU_DC_TC_DTF           BIT_ULL(4)
>  #define RISCV_IOMMU_DC_TC_PDTV          BIT_ULL(5)
>  #define RISCV_IOMMU_DC_TC_PRPR          BIT_ULL(6)
> +#define RISCV_IOMMU_DC_TC_GADE          BIT_ULL(7)
> +#define RISCV_IOMMU_DC_TC_SADE          BIT_ULL(8)
>  #define RISCV_IOMMU_DC_TC_DPE           BIT_ULL(9)
>  #define RISCV_IOMMU_DC_TC_SBE           BIT_ULL(10)
>  #define RISCV_IOMMU_DC_TC_SXL           BIT_ULL(11)
> @@ -309,9 +321,11 @@ enum riscv_iommu_fq_causes {
>
>  /* Translation attributes fields */
>  #define RISCV_IOMMU_PC_TA_V             BIT_ULL(0)
> +#define RISCV_IOMMU_PC_TA_RESERVED      GENMASK_ULL(63, 32)
>
>  /* First stage context fields */
>  #define RISCV_IOMMU_PC_FSC_PPN          GENMASK_ULL(43, 0)
> +#define RISCV_IOMMU_PC_FSC_RESERVED     GENMASK_ULL(59, 44)
>
>  enum riscv_iommu_fq_ttypes {
>      RISCV_IOMMU_FQ_TTYPE_NONE =3D 0,
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> new file mode 100644
> index 0000000000..ebe3a53a04
> --- /dev/null
> +++ b/hw/riscv/riscv-iommu.c
> @@ -0,0 +1,2017 @@
> +/*
> + * QEMU emulation of an RISC-V IOMMU
> + *
> + * Copyright (C) 2021-2023, Rivos Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qom/object.h"
> +#include "hw/pci/pci_bus.h"
> +#include "hw/pci/pci_device.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/riscv/riscv_hart.h"
> +#include "migration/vmstate.h"
> +#include "qapi/error.h"
> +#include "qemu/timer.h"
> +
> +#include "cpu_bits.h"
> +#include "riscv-iommu.h"
> +#include "riscv-iommu-bits.h"
> +#include "trace.h"
> +
> +#define LIMIT_CACHE_CTX               (1U << 7)
> +#define LIMIT_CACHE_IOT               (1U << 20)
> +
> +/* Physical page number coversions */
> +#define PPN_PHYS(ppn)                 ((ppn) << TARGET_PAGE_BITS)
> +#define PPN_DOWN(phy)                 ((phy) >> TARGET_PAGE_BITS)
> +
> +typedef struct RISCVIOMMUContext RISCVIOMMUContext;
> +typedef struct RISCVIOMMUEntry RISCVIOMMUEntry;
> +
> +/* Device assigned I/O address space */
> +struct RISCVIOMMUSpace {
> +    IOMMUMemoryRegion iova_mr;  /* IOVA memory region for attached devic=
e */
> +    AddressSpace iova_as;       /* IOVA address space for attached devic=
e */
> +    RISCVIOMMUState *iommu;     /* Managing IOMMU device state */
> +    uint32_t devid;             /* Requester identifier, AKA device_id *=
/
> +    bool notifier;              /* IOMMU unmap notifier enabled */
> +    QLIST_ENTRY(RISCVIOMMUSpace) list;
> +};
> +
> +/* Device translation context state. */
> +struct RISCVIOMMUContext {
> +    uint64_t devid:24;          /* Requester Id, AKA device_id */
> +    uint64_t process_id:20;     /* Process ID. PASID for PCIe */
> +    uint64_t __rfu:20;          /* reserved */
> +    uint64_t tc;                /* Translation Control */
> +    uint64_t ta;                /* Translation Attributes */
> +    uint64_t satp;              /* S-Stage address translation and prote=
ction */
> +    uint64_t gatp;              /* G-Stage address translation and prote=
ction */
> +    uint64_t msi_addr_mask;     /* MSI filtering - address mask */
> +    uint64_t msi_addr_pattern;  /* MSI filtering - address pattern */
> +    uint64_t msiptp;            /* MSI redirection page table pointer */
> +};
> +
> +/* IOMMU index for transactions without process_id specified. */
> +#define RISCV_IOMMU_NOPROCID 0
> +
> +static uint8_t riscv_iommu_get_icvec_vector(uint32_t icvec, uint32_t vec=
_type)
> +{
> +    g_assert(vec_type < 4);
> +    return (icvec >> (vec_type * 4)) & 0x0F;
> +}
> +
> +static void riscv_iommu_notify(RISCVIOMMUState *s, int vec)
> +{
> +    const uint32_t fctl =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FCT=
L);
> +    uint32_t ipsr, icvec;
> +
> +    if (fctl & RISCV_IOMMU_FCTL_WSI || !s->notify) {
> +        return;
> +    }
> +
> +    icvec =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_ICVEC);
> +    ipsr =3D riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_IPSR, (1 << vec), =
0);
> +
> +    if (!(ipsr & (1 << vec))) {
> +        s->notify(s, riscv_iommu_get_icvec_vector(icvec, vec));
> +    }
> +}
> +
> +static void riscv_iommu_fault(RISCVIOMMUState *s,
> +                              struct riscv_iommu_fq_record *ev)
> +{
> +    uint32_t ctrl =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQCSR);
> +    uint32_t head =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQH) & s-=
>fq_mask;
> +    uint32_t tail =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQT) & s-=
>fq_mask;
> +    uint32_t next =3D (tail + 1) & s->fq_mask;
> +    uint32_t devid =3D get_field(ev->hdr, RISCV_IOMMU_FQ_HDR_DID);
> +
> +    trace_riscv_iommu_flt(s->parent_obj.id, PCI_BUS_NUM(devid), PCI_SLOT=
(devid),
> +                          PCI_FUNC(devid), ev->hdr, ev->iotval);
> +
> +    if (!(ctrl & RISCV_IOMMU_FQCSR_FQON) ||
> +        !!(ctrl & (RISCV_IOMMU_FQCSR_FQOF | RISCV_IOMMU_FQCSR_FQMF))) {
> +        return;
> +    }
> +
> +    if (head =3D=3D next) {
> +        riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_FQCSR,
> +                              RISCV_IOMMU_FQCSR_FQOF, 0);
> +    } else {
> +        dma_addr_t addr =3D s->fq_addr + tail * sizeof(*ev);
> +        if (dma_memory_write(s->target_as, addr, ev, sizeof(*ev),
> +                             MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
> +            riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_FQCSR,
> +                                  RISCV_IOMMU_FQCSR_FQMF, 0);
> +        } else {
> +            riscv_iommu_reg_set32(s, RISCV_IOMMU_REG_FQT, next);
> +        }
> +    }
> +
> +    if (ctrl & RISCV_IOMMU_FQCSR_FIE) {
> +        riscv_iommu_notify(s, RISCV_IOMMU_INTR_FQ);
> +    }
> +}
> +
> +static void riscv_iommu_pri(RISCVIOMMUState *s,
> +    struct riscv_iommu_pq_record *pr)
> +{
> +    uint32_t ctrl =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQCSR);
> +    uint32_t head =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQH) & s-=
>pq_mask;
> +    uint32_t tail =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQT) & s-=
>pq_mask;
> +    uint32_t next =3D (tail + 1) & s->pq_mask;
> +    uint32_t devid =3D get_field(pr->hdr, RISCV_IOMMU_PREQ_HDR_DID);
> +
> +    trace_riscv_iommu_pri(s->parent_obj.id, PCI_BUS_NUM(devid), PCI_SLOT=
(devid),
> +                          PCI_FUNC(devid), pr->payload);
> +
> +    if (!(ctrl & RISCV_IOMMU_PQCSR_PQON) ||
> +        !!(ctrl & (RISCV_IOMMU_PQCSR_PQOF | RISCV_IOMMU_PQCSR_PQMF))) {
> +        return;
> +    }
> +
> +    if (head =3D=3D next) {
> +        riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_PQCSR,
> +                              RISCV_IOMMU_PQCSR_PQOF, 0);
> +    } else {
> +        dma_addr_t addr =3D s->pq_addr + tail * sizeof(*pr);
> +        if (dma_memory_write(s->target_as, addr, pr, sizeof(*pr),
> +                             MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
> +            riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_PQCSR,
> +                                  RISCV_IOMMU_PQCSR_PQMF, 0);
> +        } else {
> +            riscv_iommu_reg_set32(s, RISCV_IOMMU_REG_PQT, next);
> +        }
> +    }
> +
> +    if (ctrl & RISCV_IOMMU_PQCSR_PIE) {
> +        riscv_iommu_notify(s, RISCV_IOMMU_INTR_PQ);
> +    }
> +}
> +
> +/* Portable implementation of pext_u64, bit-mask extraction. */
> +static uint64_t _pext_u64(uint64_t val, uint64_t ext)
> +{
> +    uint64_t ret =3D 0;
> +    uint64_t rot =3D 1;
> +
> +    while (ext) {
> +        if (ext & 1) {
> +            if (val & 1) {
> +                ret |=3D rot;
> +            }
> +            rot <<=3D 1;
> +        }
> +        val >>=3D 1;
> +        ext >>=3D 1;
> +    }
> +
> +    return ret;
> +}
> +
> +/* Check if GPA matches MSI/MRIF pattern. */
> +static bool riscv_iommu_msi_check(RISCVIOMMUState *s, RISCVIOMMUContext =
*ctx,
> +    dma_addr_t gpa)
> +{
> +    if (!s->enable_msi) {
> +        return false;
> +    }
> +
> +    if (get_field(ctx->msiptp, RISCV_IOMMU_DC_MSIPTP_MODE) !=3D
> +        RISCV_IOMMU_DC_MSIPTP_MODE_FLAT) {
> +        return false; /* Invalid MSI/MRIF mode */
> +    }
> +
> +    if ((PPN_DOWN(gpa) ^ ctx->msi_addr_pattern) & ~ctx->msi_addr_mask) {
> +        return false; /* GPA not in MSI range defined by AIA IMSIC rules=
. */
> +    }
> +
> +    return true;
> +}
> +
> +/*
> + * RISCV IOMMU Address Translation Lookup - Page Table Walk
> + *
> + * Note: Code is based on get_physical_address() from target/riscv/cpu_h=
elper.c
> + * Both implementation can be merged into single helper function in futu=
re.
> + * Keeping them separate for now, as error reporting and flow specifics =
are
> + * sufficiently different for separate implementation.
> + *
> + * @s        : IOMMU Device State
> + * @ctx      : Translation context for device id and process address spa=
ce id.
> + * @iotlb    : translation data: physical address and access mode.
> + * @return   : success or fault cause code.
> + */
> +static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *=
ctx,
> +    IOMMUTLBEntry *iotlb)
> +{
> +    dma_addr_t addr, base;
> +    uint64_t satp, gatp, pte;
> +    bool en_s, en_g;
> +    struct {
> +        unsigned char step;
> +        unsigned char levels;
> +        unsigned char ptidxbits;
> +        unsigned char ptesize;
> +    } sc[2];
> +    /* Translation stage phase */
> +    enum {
> +        S_STAGE =3D 0,
> +        G_STAGE =3D 1,
> +    } pass;
> +
> +    satp =3D get_field(ctx->satp, RISCV_IOMMU_ATP_MODE_FIELD);
> +    gatp =3D get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
> +
> +    en_s =3D satp !=3D RISCV_IOMMU_DC_FSC_MODE_BARE;
> +    en_g =3D gatp !=3D RISCV_IOMMU_DC_IOHGATP_MODE_BARE;
> +
> +    /* Early check for MSI address match when IOVA =3D=3D GPA */
> +    if ((iotlb->perm & IOMMU_WO) &&
> +        riscv_iommu_msi_check(s, ctx, iotlb->iova)) {
> +        iotlb->target_as =3D &s->trap_as;
> +        iotlb->translated_addr =3D iotlb->iova;
> +        iotlb->addr_mask =3D ~TARGET_PAGE_MASK;
> +        return 0;
> +    }
> +
> +    /* Exit early for pass-through mode. */
> +    if (!(en_s || en_g)) {
> +        iotlb->translated_addr =3D iotlb->iova;
> +        iotlb->addr_mask =3D ~TARGET_PAGE_MASK;
> +        /* Allow R/W in pass-through mode */
> +        iotlb->perm =3D IOMMU_RW;
> +        return 0;
> +    }
> +
> +    /* S/G translation parameters. */
> +    for (pass =3D 0; pass < 2; pass++) {
> +        uint32_t sv_mode;
> +
> +        sc[pass].step =3D 0;
> +        if (pass ? (s->fctl & RISCV_IOMMU_FCTL_GXL) :
> +            (ctx->tc & RISCV_IOMMU_DC_TC_SXL)) {
> +            /* 32bit mode for GXL/SXL =3D=3D 1 */
> +            switch (pass ? gatp : satp) {
> +            case RISCV_IOMMU_DC_IOHGATP_MODE_BARE:
> +                sc[pass].levels    =3D 0;
> +                sc[pass].ptidxbits =3D 0;
> +                sc[pass].ptesize   =3D 0;
> +                break;
> +            case RISCV_IOMMU_DC_IOHGATP_MODE_SV32X4:
> +                sv_mode =3D pass ? RISCV_IOMMU_CAP_SV32X4 : RISCV_IOMMU_=
CAP_SV32;
> +                if (!(s->cap & sv_mode)) {
> +                    return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +                }
> +                sc[pass].levels    =3D 2;
> +                sc[pass].ptidxbits =3D 10;
> +                sc[pass].ptesize   =3D 4;
> +                break;
> +            default:
> +                return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +            }
> +        } else {
> +            /* 64bit mode for GXL/SXL =3D=3D 0 */
> +            switch (pass ? gatp : satp) {
> +            case RISCV_IOMMU_DC_IOHGATP_MODE_BARE:
> +                sc[pass].levels    =3D 0;
> +                sc[pass].ptidxbits =3D 0;
> +                sc[pass].ptesize   =3D 0;
> +                break;
> +            case RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4:
> +                sv_mode =3D pass ? RISCV_IOMMU_CAP_SV39X4 : RISCV_IOMMU_=
CAP_SV39;
> +                if (!(s->cap & sv_mode)) {
> +                    return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +                }
> +                sc[pass].levels    =3D 3;
> +                sc[pass].ptidxbits =3D 9;
> +                sc[pass].ptesize   =3D 8;
> +                break;
> +            case RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4:
> +                sv_mode =3D pass ? RISCV_IOMMU_CAP_SV48X4 : RISCV_IOMMU_=
CAP_SV48;
> +                if (!(s->cap & sv_mode)) {
> +                    return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +                }
> +                sc[pass].levels    =3D 4;
> +                sc[pass].ptidxbits =3D 9;
> +                sc[pass].ptesize   =3D 8;
> +                break;
> +            case RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4:
> +                sv_mode =3D pass ? RISCV_IOMMU_CAP_SV57X4 : RISCV_IOMMU_=
CAP_SV57;
> +                if (!(s->cap & sv_mode)) {
> +                    return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +                }
> +                sc[pass].levels    =3D 5;
> +                sc[pass].ptidxbits =3D 9;
> +                sc[pass].ptesize   =3D 8;
> +                break;
> +            default:
> +                return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +            }
> +        }
> +    };
> +
> +    /* S/G stages translation tables root pointers */
> +    gatp =3D PPN_PHYS(get_field(ctx->gatp, RISCV_IOMMU_ATP_PPN_FIELD));
> +    satp =3D PPN_PHYS(get_field(ctx->satp, RISCV_IOMMU_ATP_PPN_FIELD));
> +    addr =3D (en_s && en_g) ? satp : iotlb->iova;
> +    base =3D en_g ? gatp : satp;
> +    pass =3D en_g ? G_STAGE : S_STAGE;
> +
> +    do {
> +        const unsigned widened =3D (pass && !sc[pass].step) ? 2 : 0;
> +        const unsigned va_bits =3D widened + sc[pass].ptidxbits;
> +        const unsigned va_skip =3D TARGET_PAGE_BITS + sc[pass].ptidxbits=
 *
> +                                 (sc[pass].levels - 1 - sc[pass].step);
> +        const unsigned idx =3D (addr >> va_skip) & ((1 << va_bits) - 1);
> +        const dma_addr_t pte_addr =3D base + idx * sc[pass].ptesize;
> +        const bool ade =3D
> +            ctx->tc & (pass ? RISCV_IOMMU_DC_TC_GADE : RISCV_IOMMU_DC_TC=
_SADE);
> +
> +        /* Address range check before first level lookup */
> +        if (!sc[pass].step) {
> +            const uint64_t va_mask =3D (1ULL << (va_skip + va_bits)) - 1=
;
> +            if ((addr & va_mask) !=3D addr) {
> +                return RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED;
> +            }
> +        }
> +
> +        /* Read page table entry */
> +        if (dma_memory_read(s->target_as, pte_addr, &pte,
> +                sc[pass].ptesize, MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK)=
 {
> +            return (iotlb->perm & IOMMU_WO) ? RISCV_IOMMU_FQ_CAUSE_WR_FA=
ULT
> +                                            : RISCV_IOMMU_FQ_CAUSE_RD_FA=
ULT;
> +        }
> +
> +        if (sc[pass].ptesize =3D=3D 4) {
> +            pte =3D (uint64_t) le32_to_cpu(*((uint32_t *)&pte));
> +        } else {
> +            pte =3D le64_to_cpu(pte);
> +        }
> +
> +        sc[pass].step++;
> +        hwaddr ppn =3D pte >> PTE_PPN_SHIFT;
> +
> +        if (!(pte & PTE_V)) {
> +            break;                /* Invalid PTE */
> +        } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
> +            base =3D PPN_PHYS(ppn); /* Inner PTE, continue walking */
> +        } else if ((pte & (PTE_R | PTE_W | PTE_X)) =3D=3D PTE_W) {
> +            break;                /* Reserved leaf PTE flags: PTE_W */
> +        } else if ((pte & (PTE_R | PTE_W | PTE_X)) =3D=3D (PTE_W | PTE_X=
)) {
> +            break;                /* Reserved leaf PTE flags: PTE_W + PT=
E_X */
> +        } else if (ppn & ((1ULL << (va_skip - TARGET_PAGE_BITS)) - 1)) {
> +            break;                /* Misaligned PPN */
> +        } else if ((iotlb->perm & IOMMU_RO) && !(pte & PTE_R)) {
> +            break;                /* Read access check failed */
> +        } else if ((iotlb->perm & IOMMU_WO) && !(pte & PTE_W)) {
> +            break;                /* Write access check failed */
> +        } else if ((iotlb->perm & IOMMU_RO) && !ade && !(pte & PTE_A)) {
> +            break;                /* Access bit not set */
> +        } else if ((iotlb->perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
> +            break;                /* Dirty bit not set */
> +        } else {
> +            /* Leaf PTE, translation completed. */
> +            sc[pass].step =3D sc[pass].levels;
> +            base =3D PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
> +            /* Update address mask based on smallest translation granula=
rity */
> +            iotlb->addr_mask &=3D (1ULL << va_skip) - 1;
> +            /* Continue with S-Stage translation? */
> +            if (pass && sc[0].step !=3D sc[0].levels) {
> +                pass =3D S_STAGE;
> +                addr =3D iotlb->iova;
> +                continue;
> +            }
> +            /* Translation phase completed (GPA or SPA) */
> +            iotlb->translated_addr =3D base;
> +            iotlb->perm =3D (pte & PTE_W) ? ((pte & PTE_R) ? IOMMU_RW : =
IOMMU_WO)
> +                                                         : IOMMU_RO;
> +
> +            /* Check MSI GPA address match */
> +            if (pass =3D=3D S_STAGE && (iotlb->perm & IOMMU_WO) &&
> +                riscv_iommu_msi_check(s, ctx, base)) {
> +                /* Trap MSI writes and return GPA address. */
> +                iotlb->target_as =3D &s->trap_as;
> +                iotlb->addr_mask =3D ~TARGET_PAGE_MASK;
> +                return 0;
> +            }
> +
> +            /* Continue with G-Stage translation? */
> +            if (!pass && en_g) {
> +                pass =3D G_STAGE;
> +                addr =3D base;
> +                base =3D gatp;
> +                sc[pass].step =3D 0;
> +                continue;
> +            }
> +
> +            return 0;
> +        }
> +
> +        if (sc[pass].step =3D=3D sc[pass].levels) {
> +            break; /* Can't find leaf PTE */
> +        }
> +
> +        /* Continue with G-Stage translation? */
> +        if (!pass && en_g) {
> +            pass =3D G_STAGE;
> +            addr =3D base;
> +            base =3D gatp;
> +            sc[pass].step =3D 0;
> +        }
> +    } while (1);
> +
> +    return (iotlb->perm & IOMMU_WO) ?
> +                (pass ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
> +                        RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S) :
> +                (pass ? RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS :
> +                        RISCV_IOMMU_FQ_CAUSE_RD_FAULT_S);
> +}
> +
> +static void riscv_iommu_report_fault(RISCVIOMMUState *s,
> +                                     RISCVIOMMUContext *ctx,
> +                                     uint32_t fault_type, uint32_t cause=
,
> +                                     bool pv,
> +                                     uint64_t iotval, uint64_t iotval2)
> +{
> +    struct riscv_iommu_fq_record ev =3D { 0 };
> +
> +    if (ctx->tc & RISCV_IOMMU_DC_TC_DTF) {
> +        switch (cause) {
> +        case RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED:
> +        case RISCV_IOMMU_FQ_CAUSE_DDT_LOAD_FAULT:
> +        case RISCV_IOMMU_FQ_CAUSE_DDT_INVALID:
> +        case RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED:
> +        case RISCV_IOMMU_FQ_CAUSE_DDT_CORRUPTED:
> +        case RISCV_IOMMU_FQ_CAUSE_INTERNAL_DP_ERROR:
> +        case RISCV_IOMMU_FQ_CAUSE_MSI_WR_FAULT:
> +            break;
> +        default:
> +            /* DTF prevents reporting a fault for this given cause */
> +            return;
> +        }
> +    }
> +
> +    ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_CAUSE, cause);
> +    ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_TTYPE, fault_type);
> +    ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_DID, ctx->devid);
> +    ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_PV, true);
> +
> +    if (pv) {
> +        ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_PID, ctx->proces=
s_id);
> +    }
> +
> +    ev.iotval =3D iotval;
> +    ev.iotval2 =3D iotval2;
> +
> +    riscv_iommu_fault(s, &ev);
> +}
> +
> +/* Redirect MSI write for given GPA. */
> +static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
> +    RISCVIOMMUContext *ctx, uint64_t gpa, uint64_t data,
> +    unsigned size, MemTxAttrs attrs)
> +{
> +    MemTxResult res;
> +    dma_addr_t addr;
> +    uint64_t intn;
> +    uint32_t n190;
> +    uint64_t pte[2];
> +    int fault_type =3D RISCV_IOMMU_FQ_TTYPE_UADDR_WR;
> +    int cause;
> +
> +    /* Interrupt File Number */
> +    intn =3D _pext_u64(PPN_DOWN(gpa), ctx->msi_addr_mask);
> +    if (intn >=3D 256) {
> +        /* Interrupt file number out of range */
> +        res =3D MEMTX_ACCESS_ERROR;
> +        cause =3D RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
> +        goto err;
> +    }
> +
> +    /* fetch MSI PTE */
> +    addr =3D PPN_PHYS(get_field(ctx->msiptp, RISCV_IOMMU_DC_MSIPTP_PPN))=
;
> +    addr =3D addr | (intn * sizeof(pte));
> +    res =3D dma_memory_read(s->target_as, addr, &pte, sizeof(pte),
> +            MEMTXATTRS_UNSPECIFIED);
> +    if (res !=3D MEMTX_OK) {
> +        if (res =3D=3D MEMTX_DECODE_ERROR) {
> +            cause =3D RISCV_IOMMU_FQ_CAUSE_MSI_PT_CORRUPTED;
> +        } else {
> +            cause =3D RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
> +        }
> +        goto err;
> +    }
> +
> +    le64_to_cpus(&pte[0]);
> +    le64_to_cpus(&pte[1]);
> +
> +    if (!(pte[0] & RISCV_IOMMU_MSI_PTE_V) || (pte[0] & RISCV_IOMMU_MSI_P=
TE_C)) {
> +        /*
> +         * The spec mentions that: "If msipte.C =3D=3D 1, then further
> +         * processing to interpret the PTE is implementation
> +         * defined.". We'll abort with cause =3D 262 for this
> +         * case too.
> +         */
> +        res =3D MEMTX_ACCESS_ERROR;
> +        cause =3D RISCV_IOMMU_FQ_CAUSE_MSI_INVALID;
> +        goto err;
> +    }
> +
> +    switch (get_field(pte[0], RISCV_IOMMU_MSI_PTE_M)) {
> +    case RISCV_IOMMU_MSI_PTE_M_BASIC:
> +        /* MSI Pass-through mode */
> +        addr =3D PPN_PHYS(get_field(pte[0], RISCV_IOMMU_MSI_PTE_PPN));
> +        addr =3D addr | (gpa & TARGET_PAGE_MASK);
> +
> +        trace_riscv_iommu_msi(s->parent_obj.id, PCI_BUS_NUM(ctx->devid),
> +                              PCI_SLOT(ctx->devid), PCI_FUNC(ctx->devid)=
,
> +                              gpa, addr);
> +
> +        res =3D dma_memory_write(s->target_as, addr, &data, size, attrs)=
;
> +        if (res !=3D MEMTX_OK) {
> +            cause =3D RISCV_IOMMU_FQ_CAUSE_MSI_WR_FAULT;
> +            goto err;
> +        }
> +
> +        return MEMTX_OK;
> +    case RISCV_IOMMU_MSI_PTE_M_MRIF:
> +        /* MRIF mode, continue. */
> +        break;
> +    default:
> +        res =3D MEMTX_ACCESS_ERROR;
> +        cause =3D RISCV_IOMMU_FQ_CAUSE_MSI_MISCONFIGURED;
> +        goto err;
> +    }
> +
> +    /*
> +     * Report an error for interrupt identities exceeding the maximum al=
lowed
> +     * for an IMSIC interrupt file (2047) or destination address is not =
32-bit
> +     * aligned. See IOMMU Specification, Chapter 2.3. MSI page tables.
> +     */
> +    if ((data > 2047) || (gpa & 3)) {
> +        res =3D MEMTX_ACCESS_ERROR;
> +        cause =3D RISCV_IOMMU_FQ_CAUSE_MSI_MISCONFIGURED;
> +        goto err;
> +    }
> +
> +    /* MSI MRIF mode, non atomic pending bit update */
> +
> +    /* MRIF pending bit address */
> +    addr =3D get_field(pte[0], RISCV_IOMMU_MSI_PTE_MRIF_ADDR) << 9;
> +    addr =3D addr | ((data & 0x7c0) >> 3);
> +
> +    trace_riscv_iommu_msi(s->parent_obj.id, PCI_BUS_NUM(ctx->devid),
> +                          PCI_SLOT(ctx->devid), PCI_FUNC(ctx->devid),
> +                          gpa, addr);
> +
> +    /* MRIF pending bit mask */
> +    data =3D 1ULL << (data & 0x03f);
> +    res =3D dma_memory_read(s->target_as, addr, &intn, sizeof(intn), att=
rs);
> +    if (res !=3D MEMTX_OK) {
> +        cause =3D RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
> +        goto err;
> +    }
> +
> +    intn =3D intn | data;
> +    res =3D dma_memory_write(s->target_as, addr, &intn, sizeof(intn), at=
trs);
> +    if (res !=3D MEMTX_OK) {
> +        cause =3D RISCV_IOMMU_FQ_CAUSE_MSI_WR_FAULT;
> +        goto err;
> +    }
> +
> +    /* Get MRIF enable bits */
> +    addr =3D addr + sizeof(intn);
> +    res =3D dma_memory_read(s->target_as, addr, &intn, sizeof(intn), att=
rs);
> +    if (res !=3D MEMTX_OK) {
> +        cause =3D RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
> +        goto err;
> +    }
> +
> +    if (!(intn & data)) {
> +        /* notification disabled, MRIF update completed. */
> +        return MEMTX_OK;
> +    }
> +
> +    /* Send notification message */
> +    addr =3D PPN_PHYS(get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NPPN));
> +    n190 =3D get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NID) |
> +          (get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NID_MSB) << 10);
> +
> +    res =3D dma_memory_write(s->target_as, addr, &n190, sizeof(n190), at=
trs);
> +    if (res !=3D MEMTX_OK) {
> +        cause =3D RISCV_IOMMU_FQ_CAUSE_MSI_WR_FAULT;
> +        goto err;
> +    }
> +
> +    trace_riscv_iommu_mrif_notification(s->parent_obj.id, n190, addr);
> +
> +    return MEMTX_OK;
> +
> +err:
> +    riscv_iommu_report_fault(s, ctx, fault_type, cause,
> +                             !!ctx->process_id, 0, 0);
> +    return res;
> +}
> +
> +/*
> + * Check device context configuration as described by the
> + * riscv-iommu spec section "Device-context configuration
> + * checks".
> + */
> +static bool riscv_iommu_validate_device_ctx(RISCVIOMMUState *s,
> +                                            RISCVIOMMUContext *ctx)
> +{
> +    uint32_t fsc_mode, msi_mode;
> +
> +    if (!(ctx->tc & RISCV_IOMMU_DC_TC_EN_PRI) &&
> +        ctx->tc & RISCV_IOMMU_DC_TC_PRPR) {
> +        return false;
> +    }
> +
> +    if (!(s->cap & RISCV_IOMMU_CAP_T2GPA) &&
> +        ctx->tc & RISCV_IOMMU_DC_TC_T2GPA) {
> +        return false;
> +    }
> +
> +    if (s->cap & RISCV_IOMMU_CAP_MSI_FLAT) {
> +        msi_mode =3D get_field(ctx->msiptp, RISCV_IOMMU_DC_MSIPTP_MODE);
> +
> +        if (msi_mode !=3D RISCV_IOMMU_DC_MSIPTP_MODE_OFF &&
> +            msi_mode !=3D RISCV_IOMMU_DC_MSIPTP_MODE_FLAT) {
> +            return false;
> +        }
> +    }
> +
> +    fsc_mode =3D get_field(ctx->satp, RISCV_IOMMU_DC_FSC_MODE);
> +
> +    if (ctx->tc & RISCV_IOMMU_DC_TC_PDTV) {
> +        switch (fsc_mode) {
> +        case RISCV_IOMMU_DC_FSC_PDTP_MODE_PD8:
> +            if (!(s->cap & RISCV_IOMMU_CAP_PD8)) {
> +                return false;
> +            }
> +            break;
> +        case RISCV_IOMMU_DC_FSC_PDTP_MODE_PD17:
> +            if (!(s->cap & RISCV_IOMMU_CAP_PD17)) {
> +                return false;
> +            }
> +            break;
> +        case RISCV_IOMMU_DC_FSC_PDTP_MODE_PD20:
> +            if (!(s->cap & RISCV_IOMMU_CAP_PD20)) {
> +                return false;
> +            }
> +            break;
> +        }
> +    } else {
> +        /* DC.tc.PDTV is 0 */
> +        if (ctx->tc & RISCV_IOMMU_DC_TC_DPE) {
> +            return false;
> +        }
> +
> +        if (ctx->tc & RISCV_IOMMU_DC_TC_SXL) {
> +            if (fsc_mode =3D=3D RISCV_IOMMU_CAP_SV32 &&
> +                !(s->cap & RISCV_IOMMU_CAP_SV32)) {
> +                return false;
> +            }
> +        } else {
> +            switch (fsc_mode) {
> +            case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39:
> +                if (!(s->cap & RISCV_IOMMU_CAP_SV39)) {
> +                    return false;
> +                }
> +                break;
> +            case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48:
> +                if (!(s->cap & RISCV_IOMMU_CAP_SV48)) {
> +                    return false;
> +                }
> +            break;
> +            case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57:
> +                if (!(s->cap & RISCV_IOMMU_CAP_SV57)) {
> +                    return false;
> +                }
> +                break;
> +            }
> +        }
> +    }
> +
> +    /*
> +     * CAP_END is always zero (only one endianess). FCTL_BE is
> +     * always zero (little-endian accesses). Thus TC_SBE must
> +     * always be LE, i.e. zero.
> +     */
> +    if (ctx->tc & RISCV_IOMMU_DC_TC_SBE) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +/*
> + * Validate process context (PC) according to section
> + * "Process-context configuration checks".
> + */
> +static bool riscv_iommu_validate_process_ctx(RISCVIOMMUState *s,
> +                                             RISCVIOMMUContext *ctx)
> +{
> +    uint32_t mode;
> +
> +    if (get_field(ctx->ta, RISCV_IOMMU_PC_TA_RESERVED)) {
> +        return false;
> +    }
> +
> +    if (get_field(ctx->satp, RISCV_IOMMU_PC_FSC_RESERVED)) {
> +        return false;
> +    }
> +
> +    mode =3D get_field(ctx->satp, RISCV_IOMMU_DC_FSC_MODE);
> +    switch (mode) {
> +    case RISCV_IOMMU_DC_FSC_MODE_BARE:
> +    /* sv39 and sv32 modes have the same value (8) */
> +    case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39:
> +    case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48:
> +    case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57:
> +        break;
> +    default:
> +        return false;
> +    }
> +
> +    if (ctx->tc & RISCV_IOMMU_DC_TC_SXL) {
> +        if (mode =3D=3D RISCV_IOMMU_CAP_SV32 &&
> +            !(s->cap & RISCV_IOMMU_CAP_SV32)) {
> +                return false;
> +        }
> +    } else {
> +        switch (mode) {
> +        case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39:
> +            if (!(s->cap & RISCV_IOMMU_CAP_SV39)) {
> +                return false;
> +            }
> +            break;
> +        case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48:
> +            if (!(s->cap & RISCV_IOMMU_CAP_SV48)) {
> +                return false;
> +            }
> +            break;
> +        case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57:
> +            if (!(s->cap & RISCV_IOMMU_CAP_SV57)) {
> +                return false;
> +            }
> +            break;
> +        }
> +    }
> +
> +    return true;
> +}
> +
> +/*
> + * RISC-V IOMMU Device Context Loopkup - Device Directory Tree Walk
> + *
> + * @s         : IOMMU Device State
> + * @ctx       : Device Translation Context with devid and process_id set=
.
> + * @return    : success or fault code.
> + */
> +static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *=
ctx)
> +{
> +    const uint64_t ddtp =3D s->ddtp;
> +    unsigned mode =3D get_field(ddtp, RISCV_IOMMU_DDTP_MODE);
> +    dma_addr_t addr =3D PPN_PHYS(get_field(ddtp, RISCV_IOMMU_DDTP_PPN));
> +    struct riscv_iommu_dc dc;
> +    /* Device Context format: 0: extended (64 bytes) | 1: base (32 bytes=
) */
> +    const int dc_fmt =3D !s->enable_msi;
> +    const size_t dc_len =3D sizeof(dc) >> dc_fmt;
> +    unsigned depth;
> +    uint64_t de;
> +
> +    switch (mode) {
> +    case RISCV_IOMMU_DDTP_MODE_OFF:
> +        return RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED;
> +
> +    case RISCV_IOMMU_DDTP_MODE_BARE:
> +        /* mock up pass-through translation context */
> +        ctx->gatp =3D set_field(0, RISCV_IOMMU_ATP_MODE_FIELD,
> +            RISCV_IOMMU_DC_IOHGATP_MODE_BARE);
> +        ctx->satp =3D set_field(0, RISCV_IOMMU_ATP_MODE_FIELD,
> +            RISCV_IOMMU_DC_FSC_MODE_BARE);
> +        ctx->tc =3D RISCV_IOMMU_DC_TC_V;
> +        ctx->ta =3D 0;
> +        ctx->msiptp =3D 0;
> +        return 0;
> +
> +    case RISCV_IOMMU_DDTP_MODE_1LVL:
> +        depth =3D 0;
> +        break;
> +
> +    case RISCV_IOMMU_DDTP_MODE_2LVL:
> +        depth =3D 1;
> +        break;
> +
> +    case RISCV_IOMMU_DDTP_MODE_3LVL:
> +        depth =3D 2;
> +        break;
> +
> +    default:
> +        return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +    }
> +
> +    /*
> +     * Check supported device id width (in bits).
> +     * See IOMMU Specification, Chapter 6. Software guidelines.
> +     * - if extended device-context format is used:
> +     *   1LVL: 6, 2LVL: 15, 3LVL: 24
> +     * - if base device-context format is used:
> +     *   1LVL: 7, 2LVL: 16, 3LVL: 24
> +     */
> +    if (ctx->devid >=3D (1 << (depth * 9 + 6 + (dc_fmt && depth !=3D 2))=
)) {
> +        return RISCV_IOMMU_FQ_CAUSE_TTYPE_BLOCKED;
> +    }
> +
> +    /* Device directory tree walk */
> +    for (; depth-- > 0; ) {
> +        /*
> +         * Select device id index bits based on device directory tree le=
vel
> +         * and device context format.
> +         * See IOMMU Specification, Chapter 2. Data Structures.
> +         * - if extended device-context format is used:
> +         *   device index: [23:15][14:6][5:0]
> +         * - if base device-context format is used:
> +         *   device index: [23:16][15:7][6:0]
> +         */
> +        const int split =3D depth * 9 + 6 + dc_fmt;
> +        addr |=3D ((ctx->devid >> split) << 3) & ~TARGET_PAGE_MASK;
> +        if (dma_memory_read(s->target_as, addr, &de, sizeof(de),
> +                            MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
> +            return RISCV_IOMMU_FQ_CAUSE_DDT_LOAD_FAULT;
> +        }
> +        le64_to_cpus(&de);
> +        if (!(de & RISCV_IOMMU_DDTE_VALID)) {
> +            /* invalid directory entry */
> +            return RISCV_IOMMU_FQ_CAUSE_DDT_INVALID;
> +        }
> +        if (de & ~(RISCV_IOMMU_DDTE_PPN | RISCV_IOMMU_DDTE_VALID)) {
> +            /* reserved bits set */
> +            return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +        }
> +        addr =3D PPN_PHYS(get_field(de, RISCV_IOMMU_DDTE_PPN));
> +    }
> +
> +    /* index into device context entry page */
> +    addr |=3D (ctx->devid * dc_len) & ~TARGET_PAGE_MASK;
> +
> +    memset(&dc, 0, sizeof(dc));
> +    if (dma_memory_read(s->target_as, addr, &dc, dc_len,
> +                        MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
> +        return RISCV_IOMMU_FQ_CAUSE_DDT_LOAD_FAULT;
> +    }
> +
> +    /* Set translation context. */
> +    ctx->tc =3D le64_to_cpu(dc.tc);
> +    ctx->gatp =3D le64_to_cpu(dc.iohgatp);
> +    ctx->satp =3D le64_to_cpu(dc.fsc);
> +    ctx->ta =3D le64_to_cpu(dc.ta);
> +    ctx->msiptp =3D le64_to_cpu(dc.msiptp);
> +    ctx->msi_addr_mask =3D le64_to_cpu(dc.msi_addr_mask);
> +    ctx->msi_addr_pattern =3D le64_to_cpu(dc.msi_addr_pattern);
> +
> +    if (!(ctx->tc & RISCV_IOMMU_DC_TC_V)) {
> +        return RISCV_IOMMU_FQ_CAUSE_DDT_INVALID;
> +    }
> +
> +    if (!riscv_iommu_validate_device_ctx(s, ctx)) {
> +        return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +    }
> +
> +    /* FSC field checks */
> +    mode =3D get_field(ctx->satp, RISCV_IOMMU_DC_FSC_MODE);
> +    addr =3D PPN_PHYS(get_field(ctx->satp, RISCV_IOMMU_DC_FSC_PPN));
> +
> +    if (!(ctx->tc & RISCV_IOMMU_DC_TC_PDTV)) {
> +        if (ctx->process_id !=3D RISCV_IOMMU_NOPROCID) {
> +            /* PID is disabled */
> +            return RISCV_IOMMU_FQ_CAUSE_TTYPE_BLOCKED;
> +        }
> +        if (mode > RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57) {
> +            /* Invalid translation mode */
> +            return RISCV_IOMMU_FQ_CAUSE_DDT_INVALID;
> +        }
> +        return 0;
> +    }
> +
> +    if (ctx->process_id =3D=3D RISCV_IOMMU_NOPROCID) {
> +        if (!(ctx->tc & RISCV_IOMMU_DC_TC_DPE)) {
> +            /* No default process_id enabled, set BARE mode */
> +            ctx->satp =3D 0ULL;
> +            return 0;
> +        } else {
> +            /* Use default process_id #0 */
> +            ctx->process_id =3D 0;
> +        }
> +    }
> +
> +    if (mode =3D=3D RISCV_IOMMU_DC_FSC_MODE_BARE) {
> +        /* No S-Stage translation, done. */
> +        return 0;
> +    }
> +
> +    /* FSC.TC.PDTV enabled */
> +    if (mode > RISCV_IOMMU_DC_FSC_PDTP_MODE_PD20) {
> +        /* Invalid PDTP.MODE */
> +        return RISCV_IOMMU_FQ_CAUSE_PDT_MISCONFIGURED;
> +    }
> +
> +    for (depth =3D mode - RISCV_IOMMU_DC_FSC_PDTP_MODE_PD8; depth-- > 0;=
 ) {
> +        /*
> +         * Select process id index bits based on process directory tree
> +         * level. See IOMMU Specification, 2.2. Process-Directory-Table.
> +         */
> +        const int split =3D depth * 9 + 8;
> +        addr |=3D ((ctx->process_id >> split) << 3) & ~TARGET_PAGE_MASK;
> +        if (dma_memory_read(s->target_as, addr, &de, sizeof(de),
> +                            MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
> +            return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
> +        }
> +        le64_to_cpus(&de);
> +        if (!(de & RISCV_IOMMU_PC_TA_V)) {
> +            return RISCV_IOMMU_FQ_CAUSE_PDT_INVALID;
> +        }
> +        addr =3D PPN_PHYS(get_field(de, RISCV_IOMMU_PC_FSC_PPN));
> +    }
> +
> +    /* Leaf entry in PDT */
> +    addr |=3D (ctx->process_id << 4) & ~TARGET_PAGE_MASK;
> +    if (dma_memory_read(s->target_as, addr, &dc.ta, sizeof(uint64_t) * 2=
,
> +                        MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {
> +        return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
> +    }
> +
> +    /* Use FSC and TA from process directory entry. */
> +    ctx->ta =3D le64_to_cpu(dc.ta);
> +    ctx->satp =3D le64_to_cpu(dc.fsc);
> +
> +    if (!(ctx->ta & RISCV_IOMMU_PC_TA_V)) {
> +        return RISCV_IOMMU_FQ_CAUSE_PDT_INVALID;
> +    }
> +
> +    if (!riscv_iommu_validate_process_ctx(s, ctx)) {
> +        return RISCV_IOMMU_FQ_CAUSE_PDT_MISCONFIGURED;
> +    }
> +
> +    return 0;
> +}
> +
> +/* Translation Context cache support */
> +static gboolean __ctx_equal(gconstpointer v1, gconstpointer v2)
> +{
> +    RISCVIOMMUContext *c1 =3D (RISCVIOMMUContext *) v1;
> +    RISCVIOMMUContext *c2 =3D (RISCVIOMMUContext *) v2;
> +    return c1->devid =3D=3D c2->devid &&
> +           c1->process_id =3D=3D c2->process_id;
> +}
> +
> +static guint __ctx_hash(gconstpointer v)
> +{
> +    RISCVIOMMUContext *ctx =3D (RISCVIOMMUContext *) v;
> +    /*
> +     * Generate simple hash of (process_id, devid)
> +     * assuming 24-bit wide devid.
> +     */
> +    return (guint)(ctx->devid) + ((guint)(ctx->process_id) << 24);
> +}
> +
> +static void __ctx_inval_devid_procid(gpointer key, gpointer value,
> +                                     gpointer data)
> +{
> +    RISCVIOMMUContext *ctx =3D (RISCVIOMMUContext *) value;
> +    RISCVIOMMUContext *arg =3D (RISCVIOMMUContext *) data;
> +    if (ctx->tc & RISCV_IOMMU_DC_TC_V &&
> +        ctx->devid =3D=3D arg->devid &&
> +        ctx->process_id =3D=3D arg->process_id) {
> +        ctx->tc &=3D ~RISCV_IOMMU_DC_TC_V;
> +    }
> +}
> +
> +static void __ctx_inval_devid(gpointer key, gpointer value, gpointer dat=
a)
> +{
> +    RISCVIOMMUContext *ctx =3D (RISCVIOMMUContext *) value;
> +    RISCVIOMMUContext *arg =3D (RISCVIOMMUContext *) data;
> +    if (ctx->tc & RISCV_IOMMU_DC_TC_V &&
> +        ctx->devid =3D=3D arg->devid) {
> +        ctx->tc &=3D ~RISCV_IOMMU_DC_TC_V;
> +    }
> +}
> +
> +static void __ctx_inval_all(gpointer key, gpointer value, gpointer data)
> +{
> +    RISCVIOMMUContext *ctx =3D (RISCVIOMMUContext *) value;
> +    if (ctx->tc & RISCV_IOMMU_DC_TC_V) {
> +        ctx->tc &=3D ~RISCV_IOMMU_DC_TC_V;
> +    }
> +}
> +
> +static void riscv_iommu_ctx_inval(RISCVIOMMUState *s, GHFunc func,
> +                                  uint32_t devid, uint32_t process_id)
> +{
> +    GHashTable *ctx_cache;
> +    RISCVIOMMUContext key =3D {
> +        .devid =3D devid,
> +        .process_id =3D process_id,
> +    };
> +    ctx_cache =3D g_hash_table_ref(s->ctx_cache);
> +    qemu_mutex_lock(&s->ctx_lock);
> +    g_hash_table_foreach(ctx_cache, func, &key);
> +    qemu_mutex_unlock(&s->ctx_lock);
> +    g_hash_table_unref(ctx_cache);
> +}
> +
> +/* Find or allocate translation context for a given {device_id, process_=
id} */
> +static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
> +                                          unsigned devid, unsigned proce=
ss_id,
> +                                          void **ref)
> +{
> +    GHashTable *ctx_cache;
> +    RISCVIOMMUContext *ctx;
> +    RISCVIOMMUContext key =3D {
> +        .devid =3D devid,
> +        .process_id =3D process_id,
> +    };
> +
> +    ctx_cache =3D g_hash_table_ref(s->ctx_cache);
> +    qemu_mutex_lock(&s->ctx_lock);
> +    ctx =3D g_hash_table_lookup(ctx_cache, &key);
> +    qemu_mutex_unlock(&s->ctx_lock);
> +
> +    if (ctx && (ctx->tc & RISCV_IOMMU_DC_TC_V)) {
> +        *ref =3D ctx_cache;
> +        return ctx;
> +    }
> +
> +    ctx =3D g_new0(RISCVIOMMUContext, 1);
> +    ctx->devid =3D devid;
> +    ctx->process_id =3D process_id;
> +
> +    int fault =3D riscv_iommu_ctx_fetch(s, ctx);
> +    if (!fault) {
> +        qemu_mutex_lock(&s->ctx_lock);
> +        if (g_hash_table_size(ctx_cache) >=3D LIMIT_CACHE_CTX) {
> +            g_hash_table_unref(ctx_cache);
> +            ctx_cache =3D g_hash_table_new_full(__ctx_hash, __ctx_equal,
> +                                              g_free, NULL);
> +            g_hash_table_ref(ctx_cache);
> +            g_hash_table_unref(qatomic_xchg(&s->ctx_cache, ctx_cache));
> +        }
> +        g_hash_table_add(ctx_cache, ctx);
> +        qemu_mutex_unlock(&s->ctx_lock);
> +        *ref =3D ctx_cache;
> +        return ctx;
> +    }
> +
> +    g_hash_table_unref(ctx_cache);
> +    *ref =3D NULL;
> +
> +    riscv_iommu_report_fault(s, ctx, RISCV_IOMMU_FQ_TTYPE_UADDR_RD,
> +                             fault, !!process_id, 0, 0);
> +
> +    g_free(ctx);
> +    return NULL;
> +}
> +
> +static void riscv_iommu_ctx_put(RISCVIOMMUState *s, void *ref)
> +{
> +    if (ref) {
> +        g_hash_table_unref((GHashTable *)ref);
> +    }
> +}
> +
> +/* Find or allocate address space for a given device */
> +static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devi=
d)
> +{
> +    RISCVIOMMUSpace *as;
> +
> +    /* FIXME: PCIe bus remapping for attached endpoints. */
> +    devid |=3D s->bus << 8;
> +
> +    qemu_mutex_lock(&s->core_lock);
> +    QLIST_FOREACH(as, &s->spaces, list) {
> +        if (as->devid =3D=3D devid) {
> +            break;
> +        }
> +    }
> +    qemu_mutex_unlock(&s->core_lock);
> +
> +    if (as =3D=3D NULL) {
> +        char name[64];
> +        as =3D g_new0(RISCVIOMMUSpace, 1);
> +
> +        as->iommu =3D s;
> +        as->devid =3D devid;
> +
> +        snprintf(name, sizeof(name), "riscv-iommu-%04x:%02x.%d-iova",
> +            PCI_BUS_NUM(as->devid), PCI_SLOT(as->devid), PCI_FUNC(as->de=
vid));
> +
> +        /* IOVA address space, untranslated addresses */
> +        memory_region_init_iommu(&as->iova_mr, sizeof(as->iova_mr),
> +            TYPE_RISCV_IOMMU_MEMORY_REGION,
> +            OBJECT(as), "riscv_iommu", UINT64_MAX);
> +        address_space_init(&as->iova_as, MEMORY_REGION(&as->iova_mr), na=
me);
> +
> +        qemu_mutex_lock(&s->core_lock);
> +        QLIST_INSERT_HEAD(&s->spaces, as, list);
> +        qemu_mutex_unlock(&s->core_lock);
> +
> +        trace_riscv_iommu_new(s->parent_obj.id, PCI_BUS_NUM(as->devid),
> +                PCI_SLOT(as->devid), PCI_FUNC(as->devid));
> +    }
> +    return &as->iova_as;
> +}
> +
> +static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *=
ctx,
> +    IOMMUTLBEntry *iotlb)
> +{
> +    bool enable_pid;
> +    bool enable_pri;
> +    int fault;
> +
> +    /*
> +     * TC[32] is reserved for custom extensions, used here to temporaril=
y
> +     * enable automatic page-request generation for ATS queries.
> +     */
> +    enable_pri =3D (iotlb->perm =3D=3D IOMMU_NONE) && (ctx->tc & BIT_ULL=
(32));
> +    enable_pid =3D (ctx->tc & RISCV_IOMMU_DC_TC_PDTV);
> +
> +    /* Translate using device directory / page table information. */
> +    fault =3D riscv_iommu_spa_fetch(s, ctx, iotlb);
> +
> +    if (enable_pri && fault) {
> +        struct riscv_iommu_pq_record pr =3D {0};
> +        if (enable_pid) {
> +            pr.hdr =3D set_field(RISCV_IOMMU_PREQ_HDR_PV,
> +                               RISCV_IOMMU_PREQ_HDR_PID, ctx->process_id=
);
> +        }
> +        pr.hdr =3D set_field(pr.hdr, RISCV_IOMMU_PREQ_HDR_DID, ctx->devi=
d);
> +        pr.payload =3D (iotlb->iova & TARGET_PAGE_MASK) |
> +                     RISCV_IOMMU_PREQ_PAYLOAD_M;
> +        riscv_iommu_pri(s, &pr);
> +        return fault;
> +    }
> +
> +    if (fault) {
> +        unsigned ttype;
> +
> +        if (iotlb->perm & IOMMU_RW) {
> +            ttype =3D RISCV_IOMMU_FQ_TTYPE_UADDR_WR;
> +        } else {
> +            ttype =3D RISCV_IOMMU_FQ_TTYPE_UADDR_RD;
> +        }
> +
> +        riscv_iommu_report_fault(s, ctx, ttype, fault, enable_pid,
> +                                 iotlb->iova, iotlb->translated_addr);
> +        return fault;
> +    }
> +
> +    return 0;
> +}
> +
> +/* IOMMU Command Interface */
> +static MemTxResult riscv_iommu_iofence(RISCVIOMMUState *s, bool notify,
> +    uint64_t addr, uint32_t data)
> +{
> +    /*
> +     * ATS processing in this implementation of the IOMMU is synchronous=
,
> +     * no need to wait for completions here.
> +     */
> +    if (!notify) {
> +        return MEMTX_OK;
> +    }
> +
> +    return dma_memory_write(s->target_as, addr, &data, sizeof(data),
> +        MEMTXATTRS_UNSPECIFIED);
> +}
> +
> +static void riscv_iommu_process_ddtp(RISCVIOMMUState *s)
> +{
> +    uint64_t old_ddtp =3D s->ddtp;
> +    uint64_t new_ddtp =3D riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_DDTP)=
;
> +    unsigned new_mode =3D get_field(new_ddtp, RISCV_IOMMU_DDTP_MODE);
> +    unsigned old_mode =3D get_field(old_ddtp, RISCV_IOMMU_DDTP_MODE);
> +    bool ok =3D false;
> +
> +    /*
> +     * Check for allowed DDTP.MODE transitions:
> +     * {OFF, BARE}        -> {OFF, BARE, 1LVL, 2LVL, 3LVL}
> +     * {1LVL, 2LVL, 3LVL} -> {OFF, BARE}
> +     */
> +    if (new_mode =3D=3D old_mode ||
> +        new_mode =3D=3D RISCV_IOMMU_DDTP_MODE_OFF ||
> +        new_mode =3D=3D RISCV_IOMMU_DDTP_MODE_BARE) {
> +        ok =3D true;
> +    } else if (new_mode =3D=3D RISCV_IOMMU_DDTP_MODE_1LVL ||
> +               new_mode =3D=3D RISCV_IOMMU_DDTP_MODE_2LVL ||
> +               new_mode =3D=3D RISCV_IOMMU_DDTP_MODE_3LVL) {
> +        ok =3D old_mode =3D=3D RISCV_IOMMU_DDTP_MODE_OFF ||
> +             old_mode =3D=3D RISCV_IOMMU_DDTP_MODE_BARE;
> +    }
> +
> +    if (ok) {
> +        /* clear reserved and busy bits, report back sanitized version *=
/
> +        new_ddtp =3D set_field(new_ddtp & RISCV_IOMMU_DDTP_PPN,
> +                             RISCV_IOMMU_DDTP_MODE, new_mode);
> +    } else {
> +        new_ddtp =3D old_ddtp;
> +    }
> +    s->ddtp =3D new_ddtp;
> +
> +    riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_DDTP, new_ddtp);
> +}
> +
> +/* Command function and opcode field. */
> +#define RISCV_IOMMU_CMD(func, op) (((func) << 7) | (op))
> +
> +static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
> +{
> +    struct riscv_iommu_command cmd;
> +    MemTxResult res;
> +    dma_addr_t addr;
> +    uint32_t tail, head, ctrl;
> +    uint64_t cmd_opcode;
> +    GHFunc func;
> +
> +    ctrl =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQCSR);
> +    tail =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQT) & s->cq_mask;
> +    head =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQH) & s->cq_mask;
> +
> +    /* Check for pending error or queue processing disabled */
> +    if (!(ctrl & RISCV_IOMMU_CQCSR_CQON) ||
> +        !!(ctrl & (RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_CQMF)))=
 {
> +        return;
> +    }
> +
> +    while (tail !=3D head) {
> +        addr =3D s->cq_addr  + head * sizeof(cmd);
> +        res =3D dma_memory_read(s->target_as, addr, &cmd, sizeof(cmd),
> +                              MEMTXATTRS_UNSPECIFIED);
> +
> +        if (res !=3D MEMTX_OK) {
> +            riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQCSR,
> +                                  RISCV_IOMMU_CQCSR_CQMF, 0);
> +            goto fault;
> +        }
> +
> +        trace_riscv_iommu_cmd(s->parent_obj.id, cmd.dword0, cmd.dword1);
> +
> +        cmd_opcode =3D get_field(cmd.dword0,
> +                               RISCV_IOMMU_CMD_OPCODE | RISCV_IOMMU_CMD_=
FUNC);
> +
> +        switch (cmd_opcode) {
> +        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOFENCE_FUNC_C,
> +                             RISCV_IOMMU_CMD_IOFENCE_OPCODE):
> +            res =3D riscv_iommu_iofence(s,
> +                cmd.dword0 & RISCV_IOMMU_CMD_IOFENCE_AV, cmd.dword1,
> +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOFENCE_DATA));
> +
> +            if (res !=3D MEMTX_OK) {
> +                riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQCSR,
> +                                      RISCV_IOMMU_CQCSR_CQMF, 0);
> +                goto fault;
> +            }
> +            break;
> +
> +        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA,
> +                             RISCV_IOMMU_CMD_IOTINVAL_OPCODE):
> +            if (cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV) {
> +                /* illegal command arguments IOTINVAL.GVMA & PSCV =3D=3D=
 1 */
> +                goto cmd_ill;
> +            }
> +            /* translation cache not implemented yet */
> +            break;
> +
> +        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA,
> +                             RISCV_IOMMU_CMD_IOTINVAL_OPCODE):
> +            /* translation cache not implemented yet */
> +            break;
> +
> +        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_DDT,
> +                             RISCV_IOMMU_CMD_IODIR_OPCODE):
> +            if (!(cmd.dword0 & RISCV_IOMMU_CMD_IODIR_DV)) {
> +                /* invalidate all device context cache mappings */
> +                func =3D __ctx_inval_all;
> +            } else {
> +                /* invalidate all device context matching DID */
> +                func =3D __ctx_inval_devid;
> +            }
> +            riscv_iommu_ctx_inval(s, func,
> +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IODIR_DID), 0);
> +            break;
> +
> +        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_PDT,
> +                             RISCV_IOMMU_CMD_IODIR_OPCODE):
> +            if (!(cmd.dword0 & RISCV_IOMMU_CMD_IODIR_DV)) {
> +                /* illegal command arguments IODIR_PDT & DV =3D=3D 0 */
> +                goto cmd_ill;
> +            } else {
> +                func =3D __ctx_inval_devid_procid;
> +            }
> +            riscv_iommu_ctx_inval(s, func,
> +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IODIR_DID),
> +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IODIR_PID));
> +            break;
> +
> +        default:
> +        cmd_ill:
> +            /* Invalid instruction, do not advance instruction index. */
> +            riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQCSR,
> +                RISCV_IOMMU_CQCSR_CMD_ILL, 0);
> +            goto fault;
> +        }
> +
> +        /* Advance and update head pointer after command completes. */
> +        head =3D (head + 1) & s->cq_mask;
> +        riscv_iommu_reg_set32(s, RISCV_IOMMU_REG_CQH, head);
> +    }
> +    return;
> +
> +fault:
> +    if (ctrl & RISCV_IOMMU_CQCSR_CIE) {
> +        riscv_iommu_notify(s, RISCV_IOMMU_INTR_CQ);
> +    }
> +}
> +
> +static void riscv_iommu_process_cq_control(RISCVIOMMUState *s)
> +{
> +    uint64_t base;
> +    uint32_t ctrl_set =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQCSR=
);
> +    uint32_t ctrl_clr;
> +    bool enable =3D !!(ctrl_set & RISCV_IOMMU_CQCSR_CQEN);
> +    bool active =3D !!(ctrl_set & RISCV_IOMMU_CQCSR_CQON);
> +
> +    if (enable && !active) {
> +        base =3D riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_CQB);
> +        s->cq_mask =3D (2ULL << get_field(base, RISCV_IOMMU_CQB_LOG2SZ))=
 - 1;
> +        s->cq_addr =3D PPN_PHYS(get_field(base, RISCV_IOMMU_CQB_PPN));
> +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQT], ~s->cq_mask);
> +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_CQH], 0);
> +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_CQT], 0);
> +        ctrl_set =3D RISCV_IOMMU_CQCSR_CQON;
> +        ctrl_clr =3D RISCV_IOMMU_CQCSR_BUSY | RISCV_IOMMU_CQCSR_CQMF |
> +                   RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_CMD_TO =
|
> +                   RISCV_IOMMU_CQCSR_FENCE_W_IP;
> +    } else if (!enable && active) {
> +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQT], ~0);
> +        ctrl_set =3D 0;
> +        ctrl_clr =3D RISCV_IOMMU_CQCSR_BUSY | RISCV_IOMMU_CQCSR_CQON;
> +    } else {
> +        ctrl_set =3D 0;
> +        ctrl_clr =3D RISCV_IOMMU_CQCSR_BUSY;
> +    }
> +
> +    riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQCSR, ctrl_set, ctrl_clr);
> +}
> +
> +static void riscv_iommu_process_fq_control(RISCVIOMMUState *s)
> +{
> +    uint64_t base;
> +    uint32_t ctrl_set =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQCSR=
);
> +    uint32_t ctrl_clr;
> +    bool enable =3D !!(ctrl_set & RISCV_IOMMU_FQCSR_FQEN);
> +    bool active =3D !!(ctrl_set & RISCV_IOMMU_FQCSR_FQON);
> +
> +    if (enable && !active) {
> +        base =3D riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_FQB);
> +        s->fq_mask =3D (2ULL << get_field(base, RISCV_IOMMU_FQB_LOG2SZ))=
 - 1;
> +        s->fq_addr =3D PPN_PHYS(get_field(base, RISCV_IOMMU_FQB_PPN));
> +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_FQH], ~s->fq_mask);
> +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_FQH], 0);
> +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_FQT], 0);
> +        ctrl_set =3D RISCV_IOMMU_FQCSR_FQON;
> +        ctrl_clr =3D RISCV_IOMMU_FQCSR_BUSY | RISCV_IOMMU_FQCSR_FQMF |
> +            RISCV_IOMMU_FQCSR_FQOF;
> +    } else if (!enable && active) {
> +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_FQH], ~0);
> +        ctrl_set =3D 0;
> +        ctrl_clr =3D RISCV_IOMMU_FQCSR_BUSY | RISCV_IOMMU_FQCSR_FQON;
> +    } else {
> +        ctrl_set =3D 0;
> +        ctrl_clr =3D RISCV_IOMMU_FQCSR_BUSY;
> +    }
> +
> +    riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_FQCSR, ctrl_set, ctrl_clr);
> +}
> +
> +static void riscv_iommu_process_pq_control(RISCVIOMMUState *s)
> +{
> +    uint64_t base;
> +    uint32_t ctrl_set =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQCSR=
);
> +    uint32_t ctrl_clr;
> +    bool enable =3D !!(ctrl_set & RISCV_IOMMU_PQCSR_PQEN);
> +    bool active =3D !!(ctrl_set & RISCV_IOMMU_PQCSR_PQON);
> +
> +    if (enable && !active) {
> +        base =3D riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_PQB);
> +        s->pq_mask =3D (2ULL << get_field(base, RISCV_IOMMU_PQB_LOG2SZ))=
 - 1;
> +        s->pq_addr =3D PPN_PHYS(get_field(base, RISCV_IOMMU_PQB_PPN));
> +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_PQH], ~s->pq_mask);
> +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_PQH], 0);
> +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_PQT], 0);
> +        ctrl_set =3D RISCV_IOMMU_PQCSR_PQON;
> +        ctrl_clr =3D RISCV_IOMMU_PQCSR_BUSY | RISCV_IOMMU_PQCSR_PQMF |
> +            RISCV_IOMMU_PQCSR_PQOF;
> +    } else if (!enable && active) {
> +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_PQH], ~0);
> +        ctrl_set =3D 0;
> +        ctrl_clr =3D RISCV_IOMMU_PQCSR_BUSY | RISCV_IOMMU_PQCSR_PQON;
> +    } else {
> +        ctrl_set =3D 0;
> +        ctrl_clr =3D RISCV_IOMMU_PQCSR_BUSY;
> +    }
> +
> +    riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_PQCSR, ctrl_set, ctrl_clr);
> +}
> +
> +static void riscv_iommu_process_icvec_update(RISCVIOMMUState *s)
> +{
> +    uint32_t icvec =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_ICVEC);
> +
> +    s->icvec_update(s,
> +                    riscv_iommu_get_icvec_vector(icvec, RISCV_IOMMU_INTR=
_CQ),
> +                    riscv_iommu_get_icvec_vector(icvec, RISCV_IOMMU_INTR=
_FQ),
> +                    riscv_iommu_get_icvec_vector(icvec, RISCV_IOMMU_INTR=
_PM),
> +                    riscv_iommu_get_icvec_vector(icvec, RISCV_IOMMU_INTR=
_PQ));
> +}
> +
> +typedef void riscv_iommu_process_fn(RISCVIOMMUState *s);
> +
> +static void riscv_iommu_update_ipsr(RISCVIOMMUState *s, uint64_t data)
> +{
> +    uint32_t cqcsr, fqcsr, pqcsr;
> +    uint32_t ipsr_set =3D 0;
> +    uint32_t ipsr_clr =3D 0;
> +
> +    if (data & RISCV_IOMMU_IPSR_CIP) {
> +        cqcsr =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQCSR);
> +
> +        if (cqcsr & RISCV_IOMMU_CQCSR_CIE &&
> +            (cqcsr & RISCV_IOMMU_CQCSR_FENCE_W_IP ||
> +             cqcsr & RISCV_IOMMU_CQCSR_CMD_ILL ||
> +             cqcsr & RISCV_IOMMU_CQCSR_CMD_TO ||
> +             cqcsr & RISCV_IOMMU_CQCSR_CQMF)) {
> +            ipsr_set |=3D RISCV_IOMMU_IPSR_CIP;
> +        } else {
> +            ipsr_clr |=3D RISCV_IOMMU_IPSR_CIP;
> +        }
> +    } else {
> +        ipsr_clr |=3D RISCV_IOMMU_IPSR_CIP;
> +    }
> +
> +    if (data & RISCV_IOMMU_IPSR_FIP) {
> +        fqcsr =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQCSR);
> +
> +        if (fqcsr & RISCV_IOMMU_FQCSR_FIE &&
> +            (fqcsr & RISCV_IOMMU_FQCSR_FQOF ||
> +             fqcsr & RISCV_IOMMU_FQCSR_FQMF)) {
> +            ipsr_set |=3D RISCV_IOMMU_IPSR_FIP;
> +        } else {
> +            ipsr_clr |=3D RISCV_IOMMU_IPSR_FIP;
> +        }
> +    } else {
> +        ipsr_clr |=3D RISCV_IOMMU_IPSR_FIP;
> +    }
> +
> +    if (data & RISCV_IOMMU_IPSR_PIP) {
> +        pqcsr =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQCSR);
> +
> +        if (pqcsr & RISCV_IOMMU_PQCSR_PIE &&
> +            (pqcsr & RISCV_IOMMU_PQCSR_PQOF ||
> +             pqcsr & RISCV_IOMMU_PQCSR_PQMF)) {
> +            ipsr_set |=3D RISCV_IOMMU_IPSR_PIP;
> +        } else {
> +            ipsr_clr |=3D RISCV_IOMMU_IPSR_PIP;
> +        }
> +    } else {
> +        ipsr_clr |=3D RISCV_IOMMU_IPSR_PIP;
> +    }
> +
> +    riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_IPSR, ipsr_set, ipsr_clr);
> +}
> +
> +static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
> +    uint64_t data, unsigned size, MemTxAttrs attrs)
> +{
> +    riscv_iommu_process_fn *process_fn =3D NULL;
> +    RISCVIOMMUState *s =3D opaque;
> +    uint32_t regb =3D addr & ~3;
> +    uint32_t busy =3D 0;
> +    uint64_t val =3D 0;
> +
> +    if ((addr & (size - 1)) !=3D 0) {
> +        /* Unsupported MMIO alignment or access size */
> +        return MEMTX_ERROR;
> +    }
> +
> +    if (addr + size > RISCV_IOMMU_REG_MSI_CONFIG) {
> +        /* Unsupported MMIO access location. */
> +        return MEMTX_ACCESS_ERROR;
> +    }
> +
> +    /* Track actionable MMIO write. */
> +    switch (regb) {
> +    case RISCV_IOMMU_REG_DDTP:
> +    case RISCV_IOMMU_REG_DDTP + 4:
> +        process_fn =3D riscv_iommu_process_ddtp;
> +        regb =3D RISCV_IOMMU_REG_DDTP;
> +        busy =3D RISCV_IOMMU_DDTP_BUSY;
> +        break;
> +
> +    case RISCV_IOMMU_REG_CQT:
> +        process_fn =3D riscv_iommu_process_cq_tail;
> +        break;
> +
> +    case RISCV_IOMMU_REG_CQCSR:
> +        process_fn =3D riscv_iommu_process_cq_control;
> +        busy =3D RISCV_IOMMU_CQCSR_BUSY;
> +        break;
> +
> +    case RISCV_IOMMU_REG_FQCSR:
> +        process_fn =3D riscv_iommu_process_fq_control;
> +        busy =3D RISCV_IOMMU_FQCSR_BUSY;
> +        break;
> +
> +    case RISCV_IOMMU_REG_PQCSR:
> +        process_fn =3D riscv_iommu_process_pq_control;
> +        busy =3D RISCV_IOMMU_PQCSR_BUSY;
> +        break;
> +
> +    case RISCV_IOMMU_REG_ICVEC:
> +        process_fn =3D riscv_iommu_process_icvec_update;
> +        break;
> +
> +    case RISCV_IOMMU_REG_IPSR:
> +        /*
> +         * IPSR has special procedures to update. Execute it
> +         * and exit.
> +         */
> +        if (size =3D=3D 4) {
> +            uint32_t ro =3D ldl_le_p(&s->regs_ro[addr]);
> +            uint32_t wc =3D ldl_le_p(&s->regs_wc[addr]);
> +            uint32_t rw =3D ldl_le_p(&s->regs_rw[addr]);
> +            stl_le_p(&val, ((rw & ro) | (data & ~ro)) & ~(data & wc));
> +        } else if (size =3D=3D 8) {
> +            uint64_t ro =3D ldq_le_p(&s->regs_ro[addr]);
> +            uint64_t wc =3D ldq_le_p(&s->regs_wc[addr]);
> +            uint64_t rw =3D ldq_le_p(&s->regs_rw[addr]);
> +            stq_le_p(&val, ((rw & ro) | (data & ~ro)) & ~(data & wc));
> +        }
> +
> +        riscv_iommu_update_ipsr(s, val);
> +
> +        return MEMTX_OK;
> +
> +    default:
> +        break;
> +    }
> +
> +    /*
> +     * Registers update might be not synchronized with core logic.
> +     * If system software updates register when relevant BUSY bit
> +     * is set IOMMU behavior of additional writes to the register
> +     * is UNSPECIFIED.
> +     */
> +    qemu_spin_lock(&s->regs_lock);
> +    if (size =3D=3D 1) {
> +        uint8_t ro =3D s->regs_ro[addr];
> +        uint8_t wc =3D s->regs_wc[addr];
> +        uint8_t rw =3D s->regs_rw[addr];
> +        s->regs_rw[addr] =3D ((rw & ro) | (data & ~ro)) & ~(data & wc);
> +    } else if (size =3D=3D 2) {
> +        uint16_t ro =3D lduw_le_p(&s->regs_ro[addr]);
> +        uint16_t wc =3D lduw_le_p(&s->regs_wc[addr]);
> +        uint16_t rw =3D lduw_le_p(&s->regs_rw[addr]);
> +        stw_le_p(&s->regs_rw[addr], ((rw & ro) | (data & ~ro)) & ~(data =
& wc));
> +    } else if (size =3D=3D 4) {
> +        uint32_t ro =3D ldl_le_p(&s->regs_ro[addr]);
> +        uint32_t wc =3D ldl_le_p(&s->regs_wc[addr]);
> +        uint32_t rw =3D ldl_le_p(&s->regs_rw[addr]);
> +        stl_le_p(&s->regs_rw[addr], ((rw & ro) | (data & ~ro)) & ~(data =
& wc));
> +    } else if (size =3D=3D 8) {
> +        uint64_t ro =3D ldq_le_p(&s->regs_ro[addr]);
> +        uint64_t wc =3D ldq_le_p(&s->regs_wc[addr]);
> +        uint64_t rw =3D ldq_le_p(&s->regs_rw[addr]);
> +        stq_le_p(&s->regs_rw[addr], ((rw & ro) | (data & ~ro)) & ~(data =
& wc));
> +    }
> +
> +    /* Busy flag update, MSB 4-byte register. */
> +    if (busy) {
> +        uint32_t rw =3D ldl_le_p(&s->regs_rw[regb]);
> +        stl_le_p(&s->regs_rw[regb], rw | busy);
> +    }
> +    qemu_spin_unlock(&s->regs_lock);
> +
> +    if (process_fn) {
> +        qemu_mutex_lock(&s->core_lock);
> +        process_fn(s);
> +        qemu_mutex_unlock(&s->core_lock);
> +    }
> +
> +    return MEMTX_OK;
> +}
> +
> +static MemTxResult riscv_iommu_mmio_read(void *opaque, hwaddr addr,
> +    uint64_t *data, unsigned size, MemTxAttrs attrs)
> +{
> +    RISCVIOMMUState *s =3D opaque;
> +    uint64_t val =3D -1;
> +    uint8_t *ptr;
> +
> +    if ((addr & (size - 1)) !=3D 0) {
> +        /* Unsupported MMIO alignment. */
> +        return MEMTX_ERROR;
> +    }
> +
> +    if (addr + size > RISCV_IOMMU_REG_MSI_CONFIG) {
> +        return MEMTX_ACCESS_ERROR;
> +    }
> +
> +    ptr =3D &s->regs_rw[addr];
> +
> +    if (size =3D=3D 1) {
> +        val =3D (uint64_t)*ptr;
> +    } else if (size =3D=3D 2) {
> +        val =3D lduw_le_p(ptr);
> +    } else if (size =3D=3D 4) {
> +        val =3D ldl_le_p(ptr);
> +    } else if (size =3D=3D 8) {
> +        val =3D ldq_le_p(ptr);
> +    } else {
> +        return MEMTX_ERROR;
> +    }
> +
> +    *data =3D val;
> +
> +    return MEMTX_OK;
> +}
> +
> +static const MemoryRegionOps riscv_iommu_mmio_ops =3D {
> +    .read_with_attrs =3D riscv_iommu_mmio_read,
> +    .write_with_attrs =3D riscv_iommu_mmio_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .impl =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 8,
> +        .unaligned =3D false,
> +    },
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 8,
> +    }
> +};
> +
> +/*
> + * Translations matching MSI pattern check are redirected to "riscv-iomm=
u-trap"
> + * memory region as untranslated address, for additional MSI/MRIF interc=
eption
> + * by IOMMU interrupt remapping implementation.
> + * Note: Device emulation code generating an MSI is expected to provide =
a valid
> + * memory transaction attributes with requested_id set.
> + */
> +static MemTxResult riscv_iommu_trap_write(void *opaque, hwaddr addr,
> +    uint64_t data, unsigned size, MemTxAttrs attrs)
> +{
> +    RISCVIOMMUState* s =3D (RISCVIOMMUState *)opaque;
> +    RISCVIOMMUContext *ctx;
> +    MemTxResult res;
> +    void *ref;
> +    uint32_t devid =3D attrs.requester_id;
> +
> +    if (attrs.unspecified) {
> +        return MEMTX_ACCESS_ERROR;
> +    }
> +
> +    /* FIXME: PCIe bus remapping for attached endpoints. */
> +    devid |=3D s->bus << 8;
> +
> +    ctx =3D riscv_iommu_ctx(s, devid, 0, &ref);
> +    if (ctx =3D=3D NULL) {
> +        res =3D MEMTX_ACCESS_ERROR;
> +    } else {
> +        res =3D riscv_iommu_msi_write(s, ctx, addr, data, size, attrs);
> +    }
> +    riscv_iommu_ctx_put(s, ref);
> +    return res;
> +}
> +
> +static MemTxResult riscv_iommu_trap_read(void *opaque, hwaddr addr,
> +    uint64_t *data, unsigned size, MemTxAttrs attrs)
> +{
> +    return MEMTX_ACCESS_ERROR;
> +}
> +
> +static const MemoryRegionOps riscv_iommu_trap_ops =3D {
> +    .read_with_attrs =3D riscv_iommu_trap_read,
> +    .write_with_attrs =3D riscv_iommu_trap_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .impl =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 8,
> +        .unaligned =3D true,
> +    },
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 8,
> +    }
> +};
> +
> +static void riscv_iommu_realize(DeviceState *dev, Error **errp)
> +{
> +    RISCVIOMMUState *s =3D RISCV_IOMMU(dev);
> +
> +    s->cap =3D s->version & RISCV_IOMMU_CAP_VERSION;
> +    if (s->enable_msi) {
> +        s->cap |=3D RISCV_IOMMU_CAP_MSI_FLAT | RISCV_IOMMU_CAP_MSI_MRIF;
> +    }
> +    if (s->enable_s_stage) {
> +        s->cap |=3D RISCV_IOMMU_CAP_SV32 | RISCV_IOMMU_CAP_SV39 |
> +                  RISCV_IOMMU_CAP_SV48 | RISCV_IOMMU_CAP_SV57;
> +    }
> +    if (s->enable_g_stage) {
> +        s->cap |=3D RISCV_IOMMU_CAP_SV32X4 | RISCV_IOMMU_CAP_SV39X4 |
> +                  RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4;
> +    }
> +    /* Report QEMU target physical address space limits */
> +    s->cap =3D set_field(s->cap, RISCV_IOMMU_CAP_PAS,
> +                       TARGET_PHYS_ADDR_SPACE_BITS);
> +
> +    /* TODO: method to report supported PID bits */
> +    s->pid_bits =3D 8; /* restricted to size of MemTxAttrs.pid */
> +    s->cap |=3D RISCV_IOMMU_CAP_PD8;
> +
> +    /* Out-of-reset translation mode: OFF (DMA disabled) BARE (passthrou=
gh) */
> +    s->ddtp =3D set_field(0, RISCV_IOMMU_DDTP_MODE, s->enable_off ?
> +                        RISCV_IOMMU_DDTP_MODE_OFF : RISCV_IOMMU_DDTP_MOD=
E_BARE);
> +
> +    /* register storage */
> +    s->regs_rw =3D g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
> +    s->regs_ro =3D g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
> +    s->regs_wc =3D g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
> +
> +     /* Mark all registers read-only */
> +    memset(s->regs_ro, 0xff, RISCV_IOMMU_REG_SIZE);
> +
> +    /*
> +     * Register complete MMIO space, including MSI/PBA registers.
> +     * Note, PCIDevice implementation will add overlapping MR for MSI/PB=
A,
> +     * managed directly by the PCIDevice implementation.
> +     */
> +    memory_region_init_io(&s->regs_mr, OBJECT(dev), &riscv_iommu_mmio_op=
s, s,
> +        "riscv-iommu-regs", RISCV_IOMMU_REG_SIZE);
> +
> +    /* Set power-on register state */
> +    stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_CAP], s->cap);
> +    stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_FCTL], 0);
> +    stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_FCTL],
> +             ~(RISCV_IOMMU_FCTL_BE | RISCV_IOMMU_FCTL_WSI));
> +    stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_DDTP],
> +        ~(RISCV_IOMMU_DDTP_PPN | RISCV_IOMMU_DDTP_MODE));
> +    stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQB],
> +        ~(RISCV_IOMMU_CQB_LOG2SZ | RISCV_IOMMU_CQB_PPN));
> +    stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_FQB],
> +        ~(RISCV_IOMMU_FQB_LOG2SZ | RISCV_IOMMU_FQB_PPN));
> +    stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_PQB],
> +        ~(RISCV_IOMMU_PQB_LOG2SZ | RISCV_IOMMU_PQB_PPN));
> +    stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_CQCSR], RISCV_IOMMU_CQCSR_CQMF =
|
> +        RISCV_IOMMU_CQCSR_CMD_TO | RISCV_IOMMU_CQCSR_CMD_ILL);
> +    stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQCSR], RISCV_IOMMU_CQCSR_CQON =
|
> +        RISCV_IOMMU_CQCSR_BUSY);
> +    stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_FQCSR], RISCV_IOMMU_FQCSR_FQMF =
|
> +        RISCV_IOMMU_FQCSR_FQOF);
> +    stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_FQCSR], RISCV_IOMMU_FQCSR_FQON =
|
> +        RISCV_IOMMU_FQCSR_BUSY);
> +    stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_PQCSR], RISCV_IOMMU_PQCSR_PQMF =
|
> +        RISCV_IOMMU_PQCSR_PQOF);
> +    stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_PQCSR], RISCV_IOMMU_PQCSR_PQON =
|
> +        RISCV_IOMMU_PQCSR_BUSY);
> +    stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_IPSR], ~0);
> +    stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_ICVEC], 0);
> +    stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_DDTP], s->ddtp);
> +
> +    /* Memory region for downstream access, if specified. */
> +    if (s->target_mr) {
> +        s->target_as =3D g_new0(AddressSpace, 1);
> +        address_space_init(s->target_as, s->target_mr,
> +            "riscv-iommu-downstream");
> +    } else {
> +        /* Fallback to global system memory. */
> +        s->target_as =3D &address_space_memory;
> +    }
> +
> +    /* Memory region for untranslated MRIF/MSI writes */
> +    memory_region_init_io(&s->trap_mr, OBJECT(dev), &riscv_iommu_trap_op=
s, s,
> +            "riscv-iommu-trap", ~0ULL);
> +    address_space_init(&s->trap_as, &s->trap_mr, "riscv-iommu-trap-as");
> +
> +    /* Device translation context cache */
> +    s->ctx_cache =3D g_hash_table_new_full(__ctx_hash, __ctx_equal,
> +                                         g_free, NULL);
> +    qemu_mutex_init(&s->ctx_lock);
> +
> +    s->iommus.le_next =3D NULL;
> +    s->iommus.le_prev =3D NULL;
> +    QLIST_INIT(&s->spaces);
> +    qemu_mutex_init(&s->core_lock);
> +    qemu_spin_init(&s->regs_lock);
> +}
> +
> +static void riscv_iommu_unrealize(DeviceState *dev)
> +{
> +    RISCVIOMMUState *s =3D RISCV_IOMMU(dev);
> +
> +    qemu_mutex_destroy(&s->core_lock);
> +    g_hash_table_unref(s->ctx_cache);
> +}
> +
> +static Property riscv_iommu_properties[] =3D {
> +    DEFINE_PROP_UINT32("version", RISCVIOMMUState, version,
> +        RISCV_IOMMU_SPEC_DOT_VER),
> +    DEFINE_PROP_UINT32("bus", RISCVIOMMUState, bus, 0x0),
> +    DEFINE_PROP_BOOL("intremap", RISCVIOMMUState, enable_msi, TRUE),
> +    DEFINE_PROP_BOOL("off", RISCVIOMMUState, enable_off, TRUE),
> +    DEFINE_PROP_BOOL("s-stage", RISCVIOMMUState, enable_s_stage, TRUE),
> +    DEFINE_PROP_BOOL("g-stage", RISCVIOMMUState, enable_g_stage, TRUE),
> +    DEFINE_PROP_LINK("downstream-mr", RISCVIOMMUState, target_mr,
> +        TYPE_MEMORY_REGION, MemoryRegion *),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void riscv_iommu_class_init(ObjectClass *klass, void* data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    /* internal device for riscv-iommu-{pci/sys}, not user-creatable */
> +    dc->user_creatable =3D false;
> +    dc->realize =3D riscv_iommu_realize;
> +    dc->unrealize =3D riscv_iommu_unrealize;
> +    device_class_set_props(dc, riscv_iommu_properties);
> +}
> +
> +static const TypeInfo riscv_iommu_info =3D {
> +    .name =3D TYPE_RISCV_IOMMU,
> +    .parent =3D TYPE_DEVICE,
> +    .instance_size =3D sizeof(RISCVIOMMUState),
> +    .class_init =3D riscv_iommu_class_init,
> +};
> +
> +static const char *IOMMU_FLAG_STR[] =3D {
> +    "NA",
> +    "RO",
> +    "WR",
> +    "RW",
> +};
> +
> +/* RISC-V IOMMU Memory Region - Address Translation Space */
> +static IOMMUTLBEntry riscv_iommu_memory_region_translate(
> +    IOMMUMemoryRegion *iommu_mr, hwaddr addr,
> +    IOMMUAccessFlags flag, int iommu_idx)
> +{
> +    RISCVIOMMUSpace *as =3D container_of(iommu_mr, RISCVIOMMUSpace, iova=
_mr);
> +    RISCVIOMMUContext *ctx;
> +    void *ref;
> +    IOMMUTLBEntry iotlb =3D {
> +        .iova =3D addr,
> +        .target_as =3D as->iommu->target_as,
> +        .addr_mask =3D ~0ULL,
> +        .perm =3D flag,
> +    };
> +
> +    ctx =3D riscv_iommu_ctx(as->iommu, as->devid, iommu_idx, &ref);
> +    if (ctx =3D=3D NULL) {
> +        /* Translation disabled or invalid. */
> +        iotlb.addr_mask =3D 0;
> +        iotlb.perm =3D IOMMU_NONE;
> +    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb)) {
> +        /* Translation disabled or fault reported. */
> +        iotlb.addr_mask =3D 0;
> +        iotlb.perm =3D IOMMU_NONE;
> +    }
> +
> +    /* Trace all dma translations with original access flags. */
> +    trace_riscv_iommu_dma(as->iommu->parent_obj.id, PCI_BUS_NUM(as->devi=
d),
> +                          PCI_SLOT(as->devid), PCI_FUNC(as->devid), iomm=
u_idx,
> +                          IOMMU_FLAG_STR[flag & IOMMU_RW], iotlb.iova,
> +                          iotlb.translated_addr);
> +
> +    riscv_iommu_ctx_put(as->iommu, ref);
> +
> +    return iotlb;
> +}
> +
> +static int riscv_iommu_memory_region_notify(
> +    IOMMUMemoryRegion *iommu_mr, IOMMUNotifierFlag old,
> +    IOMMUNotifierFlag new, Error **errp)
> +{
> +    RISCVIOMMUSpace *as =3D container_of(iommu_mr, RISCVIOMMUSpace, iova=
_mr);
> +
> +    if (old =3D=3D IOMMU_NOTIFIER_NONE) {
> +        as->notifier =3D true;
> +        trace_riscv_iommu_notifier_add(iommu_mr->parent_obj.name);
> +    } else if (new =3D=3D IOMMU_NOTIFIER_NONE) {
> +        as->notifier =3D false;
> +        trace_riscv_iommu_notifier_del(iommu_mr->parent_obj.name);
> +    }
> +
> +    return 0;
> +}
> +
> +static inline bool pci_is_iommu(PCIDevice *pdev)
> +{
> +    return pci_get_word(pdev->config + PCI_CLASS_DEVICE) =3D=3D 0x0806;
> +}
> +
> +static AddressSpace *riscv_iommu_find_as(PCIBus *bus, void *opaque, int =
devfn)
> +{
> +    RISCVIOMMUState *s =3D (RISCVIOMMUState *) opaque;
> +    PCIDevice *pdev =3D pci_find_device(bus, pci_bus_num(bus), devfn);
> +    AddressSpace *as =3D NULL;
> +
> +    if (pdev && pci_is_iommu(pdev)) {
> +        return s->target_as;
> +    }
> +
> +    /* Find first registered IOMMU device */
> +    while (s->iommus.le_prev) {
> +        s =3D *(s->iommus.le_prev);
> +    }
> +
> +    /* Find first matching IOMMU */
> +    while (s !=3D NULL && as =3D=3D NULL) {
> +        as =3D riscv_iommu_space(s, PCI_BUILD_BDF(pci_bus_num(bus), devf=
n));
> +        s =3D s->iommus.le_next;
> +    }
> +
> +    return as ? as : &address_space_memory;
> +}
> +
> +static const PCIIOMMUOps riscv_iommu_ops =3D {
> +    .get_address_space =3D riscv_iommu_find_as,
> +};
> +
> +void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
> +        Error **errp)
> +{
> +    if (bus->iommu_ops &&
> +        bus->iommu_ops->get_address_space =3D=3D riscv_iommu_find_as) {
> +        /* Allow multiple IOMMUs on the same PCIe bus, link known device=
s */
> +        RISCVIOMMUState *last =3D (RISCVIOMMUState *)bus->iommu_opaque;
> +        QLIST_INSERT_AFTER(last, iommu, iommus);
> +    } else if (!bus->iommu_ops && !bus->iommu_opaque) {
> +        pci_setup_iommu(bus, &riscv_iommu_ops, iommu);
> +    } else {
> +        error_setg(errp, "can't register secondary IOMMU for PCI bus #%d=
",
> +            pci_bus_num(bus));
> +    }
> +}
> +
> +static int riscv_iommu_memory_region_index(IOMMUMemoryRegion *iommu_mr,
> +    MemTxAttrs attrs)
> +{
> +    return attrs.unspecified ? RISCV_IOMMU_NOPROCID : (int)attrs.pid;
> +}
> +
> +static int riscv_iommu_memory_region_index_len(IOMMUMemoryRegion *iommu_=
mr)
> +{
> +    RISCVIOMMUSpace *as =3D container_of(iommu_mr, RISCVIOMMUSpace, iova=
_mr);
> +    return 1 << as->iommu->pid_bits;
> +}
> +
> +static void riscv_iommu_memory_region_init(ObjectClass *klass, void *dat=
a)
> +{
> +    IOMMUMemoryRegionClass *imrc =3D IOMMU_MEMORY_REGION_CLASS(klass);
> +
> +    imrc->translate =3D riscv_iommu_memory_region_translate;
> +    imrc->notify_flag_changed =3D riscv_iommu_memory_region_notify;
> +    imrc->attrs_to_index =3D riscv_iommu_memory_region_index;
> +    imrc->num_indexes =3D riscv_iommu_memory_region_index_len;
> +}
> +
> +static const TypeInfo riscv_iommu_memory_region_info =3D {
> +    .parent =3D TYPE_IOMMU_MEMORY_REGION,
> +    .name =3D TYPE_RISCV_IOMMU_MEMORY_REGION,
> +    .class_init =3D riscv_iommu_memory_region_init,
> +};
> +
> +static void riscv_iommu_register_mr_types(void)
> +{
> +    type_register_static(&riscv_iommu_memory_region_info);
> +    type_register_static(&riscv_iommu_info);
> +}
> +
> +type_init(riscv_iommu_register_mr_types);
> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> new file mode 100644
> index 0000000000..6d76cb9b1a
> --- /dev/null
> +++ b/hw/riscv/riscv-iommu.h
> @@ -0,0 +1,148 @@
> +/*
> + * QEMU emulation of an RISC-V IOMMU
> + *
> + * Copyright (C) 2022-2023 Rivos Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_RISCV_IOMMU_STATE_H
> +#define HW_RISCV_IOMMU_STATE_H
> +
> +#include "qemu/osdep.h"
> +#include "qom/object.h"
> +
> +#include "hw/riscv/iommu.h"
> +
> +struct RISCVIOMMUState {
> +    /*< private >*/
> +    DeviceState parent_obj;
> +
> +    /*< public >*/
> +    uint32_t version;     /* Reported interface version number */
> +    uint32_t pid_bits;    /* process identifier width */
> +    uint32_t bus;         /* PCI bus mapping for non-root endpoints */
> +
> +    uint64_t cap;         /* IOMMU supported capabilities */
> +    uint64_t fctl;        /* IOMMU enabled features */
> +
> +    bool enable_off;      /* Enable out-of-reset OFF mode (DMA disabled)=
 */
> +    bool enable_msi;      /* Enable MSI remapping */
> +    bool enable_s_stage;  /* Enable S/VS-Stage translation */
> +    bool enable_g_stage;  /* Enable G-Stage translation */
> +
> +    /* IOMMU Internal State */
> +    uint64_t ddtp;        /* Validated Device Directory Tree Root Pointe=
r */
> +
> +    dma_addr_t cq_addr;   /* Command queue base physical address */
> +    dma_addr_t fq_addr;   /* Fault/event queue base physical address */
> +    dma_addr_t pq_addr;   /* Page request queue base physical address */
> +
> +    uint32_t cq_mask;     /* Command queue index bit mask */
> +    uint32_t fq_mask;     /* Fault/event queue index bit mask */
> +    uint32_t pq_mask;     /* Page request queue index bit mask */
> +
> +    /* interrupt notifier */
> +    void (*notify)(RISCVIOMMUState *iommu, unsigned vector);
> +    /* register icvec interrupts */
> +    void (*icvec_update)(RISCVIOMMUState *iommu,
> +                         uint32_t civ, uint32_t fiv,
> +                         uint32_t pmiv, uint32_t piv);
> +
> +    /* IOMMU State Machine */
> +    QemuThread core_proc; /* Background processing thread */
> +    QemuMutex core_lock;  /* Global IOMMU lock, used for cache/regs upda=
tes */
> +    QemuCond core_cond;   /* Background processing wake up signal */
> +    unsigned core_exec;   /* Processing thread execution actions */
> +
> +    /* IOMMU target address space */
> +    AddressSpace *target_as;
> +    MemoryRegion *target_mr;
> +
> +    /* MSI / MRIF access trap */
> +    AddressSpace trap_as;
> +    MemoryRegion trap_mr;
> +
> +    GHashTable *ctx_cache;          /* Device translation Context Cache =
*/
> +    QemuMutex ctx_lock;      /* Device translation Cache update lock */
> +
> +    /* MMIO Hardware Interface */
> +    MemoryRegion regs_mr;
> +    QemuSpin regs_lock;
> +    uint8_t *regs_rw;  /* register state (user write) */
> +    uint8_t *regs_wc;  /* write-1-to-clear mask */
> +    uint8_t *regs_ro;  /* read-only mask */
> +
> +    QLIST_ENTRY(RISCVIOMMUState) iommus;
> +    QLIST_HEAD(, RISCVIOMMUSpace) spaces;
> +};
> +
> +void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
> +         Error **errp);
> +
> +/* private helpers */
> +
> +/* Register helper functions */
> +static inline uint32_t riscv_iommu_reg_mod32(RISCVIOMMUState *s,
> +    unsigned idx, uint32_t set, uint32_t clr)
> +{
> +    uint32_t val;
> +    qemu_spin_lock(&s->regs_lock);
> +    val =3D ldl_le_p(s->regs_rw + idx);
> +    stl_le_p(s->regs_rw + idx, (val & ~clr) | set);
> +    qemu_spin_unlock(&s->regs_lock);
> +    return val;
> +}
> +
> +static inline void riscv_iommu_reg_set32(RISCVIOMMUState *s,
> +    unsigned idx, uint32_t set)
> +{
> +    qemu_spin_lock(&s->regs_lock);
> +    stl_le_p(s->regs_rw + idx, set);
> +    qemu_spin_unlock(&s->regs_lock);
> +}
> +
> +static inline uint32_t riscv_iommu_reg_get32(RISCVIOMMUState *s,
> +    unsigned idx)
> +{
> +    return ldl_le_p(s->regs_rw + idx);
> +}
> +
> +static inline uint64_t riscv_iommu_reg_mod64(RISCVIOMMUState *s,
> +    unsigned idx, uint64_t set, uint64_t clr)
> +{
> +    uint64_t val;
> +    qemu_spin_lock(&s->regs_lock);
> +    val =3D ldq_le_p(s->regs_rw + idx);
> +    stq_le_p(s->regs_rw + idx, (val & ~clr) | set);
> +    qemu_spin_unlock(&s->regs_lock);
> +    return val;
> +}
> +
> +static inline void riscv_iommu_reg_set64(RISCVIOMMUState *s,
> +    unsigned idx, uint64_t set)
> +{
> +    qemu_spin_lock(&s->regs_lock);
> +    stq_le_p(s->regs_rw + idx, set);
> +    qemu_spin_unlock(&s->regs_lock);
> +}
> +
> +static inline uint64_t riscv_iommu_reg_get64(RISCVIOMMUState *s,
> +    unsigned idx)
> +{
> +    return ldq_le_p(s->regs_rw + idx);
> +}
> +
> +
> +
> +#endif
> diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
> new file mode 100644
> index 0000000000..bdd8b657a6
> --- /dev/null
> +++ b/hw/riscv/trace-events
> @@ -0,0 +1,12 @@
> +# See documentation at docs/devel/tracing.rst
> +
> +# riscv-iommu.c
> +riscv_iommu_new(const char *id, unsigned b, unsigned d, unsigned f) "%s:=
 device attached %04x:%02x.%d"
> +riscv_iommu_flt(const char *id, unsigned b, unsigned d, unsigned f, uint=
64_t reason, uint64_t iova) "%s: fault %04x:%02x.%u reason: 0x%"PRIx64" iov=
a: 0x%"PRIx64
> +riscv_iommu_pri(const char *id, unsigned b, unsigned d, unsigned f, uint=
64_t iova) "%s: page request %04x:%02x.%u iova: 0x%"PRIx64
> +riscv_iommu_dma(const char *id, unsigned b, unsigned d, unsigned f, unsi=
gned pasid, const char *dir, uint64_t iova, uint64_t phys) "%s: translate %=
04x:%02x.%u #%u %s 0x%"PRIx64" -> 0x%"PRIx64
> +riscv_iommu_msi(const char *id, unsigned b, unsigned d, unsigned f, uint=
64_t iova, uint64_t phys) "%s: translate %04x:%02x.%u MSI 0x%"PRIx64" -> 0x=
%"PRIx64
> +riscv_iommu_mrif_notification(const char *id, uint32_t nid, uint64_t phy=
s) "%s: sent MRIF notification 0x%x to 0x%"PRIx64
> +riscv_iommu_cmd(const char *id, uint64_t l, uint64_t u) "%s: command 0x%=
"PRIx64" 0x%"PRIx64
> +riscv_iommu_notifier_add(const char *id) "%s: dev-iotlb notifier added"
> +riscv_iommu_notifier_del(const char *id) "%s: dev-iotlb notifier removed=
"
> diff --git a/hw/riscv/trace.h b/hw/riscv/trace.h
> new file mode 100644
> index 0000000000..8c0e3ca1f3
> --- /dev/null
> +++ b/hw/riscv/trace.h
> @@ -0,0 +1 @@
> +#include "trace/trace-hw_riscv.h"
> diff --git a/include/hw/riscv/iommu.h b/include/hw/riscv/iommu.h
> new file mode 100644
> index 0000000000..070ee69973
> --- /dev/null
> +++ b/include/hw/riscv/iommu.h
> @@ -0,0 +1,36 @@
> +/*
> + * QEMU emulation of an RISC-V IOMMU
> + *
> + * Copyright (C) 2022-2023 Rivos Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_RISCV_IOMMU_H
> +#define HW_RISCV_IOMMU_H
> +
> +#include "qemu/osdep.h"
> +#include "qom/object.h"
> +
> +#define TYPE_RISCV_IOMMU "riscv-iommu"
> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUState, RISCV_IOMMU)
> +typedef struct RISCVIOMMUState RISCVIOMMUState;
> +
> +#define TYPE_RISCV_IOMMU_MEMORY_REGION "riscv-iommu-mr"
> +typedef struct RISCVIOMMUSpace RISCVIOMMUSpace;
> +
> +#define TYPE_RISCV_IOMMU_PCI "riscv-iommu-pci"
> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStatePci, RISCV_IOMMU_PCI)
> +typedef struct RISCVIOMMUStatePci RISCVIOMMUStatePci;
> +
> +#endif
> diff --git a/meson.build b/meson.build
> index a1e51277b0..359f836d8e 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3373,6 +3373,7 @@ if have_system
>      'hw/pci-host',
>      'hw/ppc',
>      'hw/rtc',
> +    'hw/riscv',
>      'hw/s390x',
>      'hw/scsi',
>      'hw/sd',
> --
> 2.45.2
>
>

