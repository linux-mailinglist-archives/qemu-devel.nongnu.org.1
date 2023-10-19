Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C94A7D0060
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 19:21:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtWhs-0002YI-C3; Thu, 19 Oct 2023 13:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qtWhp-0002Vp-5V; Thu, 19 Oct 2023 13:21:09 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qtWhn-0003ex-GL; Thu, 19 Oct 2023 13:21:08 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9ba1eb73c27so1354739166b.3; 
 Thu, 19 Oct 2023 10:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697736064; x=1698340864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ocrsLyDY2xO0og8i+B4U9kq1qYU67Aps7ZFbb01KyWs=;
 b=eEejSd3szN9dNOnA1hlTuw0DylwA6O5II6El/6WzKka2JGP7tv5SVJ3z5SxcxVNqAP
 GukTLNclkOGg181bn9oObvMb7Vl6+fOHThs65EHcm3TIf2fMOsFX2v66Ya6Wm6kjcOgU
 8zpF3ulhBHgQqqM85SELidxG40c2YfEcw98xfqCyaY5boYX8bfPC1loWVPfZPmm5lyNG
 7Jd2g4ns+iJS+6iNloxESM57GgSYGspFmoG/kAQyXitqFhocmIVf4VANhB1eHK532MZ6
 Kz5r7fpGtlDNQwx4PlSB0ccBKMrWrj2LHSKoYpRSNT01jtHNhPcPC1KduRTmd0gjIen0
 ZEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697736064; x=1698340864;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ocrsLyDY2xO0og8i+B4U9kq1qYU67Aps7ZFbb01KyWs=;
 b=QH1ERPUiQVyaaZxHNQXxr+JpO5/62vH1P0OHZ+cXX6Dvn9Ps5AnwTlvlzpJU5lGYG0
 cGHE6osqD8F9I30jU9U/3IvxcxxQ2RrbEdR4/ev7a/RS3X7wh95CeaLJLkaB77Wq+whE
 Ni4LFUwR5HD5BGHOEZH6EwyPjl3yi5Uxy71RHLT9fBQHRx8flj8G+EjB/xioyXH8CYlV
 Sj1f5sFR6WkLurP9YoW3KEUJriPwpbwEkTdiz3Mt4N2ngrDVowd8ekFzhoomW3pv7HGZ
 /tO9pToISlbokVpy0jw77wfXWR6mOh/3FXRpNJa3WIJse6XcfVqD1o83h3daCHHhZ2FO
 c93Q==
X-Gm-Message-State: AOJu0YximszxzjmcTXZuOfn740b0E4M7LCv+16e9CID9D7Ut6MW0iYEg
 oikVuALQSrkYo9YQzgtylwY=
X-Google-Smtp-Source: AGHT+IGEwYocvS4Oc8/QuXzmYE3iKGFxFUycEO6PGFsqYVKEjsaZqGJWKa+BdkEF9NFvPO0tfr2ZwQ==
X-Received: by 2002:a17:907:a0c9:b0:9be:e6d4:5751 with SMTP id
 hw9-20020a170907a0c900b009bee6d45751mr2363308ejc.55.1697736064431; 
 Thu, 19 Oct 2023 10:21:04 -0700 (PDT)
