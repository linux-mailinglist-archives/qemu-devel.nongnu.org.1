Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2DE82245D
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 23:02:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKmpC-0001sV-5e; Tue, 02 Jan 2024 17:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rKmp4-0001qP-B5; Tue, 02 Jan 2024 17:01:19 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rKmp1-0005MZ-M6; Tue, 02 Jan 2024 17:01:17 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a28005f9b9cso183172566b.3; 
 Tue, 02 Jan 2024 14:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704232873; x=1704837673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RybfX6cFxOoWNhvf1lUHDW1yP5iQ4MUUyEXqzhB2lXs=;
 b=Q0jLIm77KnU7HegqFlBOLFsEj1P4m2V5mHMzrUiZX/C4p88NsUZAakQA75zeQhZAvG
 cN8cnHWyVjAdBbV0Ot5gU6SQzgb8NfZMKmGndwqR8TvG8u8B32PvGgyXas5RLkacRxU1
 V6xmOpxWzS0AKJAPiYOgCoAefSuNGlydCpTzADWWZaLOiHVcMONN5AlNJH+YdTFE7QRG
 w5Aza01ucRnjkdOr8np5vn7ZDxCqQvOmrC46tNIbYhwe7u5cMbsqE9xKvSyleIkX090M
 i7B8pJogOIH8Cml9GlA7poJwjr7kY358jOdoL7JXDuV5oyuLqWlNDOrL2m/4HipOZ9s4
 nU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704232873; x=1704837673;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RybfX6cFxOoWNhvf1lUHDW1yP5iQ4MUUyEXqzhB2lXs=;
 b=oLly/reftdpT7tV4/m5qkFaW8WxmWpZTWpd8WWg65+grJZAzuxbqKKD/SqkFRVAQ0J
 0ZXKYOINXJ8s1jQeg0ChHvQsquFKw2QLhDzz3Evw81pdDK4Xj9gn/JxsuMJKoMbT+cu3
 1PLy6bQkcqsNzBN3g/FNCri2EpagSRw8ikm+l4JbNPyS45MempiUU6GCFWXWAaPufK+k
 Yhs7OMMblaSZuTcX7tdSmaRiMkEH98vOc9wSwTF2Vkq3w90IXFGvi2UK+U+RjUX63/D9
 z0V4/KcTExnV8N0hS9PysTDvdqqotmU+Nk+vLJiNQP9/cOzu/KqxhrC0SHN3m+cUXJHN
 tT+Q==
X-Gm-Message-State: AOJu0YynE1F9XLcYPnTQHiPZrn5riu6y0qKiRQUiC4G+4wrhxAi/E6pe
 4tq7k0I83vbxePbORPRwq7MHZnb+NDg=
X-Google-Smtp-Source: AGHT+IG7XjxcSAiDcUILkhVEEuQgOt/sQm42Ri2z3dmQd8VXKXEpw5ZDwOFnX/9HTFFqYhZAhdJpzg==
X-Received: by 2002:a17:907:970e:b0:a27:710d:99ed with SMTP id
 jg14-20020a170907970e00b00a27710d99edmr5024938ejc.24.1704232872882; 
 Tue, 02 Jan 2024 14:01:12 -0800 (PST)
Received: from [127.0.0.1] (dynamic-089-014-091-072.89.14.pool.telefonica.de.
 [89.14.91.72]) by smtp.gmail.com with ESMTPSA id
 cl2-20020a170906c4c200b00a19afc16d23sm12003262ejb.104.2024.01.02.14.01.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 14:01:12 -0800 (PST)
Date: Tue, 02 Jan 2024 22:01:07 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_12/12=5D_hw/isa/vt82c686=3A_Implemen?=
 =?US-ASCII?Q?t_relocation_and_toggling_of_SuperI/O_functions?=
In-Reply-To: <acf63b63-df0d-1223-1022-292a396d717e@eik.bme.hu>
References: <20231218185114.119736-1-shentey@gmail.com>
 <20231218185114.119736-13-shentey@gmail.com>
 <9c472e25-506f-fbd5-6d72-00be078bb15c@eik.bme.hu>
 <B0C3E617-569E-4DD2-900A-5ACF093C3B63@gmail.com>
 <acf63b63-df0d-1223-1022-292a396d717e@eik.bme.hu>
Message-ID: <4E10FA4B-2659-4344-BA5A-6FD4BBC74AD3@gmail.com>
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



Am 24=2E Dezember 2023 00:51:53 UTC schrieb BALATON Zoltan <balaton@eik=2E=
bme=2Ehu>:
>On Tue, 19 Dec 2023, Bernhard Beschow wrote:
>> Am 19=2E Dezember 2023 00:26:15 UTC schrieb BALATON Zoltan <balaton@eik=
=2Ebme=2Ehu>:
>>> On Mon, 18 Dec 2023, Bernhard Beschow wrote:
>>>> The VIA south bridges are able to relocate and toggle (enable or disa=
ble) their
>>>> SuperI/O functions=2E So far this is hardcoded such that all function=
s are always
>>>> enabled and are located at fixed addresses=2E
>>>>=20
>>>> Some PC BIOSes seem to probe for I/O occupancy before activating such=
 a function
>>>> and issue an error in case of a conflict=2E Since the functions are e=
nabled on
>>>> reset, conflicts are always detected=2E Prevent that by implementing =
relocation
>>>> and toggling of the SuperI/O functions=2E
>>>>=20
>>>> Note that all SuperI/O functions are now deactivated upon reset (exce=
pt for
>>>> VT82C686B's serial ports where Fuloong 2e's rescue-yl seems to expect=
 them to be
>>>> enabled by default)=2E Rely on firmware -- or in case of pegasos2 on =
board code if
>>>> no -bios is given -- to configure the functions accordingly=2E
>>>=20
>>> Pegasos2 emulates firmware when no -bios is given, this was explained =
in previos commit so maybe not needed to be explained it here again so you =
could drop the comment between -- -- but I don't mind=2E
>>>=20
>>>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>>> ---
>>>> hw/isa/vt82c686=2Ec | 121 ++++++++++++++++++++++++++++++++++---------=
---
>>>> 1 file changed, 90 insertions(+), 31 deletions(-)
>>>>=20
>>>> diff --git a/hw/isa/vt82c686=2Ec b/hw/isa/vt82c686=2Ec
>>>> index 9c2333a277=2E=2Ebe202d23cf 100644
>>>> --- a/hw/isa/vt82c686=2Ec
>>>> +++ b/hw/isa/vt82c686=2Ec
>>>> @@ -15,6 +15,9 @@
>>>>=20
>>>> #include "qemu/osdep=2Eh"
>>>> #include "hw/isa/vt82c686=2Eh"
>>>> +#include "hw/block/fdc=2Eh"
>>>> +#include "hw/char/parallel-isa=2Eh"
>>>> +#include "hw/char/serial=2Eh"
>>>> #include "hw/pci/pci=2Eh"
>>>> #include "hw/qdev-properties=2Eh"
>>>> #include "hw/ide/pci=2Eh"
>>>> @@ -343,6 +346,35 @@ static const TypeInfo via_superio_info =3D {
>>>>=20
>>>> #define TYPE_VT82C686B_SUPERIO "vt82c686b-superio"
>>>>=20
>>>> +static void vt82c686b_superio_update(ViaSuperIOState *s)
>>>> +{
>>>> +    isa_parallel_set_enabled(s->superio=2Eparallel[0],
>>>> +                             (s->regs[0xe2] & 0x3) !=3D 3);
>>>> +    isa_serial_set_enabled(s->superio=2Eserial[0], s->regs[0xe2] & B=
IT(2));
>>>> +    isa_serial_set_enabled(s->superio=2Eserial[1], s->regs[0xe2] & B=
IT(3));
>>>> +    isa_fdc_set_enabled(s->superio=2Efloppy, s->regs[0xe2] & BIT(4))=
;
>>>> +
>>>> +    isa_fdc_set_iobase(s->superio=2Efloppy, (s->regs[0xe3] & 0xfc) <=
< 2);
>>>> +    isa_parallel_set_iobase(s->superio=2Eparallel[0], s->regs[0xe6] =
<< 2);
>>>> +    isa_serial_set_iobase(s->superio=2Eserial[0], (s->regs[0xe7] & 0=
xfe) << 2);
>>>> +    isa_serial_set_iobase(s->superio=2Eserial[1], (s->regs[0xe8] & 0=
xfe) << 2);
>>>> +}
>>>=20
>>> I wonder if some code duplication could be saved by adding a shared vi=
a_superio_update() for this further up in the abstract via-superio class in=
stead of this method and vt8231_superio_update() below=2E This common metho=
d in abstract class would need to handle the differences which seem to be r=
eg addresses offset by 0x10 and VT8231 having only 1 serial port=2E These c=
ould either be handled by adding function parameters or fields to ViaSuperI=
OState for this that the subclasses can set and the method check=2E (Such a=
s reg base=3D0xe2 for vt82c686 and 0xf2 for vt8231 and num_serial or simila=
r for how many ports are there then can have a for loop for those that woul=
d only run once for vt8231)=2E
>>=20
>> Only the enable bits and the parallel port base address line up, the se=
rial port(s) and the floppy would need special treatment=2E Not worth it IM=
O=2E
>
>Missed this part in previous reply=2E The serial ports would be taken car=
e of by a loop for number of ports so only the floppy needs an if which cou=
ld also use the number of serial ports for lack of better way to distinguis=
h these cips easily=2E Number of ports are in the superio class which you c=
ould get with ISA_SUPERIO_GET_CLASS (see via_superio_realize) then serial=
=2Ecount would be 2 for 686b and 1 for 8231=2E

I'm not very convinced about telling the device models apart by their numb=
er of sub devices=2E So let's omit this part for now=2E

>
>But now I think another way may be better that is to drop the superio_upd=
ate function as this updates all functions on writing any register unnecess=
arily and put the lines from it in the vt*_superio_cfg_write() functions un=
der the separate cases=2E This was the original intent, that's why the rese=
t function goes through that write function so it can enable/disable functi=
ons=2E That way you could apply mask on write so via_superio_cfg_read() wou=
ld return 0 bits as 0 (although the data sheet is not clear about what real=
 chip does, just says these must be 0 not that it's enforced but if we enfo=
rce that it's probably better to return the effective value on read as well=
)=2E Then when state saving is added in separate patch you can have a simil=
ar function as vt82c686b_superio_reset() (or rename that to update and make=
 it use regs[xx] instead of constant values and call that from reset after =
setting regs values like you did here=2E But that needs more thought as the=
 vmstate added by this patch is incomplete and would not work so you could =
just drop it for now and add it later with also adding other necessary stat=
e as well=2E The idea was to implement the chip first then add state saving=
 so we don't need to bother with breaking it until we have a good enough im=
plementation=2E So far the state saving there is just left over from the ol=
d model which never worked and only left there for reminder but only wanted=
 to fix once the model is complete enough=2E

Indeed, the patch obviously does too much if it misses details in vmstate=
=2E Let's omit vmstate handling for now and go with your suggestion=2E

Any other comments from your side before the next iteration?

>
>So I think for now you could drop vmstate stuff and distribute the superi=
o_update lines in the superio_cfg_write functions so each reg only controls=
 the function it should control=2E Then when vmstate saving is added later =
it could reuse superio_reset as an update function adding a new reset func =
setting reg values and calling the old reset/new update function=2E Does th=
at make sense?

What I don't like about the vt*_superio_cfg_write() being called during re=
set is the trace logs they produce=2E They are hard to tell apart from gues=
ts poking these registers, especially during reboot=2E So I wonder if this =
could be addressed when implementing vmstate handling as you suggest=2E Not=
 too big of a deal, though=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan

