Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1E47D7E89
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 10:32:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvvmb-0002f5-7V; Thu, 26 Oct 2023 04:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qvvmW-0002cQ-5n
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:31:56 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qvvmU-0003GE-Fy
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:31:55 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9adca291f99so91438466b.2
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 01:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698309112; x=1698913912; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EK7z7nW9IbW+wNSjNYnANY+PyJrIBvlcjyYf+zls/uw=;
 b=M6LMvx2L2C+RajBW1RvmL6VhlnaajATqj/UT3vwaMX1x3cU6iFCu/AXpVm3XKE1PWS
 CThs9s8UqK+0MGVbrWc0y7FV0TK3QqK3DePwXJvt0wrr/sMsH+HYS0aMPlQSWDzG7eYx
 oeqEjWOCONpxCWUma4LpmyVk4HhZQ6wfROdaz9Z2d0VGy1J0qxlJ/2CCzc/rjHV0eney
 XYK8VmyYcKr2NejBs0h3oxqiaS0ztB4p71pmB1fuMR28nGee6vvKKPATQZ7nv5QWmfsJ
 RAc9tBYrchpKB8N2OWADUoqIoDm1QlsoguXQ10zr7G0NN02tdzkb2xNtewNWB6r9KJqz
 tKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698309112; x=1698913912;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EK7z7nW9IbW+wNSjNYnANY+PyJrIBvlcjyYf+zls/uw=;
 b=FXx/C7qVmgBsIruLWnBmOXjEvhFs51NFmlITQOrXAlp6TqVIaKxeBIhspKeErJyrDS
 5U9HvKxaFuRNBo2nfsfFhyDhUAPLD7I1y2xcuMp4LJ3m2zGAsIDlxrwHs8FeWipPcmEm
 7BxD0lMKeWTUMKQPoxWkpmsRLDJabp5nme0hAglGr+ECHRpP5TOEw3QojuWIn6DLMrOL
 iu00J9AByj1Ur16QtJEvlqVXplg69nw7FxsqVPgFj5lSCAh/5SUy+lDrt05VyFN6nl5C
 fyY9UOIZfx7/JthLhdUox7FVkCF2GjgWpI1iRcRyfWJ40H3wvWPJeulMiUgAdjKDNZNL
 1VDQ==
X-Gm-Message-State: AOJu0YzsRHudYLFB1PBIa7dP+Mo9HVP5otMDUaRvIc4dbRQSq0Kp6FtN
 eOwpcKLG0jmHghYtET1WwIOyMA==
X-Google-Smtp-Source: AGHT+IGlAn99shPNYqWy5b5F4cv9FLygptxO7u6WcN9Wj/K7zfjN0NxzTMteEoX4s+dOzFx+h6s43w==
X-Received: by 2002:a17:907:94c3:b0:9c3:bd63:4245 with SMTP id
 dn3-20020a17090794c300b009c3bd634245mr12536736ejc.47.1698309112538; 
 Thu, 26 Oct 2023 01:31:52 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 i6-20020a17090671c600b009920a690cd9sm11159820ejk.59.2023.10.26.01.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 01:31:52 -0700 (PDT)
Date: Thu, 26 Oct 2023 10:31:51 +0200
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
Subject: Re: [PATCH v4 09/13] hw/riscv/virt-acpi-build.c: Add MMU node in RHCT
Message-ID: <20231026-5530c164173cd1859e9df666@orel>
References: <20231025200713.580814-1-sunilvl@ventanamicro.com>
 <20231025200713.580814-10-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025200713.580814-10-sunilvl@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62b.google.com
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

On Thu, Oct 26, 2023 at 01:37:09AM +0530, Sunil V L wrote:
> MMU type information is available via MMU node in RHCT. Add this node in
> RHCT.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  hw/riscv/virt-acpi-build.c | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index ebe7062b9b..dc7c0213f5 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -159,6 +159,8 @@ static void build_rhct(GArray *table_data,
>      size_t len, aligned_len;
>      uint32_t isa_offset, num_rhct_nodes, cmo_offset = 0;
>      RISCVCPU *cpu = &s->soc[0].harts[0];
> +    uint32_t mmu_offset = 0;
> +    uint8_t satp_mode_max;
>      char *isa;
>  
>      AcpiTable table = { .sig = "RHCT", .rev = 1, .oem_id = s->oem_id,
> @@ -178,6 +180,10 @@ static void build_rhct(GArray *table_data,
>          num_rhct_nodes++;
>      }
>  
> +    if (cpu->cfg.satp_mode.supported != 0) {
> +        num_rhct_nodes++;
> +    }
> +
>      /* Number of RHCT nodes*/
>      build_append_int_noprefix(table_data, num_rhct_nodes, 4);
>  
> @@ -233,6 +239,26 @@ static void build_rhct(GArray *table_data,
>          }
>      }
>  
> +    /* MMU node structure */
> +    if (cpu->cfg.satp_mode.supported != 0) {
> +        satp_mode_max = satp_mode_max_from_map(cpu->cfg.satp_mode.map);
> +        mmu_offset = table_data->len - table.table_offset;
> +        build_append_int_noprefix(table_data, 2, 2);    /* Type */
> +        build_append_int_noprefix(table_data, 8, 2);    /* Length */
> +        build_append_int_noprefix(table_data, 0x1, 2);  /* Revision */
> +        build_append_int_noprefix(table_data, 0, 1);    /* Reserved */
> +        /* MMU Type */
> +        if (satp_mode_max == VM_1_10_SV57) {
> +            build_append_int_noprefix(table_data, 2, 1);    /* Sv57 */
> +        } else if (satp_mode_max == VM_1_10_SV48) {
> +            build_append_int_noprefix(table_data, 1, 1);    /* Sv48 */
> +        } else if (satp_mode_max == VM_1_10_SV39) {
> +            build_append_int_noprefix(table_data, 0, 1);    /* Sv39 */
> +        } else {
> +            assert(1);
> +        }
> +    }
> +
>      /* Hart Info Node */
>      for (int i = 0; i < arch_ids->len; i++) {
>          len = 16;
> @@ -245,17 +271,26 @@ static void build_rhct(GArray *table_data,
>              num_offsets++;
>          }
>  
> +        if (mmu_offset) {
> +            len += 4;
> +            num_offsets++;
> +        }
> +
>          build_append_int_noprefix(table_data, len, 2);
>          build_append_int_noprefix(table_data, 0x1, 2); /* Revision */
>          /* Number of offsets */
>          build_append_int_noprefix(table_data, num_offsets, 2);
>          build_append_int_noprefix(table_data, i, 4);   /* ACPI Processor UID */
> -
>          /* Offsets */
>          build_append_int_noprefix(table_data, isa_offset, 4);
> +        if (mmu_offset) {
> +            build_append_int_noprefix(table_data, mmu_offset, 4);
> +        }
> +

In the previous version of this patch the MMU node was getting generated
above the CMO node, so its offset was less than those of the CMO node,
and why I recommended moving it up here. But, in this version, the MMU
node is now getting generated after the CMO node, so moving this up
means the offsets are still not in ascending order.

>          if (cmo_offset) {
>              build_append_int_noprefix(table_data, cmo_offset, 4);
>          }
> +
>      }
>  
>      acpi_table_end(linker, &table);
> -- 
> 2.39.2
> 
>

Anyway,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew


