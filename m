Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E38724413
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 15:14:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6WUs-0002Be-9T; Tue, 06 Jun 2023 09:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1q6WUp-0002BR-Qg
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 09:13:11 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1q6WUn-00012h-Ky
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 09:13:11 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-30ae4ec1ac7so4801763f8f.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 06:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1686057187; x=1688649187;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0aZ6pYJ55rqn9IMCYYI1FiODTcZaHJvbjE+pvUeGPEA=;
 b=X9i4TEdRC20OkdhOZBxL1vQZ82/PN7jVPWdcUnpBe72QqXaWAnqOASFZzA0f+mlq/v
 a2W6+IonN4a33+cNRSAcixaU2z7JNtQ57bNoahYSJgRI9JNIMQggw/Ow2sgX1nEVF2fE
 IhxMUdsvgELWa+90CjTwN2r9qWRRmBpIkHsgg2UjSDi04yp7sDP3OTmJj1cxOHBgNBzH
 M/4Hu7rVD2x/vSoxWAOiLJFDXO1C2Ycby/i5USfyj9yDF5wd1JyHiPQcowl9EWllBBDa
 ZdabSuzajei151HcqzPMxaMvzpJDuTtnRF7BVrUcoqxxj041aMcDMKQAod/1Z8j96V/N
 JyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686057187; x=1688649187;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0aZ6pYJ55rqn9IMCYYI1FiODTcZaHJvbjE+pvUeGPEA=;
 b=hw25i538ElVss+GGLGXeIJh0BIbQUgP9qmBqUUiNyl3ddq9Lius08Fih7o8zwXNk8f
 LzSFKgxminXMR5GRpzYRw+mQ2eKcBxoXlXGANc6nwvWqzLezmPJcUVdfwlNi3arsmLtd
 CTJGkUKMUrd3y8Ey2TMbio4qVHd7ED2JAvFBaPUeGiM0Le/v9p/j40QeR2DEWap2nv3m
 srz282VzBQJi5eV0Z5vBnIOnoRpeiE5RtsiHb8eU6S02H1Mcji6/d0huHLook53G8GRT
 ObZ79azD3T4aBDUF/GJSVcCpeHcSWAhW8bN+ZyR6GcIVjRuY22r9fKwysY8HcdEt4Wbb
 k92w==
X-Gm-Message-State: AC+VfDzxyb6XUEfJitkKzmTrVZigE2ZD4dXxKSYNqazQtDirsJ+qt45t
 uPrRlK/O2hCfEd0ihN/h8PS3bg==
X-Google-Smtp-Source: ACHHUZ7YenBR5FQSqUqXAXGXA3uRZE3YETL6wGnWlcp1KTRHbgBLWQDcRG2wFDj3BnqaUk1/+b04EQ==
X-Received: by 2002:a5d:53c5:0:b0:306:b3f9:e2c9 with SMTP id
 a5-20020a5d53c5000000b00306b3f9e2c9mr1700145wrw.6.1686057187565; 
 Tue, 06 Jun 2023 06:13:07 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 m7-20020a5d4a07000000b003077f3dfcc8sm12618924wrq.32.2023.06.06.06.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 06:13:07 -0700 (PDT)
Date: Tue, 6 Jun 2023 15:13:06 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 02/16] hw/riscv/virt.c: skip 'mmu-type' FDT if satp mode
 not set
Message-ID: <20230606-523ed1960aaa8070f5639237@orel>
References: <20230530194623.272652-1-dbarboza@ventanamicro.com>
 <20230530194623.272652-3-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530194623.272652-3-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x429.google.com
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

On Tue, May 30, 2023 at 04:46:09PM -0300, Daniel Henrique Barboza wrote:
> The absence of a satp mode in riscv_host_cpu_init() is causing the
> following error:
> 
> $ sudo ./qemu/build/qemu-system-riscv64  -machine virt,accel=kvm \
>     -m 2G -smp 1  -nographic -snapshot \
>     -kernel ./guest_imgs/Image \
>     -initrd ./guest_imgs/rootfs_kvm_riscv64.img \
>     -append "earlycon=sbi root=/dev/ram rw" \
>     -cpu host
> **
> ERROR:../target/riscv/cpu.c:320:satp_mode_str: code should not be
> reached
> Bail out! ERROR:../target/riscv/cpu.c:320:satp_mode_str: code should
> not be reached
> Aborted
> 
> The error is triggered from create_fdt_socket_cpus() in hw/riscv/virt.c.
> It's trying to get satp_mode_str for a NULL cpu->cfg.satp_mode.map.
> 
> For this KVM 'cpu' we would need to inherit the satp supported modes
> from the RISC-V host. At this moment this is not possible because the
> KVM driver does not support it. And even when it does we can't just let
> this broken for every other older kernel.
> 
> Skip the 'mmu-type' FDT node if there's no satp_mode set.

This seems reasonable, since mmu-type is not a required node, according to
[1], and there's nothing we can put in it, which would be correct, until
we can get the information from KVM.

[1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/cpu.yaml

> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  hw/riscv/virt.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 4e3efbee16..8aa907e81f 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -243,13 +243,13 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
>              s->soc[socket].hartid_base + cpu);
>          qemu_fdt_add_subnode(ms->fdt, cpu_name);
>  
> -        satp_mode_max = satp_mode_max_from_map(
> -            s->soc[socket].harts[cpu].cfg.satp_mode.map);
> -        sv_name = g_strdup_printf("riscv,%s",
> -                                  satp_mode_str(satp_mode_max, is_32_bit));
> -        qemu_fdt_setprop_string(ms->fdt, cpu_name, "mmu-type", sv_name);
> -        g_free(sv_name);
> -
> +        if (cpu_ptr->cfg.satp_mode.supported != 0) {
> +            satp_mode_max = satp_mode_max_from_map(cpu_ptr->cfg.satp_mode.map);
> +            sv_name = g_strdup_printf("riscv,%s",
> +                                      satp_mode_str(satp_mode_max, is_32_bit));
> +            qemu_fdt_setprop_string(ms->fdt, cpu_name, "mmu-type", sv_name);
> +            g_free(sv_name);
> +        }
>  
>          name = riscv_isa_string(cpu_ptr);
>          qemu_fdt_setprop_string(ms->fdt, cpu_name, "riscv,isa", name);
> -- 
> 2.40.1
> 
>

Adding a sentence, like what I wrote above, to the commit message in order
to provide better justification might be nice, but either way

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

