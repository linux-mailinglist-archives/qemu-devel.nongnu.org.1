Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D8C74772B
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 18:49:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGjBe-0004dC-OE; Tue, 04 Jul 2023 12:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qGjBN-0004Yg-7Z
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:47:17 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qGjBK-0003vB-In
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:47:16 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-991c786369cso687578166b.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 09:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688489233; x=1691081233;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zJweUlL8jpuH6TdCrjCcdHLe7fHUENdBl4BUr9GcBSQ=;
 b=KvteLZr5Sp4VSxcMoimAPi7qPFuw4JACj1y3n6ehWq60SBbkswg3Y8CRS3RUg2xlSe
 tVoYmrYZt0ow1SBIlzng4UNPAisa+YzzanykIAgMtvCz0R5ND7gEVt2oRwp+KdwRrLh/
 3pYCRN84wyw00KMDwHTd5JBZGyn7G2sCuuyPOXPDDZLEvUFhtAOILVjikkgNa1hoE5FN
 z1Z934t483t5bx81Sp/zSqai0LyBDBddJfkHqf4tV0406wOCN6MkF3JWHeLMPmt8jLtR
 nOwo3EEMq4MAlHmsblHBE6kaSsKL7xZc3skR7LUJJR4xalc3s+d4eXvkNf+F6TDE9tsE
 3Zrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688489233; x=1691081233;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zJweUlL8jpuH6TdCrjCcdHLe7fHUENdBl4BUr9GcBSQ=;
 b=S3ZapaOiF0lB7OPuCXVc8jlLOr4ukjrh2vJmqonjqY2d9QpTWRJ/yCPV84cfT3xGt9
 38z2Bb5hpzU7ATckp5it94ESYPv6grSXsMKpgzwQNYj+rotTATO8MiIVJy/Uy7dPb7vA
 u9qmRNqKWFRQI+pzKHngm1LsjZ+H5OagU7kDP5unQ7qz99IBOWag43eOoENl2PFQa83D
 CTR4/zfGyu1dYf2QpAZ5pYnx8XRziBOP8tM60qaRkbs3EzwgzUCt8ydTgGwoZu++0+KJ
 8hfdXcnMDVFO3xpdDF7UjO0BUzvUaBkk+T9+m3XOvrYCBZosVAZnAdP/7oHrf6aYaT/t
 AbcA==
X-Gm-Message-State: ABy/qLagXxqpZv02Zi2OYCt8oVSKn0OlX8iSE5U/W6RyeKmkiIYc+Djj
 BSHIUA4FNYLOtUg11/q+RMh0Vw==
X-Google-Smtp-Source: APBJJlEQScK7FiYbijQBX+qsCch91wF0qTtxg0kkEceMNpDS0OHkA9B3VgN0E3IxR2pB/IxZg2JafQ==
X-Received: by 2002:a17:906:5904:b0:991:e7c3:5712 with SMTP id
 h4-20020a170906590400b00991e7c35712mr10441231ejq.30.1688489232774; 
 Tue, 04 Jul 2023 09:47:12 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 kq2-20020a170906abc200b009929c39d5c4sm7899725ejb.36.2023.07.04.09.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 09:47:12 -0700 (PDT)
Date: Tue, 4 Jul 2023 18:47:10 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, rkanwal@rivosinc.com, 
 anup@brainfault.org, dbarboza@ventanamicro.com, atishp@atishpatra.org, 
 vincent.chen@sifive.com, greentime.hu@sifive.com, frank.chang@sifive.com, 
 jim.shu@sifive.com, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 6/6] target/riscv: select KVM AIA in riscv virt machine
Message-ID: <20230704-e07a2725be51e48fea6e9e05@orel>
References: <20230621145500.25624-1-yongxuan.wang@sifive.com>
 <20230621145500.25624-7-yongxuan.wang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621145500.25624-7-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x632.google.com
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

On Wed, Jun 21, 2023 at 02:54:56PM +0000, Yong-Xuan Wang wrote:
> Select KVM AIA when the host kernel has in-kernel AIA chip support.
> Since KVM AIA only has one APLIC instance, we map the QEMU APLIC
> devices to KVM APLIC.
> We also extend virt machine to specify the KVM AIA mode. The "kvm-aia"
> parameter is passed along with machine name in QEMU command-line.
> 1) "kvm-aia=emul": IMSIC is emulated by hypervisor
> 2) "kvm-aia=hwaccel": use hardware guest IMSIC
> 3) "kvm-aia=auto": use the hardware guest IMSICs whenever available
>                    otherwise we fallback to software emulation.
> 
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>
> ---
>  hw/riscv/virt.c         | 92 ++++++++++++++++++++++++++++++++++-------
>  include/hw/riscv/virt.h |  1 +
>  2 files changed, 79 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 4a1d29a741..efa176a184 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -35,6 +35,7 @@
>  #include "hw/riscv/virt.h"
>  #include "hw/riscv/boot.h"
>  #include "hw/riscv/numa.h"
> +#include "kvm_riscv.h"
>  #include "hw/intc/riscv_aclint.h"
>  #include "hw/intc/riscv_aplic.h"
>  #include "hw/intc/riscv_imsic.h"
> @@ -74,6 +75,12 @@
>  #error "Can't accomodate all IMSIC groups in address space"
>  #endif
>  
> +/* KVM AIA only supports APLIC.m. APLIC.w is always emulated by QEMU. */

"APLIC MSI" and "APLIC Wired"

> +static bool virt_use_kvm_aia(RISCVVirtState *s)
> +{
> +    return kvm_irqchip_in_kernel() && s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
> +}
> +
>  static const MemMapEntry virt_memmap[] = {
>      [VIRT_DEBUG] =        {        0x0,         0x100 },
>      [VIRT_MROM] =         {     0x1000,        0xf000 },
> @@ -642,7 +649,8 @@ static void create_fdt_socket_aplic(RISCVVirtState *s,
>                                      uint32_t msi_s_phandle,
>                                      uint32_t *phandle,
>                                      uint32_t *intc_phandles,
> -                                    uint32_t *aplic_phandles)
> +                                    uint32_t *aplic_phandles,
> +                                    int num_harts)
>  {
>      int cpu;
>      char *aplic_name;
> @@ -653,11 +661,11 @@ static void create_fdt_socket_aplic(RISCVVirtState *s,
>  
>      aplic_m_phandle = (*phandle)++;
>      aplic_s_phandle = (*phandle)++;
> -    aplic_cells = g_new0(uint32_t, s->soc[socket].num_harts * 2);
> +    aplic_cells = g_new0(uint32_t, num_harts * 2);
>  
>      if (!kvm_enabled()) {
>          /* M-level APLIC node */
> -        for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
> +        for (cpu = 0; cpu < num_harts; cpu++) {
>              aplic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
>              aplic_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_M_EXT);
>          }

There are a couple other instances of s->soc[socket].num_harts in this
function that can be changed to num_harts.

> @@ -691,7 +699,7 @@ static void create_fdt_socket_aplic(RISCVVirtState *s,
>      }
>  
>      /* S-level APLIC node */
> -    for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
> +    for (cpu = 0; cpu < num_harts; cpu++) {
>          aplic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
>          aplic_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_S_EXT);
>      }
> @@ -798,17 +806,25 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
>          *msi_pcie_phandle = msi_s_phandle;
>      }
>  
> -    phandle_pos = ms->smp.cpus;
> -    for (socket = (socket_count - 1); socket >= 0; socket--) {
> -        phandle_pos -= s->soc[socket].num_harts;
> +    /* KVM AIA only has one APLIC instance */
> +    if (virt_use_kvm_aia(s)) {
> +        create_fdt_socket_aplic(s, memmap, 0,
> +            msi_m_phandle, msi_s_phandle, phandle,
> +            &intc_phandles[0], xplic_phandles, ms->smp.cpus);
> +    } else {
> +        phandle_pos = ms->smp.cpus;
> +        for (socket = (socket_count - 1); socket >= 0; socket--) {
> +            phandle_pos -= s->soc[socket].num_harts;
>  
> -        if (s->aia_type == VIRT_AIA_TYPE_NONE) {
> -            create_fdt_socket_plic(s, memmap, socket, phandle,
> -                &intc_phandles[phandle_pos], xplic_phandles);
> -        } else {
> -            create_fdt_socket_aplic(s, memmap, socket,
> -                msi_m_phandle, msi_s_phandle, phandle,
> -                &intc_phandles[phandle_pos], xplic_phandles);
> +            if (s->aia_type == VIRT_AIA_TYPE_NONE) {
> +                create_fdt_socket_plic(s, memmap, socket, phandle,
> +                    &intc_phandles[phandle_pos], xplic_phandles);
> +            } else {
> +                create_fdt_socket_aplic(s, memmap, socket,
> +                    msi_m_phandle, msi_s_phandle, phandle,
> +                    &intc_phandles[phandle_pos], xplic_phandles,
> +                    s->soc[socket].num_harts);
> +            }
>          }
>      }
>  
> @@ -819,6 +835,9 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
>              *irq_mmio_phandle = xplic_phandles[socket];
>              *irq_virtio_phandle = xplic_phandles[socket];
>              *irq_pcie_phandle = xplic_phandles[socket];
> +
> +            if (virt_use_kvm_aia(s))
> +                break;

Need {}. Doesn't checkpatch complain about that? But this break is a bit
hacky. Duplicating the three phandle assignments above into the 'if
(virt_use_kvm_aia(s)) {' block above and putting this for loop into the
else block above would be neater.

>          }
>          if (socket == 1) {
>              *irq_virtio_phandle = xplic_phandles[socket];
> @@ -1454,6 +1473,14 @@ static void virt_machine_init(MachineState *machine)
>          }
>      }
>  
> +    if (virt_use_kvm_aia(s)) {
> +        kvm_riscv_aia_create(
> +            machine, s->kvm_aia_mode, IMSIC_MMIO_GROUP_MIN_SHIFT,
> +            VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_NUM_MSIS,
> +            memmap[VIRT_APLIC_S].base, memmap[VIRT_IMSIC_S].base,
> +            s->aia_guests);
> +    }
> +
>      if (riscv_is_32bit(&s->soc[0])) {
>  #if HOST_LONG_BITS == 64
>          /* limit RAM size in a 32-bit system */
> @@ -1610,6 +1637,31 @@ static void virt_set_aia(Object *obj, const char *val, Error **errp)
>      }
>  }
>  
> +#if defined(CONFIG_KVM)
> +static char *virt_get_kvm_aia(Object *obj, Error **errp)
> +{
> +    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
> +
> +    return kvm_aia_mode_str(s->kvm_aia_mode);

I was wondering why kvm_aia_mode_str() was export from target/riscv/kvm.c
and now I see why it was also using strdup. I'd just do the strdup here
though and return static strings from kvm_aia_mode_str().

> +}
> +
> +static void virt_set_kvm_aia(Object *obj, const char *val, Error **errp)
> +{
> +    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
> +
> +    if (!strcmp(val, "emul")) {
> +        s->kvm_aia_mode = KVM_DEV_RISCV_AIA_MODE_EMUL;
> +    } else if (!strcmp(val, "hwaccel")) {
> +        s->kvm_aia_mode = KVM_DEV_RISCV_AIA_MODE_HWACCEL;
> +    } else if (!strcmp(val, "auto")) {
> +        s->kvm_aia_mode = KVM_DEV_RISCV_AIA_MODE_AUTO;
> +    } else {
> +        error_setg(errp, "Invalid KVM AIA mode");
> +        error_append_hint(errp, "Valid values are emul, hwaccel, and auto.\n");
> +    }
> +}
> +#endif
> +
>  static bool virt_get_aclint(Object *obj, Error **errp)
>  {
>      RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
> @@ -1717,6 +1769,18 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>      sprintf(str, "Set number of guest MMIO pages for AIA IMSIC. Valid value "
>                   "should be between 0 and %d.", VIRT_IRQCHIP_MAX_GUESTS);
>      object_class_property_set_description(oc, "aia-guests", str);
> +
> +#if defined(CONFIG_KVM)
> +    object_class_property_add_str(oc, "kvm-aia", virt_get_kvm_aia,
> +                                  virt_set_kvm_aia);
> +    object_class_property_set_description(oc, "kvm-aia",
> +                                          "Set KVM AIA mode. Valid values are "
> +                                          "emul, hwaccel, and auto. Default "
> +                                          "is auto.");
> +    object_property_set_default_str(object_class_property_find(oc, "kvm-aia"),
> +                                    "auto");
> +
> +#endif
>      object_class_property_add(oc, "acpi", "OnOffAuto",
>                                virt_get_acpi, virt_set_acpi,
>                                NULL, NULL);
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index e5c474b26e..d0140feeff 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -56,6 +56,7 @@ struct RISCVVirtState {
>      bool have_aclint;
>      RISCVVirtAIAType aia_type;
>      int aia_guests;
> +    uint64_t kvm_aia_mode;
>      char *oem_id;
>      char *oem_table_id;
>      OnOffAuto acpi;
> -- 
> 2.17.1
> 
>

Thanks,
drew

