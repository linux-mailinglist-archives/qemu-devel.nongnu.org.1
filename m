Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 528017DAC3F
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 12:30:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qx3ym-0004p6-To; Sun, 29 Oct 2023 07:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qx3yk-0004ox-CZ
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 07:29:14 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qx3yi-0005yI-Ni
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 07:29:14 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-538e8eca9c1so5579237a12.3
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 04:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698578950; x=1699183750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5JC5X+nclUfzDSBbmviBfu7RzIQjEtkeA0dTBuQrnxk=;
 b=VYE8KHiFT/ZQxCixjkRiOk8FCuUsqeVNPVuh9BO6l5Aa7mO2I8Pr0uVfKEJ3BuJQXE
 s+zFAsaV2yWz/vVMoUJFSC4bPeCS1kuEWbqViQe1pbWaL5aMMSPLbdb5vCqROMD9Hb/d
 oPdw2tm+HZDTRFSYqGPqz8J5ptvXdlmhd21idYdEZB46T98XKC5+XdU/TUr1hdLPfLPs
 O5gL0IjD9pYOAn+l8VtVAY0tOhil6hypp5POg8tFPKa1T1XONGeT8IVvrhe12rfCBADW
 Oha/hn4wKse+4eeDHpBLCc5ldYSSBdIxFz+M8xWAmRSGHTn2/b/zrwnNfU8sLNCx+i0R
 YlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698578950; x=1699183750;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5JC5X+nclUfzDSBbmviBfu7RzIQjEtkeA0dTBuQrnxk=;
 b=sWk7bkrnx/zqyMf8hqaTg2SIetjEYbG6dhRp3ofz2E1n7igL6Pz2Zfct3gSRhQCBiy
 9nkX941pemVBS1yVlFPghujufxhTd1TL1TmLFX+orQoYeCdp8xPOJCvx2VmLFSz5tk1u
 8S+Of6ckKeb85LcWR3854rqQtProlIa03Vf0Mi3J+Rvyne1vWK4TPvjDNh/DREIt+jOJ
 x4kgQNW1+tYCsqc5UR5ssTai0PV5wVg4DWluxfx42vSawddWqeOcg2+xlh4yzkSiKMxM
 VC5QS2r4Pd0G79hMsY85T/MY374e2IaVocn9sV+bfkfERXAI/GLsuDNVGFTqnSECvrre
 ajxA==
X-Gm-Message-State: AOJu0YzBlA0obKMD1AbaTpzyL/NzEmOegE7HNEcc0M3fubpnGGk0Ptu5
 +w3oCvywPaIW8yd0GmzlIwI=
X-Google-Smtp-Source: AGHT+IEEDoue8GM6bEC7Ay0NUStP96M5S++hAV+kKBgFyWR05pH5Z7BnqrHSAUwa1eZBGjlmln/qxQ==
X-Received: by 2002:a17:907:1004:b0:9be:39a4:b440 with SMTP id
 ox4-20020a170907100400b009be39a4b440mr5346912ejb.76.1698578950275; 
 Sun, 29 Oct 2023 04:29:10 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-089-012-183-026.89.12.pool.telefonica.de.
 [89.12.183.26]) by smtp.gmail.com with ESMTPSA id
 n16-20020a170906841000b0099d798a6bb5sm4143267ejx.67.2023.10.29.04.29.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 04:29:09 -0700 (PDT)
Date: Sun, 29 Oct 2023 11:28:55 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
CC: philmd@linaro.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 vr_qemu@t-online.de
Subject: Re: [PATCH 0/4] Fix IRQ routing in via south bridge
In-Reply-To: <cover.1698536342.git.balaton@eik.bme.hu>
References: <cover.1698536342.git.balaton@eik.bme.hu>
Message-ID: <9FF920F3-146A-4A20-8D2E-256E58501ADB@gmail.com>
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



Am 28=2E Oktober 2023 23:56:21 UTC schrieb BALATON Zoltan <balaton@eik=2Eb=
me=2Ehu>:
>This is going back to my otiginal proposal in
>https://patchew=2Eorg/QEMU/cover=2E1677004414=2Egit=2Ebalaton@eik=2Ebme=
=2Ehu/
>implementing routing of interrupts from device functions and PCI
>devices to ISA interrupts=2E On pegasos2 the firmware sets evertyhing to
>share IRQ 9 so the current simpified version worked for taht but with
>the amigaone machine its firmware makes use of this feature and
>assigns different interrupts to functions and PCI devices so we need
>to properly impelent this=2E Since any ISA interrupt can be controlled
>by any interrupt source (different functions of the multifunction
>device plus the 4 input pins from PCI devices) there are more than 4
>possible sources so this can't be handled by just the 4 PCI interrupt
>lines=2E We need to keep track of the state of each interrupt source to
>be able to determine the level of the ISA interrupt and avoid one
>device clearing it while other still has an interrupt=2E
>
>This fixes USB on amigaone and maybe other bugs not discovered yet=2E

Amigaone's U-Boot maps the PCI IRQ pins to PIC IRQs 7,9,10,11=2E IRQ 7 see=
ms to be the parallel port on ISA machines=2E The VIA hardware disables it =
by default (see index e2 in superio configuration registers) while it is en=
abled by default in our device models=2E Does this maybe cause an IRQ confl=
ict, making the USB function unusable?

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan
>
>BALATON Zoltan (4):
>  hw/isa/vt82c686: Bring back via_isa_set_irq()
>  hw/usb/vt82c686-uhci-pci: Use ISA instead of PCI interrupts
>  hw/isa/vt82c686: Route PIRQ inputs using via_isa_set_irq()
>  hw/audio/via-ac97: Route interrupts using via_isa_set_irq()
>
> hw/audio/via-ac97=2Ec        |  8 ++---
> hw/isa/vt82c686=2Ec          | 67 +++++++++++++++++++++++---------------
> hw/usb/vt82c686-uhci-pci=2Ec |  9 +++++
> include/hw/isa/vt82c686=2Eh  |  2 ++
> 4 files changed, 56 insertions(+), 30 deletions(-)
>

