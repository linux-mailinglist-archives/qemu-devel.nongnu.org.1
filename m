Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D11A7C964A
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 22:42:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrlSI-000806-HU; Sat, 14 Oct 2023 16:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qrlSG-0007zy-TO
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 16:41:48 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qrlSF-0004Lc-5O
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 16:41:48 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 61561757202;
 Sat, 14 Oct 2023 22:40:42 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 583B97456A7; Sat, 14 Oct 2023 22:40:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 54EE0745681;
 Sat, 14 Oct 2023 22:40:41 +0200 (CEST)
Date: Sat, 14 Oct 2023 22:40:41 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: deller@kernel.org
cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 08/12] hw/hppa: Require at least SeaBIOS-hppa version
 10
In-Reply-To: <20231014195719.151397-9-deller@kernel.org>
Message-ID: <342a3f01-0610-e7e4-b52a-2bbd5ab39f60@eik.bme.hu>
References: <20231014195719.151397-1-deller@kernel.org>
 <20231014195719.151397-9-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Sat, 14 Oct 2023, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
>
> The new SeaBIOS-hppa version 10 includes initial support
> for PA2.0 CPUs.

Patch does a few misc things not mentioned in commit message. Would those 
need to be split of in separate patch or mentioned here?

Regards,
BALATON Zoltan

> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
> hw/hppa/machine.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index cf28cb9586..c6d8deffcf 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -1,6 +1,8 @@
> /*
>  * QEMU HPPA hardware system emulator.
> - * Copyright 2018 Helge Deller <deller@gmx.de>
> + * (C) Copyright 2018-2023 Helge Deller <deller@gmx.de>
> + *
> + * This work is licensed under the GNU GPL license version 2 or later.
>  */
>
> #include "qemu/osdep.h"
> @@ -29,7 +31,7 @@
> #include "net/net.h"
> #include "qemu/log.h"
>
> -#define MIN_SEABIOS_HPPA_VERSION 6 /* require at least this fw version */
> +#define MIN_SEABIOS_HPPA_VERSION 10 /* require at least this fw version */
>
> #define HPA_POWER_BUTTON (FIRMWARE_END - 0x10)
>
> @@ -95,9 +97,7 @@ static ISABus *hppa_isa_bus(void)
>
>     isa_bus = isa_bus_new(NULL, get_system_memory(), isa_region,
>                           &error_abort);
> -    isa_irqs = i8259_init(isa_bus,
> -                          /* qemu_allocate_irq(dino_set_isa_irq, s, 0)); */
> -                          NULL);
> +    isa_irqs = i8259_init(isa_bus, NULL);
>     isa_bus_register_input_irqs(isa_bus, isa_irqs);
>
>     return isa_bus;
>

