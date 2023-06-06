Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9422C7244CC
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 15:48:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6X2N-0001MJ-C7; Tue, 06 Jun 2023 09:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q6X2M-0001LP-5X
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 09:47:50 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q6X2K-0000K0-EP
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 09:47:49 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-19f8af9aa34so6292199fac.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 06:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1686059267; x=1688651267;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HcXGC/hPLQwPSEK2S3AN0izpNc35VE9pCikrGzM6jig=;
 b=HSguVNTHuNsy3Tomj8m4EAqeBnr2OFsdLI3XDf/quZn6v5RuacKOrccEJyvstiCzMg
 cnerEMpaA2cqKK7Dg2dE0/Vj3cWwDivOJhggYDEM0UjAqk8yVJERBsMlLRI/fwvtCMOc
 /rJ0+bZxoVya0CMk0oVnQ++l3ncLqZIOnK9fCxuW1OzsrpsnAMTBDBNxMIiWLq+1snEj
 pcCzv4MDYTofS20JWYgA/MjVK5OtlbKHCEDZRgUvmBoONS8I31cKrznwZ8CIuKQmdzq5
 97p+Na/Cw3lQfjYLmtCR+cFS1+jdtukwmY2v6yMeYz9KaWdIsSIZI9sx0BXFAh/qrouD
 yGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686059267; x=1688651267;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HcXGC/hPLQwPSEK2S3AN0izpNc35VE9pCikrGzM6jig=;
 b=RNybVrEJVZky9g36kPAgHKqutmvDCbLm8ZiVCHA3BYX2P/F5fl6PYvdbqOOBt75ElQ
 dje20n5wGKUlXR0mwiC/215DSYY0j6HIKfyALYkEpN742cUi6iHDTxZtyqMz+kyy3mxn
 O6DCGkobAU8pgby5f48x2vb1dvMmkb7kMHPLyKFihM9gSR7HpjIbKuBWStVToee5h+wo
 KNo6LVRDKeG9jUa/2azdDkby3LXd5wsZrhQiz2gYcTlAzHyvbI+aux6JHP/RDudiObLT
 wZAlPfY50EFBSJTMlXQnfkh1u9fcgQhlAqW1W7Zrmvi6CIQMCdeFpIKevybT2h+kABZF
 +c6Q==
X-Gm-Message-State: AC+VfDwkNWEJEA7i3ogSKboZ8t7W/VLt0Wa/oUGicusoZXmyl5zsVQYX
 u8u7OKW9V/ZMvNIIeI9JAgH2aw==
X-Google-Smtp-Source: ACHHUZ7foQPEgeS23sCXPcRqn77uLDMaSDJPt9sT+GNQzO+sHS4vYbe+GZrqzS3vSf9tOiGVYT5F2w==
X-Received: by 2002:a05:6871:84c2:b0:19e:c567:6050 with SMTP id
 sw2-20020a05687184c200b0019ec5676050mr3288190oab.55.1686059266805; 
 Tue, 06 Jun 2023 06:47:46 -0700 (PDT)
Received: from [192.168.68.107] ([177.170.117.52])
 by smtp.gmail.com with ESMTPSA id
 v2-20020a05687105c200b001931cb17a86sm4760835oan.27.2023.06.06.06.47.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 06:47:46 -0700 (PDT)
Message-ID: <0a27afe3-0749-99cb-772e-0970e7dda20f@ventanamicro.com>
Date: Tue, 6 Jun 2023 10:47:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 5/6] target/riscv: update APLIC and IMSIC to support
 KVM AIA
Content-Language: en-US
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, rkanwal@rivosinc.com, anup@brainfault.org,
 atishp@atishpatra.org, vincent.chen@sifive.com, greentime.hu@sifive.com,
 frank.chang@sifive.com, jim.shu@sifive.com
Cc: Alistair Francis <alistair.francis@wdc.com>, Stefan Weil
 <sw@weilnetz.de>, Mayuresh Chitale <mchitale@ventanamicro.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>, Palmer Dabbelt <palmer@rivosinc.com>
References: <20230526062509.31682-1-yongxuan.wang@sifive.com>
 <20230526062509.31682-6-yongxuan.wang@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230526062509.31682-6-yongxuan.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2e.google.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



