Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D14707D3795
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 15:18:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quuoR-0003mj-FL; Mon, 23 Oct 2023 09:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1quuoC-0003kb-Hk
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 09:17:29 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1quuoA-0002Ej-Gx
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 09:17:28 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9be1ee3dc86so469999066b.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 06:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698067045; x=1698671845; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=08Ns5r0OQR+V9W8vMSPerOUKx+75ry4tY92zwJak5PU=;
 b=JqLZnf1c8wutxBxgZaASw0k8SE18Q1uuD78bsFGrAUMQgZf3+zyFAhiZ0KqtqXPEV2
 A+nWw0dpGGWLEh13sfzPkMQ42aNapOQWqRX5XoqEO8Jr3iqWQbGOwzYsxHyafb35xMiA
 C/zWuwChjpvfhvgIFO4xJWg7EWCa9QB5A2pX6MAKIwimpJIgYRu0M4YWnQQeSVdc/MOK
 7j4K1UWeO2IY1NXP9KNSUfYbN5U14yd2SO0jWXMO4NN5tW4bkcMeUraaqs1j7xTRKl5O
 HdksOkGF6+ELOaiEAmrMiBwPReuAb8HKPOug/nfVrDCzHO/cCOApASz04HUtccQBjPxN
 yH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698067045; x=1698671845;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=08Ns5r0OQR+V9W8vMSPerOUKx+75ry4tY92zwJak5PU=;
 b=Tleyc6IVjS9OFzZ4tuOVHBb01diVacxG4MnvUwPqdcVMTxRC2a02FEOuCQ20V8HQNo
 D0kG4lDc3OIMGwnADGZpFj0i18wA4VvYzMI4eCt5v/v/y6etVbdKVgTnU/x1rQN1pzSP
 B5eBcE1hetY7H0QToiRGvjZFmJB8tEdG6IFMPOnt76dQqmFVXFYBBDMFYbuZH4tAbgOv
 +6YoxKkYQhAMzx9H52AKo+h43xm2QaKDcqZ8oy2Dg2Dxa769/SEELEmUVB/SQKn5Tp9O
 7T0viq36tvqruJYAmrNwsPcczJ9m/oyp70hCw5S0I50svmE4NEZ4zCPTZpbgr2tSHymc
 bCwg==
X-Gm-Message-State: AOJu0YwHQN5N0Zp3rkTUSRmn0twryOYXGe/P1jw3ohBO5Rh44vbmfFK0
 m7iA7UOorXF1HRBoaPk1rHrBCw==
X-Google-Smtp-Source: AGHT+IEdwwp5LYwZqnIgGG1Ta3aKIjOW+MS6MmJR7kaSzA1uQQqqSLm8ztvCDAvZqYo8qlDXsi6ThA==
X-Received: by 2002:a17:907:25c3:b0:9ae:5c99:f2e2 with SMTP id
 ae3-20020a17090725c300b009ae5c99f2e2mr6997333ejc.43.1698067044174; 
 Mon, 23 Oct 2023 06:17:24 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 ga23-20020a170906b85700b009b65b2be80bsm6611455ejb.76.2023.10.23.06.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 06:17:23 -0700 (PDT)
Date: Mon, 23 Oct 2023 15:17:22 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Anup Patel <apatel@ventanamicro.com>, Atish Kumar Patra <atishp@rivosinc.com>, 
 Haibo Xu <haibo1.xu@intel.com>
Subject: Re: [PATCH v3 07/12] hw/riscv/virt-acpi-build.c: Add CMO information
 in RHCT
Message-ID: <20231023-c3b85e7af47edaaba7eedd6e@orel>
References: <20231019132648.23703-1-sunilvl@ventanamicro.com>
 <20231019132648.23703-8-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019132648.23703-8-sunilvl@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x629.google.com
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

On Thu, Oct 19, 2023 at 06:56:43PM +0530, Sunil V L wrote:
> When CMO related extensions like Zicboz, Zicbom and Zicbop are enabled, the
> block size for those extensions need to be communicated via CMO node in
> RHCT. Add CMO node in RHCT if any of those CMO extensions are detected.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  hw/riscv/virt-acpi-build.c | 64 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 56 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 8fa358d034..bf47eef792 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -147,6 +147,7 @@ static void acpi_dsdt_add_cpus(Aml *scope, RISCVVirtState *s)
>   * 5.2.36 RISC-V Hart Capabilities Table (RHCT)
>   * REF: https://github.com/riscv-non-isa/riscv-acpi/issues/16
>   *      https://drive.google.com/file/d/1nP3nFiH4jkPMp6COOxP6123DCZKR-tia/view
> + *      https://drive.google.com/file/d/1sKbOa8m1UZw1JkquZYe3F1zQBN1xXsaf/view
>   */
>  static void build_rhct(GArray *table_data,
>                         BIOSLinker *linker,
> @@ -156,8 +157,8 @@ static void build_rhct(GArray *table_data,
>      MachineState *ms = MACHINE(s);
>      const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(ms);
>      size_t len, aligned_len;
> -    uint32_t isa_offset, num_rhct_nodes;
> -    RISCVCPU *cpu;
> +    uint32_t isa_offset, num_rhct_nodes, cmo_offset = 0;
> +    RISCVCPU *cpu = &s->soc[0].harts[0];
>      char *isa;
>  
>      AcpiTable table = { .sig = "RHCT", .rev = 1, .oem_id = s->oem_id,
> @@ -173,6 +174,9 @@ static void build_rhct(GArray *table_data,
>  
>      /* ISA + N hart info */
>      num_rhct_nodes = 1 + ms->smp.cpus;
> +    if (cpu->cfg.ext_zicbom || cpu->cfg.ext_zicboz) {
> +        num_rhct_nodes++;
> +    }
>  
>      /* Number of RHCT nodes*/
>      build_append_int_noprefix(table_data, num_rhct_nodes, 4);
> @@ -184,7 +188,6 @@ static void build_rhct(GArray *table_data,
>      isa_offset = table_data->len - table.table_offset;
>      build_append_int_noprefix(table_data, 0, 2);   /* Type 0 */
>  
> -    cpu = &s->soc[0].harts[0];
>      isa = riscv_isa_string(cpu);
>      len = 8 + strlen(isa) + 1;
>      aligned_len = (len % 2) ? (len + 1) : len;
> @@ -200,14 +203,59 @@ static void build_rhct(GArray *table_data,
>          build_append_int_noprefix(table_data, 0x0, 1);   /* Optional Padding */
>      }
>  
> +    /* CMO node */
> +    if (cpu->cfg.ext_zicbom || cpu->cfg.ext_zicboz) {
> +        cmo_offset = table_data->len - table.table_offset;
> +        build_append_int_noprefix(table_data, 1, 2);    /* Type */
> +        build_append_int_noprefix(table_data, 10, 2);   /* Total Length */

Comment should be "Length"

> +        build_append_int_noprefix(table_data, 0x1, 2);  /* Revision */
> +        build_append_int_noprefix(table_data, 0, 1);    /* Reserved */
> +
> +        /* CBOM block size */
> +        if (cpu->cfg.cbom_blocksize) {
> +            build_append_int_noprefix(table_data,
> +                                      __builtin_ctz(cpu->cfg.cbom_blocksize),
> +                                      1);
> +        } else {
> +            build_append_int_noprefix(table_data, 0, 1);
> +        }
> +
> +        /* CBOP block size */
> +        build_append_int_noprefix(table_data, 0, 1);
> +
> +        /* CBOZ block size */
> +        if (cpu->cfg.cboz_blocksize) {
> +            build_append_int_noprefix(table_data,
> +                                      __builtin_ctz(cpu->cfg.cboz_blocksize),
> +                                      1);
> +        } else {
> +            build_append_int_noprefix(table_data, 0, 1);
> +        }
> +    }
> +
>      /* Hart Info Node */
>      for (int i = 0; i < arch_ids->len; i++) {
> +        len = 16;
> +        int num_offsets = 1;
>          build_append_int_noprefix(table_data, 0xFFFF, 2);  /* Type */
> -        build_append_int_noprefix(table_data, 16, 2);      /* Length */
> -        build_append_int_noprefix(table_data, 0x1, 2);     /* Revision */
> -        build_append_int_noprefix(table_data, 1, 2);    /* Number of offsets */
> -        build_append_int_noprefix(table_data, i, 4);    /* ACPI Processor UID */
> -        build_append_int_noprefix(table_data, isa_offset, 4); /* Offsets[0] */
> +
> +        /* Length */
> +        if (cmo_offset) {
> +            len += 4;
> +            num_offsets++;
> +        }
> +
> +        build_append_int_noprefix(table_data, len, 2);

Missing "Length" comment

> +        build_append_int_noprefix(table_data, 0x1, 2); /* Revision */
> +        /* Number of offsets */
> +        build_append_int_noprefix(table_data, num_offsets, 2);
> +        build_append_int_noprefix(table_data, i, 4);   /* ACPI Processor UID */
> +
> +        /* Offsets */
> +        build_append_int_noprefix(table_data, isa_offset, 4);
> +        if (cmo_offset) {
> +            build_append_int_noprefix(table_data, cmo_offset, 4);
> +        }
>      }
>  
>      acpi_table_end(linker, &table);
> -- 
> 2.34.1
>

Thanks,
drew

