Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD198D430F
	for <lists+qemu-devel@lfdr.de>; Thu, 30 May 2024 03:41:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCUlx-00084r-L3; Wed, 29 May 2024 21:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.cheng.linux@gmail.com>)
 id 1sCUlr-000847-Mb; Wed, 29 May 2024 21:39:59 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eric.cheng.linux@gmail.com>)
 id 1sCUlm-0006Rp-LC; Wed, 29 May 2024 21:39:59 -0400
Received: by mail-pg1-x541.google.com with SMTP id
 41be03b00d2f7-68194ee2174so308393a12.3; 
 Wed, 29 May 2024 18:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717033193; x=1717637993; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=S5HGOOl5BI3LlDrmI3/ZpX64WoHIF9+eg4taMqOOg0M=;
 b=iKTvDoweW2YJXU6gUurc2EqRO3RQSaokIh8iCWR1ejXprsrBJt6ZgJ9fpx0983lHgw
 HPTERpteVCyMh3e0W7YFSVK0lZhQLUuvDurYemo8F8urVLuotgEK7HErFqUl8a368iRY
 6YqFWTxMyGDspYC6WdJJYzHjh/OMENmt505la0iWX4oDYgSkN+1eezKAkuEb0jwozK1Q
 PG4YtkU8yturcI1O0uMplqVezvRAFyq5c8fdW73JRQEVm3zyVIM/1pbwBLo3M356WhGN
 o3MtHeOlQsEqhSf+MhKCVGJ/MqJkGe5K+BqEw3Jl0IC2tTDKuwyJjqyUCyrGcfTELDMI
 LuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717033193; x=1717637993;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S5HGOOl5BI3LlDrmI3/ZpX64WoHIF9+eg4taMqOOg0M=;
 b=JJgxvwe5a0i0xXNWfVg+yTA+dHdbp/h6kz5o/h+3cPo3dtoVc57ou766+M7Kz9MP+i
 43RUmLpkbjJRBw+PGO8/roy2ZueLYLTeaeYUwOOZdSaKEMUw4YMJ+7PpmJ5D/130Tlfj
 nuz1XgH9Nyym/KzzD90+nIt2UudFVi62ryIlb0Hknz6sef0lzb6BnaNK8pANyKMabhna
 JnIAnkddQyTCncEESAgCEioiAf26NBz6/vOMxcZeyVKhWnIhZ7BGcUE9UksxW2YBiNb7
 Wxtp42P18h6VHytBynl7EnwFzXg46Lt3f48cZOivlFjI82gbgGMOrcrkN4MWwxOLxXx3
 4ckQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxz2Gf4ezwz/qklJLfLg+EXZVq5KiWxIp59+InlC/FTRKdR9VycBOn2AcEYzL+Q3Pna/BJ0HE6JDb89LxGKMMB3Uq1mWU=
X-Gm-Message-State: AOJu0YzdIF0w1H1uNOU+mPdxTJq2abxU4oQX8wKQLCzYLIacsiyBUdjz
 r079WM1RtlSZv6iLY/zvJpQ4s21/mBgWeF1UKd6g+BZ+ciKVpf4D
X-Google-Smtp-Source: AGHT+IHfyJfpVpCUkSapcLmUS+CJWhsY2Mq1pemTpoWnKI+3oO6OJD3EefHZx0dvBdTxKfk7cPibyw==
X-Received: by 2002:a05:6a21:338b:b0:1b2:2e3e:42dd with SMTP id
 adf61e73a8af0-1b2645639b5mr936885637.34.1717033191513; 
 Wed, 29 May 2024 18:39:51 -0700 (PDT)
Received: from [172.27.237.37]
 (ec2-16-163-40-128.ap-east-1.compute.amazonaws.com. [16.163.40.128])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbd3ea03sm8676948b3a.39.2024.05.29.18.39.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 18:39:51 -0700 (PDT)
Message-ID: <f521ae6d-ffa1-4a7e-b0fb-d732fe693f69@gmail.com>
Date: Thu, 30 May 2024 09:39:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Eric Cheng <eric.cheng.linux@gmail.com>
Subject: Re: [PATCH v3 03/13] hw/riscv: add RISC-V IOMMU base emulation
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 tjeznach@rivosinc.com, ajones@ventanamicro.com, frank.chang@sifive.com,
 Sebastien Boeuf <seb@rivosinc.com>
References: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
 <20240523173955.1940072-4-dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20240523173955.1940072-4-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=eric.cheng.linux@gmail.com; helo=mail-pg1-x541.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 5/24/2024 1:39 AM, Daniel Henrique Barboza wrote:
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
> 
> The RISC-V IOMMU specification is now ratified as-per the RISC-V
> international process. The latest frozen specifcation can be found
> at:
> 
> https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv-iommu.pdf
> 
> Add the foundation of the device emulation for RISC-V IOMMU, which
> includes an IOMMU that has no capabilities but MSI interrupt support and
> fault queue interfaces. We'll add add more features incrementally in the
						      ^^^  ^^^
repeated 'add'

> next patches.
> 
> Co-developed-by: Sebastien Boeuf <seb@rivosinc.com>
> Signed-off-by: Sebastien Boeuf <seb@rivosinc.com>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   hw/riscv/Kconfig         |    4 +
>   hw/riscv/meson.build     |    1 +
>   hw/riscv/riscv-iommu.c   | 1602 ++++++++++++++++++++++++++++++++++++++
>   hw/riscv/riscv-iommu.h   |  141 ++++
>   hw/riscv/trace-events    |   11 +
>   hw/riscv/trace.h         |    1 +
>   include/hw/riscv/iommu.h |   36 +
>   meson.build              |    1 +
>   8 files changed, 1797 insertions(+)
>   create mode 100644 hw/riscv/riscv-iommu.c
>   create mode 100644 hw/riscv/riscv-iommu.h
>   create mode 100644 hw/riscv/trace-events
>   create mode 100644 hw/riscv/trace.h
>   create mode 100644 include/hw/riscv/iommu.h
> 
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index a2030e3a6f..f69d6e3c8e 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -1,3 +1,6 @@
> +config RISCV_IOMMU
> +    bool
> +
>   config RISCV_NUMA
>       bool
>   
> @@ -47,6 +50,7 @@ config RISCV_VIRT
>       select SERIAL
>       select RISCV_ACLINT
>       select RISCV_APLIC
> +    select RISCV_IOMMU
>       select RISCV_IMSIC
>       select SIFIVE_PLIC
>       select SIFIVE_TEST
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index f872674093..cbc99c6e8e 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -10,5 +10,6 @@ riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
>   riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
>   riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_pfsoc.c'))
>   riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
> +riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c'))
>   
>   hw_arch += {'riscv': riscv_ss}
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> new file mode 100644
> index 0000000000..39b4ff1405
> --- /dev/null
> +++ b/hw/riscv/riscv-iommu.c
> @@ -0,0 +1,1602 @@
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
> + * You should have received a copy of the GNU General Public License along
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
> +    IOMMUMemoryRegion iova_mr;  /* IOVA memory region for attached device */
> +    AddressSpace iova_as;       /* IOVA address space for attached device */
> +    RISCVIOMMUState *iommu;     /* Managing IOMMU device state */
> +    uint32_t devid;             /* Requester identifier, AKA device_id */
> +    bool notifier;              /* IOMMU unmap notifier enabled */
> +    QLIST_ENTRY(RISCVIOMMUSpace) list;
> +};
> +
> +/* Device translation context state. */
> +struct RISCVIOMMUContext {
> +    uint64_t devid:24;          /* Requester Id, AKA device_id */
> +    uint64_t pasid:20;          /* Process Address Space ID */
> +    uint64_t __rfu:20;          /* reserved */
> +    uint64_t tc;                /* Translation Control */
> +    uint64_t ta;                /* Translation Attributes */
> +    uint64_t msi_addr_mask;     /* MSI filtering - address mask */
> +    uint64_t msi_addr_pattern;  /* MSI filtering - address pattern */
> +    uint64_t msiptp;            /* MSI redirection page table pointer */
> +};

Can we alias use (devid + pasid + __rfu) by union? so that can easily compare 
the key, esp. I assume functions like __ctx_equal() are on hot path.

And, pasid, is the term in PCI context. I suggest use more general name in spec: 
process_id.

e.g. below (just compiled, not tested)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 1b34d226f9..74011c7f1f 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -53,9 +53,12 @@ struct RISCVIOMMUSpace {

  /* Device translation context state. */
  struct RISCVIOMMUContext {
-    uint64_t devid:24;          /* Requester Id, AKA device_id */
-    uint64_t pasid:20;          /* Process Address Space ID */
-    uint64_t __rfu:20;          /* reserved */
+    union {
+        uint64_t devid:24,          /* Requester Id, AKA device_id */
+                 pasid:20,          /* Process Address Space ID */
+                 __rfu:20;          /* reserved */
+        uint64_t key;
+    };
      uint64_t tc;                /* Translation Control */
      uint64_t ta;                /* Translation Attributes */
      uint64_t satp;              /* S-Stage address translation and protection */
@@ -943,14 +946,14 @@ static gboolean __ctx_equal(gconstpointer v1, 
gconstpointer v2)
  {
      RISCVIOMMUContext *c1 = (RISCVIOMMUContext *) v1;
      RISCVIOMMUContext *c2 = (RISCVIOMMUContext *) v2;
-    return c1->devid == c2->devid && c1->pasid == c2->pasid;
+    return c1->key == c2->key;
  }

  static guint __ctx_hash(gconstpointer v)
  {
      RISCVIOMMUContext *ctx = (RISCVIOMMUContext *) v;
      /* Generate simple hash of (pasid, devid), assuming 24-bit wide devid */
-    return (guint)(ctx->devid) + ((guint)(ctx->pasid) << 24);
+    return (guint)ctx->key;
  }

  static void __ctx_inval_devid_pasid(gpointer key, gpointer value, gpointer data)
@@ -958,8 +961,7 @@ static void __ctx_inval_devid_pasid(gpointer key, gpointer 
value, gpointer data)
      RISCVIOMMUContext *ctx = (RISCVIOMMUContext *) value;
      RISCVIOMMUContext *arg = (RISCVIOMMUContext *) data;
      if (ctx->tc & RISCV_IOMMU_DC_TC_V &&
-        ctx->devid == arg->devid &&
-        ctx->pasid == arg->pasid) {
+        ctx->key == arg->key) {
          ctx->tc &= ~RISCV_IOMMU_DC_TC_V;
      }
  }
@@ -989,6 +991,7 @@ static void riscv_iommu_ctx_inval(RISCVIOMMUState *s, GHFunc 
func,
      RISCVIOMMUContext key = {
          .devid = devid,
          .pasid = pasid,
+        .__rfu = 0,
      };
      ctx_cache = g_hash_table_ref(s->ctx_cache);
      g_hash_table_foreach(ctx_cache, func, &key);
@@ -1004,6 +1007,7 @@ static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
      RISCVIOMMUContext key = {
          .devid = devid,
          .pasid = pasid,
+        .__rfu = 0,
      };

      ctx_cache = g_hash_table_ref(s->ctx_cache);


> +
> +/* IOMMU index for transactions without PASID specified. */
> +#define RISCV_IOMMU_NOPASID 0
> +
> +static void riscv_iommu_notify(RISCVIOMMUState *s, int vec)
> +{
> +    const uint32_t fctl = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FCTL);
> +    uint32_t ipsr, ivec;
> +
> +    if (fctl & RISCV_IOMMU_FCTL_WSI || !s->notify) {
> +        return;
> +    }
> +
> +    ipsr = riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_IPSR, (1 << vec), 0);
> +    ivec = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_IVEC);
> +
> +    if (!(ipsr & (1 << vec))) {
> +        s->notify(s, (ivec >> (vec * 4)) & 0x0F);
> +    }
> +}
> +
> +static void riscv_iommu_fault(RISCVIOMMUState *s,
> +                              struct riscv_iommu_fq_record *ev)
> +{
> +    uint32_t ctrl = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQCSR);
> +    uint32_t head = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQH) & s->fq_mask;
> +    uint32_t tail = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQT) & s->fq_mask;
> +    uint32_t next = (tail + 1) & s->fq_mask;
> +    uint32_t devid = get_field(ev->hdr, RISCV_IOMMU_FQ_HDR_DID);
> +
> +    trace_riscv_iommu_flt(s->parent_obj.id, PCI_BUS_NUM(devid), PCI_SLOT(devid),
> +                          PCI_FUNC(devid), ev->hdr, ev->iotval);
> +
> +    if (!(ctrl & RISCV_IOMMU_FQCSR_FQON) ||
> +        !!(ctrl & (RISCV_IOMMU_FQCSR_FQOF | RISCV_IOMMU_FQCSR_FQMF))) {
> +        return;
> +    }
> +
> +    if (head == next) {
> +        riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_FQCSR,
> +                              RISCV_IOMMU_FQCSR_FQOF, 0);
> +    } else {
> +        dma_addr_t addr = s->fq_addr + tail * sizeof(*ev);
> +        if (dma_memory_write(s->target_as, addr, ev, sizeof(*ev),
> +                             MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
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
> +    uint32_t ctrl = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQCSR);
> +    uint32_t head = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQH) & s->pq_mask;
> +    uint32_t tail = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQT) & s->pq_mask;
> +    uint32_t next = (tail + 1) & s->pq_mask;
> +    uint32_t devid = get_field(pr->hdr, RISCV_IOMMU_PREQ_HDR_DID);
> +
> +    trace_riscv_iommu_pri(s->parent_obj.id, PCI_BUS_NUM(devid), PCI_SLOT(devid),
> +                          PCI_FUNC(devid), pr->payload);
> +
> +    if (!(ctrl & RISCV_IOMMU_PQCSR_PQON) ||
> +        !!(ctrl & (RISCV_IOMMU_PQCSR_PQOF | RISCV_IOMMU_PQCSR_PQMF))) {
> +        return;
> +    }
> +
> +    if (head == next) {
> +        riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_PQCSR,
> +                              RISCV_IOMMU_PQCSR_PQOF, 0);
> +    } else {
> +        dma_addr_t addr = s->pq_addr + tail * sizeof(*pr);
> +        if (dma_memory_write(s->target_as, addr, pr, sizeof(*pr),
> +                             MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
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
> +    uint64_t ret = 0;
> +    uint64_t rot = 1;
> +
> +    while (ext) {
> +        if (ext & 1) {
> +            if (val & 1) {
> +                ret |= rot;
> +            }
> +            rot <<= 1;
> +        }
> +        val >>= 1;
> +        ext >>= 1;
> +    }
> +
> +    return ret;
> +}
> +
> +/* Check if GPA matches MSI/MRIF pattern. */
> +static bool riscv_iommu_msi_check(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
> +    dma_addr_t gpa)
> +{
> +    if (get_field(ctx->msiptp, RISCV_IOMMU_DC_MSIPTP_MODE) !=
> +        RISCV_IOMMU_DC_MSIPTP_MODE_FLAT) {
> +        return false; /* Invalid MSI/MRIF mode */
> +    }
> +
> +    if ((PPN_DOWN(gpa) ^ ctx->msi_addr_pattern) & ~ctx->msi_addr_mask) {
> +        return false; /* GPA not in MSI range defined by AIA IMSIC rules. */
> +    }
> +
> +    return true;
> +}
> +
> +/* RISCV IOMMU Address Translation Lookup - Page Table Walk */
> +static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
> +    IOMMUTLBEntry *iotlb)
> +{
> +    /* Early check for MSI address match when IOVA == GPA */
> +    if (iotlb->perm & IOMMU_WO &&
> +        riscv_iommu_msi_check(s, ctx, iotlb->iova)) {
> +        iotlb->target_as = &s->trap_as;
> +        iotlb->translated_addr = iotlb->iova;
> +        iotlb->addr_mask = ~TARGET_PAGE_MASK;
> +        return 0;
> +    }
> +
> +    /* Exit early for pass-through mode. */
> +    iotlb->translated_addr = iotlb->iova;
> +    iotlb->addr_mask = ~TARGET_PAGE_MASK;
> +    /* Allow R/W in pass-through mode */
> +    iotlb->perm = IOMMU_RW;
> +    return 0;
> +}
> +
> +static void riscv_iommu_report_fault(RISCVIOMMUState *s,
> +                                     RISCVIOMMUContext *ctx,
> +                                     uint32_t fault_type, uint32_t cause,
> +                                     bool pv,
> +                                     uint64_t iotval, uint64_t iotval2)
> +{
> +    struct riscv_iommu_fq_record ev = { 0 };
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
> +    ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_CAUSE, cause);
> +    ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_TTYPE, fault_type);
> +    ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_DID, ctx->devid);
> +    ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_PV, true);
> +
> +    if (pv) {
> +        ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_PID, ctx->pasid);
> +    }
> +
> +    ev.iotval = iotval;
> +    ev.iotval2 = iotval2;
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
> +    int fault_type = RISCV_IOMMU_FQ_TTYPE_UADDR_WR;
> +    int cause;
> +
> +    if (!riscv_iommu_msi_check(s, ctx, gpa)) {
> +        res = MEMTX_ACCESS_ERROR;
> +        cause = RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
> +        goto err;
> +    }
> +
> +    /* Interrupt File Number */
> +    intn = _pext_u64(PPN_DOWN(gpa), ctx->msi_addr_mask);
> +    if (intn >= 256) {
> +        /* Interrupt file number out of range */
> +        res = MEMTX_ACCESS_ERROR;
> +        cause = RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
> +        goto err;
> +    }
> +
> +    /* fetch MSI PTE */
> +    addr = PPN_PHYS(get_field(ctx->msiptp, RISCV_IOMMU_DC_MSIPTP_PPN));
> +    addr = addr | (intn * sizeof(pte));
> +    res = dma_memory_read(s->target_as, addr, &pte, sizeof(pte),
> +            MEMTXATTRS_UNSPECIFIED);
> +    if (res != MEMTX_OK) {
> +        if (res == MEMTX_DECODE_ERROR) {
> +            cause = RISCV_IOMMU_FQ_CAUSE_MSI_PT_CORRUPTED;
> +        } else {
> +            cause = RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
> +        }
> +        goto err;
> +    }
> +
> +    le64_to_cpus(&pte[0]);
> +    le64_to_cpus(&pte[1]);
> +
> +    if (!(pte[0] & RISCV_IOMMU_MSI_PTE_V) || (pte[0] & RISCV_IOMMU_MSI_PTE_C)) {
> +        /*
> +         * The spec mentions that: "If msipte.C == 1, then further
> +         * processing to interpret the PTE is implementation
> +         * defined.". We'll abort with cause = 262 for this
> +         * case too.
> +         */
> +        res = MEMTX_ACCESS_ERROR;
> +        cause = RISCV_IOMMU_FQ_CAUSE_MSI_INVALID;
> +        goto err;
> +    }
> +
> +    switch (get_field(pte[0], RISCV_IOMMU_MSI_PTE_M)) {
> +    case RISCV_IOMMU_MSI_PTE_M_BASIC:
> +        /* MSI Pass-through mode */
> +        addr = PPN_PHYS(get_field(pte[0], RISCV_IOMMU_MSI_PTE_PPN));
> +        addr = addr | (gpa & TARGET_PAGE_MASK);
> +
> +        trace_riscv_iommu_msi(s->parent_obj.id, PCI_BUS_NUM(ctx->devid),
> +                              PCI_SLOT(ctx->devid), PCI_FUNC(ctx->devid),
> +                              gpa, addr);
> +
> +        res = dma_memory_write(s->target_as, addr, &data, size, attrs);
> +        if (res != MEMTX_OK) {
> +            cause = RISCV_IOMMU_FQ_CAUSE_MSI_WR_FAULT;
> +            goto err;
> +        }
> +
> +        return MEMTX_OK;
> +    case RISCV_IOMMU_MSI_PTE_M_MRIF:
> +        /* MRIF mode, continue. */
> +        break;
> +    default:
> +        res = MEMTX_ACCESS_ERROR;
> +        cause = RISCV_IOMMU_FQ_CAUSE_MSI_MISCONFIGURED;
> +        goto err;
> +    }
> +
> +    /*
> +     * Report an error for interrupt identities exceeding the maximum allowed
> +     * for an IMSIC interrupt file (2047) or destination address is not 32-bit
> +     * aligned. See IOMMU Specification, Chapter 2.3. MSI page tables.
> +     */
> +    if ((data > 2047) || (gpa & 3)) {
> +        res = MEMTX_ACCESS_ERROR;
> +        cause = RISCV_IOMMU_FQ_CAUSE_MSI_MISCONFIGURED;
> +        goto err;
> +    }
> +
> +    /* MSI MRIF mode, non atomic pending bit update */
> +
> +    /* MRIF pending bit address */
> +    addr = get_field(pte[0], RISCV_IOMMU_MSI_PTE_MRIF_ADDR) << 9;
> +    addr = addr | ((data & 0x7c0) >> 3);
> +
> +    trace_riscv_iommu_msi(s->parent_obj.id, PCI_BUS_NUM(ctx->devid),
> +                          PCI_SLOT(ctx->devid), PCI_FUNC(ctx->devid),
> +                          gpa, addr);
> +
> +    /* MRIF pending bit mask */
> +    data = 1ULL << (data & 0x03f);
> +    res = dma_memory_read(s->target_as, addr, &intn, sizeof(intn), attrs);
> +    if (res != MEMTX_OK) {
> +        cause = RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
> +        goto err;
> +    }
> +
> +    intn = intn | data;
> +    res = dma_memory_write(s->target_as, addr, &intn, sizeof(intn), attrs);
> +    if (res != MEMTX_OK) {
> +        cause = RISCV_IOMMU_FQ_CAUSE_MSI_WR_FAULT;
> +        goto err;
> +    }
> +
> +    /* Get MRIF enable bits */
> +    addr = addr + sizeof(intn);
> +    res = dma_memory_read(s->target_as, addr, &intn, sizeof(intn), attrs);
> +    if (res != MEMTX_OK) {
> +        cause = RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
> +        goto err;
> +    }
> +
> +    if (!(intn & data)) {
> +        /* notification disabled, MRIF update completed. */
> +        return MEMTX_OK;
> +    }
> +
> +    /* Send notification message */
> +    addr = PPN_PHYS(get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NPPN));
> +    n190 = get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NID) |
> +          (get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NID_MSB) << 10);
> +
> +    res = dma_memory_write(s->target_as, addr, &n190, sizeof(n190), attrs);
> +    if (res != MEMTX_OK) {
> +        cause = RISCV_IOMMU_FQ_CAUSE_MSI_WR_FAULT;
> +        goto err;
> +    }
> +
> +    return MEMTX_OK;
> +
> +err:
> +    riscv_iommu_report_fault(s, ctx, fault_type, cause,
> +                             !!ctx->pasid, 0, 0);
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
> +    uint32_t msi_mode;
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
> +        msi_mode = get_field(ctx->msiptp, RISCV_IOMMU_DC_MSIPTP_MODE);
> +
> +        if (msi_mode != RISCV_IOMMU_DC_MSIPTP_MODE_OFF &&
> +            msi_mode != RISCV_IOMMU_DC_MSIPTP_MODE_FLAT) {
> +            return false;
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
> + * RISC-V IOMMU Device Context Loopkup - Device Directory Tree Walk
> + *
> + * @s         : IOMMU Device State
> + * @ctx       : Device Translation Context with devid and pasid set.
> + * @return    : success or fault code.
> + */
> +static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
> +{
> +    const uint64_t ddtp = s->ddtp;
> +    unsigned mode = get_field(ddtp, RISCV_IOMMU_DDTP_MODE);
> +    dma_addr_t addr = PPN_PHYS(get_field(ddtp, RISCV_IOMMU_DDTP_PPN));
> +    struct riscv_iommu_dc dc;
> +    /* Device Context format: 0: extended (64 bytes) | 1: base (32 bytes) */
> +    const int dc_fmt = !s->enable_msi;
> +    const size_t dc_len = sizeof(dc) >> dc_fmt;
> +    unsigned depth;
> +    uint64_t de;
> +
> +    switch (mode) {
> +    case RISCV_IOMMU_DDTP_MODE_OFF:
> +        return RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED;
> +
> +    case RISCV_IOMMU_DDTP_MODE_BARE:
> +        /* mock up pass-through translation context */
> +        ctx->tc = RISCV_IOMMU_DC_TC_V;
> +        ctx->ta = 0;
> +        ctx->msiptp = 0;
> +        return 0;
> +
> +    case RISCV_IOMMU_DDTP_MODE_1LVL:
> +        depth = 0;
> +        break;
> +
> +    case RISCV_IOMMU_DDTP_MODE_2LVL:
> +        depth = 1;
> +        break;
> +
> +    case RISCV_IOMMU_DDTP_MODE_3LVL:
> +        depth = 2;
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
> +    if (ctx->devid >= (1 << (depth * 9 + 6 + (dc_fmt && depth != 2)))) {
> +        return RISCV_IOMMU_FQ_CAUSE_TTYPE_BLOCKED;
> +    }
> +
> +    /* Device directory tree walk */
> +    for (; depth-- > 0; ) {
> +        /*
> +         * Select device id index bits based on device directory tree level
> +         * and device context format.
> +         * See IOMMU Specification, Chapter 2. Data Structures.
> +         * - if extended device-context format is used:
> +         *   device index: [23:15][14:6][5:0]
> +         * - if base device-context format is used:
> +         *   device index: [23:16][15:7][6:0]
> +         */
> +        const int split = depth * 9 + 6 + dc_fmt;
> +        addr |= ((ctx->devid >> split) << 3) & ~TARGET_PAGE_MASK;
> +        if (dma_memory_read(s->target_as, addr, &de, sizeof(de),
> +                            MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
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
> +        addr = PPN_PHYS(get_field(de, RISCV_IOMMU_DDTE_PPN));
> +    }
> +
> +    /* index into device context entry page */
> +    addr |= (ctx->devid * dc_len) & ~TARGET_PAGE_MASK;
> +
> +    memset(&dc, 0, sizeof(dc));
> +    if (dma_memory_read(s->target_as, addr, &dc, dc_len,
> +                        MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
> +        return RISCV_IOMMU_FQ_CAUSE_DDT_LOAD_FAULT;
> +    }
> +
> +    /* Set translation context. */
> +    ctx->tc = le64_to_cpu(dc.tc);
> +    ctx->ta = le64_to_cpu(dc.ta);
> +    ctx->msiptp = le64_to_cpu(dc.msiptp);
> +    ctx->msi_addr_mask = le64_to_cpu(dc.msi_addr_mask);
> +    ctx->msi_addr_pattern = le64_to_cpu(dc.msi_addr_pattern);
> +
> +    if (!riscv_iommu_validate_device_ctx(s, ctx)) {
> +        return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +    }
> +
> +    if (!(ctx->tc & RISCV_IOMMU_DC_TC_V)) {
> +        return RISCV_IOMMU_FQ_CAUSE_DDT_INVALID;
> +    }
> +
> +    if (!(ctx->tc & RISCV_IOMMU_DC_TC_PDTV)) {
> +        if (ctx->pasid != RISCV_IOMMU_NOPASID) {
> +            /* PASID is disabled */
> +            return RISCV_IOMMU_FQ_CAUSE_TTYPE_BLOCKED;
> +        }
> +        return 0;
> +    }
> +
> +    /* FSC.TC.PDTV enabled */
> +    if (mode > RISCV_IOMMU_DC_FSC_PDTP_MODE_PD20) {
> +        /* Invalid PDTP.MODE */
> +        return RISCV_IOMMU_FQ_CAUSE_PDT_MISCONFIGURED;
> +    }
> +
> +    for (depth = mode - RISCV_IOMMU_DC_FSC_PDTP_MODE_PD8; depth-- > 0; ) {
> +        /*
> +         * Select process id index bits based on process directory tree
> +         * level. See IOMMU Specification, 2.2. Process-Directory-Table.
> +         */
> +        const int split = depth * 9 + 8;
> +        addr |= ((ctx->pasid >> split) << 3) & ~TARGET_PAGE_MASK;
> +        if (dma_memory_read(s->target_as, addr, &de, sizeof(de),
> +                            MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
> +            return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
> +        }
> +        le64_to_cpus(&de);
> +        if (!(de & RISCV_IOMMU_PC_TA_V)) {
> +            return RISCV_IOMMU_FQ_CAUSE_PDT_INVALID;
> +        }
> +        addr = PPN_PHYS(get_field(de, RISCV_IOMMU_PC_FSC_PPN));
> +    }
> +
> +    /* Leaf entry in PDT */
> +    addr |= (ctx->pasid << 4) & ~TARGET_PAGE_MASK;
> +    if (dma_memory_read(s->target_as, addr, &dc.ta, sizeof(uint64_t) * 2,
> +                        MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
> +        return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
> +    }
> +
> +    /* Use FSC and TA from process directory entry. */
> +    ctx->ta = le64_to_cpu(dc.ta);
> +
> +    return 0;
> +}
> +
> +/* Translation Context cache support */
> +static gboolean __ctx_equal(gconstpointer v1, gconstpointer v2)
> +{
> +    RISCVIOMMUContext *c1 = (RISCVIOMMUContext *) v1;
> +    RISCVIOMMUContext *c2 = (RISCVIOMMUContext *) v2;
> +    return c1->devid == c2->devid && c1->pasid == c2->pasid;
> +}
> +
> +static guint __ctx_hash(gconstpointer v)
> +{
> +    RISCVIOMMUContext *ctx = (RISCVIOMMUContext *) v;
> +    /* Generate simple hash of (pasid, devid), assuming 24-bit wide devid */
> +    return (guint)(ctx->devid) + ((guint)(ctx->pasid) << 24);
> +}
> +
> +static void __ctx_inval_devid_pasid(gpointer key, gpointer value, gpointer data)
> +{
> +    RISCVIOMMUContext *ctx = (RISCVIOMMUContext *) value;
> +    RISCVIOMMUContext *arg = (RISCVIOMMUContext *) data;
> +    if (ctx->tc & RISCV_IOMMU_DC_TC_V &&
> +        ctx->devid == arg->devid &&
> +        ctx->pasid == arg->pasid) {
> +        ctx->tc &= ~RISCV_IOMMU_DC_TC_V;
> +    }
> +}
> +
> +static void __ctx_inval_devid(gpointer key, gpointer value, gpointer data)
> +{
> +    RISCVIOMMUContext *ctx = (RISCVIOMMUContext *) value;
> +    RISCVIOMMUContext *arg = (RISCVIOMMUContext *) data;
> +    if (ctx->tc & RISCV_IOMMU_DC_TC_V &&
> +        ctx->devid == arg->devid) {
> +        ctx->tc &= ~RISCV_IOMMU_DC_TC_V;
> +    }
> +}
> +
> +static void __ctx_inval_all(gpointer key, gpointer value, gpointer data)
> +{
> +    RISCVIOMMUContext *ctx = (RISCVIOMMUContext *) value;
> +    if (ctx->tc & RISCV_IOMMU_DC_TC_V) {
> +        ctx->tc &= ~RISCV_IOMMU_DC_TC_V;
> +    }
> +}
> +
> +static void riscv_iommu_ctx_inval(RISCVIOMMUState *s, GHFunc func,
> +    uint32_t devid, uint32_t pasid)
> +{
> +    GHashTable *ctx_cache;
> +    RISCVIOMMUContext key = {
> +        .devid = devid,
> +        .pasid = pasid,
> +    };
> +    ctx_cache = g_hash_table_ref(s->ctx_cache);
> +    g_hash_table_foreach(ctx_cache, func, &key);
> +    g_hash_table_unref(ctx_cache);
> +}
> +
> +/* Find or allocate translation context for a given {device_id, process_id} */
> +static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
> +    unsigned devid, unsigned pasid, void **ref)
> +{
> +    GHashTable *ctx_cache;
> +    RISCVIOMMUContext *ctx;
> +    RISCVIOMMUContext key = {
> +        .devid = devid,
> +        .pasid = pasid,
> +    };
> +
> +    ctx_cache = g_hash_table_ref(s->ctx_cache);
> +    ctx = g_hash_table_lookup(ctx_cache, &key);
> +
> +    if (ctx && (ctx->tc & RISCV_IOMMU_DC_TC_V)) {
> +        *ref = ctx_cache;
> +        return ctx;
> +    }
> +
> +    if (g_hash_table_size(s->ctx_cache) >= LIMIT_CACHE_CTX) {
> +        ctx_cache = g_hash_table_new_full(__ctx_hash, __ctx_equal,
> +                                          g_free, NULL);
> +        g_hash_table_unref(qatomic_xchg(&s->ctx_cache, ctx_cache));
> +    }
> +
> +    ctx = g_new0(RISCVIOMMUContext, 1);
> +    ctx->devid = devid;
> +    ctx->pasid = pasid;
> +
> +    int fault = riscv_iommu_ctx_fetch(s, ctx);
> +    if (!fault) {
> +        g_hash_table_add(ctx_cache, ctx);
> +        *ref = ctx_cache;
> +        return ctx;
> +    }
> +
> +    g_hash_table_unref(ctx_cache);
> +    *ref = NULL;
> +
> +    riscv_iommu_report_fault(s, ctx, RISCV_IOMMU_FQ_TTYPE_UADDR_RD,
> +                             fault, !!pasid, 0, 0);
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
> +static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devid)
> +{
> +    RISCVIOMMUSpace *as;
> +
> +    /* FIXME: PCIe bus remapping for attached endpoints. */
> +    devid |= s->bus << 8;
> +
> +    qemu_mutex_lock(&s->core_lock);
> +    QLIST_FOREACH(as, &s->spaces, list) {
> +        if (as->devid == devid) {
> +            break;
> +        }
> +    }
> +    qemu_mutex_unlock(&s->core_lock);
> +
> +    if (as == NULL) {
> +        char name[64];
> +        as = g_new0(RISCVIOMMUSpace, 1);
> +
> +        as->iommu = s;
> +        as->devid = devid;
> +
> +        snprintf(name, sizeof(name), "riscv-iommu-%04x:%02x.%d-iova",
> +            PCI_BUS_NUM(as->devid), PCI_SLOT(as->devid), PCI_FUNC(as->devid));
> +
> +        /* IOVA address space, untranslated addresses */
> +        memory_region_init_iommu(&as->iova_mr, sizeof(as->iova_mr),
> +            TYPE_RISCV_IOMMU_MEMORY_REGION,
> +            OBJECT(as), "riscv_iommu", UINT64_MAX);
> +        address_space_init(&as->iova_as, MEMORY_REGION(&as->iova_mr), name);
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
> +static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
> +    IOMMUTLBEntry *iotlb)
> +{
> +    bool enable_pasid;
> +    bool enable_pri;
> +    int fault;
> +
> +    /*
> +     * TC[32] is reserved for custom extensions, used here to temporarily
> +     * enable automatic page-request generation for ATS queries.
> +     */
> +    enable_pri = (iotlb->perm == IOMMU_NONE) && (ctx->tc & BIT_ULL(32));
> +    enable_pasid = (ctx->tc & RISCV_IOMMU_DC_TC_PDTV);
> +
> +    /* Translate using device directory / page table information. */
> +    fault = riscv_iommu_spa_fetch(s, ctx, iotlb);
> +
> +    if (enable_pri && fault) {
> +        struct riscv_iommu_pq_record pr = {0};
> +        if (enable_pasid) {
> +            pr.hdr = set_field(RISCV_IOMMU_PREQ_HDR_PV,
> +                RISCV_IOMMU_PREQ_HDR_PID, ctx->pasid);
> +        }
> +        pr.hdr = set_field(pr.hdr, RISCV_IOMMU_PREQ_HDR_DID, ctx->devid);
> +        pr.payload = (iotlb->iova & TARGET_PAGE_MASK) |
> +                     RISCV_IOMMU_PREQ_PAYLOAD_M;
> +        riscv_iommu_pri(s, &pr);
> +        return fault;
> +    }
> +
> +    if (fault) {
> +        unsigned ttype;
> +
> +        if (iotlb->perm & IOMMU_RW) {
> +            ttype = RISCV_IOMMU_FQ_TTYPE_UADDR_WR;
> +        } else {
> +            ttype = RISCV_IOMMU_FQ_TTYPE_UADDR_RD;
> +        }
> +
> +        riscv_iommu_report_fault(s, ctx, ttype, fault, enable_pasid,
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
> +     * ATS processing in this implementation of the IOMMU is synchronous,
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
> +    uint64_t old_ddtp = s->ddtp;
> +    uint64_t new_ddtp = riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_DDTP);
> +    unsigned new_mode = get_field(new_ddtp, RISCV_IOMMU_DDTP_MODE);
> +    unsigned old_mode = get_field(old_ddtp, RISCV_IOMMU_DDTP_MODE);
> +    bool ok = false;
> +
> +    /*
> +     * Check for allowed DDTP.MODE transitions:
> +     * {OFF, BARE}        -> {OFF, BARE, 1LVL, 2LVL, 3LVL}
> +     * {1LVL, 2LVL, 3LVL} -> {OFF, BARE}
> +     */
> +    if (new_mode == old_mode ||
> +        new_mode == RISCV_IOMMU_DDTP_MODE_OFF ||
> +        new_mode == RISCV_IOMMU_DDTP_MODE_BARE) {
> +        ok = true;
> +    } else if (new_mode == RISCV_IOMMU_DDTP_MODE_1LVL ||
> +               new_mode == RISCV_IOMMU_DDTP_MODE_2LVL ||
> +               new_mode == RISCV_IOMMU_DDTP_MODE_3LVL) {
> +        ok = old_mode == RISCV_IOMMU_DDTP_MODE_OFF ||
> +             old_mode == RISCV_IOMMU_DDTP_MODE_BARE;
> +    }
> +
> +    if (ok) {
> +        /* clear reserved and busy bits, report back sanitized version */
> +        new_ddtp = set_field(new_ddtp & RISCV_IOMMU_DDTP_PPN,
> +                             RISCV_IOMMU_DDTP_MODE, new_mode);
> +    } else {
> +        new_ddtp = old_ddtp;
> +    }
> +    s->ddtp = new_ddtp;
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
> +    ctrl = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQCSR);
> +    tail = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQT) & s->cq_mask;
> +    head = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQH) & s->cq_mask;
> +
> +    /* Check for pending error or queue processing disabled */
> +    if (!(ctrl & RISCV_IOMMU_CQCSR_CQON) ||
> +        !!(ctrl & (RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_CQMF))) {
> +        return;
> +    }
> +
> +    while (tail != head) {
> +        addr = s->cq_addr  + head * sizeof(cmd);
> +        res = dma_memory_read(s->target_as, addr, &cmd, sizeof(cmd),
> +                              MEMTXATTRS_UNSPECIFIED);
> +
> +        if (res != MEMTX_OK) {
> +            riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQCSR,
> +                                  RISCV_IOMMU_CQCSR_CQMF, 0);
> +            goto fault;
> +        }
> +
> +        trace_riscv_iommu_cmd(s->parent_obj.id, cmd.dword0, cmd.dword1);
> +
> +        cmd_opcode = get_field(cmd.dword0,
> +                               RISCV_IOMMU_CMD_OPCODE | RISCV_IOMMU_CMD_FUNC);
> +
> +        switch (cmd_opcode) {
> +        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOFENCE_FUNC_C,
> +                             RISCV_IOMMU_CMD_IOFENCE_OPCODE):
> +            res = riscv_iommu_iofence(s,
> +                cmd.dword0 & RISCV_IOMMU_CMD_IOFENCE_AV, cmd.dword1,
> +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOFENCE_DATA));
> +
> +            if (res != MEMTX_OK) {
> +                riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQCSR,
> +                                      RISCV_IOMMU_CQCSR_CQMF, 0);
> +                goto fault;
> +            }
> +            break;
> +
> +        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA,
> +                             RISCV_IOMMU_CMD_IOTINVAL_OPCODE):
> +            if (cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV) {
> +                /* illegal command arguments IOTINVAL.GVMA & PSCV == 1 */
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
> +                func = __ctx_inval_all;
> +            } else {
> +                /* invalidate all device context matching DID */
> +                func = __ctx_inval_devid;
> +            }
> +            riscv_iommu_ctx_inval(s, func,
> +                get_field(cmd.dword0, RISCV_IOMMU_CMD_IODIR_DID), 0);
> +            break;
> +
> +        case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_PDT,
> +                             RISCV_IOMMU_CMD_IODIR_OPCODE):
> +            if (!(cmd.dword0 & RISCV_IOMMU_CMD_IODIR_DV)) {
> +                /* illegal command arguments IODIR_PDT & DV == 0 */
> +                goto cmd_ill;
> +            } else {
> +                func = __ctx_inval_devid_pasid;
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
> +        head = (head + 1) & s->cq_mask;
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
> +    uint32_t ctrl_set = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQCSR);
> +    uint32_t ctrl_clr;
> +    bool enable = !!(ctrl_set & RISCV_IOMMU_CQCSR_CQEN);
> +    bool active = !!(ctrl_set & RISCV_IOMMU_CQCSR_CQON);
> +
> +    if (enable && !active) {
> +        base = riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_CQB);
> +        s->cq_mask = (2ULL << get_field(base, RISCV_IOMMU_CQB_LOG2SZ)) - 1;
> +        s->cq_addr = PPN_PHYS(get_field(base, RISCV_IOMMU_CQB_PPN));
> +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQT], ~s->cq_mask);
> +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_CQH], 0);
> +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_CQT], 0);
> +        ctrl_set = RISCV_IOMMU_CQCSR_CQON;
> +        ctrl_clr = RISCV_IOMMU_CQCSR_BUSY | RISCV_IOMMU_CQCSR_CQMF |
> +                   RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_CMD_TO |
> +                   RISCV_IOMMU_CQCSR_FENCE_W_IP;
> +    } else if (!enable && active) {
> +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQT], ~0);
> +        ctrl_set = 0;
> +        ctrl_clr = RISCV_IOMMU_CQCSR_BUSY | RISCV_IOMMU_CQCSR_CQON;
> +    } else {
> +        ctrl_set = 0;
> +        ctrl_clr = RISCV_IOMMU_CQCSR_BUSY;
> +    }
> +
> +    riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQCSR, ctrl_set, ctrl_clr);
> +}
> +
> +static void riscv_iommu_process_fq_control(RISCVIOMMUState *s)
> +{
> +    uint64_t base;
> +    uint32_t ctrl_set = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQCSR);
> +    uint32_t ctrl_clr;
> +    bool enable = !!(ctrl_set & RISCV_IOMMU_FQCSR_FQEN);
> +    bool active = !!(ctrl_set & RISCV_IOMMU_FQCSR_FQON);
> +
> +    if (enable && !active) {
> +        base = riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_FQB);
> +        s->fq_mask = (2ULL << get_field(base, RISCV_IOMMU_FQB_LOG2SZ)) - 1;
> +        s->fq_addr = PPN_PHYS(get_field(base, RISCV_IOMMU_FQB_PPN));
> +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_FQH], ~s->fq_mask);
> +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_FQH], 0);
> +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_FQT], 0);
> +        ctrl_set = RISCV_IOMMU_FQCSR_FQON;
> +        ctrl_clr = RISCV_IOMMU_FQCSR_BUSY | RISCV_IOMMU_FQCSR_FQMF |
> +            RISCV_IOMMU_FQCSR_FQOF;
> +    } else if (!enable && active) {
> +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_FQH], ~0);
> +        ctrl_set = 0;
> +        ctrl_clr = RISCV_IOMMU_FQCSR_BUSY | RISCV_IOMMU_FQCSR_FQON;
> +    } else {
> +        ctrl_set = 0;
> +        ctrl_clr = RISCV_IOMMU_FQCSR_BUSY;
> +    }
> +
> +    riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_FQCSR, ctrl_set, ctrl_clr);
> +}
> +
> +static void riscv_iommu_process_pq_control(RISCVIOMMUState *s)
> +{
> +    uint64_t base;
> +    uint32_t ctrl_set = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQCSR);
> +    uint32_t ctrl_clr;
> +    bool enable = !!(ctrl_set & RISCV_IOMMU_PQCSR_PQEN);
> +    bool active = !!(ctrl_set & RISCV_IOMMU_PQCSR_PQON);
> +
> +    if (enable && !active) {
> +        base = riscv_iommu_reg_get64(s, RISCV_IOMMU_REG_PQB);
> +        s->pq_mask = (2ULL << get_field(base, RISCV_IOMMU_PQB_LOG2SZ)) - 1;
> +        s->pq_addr = PPN_PHYS(get_field(base, RISCV_IOMMU_PQB_PPN));
> +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_PQH], ~s->pq_mask);
> +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_PQH], 0);
> +        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_PQT], 0);
> +        ctrl_set = RISCV_IOMMU_PQCSR_PQON;
> +        ctrl_clr = RISCV_IOMMU_PQCSR_BUSY | RISCV_IOMMU_PQCSR_PQMF |
> +            RISCV_IOMMU_PQCSR_PQOF;
> +    } else if (!enable && active) {
> +        stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_PQH], ~0);
> +        ctrl_set = 0;
> +        ctrl_clr = RISCV_IOMMU_PQCSR_BUSY | RISCV_IOMMU_PQCSR_PQON;
> +    } else {
> +        ctrl_set = 0;
> +        ctrl_clr = RISCV_IOMMU_PQCSR_BUSY;
> +    }
> +
> +    riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_PQCSR, ctrl_set, ctrl_clr);
> +}
> +
> +typedef void riscv_iommu_process_fn(RISCVIOMMUState *s);
> +
> +static void riscv_iommu_update_ipsr(RISCVIOMMUState *s, uint64_t data)
> +{
> +    uint32_t cqcsr, fqcsr, pqcsr;
> +    uint32_t ipsr_set = 0;
> +    uint32_t ipsr_clr = 0;
> +
> +    if (data & RISCV_IOMMU_IPSR_CIP) {
> +        cqcsr = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQCSR);
> +
> +        if (cqcsr & RISCV_IOMMU_CQCSR_CIE &&
> +            (cqcsr & RISCV_IOMMU_CQCSR_FENCE_W_IP ||
> +             cqcsr & RISCV_IOMMU_CQCSR_CMD_ILL ||
> +             cqcsr & RISCV_IOMMU_CQCSR_CMD_TO ||
> +             cqcsr & RISCV_IOMMU_CQCSR_CQMF)) {
> +            ipsr_set |= RISCV_IOMMU_IPSR_CIP;
> +        } else {
> +            ipsr_clr |= RISCV_IOMMU_IPSR_CIP;
> +        }
> +    } else {
> +        ipsr_clr |= RISCV_IOMMU_IPSR_CIP;
> +    }
> +
> +    if (data & RISCV_IOMMU_IPSR_FIP) {
> +        fqcsr = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQCSR);
> +
> +        if (fqcsr & RISCV_IOMMU_FQCSR_FIE &&
> +            (fqcsr & RISCV_IOMMU_FQCSR_FQOF ||
> +             fqcsr & RISCV_IOMMU_FQCSR_FQMF)) {
> +            ipsr_set |= RISCV_IOMMU_IPSR_FIP;
> +        } else {
> +            ipsr_clr |= RISCV_IOMMU_IPSR_FIP;
> +        }
> +    } else {
> +        ipsr_clr |= RISCV_IOMMU_IPSR_FIP;
> +    }
> +
> +    if (data & RISCV_IOMMU_IPSR_PIP) {
> +        pqcsr = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQCSR);
> +
> +        if (pqcsr & RISCV_IOMMU_PQCSR_PIE &&
> +            (pqcsr & RISCV_IOMMU_PQCSR_PQOF ||
> +             pqcsr & RISCV_IOMMU_PQCSR_PQMF)) {
> +            ipsr_set |= RISCV_IOMMU_IPSR_PIP;
> +        } else {
> +            ipsr_clr |= RISCV_IOMMU_IPSR_PIP;
> +        }
> +    } else {
> +        ipsr_clr |= RISCV_IOMMU_IPSR_PIP;
> +    }
> +
> +    riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_IPSR, ipsr_set, ipsr_clr);
> +}
> +
> +static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
> +    uint64_t data, unsigned size, MemTxAttrs attrs)
> +{
> +    riscv_iommu_process_fn *process_fn = NULL;
> +    RISCVIOMMUState *s = opaque;
> +    uint32_t regb = addr & ~3;
> +    uint32_t busy = 0;
> +    uint64_t val = 0;
> +
> +    if ((addr & (size - 1)) != 0) {
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
> +        process_fn = riscv_iommu_process_ddtp;
> +        regb = RISCV_IOMMU_REG_DDTP;
> +        busy = RISCV_IOMMU_DDTP_BUSY;
> +        break;
> +
> +    case RISCV_IOMMU_REG_CQT:
> +        process_fn = riscv_iommu_process_cq_tail;
> +        break;
> +
> +    case RISCV_IOMMU_REG_CQCSR:
> +        process_fn = riscv_iommu_process_cq_control;
> +        busy = RISCV_IOMMU_CQCSR_BUSY;
> +        break;
> +
> +    case RISCV_IOMMU_REG_FQCSR:
> +        process_fn = riscv_iommu_process_fq_control;
> +        busy = RISCV_IOMMU_FQCSR_BUSY;
> +        break;
> +
> +    case RISCV_IOMMU_REG_PQCSR:
> +        process_fn = riscv_iommu_process_pq_control;
> +        busy = RISCV_IOMMU_PQCSR_BUSY;
> +        break;
> +
> +    case RISCV_IOMMU_REG_IPSR:
> +        /*
> +         * IPSR has special procedures to update. Execute it
> +         * and exit.
> +         */
> +        if (size == 4) {
> +            uint32_t ro = ldl_le_p(&s->regs_ro[addr]);
> +            uint32_t wc = ldl_le_p(&s->regs_wc[addr]);
> +            uint32_t rw = ldl_le_p(&s->regs_rw[addr]);
> +            stl_le_p(&val, ((rw & ro) | (data & ~ro)) & ~(data & wc));
> +        } else if (size == 8) {
> +            uint64_t ro = ldq_le_p(&s->regs_ro[addr]);
> +            uint64_t wc = ldq_le_p(&s->regs_wc[addr]);
> +            uint64_t rw = ldq_le_p(&s->regs_rw[addr]);
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
> +    if (size == 1) {
> +        uint8_t ro = s->regs_ro[addr];
> +        uint8_t wc = s->regs_wc[addr];
> +        uint8_t rw = s->regs_rw[addr];
> +        s->regs_rw[addr] = ((rw & ro) | (data & ~ro)) & ~(data & wc);
> +    } else if (size == 2) {
> +        uint16_t ro = lduw_le_p(&s->regs_ro[addr]);
> +        uint16_t wc = lduw_le_p(&s->regs_wc[addr]);
> +        uint16_t rw = lduw_le_p(&s->regs_rw[addr]);
> +        stw_le_p(&s->regs_rw[addr], ((rw & ro) | (data & ~ro)) & ~(data & wc));
> +    } else if (size == 4) {
> +        uint32_t ro = ldl_le_p(&s->regs_ro[addr]);
> +        uint32_t wc = ldl_le_p(&s->regs_wc[addr]);
> +        uint32_t rw = ldl_le_p(&s->regs_rw[addr]);
> +        stl_le_p(&s->regs_rw[addr], ((rw & ro) | (data & ~ro)) & ~(data & wc));
> +    } else if (size == 8) {
> +        uint64_t ro = ldq_le_p(&s->regs_ro[addr]);
> +        uint64_t wc = ldq_le_p(&s->regs_wc[addr]);
> +        uint64_t rw = ldq_le_p(&s->regs_rw[addr]);
> +        stq_le_p(&s->regs_rw[addr], ((rw & ro) | (data & ~ro)) & ~(data & wc));
> +    }
> +
> +    /* Busy flag update, MSB 4-byte register. */
> +    if (busy) {
> +        uint32_t rw = ldl_le_p(&s->regs_rw[regb]);
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
> +    RISCVIOMMUState *s = opaque;
> +    uint64_t val = -1;
> +    uint8_t *ptr;
> +
> +    if ((addr & (size - 1)) != 0) {
> +        /* Unsupported MMIO alignment. */
> +        return MEMTX_ERROR;
> +    }
> +
> +    if (addr + size > RISCV_IOMMU_REG_MSI_CONFIG) {
> +        return MEMTX_ACCESS_ERROR;
> +    }
> +
> +    ptr = &s->regs_rw[addr];
> +
> +    if (size == 1) {
> +        val = (uint64_t)*ptr;
> +    } else if (size == 2) {
> +        val = lduw_le_p(ptr);
> +    } else if (size == 4) {
> +        val = ldl_le_p(ptr);
> +    } else if (size == 8) {
> +        val = ldq_le_p(ptr);
> +    } else {
> +        return MEMTX_ERROR;
> +    }
> +
> +    *data = val;
> +
> +    return MEMTX_OK;
> +}
> +
> +static const MemoryRegionOps riscv_iommu_mmio_ops = {
> +    .read_with_attrs = riscv_iommu_mmio_read,
> +    .write_with_attrs = riscv_iommu_mmio_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 8,
> +        .unaligned = false,
> +    },
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 8,
> +    }
> +};
> +
> +/*
> + * Translations matching MSI pattern check are redirected to "riscv-iommu-trap"
> + * memory region as untranslated address, for additional MSI/MRIF interception
> + * by IOMMU interrupt remapping implementation.
> + * Note: Device emulation code generating an MSI is expected to provide a valid
> + * memory transaction attributes with requested_id set.
> + */
> +static MemTxResult riscv_iommu_trap_write(void *opaque, hwaddr addr,
> +    uint64_t data, unsigned size, MemTxAttrs attrs)
> +{
> +    RISCVIOMMUState* s = (RISCVIOMMUState *)opaque;
> +    RISCVIOMMUContext *ctx;
> +    MemTxResult res;
> +    void *ref;
> +    uint32_t devid = attrs.requester_id;
> +
> +    if (attrs.unspecified) {
> +        return MEMTX_ACCESS_ERROR;
> +    }
> +
> +    /* FIXME: PCIe bus remapping for attached endpoints. */
> +    devid |= s->bus << 8;
> +
> +    ctx = riscv_iommu_ctx(s, devid, 0, &ref);
> +    if (ctx == NULL) {
> +        res = MEMTX_ACCESS_ERROR;
> +    } else {
> +        res = riscv_iommu_msi_write(s, ctx, addr, data, size, attrs);
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
> +static const MemoryRegionOps riscv_iommu_trap_ops = {
> +    .read_with_attrs = riscv_iommu_trap_read,
> +    .write_with_attrs = riscv_iommu_trap_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 8,
> +        .unaligned = true,
> +    },
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 8,
> +    }
> +};
> +
> +static void riscv_iommu_realize(DeviceState *dev, Error **errp)
> +{
> +    RISCVIOMMUState *s = RISCV_IOMMU(dev);
> +
> +    s->cap = s->version & RISCV_IOMMU_CAP_VERSION;
> +    if (s->enable_msi) {
> +        s->cap |= RISCV_IOMMU_CAP_MSI_FLAT | RISCV_IOMMU_CAP_MSI_MRIF;
> +    }
> +    /* Report QEMU target physical address space limits */
> +    s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS,
> +                       TARGET_PHYS_ADDR_SPACE_BITS);
> +
> +    /* TODO: method to report supported PASID bits */
> +    s->pasid_bits = 8; /* restricted to size of MemTxAttrs.pasid */
> +    s->cap |= RISCV_IOMMU_CAP_PD8;
> +
> +    /* Out-of-reset translation mode: OFF (DMA disabled) BARE (passthrough) */
> +    s->ddtp = set_field(0, RISCV_IOMMU_DDTP_MODE, s->enable_off ?
> +                        RISCV_IOMMU_DDTP_MODE_OFF : RISCV_IOMMU_DDTP_MODE_BARE);
> +
> +    /* register storage */
> +    s->regs_rw = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
> +    s->regs_ro = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
> +    s->regs_wc = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
> +
> +     /* Mark all registers read-only */
> +    memset(s->regs_ro, 0xff, RISCV_IOMMU_REG_SIZE);
> +
> +    /*
> +     * Register complete MMIO space, including MSI/PBA registers.
> +     * Note, PCIDevice implementation will add overlapping MR for MSI/PBA,
> +     * managed directly by the PCIDevice implementation.
> +     */
> +    memory_region_init_io(&s->regs_mr, OBJECT(dev), &riscv_iommu_mmio_ops, s,
> +        "riscv-iommu-regs", RISCV_IOMMU_REG_SIZE);
> +
> +    /* Set power-on register state */
> +    stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_CAP], s->cap);
> +    stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_FCTL], 0);
> +    stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_DDTP],
> +        ~(RISCV_IOMMU_DDTP_PPN | RISCV_IOMMU_DDTP_MODE));
> +    stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQB],
> +        ~(RISCV_IOMMU_CQB_LOG2SZ | RISCV_IOMMU_CQB_PPN));
> +    stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_FQB],
> +        ~(RISCV_IOMMU_FQB_LOG2SZ | RISCV_IOMMU_FQB_PPN));
> +    stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_PQB],
> +        ~(RISCV_IOMMU_PQB_LOG2SZ | RISCV_IOMMU_PQB_PPN));
> +    stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_CQCSR], RISCV_IOMMU_CQCSR_CQMF |
> +        RISCV_IOMMU_CQCSR_CMD_TO | RISCV_IOMMU_CQCSR_CMD_ILL);
> +    stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQCSR], RISCV_IOMMU_CQCSR_CQON |
> +        RISCV_IOMMU_CQCSR_BUSY);
> +    stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_FQCSR], RISCV_IOMMU_FQCSR_FQMF |
> +        RISCV_IOMMU_FQCSR_FQOF);
> +    stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_FQCSR], RISCV_IOMMU_FQCSR_FQON |
> +        RISCV_IOMMU_FQCSR_BUSY);
> +    stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_PQCSR], RISCV_IOMMU_PQCSR_PQMF |
> +        RISCV_IOMMU_PQCSR_PQOF);
> +    stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_PQCSR], RISCV_IOMMU_PQCSR_PQON |
> +        RISCV_IOMMU_PQCSR_BUSY);
> +    stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_IPSR], ~0);
> +    stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_IVEC], 0);
> +    stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_DDTP], s->ddtp);
> +
> +    /* Memory region for downstream access, if specified. */
> +    if (s->target_mr) {
> +        s->target_as = g_new0(AddressSpace, 1);
> +        address_space_init(s->target_as, s->target_mr,
> +            "riscv-iommu-downstream");
> +    } else {
> +        /* Fallback to global system memory. */
> +        s->target_as = &address_space_memory;
> +    }
> +
> +    /* Memory region for untranslated MRIF/MSI writes */
> +    memory_region_init_io(&s->trap_mr, OBJECT(dev), &riscv_iommu_trap_ops, s,
> +            "riscv-iommu-trap", ~0ULL);
> +    address_space_init(&s->trap_as, &s->trap_mr, "riscv-iommu-trap-as");
> +
> +    /* Device translation context cache */
> +    s->ctx_cache = g_hash_table_new_full(__ctx_hash, __ctx_equal,
> +                                         g_free, NULL);
> +
> +    s->iommus.le_next = NULL;
> +    s->iommus.le_prev = NULL;
> +    QLIST_INIT(&s->spaces);
> +    qemu_mutex_init(&s->core_lock);
> +    qemu_spin_init(&s->regs_lock);
> +}
> +
> +static void riscv_iommu_unrealize(DeviceState *dev)
> +{
> +    RISCVIOMMUState *s = RISCV_IOMMU(dev);
> +
> +    qemu_mutex_destroy(&s->core_lock);
> +    g_hash_table_unref(s->ctx_cache);
> +}
> +
> +static Property riscv_iommu_properties[] = {
> +    DEFINE_PROP_UINT32("version", RISCVIOMMUState, version,
> +        RISCV_IOMMU_SPEC_DOT_VER),
> +    DEFINE_PROP_UINT32("bus", RISCVIOMMUState, bus, 0x0),
> +    DEFINE_PROP_BOOL("intremap", RISCVIOMMUState, enable_msi, TRUE),
> +    DEFINE_PROP_BOOL("off", RISCVIOMMUState, enable_off, TRUE),
> +    DEFINE_PROP_LINK("downstream-mr", RISCVIOMMUState, target_mr,
> +        TYPE_MEMORY_REGION, MemoryRegion *),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void riscv_iommu_class_init(ObjectClass *klass, void* data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    /* internal device for riscv-iommu-{pci/sys}, not user-creatable */
> +    dc->user_creatable = false;
> +    dc->realize = riscv_iommu_realize;
> +    dc->unrealize = riscv_iommu_unrealize;
> +    device_class_set_props(dc, riscv_iommu_properties);
> +}
> +
> +static const TypeInfo riscv_iommu_info = {
> +    .name = TYPE_RISCV_IOMMU,
> +    .parent = TYPE_DEVICE,
> +    .instance_size = sizeof(RISCVIOMMUState),
> +    .class_init = riscv_iommu_class_init,
> +};
> +
> +static const char *IOMMU_FLAG_STR[] = {
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
> +    RISCVIOMMUSpace *as = container_of(iommu_mr, RISCVIOMMUSpace, iova_mr);
> +    RISCVIOMMUContext *ctx;
> +    void *ref;
> +    IOMMUTLBEntry iotlb = {
> +        .iova = addr,
> +        .target_as = as->iommu->target_as,
> +        .addr_mask = ~0ULL,
> +        .perm = flag,
> +    };
> +
> +    ctx = riscv_iommu_ctx(as->iommu, as->devid, iommu_idx, &ref);
> +    if (ctx == NULL) {
> +        /* Translation disabled or invalid. */
> +        iotlb.addr_mask = 0;
> +        iotlb.perm = IOMMU_NONE;
> +    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb)) {
> +        /* Translation disabled or fault reported. */
> +        iotlb.addr_mask = 0;
> +        iotlb.perm = IOMMU_NONE;
> +    }
> +
> +    /* Trace all dma translations with original access flags. */
> +    trace_riscv_iommu_dma(as->iommu->parent_obj.id, PCI_BUS_NUM(as->devid),
> +                          PCI_SLOT(as->devid), PCI_FUNC(as->devid), iommu_idx,
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
> +    RISCVIOMMUSpace *as = container_of(iommu_mr, RISCVIOMMUSpace, iova_mr);
> +
> +    if (old == IOMMU_NOTIFIER_NONE) {
> +        as->notifier = true;
> +        trace_riscv_iommu_notifier_add(iommu_mr->parent_obj.name);
> +    } else if (new == IOMMU_NOTIFIER_NONE) {
> +        as->notifier = false;
> +        trace_riscv_iommu_notifier_del(iommu_mr->parent_obj.name);
> +    }
> +
> +    return 0;
> +}
> +
> +static inline bool pci_is_iommu(PCIDevice *pdev)
> +{
> +    return pci_get_word(pdev->config + PCI_CLASS_DEVICE) == 0x0806;
> +}
> +
> +static AddressSpace *riscv_iommu_find_as(PCIBus *bus, void *opaque, int devfn)
> +{
> +    RISCVIOMMUState *s = (RISCVIOMMUState *) opaque;
> +    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
> +    AddressSpace *as = NULL;
> +
> +    if (pdev && pci_is_iommu(pdev)) {
> +        return s->target_as;
> +    }
> +
> +    /* Find first registered IOMMU device */
> +    while (s->iommus.le_prev) {
> +        s = *(s->iommus.le_prev);
> +    }
> +
> +    /* Find first matching IOMMU */
> +    while (s != NULL && as == NULL) {
> +        as = riscv_iommu_space(s, PCI_BUILD_BDF(pci_bus_num(bus), devfn));
> +        s = s->iommus.le_next;
> +    }
> +
> +    return as ? as : &address_space_memory;
> +}
> +
> +static const PCIIOMMUOps riscv_iommu_ops = {
> +    .get_address_space = riscv_iommu_find_as,
> +};
> +
> +void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
> +        Error **errp)
> +{
> +    if (bus->iommu_ops &&
> +        bus->iommu_ops->get_address_space == riscv_iommu_find_as) {
> +        /* Allow multiple IOMMUs on the same PCIe bus, link known devices */
> +        RISCVIOMMUState *last = (RISCVIOMMUState *)bus->iommu_opaque;
> +        QLIST_INSERT_AFTER(last, iommu, iommus);
> +    } else if (!bus->iommu_ops && !bus->iommu_opaque) {
> +        pci_setup_iommu(bus, &riscv_iommu_ops, iommu);
> +    } else {
> +        error_setg(errp, "can't register secondary IOMMU for PCI bus #%d",
> +            pci_bus_num(bus));
> +    }
> +}
> +
> +static int riscv_iommu_memory_region_index(IOMMUMemoryRegion *iommu_mr,
> +    MemTxAttrs attrs)
> +{
> +    return attrs.unspecified ? RISCV_IOMMU_NOPASID : (int)attrs.pasid;
> +}
> +
> +static int riscv_iommu_memory_region_index_len(IOMMUMemoryRegion *iommu_mr)
> +{
> +    RISCVIOMMUSpace *as = container_of(iommu_mr, RISCVIOMMUSpace, iova_mr);
> +    return 1 << as->iommu->pasid_bits;
> +}
> +
> +static void riscv_iommu_memory_region_init(ObjectClass *klass, void *data)
> +{
> +    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
> +
> +    imrc->translate = riscv_iommu_memory_region_translate;
> +    imrc->notify_flag_changed = riscv_iommu_memory_region_notify;
> +    imrc->attrs_to_index = riscv_iommu_memory_region_index;
> +    imrc->num_indexes = riscv_iommu_memory_region_index_len;
> +}
> +
> +static const TypeInfo riscv_iommu_memory_region_info = {
> +    .parent = TYPE_IOMMU_MEMORY_REGION,
> +    .name = TYPE_RISCV_IOMMU_MEMORY_REGION,
> +    .class_init = riscv_iommu_memory_region_init,
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
> index 0000000000..31d3907d33
> --- /dev/null
> +++ b/hw/riscv/riscv-iommu.h
> @@ -0,0 +1,141 @@
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
> + * You should have received a copy of the GNU General Public License along
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
> +    uint32_t pasid_bits;  /* process identifier width */
> +    uint32_t bus;         /* PCI bus mapping for non-root endpoints */
> +
> +    uint64_t cap;         /* IOMMU supported capabilities */
> +    uint64_t fctl;        /* IOMMU enabled features */
> +
> +    bool enable_off;      /* Enable out-of-reset OFF mode (DMA disabled) */
> +    bool enable_msi;      /* Enable MSI remapping */
> +
> +    /* IOMMU Internal State */
> +    uint64_t ddtp;        /* Validated Device Directory Tree Root Pointer */
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
> +
> +    /* IOMMU State Machine */
> +    QemuThread core_proc; /* Background processing thread */
> +    QemuMutex core_lock;  /* Global IOMMU lock, used for cache/regs updates */
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
> +    GHashTable *ctx_cache;          /* Device translation Context Cache */
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
> +    val = ldl_le_p(s->regs_rw + idx);
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
> +    val = ldq_le_p(s->regs_rw + idx);
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
> index 0000000000..42a97caffa
> --- /dev/null
> +++ b/hw/riscv/trace-events
> @@ -0,0 +1,11 @@
> +# See documentation at docs/devel/tracing.rst
> +
> +# riscv-iommu.c
> +riscv_iommu_new(const char *id, unsigned b, unsigned d, unsigned f) "%s: device attached %04x:%02x.%d"
> +riscv_iommu_flt(const char *id, unsigned b, unsigned d, unsigned f, uint64_t reason, uint64_t iova) "%s: fault %04x:%02x.%u reason: 0x%"PRIx64" iova: 0x%"PRIx64
> +riscv_iommu_pri(const char *id, unsigned b, unsigned d, unsigned f, uint64_t iova) "%s: page request %04x:%02x.%u iova: 0x%"PRIx64
> +riscv_iommu_dma(const char *id, unsigned b, unsigned d, unsigned f, unsigned pasid, const char *dir, uint64_t iova, uint64_t phys) "%s: translate %04x:%02x.%u #%u %s 0x%"PRIx64" -> 0x%"PRIx64
> +riscv_iommu_msi(const char *id, unsigned b, unsigned d, unsigned f, uint64_t iova, uint64_t phys) "%s: translate %04x:%02x.%u MSI 0x%"PRIx64" -> 0x%"PRIx64
> +riscv_iommu_cmd(const char *id, uint64_t l, uint64_t u) "%s: command 0x%"PRIx64" 0x%"PRIx64
> +riscv_iommu_notifier_add(const char *id) "%s: dev-iotlb notifier added"
> +riscv_iommu_notifier_del(const char *id) "%s: dev-iotlb notifier removed"
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
> + * You should have received a copy of the GNU General Public License along
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
> index a9de71d450..8099d8271c 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3319,6 +3319,7 @@ if have_system
>       'hw/pci-host',
>       'hw/ppc',
>       'hw/rtc',
> +    'hw/riscv',
>       'hw/s390x',
>       'hw/scsi',
>       'hw/sd',


