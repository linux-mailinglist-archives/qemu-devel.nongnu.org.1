Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E431816AAC
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 11:13:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFAaz-0002ky-QZ; Mon, 18 Dec 2023 05:11:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFAau-0002kd-P1; Mon, 18 Dec 2023 05:11:29 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFAal-0003Mw-HT; Mon, 18 Dec 2023 05:11:28 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a2335397e64so143608166b.2; 
 Mon, 18 Dec 2023 02:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702894273; x=1703499073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l8KmqFL2sfzHfIJC2kAQ+Bpc3maynsC5ghmmdEIf67s=;
 b=b1jJ8h4JvQrrZC04Wdn5zIzsZ9qd9jWznzxpwaA9WhU1xMYmHR2NOh6cPdFZeJUZLS
 vEZfNVSUHsYAQ3SLZoI+cNo148luEapwkmOCQifjHyczaDLSGe6VzRDGgbmvcQe+yZUV
 AumaDJyARQi6eD608tHn6qZUF9JDXwv9JYPEWP9Mh21dHs2QN/4rDWJmi3agEgYhCURx
 I3z6JdcFub4whplJfoVAtBCw41NKfzRv0QqoNNthmbpBLlHDj/xN+NxJhIJB9CMkD8xJ
 Bkb86E/hQ93RHADd8INDbDueZjE+wqyF8KIAJ3VdYxNl3jq0hp5RRWo+WnkqpKhqf5ur
 /AyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702894273; x=1703499073;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l8KmqFL2sfzHfIJC2kAQ+Bpc3maynsC5ghmmdEIf67s=;
 b=Dti83snTJG5MIublFHsGWcFcVrfMzwJ3zldwP47+6NHjpuW9LwtGxyO/fqv5WLvu8C
 J661KlmzhnRlIIg3lGJlz9+1kq8tp1tFcfxuaeS0bqaH8e+uit1qoyJUVwti1R/tnt/3
 SD+2GhhAflL496WPjdbQ4pkh5KTryO6eWOHrlHN5vYRBuVbl2iWgMbreD6iN5UEKjuBI
 6hmVm6DDeKGFB0bD97PYUqsM6Awjk6JsncAzhpub8B+pA7bAr8KOKC0r0lvqGLgQ01ZV
 Sl2TA78y5VG3XgGzzpso0btn2OJhfrpZLez+vA9aykMUS52kmImYKT18MmKo0rm9zNKe
 QWJQ==
X-Gm-Message-State: AOJu0YwQFSzFGkFoo2U2vV+FmQAKyHf6IhG4RpmkEAfupihRCyxVtTnD
 2vZzPMpiTafNL31RZ4dUORs=
X-Google-Smtp-Source: AGHT+IHkEm4am2sWC15xgqbRF4GypoU86qsTs6p0UDqRukEBKGKIj7BvkotsbQ7mgtnHO/M8YV38ow==
X-Received: by 2002:a17:907:944b:b0:a23:52b7:c0c7 with SMTP id
 dl11-20020a170907944b00b00a2352b7c0c7mr996421ejc.132.1702894273289; 
 Mon, 18 Dec 2023 02:11:13 -0800 (PST)
Received: from [127.0.0.1] (dynamic-092-224-039-156.92.224.pool.telefonica.de.
 [92.224.39.156]) by smtp.gmail.com with ESMTPSA id
 va15-20020a17090711cf00b00a235a62516asm848727ejb.57.2023.12.18.02.11.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Dec 2023 02:11:12 -0800 (PST)
Date: Sun, 17 Dec 2023 23:47:42 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 David Hildenbrand <david@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, Juan Quintela <quintela@redhat.com>,
 =?ISO-8859-1?Q?Fr=E9d=E9ric_Barrat?= <fbarrat@linux.ibm.com>,
 qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_12/12=5D_hw/isa/vt82c686=3A_Imp?=
 =?US-ASCII?Q?lement_relocation_of_SuperI/O_functions?=
In-Reply-To: <9e1340f7-113e-1b92-568f-a2754293269c@eik.bme.hu>
References: <20231217144148.15511-1-shentey@gmail.com>
 <20231217144148.15511-13-shentey@gmail.com>
 <9e1340f7-113e-1b92-568f-a2754293269c@eik.bme.hu>
