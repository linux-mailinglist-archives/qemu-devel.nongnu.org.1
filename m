Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0C57DA70C
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 15:04:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwiyg-0003is-3l; Sat, 28 Oct 2023 09:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qwiye-0003fe-0r
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 09:03:44 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qwiyb-0005q0-FY
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 09:03:43 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 8FBD2756082;
 Sat, 28 Oct 2023 15:03:41 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3EBF27456A7; Sat, 28 Oct 2023 15:03:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3CD11745681;
 Sat, 28 Oct 2023 15:03:41 +0200 (CEST)
Date: Sat, 28 Oct 2023 15:03:41 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 5/5] hw/isa/vt82c686: Implement software-based SMI
 triggering
In-Reply-To: <20231028091606.23700-6-shentey@gmail.com>
Message-ID: <95144ce6-b340-11bf-354b-e73c2fbc795e@eik.bme.hu>
References: <20231028091606.23700-1-shentey@gmail.com>
 <20231028091606.23700-6-shentey@gmail.com>
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

On Sat, 28 Oct 2023, Bernhard Beschow wrote:
> If enabled, SMIs can be triggered via software by writing to an IO-mapped port.
> SMIs usually trigger execution of BIOS code. If appropriate values are written
> to the port, the BIOS transitions the system into or out of ACPI mode.
>
> Note that APMState implements Intel-specific behavior where there are two IO
> ports which are mapped at fixed addresses. In VIA, there is only one such port
> which is located inside a relocatable IO-mapped region. Hence, there is no point
> in reusing APMState.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> hw/isa/vt82c686.c | 95 +++++++++++++++++++++++++++++++++++++++++++----
> 1 file changed, 87 insertions(+), 8 deletions(-)
>
> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
> index e8ec63dea9..361b3bed0a 100644
> --- a/hw/isa/vt82c686.c
> +++ b/hw/isa/vt82c686.c
> @@ -27,7 +27,6 @@
> #include "hw/timer/i8254.h"
> #include "hw/rtc/mc146818rtc.h"
> #include "migration/vmstate.h"
> -#include "hw/isa/apm.h"
> #include "hw/acpi/acpi.h"
> #include "hw/i2c/pm_smbus.h"
> #include "qapi/error.h"
> @@ -42,6 +41,16 @@
> #define TYPE_VIA_PM "via-pm"
> OBJECT_DECLARE_SIMPLE_TYPE(ViaPMState, VIA_PM)
>
> +#define VIA_PM_IO_GBLEN 0x2a
> +#define VIA_PM_IO_GBLEN_SW_SMI_EN (1 << 6)
> +
> +#define VIA_PM_IO_GBLCTL 0x2c
> +#define VIA_PM_IO_GBLCTL_SMI_EN 1
> +#define VIA_PM_IO_GBLCTL_SMIIG (1 << 4)
> +#define VIA_PM_IO_GBLCTL_INSMI (1 << 8)
> +
> +#define VIA_PM_IO_SMI_CMD 0x2f
> +
> #define VIA_PM_GPE_LEN 4
>
> #define VIA_PM_SCI_SELECT_OFS 0x42

If we'll make a copy of the data sheet in form of #defines could these be 
in the header to less clutter the source?

Regards,
BALATON Zoltan

> @@ -49,14 +58,19 @@ OBJECT_DECLARE_SIMPLE_TYPE(ViaPMState, VIA_PM)
>
> struct ViaPMState {
>     PCIDevice dev;
> +
>     MemoryRegion io;
>     ACPIREGS ar;
> -    APMState apm;
> +    uint16_t gbl_en;
> +    uint16_t gbl_ctl;
> +    uint8_t smi_cmd;
> +
>     PMSMBus smb;
>
>     Notifier powerdown_notifier;
>
>     qemu_irq sci_irq;
> +    qemu_irq smi_irq;
> };
>
> static void pm_io_space_update(ViaPMState *s)
> @@ -90,7 +104,7 @@ static int vmstate_acpi_post_load(void *opaque, int version_id)
>
> static const VMStateDescription vmstate_acpi = {
>     .name = "vt82c686b_pm",
> -    .version_id = 1,
> +    .version_id = 2,
>     .minimum_version_id = 1,
>     .post_load = vmstate_acpi_post_load,
>     .fields = (VMStateField[]) {
> @@ -98,9 +112,11 @@ static const VMStateDescription vmstate_acpi = {
>         VMSTATE_UINT16(ar.pm1.evt.sts, ViaPMState),
>         VMSTATE_UINT16(ar.pm1.evt.en, ViaPMState),
>         VMSTATE_UINT16(ar.pm1.cnt.cnt, ViaPMState),
> -        VMSTATE_STRUCT(apm, ViaPMState, 0, vmstate_apm, APMState),
>         VMSTATE_TIMER_PTR(ar.tmr.timer, ViaPMState),
>         VMSTATE_INT64(ar.tmr.overflow_time, ViaPMState),
> +        VMSTATE_UINT16(gbl_en, ViaPMState),
> +        VMSTATE_UINT16(gbl_ctl, ViaPMState),
> +        VMSTATE_UINT8(smi_cmd, ViaPMState),
>         VMSTATE_END_OF_LIST()
>     }
> };
> @@ -128,15 +144,75 @@ static void pm_write_config(PCIDevice *d, uint32_t addr, uint32_t val, int len)
>     }
> }
>
> +static void via_pm_apm_ctrl_changed(ViaPMState *s, uint8_t val)
> +{
> +    s->smi_cmd = val;
> +
> +    if (s->gbl_en & VIA_PM_IO_GBLEN_SW_SMI_EN
> +        && s->gbl_ctl & VIA_PM_IO_GBLCTL_SMI_EN
> +        && !(s->gbl_ctl & VIA_PM_IO_GBLCTL_SMIIG
> +             && s->gbl_ctl & VIA_PM_IO_GBLCTL_INSMI)) {
> +        s->gbl_ctl |= VIA_PM_IO_GBLCTL_INSMI;
> +
> +        if (s->smi_irq) {
> +            qemu_irq_raise(s->smi_irq);
> +        }
> +    }
> +}
> +
> static void pm_io_write(void *op, hwaddr addr, uint64_t data, unsigned size)
> {
> +    ViaPMState *s = op;
> +
>     trace_via_pm_io_write(addr, data, size);
> +
> +    switch (addr) {
> +    case VIA_PM_IO_GBLEN:
> +        s->gbl_en = (s->gbl_en & 0xff00) | data;
> +        break;
> +    case VIA_PM_IO_GBLEN + 1:
> +        s->gbl_en = (s->gbl_en & 0x00ff) | (data << 8);
> +        break;
> +    case VIA_PM_IO_GBLCTL:
> +        s->gbl_ctl = (s->gbl_ctl & 0xff00) | data;
> +        break;
> +    case VIA_PM_IO_GBLCTL + 1:
> +        data <<= 8;
> +        data &= ~(s->gbl_ctl & VIA_PM_IO_GBLCTL_INSMI);
> +        s->gbl_ctl = (s->gbl_ctl & 0x00ff) | data;
> +        break;
> +    case VIA_PM_IO_SMI_CMD:
> +        via_pm_apm_ctrl_changed(s, data);
> +        break;
> +    }
> }
>
> static uint64_t pm_io_read(void *op, hwaddr addr, unsigned size)
> {
> -    trace_via_pm_io_read(addr, 0, size);
> -    return 0;
> +    ViaPMState *s = op;
> +    uint64_t data = 0;
> +
> +    switch (addr) {
> +    case VIA_PM_IO_GBLEN:
> +        data = s->gbl_en & 0xff;
> +        break;
> +    case VIA_PM_IO_GBLEN + 1:
> +        data = s->gbl_en >> 8;
> +        break;
> +    case VIA_PM_IO_GBLCTL:
> +        data = s->gbl_ctl & 0xff;
> +        break;
> +    case VIA_PM_IO_GBLCTL + 1:
> +        data = (s->gbl_ctl >> 8) & 0xd;
> +        break;
> +    case VIA_PM_IO_SMI_CMD:
> +        data = s->smi_cmd;
> +        break;
> +    }
> +
> +    trace_via_pm_io_read(addr, data, size);
> +
> +    return data;
> }
>
> static const MemoryRegionOps pm_io_ops = {
> @@ -166,6 +242,10 @@ static void via_pm_reset(DeviceState *d)
>     /* SMBus IO base */
>     pci_set_long(s->dev.config + 0x90, 1);
>
> +    s->gbl_en = 0;
> +    s->gbl_ctl = VIA_PM_IO_GBLCTL_SMIIG;
> +    s->smi_cmd = 0;
> +
>     acpi_pm1_evt_reset(&s->ar);
>     acpi_pm1_cnt_reset(&s->ar);
>     acpi_pm_tmr_reset(&s->ar);
> @@ -194,8 +274,6 @@ static void via_pm_realize(PCIDevice *dev, Error **errp)
>     memory_region_add_subregion(pci_address_space_io(dev), 0, &s->smb.io);
>     memory_region_set_enabled(&s->smb.io, false);
>
> -    apm_init(dev, &s->apm, NULL, s);
> -
>     memory_region_init_io(&s->io, OBJECT(dev), &pm_io_ops, s, "via-pm", 128);
>     memory_region_add_subregion(pci_address_space_io(dev), 0, &s->io);
>     memory_region_set_enabled(&s->io, false);
> @@ -214,6 +292,7 @@ static void via_pm_init(Object *obj)
>     ViaPMState *s = VIA_PM(obj);
>
>     qdev_init_gpio_out_named(DEVICE(obj), &s->sci_irq, "sci", 1);
> +    qdev_init_gpio_out_named(DEVICE(obj), &s->smi_irq, "smi-irq", 1);
> }
>
> typedef struct via_pm_init_info {
>

