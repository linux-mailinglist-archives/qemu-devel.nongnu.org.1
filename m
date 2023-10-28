Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B7A7DA70B
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 15:00:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwivA-00024t-7t; Sat, 28 Oct 2023 09:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qwiuz-0001zR-Q2
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 08:59:59 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qwiuy-0004rK-5X
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 08:59:57 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id B2BC3756088;
 Sat, 28 Oct 2023 14:59:56 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7BFC8756082; Sat, 28 Oct 2023 14:59:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7A6577456A7;
 Sat, 28 Oct 2023 14:59:56 +0200 (CEST)
Date: Sat, 28 Oct 2023 14:59:56 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 3/5] hw/isa/vt82c686: Reuse acpi_update_sci()
In-Reply-To: <20231028091606.23700-4-shentey@gmail.com>
Message-ID: <6199fe57-94b1-7633-e195-13519ef42a0c@eik.bme.hu>
References: <20231028091606.23700-1-shentey@gmail.com>
 <20231028091606.23700-4-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

On Sat, 28 Oct 2023, Bernhard Beschow wrote:
> acpi_update_sci() covers everything pm_update_sci() does. It implements common
> ACPI funtionality in a generic fashion. Note that it agnostic to any
> Frankenstein usage of the general purpose event registers in other device
> models. It just implements a generic mechanism which can be wired to arbitrary
> functionality.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> hw/isa/vt82c686.c | 20 ++------------------
> 1 file changed, 2 insertions(+), 18 deletions(-)
>
> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
> index 60ca781e03..7b44ad9485 100644
> --- a/hw/isa/vt82c686.c
> +++ b/hw/isa/vt82c686.c
> @@ -145,26 +145,10 @@ static const MemoryRegionOps pm_io_ops = {
>     },
> };
>
> -static void pm_update_sci(ViaPMState *s)
> -{
> -    int sci_level, pmsts;
> -
> -    pmsts = acpi_pm1_evt_get_sts(&s->ar);
> -    sci_level = (((pmsts & s->ar.pm1.evt.en) &
> -                  (ACPI_BITMASK_RT_CLOCK_ENABLE |
> -                   ACPI_BITMASK_POWER_BUTTON_ENABLE |
> -                   ACPI_BITMASK_GLOBAL_LOCK_ENABLE |
> -                   ACPI_BITMASK_TIMER_ENABLE)) != 0);

The level calculation in acpi_update_sci() is different than the above. 
Which one is correct and why?

Regards,
BALATON Zoltan

> -    qemu_set_irq(s->sci_irq, sci_level);
> -    /* schedule a timer interruption if needed */
> -    acpi_pm_tmr_update(&s->ar, (s->ar.pm1.evt.en & ACPI_BITMASK_TIMER_ENABLE) &&
> -                       !(pmsts & ACPI_BITMASK_TIMER_STATUS));
> -}
> -
> static void pm_tmr_timer(ACPIREGS *ar)
> {
>     ViaPMState *s = container_of(ar, ViaPMState, ar);
> -    pm_update_sci(s);
> +    acpi_update_sci(&s->ar, s->sci_irq);
> }
>
> static void via_pm_reset(DeviceState *d)
> @@ -182,7 +166,7 @@ static void via_pm_reset(DeviceState *d)
>     acpi_pm1_cnt_reset(&s->ar);
>     acpi_pm_tmr_reset(&s->ar);
>     acpi_gpe_reset(&s->ar);
> -    pm_update_sci(s);
> +    acpi_update_sci(&s->ar, s->sci_irq);
>
>     pm_io_space_update(s);
>     smb_io_space_update(s);
>

