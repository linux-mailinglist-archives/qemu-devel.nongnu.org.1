Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAD6826FAC
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 14:26:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMpe6-0002lp-2P; Mon, 08 Jan 2024 08:26:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rMpdq-0002lR-Ns
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 08:26:10 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rMpdn-00061r-L6
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 08:26:10 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a1915034144so180080866b.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 05:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704720364; x=1705325164; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/KZ62goZuNjVqXyNsftNtz/FVUsZoAdoqOHBRqA+dis=;
 b=Ppec/0gKGEg/TTn9LwKPYcKTR5K7ZcOPauQtyMRt1djT3m1OqCM9D90TVy1Obgr8RL
 wpy8LKcG7RB7hYhWLWH7veB+ytW4jOiv7hnc+Xq0fUzizZC8TRyoI3SVTbmBgCbyblSR
 MWWPFvCJ5889lPxmDLUkQi1V8aWKEgkyT+bzRe7ytVOKS4ig7S1TI7niqRaySttp+23S
 IIn+5MyfVQUUAXy46sBo2SMsl5OlWhSgZaI2hPYZJ57jMYd0enQKIWMbFTNTDdmMwDNT
 dygRm0WcEeXw05qKtM+sfYSsxfPrDy3OkXWHHDeQyY0y47fJcopJfxwIA4iA4m6RDTmD
 i7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704720364; x=1705325164;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/KZ62goZuNjVqXyNsftNtz/FVUsZoAdoqOHBRqA+dis=;
 b=mAiitKYAe+0zy9cp6JrwNORQ0X3PsYkq2Dyvq2kBZVl7NrN2wbvDJNCkfMp6LSDUuR
 AbTGdpjcZ9mNbAtH6A4fpiCTwns4oiApvPgunPEgnV34BDpifVPFtAD2bycApoi8yG0r
 41N97gEk6nPcb+oT/tk+UCuOe/a5YJ8caDDiUFLIazsaD+Bh8a67eJS0CQ2yqUEyzmQ7
 hj+qMvH9BneGPBaZ5CB3GttdS0kszmTrvTBD2lXDEc3t6MhnHBIK6jN2jHznCcc7DYqJ
 CIbakswLGVCsAdb0WItsFxBSXILUzmLsWeZoza/ftODzLm8ALzF3Kka0J2YpNdAX9NiT
 aLbg==
X-Gm-Message-State: AOJu0YzS7+hcbpAvnkc9TrLci/SCIsjC/SegjXMqM1aZlZgQwRL14Qo8
 wczuUXKJ2EqsMz9NSuTXVQuBTKZzSWnSZg==
X-Google-Smtp-Source: AGHT+IHOueXGaR9PrrVoYzh2Wi3EHPne/bLqyUH+pnRriXa1r7WmAE7PyMl8X9PoDa2Su7Bm9Lc87A==
X-Received: by 2002:a17:907:31c1:b0:a28:e42e:12da with SMTP id
 xf1-20020a17090731c100b00a28e42e12damr2046403ejb.61.1704720364064; 
 Mon, 08 Jan 2024 05:26:04 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 w16-20020a17090633d000b00a269f8e8869sm3921107eja.128.2024.01.08.05.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 05:26:03 -0800 (PST)
Date: Mon, 8 Jan 2024 14:26:02 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Conor Dooley <conor@kernel.org>
Cc: qemu-riscv@nongnu.org, Conor Dooley <conor.dooley@microchip.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] riscv: support new isa extension detection devicetree
 properties
