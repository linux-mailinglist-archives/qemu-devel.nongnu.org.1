Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE198279DE
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 22:01:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMwgs-0001F5-E5; Mon, 08 Jan 2024 15:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rMwgk-0001B4-BV; Mon, 08 Jan 2024 15:57:38 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rMwge-0006ND-Kn; Mon, 08 Jan 2024 15:57:36 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 967764E6DBE;
 Mon,  8 Jan 2024 21:57:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id l-ZGTS-8CfiR; Mon,  8 Jan 2024 21:57:25 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AA8C74E63FA; Mon,  8 Jan 2024 21:57:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A675774577C;
 Mon,  8 Jan 2024 21:57:25 +0100 (CET)
Date: Mon, 8 Jan 2024 21:57:25 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 =?ISO-8859-15?Q?Fr=E9d=E9ric_Barrat?= <fbarrat@linux.ibm.com>, 
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <huth@tuxfamily.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, 
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Juan Quintela <quintela@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Sergio Lopez <slp@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>
Subject: Re: [PATCH v4 11/11] hw/isa/vt82c686: Implement relocation and
 toggling of SuperI/O functions
In-Reply-To: <953F5075-4774-457F-BC9C-DA021DED8C0F@gmail.com>
Message-ID: <eb8eed24-9ec9-0ad1-95f7-989edfb5199d@eik.bme.hu>
References: <20240106210531.140542-1-shentey@gmail.com>
 <20240106210531.140542-12-shentey@gmail.com>
 <43de62e3-67d0-f013-2f4b-21ec1a78dbee@eik.bme.hu>
 <953F5075-4774-457F-BC9C-DA021DED8C0F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

