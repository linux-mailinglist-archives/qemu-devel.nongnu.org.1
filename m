Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E90A822CA6
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 13:08:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL025-0000P0-5P; Wed, 03 Jan 2024 07:07:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1rL021-0000OI-OQ
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 07:07:33 -0500
Received: from jedlik.phy.bme.hu ([152.66.102.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1rL01y-00012t-Vs
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 07:07:33 -0500
Received: by jedlik.phy.bme.hu (Postfix, from userid 1000)
 id 7F3BEA00CF; Wed,  3 Jan 2024 13:00:35 +0100 (CET)
Date: Wed, 3 Jan 2024 13:00:35 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: [PATCH] docs/system: Document running Linux on amigaone
 machine
In-Reply-To: <2CA50F74-DE6D-4AD6-8581-EC22C80925B3@gmail.com>
Message-ID: <alpine.LMD.2.03.2401031258001.11743@eik.bme.hu>
References: <20231216123013.67978-1-shentey@gmail.com>
 <da92f16c-585a-7d1f-fa0b-9a6912f7760e@eik.bme.hu>
 <79067497-55AC-49EB-A0EE-909219E2C6A7@gmail.com>
 <6d50c5e7-ee6d-609f-c3e7-28f74eeeb714@eik.bme.hu>
 <2CA50F74-DE6D-4AD6-8581-EC22C80925B3@gmail.com>
User-Agent: Alpine 2.03 (LMD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
 BOUNDARY="1117279078-348480708-1704283235=:11743"
Received-SPF: none client-ip=152.66.102.83;
 envelope-from=balaton@jedlik.phy.bme.hu; helo=jedlik.phy.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1117279078-348480708-1704283235=:11743
Content-Type: TEXT/PLAIN; charset=utf-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 2 Jan 2024, Bernhard Beschow wrote:
> Am 16. Dezember 2023 21:15:54 UTC schrieb BALATON Zoltan <balaton@eik.bme=
=2Ehu>:
>> On Sat, 16 Dec 2023, Bernhard Beschow wrote:
>>> Am 16. Dezember 2023 12:53:55 UTC schrieb BALATON Zoltan <balaton@eik.b=
me.hu>:
>>>> On Sat, 16 Dec 2023, Bernhard Beschow wrote:
>>>>> Documentation on how to run Linux on the amigaone machine is currentl=
y burried
>>>>> in the depths of the qemu-devel mailing list [1] and in the source co=
de. Let's
>>>>> collect the information in the QEMU handbook for a one stop solution.
>>>>
>>>> Thanks for collecting this info and adding it as documentation.
>>>
>>> You're welcome!
>>>
>>>> A few small comments bellow.
>>>>
>>>>> [1] https://lore.kernel.org/qemu-devel/dafc407d-3749-e6f4-3a66-750fde=
8965f9@eik.bme.hu/
>>>>
>>>> Do we want to keep an URL in the commit log? kernel.org is quite stabl=
e but not sure it would need to be in the commit message.
>>>
>>> Let's drop it.
>>>
>>>>
>>>>> Co-authored-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>>>> ---
>>>>> MAINTAINERS                  |  1 +
>>>>> docs/system/ppc/amigaone.rst | 53 +++++++++++++++++++++++++++++++++++=
+
>>>>> docs/system/target-ppc.rst   |  1 +
>>>>> hw/ppc/amigaone.c            |  9 ------
>>>>> 4 files changed, 55 insertions(+), 9 deletions(-)
>>>>> create mode 100644 docs/system/ppc/amigaone.rst
>>>>>
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index 695e0bd34f..a2dd1407e2 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -1560,6 +1560,7 @@ amigaone
>>>>> M: BALATON Zoltan <balaton@eik.bme.hu>
>>>>> L: qemu-ppc@nongnu.org
>>>>> S: Maintained
>>>>> +F: docs/system/ppc/amigaone.rst
>>>>> F: hw/ppc/amigaone.c
>>>>> F: hw/pci-host/articia.c
>>>>> F: include/hw/pci-host/articia.h
>>>>> diff --git a/docs/system/ppc/amigaone.rst b/docs/system/ppc/amigaone.=
rst
>>>>> new file mode 100644
>>>>> index 0000000000..c3f11a7bb2
>>>>> --- /dev/null
>>>>> +++ b/docs/system/ppc/amigaone.rst
>>>>
>>>> Maybe call it amigang.rst so it can be a place for docs on other PPC A=
migaNG machines such as pegasos2 and sam460ex in the future to collect them=
 in one place.
>>>
>>> Having everything in one place seems like creating a lot of complexity =
if one were to elaborate on the various pros and cons for each machine: Ami=
gaOne needs a custom vgabios, the others do not.
>>
>> All of these need real mode VGA BIOS as the BIOS emulator in all three m=
achines choke on the gcc compiled QEMU VGA BIOS so this isn't uinque to ami=
gaone.
>>
>>> MorpOS can be run on the other machines but not on AmigaOne. Sometimes =
a bootloader is needed and sometimes not, the circumstances may vary.
>>
>> MorphOS does not support amigaone, boot loader is optional and alternati=
ve to using firmware.
>>
>> Other docs seem to combine similar machines like powermac and embedded a=
nd ppce500 in a single doc file so the convention seems to not have one fil=
e for each machine but it's not a big deal.
>>
>>> I suggest to have a separate doc on each machine.
>>
>> I could also rename it later if more docs is added for other machines.
>>
>>>>> @@ -0,0 +1,53 @@
>>>>> +Eyetech AmigaOne/Mai Logic Teron (``amigaone``)
>>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>> +
>>>>> +The ``amigaone`` model emulates an AmigaOne XE mainboard developed b=
y Eyetech. Use
>>>>> +the executable ``qemu-system-ppc`` to simulate a complete system.
>>>>
>>>> QEMU is not a simulator so even if that's repeating this should say em=
ulate. (Should this doc be formatted with 80 chars line too like sources?)
>>>
>>> I took heavy inspiration from the cupieboard machine. Feel free to chan=
ge.
>>
>> docs/system/arm/cubieboard.rst:
>> "The ``cubieboard`` model emulates the Cubietech Cubieboard,"
>> also says emulate not simulate.
>>
>>>>> +
>>>>> +Emulated devices
>>>>> +----------------
>>>>> +
>>>>> + *  PowerPC 7457 v1.2 CPU
>>>>> + *  Articia S north bridge
>>>>> + *  VT82C686B south bridge
>>>>> + *  PCI VGA compatible card
>>>>> +
>>>>> +
>>>>> +Preparation
>>>>> +-----------
>>>>> +
>>>>> +A firmware binary is necessary for the boot process and is available=
 at
>>>>> +https://www.hyperion-entertainment.com/index.php/downloads?view=3Dfi=
les&parent=3D28.
>>>>> +It needs to be extracted with the following command:
>>>>> +
>>>>> +.. code-block:: bash
>>>>> +
>>>>> +  $ tail -c 524288 updater.image > u-boot-amigaone.bin
>>>>> +
>>>>> +The firmware binary is unable to run QEMU=E2=80=98s standard vgabios=
 and
>>>>> +``VGABIOS-lgpl-latest.bin`` is needed instead. It can be downloaded =
from
>>>>> +http://www.nongnu.org/vgabios.
>>>>> +
>>>>> +
>>>>> +Running Linux
>>>>> +-------------
>>>>> +
>>>>> +There are some Linux images under the following link that work on th=
e
>>>>> +``amigaone`` machine:
>>>>> +https://sourceforge.net/projects/amigaone-linux/files/debian-install=
er/. To boot
>>>>> +the system run:
>>>>> +
>>>>> +.. code-block:: bash
>>>>> +
>>>>> +  $ qemu-system-ppc -M amigaone -bios u-boot-amigaone.bin \
>>>>> +                    -cdrom "A1 Linux Net Installer.iso" \
>>>>> +                    -device ati-vga,model=3Drv100,romfile=3DVGABIOS-=
lgpl-latest.bin
>>>>> +
>>>>> +From the firmware menu that appears select ``Boot sequence`` =E2=86=
=92
>>>>> +``Amiga Multiboot Options`` and set ``Boot device 1`` to
>>>>> +``Onboard VIA IDE CDROM``. Then hit escape until the main screen app=
ears again,
>>>>> +hit escape once more and from the exit menu that appears select eith=
er
>>>>> +``Save settings and exit`` or ``Use settings for this session only``=
=2E It may
>>>>> +take a long time loading the kernel into memory but eventually it bo=
ots and the
>>>>> +installer becomes visible.
>>>>> diff --git a/docs/system/target-ppc.rst b/docs/system/target-ppc.rst
>>>>> index 4f6eb93b17..c1daa463cf 100644
>>>>> --- a/docs/system/target-ppc.rst
>>>>> +++ b/docs/system/target-ppc.rst
>>>>> @@ -18,6 +18,7 @@ help``.
>>>>>    :maxdepth: 1
>>>>>
>>>>>    ppc/embedded
>>>>> +   ppc/amigaone
>>>>>    ppc/powermac
>>>>>    ppc/powernv
>>>>>    ppc/ppce500
>>>>> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
>>>>> index ddfa09457a..4f680a5bdd 100644
>>>>> --- a/hw/ppc/amigaone.c
>>>>> +++ b/hw/ppc/amigaone.c
>>>>> @@ -27,15 +27,6 @@
>>>>>
>>>>> #define BUS_FREQ_HZ 100000000
>>>>>
>>>>> -/*
>>>>> - * Firmware binary available at
>>>>> - * https://www.hyperion-entertainment.com/index.php/downloads?view=
=3Dfiles&parent=3D28
>>>>> - * then "tail -c 524288 updater.image >u-boot-amigaone.bin"
>>>>> - *
>>>>> - * BIOS emulator in firmware cannot run QEMU vgabios and hangs on it=
, use
>>>>> - * -device VGA,romfile=3DVGABIOS-lgpl-latest.bin
>>>>> - * from http://www.nongnu.org/vgabios/ instead.
>>>>> - */
>>>>
>>>> Maybe it's worth keeping the comment here in case somebody reads the s=
ource but not documentation.
>>>
>>> Maybe change the comment to point at the doc to avoid duplication?
>>
>> That could work too.
>>
>>>> Do you want to send a v2 or want me to take over and do it myself?
>>>
>>> Sure, feel free to take over!
>>
>> OK, I'll try to make a v2 then.
>
> Ping

I've started it but then did not have time to finish yet but not=20
forgotten, will do it eventually. I also want to add info on other=20
machines so we'll have this in one place.

Regards,
BALATON Zoltan
--1117279078-348480708-1704283235=:11743--

