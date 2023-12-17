Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3A7816039
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 16:42:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEtGV-000871-B7; Sun, 17 Dec 2023 10:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rEtGS-000863-8F; Sun, 17 Dec 2023 10:41:12 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rEtGO-0007ja-1d; Sun, 17 Dec 2023 10:41:12 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B4B2D75A4C6;
 Sun, 17 Dec 2023 16:41:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id zJSB5xMYWlsZ; Sun, 17 Dec 2023 16:40:58 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C627C75607B; Sun, 17 Dec 2023 16:40:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C3D8A756066;
 Sun, 17 Dec 2023 16:40:58 +0100 (CET)
Date: Sun, 17 Dec 2023 16:40:58 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, 
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, 
 David Hildenbrand <david@redhat.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Kevin Wolf <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 Sergio Lopez <slp@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 Nicholas Piggin <npiggin@gmail.com>, Juan Quintela <quintela@redhat.com>, 
 =?ISO-8859-15?Q?Fr=E9d=E9ric_Barrat?= <fbarrat@linux.ibm.com>, 
 qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Leonardo Bras <leobras@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 12/12] hw/isa/vt82c686: Implement relocation of SuperI/O
 functions
In-Reply-To: <20231217144148.15511-13-shentey@gmail.com>
Message-ID: <9e1340f7-113e-1b92-568f-a2754293269c@eik.bme.hu>
References: <20231217144148.15511-1-shentey@gmail.com>
 <20231217144148.15511-13-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, 17 Dec 2023, Bernhard Beschow wrote:
> The VIA south bridges are able to relocate and enable or disable their SuperI/O
> functions. So far this is hardcoded such that all functions are always enabled
> and are located at fixed addresses.
>
> Some PC BIOSes seem to probe for I/O occupancy before activating such a function
> and issue an error in case of a conflict. Since the functions are enabled on
> reset, conflicts are always detected. Prevent that by implementing relocation of
> the SuperI/O functions.
>
> Note that the reset I/O region of VT8231's serial port changes from
> 0x2f8/enabled to 0x3f8/disabled. The ROM of the Pegasos II machine can handle it
> since it enables and relocates the I/O region accordingly.

"... but we need to do that when running without firmware which this patch 
does." or something like that is missing here to complete the sentence. I 
think this part changing pegasos2.c could be split off in its own patch 
coming before this one. Poking those registers before they are implemented 
is harmless (the ROM does that already) but would make two simpler patches 
instead of one doing two things.

This is a welcome change but since vt82c686 uses isa-superio I wonder if 
it there could be a way to add functions to isa-superio.c to set these 
base addresses and enable/disable deivces in runtime instead of poking the 
internals od superio in vt82c686.c? That looks to me a more object 
oriented approach. Or going further with that maybe the fdc and serial 
device objects should have methods to set their base that then either 
superio or vt82c686 could then use without peeking them or exposing the 
device sturctures.

Regards,
BALATON Zoltan

> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> hw/isa/vt82c686.c | 140 ++++++++++++++++++++++++++++++++++++----------
> hw/ppc/pegasos2.c |  15 +++++
> 2 files changed, 124 insertions(+), 31 deletions(-)
>
> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
> index 9c2333a277..8fbc016755 100644
> --- a/hw/isa/vt82c686.c
> +++ b/hw/isa/vt82c686.c
> @@ -15,6 +15,9 @@
>
> #include "qemu/osdep.h"
> #include "hw/isa/vt82c686.h"
> +#include "hw/block/fdc-isa.h"
> +#include "hw/char/parallel-isa.h"
> +#include "hw/char/serial-isa.h"
> #include "hw/pci/pci.h"
> #include "hw/qdev-properties.h"
> #include "hw/ide/pci.h"
> @@ -343,6 +346,46 @@ static const TypeInfo via_superio_info = {
>
> #define TYPE_VT82C686B_SUPERIO "vt82c686b-superio"
>
> +static void vt82c686b_superio_update(ViaSuperIOState *s)
> +{
> +    FDCtrlISABus *fd = ISA_FDC(s->superio.floppy);
> +    ISASerialState *ss1 = ISA_SERIAL(s->superio.serial[0]);
> +    ISASerialState *ss2 = ISA_SERIAL(s->superio.serial[1]);
> +    ISAParallelState *ps = ISA_PARALLEL(s->superio.parallel[0]);
> +
> +    portio_list_set_enabled(&ps->state.portio_list, (s->regs[0xe2] & 0x3) != 3);
> +    memory_region_set_enabled(&ss1->state.io, s->regs[0xe2] & BIT(2));
> +    memory_region_set_enabled(&ss2->state.io, s->regs[0xe2] & BIT(3));
> +    portio_list_set_enabled(&fd->state.portio_list, s->regs[0xe2] & BIT(4));
> +
> +    fd->iobase = (s->regs[0xe3] & 0xfc) << 2;
> +    portio_list_set_address(&fd->state.portio_list, fd->iobase);
> +
> +    ps->iobase = s->regs[0xe6] << 2;
> +    portio_list_set_address(&ps->state.portio_list, ps->iobase);
> +
> +    ss1->iobase = (s->regs[0xe7] & 0xfe) << 2;
> +    memory_region_set_address(&ss1->state.io, ss1->iobase);
> +
> +    ss2->iobase = (s->regs[0xe8] & 0xfe) << 2;
> +    memory_region_set_address(&ss2->state.io, ss2->iobase);
> +}
> +
> +static int vmstate_vt82c686b_superio_post_load(void *opaque, int version_id)
> +{
> +    ViaSuperIOState *s = opaque;
> +
> +    vt82c686b_superio_update(s);
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_vt82c686b_superio = {
> +    .name = "vt82c686b_superio",
> +    .version_id = 1,
> +    .post_load = vmstate_vt82c686b_superio_post_load,
> +};
> +
> static void vt82c686b_superio_cfg_write(void *opaque, hwaddr addr,
>                                         uint64_t data, unsigned size)
> {
> @@ -368,7 +411,11 @@ static void vt82c686b_superio_cfg_write(void *opaque, hwaddr addr,
>     case 0xfd ... 0xff:
>         /* ignore write to read only registers */
>         return;
> -    /* case 0xe6 ... 0xe8: Should set base port of parallel and serial */
> +    case 0xe2 ... 0xe3:
> +    case 0xe6 ... 0xe8:
> +        sc->regs[idx] = data;
> +        vt82c686b_superio_update(sc);
> +        return;
>     default:
>         qemu_log_mask(LOG_UNIMP,
>                       "via_superio_cfg: unimplemented register 0x%x\n", idx);
> @@ -393,25 +440,24 @@ static void vt82c686b_superio_reset(DeviceState *dev)
>
>     memset(s->regs, 0, sizeof(s->regs));
>     /* Device ID */
> -    vt82c686b_superio_cfg_write(s, 0, 0xe0, 1);
> -    vt82c686b_superio_cfg_write(s, 1, 0x3c, 1);
> -    /* Function select - all disabled */
> -    vt82c686b_superio_cfg_write(s, 0, 0xe2, 1);
> -    vt82c686b_superio_cfg_write(s, 1, 0x03, 1);
> +    s->regs[0xe0] = 0x3c;
> +    /*
> +     * Function select - only serial enabled
> +     * Fuloong 2e's rescue-yl prints to the serial console w/o enabling it. This
> +     * suggests that the serial ports are enabled by default, so override the
> +     * datasheet.
> +     */
> +    s->regs[0xe2] = 0x0f;
>     /* Floppy ctrl base addr 0x3f0-7 */
> -    vt82c686b_superio_cfg_write(s, 0, 0xe3, 1);
> -    vt82c686b_superio_cfg_write(s, 1, 0xfc, 1);
> +    s->regs[0xe3] = 0xfc;
>     /* Parallel port base addr 0x378-f */
> -    vt82c686b_superio_cfg_write(s, 0, 0xe6, 1);
> -    vt82c686b_superio_cfg_write(s, 1, 0xde, 1);
> +    s->regs[0xe6] = 0xde;
>     /* Serial port 1 base addr 0x3f8-f */
> -    vt82c686b_superio_cfg_write(s, 0, 0xe7, 1);
> -    vt82c686b_superio_cfg_write(s, 1, 0xfe, 1);
> +    s->regs[0xe7] = 0xfe;
>     /* Serial port 2 base addr 0x2f8-f */
> -    vt82c686b_superio_cfg_write(s, 0, 0xe8, 1);
> -    vt82c686b_superio_cfg_write(s, 1, 0xbe, 1);
> +    s->regs[0xe8] = 0xbe;
>
> -    vt82c686b_superio_cfg_write(s, 0, 0, 1);
> +    vt82c686b_superio_update(s);
> }
>
> static void vt82c686b_superio_init(Object *obj)
> @@ -429,6 +475,7 @@ static void vt82c686b_superio_class_init(ObjectClass *klass, void *data)
>     sc->parallel.count = 1;
>     sc->ide.count = 0; /* emulated by via-ide */
>     sc->floppy.count = 1;
> +    dc->vmsd = &vmstate_vt82c686b_superio;
> }
>
> static const TypeInfo vt82c686b_superio_info = {
> @@ -443,6 +490,41 @@ static const TypeInfo vt82c686b_superio_info = {
>
> #define TYPE_VT8231_SUPERIO "vt8231-superio"
>
> +static void vt8231_superio_update(ViaSuperIOState *s)
> +{
> +    FDCtrlISABus *fd = ISA_FDC(s->superio.floppy);
> +    ISASerialState *ss = ISA_SERIAL(s->superio.serial[0]);
> +    ISAParallelState *ps = ISA_PARALLEL(s->superio.parallel[0]);
> +
> +    portio_list_set_enabled(&ps->state.portio_list, (s->regs[0xf2] & 0x3) != 3);
> +    memory_region_set_enabled(&ss->state.io, s->regs[0xf2] & BIT(2));
> +    portio_list_set_enabled(&fd->state.portio_list, s->regs[0xf2] & BIT(4));
> +
> +    ss->iobase = (s->regs[0xf4] & 0xfe) << 2;
> +    memory_region_set_address(&ss->state.io, ss->iobase);
> +
> +    ps->iobase = s->regs[0xf6] << 2;
> +    portio_list_set_address(&ps->state.portio_list, ps->iobase);
> +
> +    fd->iobase = (s->regs[0xf7] & 0xfc) << 2;
> +    portio_list_set_address(&fd->state.portio_list, fd->iobase);
> +}
> +
> +static int vmstate_vt8231_superio_post_load(void *opaque, int version_id)
> +{
> +    ViaSuperIOState *s = opaque;
> +
> +    vt8231_superio_update(s);
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_vt8231_superio = {
> +    .name = "vt8231_superio",
> +    .version_id = 1,
> +    .post_load = vmstate_vt8231_superio_post_load,
> +};
> +
> static void vt8231_superio_cfg_write(void *opaque, hwaddr addr,
>                                      uint64_t data, unsigned size)
> {
> @@ -465,6 +547,12 @@ static void vt8231_superio_cfg_write(void *opaque, hwaddr addr,
>     case 0xfd:
>         /* ignore write to read only registers */
>         return;
> +    case 0xf2:
> +    case 0xf4:
> +    case 0xf6 ... 0xf7:
> +        sc->regs[idx] = data;
> +        vt8231_superio_update(sc);
> +        return;
>     default:
>         qemu_log_mask(LOG_UNIMP,
>                       "via_superio_cfg: unimplemented register 0x%x\n", idx);
> @@ -493,19 +581,15 @@ static void vt8231_superio_reset(DeviceState *dev)
>     /* Device revision */
>     s->regs[0xf1] = 0x01;
>     /* Function select - all disabled */
> -    vt8231_superio_cfg_write(s, 0, 0xf2, 1);
> -    vt8231_superio_cfg_write(s, 1, 0x03, 1);
> +    s->regs[0xf2] = 0x03;
>     /* Serial port base addr */
> -    vt8231_superio_cfg_write(s, 0, 0xf4, 1);
> -    vt8231_superio_cfg_write(s, 1, 0xfe, 1);
> +    s->regs[0xf4] = 0xfe;
>     /* Parallel port base addr */
> -    vt8231_superio_cfg_write(s, 0, 0xf6, 1);
> -    vt8231_superio_cfg_write(s, 1, 0xde, 1);
> +    s->regs[0xf6] = 0xde;
>     /* Floppy ctrl base addr */
> -    vt8231_superio_cfg_write(s, 0, 0xf7, 1);
> -    vt8231_superio_cfg_write(s, 1, 0xfc, 1);
> +    s->regs[0xf7] = 0xfc;
>
> -    vt8231_superio_cfg_write(s, 0, 0, 1);
> +    vt8231_superio_update(s);
> }
>
> static void vt8231_superio_init(Object *obj)
> @@ -513,12 +597,6 @@ static void vt8231_superio_init(Object *obj)
>     VIA_SUPERIO(obj)->io_ops = &vt8231_superio_cfg_ops;
> }
>
> -static uint16_t vt8231_superio_serial_iobase(ISASuperIODevice *sio,
> -                                             uint8_t index)
> -{
> -        return 0x2f8; /* FIXME: This should be settable via registers f2-f4 */
> -}
> -
> static void vt8231_superio_class_init(ObjectClass *klass, void *data)
> {
>     DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -526,10 +604,10 @@ static void vt8231_superio_class_init(ObjectClass *klass, void *data)
>
>     dc->reset = vt8231_superio_reset;
>     sc->serial.count = 1;
> -    sc->serial.get_iobase = vt8231_superio_serial_iobase;
>     sc->parallel.count = 1;
>     sc->ide.count = 0; /* emulated by via-ide */
>     sc->floppy.count = 1;
> +    dc->vmsd = &vmstate_vt8231_superio;
> }
>
> static const TypeInfo vt8231_superio_info = {
> diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
> index 3203a4a728..0a40ebd542 100644
> --- a/hw/ppc/pegasos2.c
> +++ b/hw/ppc/pegasos2.c
> @@ -285,6 +285,15 @@ static void pegasos2_pci_config_write(Pegasos2MachineState *pm, int bus,
>     pegasos2_mv_reg_write(pm, pcicfg + 4, len, val);
> }
>
> +static void pegasos2_superio_write(Pegasos2MachineState *pm, uint32_t addr,
> +                                   uint32_t val)
> +{
> +    AddressSpace *as = CPU(pm->cpu)->as;
> +
> +    stb_phys(as, PCI1_IO_BASE + 0x3f0, addr);
> +    stb_phys(as, PCI1_IO_BASE + 0x3f1, val);
> +}
> +
> static void pegasos2_machine_reset(MachineState *machine, ShutdownCause reason)
> {
>     Pegasos2MachineState *pm = PEGASOS2_MACHINE(machine);
> @@ -310,6 +319,12 @@ static void pegasos2_machine_reset(MachineState *machine, ShutdownCause reason)
>
>     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
>                               PCI_INTERRUPT_LINE, 2, 0x9);
> +    pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
> +                              0x50, 1, 0x6);
> +    pegasos2_superio_write(pm, 0xf4, 0xbe);
> +    pegasos2_superio_write(pm, 0xf6, 0xef);
> +    pegasos2_superio_write(pm, 0xf7, 0xfc);
> +    pegasos2_superio_write(pm, 0xf2, 0x14);
>     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
>                               0x50, 1, 0x2);
>     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
>

