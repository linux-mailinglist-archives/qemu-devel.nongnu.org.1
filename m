Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3F68261A5
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 22:11:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMDwX-0006BQ-4o; Sat, 06 Jan 2024 16:10:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rMDwQ-0006B4-HU; Sat, 06 Jan 2024 16:10:50 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rMDwO-0001tD-GK; Sat, 06 Jan 2024 16:10:50 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a28ee72913aso291007266b.1; 
 Sat, 06 Jan 2024 13:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704575446; x=1705180246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QyRr6ml7GtbHod1ZFoeOmfHxKgbSywc9LuMRRz/T0Tk=;
 b=I2Wy5mgL08vn866NslGfkDEgQkoMk6+SgjrjYQguMNoNWIIcaIcnDIdLQcL2nXwPSs
 8VS1diDZ1PzWyZM9S2oPdpFah0Shlf8x+iVL849SVpNoCHJFqPMj8NzpO4eCRnr17Dtd
 FTK6p3yjN6RxHuOonhP3ZmM7hhXyWpnTIglpEQmEy4CSMTuBAPBw3rFbvEdWJBUQSZ6Y
 9FQ8C+fArdcqNlIRCwH34DOCl+8BV923UxmNg4B86U95BAr+tkjObr/hvRr74QXpGUwr
 6DksZaafBj8pqz9QJQrL9ZltGfMJwlO+MgAI6GEcjo345SH4zeRH0JJEvKqrz5Yo8MGx
 qO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704575446; x=1705180246;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QyRr6ml7GtbHod1ZFoeOmfHxKgbSywc9LuMRRz/T0Tk=;
 b=IaFHuttoS4ULfOEdDRbR5clyBYytTEAPuOllXex0BL60p2q5T7ybv6+/8C0+2NibxL
 a79j5QIZTUYbDlfURsVnmBQ2vlrQojWnqldpksBdoheQt5Ijij4PCNV3zY05093ITGVM
 0ecxwu+MJi/+fK6/US2HPCS8YxdwN+dFrFeaxNZ7nxaq4UXam1NmgmUyEZr6xhNGd8we
 J3Hm+9CTI1i6Pd+xVW/c5gwceI81T5zy3sCZE6XvgiAHLmquCz1Thd2dylzcb6T1X5Kw
 gsdM/q2NXtIMX/xw2yDXmhn34E/2loH9VfhZuhijDhuiqK4AqDbZHoNPgdZ9fkDEutQM
 0+5w==
X-Gm-Message-State: AOJu0YwGHUNyPK6xCnUGIaKkr7xyT4uCa1fa7S4zSr/ZSzRJEBZaR9ol
 sgVH7BM/Z2RJOb531e5uZyY=
X-Google-Smtp-Source: AGHT+IE5VF2k//EzX3x04DdpuMgbEY7t/PgD3wETr3opeIQ6yf8YjTOklEXd3Mk+J7395MhCwrnKnA==
X-Received: by 2002:a17:906:b790:b0:a25:1acc:8a48 with SMTP id
 dt16-20020a170906b79000b00a251acc8a48mr1359418ejb.56.1704575446001; 
 Sat, 06 Jan 2024 13:10:46 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-011-174-094.77.11.pool.telefonica.de.
 [77.11.174.94]) by smtp.gmail.com with ESMTPSA id
 v14-20020a1709060b4e00b00a27ac0895ecsm2308209ejg.9.2024.01.06.13.10.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Jan 2024 13:10:45 -0800 (PST)
Date: Sat, 06 Jan 2024 21:10:33 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_12/12=5D_hw/isa/vt82c686=3A_Implemen?=
 =?US-ASCII?Q?t_relocation_and_toggling_of_SuperI/O_functions?=
In-Reply-To: <4508fb1e-0e25-2654-6dd6-f4a35b71c880@eik.bme.hu>
References: <20231218185114.119736-1-shentey@gmail.com>
 <20231218185114.119736-13-shentey@gmail.com>
 <9c472e25-506f-fbd5-6d72-00be078bb15c@eik.bme.hu>
 <B0C3E617-569E-4DD2-900A-5ACF093C3B63@gmail.com>
 <acf63b63-df0d-1223-1022-292a396d717e@eik.bme.hu>
 <4E10FA4B-2659-4344-BA5A-6FD4BBC74AD3@gmail.com>
 <4508fb1e-0e25-2654-6dd6-f4a35b71c880@eik.bme.hu>
Message-ID: <73EFB4C0-8E5B-44C0-B45E-2B10C1F79088@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 3=2E Januar 2024 12:26:07 UTC schrieb BALATON Zoltan <balaton@eik=2Ebme=
=2Ehu>:
>On Tue, 2 Jan 2024, Bernhard Beschow wrote:
>> Am 24=2E Dezember 2023 00:51:53 UTC schrieb BALATON Zoltan <balaton@eik=
=2Ebme=2Ehu>:
>>> On Tue, 19 Dec 2023, Bernhard Beschow wrote:
>>>> Am 19=2E Dezember 2023 00:26:15 UTC schrieb BALATON Zoltan <balaton@e=
ik=2Ebme=2Ehu>:
>>>>> On Mon, 18 Dec 2023, Bernhard Beschow wrote:
>>>>>> The VIA south bridges are able to relocate and toggle (enable or di=
sable) their
>>>>>> SuperI/O functions=2E So far this is hardcoded such that all functi=
ons are always
>>>>>> enabled and are located at fixed addresses=2E
>>>>>>=20
>>>>>> Some PC BIOSes seem to probe for I/O occupancy before activating su=
ch a function
>>>>>> and issue an error in case of a conflict=2E Since the functions are=
 enabled on
>>>>>> reset, conflicts are always detected=2E Prevent that by implementin=
g relocation
>>>>>> and toggling of the SuperI/O functions=2E
>>>>>>=20
>>>>>> Note that all SuperI/O functions are now deactivated upon reset (ex=
cept for
>>>>>> VT82C686B's serial ports where Fuloong 2e's rescue-yl seems to expe=
ct them to be
>>>>>> enabled by default)=2E Rely on firmware -- or in case of pegasos2 o=
n board code if
>>>>>> no -bios is given -- to configure the functions accordingly=2E
>>>>>=20
>>>>> Pegasos2 emulates firmware when no -bios is given, this was explaine=
d in previos commit so maybe not needed to be explained it here again so yo=
u could drop the comment between -- -- but I don't mind=2E
>>>>>=20
>>>>>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>>>>> ---
>>>>>> hw/isa/vt82c686=2Ec | 121 ++++++++++++++++++++++++++++++++++-------=
-----
>>>>>> 1 file changed, 90 insertions(+), 31 deletions(-)
>>>>>>=20
>>>>>> diff --git a/hw/isa/vt82c686=2Ec b/hw/isa/vt82c686=2Ec
>>>>>> index 9c2333a277=2E=2Ebe202d23cf 100644
>>>>>> --- a/hw/isa/vt82c686=2Ec
>>>>>> +++ b/hw/isa/vt82c686=2Ec
>>>>>> @@ -15,6 +15,9 @@
>>>>>>=20
>>>>>> #include "qemu/osdep=2Eh"
>>>>>> #include "hw/isa/vt82c686=2Eh"
>>>>>> +#include "hw/block/fdc=2Eh"
>>>>>> +#include "hw/char/parallel-isa=2Eh"
>>>>>> +#include "hw/char/serial=2Eh"
>>>>>> #include "hw/pci/pci=2Eh"
>>>>>> #include "hw/qdev-properties=2Eh"
>>>>>> #include "hw/ide/pci=2Eh"
>>>>>> @@ -343,6 +346,35 @@ static const TypeInfo via_superio_info =3D {
>>>>>>=20
>>>>>> #define TYPE_VT82C686B_SUPERIO "vt82c686b-superio"
>>>>>>=20
>>>>>> +static void vt82c686b_superio_update(ViaSuperIOState *s)
>>>>>> +{
>>>>>> +    isa_parallel_set_enabled(s->superio=2Eparallel[0],
>>>>>> +                             (s->regs[0xe2] & 0x3) !=3D 3);
>>>>>> +    isa_serial_set_enabled(s->superio=2Eserial[0], s->regs[0xe2] &=
 BIT(2));
>>>>>> +    isa_serial_set_enabled(s->superio=2Eserial[1], s->regs[0xe2] &=
 BIT(3));
>>>>>> +    isa_fdc_set_enabled(s->superio=2Efloppy, s->regs[0xe2] & BIT(4=
));
>>>>>> +
>>>>>> +    isa_fdc_set_iobase(s->superio=2Efloppy, (s->regs[0xe3] & 0xfc)=
 << 2);
>>>>>> +    isa_parallel_set_iobase(s->superio=2Eparallel[0], s->regs[0xe6=
] << 2);
>>>>>> +    isa_serial_set_iobase(s->superio=2Eserial[0], (s->regs[0xe7] &=
 0xfe) << 2);
>>>>>> +    isa_serial_set_iobase(s->superio=2Eserial[1], (s->regs[0xe8] &=
 0xfe) << 2);
>>>>>> +}
>>>>>=20
>>>>> I wonder if some code duplication could be saved by adding a shared =
via_superio_update() for this further up in the abstract via-superio class =
instead of this method and vt8231_superio_update() below=2E This common met=
hod in abstract class would need to handle the differences which seem to be=
 reg addresses offset by 0x10 and VT8231 having only 1 serial port=2E These=
 could either be handled by adding function parameters or fields to ViaSupe=
rIOState for this that the subclasses can set and the method check=2E (Such=
 as reg base=3D0xe2 for vt82c686 and 0xf2 for vt8231 and num_serial or simi=
lar for how many ports are there then can have a for loop for those that wo=
uld only run once for vt8231)=2E
>>>>=20
>>>> Only the enable bits and the parallel port base address line up, the =
serial port(s) and the floppy would need special treatment=2E Not worth it =
IMO=2E
>>>=20
>>> Missed this part in previous reply=2E The serial ports would be taken =
care of by a loop for number of ports so only the floppy needs an if which =
could also use the number of serial ports for lack of better way to disting=
uish these cips easily=2E Number of ports are in the superio class which yo=
u could get with ISA_SUPERIO_GET_CLASS (see via_superio_realize) then seria=
l=2Ecount would be 2 for 686b and 1 for 8231=2E
>>=20
>> I'm not very convinced about telling the device models apart by their n=
umber of sub devices=2E So let's omit this part for now=2E
>>=20
>>>=20
>>> But now I think another way may be better that is to drop the superio_=
update function as this updates all functions on writing any register unnec=
essarily and put the lines from it in the vt*_superio_cfg_write() functions=
 under the separate cases=2E This was the original intent, that's why the r=
eset function goes through that write function so it can enable/disable fun=
ctions=2E That way you could apply mask on write so via_superio_cfg_read() =
would return 0 bits as 0 (although the data sheet is not clear about what r=
eal chip does, just says these must be 0 not that it's enforced but if we e=
nforce that it's probably better to return the effective value on read as w=
ell)=2E Then when state saving is added in separate patch you can have a si=
milar function as vt82c686b_superio_reset() (or rename that to update and m=
ake it use regs[xx] instead of constant values and call that from reset aft=
er setting regs values like you did here=2E But that needs more thought as =
the vmstate added by this patch is incomplete and would not work so you cou=
ld just drop it for now and add it later with also adding other necessary s=
tate as well=2E The idea was to implement the chip first then add state sav=
ing so we don't need to bother with breaking it until we have a good enough=
 implementation=2E So far the state saving there is just left over from the=
 old model which never worked and only left there for reminder but only wan=
ted to fix once the model is complete enough=2E
>>=20
>> Indeed, the patch obviously does too much if it misses details in vmsta=
te=2E Let's omit vmstate handling for now and go with your suggestion=2E
>>=20
>> Any other comments from your side before the next iteration?
>
>Nothing else from me unless Philippe has something to add=2E You can keep=
 a common function in the abstract via superclass for handling the enable b=
its in the function select register to reduce code duplication as those mat=
ch and handle the address setting separately=2E

I've just sent v4=2E

Best regards,
Bernhard

>
>>> So I think for now you could drop vmstate stuff and distribute the sup=
erio_update lines in the superio_cfg_write functions so each reg only contr=
ols the function it should control=2E Then when vmstate saving is added lat=
er it could reuse superio_reset as an update function adding a new reset fu=
nc setting reg values and calling the old reset/new update function=2E Does=
 that make sense?
>>=20
>> What I don't like about the vt*_superio_cfg_write() being called during=
 reset is the trace logs they produce=2E They are hard to tell apart from g=
uests poking these registers, especially during reboot=2E So I wonder if th=
is could be addressed when implementing vmstate handling as you suggest=2E =
Not too big of a deal, though=2E
>
>An easy way around that is to start qemu with -S then these setup logs co=
me before qemu stops then logs from guest actions will be printed after con=
tinue|c in monitor=2E
>
>Regards,
>BALATON Zoltan

