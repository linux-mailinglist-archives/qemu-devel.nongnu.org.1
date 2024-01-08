Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5817C82792C
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 21:32:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMwHX-0004Ey-El; Mon, 08 Jan 2024 15:31:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rMwHS-0004EK-0i; Mon, 08 Jan 2024 15:31:30 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rMwHP-000597-5G; Mon, 08 Jan 2024 15:31:29 -0500
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2cd56dac1adso14993341fa.2; 
 Mon, 08 Jan 2024 12:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704745883; x=1705350683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m6xZFIXTW8KcgePBou+mANJ7I4C6HnRtN/q795tCnLo=;
 b=WaXWUhrh5zkbgUXm4JmUOTmIln/9RgAnv/pOZM/LjOQHbnhVG/tfeHkiBtiqjkdEXx
 0ss/Lh8Uj2Lx41nrV6TKr63cU+bVznk1UbC1t0PASDP3i4fSd2ncoqcyyys40dErqp2K
 sgy7o7AgiTSx1bXQrfQPld2DMnER4DbfDaY1WxNrOX5hAibOqb5T/bAoOScfHSWnD2UJ
 y50zZeyqz7CjTqqi3pohMIuaQ70U1t+rWdi5gRqkjmj85VoJBAQloYSJC2+TAD5OoW01
 bh6U0F8zOk7eHDSTZPI2JEmS263+PFCSXdAdqgOwU7NtMGHPbBiGoF8BO830HJINSYDD
 jenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704745883; x=1705350683;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m6xZFIXTW8KcgePBou+mANJ7I4C6HnRtN/q795tCnLo=;
 b=dafoOM2PziKSVcY2YE/8KnL6oDE4ztcxlnh+qEDieNSOYA7XpDBIYDtXHSbG+Izdwh
 MKHbENwtWnxK4nn3UIuwOBJ+0qKEEwtufmBoTMsNWEfOi4zRURCRkTrpDThAtAGHapUt
 wHz1fPiQRcxPdNHJAtE8OujWPjAqTmUgL9MEkM1MVrjMKNQVJ1A51GI4UPftCVimwCQk
 P02/9lAGhdncbbDzHu1tffYjGSaN71KLeveMQTJcKQoS2aRpB4xkwnDxFioXAFOhhrLT
 saX4Tjg9Myv94wMHzLiL+wcZsSYbvI0UZq3Kvfspz8RGszj7gkvcg8LkMpjex2gKRyh1
 jhNg==
X-Gm-Message-State: AOJu0YyO3GNHMyjqqGXOGg0imOudSXewCvePNcS+9IMbUC1wJYlJdQbU
 K6z6GfH9buurZs47Bot7nDs=
X-Google-Smtp-Source: AGHT+IHQTlEWwmB7bvBmkL0saCw91GEhXg0JQWnsTTkxyzXPdusHKUaeWRPOAA1hO8erKvXjJWrfIg==
X-Received: by 2002:a2e:3903:0:b0:2cc:fe03:4360 with SMTP id
 g3-20020a2e3903000000b002ccfe034360mr1992864lja.24.1704745883100; 
 Mon, 08 Jan 2024 12:31:23 -0800 (PST)
Received: from [127.0.0.1] (dynamic-078-054-062-214.78.54.pool.telefonica.de.
 [78.54.62.214]) by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b0055732bd1fc0sm184726edw.82.2024.01.08.12.31.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 12:31:21 -0800 (PST)
Date: Mon, 08 Jan 2024 19:54:34 +0000
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_10/11=5D_hw/ppc/pegasos2=3A_Let_p?=
 =?US-ASCII?Q?egasos2_machine_configure_SuperI/O_functions?=
In-Reply-To: <fa7a9464-912c-19d7-e9d0-b1a0896e0cac@eik.bme.hu>
References: <20240106210531.140542-1-shentey@gmail.com>
 <20240106210531.140542-11-shentey@gmail.com>
 <fa7a9464-912c-19d7-e9d0-b1a0896e0cac@eik.bme.hu>
Message-ID: <0F015BDE-FF03-4BF3-80E9-6300E6B80C32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=shentey@gmail.com; helo=mail-lj1-x22c.google.com
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



Am 7=2E Januar 2024 13:54:57 UTC schrieb BALATON Zoltan <balaton@eik=2Ebme=
=2Ehu>:
>On Sat, 6 Jan 2024, Bernhard Beschow wrote:
>> This is a preparation for implementing relocation and toggling of Super=
I/O
>> functions in the VT8231 device model=2E Upon reset, all SuperI/O functi=
ons will be
>> deactivated, so in case if no -bios is given, let the machine configure=
 those
>> functions the same way Pegasos II firmware would do=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>> hw/ppc/pegasos2=2Ec | 15 +++++++++++++++
>> 1 file changed, 15 insertions(+)
>>=20
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
>
>I think this function should not need Pegasos2MachineState *pm and can ju=
st use cpu_physical_memory_write() instead=2E

Okay, I'll change it=2E

Best regards,
Bernhard

> Otherwise
>
>Reviewed-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>
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