Message-ID: <20240108-5648f1bbf24e9dd4170a20e2@orel>
References: <20231208-sponge-thickness-c0e9511b1baf@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208-sponge-thickness-c0e9511b1baf@spud>
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Dec 08, 2023 at 12:07:22PM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> A few months ago I submitted a patch to various lists, deprecating
> "riscv,isa" with a lengthy commit message [0] that is now commit
> aeb71e42caae ("dt-bindings: riscv: deprecate riscv,isa") in the Linux
> kernel tree. Primarily, the goal was to replace "riscv,isa" with a new
> set of properties that allowed for strictly defining the meaning of
> various extensions, where "riscv,isa" was tied to whatever definitions
> inflicted upon us by the ISA manual, which have seen some variance over
> time.
> 
> Two new properties were introduced: "riscv,isa-base" and
> "riscv,isa-extensions". The former is a simple string to communicate the
> base ISA implemented by a hart and the latter an array of strings used
> to communicate the set of ISA extensions supported, per the definitions
> of each substring in extensions.yaml [1]. A beneficial side effect was
> also the ability to define vendor extensions in a more "official" way,
> as the ISA manual and other RVI specifications only covered the format
> for vendor extensions in the ISA string, but not the meaning of vendor
> extensions, for obvious reasons.
> 
> Add support for setting these two new properties in the devicetrees for
> the various devicetree platforms supported by QEMU for RISC-V. The Linux
> kernel already supports parsing ISA extensions from these new
> properties, and documenting them in the dt-binding is a requirement for
> new extension detection being added to the kernel.
> 
> A side effect of the implementation is that the meaning for elements in
> "riscv,isa" and in "riscv,isa-extensions" are now tied together as they
> are constructed from the same source. The same applies to the ISA string
> provided in ACPI tables, but there does not appear to be any strict
> definitions of meanings in ACPI land either.
> 
> Link: https://lore.kernel.org/qemu-riscv/20230702-eats-scorebook-c951f170d29f@spud/ [0]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/riscv/extensions.yaml [1]
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changes in v2:
> - use g_strdup() for multiletter extension string copying
> - wrap stuff in #ifndef to prevent breaking the user mode build
> - rename riscv_isa_set_props() -> riscv_isa_write_fdt()
> 
> CC: Alistair Francis <Alistair.Francis@wdc.com>
> CC: Bin Meng <bin.meng@windriver.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: Weiwei Li <liwei1518@gmail.com>
> CC: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> CC: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> CC: qemu-riscv@nongnu.org
> CC: qemu-devel@nongnu.org
> ---
>  hw/riscv/sifive_u.c |  7 ++-----
>  hw/riscv/spike.c    |  6 ++----
>  hw/riscv/virt.c     |  6 ++----
>  target/riscv/cpu.c  | 50 +++++++++++++++++++++++++++++++++++++++++++++
>  target/riscv/cpu.h  |  1 +
>  5 files changed, 57 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index ec76dce6c9..2f227f15bc 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -171,7 +171,6 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
>          int cpu_phandle = phandle++;
>          nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
>          char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
> -        char *isa;
>          qemu_fdt_add_subnode(fdt, nodename);
>          /* cpu 0 is the management hart that does not have mmu */
>          if (cpu != 0) {
> @@ -180,11 +179,10 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
>              } else {
>                  qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
>              }
> -            isa = riscv_isa_string(&s->soc.u_cpus.harts[cpu - 1]);
> +            riscv_isa_write_fdt(&s->soc.u_cpus.harts[cpu - 1], fdt, nodename);
>          } else {
> -            isa = riscv_isa_string(&s->soc.e_cpus.harts[0]);
> +            riscv_isa_write_fdt(&s->soc.e_cpus.harts[0], fdt, nodename);
>          }
> -        qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", isa);
>          qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
>          qemu_fdt_setprop_string(fdt, nodename, "status", "okay");
>          qemu_fdt_setprop_cell(fdt, nodename, "reg", cpu);
> @@ -194,7 +192,6 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
>          qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
>          qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
>          qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
> -        g_free(isa);
>          g_free(intc);
>          g_free(nodename);
>      }
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 81f7e53aed..64074395bc 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -59,7 +59,7 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
>      MachineState *ms = MACHINE(s);
>      uint32_t *clint_cells;
>      uint32_t cpu_phandle, intc_phandle, phandle = 1;
> -    char *name, *mem_name, *clint_name, *clust_name;
> +    char *mem_name, *clint_name, *clust_name;
>      char *core_name, *cpu_name, *intc_name;
>      static const char * const clint_compat[2] = {
>          "sifive,clint0", "riscv,clint0"
> @@ -113,9 +113,7 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
>              } else {
>                  qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", "riscv,sv48");
>              }
> -            name = riscv_isa_string(&s->soc[socket].harts[cpu]);
> -            qemu_fdt_setprop_string(fdt, cpu_name, "riscv,isa", name);
> -            g_free(name);
> +            riscv_isa_write_fdt(&s->soc[socket].harts[cpu], fdt, cpu_name);
>              qemu_fdt_setprop_string(fdt, cpu_name, "compatible", "riscv");
>              qemu_fdt_setprop_string(fdt, cpu_name, "status", "okay");
>              qemu_fdt_setprop_cell(fdt, cpu_name, "reg",
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index c7fc97e273..05beb0a297 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -238,7 +238,7 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
>      int cpu;
>      uint32_t cpu_phandle;
>      MachineState *ms = MACHINE(s);
> -    char *name, *cpu_name, *core_name, *intc_name, *sv_name;
> +    char *cpu_name, *core_name, *intc_name, *sv_name;
>      bool is_32_bit = riscv_is_32bit(&s->soc[0]);
>      uint8_t satp_mode_max;
>  
> @@ -259,9 +259,7 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
>              g_free(sv_name);
>          }
>  
> -        name = riscv_isa_string(cpu_ptr);
> -        qemu_fdt_setprop_string(ms->fdt, cpu_name, "riscv,isa", name);
> -        g_free(name);
> +        riscv_isa_write_fdt(cpu_ptr, ms->fdt, cpu_name);
>  
>          if (cpu_ptr->cfg.ext_zicbom) {
>              qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cbom-block-size",
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 83c7c0cf07..ce413b9f00 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -31,6 +31,7 @@
>  #include "hw/qdev-properties.h"
>  #include "migration/vmstate.h"
>  #include "fpu/softfloat-helpers.h"
> +#include "sysemu/device_tree.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/tcg.h"
>  #include "kvm/kvm_riscv.h"
> @@ -1735,6 +1736,55 @@ char *riscv_isa_string(RISCVCPU *cpu)
>      return isa_str;
>  }
>  
> +#ifndef CONFIG_USER_ONLY
> +static char **riscv_isa_extensions_list(RISCVCPU *cpu, int *count)
> +{
> +    int maxlen = ARRAY_SIZE(riscv_single_letter_exts) + ARRAY_SIZE(isa_edata_arr);
> +    char **extensions = g_new(char *, maxlen);
> +
> +    for (int i = 0; i < sizeof(riscv_single_letter_exts) - 1; i++) {
> +        if (cpu->env.misa_ext & RV(riscv_single_letter_exts[i])) {
> +            extensions[*count] = g_new(char, 2);
> +            snprintf(extensions[*count], 2, "%c",
> +                     qemu_tolower(riscv_single_letter_exts[i]));
> +            (*count)++;
> +        }
> +    }
> +
> +    for (const RISCVIsaExtData *edata = isa_edata_arr; edata && edata->name; edata++) {
                                                          ^ edata can never
							  be NULL
				(I know riscv_isa_string_ext() also has
				that check though...)

> +        if (isa_ext_is_enabled(cpu, edata->ext_enable_offset)) {
> +            extensions[*count] = g_strdup(edata->name);
> +            (*count)++;
> +        }
> +    }
> +
> +    return extensions;
> +}
> +
> +void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
> +{
> +    const size_t maxlen = sizeof("rv128i");
> +    g_autofree char *isa_base = g_new(char, maxlen);
> +    g_autofree char *riscv_isa;
> +    char **isa_extensions;
> +    int count = 0;
> +
> +    riscv_isa = riscv_isa_string(cpu);
> +    qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", riscv_isa);
> +
> +    snprintf(isa_base, maxlen, "rv%di", TARGET_LONG_BITS);
> +    qemu_fdt_setprop_string(fdt, nodename, "riscv,isa-base", isa_base);
> +
> +    isa_extensions = riscv_isa_extensions_list(cpu, &count);
> +    qemu_fdt_setprop_string_array(fdt, nodename, "riscv,isa-extensions",
> +                                  isa_extensions, count);
> +
> +    for (int i = 0; i < count; i++) {
> +        g_free(isa_extensions[i]);
> +    }

Need g_free(isa_extensions) here.

> +}
> +#endif
> +
>  static gint riscv_cpu_list_compare(gconstpointer a, gconstpointer b)
>  {
>      ObjectClass *class_a = (ObjectClass *)a;
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index bf58b0f0b5..5bbce607c4 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -496,6 +496,7 @@ void riscv_cpu_list(void);
>  #define cpu_mmu_index riscv_cpu_mmu_index
>  
>  #ifndef CONFIG_USER_ONLY
> +void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename);
>  void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
>                                       vaddr addr, unsigned size,
>                                       MMUAccessType access_type,
> -- 
> 2.39.2
> 
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

