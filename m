Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9557DA7C1
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 17:22:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwl7N-0005HK-Gt; Sat, 28 Oct 2023 11:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qwl79-0005FN-Em
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 11:20:40 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qwl75-0003OX-NV
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 11:20:38 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9d10972e63eso142364566b.2
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 08:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698506433; x=1699111233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tB83i6lsSrX6pEaIHqwEBC8yDcbkKhWEi3oU3gemnRc=;
 b=e4hwldoqAQkiZGCHxi5xIyb5sAbT2J3YLfRNh10cwGTPLfZXLXtKLIMUA42HmJYkPh
 vjoxd9snJPobxjybFU0515pmJcrICUeGOdgtdbNf7WhzPx9qeMzg2vFrBi9jcpbevwoc
 VcceZZvDcMFHrxKI0M1d/YdDQksELHW6GvvY6802XKOsXqaIDNRfsjATJGehXVgHn57+
 JfBpXLXA10hvijJxJzcipTYyoPKydFs1P2A3f7PuaI07ie6iErdl4EHn8bDSK+poQfNh
 HZ5kUtAbapPb//ZWBjwzjTHspRZsR3gv/GdJ3TbAYQe7HDCpBBw45XBQsIWi8/nOxM8F
 Mk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698506433; x=1699111233;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tB83i6lsSrX6pEaIHqwEBC8yDcbkKhWEi3oU3gemnRc=;
 b=pNsfoy4wRrhG3E0G4CjrFqz6Nwz4SGG+r6UdukcljdqJxfSY/cRX0oQesiCfsFIrYG
 Feva/LFs2KNMcJX7puEtJxDpQ+9BcTJbwlqRAfFO2McmmY/CZUNIpziC1qfJp0yu8XA8
 WgEVX6jEdKp+qnOxFXrtMFPIUz5NcLsNXkPJXhPST1wEXEv7t19e6F/hmzxsWeePCU1R
 9Ko2gqC/oWeMYO1t+Dz6GoLwwtDo2QsU8WYjtl9EgQ+K/iJpS33/X4VqAvOJw6GdFAfS
 e4ExSgqm4DCN5L1sfinn5ixHgmJ2FJyI22saksvGae+RysUXGgWFfbDwsUSlj3f3XfLF
 deMw==
X-Gm-Message-State: AOJu0YwTRzNh0uKrMWsW8mRFgaAyt4D7sM4XDA7r+3XQSuOTt+4hXYoZ
 WgK8twi7W2/zDPYG3QimmSQ=
X-Google-Smtp-Source: AGHT+IGm0XkAct2b9THO9UtshmLhh75DXiSlftQMQNeh5F/8PFoWt09AMbNRSPBLljg7NIa97ZBFww==
X-Received: by 2002:a17:907:9602:b0:9bf:77ae:3aa9 with SMTP id
 gb2-20020a170907960200b009bf77ae3aa9mr4449409ejc.24.1698506432828; 
 Sat, 28 Oct 2023 08:20:32 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-089-012-044-170.89.12.pool.telefonica.de.
 [89.12.44.170]) by smtp.gmail.com with ESMTPSA id
 a2-20020a170906244200b0099cb0a7098dsm2947532ejb.19.2023.10.28.08.20.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 08:20:32 -0700 (PDT)
Date: Sat, 28 Oct 2023 15:20:26 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 0/5] VIA PM: Implement basic ACPI support
In-Reply-To: <999122a1-7790-f77c-8826-cd143191f6fb@eik.bme.hu>
References: <20231028091606.23700-1-shentey@gmail.com>
 <999122a1-7790-f77c-8826-cd143191f6fb@eik.bme.hu>
Message-ID: <FE0C5B55-83DE-466F-B555-124B3936E3DE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 28=2E Oktober 2023 12:58:32 UTC schrieb BALATON Zoltan <balaton@eik=2Eb=
me=2Ehu>:
>Hello,
>
>On Sat, 28 Oct 2023, Bernhard Beschow wrote:
>> This series is part of my work to bring the VIA south bridges to the PC=
 machine
>> [1]=2E It implements missing ACPI functionality which ACPI-aware x86 gu=
ests
>> expect for a smooth experience=2E The implementation is heavily inspire=
d by PIIX4=2E
>
>I think first the interrupt routing should be fixed because that may chan=
ge a few things in this series so that should be the next step and then reb=
ase this series on top of that=2E
>
>What I mean by fixing interrupt routing? You may remember this discussion=
:
>
>https://patchew=2Eorg/QEMU/cover=2E1677004414=2Egit=2Ebalaton@eik=2Ebme=
=2Ehu/
>
>With pegasos2 your (over)simplification worked only because the firmware =
of that machine maps everythnig to one ISA IRQ and guests were happy with t=
hat=2E I told you that back then but could not convince you and Mark about =
that=2E Now with the amigaone machine the firmware maps VIA devices and PCI=
 interuupt pins to different ISA IRQs so we need to go back either to my ot=
iginal implementation or something else you come up with=2E You can test th=
is trying to use USB devices with amigaone machine which only works after r=
everting 4e5a20b6da9b1 and 422a6e8075752=2E So please either propose someth=
ing to fix that first or wait with this series until I can update my pathch=
es to solve interrupt routing=2E I think this series should wait until afte=
r that because it adds more interrupt handling which should follow whatever=
 way we come up with for that so it's too early fir this series yet=2E (If =
you want to try fixing it keep in mind that in both amigaone and pegasos2 t=
he PCI buses are in the north bridge not in the VIA south bridge so don't t=
ry to force the IRQ mapping into the PCI bus=2E All the VIA chip needs to d=
o is mapping its PIRQ/PINT pins to ISA IRQs as the VIA is only handling ISA=
 IRQs and all other pci stuff is handled in the north bridge=2E So I think =
we need a via_set_isa_irq function but we could change it according to Mark=
's idea to pass the PCI device and use its function number to select itq so=
urce instead of the enum I had in my original series=2E)
>
>I have some other comments that I'll add in reply to individual patches f=
or the future/

Hi Zoltan,

The interrupt handling introduced in this series is not related to PCI int=
errupt routing: The SMI is a dedicated pin on the device and the SCI is map=
ped internally to an ISA interrupt (note how the power management function =
lacks the registers for PCI interrupt information)=2E Hence, PCI interrupt =
routing isn't changed in this series and therefore seems off-topic to me=2E

Moreover, the SMI is a new interrupt which is therefore not used in any ma=
chine yet=2E The SCI is deactivated if set to IRQ 0 which is the default ev=
en=2E If a guest configures it, it shall be aware to receive an *ISA* inter=
rupt=2E

So I think this series shouldn't conflict with any previous work and shoul=
d not be blocked by the PCI IRQ routing topic=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan
>
>> Further quirks are needed in order to use the VIA south bridges in the =
PC
>> machine=2E These were deliberately left out for a future series=2E The =
idea for now
>> is to get the device model in shape for adding support for it in SeaBIO=
S=2E
>>=20
>> The series is structured as follows: The first patch fixes ACPI events =
to be
>> signalled by SCI interrupts=2E The next three patches implement typical=
 ACPI
>> event handling=2E The last patch adds software-based SMI triggering whi=
ch is the
>> mechanism used in ACPI to transition the system into ACPI mode=2E
>>=20
>> Testing done:
>> * `make check`
>> * `make check-avocado`
>> * `qemu-system-ppc -M pegasos2 \
>>                   -device ati-vga,romfile=3D"" \
>>                   -cdrom morphos-3=2E18=2Eiso \
>>                   -bios pegasos2=2Erom`
>>=20
>> [1] https://github=2Ecom/shentok/qemu/tree/pc-via
>>=20
>> v5:
>> * Implement software-based SMI triggering and handling of ACPI events b=
ased on
>>  v3
>>=20
>> v4:
>> * Alternative proposal (Zoltan)
>>=20
>> v3: https://patchew=2Eorg/QEMU/20231005115159=2E81202-1-shentey@gmail=
=2Ecom/
>> * Rename SCI irq attribute to sci_irq (Zoltan)
>> * Fix confusion about location of ACPI interrupt select register (Zolta=
n)
>> * Model SCI as named GPIO (Bernhard)
>> * Perform upcast via macro rather than sub structure selection (Bernhar=
d)
>>=20
>> v2:
>> * Introduce named constants for the ACPI interrupt select register at o=
ffset
>>  0x42 (Phil)
>>=20
>> Bernhard Beschow (5):
>>  hw/isa/vt82c686: Respect SCI interrupt assignment
>>  hw/isa/vt82c686: Add missing initialization of ACPI general purpose
>>    event registers
>>  hw/isa/vt82c686: Reuse acpi_update_sci()
>>  hw/isa/vt82c686: Implement ACPI powerdown
>>  hw/isa/vt82c686: Implement software-based SMI triggering
>>=20
>> hw/isa/vt82c686=2Ec | 179 ++++++++++++++++++++++++++++++++++++---------=
-
>> 1 file changed, 142 insertions(+), 37 deletions(-)
>>=20
>> --
>> 2=2E42=2E0
>>=20
>>=20
>>=20

