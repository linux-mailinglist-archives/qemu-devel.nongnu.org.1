Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE667511C9
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 22:22:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJgL9-0001gS-BD; Wed, 12 Jul 2023 16:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qJgL4-0001gI-Pk
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 16:21:30 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qJgL2-0005je-Dr
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 16:21:30 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6b708b97418so6471141a34.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 13:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689193285; x=1691785285;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cwWRQyoKQ6bJh6p2PGoxiQUawKtyviak6FVWrh1tluw=;
 b=UAlWshDBIq2D6up6XLmuRFtvDYNLS9VsAuVp2/RK2ZAY3W4b1SFi3Pvjp19bD0aMjk
 NDpf9WG+GdvzccqhTsRM/9+uP8Q0Y+QGGgzxZBsECQtROxlRmX53gcDqH7L38xuRy67G
 Or/wdswjj/KrzkHQkh6NRTuY0jHSMiR2oJiaT1ezLYnvmZuAgSYUoRGej1kdgqj2duG7
 2xGQ2S51vJeZfDq4CFE5+BIeEJPgGiMS8J10LqrMred6nM3owi+S73tPHAsfaDM3LE3u
 TBJWJH0TWWR3Zq6ktgrcpNmbIKwCZmAPwrtofhxUDBuy7leDQMTQ4dVPoJmLJFBxIj2o
 QswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689193285; x=1691785285;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cwWRQyoKQ6bJh6p2PGoxiQUawKtyviak6FVWrh1tluw=;
 b=IWiKEONNfYBpQ4bBpUHemqFVDsZ9IfWShbw/5JU2OwhQ2tPNiNXq0NyKfdr42auHQg
 WAEkxjHYKgh4R5bwi/G8jLaL7E3EmEhcp+aGBKIL//TfSTxXZgFWP7vKkQaOfcGGpEkX
 b4Fv6ov4/pnytQrFC7Y9LxRJr5PuRGe08GEDSLD2RoQA9XWIa4ng46atvcqRR7CBYXun
 DGhgATRpe6lAsmYM/yFVyl1BGSRIFtaLJCyEcrcxBJv6i9jYcx8RX0DtaDUoxtnuC7BM
 TJnrjbVailM6uVIumzWUBWI2dDhjbhja1utCgjxFhbe5xIZH3kJOrYeY+I0Dj+oQRSDI
 YAGQ==
X-Gm-Message-State: ABy/qLbOp3oRrgYDOsOL3z2qH+KywDNrw6J2RGWC2l5sNdlupvKyO4D1
 y11ZOYZZVZjAlAGNIncYaEgXBg==
X-Google-Smtp-Source: APBJJlFmEPrQuBtWoofz05B/Jz/rtpUpHyreKesELcd3/M0k6fZxFlG2lzA4wSvnMRwl8x1vB5+c+g==
X-Received: by 2002:a05:6830:2044:b0:6b9:57cb:8c42 with SMTP id
 f4-20020a056830204400b006b957cb8c42mr10341206otp.13.1689193285333; 
 Wed, 12 Jul 2023 13:21:25 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-19.dial-up.telesp.net.br.
 [201.69.66.19]) by smtp.gmail.com with ESMTPSA id
 m15-20020a0568301e6f00b006b94fb2762asm2267472otr.23.2023.07.12.13.21.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 13:21:25 -0700 (PDT)
Message-ID: <bb779bc2-876e-e1d4-0624-844a2f5d6299@ventanamicro.com>
Date: Wed, 12 Jul 2023 17:21:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 03/10] hw/riscv: virt: Make few IMSIC macros and functions
 public
Content-Language: en-US
To: Sunil V L <sunilvl@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel <apatel@ventanamicro.com>
References: <20230712163943.98994-1-sunilvl@ventanamicro.com>
 <20230712163943.98994-4-sunilvl@ventanamicro.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230712163943.98994-4-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.11,
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