Received: from [127.0.0.1] ([90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 mc8-20020a170906eb4800b009737b8d47b6sm3744024ejb.203.2023.10.19.10.21.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 10:21:04 -0700 (PDT)
Date: Thu, 19 Oct 2023 10:23:14 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: qemu-ppc@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2] hw/audio/pcspk: Inline pcspk_init()
In-Reply-To: <20231019073307.99608-1-philmd@linaro.org>
References: <20231019073307.99608-1-philmd@linaro.org>
Message-ID: <C044C8A9-952A-4F9A-8B9F-DE689A5FEF46@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



Am 19=2E Oktober 2023 07:33:07 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <=
philmd@linaro=2Eorg>:
>pcspk_init() is a legacy init function, inline and remove it=2E
>
>Since the device is realized using &error_fatal, use the same
>error for setting the "pit" link=2E
>
>Reviewed-by: Mark Cave-Ayland <mark=2Ecave-ayland@ilande=2Eco=2Euk>
>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>---
> include/hw/audio/pcspk=2Eh | 10 ----------
> hw/i386/pc=2Ec             |  4 +++-
> hw/isa/i82378=2Ec          |  5 ++++-
> hw/mips/jazz=2Ec           |  5 ++++-
> 4 files changed, 11 insertions(+), 13 deletions(-)
>
>diff --git a/include/hw/audio/pcspk=2Eh b/include/hw/audio/pcspk=2Eh
>index 9506179587=2E=2E6be75a6b86 100644
>--- a/include/hw/audio/pcspk=2Eh
>+++ b/include/hw/audio/pcspk=2Eh
>@@ -25,16 +25,6 @@
> #ifndef HW_PCSPK_H
> #define HW_PCSPK_H
>=20
>-#include "hw/isa/isa=2Eh"
>-#include "hw/qdev-properties=2Eh"
>-#include "qapi/error=2Eh"
>-
> #define TYPE_PC_SPEAKER "isa-pcspk"
>=20
>-static inline void pcspk_init(ISADevice *isadev, ISABus *bus, ISADevice =
*pit)
>-{
>-    object_property_set_link(OBJECT(isadev), "pit", OBJECT(pit), NULL);
>-    isa_realize_and_unref(isadev, bus, &error_fatal);
>-}
>-
> #endif /* HW_PCSPK_H */
>diff --git a/hw/i386/pc=2Ec b/hw/i386/pc=2Ec
>index bb3854d1d0=2E=2Ef7ee638bec 100644
>--- a/hw/i386/pc=2Ec
>+++ b/hw/i386/pc=2Ec
>@@ -1283,7 +1283,9 @@ void pc_basic_device_init(struct PCMachineState *pc=
ms,
>             /* connect PIT to output control line of the HPET */
>             qdev_connect_gpio_out(hpet, 0, qdev_get_gpio_in(DEVICE(pit),=
 0));
>         }
>-        pcspk_init(pcms->pcspk, isa_bus, pit);
>+        object_property_set_link(OBJECT(pcms->pcspk), "pit",
>+                                 OBJECT(pit), &error_fatal);
>+        isa_realize_and_unref(pcms->pcspk, isa_bus, &error_fatal);
>     }
>=20
>     /* Super I/O */
>diff --git a/hw/isa/i82378=2Ec b/hw/isa/i82378=2Ec
>index 63e0857208=2E=2E79ffbb52a0 100644
>--- a/hw/isa/i82378=2Ec
>+++ b/hw/isa/i82378=2Ec
>@@ -67,6 +67,7 @@ static void i82378_realize(PCIDevice *pci, Error **errp=
)
>     uint8_t *pci_conf;
>     ISABus *isabus;
>     ISADevice *pit;
>+    ISADevice *pcspk;
>=20
>     pci_conf =3D pci->config;
>     pci_set_word(pci_conf + PCI_COMMAND,
>@@ -102,7 +103,9 @@ static void i82378_realize(PCIDevice *pci, Error **er=
rp)
>     pit =3D i8254_pit_init(isabus, 0x40, 0, NULL);
>=20
>     /* speaker */
>-    pcspk_init(isa_new(TYPE_PC_SPEAKER), isabus, pit);
>+    pcspk =3D isa_new(TYPE_PC_SPEAKER);
>+    object_property_set_link(OBJECT(pcspk), "pit", OBJECT(pit), &error_f=
atal);
>+    isa_realize_and_unref(pcspk, isabus, &error_fatal);

Why not pass errp here? I think that was Mark's comment in v1=2E

>=20
>     /* 2 82C37 (dma) */
>     isa_create_simple(isabus, "i82374");
>diff --git a/hw/mips/jazz=2Ec b/hw/mips/jazz=2Ec
>index c32d2b0b0a=2E=2Ecdc37126c2 100644
>--- a/hw/mips/jazz=2Ec
>+++ b/hw/mips/jazz=2Ec
>@@ -177,6 +177,7 @@ static void mips_jazz_init(MachineState *machine,
>     SysBusDevice *sysbus;
>     ISABus *isa_bus;
>     ISADevice *pit;
>+    ISADevice *pcspk;
>     DriveInfo *fds[MAX_FD];
>     MemoryRegion *bios =3D g_new(MemoryRegion, 1);
>     MemoryRegion *bios2 =3D g_new(MemoryRegion, 1);
>@@ -279,7 +280,9 @@ static void mips_jazz_init(MachineState *machine,
>     isa_bus_register_input_irqs(isa_bus, i8259);
>     i8257_dma_init(isa_bus, 0);
>     pit =3D i8254_pit_init(isa_bus, 0x40, 0, NULL);
>-    pcspk_init(isa_new(TYPE_PC_SPEAKER), isa_bus, pit);
>+    pcspk =3D isa_new(TYPE_PC_SPEAKER);
>+    object_property_set_link(OBJECT(pcspk), "pit", OBJECT(pit), &error_f=
atal);
>+    isa_realize_and_unref(pcspk, isa_bus, &error_fatal);
>=20
>     /* Video card */
>     switch (jazz_model) {