Message-ID: <818CF253-84EA-42DB-BA09-432547EE9D31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



Am 17=2E Dezember 2023 15:40:58 UTC schrieb BALATON Zoltan <balaton@eik=2E=
bme=2Ehu>:
>On Sun, 17 Dec 2023, Bernhard Beschow wrote:
>> The VIA south bridges are able to relocate and enable or disable their =
SuperI/O
>> functions=2E So far this is hardcoded such that all functions are alway=
s enabled
>> and are located at fixed addresses=2E
>>=20
>> Some PC BIOSes seem to probe for I/O occupancy before activating such a=
 function
>> and issue an error in case of a conflict=2E Since the functions are ena=
bled on
>> reset, conflicts are always detected=2E Prevent that by implementing re=
location of
>> the SuperI/O functions=2E
>>=20
>> Note that the reset I/O region of VT8231's serial port changes from
>> 0x2f8/enabled to 0x3f8/disabled=2E The ROM of the Pegasos II machine ca=
n handle it
>> since it enables and relocates the I/O region accordingly=2E
>
>"=2E=2E=2E but we need to do that when running without firmware which thi=
s patch does=2E" or something like that is missing here to complete the sen=
tence=2E

I'll mention this in the next iteration=2E

> I think this part changing pegasos2=2Ec could be split off in its own pa=
tch coming before this one=2E Poking those registers before they are implem=
ented is harmless (the ROM does that already) but would make two simpler pa=
tches instead of one doing two things=2E

Will do=2E I considered this but went with the combined approach for compa=
ctness=2E

>
>This is a welcome change but since vt82c686 uses isa-superio I wonder if =
it there could be a way to add functions to isa-superio=2Ec to set these ba=
se addresses and enable/disable deivces in runtime instead of poking the in=
ternals od superio in vt82c686=2Ec? That looks to me a more object oriented=
 approach=2E Or going further with that maybe the fdc and serial device obj=
ects should have methods to set their base that then either superio or vt82=
c686 could then use without peeking them or exposing the device sturctures=
=2E

