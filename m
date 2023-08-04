Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41853770091
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 14:54:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRuJ4-0003rC-Ph; Fri, 04 Aug 2023 08:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRuIy-0003qX-I2
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 08:53:20 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRuIw-0003ns-Mp
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 08:53:20 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-522bc9556f5so2756414a12.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 05:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691153597; x=1691758397;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cLixGaYVMlT8KQNTYX8Vc9UsltoccqnmzBpAwDwULgk=;
 b=pY7TQVP3RFynmuMxsKx+uYnybgXbLzthG1R7+OYs30LupDxwsloysW9eLl+3z7egFK
 obXzwefT6b9lUNsQ0teHUU4kv+EDCOjOgEQI77G5TRhsR2Vv94oRvBzfgPGjMcnCHrpC
 aNLjPoklVWLL0ZeQBgpMIJwO0snXLchsFQxRz34evaRybTBqxO1IOoIxnB/nyTJZsCEd
 1ibhpSyCp6P1hkZ0XVtcCcr41w8Vt/wKWi0xm50ckYgZUb2Sg3/CuzSil5gnqkDdvTQQ
 5KgB7i7GFi1pTdyjJotNtUdzEseIF9r/2ekPcmn+hZBUNnqlysOd8tEQusbEIn+inFjD
 NsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691153597; x=1691758397;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cLixGaYVMlT8KQNTYX8Vc9UsltoccqnmzBpAwDwULgk=;
 b=R87FU6kmRCb8zAzgD3FVDPGpXOnEWPoZvo1G1vah0W4BW+bgzSWbNJwcMYlzTehH0o
 sMAn1DPVe01xUVVlV2uPNh53EVJQoYWnStbzZFCavbyYs9MdYXukSZFyJNZQlkaSRt4i
 13Afq5b5W4HVyh7l6sr6dsPsAvwiFIsEjRwt3FgnyWvbVI4mHs7Jh00WjtiVb9i2e6AY
 WWkOwoRKFkPYbzDx0CaY79815eaTjuN2rNYhabdfQNPwNGP7HnxQVlyUiEdfC7Xn6us2
 XZs+t4lRL3wXCFKnU+6RvaiHWoh6H9l/242tQSIZx7UZaFBrB+NyNiO/caeJ9b9xbjRy
 +gVg==
X-Gm-Message-State: AOJu0YwI62YRdvTCXOynk+Sb8fQIj7oA5YpgaaHNxtVwGHR8U5MSD1Rc
 DMbcmwe2PZ46ThvatRRTpk9vORxAnSnORvkVrKBbzA==
X-Google-Smtp-Source: AGHT+IFeCf9jVQUEwNjROYWNJCvzT2eYnOBiOQRkFf+DAMZr/+YVsSYLoCDJQ/Tu6MvJEiuTTsRUXdRRZcMokzD4fJo=
X-Received: by 2002:aa7:c147:0:b0:523:1410:a47d with SMTP id
 r7-20020aa7c147000000b005231410a47dmr1908289edp.24.1691153597078; Fri, 04 Aug
 2023 05:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20230726132512.149618-13-sergey.kambalin@auriga.com>
In-Reply-To: <20230726132512.149618-13-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 13:53:05 +0100
Message-ID: <CAFEAcA_w_TezAo2xLNrtSHZ+Fnz6foV_9fckgcghS0Er+cqtqQ@mail.gmail.com>
Subject: Re: [PATCH 12/44] Temporary disable unimplemented rpi4b devices
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Wed, 26 Jul 2023 at 14:56, Sergey Kambalin <serg.oker@gmail.com> wrote:

"Temporarily".

It would be good to note in the commit message that the
"remove devices from dt" code will all go away in following
commits but that it allows a kernel to boot at this point
(assuming that is what it does). That documents the motivation
for what is otherwise a slightly ugly looking hack.

>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/raspi.c                  |  2 +-
>  hw/arm/raspi4b.c                | 63 +++++++++++++++++++++++++++++++++
>  include/hw/arm/raspi_platform.h |  1 +
>  3 files changed, 65 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index da1e9e7c13..cffdd8de4e 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -75,7 +75,7 @@ static const struct {
>      [PROCESSOR_ID_BCM2838] = {TYPE_BCM2838, BCM283X_NCPUS},
>  };
>
> -static uint64_t board_ram_size(uint32_t board_rev)
> +uint64_t board_ram_size(uint32_t board_rev)
>  {
>      assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
>      return 256 * MiB << FIELD_EX32(board_rev, REV_CODE, MEMORY_SIZE);
> diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
> index 4096522d85..d2053c9380 100644
> --- a/hw/arm/raspi4b.c
> +++ b/hw/arm/raspi4b.c
> @@ -21,6 +21,7 @@
>  #include "hw/arm/boot.h"
>  #include "qom/object.h"
>  #include "hw/arm/bcm2838.h"
> +#include <libfdt.h>
>
>  #define TYPE_RASPI4B_MACHINE MACHINE_TYPE_NAME("raspi4b-common")
>  OBJECT_DECLARE_SIMPLE_TYPE(Raspi4bMachineState, RASPI4B_MACHINE)
> @@ -34,6 +35,61 @@ struct Raspi4bMachineState {
>      uint32_t vcram_size;
>  };
>
> +
> +static int raspi_add_memory_node(void *fdt, hwaddr mem_base, hwaddr mem_len)
> +{
> +    int ret;
> +    uint32_t acells, scells;
> +    char *nodename = g_strdup_printf("/memory@%" PRIx64, mem_base);
> +
> +    acells = qemu_fdt_getprop_cell(fdt, "/", "#address-cells",
> +                                   NULL, &error_fatal);
> +    scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells",
> +                                   NULL, &error_fatal);
> +    if (acells == 0 || scells == 0) {
> +        fprintf(stderr, "dtb file invalid (#address-cells or #size-cells 0)\n");
> +        ret = -1;
> +    } else {
> +        qemu_fdt_add_subnode(fdt, nodename);
> +        qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
> +        ret = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg",
> +                                           acells, mem_base,
> +                                           scells, mem_len);
> +    }
> +
> +    g_free(nodename);
> +    return ret;
> +}

Why do we need to add a memory node ? The commit message
doesn't say anything about doing this.

> +static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
> +{
> +
> +    /* Temporary disable following devices until they are implemented*/
> +    const char *to_be_removed_from_dt_as_wa[] = {
> +        "brcm,bcm2711-pcie",
> +        "brcm,bcm2711-rng200",
> +        "brcm,bcm2711-thermal",
> +        "brcm,bcm2711-genet-v5",
> +    };
> +
> +    for (int i = 0; i < ARRAY_SIZE(to_be_removed_from_dt_as_wa); i++) {
> +        const char *dev_str = to_be_removed_from_dt_as_wa[i];
> +
> +        int offset = fdt_node_offset_by_compatible(fdt, -1, dev_str);
> +        if (offset >= 0) {
> +            if (!fdt_nop_node(fdt, offset)) {
> +                warn_report("bcm2711 dtc: %s has been disabled!", dev_str);
> +            }
> +        }
> +    }
> +
> +    uint64_t ram_size = board_ram_size(info->board_id);

If you need to get at board-specific info in this hook,
the standard way to do it is to get the MachineState pointer
from the arm_boot_info pointer, like this:
    RaspiBaseMachineState *s_base = container_of(binfo,
RaspiBaseMachineState, binfo);

(which works because the arm_boot_info struct is embedded inside the
RaspiBaseMachineState struct).

But in this specific case I think you can probably work with
info->ram_size (it's the ram size adjusted by the vcram_size, I
think, but that's probably OK.)

> +
> +    if (ram_size > UPPER_RAM_BASE) {
> +        raspi_add_memory_node(fdt, UPPER_RAM_BASE, ram_size - UPPER_RAM_BASE);
> +    }
> +}
> +
>  static void raspi4b_machine_init(MachineState *machine)
>  {
>      Raspi4bMachineState *s = RASPI4B_MACHINE(machine);
> @@ -41,6 +97,13 @@ static void raspi4b_machine_init(MachineState *machine)
>      RaspiBaseMachineClass *mc = RASPI_BASE_MACHINE_GET_CLASS(machine);
>      BCM2838State *soc = &s->soc;
>
> +    s_base->binfo.modify_dtb = raspi4_modify_dtb;
> +    /*
> +     * Hack to get board revision during device tree modification without
> +     * changes of common code.
> +     * The correct way is to set board_id to MACH_TYPE_BCM2708 and add board_rev
> +     * to the arm_boot_info structure.
> +     */
>      s_base->binfo.board_id = mc->board_rev;

Then you can avoid this hack.

thanks
-- PMM

