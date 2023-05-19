Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C83709DAB
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 19:15:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q03hP-0002Pe-MS; Fri, 19 May 2023 13:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q03hI-0002Oi-Mu
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:15:21 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q03hG-0007P8-Mg
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:15:20 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f42711865eso22562855e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 10:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684516517; x=1687108517;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Lm6I4ZpaJpPYNz1gRwThJ8Pmmqv3IfAT+ti7+cmttZk=;
 b=XSNOtJPW590Mfz8C9vU54tSOr3+9s41ZKmJVw0hNDEGrTjR8/39+feMd79SPlYH/5I
 jKZB0ObW5te29BgUdJ+MsSoe9c5qdJo2ZUVQw6CFM8e0TMb6cXOEMklUfWJnHy7l2r2t
 R2UAimDlbLZDbWaYjlabnMqubykCsROnAa8gfMur3OXRfohDbtq/uH9S02Ea3A7yyq5i
 rNYihpZmZTRuoVHr15Gw/4biqVuqj2FAg/XlpqttVizx0Uvcwslwi2KPv+g4jz021Mai
 8vKOItrvfyQX7E+/IhsYN5ZznBW0Bg3rTL+ezP7ehcNNoPmBwGc9j/ASoJCGk4lTAOVR
 l+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684516517; x=1687108517;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lm6I4ZpaJpPYNz1gRwThJ8Pmmqv3IfAT+ti7+cmttZk=;
 b=JYW8obd9Lvs+4SS0Cni85wC2T6tVYggxqXTsbe0ieSYyChNF2qDa4XpqdKUNpBQYkg
 SqkfUShSuXTXWVpxsrWcqw9B07H402qGj19RqZi3njKEG7w+mXkRKPthGU9DatHbyGcA
 Kjlz7MmUA1HroGL80yEQpPBsTCEPWqwV5+uhhY1CPbu+XrVDJj4QcJh+dBUh7MJqNZKe
 ss5ytGiYGBdDvUenpLRoGovE38ULBz36rZZtM1VB3Q8qThbnogc6GK3rovdutRMMk+Va
 SUtCMXtMYCriNywutQb/TI10KlN8cEiDNP3buPdUE33/4ck85bP9fbWuVYxSZd9gubim
 fatg==
X-Gm-Message-State: AC+VfDwqb8kT6KR6cyQU9DFy/EqncSipApEh4QaHh0swLfghWlJ9U0ja
 Z1ibt/IVNDCLf9Yk6GwX/Giirw==
X-Google-Smtp-Source: ACHHUZ72X8XW6U7UB0bmcUNQWaG3nhHiCaxduDGzhTQ2tp4tAxCDlOE3yOfZWLfdKSE2DiBF8TVHFQ==
X-Received: by 2002:a7b:cd8b:0:b0:3f4:e4f5:1f63 with SMTP id
 y11-20020a7bcd8b000000b003f4e4f51f63mr1598538wmj.41.1684516516844; 
 Fri, 19 May 2023 10:15:16 -0700 (PDT)
Received: from [192.168.69.115] (mau49-h01-176-184-41-228.dsl.sta.abo.bbox.fr.
 [176.184.41.228]) by smtp.gmail.com with ESMTPSA id
 x6-20020a05600c21c600b003f4fbd9cdb3sm2979228wmj.34.2023.05.19.10.15.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 10:15:16 -0700 (PDT)
Message-ID: <7021189b-4034-f5e7-4e72-0a4276d0bc8a@linaro.org>
Date: Fri, 19 May 2023 19:15:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v5 6/11] riscv: Initial commit of OpenTitan machine
Content-Language: en-US
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: bmeng.cn@gmail.com, palmer@dabbelt.com, alistair23@gmail.com
References: <cover.1590704015.git.alistair.francis@wdc.com>
 <0ab3cecbe801f9e14ad1a5447d02483b9008fdbb.1590704015.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <0ab3cecbe801f9e14ad1a5447d02483b9008fdbb.1590704015.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.527,
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

Hi Alistair,

[Old patch]

On 29/5/20 00:14, Alistair Francis wrote:
> This adds a barebone OpenTitan machine to QEMU.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Bin Meng <bin.meng@windriver.com>
> ---
>   default-configs/riscv32-softmmu.mak |   1 +
>   default-configs/riscv64-softmmu.mak |  11 +-
>   include/hw/riscv/opentitan.h        |  68 ++++++++++
>   hw/riscv/opentitan.c                | 184 ++++++++++++++++++++++++++++
>   MAINTAINERS                         |   9 ++
>   hw/riscv/Kconfig                    |   5 +
>   hw/riscv/Makefile.objs              |   1 +
>   7 files changed, 278 insertions(+), 1 deletion(-)
>   create mode 100644 include/hw/riscv/opentitan.h
>   create mode 100644 hw/riscv/opentitan.c


> diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan.h
> new file mode 100644
> index 0000000000..a4b6499444
> --- /dev/null
> +++ b/include/hw/riscv/opentitan.h
> @@ -0,0 +1,68 @@
> +/*
> + * QEMU RISC-V Board Compatible with OpenTitan FPGA platform
> + *
> + * Copyright (c) 2020 Western Digital
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_OPENTITAN_H
> +#define HW_OPENTITAN_H
> +
> +#include "hw/riscv/riscv_hart.h"
> +
> +#define TYPE_RISCV_IBEX_SOC "riscv.lowrisc.ibex.soc"
> +#define RISCV_IBEX_SOC(obj) \
> +    OBJECT_CHECK(LowRISCIbexSoCState, (obj), TYPE_RISCV_IBEX_SOC)
> +
> +typedef struct LowRISCIbexSoCState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    RISCVHartArrayState cpus;
> +    MemoryRegion flash_mem;
> +    MemoryRegion rom;
> +} LowRISCIbexSoCState;
> +
> +typedef struct OpenTitanState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;

Shouldn't this object inheritate from MachineState ...?

> +    /*< public >*/
> +    LowRISCIbexSoCState soc;
> +} OpenTitanState;


> diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
> new file mode 100644
> index 0000000000..b4fb836466
> --- /dev/null
> +++ b/hw/riscv/opentitan.c
> @@ -0,0 +1,184 @@
> +/*
> + * QEMU RISC-V Board Compatible with OpenTitan FPGA platform
> + *
> + * Copyright (c) 2020 Western Digital
> + *
> + * Provides a board compatible with the OpenTitan FPGA platform:
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/riscv/opentitan.h"
> +#include "qapi/error.h"
> +#include "hw/boards.h"
> +#include "hw/misc/unimp.h"
> +#include "hw/riscv/boot.h"
> +#include "exec/address-spaces.h"
> +
> +static const struct MemmapEntry {
> +    hwaddr base;
> +    hwaddr size;
> +} ibex_memmap[] = {
> +    [IBEX_ROM] =            {  0x00008000,   0xc000 },
> +    [IBEX_RAM] =            {  0x10000000,  0x10000 },
> +    [IBEX_FLASH] =          {  0x20000000,  0x80000 },
> +    [IBEX_UART] =           {  0x40000000,  0x10000 },
> +    [IBEX_GPIO] =           {  0x40010000,  0x10000 },
> +    [IBEX_SPI] =            {  0x40020000,  0x10000 },
> +    [IBEX_FLASH_CTRL] =     {  0x40030000,  0x10000 },
> +    [IBEX_PINMUX] =         {  0x40070000,  0x10000 },
> +    [IBEX_RV_TIMER] =       {  0x40080000,  0x10000 },
> +    [IBEX_PLIC] =           {  0x40090000,  0x10000 },
> +    [IBEX_PWRMGR] =         {  0x400A0000,  0x10000 },
> +    [IBEX_RSTMGR] =         {  0x400B0000,  0x10000 },
> +    [IBEX_CLKMGR] =         {  0x400C0000,  0x10000 },
> +    [IBEX_AES] =            {  0x40110000,  0x10000 },
> +    [IBEX_HMAC] =           {  0x40120000,  0x10000 },
> +    [IBEX_ALERT_HANDLER] =  {  0x40130000,  0x10000 },
> +    [IBEX_NMI_GEN] =        {  0x40140000,  0x10000 },
> +    [IBEX_USBDEV] =         {  0x40150000,  0x10000 },
> +    [IBEX_PADCTRL] =        {  0x40160000,  0x10000 }
> +};
> +
> +static void riscv_opentitan_init(MachineState *machine)
> +{
> +    const struct MemmapEntry *memmap = ibex_memmap;
> +    OpenTitanState *s = g_new0(OpenTitanState, 1);

... because looking at QOM design issue, this line looks dubious.

> +    MemoryRegion *sys_mem = get_system_memory();
> +    MemoryRegion *main_mem = g_new(MemoryRegion, 1);
> +
> +    /* Initialize SoC */
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc,
> +                            sizeof(s->soc), TYPE_RISCV_IBEX_SOC,
> +                            &error_abort, NULL);
> +    object_property_set_bool(OBJECT(&s->soc), true, "realized",
> +                            &error_abort);
> +
> +    memory_region_init_ram(main_mem, NULL, "riscv.lowrisc.ibex.ram",
> +        memmap[IBEX_RAM].size, &error_fatal);
> +    memory_region_add_subregion(sys_mem,
> +        memmap[IBEX_RAM].base, main_mem);
> +
> +
> +    if (machine->firmware) {
> +        riscv_load_firmware(machine->firmware, memmap[IBEX_RAM].base, NULL);
> +    }
> +
> +    if (machine->kernel_filename) {
> +        riscv_load_kernel(machine->kernel_filename, NULL);
> +    }
> +}

