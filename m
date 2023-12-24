Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FFD81D76E
	for <lists+qemu-devel@lfdr.de>; Sun, 24 Dec 2023 01:53:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHCis-0006dD-OU; Sat, 23 Dec 2023 19:52:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rHCio-0006cl-Ph; Sat, 23 Dec 2023 19:52:02 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rHCim-0005qi-IK; Sat, 23 Dec 2023 19:52:02 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 79DB875A4BE;
 Sun, 24 Dec 2023 01:51:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id KRSTYa1n5fMC; Sun, 24 Dec 2023 01:51:53 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8B0CD75A4B7; Sun, 24 Dec 2023 01:51:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 88E11756078;
 Sun, 24 Dec 2023 01:51:53 +0100 (CET)
Date: Sun, 24 Dec 2023 01:51:53 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Leonardo Bras <leobras@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 12/12] hw/isa/vt82c686: Implement relocation and
 toggling of SuperI/O functions
In-Reply-To: <B0C3E617-569E-4DD2-900A-5ACF093C3B63@gmail.com>
Message-ID: <acf63b63-df0d-1223-1022-292a396d717e@eik.bme.hu>
References: <20231218185114.119736-1-shentey@gmail.com>
 <20231218185114.119736-13-shentey@gmail.com>
 <9c472e25-506f-fbd5-6d72-00be078bb15c@eik.bme.hu>
 <B0C3E617-569E-4DD2-900A-5ACF093C3B63@gmail.com>
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

On Tue, 19 Dec 2023, Bernhard Beschow wrote:
> Am 19. Dezember 2023 00:26:15 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>> On Mon, 18 Dec 2023, Bernhard Beschow wrote:
>>> The VIA south bridges are able to relocate and toggle (enable or disable) their
>>> SuperI/O functions. So far this is hardcoded such that all functions are always
>>> enabled and are located at fixed addresses.
>>>
>>> Some PC BIOSes seem to probe for I/O occupancy before activating such a function
>>> and issue an error in case of a conflict. Since the functions are enabled on
>>> reset, conflicts are always detected. Prevent that by implementing relocation
>>> and toggling of the SuperI/O functions.
>>>
>>> Note that all SuperI/O functions are now deactivated upon reset (except for
>>> VT82C686B's serial ports where Fuloong 2e's rescue-yl seems to expect them to be
>>> enabled by default). Rely on firmware -- or in case of pegasos2 on board code if
>>> no -bios is given -- to configure the functions accordingly.
>>
>> Pegasos2 emulates firmware when no -bios is given, this was explained in previos commit so maybe not needed to be explained it here again so you could drop the comment between -- -- but I don't mind.
>>
>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>> ---
>>> hw/isa/vt82c686.c | 121 ++++++++++++++++++++++++++++++++++------------
>>> 1 file changed, 90 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
>>> index 9c2333a277..be202d23cf 100644
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
>>> @@ -343,6 +346,35 @@ static const TypeInfo via_superio_info = {
>>>
>>> #define TYPE_VT82C686B_SUPERIO "vt82c686b-superio"
>>>
>>> +static void vt82c686b_superio_update(ViaSuperIOState *s)
>>> +{
>>> +    isa_parallel_set_enabled(s->superio.parallel[0],
>>> +                             (s->regs[0xe2] & 0x3) != 3);
>>> +    isa_serial_set_enabled(s->superio.serial[0], s->regs[0xe2] & BIT(2));
>>> +    isa_serial_set_enabled(s->superio.serial[1], s->regs[0xe2] & BIT(3));
>>> +    isa_fdc_set_enabled(s->superio.floppy, s->regs[0xe2] & BIT(4));
>>> +
>>> +    isa_fdc_set_iobase(s->superio.floppy, (s->regs[0xe3] & 0xfc) << 2);
>>> +    isa_parallel_set_iobase(s->superio.parallel[0], s->regs[0xe6] << 2);
>>> +    isa_serial_set_iobase(s->superio.serial[0], (s->regs[0xe7] & 0xfe) << 2);
>>> +    isa_serial_set_iobase(s->superio.serial[1], (s->regs[0xe8] & 0xfe) << 2);
>>> +}
>>
>> I wonder if some code duplication could be saved by adding a shared via_superio_update() for this further up in the abstract via-superio class instead of this method and vt8231_superio_update() below. This common method in abstract class would need to handle the differences which seem to be reg addresses offset by 0x10 and VT8231 having only 1 serial port. These could either be handled by adding function parameters or fields to ViaSuperIOState for this that the subclasses can set and the method check. (Such as reg base=0xe2 for vt82c686 and 0xf2 for vt8231 and num_serial or similar for how many ports are there then can have a for loop for those that would only run once for vt8231).
>
> Only the enable bits and the parallel port base address line up, the 
> serial port(s) and the floppy would need special treatment. Not worth it 
> IMO.

Missed this part in previous reply. The serial ports would be taken care 
of by a loop for number of ports so only the floppy needs an if which 
could also use the number of serial ports for lack of better way to 
distinguish these cips easily. Number of ports are in the superio class 
which you could get with ISA_SUPERIO_GET_CLASS (see via_superio_realize) 
then serial.count would be 2 for 686b and 1 for 8231.

But now I think another way may be better that is to drop the 
superio_update function as this updates all functions on writing any 
register unnecessarily and put the lines from it in the 
vt*_superio_cfg_write() functions under the separate cases. This was the 
original intent, that's why the reset function goes through that write 
function so it can enable/disable functions. That way you could apply mask 
on write so via_superio_cfg_read() would return 0 bits as 0 (although the 
data sheet is not clear about what real chip does, just says these must be 
0 not that it's enforced but if we enforce that it's probably better to 
return the effective value on read as well). Then when state saving is 
added in separate patch you can have a similar function as 
vt82c686b_superio_reset() (or rename that to update and make it use 
regs[xx] instead of constant values and call that from reset after setting 
regs values like you did here. But that needs more thought as the vmstate 
added by this patch is incomplete and would not work so you could just 
drop it for now and add it later with also adding other necessary state as 
well. The idea was to implement the chip first then add state saving so we 
don't need to bother with breaking it until we have a good enough 
implementation. So far the state saving there is just left over from the 
old model which never worked and only left there for reminder but only 
wanted to fix once the model is complete enough.

So I think for now you could drop vmstate stuff and distribute the 
superio_update lines in the superio_cfg_write functions so each reg only 
controls the function it should control. Then when vmstate saving is added 
later it could reuse superio_reset as an update function adding a new 
reset func setting reg values and calling the old reset/new update 
function. Does that make sense?

Regards,
BALATON Zoltan

