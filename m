Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A48709D94
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 19:10:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q03cD-0000XM-PY; Fri, 19 May 2023 13:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q03cB-0000X4-OU; Fri, 19 May 2023 13:10:03 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q03c9-0006ZN-9o; Fri, 19 May 2023 13:10:03 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-50bcb4a81ceso6101159a12.2; 
 Fri, 19 May 2023 10:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684516199; x=1687108199;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ig1t41ohuO8I1RhKMFb/7UpJlOCqzKXsPmg9fkbjkwA=;
 b=lQLNW8rlb6t+y4AuXOtaNIcMVbITJNn0LiZqYgijEbvwqRua9rc9fftmWx6ypthA5H
 cU9Xm2duK4dltMYPdQHEgzuqKhsk/BWFtVqNTeW3k456A+IUD8dutIXRp9o7sXc+sFrd
 hPq9nSgxEQ5QTh+AXqoR6M9xIHK3E9D6Qd6FUVQKAPN8SW6f40iCEFiiR6q7foSsF39A
 MpLsIswid3zfEOqriTmcRROaNFobINNGsgkqKARwEWgvpBugMHt8n5Tcgp5ibN+IpPLQ
 50lFLGR6HC0oy2ynpsFngMbcyvaayGMjYAKmewiW3dGF6YOUq/0igGBmRSEQM5nSRmw9
 aKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684516199; x=1687108199;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ig1t41ohuO8I1RhKMFb/7UpJlOCqzKXsPmg9fkbjkwA=;
 b=YajziQinuysXD5EzI1JedmHfipgZXrZV270S8QCyHQOFygXZPcYarj4EfKXnREGkjm
 10OU4zSBi5FM+Fz59L4Zysd9OIsnZHa6duo4QQeTX1nKDLbjHPnY4zkAmPqmaAm8Gmc8
 rCGWXuKF9WAi4mysAFQwCINsjaj9sF6z/uTHGZwHHUrEooiS1wC7ym4bd+RZ/9W8+3gN
 ABnEFZPR0eByNNkbr5IoZg/Q3Rs+dPVM4XRdF+/sQMhzQ1WJK6uT5zF2IRs+txpMkiLu
 qAGtx5bBCfAZNPiz5zapDV1o7IL35MK7tMgOwJNR9ZLpDQkJnI4oUP0A4m63x5ETwzTg
 4qXQ==
X-Gm-Message-State: AC+VfDwn4xsOKK33nANwrhi8/Vi5WiOSTRGJSWCjsWmbWSWmFqjsB0D+
 E6FLroRSG1LldZLaRvvURG8=
X-Google-Smtp-Source: ACHHUZ6BSpZCZKvX4YZA6Mev+6M1DR7+CQkhGdZoF6UdA3zXzhiVODUaP6RySauWB8OVQhxQ5ed3nQ==
X-Received: by 2002:a17:906:b188:b0:96a:4ea0:a1e7 with SMTP id
 w8-20020a170906b18800b0096a4ea0a1e7mr2147404ejy.50.1684516198612; 
 Fri, 19 May 2023 10:09:58 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-089-014-126-098.89.14.pool.telefonica.de.
 [89.14.126.98]) by smtp.gmail.com with ESMTPSA id
 c7-20020a17090654c700b0096f4389714csm1928405ejp.55.2023.05.19.10.09.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 10:09:58 -0700 (PDT)
Date: Fri, 19 May 2023 17:09:50 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
CC: qemu-block@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, John Snow <jsnow@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH 10/13] hw/ide/piix: Reuse PCIIDEState::{cmd,data}_ops
In-Reply-To: <30298351-6e6e-d5cc-834c-9266976d1a93@ilande.co.uk>
References: <20230422150728.176512-1-shentey@gmail.com>
 <20230422150728.176512-11-shentey@gmail.com>
 <4ed18370-3a92-3ae5-912f-1f6dafab37d1@ilande.co.uk>
 <612DFA62-40DC-44D3-88A9-797FB4EC1F48@gmail.com>
 <CD1A2767-74AD-4285-ADF8-1757B8DD7953@gmail.com>
 <698457dc-ca0a-956d-f20d-c3b353fbf0c3@ilande.co.uk>
 <6D292D6F-D82B-4425-8A03-7A51AA7791B0@gmail.com>
 <3d9a88eb-e9f3-4335-2a00-34d249c17289@ilande.co.uk>
 <0E1C9281-7688-44FF-917B-0E4AB99C1EE1@gmail.com>
 <30298351-6e6e-d5cc-834c-9266976d1a93@ilande.co.uk>
Message-ID: <B3A29DEC-E386-43C0-B38A-F8B488CDDC51@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x535.google.com
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



Am 18=2E Mai 2023 14:53:26 UTC schrieb Mark Cave-Ayland <mark=2Ecave-aylan=
d@ilande=2Eco=2Euk>:
>On 13/05/2023 13:21, Bernhard Beschow wrote:
>
>> Am 3=2E Mai 2023 19:52:41 UTC schrieb Mark Cave-Ayland <mark=2Ecave-ayl=
and@ilande=2Eco=2Euk>:
>>> On 27/04/2023 19:15, Bernhard Beschow wrote:
>>>=20
>>>> Am 27=2E April 2023 10:52:17 UTC schrieb Mark Cave-Ayland <mark=2Ecav=
e-ayland@ilande=2Eco=2Euk>:
>>>>> On 26/04/2023 21:14, Bernhard Beschow wrote:
>>>>>=20
>>>>>> Am 26=2E April 2023 18:18:35 UTC schrieb Bernhard Beschow <shentey@=
gmail=2Ecom>:
>>>>>>>=20
>>>>>>>=20
>>>>>>> Am 26=2E April 2023 11:37:48 UTC schrieb Mark Cave-Ayland <mark=2E=
cave-ayland@ilande=2Eco=2Euk>:
>>>>>>>> On 22/04/2023 16:07, Bernhard Beschow wrote:
>>>>>>>>=20
>>>>>>>>> Now that PCIIDEState::{cmd,data}_ops are initialized in the base=
 class
>>>>>>>>> constructor there is an opportunity for PIIX to reuse these attr=
ibutes=2E This
>>>>>>>>> resolves usage of ide_init_ioport() which would fall back intern=
ally to using
>>>>>>>>> the isabus global due to NULL being passed as ISADevice by PIIX=
=2E
>>>>>>>>>=20
>>>>>>>>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>>>>>>>> ---
>>>>>>>>>      hw/ide/piix=2Ec | 30 +++++++++++++-----------------
>>>>>>>>>      1 file changed, 13 insertions(+), 17 deletions(-)
>>>>>>>>>=20
>>>>>>>>> diff --git a/hw/ide/piix=2Ec b/hw/ide/piix=2Ec
>>>>>>>>> index a3a15dc7db=2E=2E406a67fa0f 100644
>>>>>>>>> --- a/hw/ide/piix=2Ec
>>>>>>>>> +++ b/hw/ide/piix=2Ec
>>>>>>>>> @@ -104,34 +104,32 @@ static void piix_ide_reset(DeviceState *de=
v)
>>>>>>>>>          pci_set_byte(pci_conf + 0x20, 0x01);  /* BMIBA: 20-23h =
*/
>>>>>>>>>      }
>>>>>>>>>      -static bool pci_piix_init_bus(PCIIDEState *d, unsigned i, =
ISABus *isa_bus,
>>>>>>>>> -                              Error **errp)
>>>>>>>>> +static void pci_piix_init_bus(PCIIDEState *d, unsigned i, ISABu=
s *isa_bus)
>>>>>>>>>      {
>>>>>>>>>          static const struct {
>>>>>>>>>              int iobase;
>>>>>>>>>              int iobase2;
>>>>>>>>>              int isairq;
>>>>>>>>>          } port_info[] =3D {
>>>>>>>>> -        {0x1f0, 0x3f6, 14},
>>>>>>>>> -        {0x170, 0x376, 15},
>>>>>>>>> +        {0x1f0, 0x3f4, 14},
>>>>>>>>> +        {0x170, 0x374, 15},
>>>>>>>>>          };
>>>>>>>>> -    int ret;
>>>>>>>>> +    MemoryRegion *address_space_io =3D pci_address_space_io(PCI=
_DEVICE(d));
>>>>>>>>>            ide_bus_init(&d->bus[i], sizeof(d->bus[i]), DEVICE(d)=
, i, 2);
>>>>>>>>> -    ret =3D ide_init_ioport(&d->bus[i], NULL, port_info[i]=2Eio=
base,
>>>>>>>>> -                          port_info[i]=2Eiobase2);
>>>>>>>>> -    if (ret) {
>>>>>>>>> -        error_setg_errno(errp, -ret, "Failed to realize %s port=
 %u",
>>>>>>>>> -                         object_get_typename(OBJECT(d)), i);
>>>>>>>>> -        return false;
>>>>>>>>> -    }
>>>>>>>>> +    memory_region_add_subregion(address_space_io, port_info[i]=
=2Eiobase,
>>>>>>>>> +                                &d->data_ops[i]);
>>>>>>>>> +    /*
>>>>>>>>> +     * PIIX forwards the last byte of cmd_ops to ISA=2E Model t=
his using a low
>>>>>>>>> +     * prio so competing memory regions take precedence=2E
>>>>>>>>> +     */
>>>>>>>>> +    memory_region_add_subregion_overlap(address_space_io, port_=
info[i]=2Eiobase2,
>>>>>>>>> +                                        &d->cmd_ops[i], -1);
>>>>>>>>=20
>>>>>>>> Interesting=2E Is this behaviour documented somewhere and/or used=
 in one of your test images at all? If I'd have seen this myself, I probabl=
y thought that the addresses were a typo=2E=2E=2E
>>>>>>>=20
>>>>>>> I first  stumbled upon this and wondered why this code was working=
 with VIA_IDE (through my pc-via branch)=2E Then I found the correct offset=
s there which are confirmed in the piix datasheet, e=2Eg=2E: "Secondary Con=
trol Block Offset: 0374h"
>>>>>>=20
>>>>>> In case you were wondering about the forwarding of the last byte th=
e datasheet says: "Accesses to byte 3 of the Control Block are forwarded to=
 ISA where the floppy disk controller responds=2E"
>>>>>=20
>>>>> Ahhh okay okay I see what's happening here: the PIIX IDE is assuming=
 that the legacy ioport semantics are in operation here, which as you note =
above is where the FDC controller is also accessed via the above byte in th=
e IDE control block=2E This is also why you need to change the address abov=
e from 0x3f6/0x376 to 0x3f4/0x374 when trying to use the MemoryRegions used=
 for the PCI BARs since the PCI IDE controller specification requires a 4 b=
yte allocation for the Control Block - see sections 2=2E0 and 2=2E2=2E
>>>>=20
>>>> Yes, PIIX assuming that might be the case=2E Why does it contradict t=
he PCI IDE specification? PIIX seems to apply the apprppriate "workarounds"=
 here=2E
>>>=20
>>> Can you explain a bit more about where you see the contradiction? At f=
irst glance it looks okay to me=2E
>>>=20
>>>>> And that's fine, because the portio_lists used in ide_init_ioport() =
set up the legacy IDE ioports so that FDC accesses done in this way can suc=
ceed, and the PIIX IDE is hard-coded to legacy mode=2E So in fact PIIX IDE =
should keep using ide_init_ioport() rather than trying to re-use the BAR Me=
moryRegions so I think this patch should just be dropped=2E
>>>>=20
>>>> I was hoping to keep that patch=2E=2E=2E
>>>=20
>>> Perhaps a different way to think about it is that from QEMU's perspect=
ive a BAR is a MemoryRegion that can be dynamically assigned/updated and ca=
nnot overlap, whereas the portio_list implementation also handles unaligned=
 accesses and overlapping sparse accesses=2E Since the latter is the exact =
case here with the IDE/FDC then it seems the existing portio_list solution =
already does the "right thing" instead of having to manually emulate the ov=
erlapping dispatch=2E
>>=20
>> I've had another look into the "PCI IDE Controller Specification Revisi=
on 1=2E0" which says:
>
>Interesting: it looks as if we are getting different conclusions from the=
 same document=2E
>
>> "The Control Block registers consist of two bytes used for control/stat=
us of the IDE device=2E The second byte of this pair is read-only and has t=
he interesting quirk where the top bit of this byte is shared with the flop=
py controller when the IDE device is mapped at 'compatibility' locations=2E=
 It turns out that software controlling IDE devices (BIOS, drivers, etc=2E)=
 does not use this register at all=2E
>
>Just before this section the start of the paragraph reads "The ATA Standa=
rd defines two sets of registers known as Control Block Registers and Comma=
nd Block Registers=2E" which reads to me that the paragraph quoted above is=
 describing the original ATA Standard behaviour, i=2Ee=2E the expected beha=
viour for pre-PCI controllers or PCI IDE controllers in compatibility mode=
=2E
>
>> The exception for PCI IDE controllers to the ATA Standard is that only =
the first of the two bytes defined in the Control Block registers is implem=
ented=2E This byte provides Alternate Status on reads and Device Control on=
 writes=2E Accesses to the second byte of the Control Block registers (Driv=
e Address) should be ignored by the PCI IDE controller=2E"
>
>And this paragraph then leads onto the differences for PCI IDE controller=
s which are that the second (shared) byte in the Control Block is ignored, =
which again makes sense from a PCI perspective since PCI BARs cannot overla=
p=2E But that doesn't matter in PCI native mode because the BIOS/OS will ha=
ve moved the BAR to a suitable memory address that doesn't clash with the f=
loppy drive=2E
>
>> So in fact the real PIIX does adhere to this standard and there is no r=
eason to reject the idea behind this patch -- which is to make our PIIX dev=
ice model implement this standard=2E
>>=20
>> It's just that all our other PCI-IDE implementations need to implement =
this quirk as long as they implement the standard=2E And according to the L=
inux kernel they all do -- see its CONFIG_ATA_SFF=2E
>
>Another couple of hints that the registers in PCI IDE controllers in comp=
atibility mode aren't accessed through PCI BARs can also be found: i) the t=
able in section 2=2E1 for compatibility mode uses fixed addresses whilst th=
e table in section 2=2E2 references BAs and ii) section 2=2E4 suggests that=
 PCI controllers in compatibility mode always ignore the BARs=2E
>
>Now it could be that the description in the PIIX datasheet indicates that=
 the PCI IO address is hardcoded and then the second byte (re)dispatched to=
 the ISA bus, but then I would argue that this is an implementation detail:=
 from QEMU's perspective there is zero difference between this and the exis=
ting IDE portio_list, and as a bonus the existing compatibility behaviour i=
s completely unaffected by any PCI BARs=2E

Right, that was my idea: Trading one implementation detail in PIIX with an=
other to have a common "theory" accross all our TYPE_PCI_IDE devices which =
all implement the PCI IDE controller standard=2E At the same time quite a b=
it of redundant code could be removed=2E

We could of course extend this theory to consider compatibility and PCI na=
tive modes to have different implementations=2E That is, compatibility mode=
 would use portio_list semantics while PCI native woulde use the BARs seman=
tics=2E Then we'd have to make at least TYPE_VIA_IDE use portio_list since =
it is currently hardcoded to operate in compatibility mode=2E Same for cmd6=
46 if it can switch modes=2E And then there is also sil3112=2E=2E=2E

I guess I'll split this series and only ship the first four patches in v2=
=2E Meanwhile we can discuss here further on the topic of the PCI IDE contr=
oller specification which the rest of this series addresses=2E

>
>> Since this patch actually uncovered a small bug in the other device mod=
els I'd rather fix those, too=2E One way I could do this is to decrease the=
 size of the memory region or to map with lower priority=2E What is the pre=
ferred fix? Any other ideas?
>>=20
>> Note that this and the next patch resolve the last dependencies on the =
"isabus" global=2E So after this series we could apply some small patches p=
osted before and get rid of the global entirely=2E=2E=2E And have as many I=
SA and LPC buses as we want!
>
>This is the part I think we can do better with: both Phil and I have patc=
hes that remove the isabus reference from the IDE ioports e=2Eg=2E https://=
patchew=2Eorg/QEMU/20230302224058=2E43315-1-philmd@linaro=2Eorg/20230302224=
058=2E43315-9-philmd@linaro=2Eorg/ so dropping this patch shouldn't affect =
our ability to remove the isabus global=2E
>
>Do you have an example of a use-case you have for multiple ISA buses? I'm=
 fairly sure that this wouldn't work on x86 PC machines with a single PCI r=
oot bus for example=2E

The ICH0 (82801AA & 82801AB) datasheet depicts in the "system block diagra=
m" an LPC bus for the Super I/O devices and an optional PCI-ISA bridge conn=
ected to the PCI bus=2E I guess the use case is for connecting ISA cards wh=
ile the ICH made the switch to the more modern LPC bus=2E Of course one cou=
ld attach an ISA "card" to the LPC bus in QEMU since they look the same fro=
m software=2E I'd assume though that above two buses would be visible someh=
ow=2E

Other than that I don't see a real use case=2E It's just a property of a c=
lean software design to avoid imposing any artificial limits onto callers a=
nd instead give them maximum control=2E ISABus currently assumes that there=
 can only be one ISA bus in a QEMU process and above example seems like a c=
ounter example=2E Moreover, ISABus not being a singleton may make its testi=
ng more convenient and who knows, maybe it helps in moving towards heteroge=
nious architectures=2E

Best regards,
Bernhard

>
>
>ATB,
>
>Mark=2E
>