On 7/12/23 13:39, Sunil V L wrote:
> Some macros and static function related to IMSIC are defined
> in virt.c. They are required in virt-acpi-build.c. So, make them
> public.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/riscv/virt.c         | 25 +------------------------
>   include/hw/riscv/virt.h | 25 +++++++++++++++++++++++++
>   2 files changed, 26 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 46d3341113..f6067db8ec 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -37,7 +37,6 @@
>   #include "hw/riscv/numa.h"
>   #include "hw/intc/riscv_aclint.h"
>   #include "hw/intc/riscv_aplic.h"
> -#include "hw/intc/riscv_imsic.h"
>   #include "hw/intc/sifive_plic.h"
>   #include "hw/misc/sifive_test.h"
>   #include "hw/platform-bus.h"
> @@ -53,28 +52,6 @@
>   #include "hw/acpi/aml-build.h"
>   #include "qapi/qapi-visit-common.h"
>   
> -/*
> - * The virt machine physical address space used by some of the devices
> - * namely ACLINT, PLIC, APLIC, and IMSIC depend on number of Sockets,
> - * number of CPUs, and number of IMSIC guest files.
> - *
> - * Various limits defined by VIRT_SOCKETS_MAX_BITS, VIRT_CPUS_MAX_BITS,
> - * and VIRT_IRQCHIP_MAX_GUESTS_BITS are tuned for maximum utilization
> - * of virt machine physical address space.
> - */
> -
> -#define VIRT_IMSIC_GROUP_MAX_SIZE      (1U << IMSIC_MMIO_GROUP_MIN_SHIFT)
> -#if VIRT_IMSIC_GROUP_MAX_SIZE < \
> -    IMSIC_GROUP_SIZE(VIRT_CPUS_MAX_BITS, VIRT_IRQCHIP_MAX_GUESTS_BITS)
> -#error "Can't accomodate single IMSIC group in address space"
> -#endif
> -
> -#define VIRT_IMSIC_MAX_SIZE            (VIRT_SOCKETS_MAX * \
> -                                        VIRT_IMSIC_GROUP_MAX_SIZE)
> -#if 0x4000000 < VIRT_IMSIC_MAX_SIZE
> -#error "Can't accomodate all IMSIC groups in address space"
> -#endif
> -
>   static const MemMapEntry virt_memmap[] = {
>       [VIRT_DEBUG] =        {        0x0,         0x100 },
>       [VIRT_MROM] =         {     0x1000,        0xf000 },
> @@ -505,7 +482,7 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
>       g_free(plic_cells);
>   }
>   
> -static uint32_t imsic_num_bits(uint32_t count)
> +uint32_t imsic_num_bits(uint32_t count)
>   {
>       uint32_t ret = 0;
>   
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 4ef1f660ab..00c22492a7 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -23,6 +23,7 @@
>   #include "hw/riscv/riscv_hart.h"
>   #include "hw/sysbus.h"
>   #include "hw/block/flash.h"
> +#include "hw/intc/riscv_imsic.h"
>   
>   #define VIRT_CPUS_MAX_BITS             9
>   #define VIRT_CPUS_MAX                  (1 << VIRT_CPUS_MAX_BITS)
> @@ -128,4 +129,28 @@ enum {
>   
>   bool virt_is_acpi_enabled(RISCVVirtState *s);
>   void virt_acpi_setup(RISCVVirtState *vms);
> +uint32_t imsic_num_bits(uint32_t count);
> +
> +/*
> + * The virt machine physical address space used by some of the devices
> + * namely ACLINT, PLIC, APLIC, and IMSIC depend on number of Sockets,
> + * number of CPUs, and number of IMSIC guest files.
> + *
> + * Various limits defined by VIRT_SOCKETS_MAX_BITS, VIRT_CPUS_MAX_BITS,
> + * and VIRT_IRQCHIP_MAX_GUESTS_BITS are tuned for maximum utilization
> + * of virt machine physical address space.
> + */
> +
> +#define VIRT_IMSIC_GROUP_MAX_SIZE      (1U << IMSIC_MMIO_GROUP_MIN_SHIFT)
> +#if VIRT_IMSIC_GROUP_MAX_SIZE < \
> +    IMSIC_GROUP_SIZE(VIRT_CPUS_MAX_BITS, VIRT_IRQCHIP_MAX_GUESTS_BITS)
> +#error "Can't accomodate single IMSIC group in address space"
> +#endif
> +
> +#define VIRT_IMSIC_MAX_SIZE            (VIRT_SOCKETS_MAX * \
> +                                        VIRT_IMSIC_GROUP_MAX_SIZE)
> +#if 0x4000000 < VIRT_IMSIC_MAX_SIZE
> +#error "Can't accomodate all IMSIC groups in address space"
> +#endif
> +
>   #endif

