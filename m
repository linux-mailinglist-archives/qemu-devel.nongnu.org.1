Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC879815B6B
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Dec 2023 20:44:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEaYv-0002RI-9I; Sat, 16 Dec 2023 14:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rEaYr-0002R5-GP; Sat, 16 Dec 2023 14:42:57 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rEaYo-0006EK-8e; Sat, 16 Dec 2023 14:42:56 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50bf26b677dso1814621e87.2; 
 Sat, 16 Dec 2023 11:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702755771; x=1703360571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P1Bo69EuZDSn3LjB9ckjvauUygsZyjke1al0b960qmM=;
 b=DI3OH16R60RxCvYGIvGW86PI49MmECFMJp+rnvHPVV3w2smj91wiF6pTLOtjx/Fgd5
 +76qWLTIBhzXsNoP7ewHRKXu6vJ3DEv/nrGE/2CfmkXRNKCQ3pf9NU5zeSSNQbufT1ZG
 96pvyg/FP5ewYikN+yAsYsTZAqEW0iUtbfNKfI97L/otUlS3W/26gS1Wid2QPxqAl4uG
 kad9tMLHmDNxp/91jh5ytIETxBStbxoMnIWMZx2gDrmaGq9iPCI6ZCSq+LXHmXq0zoMU
 iPMyQ3CVE1ngpuovgyvB8C8p5YyhKmH9ryA6t0v5iNrNrZ6QyLA7zMU9mhWdXsUn8BQ9
 Jw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702755771; x=1703360571;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P1Bo69EuZDSn3LjB9ckjvauUygsZyjke1al0b960qmM=;
 b=N7fX0PJZpuG7lfBEtsbFFWFdUIWBqYpp2fdC/vaHXjzwOvGIE1ek3G3KC5C91q9uZU
 qYxn/uZ96wo3OW/ACxfqF3eBN+VHkr1mzFS4NECoj91ioiOQkJAjatntcKfZlU2xNOSA
 J/+/Lut0SUhC3j9tOZ9DLp5Erk//OnxCI4GkNKgjOsCbyEXDPRSAjLL2tURQR8KH8OfY
 Lm+j6YfxkA922dKA9TgSK1wE9BbRX4vWnu9auKxb5Qr5uOmSOkTZLmq5Hrcuk6uDvWp/
 S8LWeWgOGERhPjIT2ENSDyi0L1yLgKwe1FCPwOA+udpgSW679Bx5hRxkcYoF9lU66rkB
 fLew==
X-Gm-Message-State: AOJu0Yx0T6Ki7yzy6SUb5cjRaSCA5rIHDC8QJj0cMZFhE4fDEPCKvkJa
 zR8aREdQINLgzUv6zPKHRTs=
X-Google-Smtp-Source: AGHT+IGWhVFpZ/Eb32gJZ8zFJKN/ehxECNFIwKmzq2GZ3qSgM6JoMOZhr5O8g1b7NXqGJ6vVTKVmqQ==
X-Received: by 2002:ac2:4e97:0:b0:50d:12eb:9d3c with SMTP id
 o23-20020ac24e97000000b0050d12eb9d3cmr3444502lfr.134.1702755770800; 
 Sat, 16 Dec 2023 11:42:50 -0800 (PST)
Received: from [127.0.0.1] ([185.109.152.26]) by smtp.gmail.com with ESMTPSA id
 ti2-20020a170907c20200b00a1ce97f320dsm12159557ejc.31.2023.12.16.11.42.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 Dec 2023 11:42:50 -0800 (PST)
Date: Sat, 16 Dec 2023 19:40:30 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: [PATCH] docs/system: Document running Linux on amigaone machine
In-Reply-To: <da92f16c-585a-7d1f-fa0b-9a6912f7760e@eik.bme.hu>
References: <20231216123013.67978-1-shentey@gmail.com>
 <da92f16c-585a-7d1f-fa0b-9a6912f7760e@eik.bme.hu>
Message-ID: <79067497-55AC-49EB-A0EE-909219E2C6A7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x130.google.com
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



Am 16=2E Dezember 2023 12:53:55 UTC schrieb BALATON Zoltan <balaton@eik=2E=
bme=2Ehu>:
>On Sat, 16 Dec 2023, Bernhard Beschow wrote:
>> Documentation on how to run Linux on the amigaone machine is currently =
burried
>> in the depths of the qemu-devel mailing list [1] and in the source code=
=2E Let's
>> collect the information in the QEMU handbook for a one stop solution=2E
>
>Thanks for collecting this info and adding it as documentation=2E

You're welcome!

> A few small comments bellow=2E
>
>> [1] https://lore=2Ekernel=2Eorg/qemu-devel/dafc407d-3749-e6f4-3a66-750f=
de8965f9@eik=2Ebme=2Ehu/
>
>Do we want to keep an URL in the commit log? kernel=2Eorg is quite stable=
 but not sure it would need to be in the commit message=2E

Let's drop it=2E

>
>> Co-authored-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>> MAINTAINERS                  |  1 +
>> docs/system/ppc/amigaone=2Erst | 53 +++++++++++++++++++++++++++++++++++=
+
>> docs/system/target-ppc=2Erst   |  1 +
>> hw/ppc/amigaone=2Ec            |  9 ------
>> 4 files changed, 55 insertions(+), 9 deletions(-)
>> create mode 100644 docs/system/ppc/amigaone=2Erst
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 695e0bd34f=2E=2Ea2dd1407e2 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1560,6 +1560,7 @@ amigaone
>> M: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>> L: qemu-ppc@nongnu=2Eorg
>> S: Maintained
>> +F: docs/system/ppc/amigaone=2Erst
>> F: hw/ppc/amigaone=2Ec
>> F: hw/pci-host/articia=2Ec
>> F: include/hw/pci-host/articia=2Eh
>> diff --git a/docs/system/ppc/amigaone=2Erst b/docs/system/ppc/amigaone=
=2Erst
>> new file mode 100644
>> index 0000000000=2E=2Ec3f11a7bb2
>> --- /dev/null
>> +++ b/docs/system/ppc/amigaone=2Erst
>
>Maybe call it amigang=2Erst so it can be a place for docs on other PPC Am=
igaNG machines such as pegasos2 and sam460ex in the future to collect them =
in one place=2E

Having everything in one place seems like creating a lot of complexity if =
one were to elaborate on the various pros and cons for each machine: AmigaO=
ne needs a custom vgabios, the others do not=2E MorpOS can be run on the ot=
her machines but not on AmigaOne=2E Sometimes a bootloader is needed and so=
metimes not, the circumstances may vary=2E

I suggest to have a separate doc on each machine=2E

>
>> @@ -0,0 +1,53 @@
>> +Eyetech AmigaOne/Mai Logic Teron (``amigaone``)
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +The ``amigaone`` model emulates an AmigaOne XE mainboard developed by =
Eyetech=2E Use
>> +the executable ``qemu-system-ppc`` to simulate a complete system=2E
>
>QEMU is not a simulator so even if that's repeating this should say emula=
te=2E (Should this doc be formatted with 80 chars line too like sources?)

I took heavy inspiration from the cupieboard machine=2E Feel free to chang=
e=2E

>
>> +
>> +Emulated devices
>> +----------------
>> +
>> + *  PowerPC 7457 v1=2E2 CPU
>> + *  Articia S north bridge
>> + *  VT82C686B south bridge
>> + *  PCI VGA compatible card
>> +
>> +
>> +Preparation
>> +-----------
>> +
>> +A firmware binary is necessary for the boot process and is available a=
t
>> +https://www=2Ehyperion-entertainment=2Ecom/index=2Ephp/downloads?view=
=3Dfiles&parent=3D28=2E
>> +It needs to be extracted with the following command:
>> +
>> +=2E=2E code-block:: bash
>> +
>> +  $ tail -c 524288 updater=2Eimage > u-boot-amigaone=2Ebin
>> +
>> +The firmware binary is unable to run QEMU=E2=80=98s standard vgabios a=
nd
>> +``VGABIOS-lgpl-latest=2Ebin`` is needed instead=2E It can be downloade=
d from
>> +http://www=2Enongnu=2Eorg/vgabios=2E
>> +
>> +
>> +Running Linux
>> +-------------
>> +
>> +There are some Linux images under the following link that work on the
>> +``amigaone`` machine:
>> +https://sourceforge=2Enet/projects/amigaone-linux/files/debian-install=
er/=2E To boot
>> +the system run:
>> +
>> +=2E=2E code-block:: bash
>> +
>> +  $ qemu-system-ppc -M amigaone -bios u-boot-amigaone=2Ebin \
>> +                    -cdrom "A1 Linux Net Installer=2Eiso" \
>> +                    -device ati-vga,model=3Drv100,romfile=3DVGABIOS-lg=
pl-latest=2Ebin
>> +
>> +From the firmware menu that appears select ``Boot sequence`` =E2=86=92
>> +``Amiga Multiboot Options`` and set ``Boot device 1`` to
>> +``Onboard VIA IDE CDROM``=2E Then hit escape until the main screen app=
ears again,
>> +hit escape once more and from the exit menu that appears select either
>> +``Save settings and exit`` or ``Use settings for this session only``=
=2E It may
>> +take a long time loading the kernel into memory but eventually it boot=
s and the
>> +installer becomes visible=2E
>> diff --git a/docs/system/target-ppc=2Erst b/docs/system/target-ppc=2Ers=
t
>> index 4f6eb93b17=2E=2Ec1daa463cf 100644
>> --- a/docs/system/target-ppc=2Erst
>> +++ b/docs/system/target-ppc=2Erst
>> @@ -18,6 +18,7 @@ help``=2E
>>    :maxdepth: 1
>>=20
>>    ppc/embedded
>> +   ppc/amigaone
>>    ppc/powermac
>>    ppc/powernv
>>    ppc/ppce500
>> diff --git a/hw/ppc/amigaone=2Ec b/hw/ppc/amigaone=2Ec
>> index ddfa09457a=2E=2E4f680a5bdd 100644
>> --- a/hw/ppc/amigaone=2Ec
>> +++ b/hw/ppc/amigaone=2Ec
>> @@ -27,15 +27,6 @@
>>=20
>> #define BUS_FREQ_HZ 100000000
>>=20
>> -/*
>> - * Firmware binary available at
>> - * https://www=2Ehyperion-entertainment=2Ecom/index=2Ephp/downloads?vi=
ew=3Dfiles&parent=3D28
>> - * then "tail -c 524288 updater=2Eimage >u-boot-amigaone=2Ebin"
>> - *
>> - * BIOS emulator in firmware cannot run QEMU vgabios and hangs on it, =
use
>> - * -device VGA,romfile=3DVGABIOS-lgpl-latest=2Ebin
>> - * from http://www=2Enongnu=2Eorg/vgabios/ instead=2E
>> - */
>
>Maybe it's worth keeping the comment here in case somebody reads the sour=
ce but not documentation=2E

Maybe change the comment to point at the doc to avoid duplication?

> Do you want to send a v2 or want me to take over and do it myself?

Sure, feel free to take over!

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan

