Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2489080F3D0
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:58:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD63M-0000p9-6T; Tue, 12 Dec 2023 11:56:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD63J-0000o2-He
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:56:13 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD63G-0001n1-P3
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:56:13 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-334b2ffaa3eso5182004f8f.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702400169; x=1703004969; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NBWDk8DZrRUrfIj/FZi1QqGD/m54M27q/X3YkMT5U0I=;
 b=mZHsil0TIkXfwjubgh6RqFgfE25BYaePuXkh3vN35Ii9D/1M/m2tw8CnSp1sCTReUe
 agQseOsmJDftcnMMyIXVAERPdQGItHxypuCW1RPJQy15bmb6KhsrG8gDMQcSfaa3w74/
 skjVL40LRoY/PM4/NUuXvro9+LexV5HD/oRAMsrB/0wtd5X9wErVsJPHBqUySInO5Y9s
 MIaZaU/VEktFrHFPLbRFFwPLYWQpxE7Of/2fSQYMQUy/0FS+vUO8TcthWPOO0/UM00qS
 4SbqdkQLPa04aiD7SO6n6UzNpjpRvVo1aSh2rfjN3zDBNwD3h6NIkay04XLbzS2gMWUn
 xEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702400169; x=1703004969;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NBWDk8DZrRUrfIj/FZi1QqGD/m54M27q/X3YkMT5U0I=;
 b=cQaVM/q7ase58Fig5C7ssMRhDZxUTDEdfy3oOEn1fAHMRDHkU7pkRDaLx+Ygr7cP51
 eKHDRQsBt/4bQgIm2fsldjzki2pXHam00B6qVDHA9gxzi7zzC0y7C6SZaLtckFWha4XH
 Z7gDOpringzhRZmnMXIHuEmFYTHwx1HwqoKZ55xgQMj37HJGXiZfc0WZlDPIoEi3MWtr
 YhaKM3WUS23zkAlpJ5pyzrSSizJiwKh+LJAdnAnb6c6HIPVtl3we6ryjsvdHt7n91016
 OJNYRi7z0n8ME3t2GvfuGK0T/pe30bO5IU6/QHxhY1mr2m0THzkZY3rlx/d9XqspkqPW
 Wl2w==
X-Gm-Message-State: AOJu0YwKE6elHRXE0niWYcyszm98qudTh4HX8clMSiHw8lSWNORI3Pgj
 4TkyYJvg0uzug6bbEjliCHIWvvGE0L/xUdrVx5HXeqZgDUZoJ1lN
X-Google-Smtp-Source: AGHT+IHuIelw51JSX9Gu4v4p17NNEJEh1giMq6sbZ6QocOprSjaGRocGfNzpbB1waF1/UnmWibATX8PqQ4FH3BnTOnQ=
X-Received: by 2002:a05:651c:1606:b0:2cc:1ec1:93e2 with SMTP id
 f6-20020a05651c160600b002cc1ec193e2mr3241898ljq.52.1702400148268; Tue, 12 Dec
 2023 08:55:48 -0800 (PST)
MIME-Version: 1.0
References: <20231123143813.42632-1-philmd@linaro.org>
 <20231123143813.42632-6-philmd@linaro.org>
In-Reply-To: <20231123143813.42632-6-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2023 16:55:37 +0000
Message-ID: <CAFEAcA_tzL5Z4QOWCPKMyJ2XCQ0HgkR-_Ji=vC+zEECF0yRqAQ@mail.gmail.com>
Subject: Re: [PATCH-for-9.0 v2 5/8] hw: Prefer qdev_prop_set_bit over
 object_property_set_bool for QDev
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>, Joel Stanley <joel@jms.id.au>, 
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 David Gibson <david@gibson.dropbear.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Igor Mammedov <imammedo@redhat.com>,
 qemu-ppc@nongnu.org, 
 Hao Wu <wuhaotsh@google.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Beniamino Galvani <b.galvani@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 23 Nov 2023 at 14:38, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> The QOM API is lower level than the QDev one. When an instance is
> QDev and setting the property can not fail (using &error_abort),
> prefer qdev_prop_set_bit() over object_property_set_bool().
>
> Mechanical transformation using the following coccinelle patch:
>
>   @@
>   expression o, p, v;
>   @@
>   -            object_property_set_bool(OBJECT(o), p, v, &error_abort)
>   +            qdev_prop_set_bit(DEVICE(o), p, v)
>   @@@@
>   -            object_property_set_bool(o, p, v, &error_abort)
>   +            qdev_prop_set_bit(DEVICE(o), p, v)
>
> manually adding the missing "hw/qdev-properties.h" header.
>
> In hw/arm/armsse.c we use the available 'cpudev' instead of 'cpuobj'.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

> @@ -1287,8 +1288,7 @@ void arm_load_kernel(ARMCPU *cpu, MachineState *ms,=
 struct arm_boot_info *info)
>               * CPU.
>               */
>              if (cs !=3D first_cpu) {
> -                object_property_set_bool(cpuobj, "start-powered-off", tr=
ue,
> -                                         &error_abort);
> +                qdev_prop_set_bit(DEVICE(cpuobj), "start-powered-off", t=
rue);
>              }
>          }
>      }

This makes this code look a bit weird. Currently we have a loop
which has an "Object *cpuobj" which it uses to set properties,
in both cases using the object_property_* APIs. With this change,
we do half the job using a QOM API and the other half using
a qdev API. It would be good to follow up by converting the
other property-set so we can have a local Device * instead of
the Object *.


> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index eace854335..6733652120 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -263,20 +263,13 @@ static void pc_init1(MachineState *machine,
>          size_t i;
>
>          pci_dev =3D pci_new_multifunction(-1, pcms->south_bridge);
> -        object_property_set_bool(OBJECT(pci_dev), "has-usb",
> -                                 machine_usb(machine), &error_abort);
> -        object_property_set_bool(OBJECT(pci_dev), "has-acpi",
> -                                 x86_machine_is_acpi_enabled(x86ms),
> -                                 &error_abort);
> -        object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
> -                                 &error_abort);
> -        object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
> -                                 &error_abort);
> -        qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
> -        object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
> -                                 x86_machine_is_smm_enabled(x86ms),
> -                                 &error_abort);
>          dev =3D DEVICE(pci_dev);
> +        qdev_prop_set_bit(dev, "has-usb", machine_usb(machine));
> +        qdev_prop_set_bit(dev, "has-acpi", x86_machine_is_acpi_enabled(x=
86ms));
> +        qdev_prop_set_bit(dev, "has-pic", false);
> +        qdev_prop_set_bit(dev, "has-pit", false);
> +        qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);

This line also can just use "dev".

> +        qdev_prop_set_bit(dev, "smm-enabled", x86_machine_is_smm_enabled=
(x86ms));
>          for (i =3D 0; i < ISA_NUM_IRQS; i++) {
>              qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i=
]);
>          }

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

