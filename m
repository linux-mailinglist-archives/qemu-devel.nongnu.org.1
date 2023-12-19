Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2F58190CC
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:33:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfou-0007Eu-VJ; Tue, 19 Dec 2023 14:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFfoW-0007EI-8A; Tue, 19 Dec 2023 14:31:41 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFfoR-0004vq-Ii; Tue, 19 Dec 2023 14:31:34 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50e281b149aso4371329e87.1; 
 Tue, 19 Dec 2023 11:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703014288; x=1703619088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6/dxJbnCxnSsKfXaYO6K2aOYiVcs0Z9lK2V75CsbACw=;
 b=RSrHJVCDAwQuaDEYxz0sixLBD57z226qTzYFGLaYh6CTbWoXsxQDMZr8TUh/SzVVmR
 2kJxYziTeSXSjPqwx8NcBYIdnGIcjAYIKdaoCtCDzQ44zRbZ6KosEBQsq8SYKU6wQEbS
 SmB5Jkl/gwH4HDIcfjcVUKgo9hN5WNVWF4EaR5r+CIbavdB677EIk5p61GqkuLr/nuYG
 C2SAgwVRwv9C3v17SklEGTJ9A53FA6+ll5jenb8GhE60ldF6ApxV0/wJBVvMZgYpKEZP
 6+q/sAFtJ4Lkj8FJvvL5iA2beOiovlr0dUWZjEOmG6OFuzCh9xCDlEiyWx/zQmrGg7WM
 fWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703014288; x=1703619088;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6/dxJbnCxnSsKfXaYO6K2aOYiVcs0Z9lK2V75CsbACw=;
 b=gVcOsykepbsLLyeaJGXPqtbauwDYsGKLYPGRj164Iz0RJp4mWyehbxgEcjtPe1duXB
 1rzqzpdWpxZ+KpC1Ln3Nu7g2mRShY99C4o29e7mZrn38iT4pFxYsd5H6Yeh5KNUheqwm
 0wUyEMKJlemSmQJ0bo5LIEvSCaBrlEGZEzB8fNR8scHX7UO9fExLwdFRXdLDjd8DTLST
 RJ1CMfZ10e/qFHK8dXHEoxuAi2eBYzh/xUcS9vaemWaAW10psqf+5yw2yk25XdkIyGpK
 uiPPwg2OuZNkr5uekHhZOnP+t7hpJbONv00aUW10aDl9pS2sEJISCwFvv7/KLZx42Vqm
 H50A==
X-Gm-Message-State: AOJu0YyAjDQz6nf6XqM6V+UfeBI1syBUlkdWDL4YXaVaPZduAJnLrB8q
 nMX+8e3IOWqkuwBrmx+5N3g=
X-Google-Smtp-Source: AGHT+IEHu+LWygUAmmaLKSeKmqsyOg0SQZQZ3mRXGrr6C4sP6BbyUmP3M1NVqAM3mkAY7HT067oyTQ==
X-Received: by 2002:a19:4347:0:b0:50e:42d7:21fa with SMTP id
 m7-20020a194347000000b0050e42d721famr879762lfj.107.1703014288071; 
 Tue, 19 Dec 2023 11:31:28 -0800 (PST)
Received: from [127.0.0.1] (dynamic-089-014-196-021.89.14.pool.telefonica.de.
 [89.14.196.21]) by smtp.gmail.com with ESMTPSA id
 hg12-20020a1709072ccc00b00a2359f95ad8sm2700931ejc.37.2023.12.19.11.31.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Dec 2023 11:31:27 -0800 (PST)
Date: Tue, 19 Dec 2023 19:31:19 +0000
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
In-Reply-To: <9c472e25-506f-fbd5-6d72-00be078bb15c@eik.bme.hu>
References: <20231218185114.119736-1-shentey@gmail.com>
 <20231218185114.119736-13-shentey@gmail.com>
 <9c472e25-506f-fbd5-6d72-00be078bb15c@eik.bme.hu>
Message-ID: <B0C3E617-569E-4DD2-900A-5ACF093C3B63@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x132.google.com
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



Am 19=2E Dezember 2023 00:26:15 UTC schrieb BALATON Zoltan <balaton@eik=2E=
bme=2Ehu>:
>On Mon, 18 Dec 2023, Bernhard Beschow wrote:
>> The VIA south bridges are able to relocate and toggle (enable or disabl=
e) their
>> SuperI/O functions=2E So far this is hardcoded such that all functions =
are always
>> enabled and are located at fixed addresses=2E
>>=20
>> Some PC BIOSes seem to probe for I/O occupancy before activating such a=
 function
>> and issue an error in case of a conflict=2E Since the functions are ena=
bled on
>> reset, conflicts are always detected=2E Prevent that by implementing re=
location
>> and toggling of the SuperI/O functions=2E
>>=20
>> Note that all SuperI/O functions are now deactivated upon reset (except=
 for
>> VT82C686B's serial ports where Fuloong 2e's rescue-yl seems to expect t=
hem to be
>> enabled by default)=2E Rely on firmware -- or in case of pegasos2 on bo=
ard code if
>> no -bios is given -- to configure the functions accordingly=2E
>
>Pegasos2 emulates firmware when no -bios is given, this was explained in =
previos commit so maybe not needed to be explained it here again so you cou=
ld drop the comment between -- -- but I don't mind=2E
>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>> hw/isa/vt82c686=2Ec | 121 ++++++++++++++++++++++++++++++++++-----------=
-
>> 1 file changed, 90 insertions(+), 31 deletions(-)
>>=20
>> diff --git a/hw/isa/vt82c686=2Ec b/hw/isa/vt82c686=2Ec
>> index 9c2333a277=2E=2Ebe202d23cf 100644
>> --- a/hw/isa/vt82c686=2Ec
>> +++ b/hw/isa/vt82c686=2Ec
>> @@ -15,6 +15,9 @@
>>=20
>> #include "qemu/osdep=2Eh"
>> #include "hw/isa/vt82c686=2Eh"
>> +#include "hw/block/fdc=2Eh"
>> +#include "hw/char/parallel-isa=2Eh"
>> +#include "hw/char/serial=2Eh"
>> #include "hw/pci/pci=2Eh"
>> #include "hw/qdev-properties=2Eh"
>> #include "hw/ide/pci=2Eh"
>> @@ -343,6 +346,35 @@ static const TypeInfo via_superio_info =3D {
>>=20
>> #define TYPE_VT82C686B_SUPERIO "vt82c686b-superio"
>>=20
>> +static void vt82c686b_superio_update(ViaSuperIOState *s)
>> +{
>> +    isa_parallel_set_enabled(s->superio=2Eparallel[0],
>> +                             (s->regs[0xe2] & 0x3) !=3D 3);
>> +    isa_serial_set_enabled(s->superio=2Eserial[0], s->regs[0xe2] & BIT=
(2));
>> +    isa_serial_set_enabled(s->superio=2Eserial[1], s->regs[0xe2] & BIT=
(3));
>> +    isa_fdc_set_enabled(s->superio=2Efloppy, s->regs[0xe2] & BIT(4));
>> +
>> +    isa_fdc_set_iobase(s->superio=2Efloppy, (s->regs[0xe3] & 0xfc) << =
2);
>> +    isa_parallel_set_iobase(s->superio=2Eparallel[0], s->regs[0xe6] <<=
 2);
>> +    isa_serial_set_iobase(s->superio=2Eserial[0], (s->regs[0xe7] & 0xf=
e) << 2);
>> +    isa_serial_set_iobase(s->superio=2Eserial[1], (s->regs[0xe8] & 0xf=
e) << 2);
>> +}
>
>I wonder if some code duplication could be saved by adding a shared via_s=
uperio_update() for this further up in the abstract via-superio class inste=
ad of this method and vt8231_superio_update() below=2E This common method i=
n abstract class would need to handle the differences which seem to be reg =
addresses offset by 0x10 and VT8231 having only 1 serial port=2E These coul=
d either be handled by adding function parameters or fields to ViaSuperIOSt=
ate for this that the subclasses can set and the method check=2E (Such as r=
eg base=3D0xe2 for vt82c686 and 0xf2 for vt8231 and num_serial or similar f=
or how many ports are there then can have a for loop for those that would o=
nly run once for vt8231)=2E

Only the enable bits and the parallel port base address line up, the seria=
l port(s) and the floppy would need special treatment=2E Not worth it IMO=
=2E

>
>> +static int vmstate_vt82c686b_superio_post_load(void *opaque, int versi=
on_id)
>> +{
>> +    ViaSuperIOState *s =3D opaque;
>> +
>> +    vt82c686b_superio_update(s);
>> +
>> +    return 0;
>
>You could lose some blank lines here=2E You seem to love them, half of yo=
ur cover letter is just blank lines :-)

Yes, I want people to see the light rather than a wall (of text) ;-)

> but I'm the opposite and like more code to fit in one screen even on tod=
ays displays that are wider than tall=2E So this funciton would take less s=
pace without blank lines=2E (Even the local variable may not be necessary a=
s you don't access any fields within and void * should just cast without a =
warning but for spelling out the desired type as a reminder I'm ok with lea=
ving that but no excessive blank lines please if you don't mind that much=
=2E)

In this case I'll remove the s variable and the blank line above the retur=
n if that's so important to you=2E

Best regards,
Bernhard
>
>Regards,
>BALATON Zoltan
>
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
>> @@ -368,7 +400,11 @@ static void vt82c686b_superio_cfg_write(void *opaq=
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
>> @@ -393,25 +429,24 @@ static void vt82c686b_superio_reset(DeviceState *=
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
>> @@ -429,6 +464,7 @@ static void vt82c686b_superio_class_init(ObjectClas=
s *klass, void *data)
>>     sc->parallel=2Ecount =3D 1;
>>     sc->ide=2Ecount =3D 0; /* emulated by via-ide */
>>     sc->floppy=2Ecount =3D 1;
>> +    dc->vmsd =3D &vmstate_vt82c686b_superio;
>> }
>>=20
>> static const TypeInfo vt82c686b_superio_info =3D {
>> @@ -443,6 +479,33 @@ static const TypeInfo vt82c686b_superio_info =3D {
>>=20
>> #define TYPE_VT8231_SUPERIO "vt8231-superio"
>>=20
>> +static void vt8231_superio_update(ViaSuperIOState *s)
>> +{
>> +    isa_parallel_set_enabled(s->superio=2Eparallel[0],
>> +                             (s->regs[0xf2] & 0x3) !=3D 3);
>> +    isa_serial_set_enabled(s->superio=2Eserial[0], s->regs[0xf2] & BIT=
(2));
>> +    isa_fdc_set_enabled(s->superio=2Efloppy, s->regs[0xf2] & BIT(4));
>> +
>> +    isa_serial_set_iobase(s->superio=2Eserial[0], (s->regs[0xf4] & 0xf=
e) << 2);
>> +    isa_parallel_set_iobase(s->superio=2Eparallel[0], s->regs[0xf6] <<=
 2);
>> +    isa_fdc_set_iobase(s->superio=2Efloppy, (s->regs[0xf7] & 0xfc) << =
2);
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
>> @@ -465,6 +528,12 @@ static void vt8231_superio_cfg_write(void *opaque,=
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
>> @@ -493,19 +562,15 @@ static void vt8231_superio_reset(DeviceState *dev=
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
>> @@ -513,12 +578,6 @@ static void vt8231_superio_init(Object *obj)
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
>> @@ -526,10 +585,10 @@ static void vt8231_superio_class_init(ObjectClass=
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
>>=20

