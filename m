Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DE67D37DF
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 15:23:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quutc-0007wc-G9; Mon, 23 Oct 2023 09:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1quutS-0007rI-Ca
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 09:22:54 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1quutP-0003LO-PI
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 09:22:54 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-53df747cfe5so5112534a12.2
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 06:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698067370; x=1698672170; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Eyqs5XEhMqiBWGKqKvNdXfL/aKjeQDVM8f5JUSy9gCM=;
 b=hTEKU4nUaEY7vQfR2l1tir77D+ukIZKars+C+gaHa/Cj/7vvbTReUo4cCBxFAKQXXa
 03xACrwWBFUHd/5t5+a/vVWk3JfayV+bmoHTWmBSLkGxyMWwnFzcywbf9yIm8IeQnkLJ
 SUfueqkxdSPIEtVv/mZxF6PrEKlaCKp2r5plAJK7OivzUad74pEbnMVbArw66unUhPfv
 zfF0WnjKIEtsIvhcznMcWCTOuOBrkmfrU2pki1kucnnbAqIvF9DBQNIPIG+goMaOfZfL
 IayYMtQXTcDbO5BzK8dKcPHDaHJNj3oMlW7cJwlvpkesmiIGDVFmiheWX/xWggALjuX7
 mz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698067370; x=1698672170;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eyqs5XEhMqiBWGKqKvNdXfL/aKjeQDVM8f5JUSy9gCM=;
 b=sUQb22KDdUxf39xrHxEphg3WZHhDPCAf3UiX+Xa/y9cijhiUWsWg6lF4hKqqjKj0EX
 gzbyPfqpjYrM1aLVvqtf2XcWpFjqPreY9f3ZGFqy+w5E+4kbyvF3zZeMaHV0o8ZHxOm0
 HaEmhFCKMzpUsgaGUrFQhohQ80V3BgF7wp1h1VBJ/0o0as/cfBFPzXnOpjMb0DF6hNsE
 7/0P4E2mgBG9QTpVXsb1d5VFzUVoCVkyDbZxHTM2EkzSSr54bcnKZxMwdzdWXvB3cgf1
 d4EfRFVI17hUp5T1fcaCGMcJW440G5FEE+QTVkz2wloI6jmCeGlgACyJ2W3yyxPXse8k
 hzdg==
X-Gm-Message-State: AOJu0YxE/kSz/wslvk72N0MfoRPZj6KZRplPo3omPBVxuMBvfztCtdri
 /zxMHKXsVQ8eBA9C8i6jgcwkXQ==
X-Google-Smtp-Source: AGHT+IFnto2zi143lX2yrsyugq++H2tQytsa++IrYuYlAiTKAWYUULsRMsoEw6msKQFDhrSaAjK+OQ==
X-Received: by 2002:a17:907:9282:b0:9bd:fc4b:6c9b with SMTP id
 bw2-20020a170907928200b009bdfc4b6c9bmr7532860ejc.36.1698067369899; 
 Mon, 23 Oct 2023 06:22:49 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 10-20020a170906218a00b009c0c511bd62sm6597458eju.197.2023.10.23.06.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 06:22:49 -0700 (PDT)
Date: Mon, 23 Oct 2023 15:22:48 +0200
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
Subject: Re: [PATCH v3 12/12] hw/riscv/virt-acpi-build.c: Add PLIC in MADT
Message-ID: <20231023-aac858ca4920965239000952@orel>
References: <20231019132648.23703-1-sunilvl@ventanamicro.com>
 <20231019132648.23703-13-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019132648.23703-13-sunilvl@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x52d.google.com
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

On Thu, Oct 19, 2023 at 06:56:48PM +0530, Sunil V L wrote:
> Add PLIC structures for each socket in the MADT when system is configured
> with PLIC as the external interrupt controller.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  hw/riscv/virt-acpi-build.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 2f1cc92f75..d1761ddddf 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -85,6 +85,12 @@ static void riscv_acpi_madt_add_rintc(uint32_t uid,
>                                        arch_ids->cpus[uid].props.node_id,
>                                        local_cpu_id),
>                                    4);
> +    } else if (aia_type == VIRT_AIA_TYPE_NONE) {
> +        build_append_int_noprefix(entry,
> +                                  ACPI_BUILD_INTC_ID(
> +                                      arch_ids->cpus[uid].props.node_id,
> +                                      2 * local_cpu_id + 1),
> +                                  4);
>      } else {
>          build_append_int_noprefix(entry, 0, 4);
>      }
> @@ -513,6 +519,29 @@ static void build_madt(GArray *table_data,
>              build_append_int_noprefix(table_data,
>                                        s->memmap[VIRT_APLIC_S].size, 4);
>          }
> +    } else {
> +        /* PLICs */
> +        for (socket = 0; socket < riscv_socket_count(ms); socket++) {
> +            aplic_addr = s->memmap[VIRT_PLIC].base +
> +                         s->memmap[VIRT_PLIC].size * socket;
> +            gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
> +            build_append_int_noprefix(table_data, 0x1B, 1);   /* Type */
> +            build_append_int_noprefix(table_data, 36, 1);     /* Length */
> +            build_append_int_noprefix(table_data, 1, 1);      /* Version */
> +            build_append_int_noprefix(table_data, socket, 1); /* PLIC ID */
> +            build_append_int_noprefix(table_data, 0, 8);      /* Hardware ID */
> +            /* Total External Interrupt Sources Supported */
> +            build_append_int_noprefix(table_data,
> +                                      VIRT_IRQCHIP_NUM_SOURCES - 1, 2);
> +            build_append_int_noprefix(table_data, 0, 2);     /* Max priority */

"Max Priority"

> +            build_append_int_noprefix(table_data, 0, 4);     /* Flags */
> +            /* PLIC Size */
> +            build_append_int_noprefix(table_data, s->memmap[VIRT_PLIC].size, 4);
> +            /* PLIC Address */
> +            build_append_int_noprefix(table_data, aplic_addr, 8);
> +            /* Global System Interrupt Vector Base */
> +            build_append_int_noprefix(table_data, gsi_base, 4);
> +        }
>      }
>  
>      acpi_table_end(linker, &table);
> -- 
> 2.34.1
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

