Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8837D7EC9
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 10:48:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvw1D-0008T3-Kl; Thu, 26 Oct 2023 04:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qvw1B-0008Kr-5w
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:47:05 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qvw16-0001IR-DD
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:47:03 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9c773ac9b15so92984066b.2
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 01:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698310019; x=1698914819; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IFtUJqN8RXDBVxR6XWHF5t0f8JlTA/DH3EjVR7LD90g=;
 b=MRGgxS07DbrFDcm++HZ+5nLb8wHOrw1SRc6n2mWXxN83Jqlf6+UECS1NjFNu1meEVe
 cXHgl+c7prDE+AeCHIeMP4yikEVKUOysGsxp0DdgtIiiM6PTUz8cqLIhUPGTKDugxQ4r
 VbOCPfMlQwsDDpbSD2hXSwlhAThcNrZiQapGXXF8heVUFvM8jr14upHu1ElzxHt+6ZOW
 i0CK0ROeiYYkHJafEgOQv4a37EsIdsEnaNAvsmAM9s8g/Xk8k3pKTQQ/tskAAnI+lgRm
 kpLv1MzxnCTUYCzRMUAKd19fJvXs4M9LOZRWEQB9wpv2QTF7PxDZQimcy+EYRdDqFl6s
 rjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698310019; x=1698914819;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IFtUJqN8RXDBVxR6XWHF5t0f8JlTA/DH3EjVR7LD90g=;
 b=wG+OVcWKNeemSSKbELyZMNejcUy/q6kxP3QwZfQWzX6gDRj2kI2eKiTrdZf9MdtQJ7
 0rZv9RlAWHj6SyE/tbgkBpPqcniUFtoxpLlyCZMheTV1WhKmwC2yKJQecyowHOfUhIjx
 qAq8LzVTUSbSRNaFTptpwlts45rISoiDzsXOFBFwTxzPr8kkc0jYY+yCAr8uujCEVBen
 QSNyrcarNMjhsNeNCfK9FMXAPtnguoTzbfbhcXUoxNkdYZyXCbfWyIek7RrEN1btqFi2
 C9Ufn09X+DEtpp8+KACpKzD6qdtf2+dSbmT04Ap+zOl82RieZzljIaO8LDWlgVnz8D0O
 joHQ==
X-Gm-Message-State: AOJu0YwRdl2sZC7G5SXjwMjXQGQNWrX9L2OdZ5Af2ARsL4AbIMLRGvGY
 ZqsCy02w1OhNr5KL3pJKqd4t9Q==
X-Google-Smtp-Source: AGHT+IGzNuCH/Lcto2duTvtwdccWVqPQnttmhm9q0SQFnm6WupvBm72AY7qoS1e9LqQPvnIwtX4Q7w==
X-Received: by 2002:a17:906:d554:b0:9c5:1047:50e8 with SMTP id
 cr20-20020a170906d55400b009c5104750e8mr14942602ejc.40.1698310018219; 
 Thu, 26 Oct 2023 01:46:58 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 og43-20020a1709071deb00b0098951bb4dc3sm11291803ejc.184.2023.10.26.01.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 01:46:57 -0700 (PDT)
Date: Thu, 26 Oct 2023 10:46:56 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Anup Patel <apatel@ventanamicro.com>,
 Atish Kumar Patra <atishp@rivosinc.com>, Haibo Xu <haibo1.xu@intel.com>
Subject: Re: [PATCH v4 05/13] hw/riscv/virt-acpi-build.c: Add AIA support in
 RINTC
Message-ID: <20231026-e3dba47934601608bc6a8cf8@orel>
References: <20231025200713.580814-1-sunilvl@ventanamicro.com>
 <20231025200713.580814-6-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025200713.580814-6-sunilvl@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Oct 26, 2023 at 01:37:05AM +0530, Sunil V L wrote:
> Update the RINTC structure in MADT with AIA related fields.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/virt-acpi-build.c | 66 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 62 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index d8772c2821..073c85f327 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -38,6 +38,7 @@
>  #include "hw/intc/riscv_aclint.h"
>  
>  #define ACPI_BUILD_TABLE_SIZE             0x20000
> +#define ACPI_BUILD_INTC_ID(socket, index) ((socket << 24) | (index))
>  
>  typedef struct AcpiBuildState {
>      /* Copy of table in RAM (for patching) */
> @@ -58,18 +59,42 @@ static void acpi_align_size(GArray *blob, unsigned align)
>  }
>  
>  static void riscv_acpi_madt_add_rintc(uint32_t uid,
> +                                      uint32_t local_cpu_id,
>                                        const CPUArchIdList *arch_ids,
> -                                      GArray *entry)
> +                                      GArray *entry,
> +                                      RISCVVirtAIAType aia_type,
> +                                      uint64_t imsic_addr,
> +                                      uint32_t imsic_size)
>  {
>      uint64_t hart_id = arch_ids->cpus[uid].arch_id;
>  
>      build_append_int_noprefix(entry, 0x18, 1);       /* Type     */
> -    build_append_int_noprefix(entry, 20, 1);         /* Length   */
> +    build_append_int_noprefix(entry, 36, 1);         /* Length   */
>      build_append_int_noprefix(entry, 1, 1);          /* Version  */
>      build_append_int_noprefix(entry, 0, 1);          /* Reserved */
>      build_append_int_noprefix(entry, 0x1, 4);        /* Flags    */
>      build_append_int_noprefix(entry, hart_id, 8);    /* Hart ID  */
>      build_append_int_noprefix(entry, uid, 4);        /* ACPI Processor UID */
> +    /* External Interrupt Controller ID */
> +    if (aia_type == VIRT_AIA_TYPE_APLIC) {
> +        build_append_int_noprefix(entry,
> +                                  ACPI_BUILD_INTC_ID(
> +                                      arch_ids->cpus[uid].props.node_id,
> +                                      local_cpu_id),
> +                                  4);
> +    } else {
> +        build_append_int_noprefix(entry, 0, 4);
> +    }
> +
> +    if (aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
> +        /* IMSIC Base address */
> +        build_append_int_noprefix(entry, imsic_addr, 8);
> +        /* IMSIC Size */
> +        build_append_int_noprefix(entry, imsic_size, 4);
> +    } else {
> +        build_append_int_noprefix(entry, 0, 8);
> +        build_append_int_noprefix(entry, 0, 4);
> +    }
>  }
>  
>  static void acpi_dsdt_add_cpus(Aml *scope, RISCVVirtState *s)
> @@ -77,6 +102,11 @@ static void acpi_dsdt_add_cpus(Aml *scope, RISCVVirtState *s)
>      MachineClass *mc = MACHINE_GET_CLASS(s);
>      MachineState *ms = MACHINE(s);
>      const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(ms);
> +    uint64_t imsic_socket_addr, imsic_addr;
> +    uint8_t  guest_index_bits;
> +    uint32_t imsic_size, local_cpu_id, socket_id;
> +
> +    guest_index_bits = imsic_num_bits(s->aia_guests + 1);
>  
>      for (int i = 0; i < arch_ids->len; i++) {
>              Aml *dev;
> @@ -87,8 +117,19 @@ static void acpi_dsdt_add_cpus(Aml *scope, RISCVVirtState *s)
>              aml_append(dev, aml_name_decl("_UID",
>                         aml_int(arch_ids->cpus[i].arch_id)));
>  
> +            socket_id = arch_ids->cpus[i].props.node_id;
> +            local_cpu_id = (arch_ids->cpus[i].arch_id -
> +                            riscv_socket_first_hartid(ms, socket_id)) %
> +                            riscv_socket_hart_count(ms, socket_id);
>              /* build _MAT object */
> -            riscv_acpi_madt_add_rintc(i, arch_ids, madt_buf);
> +            imsic_socket_addr = s->memmap[VIRT_IMSIC_S].base +
> +                                (socket_id * VIRT_IMSIC_GROUP_MAX_SIZE);
> +            imsic_addr = imsic_socket_addr +
> +                         local_cpu_id * IMSIC_HART_SIZE(guest_index_bits);
> +            imsic_size = IMSIC_HART_SIZE(guest_index_bits);
> +
> +            riscv_acpi_madt_add_rintc(i, local_cpu_id, arch_ids, madt_buf,
> +                                      s->aia_type, imsic_addr, imsic_size);
>              aml_append(dev, aml_name_decl("_MAT",
>                                            aml_buffer(madt_buf->len,
>                                            (uint8_t *)madt_buf->data)));
> @@ -227,6 +268,7 @@ static void build_dsdt(GArray *table_data,
>   * 5.2.12 Multiple APIC Description Table (MADT)
>   * REF: https://github.com/riscv-non-isa/riscv-acpi/issues/15
>   *      https://drive.google.com/file/d/1R6k4MshhN3WTT-hwqAquu5nX6xSEqK2l/view
> + *      https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia7zR/view
>   */
>  static void build_madt(GArray *table_data,
>                         BIOSLinker *linker,
> @@ -235,6 +277,12 @@ static void build_madt(GArray *table_data,
>      MachineClass *mc = MACHINE_GET_CLASS(s);
>      MachineState *ms = MACHINE(s);
>      const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(ms);
> +    uint64_t imsic_socket_addr, imsic_addr;
> +    uint8_t  guest_index_bits;
> +    uint32_t imsic_size;
> +    uint32_t local_cpu_id, socket_id;
> +
> +    guest_index_bits = imsic_num_bits(s->aia_guests + 1);
>  
>      AcpiTable table = { .sig = "APIC", .rev = 6, .oem_id = s->oem_id,
>                          .oem_table_id = s->oem_table_id };
> @@ -246,7 +294,17 @@ static void build_madt(GArray *table_data,
>  
>      /* RISC-V Local INTC structures per HART */
>      for (int i = 0; i < arch_ids->len; i++) {
> -        riscv_acpi_madt_add_rintc(i, arch_ids, table_data);
> +        socket_id = arch_ids->cpus[i].props.node_id;
> +        local_cpu_id = (arch_ids->cpus[i].arch_id -
> +                       riscv_socket_first_hartid(ms, socket_id)) %
> +                       riscv_socket_hart_count(ms, socket_id);
> +        imsic_socket_addr = s->memmap[VIRT_IMSIC_S].base +
> +                            (socket_id * VIRT_IMSIC_GROUP_MAX_SIZE);
> +        imsic_addr = imsic_socket_addr +
> +                     local_cpu_id * IMSIC_HART_SIZE(guest_index_bits);
> +        imsic_size = IMSIC_HART_SIZE(guest_index_bits);
> +        riscv_acpi_madt_add_rintc(i, local_cpu_id, arch_ids, table_data,
> +                                  s->aia_type, imsic_addr, imsic_size);

All the above new lines identically match the new lines in
acpi_dsdt_add_cpus(), so I suggest creating a helper function rather
than duplicating them.

>      }
>  
>      acpi_table_end(linker, &table);
> -- 
> 2.39.2
> 
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