On 5/26/23 03:25, Yong-Xuan Wang wrote:
> - Do not set the mmio operations of APLIC and IMSIC when using KVM AIA
> - Send interrupt signal to KVM AIA via KVM_IRQ_LINE API
> 
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/intc/riscv_aplic.c | 19 +++++++++++++++----
>   hw/intc/riscv_imsic.c | 16 +++++++++++-----
>   2 files changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index afc5b54dbb..adf5427f22 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -31,6 +31,7 @@
>   #include "hw/irq.h"
>   #include "target/riscv/cpu.h"
>   #include "sysemu/sysemu.h"
> +#include "sysemu/kvm.h"
>   #include "migration/vmstate.h"
>   
>   #define APLIC_MAX_IDC                  (1UL << 14)
> @@ -479,6 +480,11 @@ static void riscv_aplic_request(void *opaque, int irq, int level)
>   
>       assert((0 < irq) && (irq < aplic->num_irqs));
>   
> +    if (kvm_irqchip_in_kernel()) {
> +        kvm_set_irq(kvm_state, irq, !!level);
> +        return;
> +    }
> +
>       sourcecfg = aplic->sourcecfg[irq];
>       if (sourcecfg & APLIC_SOURCECFG_D) {
>           childidx = sourcecfg & APLIC_SOURCECFG_CHILDIDX_MASK;
> @@ -814,9 +820,11 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
>       aplic->iforce = g_new0(uint32_t, aplic->num_harts);
>       aplic->ithreshold = g_new0(uint32_t, aplic->num_harts);
>   
> -    memory_region_init_io(&aplic->mmio, OBJECT(dev), &riscv_aplic_ops, aplic,
> -                          TYPE_RISCV_APLIC, aplic->aperture_size);
> -    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &aplic->mmio);
> +    if (!kvm_irqchip_in_kernel()) {
> +        memory_region_init_io(&aplic->mmio, OBJECT(dev), &riscv_aplic_ops,
> +                             aplic, TYPE_RISCV_APLIC, aplic->aperture_size);
> +        sysbus_init_mmio(SYS_BUS_DEVICE(dev), &aplic->mmio);
> +    }
>   
>       /*
>        * Only root APLICs have hardware IRQ lines. All non-root APLICs
> @@ -958,7 +966,10 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
>       qdev_prop_set_bit(dev, "mmode", mmode);
>   
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
> +
> +    if (!kvm_irqchip_in_kernel()) {
> +        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
> +    }
>   
>       if (parent) {
>           riscv_aplic_add_child(parent, dev);
> diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
> index fea3385b51..8bfa480f7c 100644
> --- a/hw/intc/riscv_imsic.c
> +++ b/hw/intc/riscv_imsic.c
> @@ -32,6 +32,7 @@
>   #include "target/riscv/cpu.h"
>   #include "target/riscv/cpu_bits.h"
>   #include "sysemu/sysemu.h"
> +#include "sysemu/kvm.h"
>   #include "migration/vmstate.h"
>   
>   #define IMSIC_MMIO_PAGE_LE             0x00
> @@ -325,10 +326,12 @@ static void riscv_imsic_realize(DeviceState *dev, Error **errp)
>       imsic->eithreshold = g_new0(uint32_t, imsic->num_pages);
>       imsic->eistate = g_new0(uint32_t, imsic->num_eistate);
>   
> -    memory_region_init_io(&imsic->mmio, OBJECT(dev), &riscv_imsic_ops,
> -                          imsic, TYPE_RISCV_IMSIC,
> -                          IMSIC_MMIO_SIZE(imsic->num_pages));
> -    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &imsic->mmio);
> +    if (!kvm_irqchip_in_kernel()) {
> +        memory_region_init_io(&imsic->mmio, OBJECT(dev), &riscv_imsic_ops,
> +                              imsic, TYPE_RISCV_IMSIC,
> +                              IMSIC_MMIO_SIZE(imsic->num_pages));
> +        sysbus_init_mmio(SYS_BUS_DEVICE(dev), &imsic->mmio);
> +    }
>   
>       /* Claim the CPU interrupt to be triggered by this IMSIC */
>       if (riscv_cpu_claim_interrupts(rcpu,
> @@ -432,7 +435,10 @@ DeviceState *riscv_imsic_create(hwaddr addr, uint32_t hartid, bool mmode,
>       qdev_prop_set_uint32(dev, "num-irqs", num_ids + 1);
>   
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
> +
> +    if (!kvm_irqchip_in_kernel()) {
> +        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
> +    }
>   
>       for (i = 0; i < num_pages; i++) {
>           if (!i) {

