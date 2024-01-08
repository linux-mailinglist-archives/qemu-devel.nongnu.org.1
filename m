Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CA982792B
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 21:32:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMwHd-0004FY-9c; Mon, 08 Jan 2024 15:31:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rMwHS-0004Ea-Bg; Mon, 08 Jan 2024 15:31:30 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rMwHP-00059N-FK; Mon, 08 Jan 2024 15:31:30 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5576ca4119cso2375084a12.2; 
 Mon, 08 Jan 2024 12:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704745885; x=1705350685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y8yI3Nzd2+Dx6OtwbthNwfIySXDAbgV8YEjE+oRwXeo=;
 b=bONAlaGI6/HnQDh9tIVOgt8DcY+xKzf+NTT6WE9HtNT8+8Bv2Ok+Y97E4E/1a+k0/i
 lCAgvwOCSbPZpQTHUegU2OuVX08DNB/FWb0jfFVkBNSvwJQgGX0EzbK0lmuHYmAdXNIY
 aSqjrNHrQMsZQmGH+E5Zovbvvlfoe5XsCEfzL/yD/rQGTW4J3/8/1/J35LXzLsrgOG5X
 CHlQSu+csSCUg35Dc0Fm9dPPTOmsfdN/bsDKt4KubfrtfAeA9U3dk+D0d2pxiu+FVslw
 cC59KnZoUyVmn00PdxfbfHv5vZQZEKUFYBMqNNk+Td46o7ymFdyG58nJfpwb+Tk3JODZ
 nmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704745885; x=1705350685;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y8yI3Nzd2+Dx6OtwbthNwfIySXDAbgV8YEjE+oRwXeo=;
 b=RRHRvXPWP8HemeChSSDaMfgrY41l1OueCzeLj9mgkMcNvHGXRqEnz136SZcSVuzCY9
 w2Ozvyg3SiD4J9lpHvvYvubkOg+BEXmWr9T0dyJF8bCcHoJnaWiOafMdl8YdUzLEXKnx
 3gA93Kv9YvkavGpCBQvTyPfQXjF4VzjChwiKXMSiI+oEeCA8Ci/QmaBuVh7yL2ml7btq
 LaZaVbb9TLl8R/Sq5OfgTdlcHxRhBxT3/X5uxd6DXdiwitHBZJ6hW4igGG/yiv7DaQxk
 iAj6pZg/xJilaOVNj6FRZL1gJsvDcB19DgJ2cT4Ovady+Lchyltv5EDJqrr0qVKbnVab
 1+Sg==
X-Gm-Message-State: AOJu0YwnSktOqCy/ewO1AWxR120MF6AHF3KUdD6tht6H+nBkfGSPG9Th
 ptJnb3AyKBs7jWyYlgMRZi0=
X-Google-Smtp-Source: AGHT+IECFBBaD6SU4TrEVcBuNsENd0aExj36M6lRiF20pQG53smhnciDdDklE+M5MuuRU9gHStUrKg==
X-Received: by 2002:a50:cdd7:0:b0:550:e014:5254 with SMTP id
 h23-20020a50cdd7000000b00550e0145254mr2703877edj.27.1704745884620; 
 Mon, 08 Jan 2024 12:31:24 -0800 (PST)
Received: from [127.0.0.1] (dynamic-078-054-062-214.78.54.pool.telefonica.de.
 [78.54.62.214]) by smtp.gmail.com with ESMTPSA id
 dy21-20020a05640231f500b00556e497cc96sm183153edb.84.2024.01.08.12.31.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 12:31:24 -0800 (PST)
Date: Mon, 08 Jan 2024 19:53:38 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 =?ISO-8859-1?Q?Fr=E9d=E9ric_Barrat?= <fbarrat@linux.ibm.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_11/11=5D_hw/isa/vt82c686=3A_Implemen?=
 =?US-ASCII?Q?t_relocation_and_toggling_of_SuperI/O_functions?=
In-Reply-To: <43de62e3-67d0-f013-2f4b-21ec1a78dbee@eik.bme.hu>
References: <20240106210531.140542-1-shentey@gmail.com>
 <20240106210531.140542-12-shentey@gmail.com>
 <43de62e3-67d0-f013-2f4b-21ec1a78dbee@eik.bme.hu>
Message-ID: <953F5075-4774-457F-BC9C-DA021DED8C0F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52b.google.com
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



Am 7=2E Januar 2024 13:59:44 UTC schrieb BALATON Zoltan <balaton@eik=2Ebme=
=2Ehu>:
>On Sat, 6 Jan 2024, Bernhard Beschow wrote:
>> The VIA south bridges are able to relocate and toggle (enable or disabl=
e) their
>> SuperI/O functions=2E So far this is hardcoded such that all functions =
are always
>> enabled and are located at fixed addresses=2E
>>=20
>> Some PC BIOSes seem to probe for I/O occupancy before activating such a=
 function
>> and issue an error in case of a conflict=2E Since the functions are cur=
rently
>> enabled on reset, conflicts are always detected=2E Prevent that by impl=
ementing
>> relocation and toggling of the SuperI/O functions=2E
>>=20
>> Note that all SuperI/O functions are now deactivated upon reset (except=
 for
>> VT82C686B's serial ports where Fuloong 2e's rescue-yl seems to expect t=
hem to be
>> enabled by default)=2E Rely on firmware to configure the functions acco=
rdingly=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>> hw/isa/vt82c686=2Ec | 66 ++++++++++++++++++++++++++++++++++++++++------=
-
>> 1 file changed, 56 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/hw/isa/vt82c686=2Ec b/hw/isa/vt82c686=2Ec
>> index d3e0f6d01f=2E=2E9f62fb5964 100644
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
>> @@ -323,6 +326,18 @@ static uint64_t via_superio_cfg_read(void *opaque,=
 hwaddr addr, unsigned size)
>>     return val;
>> }
>>=20
>> +static void via_superio_devices_enable(ViaSuperIOState *s, uint8_t dat=
a)
>> +{
>> +    ISASuperIOClass *ic =3D ISA_SUPERIO_GET_CLASS(s);
>> +    size_t i;
>
>The expected value for i is 0 or 1 (maybe up to 3 sometimes it there are =
more serial ports in a chip)=2E so why use such big type?

serial=2Ecount is of type size_t, that's why I chose it=2E Let me know if =
you still want an int, otherwise I'd leave it as is=2E

Best regards,
Bernhard

> This should just be int=2E Newly it's also allowed to declare it within =
the for so if you want that you could do so but I have no preference on tha=
t and declaring it here is also OK=2E Otherwise:
>
>Reviewed-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>
>> +
>> +    isa_parallel_set_enabled(s->superio=2Eparallel[0], (data & 0x3) !=
=3D 3);
>> +    for (i =3D 0; i < ic->serial=2Ecount; i++) {
>> +        isa_serial_set_enabled(s->superio=2Eserial[i], data & BIT(i + =
2));
>> +    }
>> +    isa_fdc_set_enabled(s->superio=2Efloppy, data & BIT(4));
>> +}
>> +
>> static void via_superio_class_init(ObjectClass *klass, void *data)
>> {
>>     DeviceClass *dc =3D DEVICE_CLASS(klass);
>> @@ -368,7 +383,25 @@ static void vt82c686b_superio_cfg_write(void *opaq=
ue, hwaddr addr,
>>     case 0xfd =2E=2E=2E 0xff:
>>         /* ignore write to read only registers */
>>         return;
>> -    /* case 0xe6 =2E=2E=2E 0xe8: Should set base port of parallel and =
serial */
>> +    case 0xe2:
>> +        data &=3D 0x1f;
>> +        via_superio_devices_enable(sc, data);
>> +        break;
>> +    case 0xe3:
>> +        data &=3D 0xfc;
>> +        isa_fdc_set_iobase(sc->superio=2Efloppy, data << 2);
>> +        break;
>> +    case 0xe6:
>> +        isa_parallel_set_iobase(sc->superio=2Eparallel[0], data << 2);
>> +        break;
>> +    case 0xe7:
>> +        data &=3D 0xfe;
>> +        isa_serial_set_iobase(sc->superio=2Eserial[0], data << 2);
>> +        break;
>> +    case 0xe8:
>> +        data &=3D 0xfe;
>> +        isa_serial_set_iobase(sc->superio=2Eserial[1], data << 2);
>> +        break;
>>     default:
>>         qemu_log_mask(LOG_UNIMP,
>>                       "via_superio_cfg: unimplemented register 0x%x\n",=
 idx);
>> @@ -395,9 +428,14 @@ static void vt82c686b_superio_reset(DeviceState *d=
ev)
>>     /* Device ID */
>>     vt82c686b_superio_cfg_write(s, 0, 0xe0, 1);
>>     vt82c686b_superio_cfg_write(s, 1, 0x3c, 1);
>> -    /* Function select - all disabled */
>> +    /*
>> +     * Function select - only serial enabled
>> +     * Fuloong 2e's rescue-yl prints to the serial console w/o enablin=
g it=2E This
>> +     * suggests that the serial ports are enabled by default, so overr=
ide the
>> +     * datasheet=2E
>> +     */
>>     vt82c686b_superio_cfg_write(s, 0, 0xe2, 1);
>> -    vt82c686b_superio_cfg_write(s, 1, 0x03, 1);
>> +    vt82c686b_superio_cfg_write(s, 1, 0x0f, 1);
>>     /* Floppy ctrl base addr 0x3f0-7 */
>>     vt82c686b_superio_cfg_write(s, 0, 0xe3, 1);
>>     vt82c686b_superio_cfg_write(s, 1, 0xfc, 1);
>> @@ -465,6 +503,21 @@ static void vt8231_superio_cfg_write(void *opaque,=
 hwaddr addr,
>>     case 0xfd:
>>         /* ignore write to read only registers */
>>         return;
>> +    case 0xf2:
>> +        data &=3D 0x17;
>> +        via_superio_devices_enable(sc, data);
>> +        break;
>> +    case 0xf4:
>> +        data &=3D 0xfe;
>> +        isa_serial_set_iobase(sc->superio=2Eserial[0], data << 2);
>> +        break;
>> +    case 0xf6:
>> +        isa_parallel_set_iobase(sc->superio=2Eparallel[0], data << 2);
>> +        break;
>> +    case 0xf7:
>> +        data &=3D 0xfc;
>> +        isa_fdc_set_iobase(sc->superio=2Efloppy, data << 2);
>> +        break;
>>     default:
>>         qemu_log_mask(LOG_UNIMP,
>>                       "via_superio_cfg: unimplemented register 0x%x\n",=
 idx);
>> @@ -513,12 +566,6 @@ static void vt8231_superio_init(Object *obj)
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
>> @@ -526,7 +573,6 @@ static void vt8231_superio_class_init(ObjectClass *=
klass, void *data)
>>=20
>>     dc->reset =3D vt8231_superio_reset;
>>     sc->serial=2Ecount =3D 1;
>> -    sc->serial=2Eget_iobase =3D vt8231_superio_serial_iobase;
>>     sc->parallel=2Ecount =3D 1;
>>     sc->ide=2Ecount =3D 0; /* emulated by via-ide */
>>     sc->floppy=2Ecount =3D 1;
>>=20