Let's focus on this topic in the other thread=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan
>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>> hw/isa/vt82c686=2Ec | 140 ++++++++++++++++++++++++++++++++++++---------=
-
>> hw/ppc/pegasos2=2Ec |  15 +++++
>> 2 files changed, 124 insertions(+), 31 deletions(-)
>>=20
>> diff --git a/hw/isa/vt82c686=2Ec b/hw/isa/vt82c686=2Ec
>> index 9c2333a277=2E=2E8fbc016755 100644
>> --- a/hw/isa/vt82c686=2Ec
>> +++ b/hw/isa/vt82c686=2Ec
>> @@ -15,6 +15,9 @@
>>=20
>> #include "qemu/osdep=2Eh"
>> #include "hw/isa/vt82c686=2Eh"
>> +#include "hw/block/fdc-isa=2Eh"
>> +#include "hw/char/parallel-isa=2Eh"
>> +#include "hw/char/serial-isa=2Eh"
>> #include "hw/pci/pci=2Eh"
>> #include "hw/qdev-properties=2Eh"
>> #include "hw/ide/pci=2Eh"
>> @@ -343,6 +346,46 @@ static const TypeInfo via_superio_info =3D {
>>=20
>> #define TYPE_VT82C686B_SUPERIO "vt82c686b-superio"
>>=20
>> +static void vt82c686b_superio_update(ViaSuperIOState *s)
>> +{
>> +    FDCtrlISABus *fd =3D ISA_FDC(s->superio=2Efloppy);
>> +    ISASerialState *ss1 =3D ISA_SERIAL(s->superio=2Eserial[0]);
>> +    ISASerialState *ss2 =3D ISA_SERIAL(s->superio=2Eserial[1]);
>> +    ISAParallelState *ps =3D ISA_PARALLEL(s->superio=2Eparallel[0]);
>> +
>> +    portio_list_set_enabled(&ps->state=2Eportio_list, (s->regs[0xe2] &=
 0x3) !=3D 3);
>> +    memory_region_set_enabled(&ss1->state=2Eio, s->regs[0xe2] & BIT(2)=
);
>> +    memory_region_set_enabled(&ss2->state=2Eio, s->regs[0xe2] & BIT(3)=
);
>> +    portio_list_set_enabled(&fd->state=2Eportio_list, s->regs[0xe2] & =
BIT(4));
>> +
>> +    fd->iobase =3D (s->regs[0xe3] & 0xfc) << 2;
>> +    portio_list_set_address(&fd->state=2Eportio_list, fd->iobase);
>> +
>> +    ps->iobase =3D s->regs[0xe6] << 2;
>> +    portio_list_set_address(&ps->state=2Eportio_list, ps->iobase);
>> +
>> +    ss1->iobase =3D (s->regs[0xe7] & 0xfe) << 2;
>> +    memory_region_set_address(&ss1->state=2Eio, ss1->iobase);
>> +
>> +    ss2->iobase =3D (s->regs[0xe8] & 0xfe) << 2;
>> +    memory_region_set_address(&ss2->state=2Eio, ss2->iobase);
>> +}
>> +
>> +static int vmstate_vt82c686b_superio_post_load(void *opaque, int versi=
on_id)
>> +{
>> +    ViaSuperIOState *s =3D opaque;
>> +
>> +    vt82c686b_superio_update(s);
>> +
>> +    return 0;
>> +}
>> +
>> +static const VMStateDescription vmstate_vt82c686b_superio =3D {
>> +    =2Ename =3D "vt82c686b_superio",
>> +    =2Eversion_id =3D 1,
>> +    =2Epost_load =3D vmstate_vt82c686b_superio_post_load,
>> +};
>> +
>> static void vt82c686b_superio_cfg_write(void *opaque, hwaddr addr,
>>                                         uint64_t data, unsigned size)
>> {
>> @@ -368,7 +411,11 @@ static void vt82c686b_superio_cfg_write(void *opaq=
ue, hwaddr addr,
>>     case 0xfd =2E=2E=2E 0xff:
>>         /* ignore write to read only registers */
>>         return;
>> -    /* case 0xe6 =2E=2E=2E 0xe8: Should set base port of parallel and =
serial */
>> +    case 0xe2 =2E=2E=2E 0xe3:
>> +    case 0xe6 =2E=2E=2E 0xe8:
>> +        sc->regs[idx] =3D data;
>> +        vt82c686b_superio_update(sc);
>> +        return;
>>     default:
>>         qemu_log_mask(LOG_UNIMP,
>>                       "via_superio_cfg: unimplemented register 0x%x\n",=
 idx);
>> @@ -393,25 +440,24 @@ static void vt82c686b_superio_reset(DeviceState *=
dev)
>>=20
>>     memset(s->regs, 0, sizeof(s->regs));
>>     /* Device ID */
>> -    vt82c686b_superio_cfg_write(s, 0, 0xe0, 1);
>> -    vt82c686b_superio_cfg_write(s, 1, 0x3c, 1);
>> -    /* Function select - all disabled */
>> -    vt82c686b_superio_cfg_write(s, 0, 0xe2, 1);
>> -    vt82c686b_superio_cfg_write(s, 1, 0x03, 1);
>> +    s->regs[0xe0] =3D 0x3c;
>> +    /*
>> +     * Function select - only serial enabled
>> +     * Fuloong 2e's rescue-yl prints to the serial console w/o enablin=
g it=2E This
>> +     * suggests that the serial ports are enabled by default, so overr=
ide the
>> +     * datasheet=2E
>> +     */
>> +    s->regs[0xe2] =3D 0x0f;
>>     /* Floppy ctrl base addr 0x3f0-7 */
>> -    vt82c686b_superio_cfg_write(s, 0, 0xe3, 1);
>> -    vt82c686b_superio_cfg_write(s, 1, 0xfc, 1);
>> +    s->regs[0xe3] =3D 0xfc;
>>     /* Parallel port base addr 0x378-f */
>> -    vt82c686b_superio_cfg_write(s, 0, 0xe6, 1);
>> -    vt82c686b_superio_cfg_write(s, 1, 0xde, 1);
>> +    s->regs[0xe6] =3D 0xde;
>>     /* Serial port 1 base addr 0x3f8-f */
>> -    vt82c686b_superio_cfg_write(s, 0, 0xe7, 1);
>> -    vt82c686b_superio_cfg_write(s, 1, 0xfe, 1);
>> +    s->regs[0xe7] =3D 0xfe;
>>     /* Serial port 2 base addr 0x2f8-f */
>> -    vt82c686b_superio_cfg_write(s, 0, 0xe8, 1);
>> -    vt82c686b_superio_cfg_write(s, 1, 0xbe, 1);
>> +    s->regs[0xe8] =3D 0xbe;
>>=20
>> -    vt82c686b_superio_cfg_write(s, 0, 0, 1);
>> +    vt82c686b_superio_update(s);
>> }
>>=20
>> static void vt82c686b_superio_init(Object *obj)
>> @@ -429,6 +475,7 @@ static void vt82c686b_superio_class_init(ObjectClas=
s *klass, void *data)
>>     sc->parallel=2Ecount =3D 1;
>>     sc->ide=2Ecount =3D 0; /* emulated by via-ide */
>>     sc->floppy=2Ecount =3D 1;
>> +    dc->vmsd =3D &vmstate_vt82c686b_superio;
>> }
>>=20
>> static const TypeInfo vt82c686b_superio_info =3D {
>> @@ -443,6 +490,41 @@ static const TypeInfo vt82c686b_superio_info =3D {
>>=20
>> #define TYPE_VT8231_SUPERIO "vt8231-superio"
>>=20
>> +static void vt8231_superio_update(ViaSuperIOState *s)
>> +{
>> +    FDCtrlISABus *fd =3D ISA_FDC(s->superio=2Efloppy);
>> +    ISASerialState *ss =3D ISA_SERIAL(s->superio=2Eserial[0]);
>> +    ISAParallelState *ps =3D ISA_PARALLEL(s->superio=2Eparallel[0]);
>> +
>> +    portio_list_set_enabled(&ps->state=2Eportio_list, (s->regs[0xf2] &=
 0x3) !=3D 3);
>> +    memory_region_set_enabled(&ss->state=2Eio, s->regs[0xf2] & BIT(2))=
;
>> +    portio_list_set_enabled(&fd->state=2Eportio_list, s->regs[0xf2] & =
BIT(4));
>> +
>> +    ss->iobase =3D (s->regs[0xf4] & 0xfe) << 2;
>> +    memory_region_set_address(&ss->state=2Eio, ss->iobase);
>> +
>> +    ps->iobase =3D s->regs[0xf6] << 2;
>> +    portio_list_set_address(&ps->state=2Eportio_list, ps->iobase);
>> +
>> +    fd->iobase =3D (s->regs[0xf7] & 0xfc) << 2;
>> +    portio_list_set_address(&fd->state=2Eportio_list, fd->iobase);
>> +}
>> +
>> +static int vmstate_vt8231_superio_post_load(void *opaque, int version_=
id)
>> +{
>> +    ViaSuperIOState *s =3D opaque;
>> +
>> +    vt8231_superio_update(s);
>> +
>> +    return 0;
>> +}
>> +
>> +static const VMStateDescription vmstate_vt8231_superio =3D {
>> +    =2Ename =3D "vt8231_superio",
>> +    =2Eversion_id =3D 1,
>> +    =2Epost_load =3D vmstate_vt8231_superio_post_load,
>> +};
>> +
>> static void vt8231_superio_cfg_write(void *opaque, hwaddr addr,
>>                                      uint64_t data, unsigned size)
>> {
>> @@ -465,6 +547,12 @@ static void vt8231_superio_cfg_write(void *opaque,=
 hwaddr addr,
>>     case 0xfd:
>>         /* ignore write to read only registers */
>>         return;
>> +    case 0xf2:
>> +    case 0xf4:
>> +    case 0xf6 =2E=2E=2E 0xf7:
>> +        sc->regs[idx] =3D data;
>> +        vt8231_superio_update(sc);
>> +        return;
>>     default:
>>         qemu_log_mask(LOG_UNIMP,
>>                       "via_superio_cfg: unimplemented register 0x%x\n",=
 idx);
>> @@ -493,19 +581,15 @@ static void vt8231_superio_reset(DeviceState *dev=
)
>>     /* Device revision */
>>     s->regs[0xf1] =3D 0x01;
>>     /* Function select - all disabled */
>> -    vt8231_superio_cfg_write(s, 0, 0xf2, 1);
>> -    vt8231_superio_cfg_write(s, 1, 0x03, 1);
>> +    s->regs[0xf2] =3D 0x03;
>>     /* Serial port base addr */
>> -    vt8231_superio_cfg_write(s, 0, 0xf4, 1);
>> -    vt8231_superio_cfg_write(s, 1, 0xfe, 1);
>> +    s->regs[0xf4] =3D 0xfe;
>>     /* Parallel port base addr */
>> -    vt8231_superio_cfg_write(s, 0, 0xf6, 1);
>> -    vt8231_superio_cfg_write(s, 1, 0xde, 1);
>> +    s->regs[0xf6] =3D 0xde;
>>     /* Floppy ctrl base addr */
>> -    vt8231_superio_cfg_write(s, 0, 0xf7, 1);
>> -    vt8231_superio_cfg_write(s, 1, 0xfc, 1);
>> +    s->regs[0xf7] =3D 0xfc;
>>=20
>> -    vt8231_superio_cfg_write(s, 0, 0, 1);
>> +    vt8231_superio_update(s);
>> }
>>=20
>> static void vt8231_superio_init(Object *obj)
>> @@ -513,12 +597,6 @@ static void vt8231_superio_init(Object *obj)
>>     VIA_SUPERIO(obj)->io_ops =3D &vt8231_superio_cfg_ops;
>> }
>>=20
>> -static uint16_t vt8231_superio_serial_iobase(ISASuperIODevice *sio,
>> -                                             uint8_t index)
>> -{
>> -        return 0x2f8; /* FIXME: This should be settable via registers =
f2-f4 */
>> -}
>> -
>> static void vt8231_superio_class_init(ObjectClass *klass, void *data)
>> {
>>     DeviceClass *dc =3D DEVICE_CLASS(klass);
>> @@ -526,10 +604,10 @@ static void vt8231_superio_class_init(ObjectClass=
 *klass, void *data)
>>=20
>>     dc->reset =3D vt8231_superio_reset;
>>     sc->serial=2Ecount =3D 1;
>> -    sc->serial=2Eget_iobase =3D vt8231_superio_serial_iobase;
>>     sc->parallel=2Ecount =3D 1;
>>     sc->ide=2Ecount =3D 0; /* emulated by via-ide */
>>     sc->floppy=2Ecount =3D 1;
>> +    dc->vmsd =3D &vmstate_vt8231_superio;
>> }
>>=20
>> static const TypeInfo vt8231_superio_info =3D {
>> diff --git a/hw/ppc/pegasos2=2Ec b/hw/ppc/pegasos2=2Ec
>> index 3203a4a728=2E=2E0a40ebd542 100644
>> --- a/hw/ppc/pegasos2=2Ec
>> +++ b/hw/ppc/pegasos2=2Ec
>> @@ -285,6 +285,15 @@ static void pegasos2_pci_config_write(Pegasos2Mach=
ineState *pm, int bus,
>>     pegasos2_mv_reg_write(pm, pcicfg + 4, len, val);
>> }
>>=20
>> +static void pegasos2_superio_write(Pegasos2MachineState *pm, uint32_t =
addr,
>> +                                   uint32_t val)
>> +{
>> +    AddressSpace *as =3D CPU(pm->cpu)->as;
>> +
>> +    stb_phys(as, PCI1_IO_BASE + 0x3f0, addr);
>> +    stb_phys(as, PCI1_IO_BASE + 0x3f1, val);
>> +}
>> +
>> static void pegasos2_machine_reset(MachineState *machine, ShutdownCause=
 reason)
>> {
>>     Pegasos2MachineState *pm =3D PEGASOS2_MACHINE(machine);
>> @@ -310,6 +319,12 @@ static void pegasos2_machine_reset(MachineState *m=
achine, ShutdownCause reason)
>>=20
>>     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
>>                               PCI_INTERRUPT_LINE, 2, 0x9);
>> +    pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
>> +                              0x50, 1, 0x6);
>> +    pegasos2_superio_write(pm, 0xf4, 0xbe);
>> +    pegasos2_superio_write(pm, 0xf6, 0xef);
>> +    pegasos2_superio_write(pm, 0xf7, 0xfc);
>> +    pegasos2_superio_write(pm, 0xf2, 0x14);
>>     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
>>                               0x50, 1, 0x2);
>>     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
>>=20

