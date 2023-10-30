Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 603947DB7D2
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 11:19:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxPMU-00080C-D7; Mon, 30 Oct 2023 06:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qxPMR-0007zr-Uq
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 06:19:08 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qxPMP-00059q-Uu
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 06:19:07 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-99357737980so670449566b.2
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 03:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698661144; x=1699265944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4H56HG89T29ghmmWKSoPhsQCUMzeu+1s1b9HPPz+Hwo=;
 b=QS0TRUwqtwtnwGAE9AvVgfr1kG+IlgWElylcTMK2vYF89YAfjX+Fn+YZFthsMDWIYJ
 Cai9keMUaj8wiDaDKmSzgDM8NCj8DOt/T9dMfdYPGp/pWKtsojfrLj/SZycX6CNDOXVI
 NoE2j14oVGbQwlk6qzm0bmPsrRR+DN8qVOIqSdRKFkquW/gihC8JgwEQn+c2q7JyazMl
 xuORr94Hj7KnGdHwQC/5Hy8qtZIttBteXbi/EeBgekPxQcJ1ePvqqFMhAN29bO7I4Wgo
 dgABL85FwLmlWum18IhZuSqjw4oY3zLVy63NISWHGhY+rCHFpzaQTMT7Wu8Fyvq7aIB4
 cfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698661144; x=1699265944;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4H56HG89T29ghmmWKSoPhsQCUMzeu+1s1b9HPPz+Hwo=;
 b=cL+OsDPz/OVlpkdY4p0nQSdinRj1EToIviwxM9IPhhT1aoZl5e9CaLb6piThiRmO6e
 KQvtu5Aqvy3aJINZdVeaB+AZB6Hsy7QyBJY7xfm15IMWoYD7BUa8GdmqObmLUvBUWNSr
 YN4CxyGXJj8isPmQ/6C5SpNENTy5Gu8PWFKuC7nEBH6q3tP0YT4NKbqswixftiVVavzu
 WArv5SfLHoW6LS+bZ7nDE1QqGpJu5jYyfsbVo1wA01hlnWW56ruBzzU7+jaznf2SDhBB
 ykfz4Nky4GksNgG3ECWS5rVf2coJsnYOEkdhRNUxxc5Wjtss7U/P1AmXMcbyai1QnIjU
 7mDg==
X-Gm-Message-State: AOJu0YzFnn057pF0IdB8wEfr4QlJi+/yvcXjPmtgwYa9onEKFPPA2ft2
 MjuffM8LUNMXqYzJN804xGI=
X-Google-Smtp-Source: AGHT+IFBgmJi+ZumZ4NeZSmboeHsAVH7aEEbHfKabXuIig+lJ5lqyjGZ5MmavhmXqVWb/HIJUPp1oQ==
X-Received: by 2002:a17:907:7245:b0:9b2:b152:b0f2 with SMTP id
 ds5-20020a170907724500b009b2b152b0f2mr8943578ejc.10.1698661144088; 
 Mon, 30 Oct 2023 03:19:04 -0700 (PDT)
Received: from [127.0.0.1] ([90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 l17-20020a170906415100b009adc77fe165sm5719265ejk.118.2023.10.30.03.19.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 03:19:03 -0700 (PDT)
Date: Mon, 30 Oct 2023 09:49:09 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, philmd@linaro.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, vr_qemu@t-online.de
Subject: Re: [PATCH 0/4] Fix IRQ routing in via south bridge
In-Reply-To: <e1cc0b8e-56be-8199-7499-9838904a97ac@eik.bme.hu>
References: <cover.1698536342.git.balaton@eik.bme.hu>
 <9FF920F3-146A-4A20-8D2E-256E58501ADB@gmail.com>
 <e1cc0b8e-56be-8199-7499-9838904a97ac@eik.bme.hu>
Message-ID: <DBA5D8E4-1903-4852-8E5A-2A84DDB54399@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
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



Am 29=2E Oktober 2023 11:35:27 UTC schrieb BALATON Zoltan <balaton@eik=2Eb=
me=2Ehu>:
>On Sun, 29 Oct 2023, Bernhard Beschow wrote:
>> Am 28=2E Oktober 2023 23:56:21 UTC schrieb BALATON Zoltan <balaton@eik=
=2Ebme=2Ehu>:
>>> This is going back to my otiginal proposal in
>>> https://patchew=2Eorg/QEMU/cover=2E1677004414=2Egit=2Ebalaton@eik=2Ebm=
e=2Ehu/
>>> implementing routing of interrupts from device functions and PCI
>>> devices to ISA interrupts=2E On pegasos2 the firmware sets evertyhing =
to
>>> share IRQ 9 so the current simpified version worked for taht but with
>>> the amigaone machine its firmware makes use of this feature and
>>> assigns different interrupts to functions and PCI devices so we need
>>> to properly impelent this=2E Since any ISA interrupt can be controlled
>>> by any interrupt source (different functions of the multifunction
>>> device plus the 4 input pins from PCI devices) there are more than 4
>>> possible sources so this can't be handled by just the 4 PCI interrupt
>>> lines=2E We need to keep track of the state of each interrupt source t=
o
>>> be able to determine the level of the ISA interrupt and avoid one
>>> device clearing it while other still has an interrupt=2E
>>>=20
>>> This fixes USB on amigaone and maybe other bugs not discovered yet=2E
>>=20
>> Amigaone's U-Boot maps the PCI IRQ pins to PIC IRQs 7,9,10,11=2E IRQ 7 =
seems to be the parallel port on ISA machines=2E The VIA hardware disables =
it by default (see index e2 in superio configuration registers) while it is=
 enabled by default in our device models=2E Does this maybe cause an IRQ co=
nflict, making the USB function unusable?
>
>Not likely because parellel port is not used and does not generate interr=
upts=2E It's just your current patch in master only maps PCI interrupts and=
 does not correctly route interrupts from chip functions so the USB interru=
pts end up at the wrong ISA IRQ=2E

Indeed=2E Even booting into a Linux guest doesn't generate "parallel*" tra=
ce logs=2E

Best regards,
Bernhard

>
>> Best regards,
>> Bernhard
>>=20
>>>=20
>>> Regards,
>>> BALATON Zoltan
>>>=20
>>> BALATON Zoltan (4):
>>>  hw/isa/vt82c686: Bring back via_isa_set_irq()
>>>  hw/usb/vt82c686-uhci-pci: Use ISA instead of PCI interrupts
>>>  hw/isa/vt82c686: Route PIRQ inputs using via_isa_set_irq()
>>>  hw/audio/via-ac97: Route interrupts using via_isa_set_irq()
>>>=20
>>> hw/audio/via-ac97=2Ec        |  8 ++---
>>> hw/isa/vt82c686=2Ec          | 67 +++++++++++++++++++++++-------------=
--
>>> hw/usb/vt82c686-uhci-pci=2Ec |  9 +++++
>>> include/hw/isa/vt82c686=2Eh  |  2 ++
>>> 4 files changed, 56 insertions(+), 30 deletions(-)
>>>=20
>>=20
>>=20

