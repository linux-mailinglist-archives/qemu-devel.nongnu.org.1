Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE72C822490
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 23:12:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKmxs-0004GQ-QM; Tue, 02 Jan 2024 17:10:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rKmxp-0004Fu-Do; Tue, 02 Jan 2024 17:10:21 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rKmxl-0007Jx-4V; Tue, 02 Jan 2024 17:10:19 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40d5f402571so64861045e9.0; 
 Tue, 02 Jan 2024 14:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704233415; x=1704838215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iFlIoMFsMjtwvwUcMFXTwIx/QuyOZP7C3m00LklabqY=;
 b=gxagKbVYPncAlmxBJ8NRv2A1QZAAKCJnNwqvF3R3BZm871jemllEZyrvuBeCkaMtQG
 YyaLI9jVOVa5mgIs9c1DxvvUw49b7Sb1UAeOH5C3RTfSE3CcrqLIAOdInmoQS8/eHmHp
 0xPj/qpiIVhmYqXCoI3CuGDgn5TJ4D/vhL4FYKXk4N7HqifKJS0km+1ww4fdbAPYBecd
 E/y6d5hd7PjhCa8devCNEiD3WUO/Lp+WQfWMp4V3vUZVk31Du3Jp/8bxwglQd/UON3TI
 aevS1TuNkvZuXjqC0KQD/lFVsZuF7IPLLg7ee0ZYgCAjbUUQb0JRbYXx+bzd/98EF6nf
 Al1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704233415; x=1704838215;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iFlIoMFsMjtwvwUcMFXTwIx/QuyOZP7C3m00LklabqY=;
 b=oL6E9t78SFO0nczOACj8HGsp+uZa+55tSwMsbj+4nnQQT2NDjvdY/cfYjlJw9I+rPI
 cxlW1OfizsJa1nLfo0ZL0+coxB2ZR6BDiGRTRuE9T9kc0PoZHruWfnhuJVmq2QzP0aD6
 ZWc7PXlINeIz+5UD47KwOfWAvtc7/LB1GHJxRVHei6rLgerUxNu/v5lAOi8I1jAk5wj6
 qDQEqSAIrKMwefoOpsT+x1K4iO25qPgesfztKP4bVMmHDNoqs1Pmn7t8tzkg0GpkMEJf
 skxY8VQM12vnrFJer7WvW6+4FSq+OUp/tfv2q7vlgGn0ogeHXitTj3LstVzTZ+4EKXb5
 NOpA==
X-Gm-Message-State: AOJu0Yx/B7on9nLtFAUnPDMljGum+Qe+nlgazhU4fCipHcHH+2ePXEOd
 5DJIZCMTSMYq78R0JfLPbRg=
X-Google-Smtp-Source: AGHT+IGgfBmbc3ALab5jW/+GFYAlqiMkT3Xif6eAUC6Mq8qzqdTcGdqKsGMsovXcnKBDl8LI3Y7XvA==
X-Received: by 2002:a05:600c:190b:b0:40d:5118:e426 with SMTP id
 j11-20020a05600c190b00b0040d5118e426mr7921727wmq.246.1704233414944; 
 Tue, 02 Jan 2024 14:10:14 -0800 (PST)
Received: from [127.0.0.1] (dynamic-089-014-091-072.89.14.pool.telefonica.de.
 [89.14.91.72]) by smtp.gmail.com with ESMTPSA id
 g18-20020a05600c311200b0040d85a1fad9sm273939wmo.46.2024.01.02.14.10.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 14:10:14 -0800 (PST)
Date: Tue, 02 Jan 2024 22:10:11 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: [PATCH] docs/system: Document running Linux on amigaone machine
In-Reply-To: <6d50c5e7-ee6d-609f-c3e7-28f74eeeb714@eik.bme.hu>
References: <20231216123013.67978-1-shentey@gmail.com>
 <da92f16c-585a-7d1f-fa0b-9a6912f7760e@eik.bme.hu>
 <79067497-55AC-49EB-A0EE-909219E2C6A7@gmail.com>
 <6d50c5e7-ee6d-609f-c3e7-28f74eeeb714@eik.bme.hu>
Message-ID: <2CA50F74-DE6D-4AD6-8581-EC22C80925B3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x332.google.com
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



Am 16=2E Dezember 2023 21:15:54 UTC schrieb BALATON Zoltan <balaton@eik=2E=
bme=2Ehu>:
>On Sat, 16 Dec 2023, Bernhard Beschow wrote:
>> Am 16=2E Dezember 2023 12:53:55 UTC schrieb BALATON Zoltan <balaton@eik=
=2Ebme=2Ehu>:
>>> On Sat, 16 Dec 2023, Bernhard Beschow wrote:
>>>> Documentation on how to run Linux on the amigaone machine is currentl=
y burried
>>>> in the depths of the qemu-devel mailing list [1] and in the source co=
de=2E Let's
>>>> collect the information in the QEMU handbook for a one stop solution=
=2E
>>>=20
>>> Thanks for collecting this info and adding it as documentation=2E
>>=20
>> You're welcome!
>>=20
>>> A few small comments bellow=2E
>>>=20
>>>> [1] https://lore=2Ekernel=2Eorg/qemu-devel/dafc407d-3749-e6f4-3a66-75=
0fde8965f9@eik=2Ebme=2Ehu/
>>>=20
>>> Do we want to keep an URL in the commit log? kernel=2Eorg is quite sta=
ble but not sure it would need to be in the commit message=2E
>>=20
>> Let's drop it=2E
>>=20
>>>=20
>>>> Co-authored-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>>>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>>> ---
>>>> MAINTAINERS                  |  1 +
>>>> docs/system/ppc/amigaone=2Erst | 53 +++++++++++++++++++++++++++++++++=
+++
>>>> docs/system/target-ppc=2Erst   |  1 +
>>>> hw/ppc/amigaone=2Ec            |  9 ------
>>>> 4 files changed, 55 insertions(+), 9 deletions(-)
>>>> create mode 100644 docs/system/ppc/amigaone=2Erst
>>>>=20
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 695e0bd34f=2E=2Ea2dd1407e2 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -1560,6 +1560,7 @@ amigaone
>>>> M: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>>>> L: qemu-ppc@nongnu=2Eorg
>>>> S: Maintained
>>>> +F: docs/system/ppc/amigaone=2Erst
>>>> F: hw/ppc/amigaone=2Ec
>>>> F: hw/pci-host/articia=2Ec
>>>> F: include/hw/pci-host/articia=2Eh
>>>> diff --git a/docs/system/ppc/amigaone=2Erst b/docs/system/ppc/amigaon=
e=2Erst
>>>> new file mode 100644
>>>> index 0000000000=2E=2Ec3f11a7bb2
>>>> --- /dev/null
>>>> +++ b/docs/system/ppc/amigaone=2Erst
>>>=20
>>> Maybe call it amigang=2Erst so it can be a place for docs on other PPC=
 AmigaNG machines such as pegasos2 and sam460ex in the future to collect th=
em in one place=2E
>>=20
>> Having everything in one place seems like creating a lot of complexity =
if one were to elaborate on the various pros and cons for each machine: Ami=
gaOne needs a custom vgabios, the others do not=2E
>
>All of these need real mode VGA BIOS as the BIOS emulator in all three ma=
chines choke on the gcc compiled QEMU VGA BIOS so this isn't uinque to amig=
aone=2E
>
>> MorpOS can be run on the other machines but not on AmigaOne=2E Sometime=
s a bootloader is needed and sometimes not, the circumstances may vary=2E
>
>MorphOS does not support amigaone, boot loader is optional and alternativ=
e to using firmware=2E
>
>Other docs seem to combine similar machines like powermac and embedded an=
d ppce500 in a single doc file so the convention seems to not have one file=
 for each machine but it's not a big deal=2E
>
>> I suggest to have a separate doc on each machine=2E
>
>I could also rename it later if more docs is added for other machines=2E
>
>>>> @@ -0,0 +1,53 @@
>>>> +Eyetech AmigaOne/Mai Logic Teron (``amigaone``)
>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> +
>>>> +The ``amigaone`` model emulates an AmigaOne XE mainboard developed b=
y Eyetech=2E Use
>>>> +the executable ``qemu-system-ppc`` to simulate a complete system=2E
>>>=20
>>> QEMU is not a simulator so even if that's repeating this should say em=
ulate=2E (Should this doc be formatted with 80 chars line too like sources?=
)
>>=20
>> I took heavy inspiration from the cupieboard machine=2E Feel free to ch=
ange=2E
>
>docs/system/arm/cubieboard=2Erst:
>"The ``cubieboard`` model emulates the Cubietech Cubieboard,"
>also says emulate not simulate=2E
>
>>>> +
>>>> +Emulated devices
>>>> +----------------
>>>> +
>>>> + *  PowerPC 7457 v1=2E2 CPU
>>>> + *  Articia S north bridge
>>>> + *  VT82C686B south bridge
>>>> + *  PCI VGA compatible card
>>>> +
>>>> +
>>>> +Preparation
>>>> +-----------
>>>> +
>>>> +A firmware binary is necessary for the boot process and is available=
 at
>>>> +https://www=2Ehyperion-entertainment=2Ecom/index=2Ephp/downloads?vie=
w=3Dfiles&parent=3D28=2E
>>>> +It needs to be extracted with the following command:
>>>> +
>>>> +=2E=2E code-block:: bash
>>>> +
>>>> +  $ tail -c 524288 updater=2Eimage > u-boot-amigaone=2Ebin
>>>> +
>>>> +The firmware binary is unable to run QEMU=E2=80=98s standard vgabios=
 and
>>>> +``VGABIOS-lgpl-latest=2Ebin`` is needed instead=2E It can be downloa=
ded from
>>>> +http://www=2Enongnu=2Eorg/vgabios=2E
>>>> +
>>>> +
>>>> +Running Linux
>>>> +-------------
>>>> +
>>>> +There are some Linux images under the following link that work on th=
e
>>>> +``amigaone`` machine:
>>>> +https://sourceforge=2Enet/projects/amigaone-linux/files/debian-insta=
ller/=2E To boot
>>>> +the system run:
>>>> +
>>>> +=2E=2E code-block:: bash
>>>> +
>>>> +  $ qemu-system-ppc -M amigaone -bios u-boot-amigaone=2Ebin \
>>>> +                    -cdrom "A1 Linux Net Installer=2Eiso" \
>>>> +                    -device ati-vga,model=3Drv100,romfile=3DVGABIOS-=
lgpl-latest=2Ebin
>>>> +
>>>> +From the firmware menu that appears select ``Boot sequence`` =E2=86=
=92
>>>> +``Amiga Multiboot Options`` and set ``Boot device 1`` to
>>>> +``Onboard VIA IDE CDROM``=2E Then hit escape until the main screen a=
ppears again,
>>>> +hit escape once more and from the exit menu that appears select eith=
er
>>>> +``Save settings and exit`` or ``Use settings for this session only``=
=2E It may
>>>> +take a long time loading the kernel into memory but eventually it bo=
ots and the
>>>> +installer becomes visible=2E
>>>> diff --git a/docs/system/target-ppc=2Erst b/docs/system/target-ppc=2E=
rst
>>>> index 4f6eb93b17=2E=2Ec1daa463cf 100644
>>>> --- a/docs/system/target-ppc=2Erst
>>>> +++ b/docs/system/target-ppc=2Erst
>>>> @@ -18,6 +18,7 @@ help``=2E
>>>>    :maxdepth: 1
>>>>=20
>>>>    ppc/embedded
>>>> +   ppc/amigaone
>>>>    ppc/powermac
>>>>    ppc/powernv
>>>>    ppc/ppce500
>>>> diff --git a/hw/ppc/amigaone=2Ec b/hw/ppc/amigaone=2Ec
>>>> index ddfa09457a=2E=2E4f680a5bdd 100644
>>>> --- a/hw/ppc/amigaone=2Ec
>>>> +++ b/hw/ppc/amigaone=2Ec
>>>> @@ -27,15 +27,6 @@
>>>>=20
>>>> #define BUS_FREQ_HZ 100000000
>>>>=20
>>>> -/*
>>>> - * Firmware binary available at
>>>> - * https://www=2Ehyperion-entertainment=2Ecom/index=2Ephp/downloads?=
view=3Dfiles&parent=3D28
>>>> - * then "tail -c 524288 updater=2Eimage >u-boot-amigaone=2Ebin"
>>>> - *
>>>> - * BIOS emulator in firmware cannot run QEMU vgabios and hangs on it=
, use
>>>> - * -device VGA,romfile=3DVGABIOS-lgpl-latest=2Ebin
>>>> - * from http://www=2Enongnu=2Eorg/vgabios/ instead=2E
>>>> - */
>>>=20
>>> Maybe it's worth keeping the comment here in case somebody reads the s=
ource but not documentation=2E
>>=20
>> Maybe change the comment to point at the doc to avoid duplication?
>
>That could work too=2E
>
>>> Do you want to send a v2 or want me to take over and do it myself?
>>=20
>> Sure, feel free to take over!
>
>OK, I'll try to make a v2 then=2E

Ping

>
>Regards,
>BALATON Zoltan