On Mon, 8 Jan 2024, Bernhard Beschow wrote:
> Am 7. Januar 2024 13:59:44 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>> On Sat, 6 Jan 2024, Bernhard Beschow wrote:
>>> The VIA south bridges are able to relocate and toggle (enable or disable) their
>>> SuperI/O functions. So far this is hardcoded such that all functions are always
>>> enabled and are located at fixed addresses.
>>>
>>> Some PC BIOSes seem to probe for I/O occupancy before activating such a function
>>> and issue an error in case of a conflict. Since the functions are currently
>>> enabled on reset, conflicts are always detected. Prevent that by implementing
>>> relocation and toggling of the SuperI/O functions.
>>>
>>> Note that all SuperI/O functions are now deactivated upon reset (except for
>>> VT82C686B's serial ports where Fuloong 2e's rescue-yl seems to expect them to be
>>> enabled by default). Rely on firmware to configure the functions accordingly.
>>>
>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>> ---
>>> hw/isa/vt82c686.c | 66 ++++++++++++++++++++++++++++++++++++++++-------
>>> 1 file changed, 56 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
>>> index d3e0f6d01f..9f62fb5964 100644
>>> --- a/hw/isa/vt82c686.c
>>> +++ b/hw/isa/vt82c686.c
>>> @@ -15,6 +15,9 @@
>>>
>>> #include "qemu/osdep.h"
>>> #include "hw/isa/vt82c686.h"
>>> +#include "hw/block/fdc.h"
>>> +#include "hw/char/parallel-isa.h"
>>> +#include "hw/char/serial.h"
>>> #include "hw/pci/pci.h"
>>> #include "hw/qdev-properties.h"
>>> #include "hw/ide/pci.h"
>>> @@ -323,6 +326,18 @@ static uint64_t via_superio_cfg_read(void *opaque, hwaddr addr, unsigned size)
>>>     return val;
>>> }
>>>
>>> +static void via_superio_devices_enable(ViaSuperIOState *s, uint8_t data)
>>> +{
>>> +    ISASuperIOClass *ic = ISA_SUPERIO_GET_CLASS(s);
>>> +    size_t i;
>>
>> The expected value for i is 0 or 1 (maybe up to 3 sometimes it there are more serial ports in a chip). so why use such big type?
>
> serial.count is of type size_t, that's why I chose it. Let me know if you still want an int, otherwise I'd leave it as is.

I think int would suffice here but it's not a big deal. The count is 
indeed size_t, not sure why. How many components were expected? But the 
practical value is just a few so larger type seems to be an overkill.

Regards,
BALATON Zoltan

> Best regards,
> Bernhard
>
>> This should just be int. Newly it's also allowed to declare it within the for so if you want that you could do so but I have no preference on that and declaring it here is also OK. Otherwise:
>>
>> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
>>
>>> +
>>> +    isa_parallel_set_enabled(s->superio.parallel[0], (data & 0x3) != 3);
>>> +    for (i = 0; i < ic->serial.count; i++) {
>>> +        isa_serial_set_enabled(s->superio.serial[i], data & BIT(i + 2));
>>> +    }
>>> +    isa_fdc_set_enabled(s->superio.floppy, data & BIT(4));
>>> +}
>>> +
>>> static void via_superio_class_init(ObjectClass *klass, void *data)
>>> {
>>>     DeviceClass *dc = DEVICE_CLASS(klass);
>>> @@ -368,7 +383,25 @@ static void vt82c686b_superio_cfg_write(void *opaque, hwaddr addr,
>>>     case 0xfd ... 0xff:
>>>         /* ignore write to read only registers */
>>>         return;
>>> -    /* case 0xe6 ... 0xe8: Should set base port of parallel and serial */
>>> +    case 0xe2:
>>> +        data &= 0x1f;
>>> +        via_superio_devices_enable(sc, data);
>>> +        break;
>>> +    case 0xe3:
>>> +        data &= 0xfc;
>>> +        isa_fdc_set_iobase(sc->superio.floppy, data << 2);
>>> +        break;
>>> +    case 0xe6:
>>> +        isa_parallel_set_iobase(sc->superio.parallel[0], data << 2);
>>> +        break;
>>> +    case 0xe7:
>>> +        data &= 0xfe;
>>> +        isa_serial_set_iobase(sc->superio.serial[0], data << 2);
>>> +        break;
>>> +    case 0xe8:
>>> +        data &= 0xfe;
>>> +        isa_serial_set_iobase(sc->superio.serial[1], data << 2);
>>> +        break;
>>>     default:
>>>         qemu_log_mask(LOG_UNIMP,
>>>                       "via_superio_cfg: unimplemented register 0x%x\n", idx);
>>> @@ -395,9 +428,14 @@ static void vt82c686b_superio_reset(DeviceState *dev)
>>>     /* Device ID */
>>>     vt82c686b_superio_cfg_write(s, 0, 0xe0, 1);
>>>     vt82c686b_superio_cfg_write(s, 1, 0x3c, 1);
>>> -    /* Function select - all disabled */
>>> +    /*
>>> +     * Function select - only serial enabled
>>> +     * Fuloong 2e's rescue-yl prints to the serial console w/o enabling it. This
>>> +     * suggests that the serial ports are enabled by default, so override the
>>> +     * datasheet.
>>> +     */
>>>     vt82c686b_superio_cfg_write(s, 0, 0xe2, 1);
>>> -    vt82c686b_superio_cfg_write(s, 1, 0x03, 1);
>>> +    vt82c686b_superio_cfg_write(s, 1, 0x0f, 1);
>>>     /* Floppy ctrl base addr 0x3f0-7 */
>>>     vt82c686b_superio_cfg_write(s, 0, 0xe3, 1);
>>>     vt82c686b_superio_cfg_write(s, 1, 0xfc, 1);
>>> @@ -465,6 +503,21 @@ static void vt8231_superio_cfg_write(void *opaque, hwaddr addr,
>>>     case 0xfd:
>>>         /* ignore write to read only registers */
>>>         return;
>>> +    case 0xf2:
>>> +        data &= 0x17;
>>> +        via_superio_devices_enable(sc, data);
>>> +        break;
>>> +    case 0xf4:
>>> +        data &= 0xfe;
>>> +        isa_serial_set_iobase(sc->superio.serial[0], data << 2);
>>> +        break;
>>> +    case 0xf6:
>>> +        isa_parallel_set_iobase(sc->superio.parallel[0], data << 2);
>>> +        break;
>>> +    case 0xf7:
>>> +        data &= 0xfc;
>>> +        isa_fdc_set_iobase(sc->superio.floppy, data << 2);
>>> +        break;
>>>     default:
>>>         qemu_log_mask(LOG_UNIMP,
>>>                       "via_superio_cfg: unimplemented register 0x%x\n", idx);
>>> @@ -513,12 +566,6 @@ static void vt8231_superio_init(Object *obj)
>>>     VIA_SUPERIO(obj)->io_ops = &vt8231_superio_cfg_ops;
>>> }
>>>
>>> -static uint16_t vt8231_superio_serial_iobase(ISASuperIODevice *sio,
>>> -                                             uint8_t index)
>>> -{
>>> -        return 0x2f8; /* FIXME: This should be settable via registers f2-f4 */
>>> -}
>>> -
>>> static void vt8231_superio_class_init(ObjectClass *klass, void *data)
>>> {
>>>     DeviceClass *dc = DEVICE_CLASS(klass);
>>> @@ -526,7 +573,6 @@ static void vt8231_superio_class_init(ObjectClass *klass, void *data)
>>>
>>>     dc->reset = vt8231_superio_reset;
>>>     sc->serial.count = 1;
>>> -    sc->serial.get_iobase = vt8231_superio_serial_iobase;
>>>     sc->parallel.count = 1;
>>>     sc->ide.count = 0; /* emulated by via-ide */
>>>     sc->floppy.count = 1;
>>>
>
>

