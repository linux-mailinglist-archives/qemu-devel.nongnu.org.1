Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE3081D765
	for <lists+qemu-devel@lfdr.de>; Sun, 24 Dec 2023 01:27:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHCJQ-0003KP-Ch; Sat, 23 Dec 2023 19:25:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rHCJN-0003JM-20; Sat, 23 Dec 2023 19:25:45 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rHCJK-00064F-O1; Sat, 23 Dec 2023 19:25:44 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 280A375A4C1;
 Sun, 24 Dec 2023 01:25:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id RmsYSmNOntLB; Sun, 24 Dec 2023 01:25:35 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3DAB775A4BE; Sun, 24 Dec 2023 01:25:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3B11A756078;
 Sun, 24 Dec 2023 01:25:35 +0100 (CET)
Date: Sun, 24 Dec 2023 01:25:35 +0100 (CET)
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
Message-ID: <7b17271a-29dd-6cef-549d-e134c781324b@eik.bme.hu>
References: <20231218185114.119736-1-shentey@gmail.com>
 <20231218185114.119736-13-shentey@gmail.com>
 <9c472e25-506f-fbd5-6d72-00be078bb15c@eik.bme.hu>
 <B0C3E617-569E-4DD2-900A-5ACF093C3B63@gmail.com>
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
> Only the enable bits and the parallel port base address line up, the serial port(s) and the floppy would need special treatment. Not worth it IMO.
>
>>
>>> +static int vmstate_vt82c686b_superio_post_load(void *opaque, int version_id)
>>> +{
>>> +    ViaSuperIOState *s = opaque;
>>> +
>>> +    vt82c686b_superio_update(s);
>>> +
>>> +    return 0;
>>
>> You could lose some blank lines here. You seem to love them, half of your cover letter is just blank lines :-)
>
> Yes, I want people to see the light rather than a wall (of text) ;-)

Well, information is in the text and anything else just distracts from it. 
I guess you can configure your editor to present text the way you like but 
it's hard for me or others to get rid of hard formatting so it's better to 
only add the needed text.

>> but I'm the opposite and like more code to fit in one screen even on todays displays that are wider than tall. So this funciton would take less space without blank lines. (Even the local variable may not be necessary as you don't access any fields within and void * should just cast without a warning but for spelling out the desired type as a reminder I'm ok with leaving that but no excessive blank lines please if you don't mind that much.)
>
> In this case I'll remove the s variable and the blank line above the return if that's so important to you.

I think it's simper and more readable that way that's why it's important 
to me.

Regards,
BALATON Zoltan

