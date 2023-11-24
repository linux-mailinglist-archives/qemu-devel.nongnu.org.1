Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 997B57F6EF9
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 09:55:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6RwM-0000aF-IW; Fri, 24 Nov 2023 03:53:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r6RwI-0000Za-UK
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 03:53:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r6RwC-00069b-Tj
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 03:53:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700816003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QpZLoA1Yp3BpSIq7Vg0mNJhT6k5y3Avb0lGT7TS3uLk=;
 b=HSsQTqAh7GxjfTzq+1eOP+ihaDXXqux2/hNvDhTRgAYS4h1T1KNAuSRvjwbIYKlq/n27fx
 uqoAPpfoZZOJkw7OyAWeTQ6eh6i+ZxXY1TMG3pnsxFHZHC5ibl/f2bTb5VtM4NGuwoyVGB
 NN1S18DmiZHE0anZbiPtixMGLp7eZgw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-DrJT9qIuP8imJ4gqYBVYwA-1; Fri, 24 Nov 2023 03:53:21 -0500
X-MC-Unique: DrJT9qIuP8imJ4gqYBVYwA-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5c19a0a2fbfso1682346a12.2
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 00:53:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700816001; x=1701420801;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QpZLoA1Yp3BpSIq7Vg0mNJhT6k5y3Avb0lGT7TS3uLk=;
 b=QAS7TK2bB3DZ88jS62splJAQ/445jVGboaU3yTZaYP9lQFvwwGksAxGpGUMQhGbA3s
 dtCVpexbf5HldwQPnYU8Ej4TkXJia3gJmGQ6q/lMAqltpMxxjjcbRKW1EjKQO9ZxIy9T
 +h7UyhKlo5zpQow8io3FsWRI/IOq7dhTmaO2N5XhFos+nzip5tSJA99F0AyCbbwp9NFh
 8VVAtOcuyigcPhdtxEln6hpxUKDfbY4YtbulkL9X5GnsrHBtMZ25HIsovTPFVl5TSInM
 2ppW+5v+jLSi0WrxLl9NJclHvhcoVB8TeiFpyAjRAokgSVH01rI7X4WwtL21ED/5ngRd
 KEfg==
X-Gm-Message-State: AOJu0YzoN/66hi9MWuEUUsSKOAcH1UUf3t+QSmSMzGe5uyrBObtMlNT7
 5XSFbHheE39zHS/VH4EqZTpLxQrSsLr7JHKAnT5TqsqdN8uZ76dugCUHs0vTYApkLNjY4thxt8m
 E8HlwAYuo5PtNU10=
X-Received: by 2002:a17:902:e84f:b0:1cc:4a47:1fe5 with SMTP id
 t15-20020a170902e84f00b001cc4a471fe5mr2358056plg.59.1700816000597; 
 Fri, 24 Nov 2023 00:53:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKE3HaaP7cn/JFDt3hGHlOWkcNPKjB8PijL/ga9dGSeaP6dipDQ1Nbqb6IWfNHhWGAPwGqEw==
X-Received: by 2002:a17:902:e84f:b0:1cc:4a47:1fe5 with SMTP id
 t15-20020a170902e84f00b001cc4a471fe5mr2358036plg.59.1700816000046; 
 Fri, 24 Nov 2023 00:53:20 -0800 (PST)
Received: from smtpclient.apple ([115.96.136.90])
 by smtp.gmail.com with ESMTPSA id
 h7-20020a170902748700b001c5dea67c26sm2656419pll.233.2023.11.24.00.53.10
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 24 Nov 2023 00:53:19 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH-for-9.0 v2 5/8] hw: Prefer qdev_prop_set_bit over
 object_property_set_bool for QDev
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20231123143813.42632-6-philmd@linaro.org>
Date: Fri, 24 Nov 2023 14:22:59 +0530
Cc: Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm@nongnu.org,
 Alistair Francis <alistair@alistair23.me>, Joel Stanley <joel@jms.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Igor Mammedov <imammedo@redhat.com>,
 qemu-ppc@nongnu.org, Hao Wu <wuhaotsh@google.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <40C51DEA-D556-4B97-A142-E49A32F97BF2@redhat.com>
References: <20231123143813.42632-1-philmd@linaro.org>
 <20231123143813.42632-6-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



> On 23-Nov-2023, at 8:08=E2=80=AFPM, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> The QOM API is lower level than the QDev one. When an instance is
> QDev and setting the property can not fail (using &error_abort),
> prefer qdev_prop_set_bit() over object_property_set_bool().
>=20
> Mechanical transformation using the following coccinelle patch:
>=20
>  @@
>  expression o, p, v;
>  @@
>  -            object_property_set_bool(OBJECT(o), p, v, &error_abort)
>  +            qdev_prop_set_bit(DEVICE(o), p, v)
>  @@@@
>  -            object_property_set_bool(o, p, v, &error_abort)
>  +            qdev_prop_set_bit(DEVICE(o), p, v)
>=20
> manually adding the missing "hw/qdev-properties.h" header.
>=20
> In hw/arm/armsse.c we use the available 'cpudev' instead of 'cpuobj'.
>=20
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> hw/acpi/cpu_hotplug.c               |  7 +++----
> hw/acpi/ich9.c                      |  4 ++--
> hw/acpi/piix4.c                     |  4 ++--

For the acpi bits,
Reviewed-by: Ani Sinha <anisinha@redhat.com>

> hw/arm/armsse.c                     |  3 +--
> hw/arm/armv7m.c                     |  3 +--
> hw/arm/aspeed_ast2400.c             |  3 +--
> hw/arm/aspeed_ast2600.c             |  9 +++------
> hw/arm/bcm2835_peripherals.c        |  3 +--
> hw/arm/bcm2836.c                    |  4 ++--
> hw/arm/boot.c                       |  4 ++--
> hw/arm/fsl-imx25.c                  |  3 +--
> hw/arm/fsl-imx31.c                  |  3 +--
> hw/arm/fsl-imx6.c                   | 12 ++++--------
> hw/arm/fsl-imx6ul.c                 |  8 ++++----
> hw/arm/fsl-imx7.c                   | 10 ++++------
> hw/arm/npcm7xx.c                    |  9 +++------
> hw/arm/xlnx-versal.c                |  9 +++------
> hw/arm/xlnx-zynqmp.c                |  9 +++------
> hw/core/bus.c                       |  2 +-
> hw/core/qdev.c                      |  2 +-
> hw/i386/pc_piix.c                   | 19 ++++++-------------
> hw/microblaze/petalogix_ml605_mmu.c |  5 ++---
> hw/microblaze/xlnx-zynqmp-pmu.c     | 18 +++++++-----------
> hw/mips/cps.c                       |  3 +--
> hw/ppc/e500.c                       |  3 +--
> hw/ppc/spapr_pci.c                  |  3 +--
> hw/rx/rx-gdbsim.c                   |  4 ++--
> hw/sparc/sun4m.c                    |  3 +--
> 28 files changed, 64 insertions(+), 105 deletions(-)
>=20
> diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
> index 634bbecb31..1338c037b5 100644
> --- a/hw/acpi/cpu_hotplug.c
> +++ b/hw/acpi/cpu_hotplug.c
> @@ -12,6 +12,7 @@
> #include "qemu/osdep.h"
> #include "hw/acpi/cpu_hotplug.h"
> #include "qapi/error.h"
> +#include "hw/qdev-properties.h"
> #include "hw/core/cpu.h"
> #include "hw/i386/pc.h"
> #include "hw/pci/pci.h"
> @@ -41,8 +42,7 @@ static void cpu_status_write(void *opaque, hwaddr =
addr, uint64_t data,
>      */
>     if (addr =3D=3D 0 && data =3D=3D 0) {
>         AcpiCpuHotplug *cpus =3D opaque;
> -        object_property_set_bool(cpus->device, "cpu-hotplug-legacy", =
false,
> -                                 &error_abort);
> +        qdev_prop_set_bit(DEVICE(cpus->device), "cpu-hotplug-legacy", =
false);
>     }
> }
>=20
> @@ -66,8 +66,7 @@ static void acpi_set_cpu_present_bit(AcpiCpuHotplug =
*g, CPUState *cpu)
>=20
>     cpu_id =3D k->get_arch_id(cpu);
>     if ((cpu_id / 8) >=3D ACPI_GPE_PROC_LEN) {
> -        object_property_set_bool(g->device, "cpu-hotplug-legacy", =
false,
> -                                 &error_abort);
> +        qdev_prop_set_bit(DEVICE(g->device), "cpu-hotplug-legacy", =
false);
>         return;
>     }
>=20
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index 25e2c7243e..64b00673fe 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -30,6 +30,7 @@
> #include "hw/pci/pci.h"
> #include "migration/vmstate.h"
> #include "qemu/timer.h"
> +#include "hw/qdev-properties.h"
> #include "hw/core/cpu.h"
> #include "sysemu/reset.h"
> #include "sysemu/runstate.h"
> @@ -197,8 +198,7 @@ static bool vmstate_test_use_cpuhp(void *opaque)
> static int vmstate_cpuhp_pre_load(void *opaque)
> {
>     ICH9LPCPMRegs *s =3D opaque;
> -    Object *obj =3D OBJECT(s->gpe_cpu.device);
> -    object_property_set_bool(obj, "cpu-hotplug-legacy", false, =
&error_abort);
> +    qdev_prop_set_bit(DEVICE(s->gpe_cpu.device), =
"cpu-hotplug-legacy", false);
>     return 0;
> }
>=20
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index dd523d2e4c..215929ac6a 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -203,8 +203,8 @@ static bool vmstate_test_use_cpuhp(void *opaque)
>=20
> static int vmstate_cpuhp_pre_load(void *opaque)
> {
> -    Object *obj =3D OBJECT(opaque);
> -    object_property_set_bool(obj, "cpu-hotplug-legacy", false, =
&error_abort);
> +    DeviceState *dev =3D DEVICE(opaque);
> +    qdev_prop_set_bit(dev, "cpu-hotplug-legacy", false);
>     return 0;
> }
>=20
> diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
> index 4672df180f..546b15e658 100644
> --- a/hw/arm/armsse.c
> +++ b/hw/arm/armsse.c
> @@ -1022,8 +1022,7 @@ static void armsse_realize(DeviceState *dev, =
Error **errp)
>          * later if necessary.
>          */
>         if (extract32(info->cpuwait_rst, i, 1)) {
> -            object_property_set_bool(cpuobj, "start-powered-off", =
true,
> -                                     &error_abort);
> +            qdev_prop_set_bit(cpudev, "start-powered-off", true);
>         }
>         if (!s->cpu_fpu[i]) {
>             if (!object_property_set_bool(cpuobj, "vfp", false, errp)) =
{
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index cbaebe9bf8..3a6d72b0f3 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -328,8 +328,7 @@ static void armv7m_realize(DeviceState *dev, Error =
**errp)
>             return;
>         }
>     }
> -    object_property_set_bool(OBJECT(s->cpu), "start-powered-off",
> -                             s->start_powered_off, &error_abort);
> +    qdev_prop_set_bit(DEVICE(s->cpu), "start-powered-off", =
s->start_powered_off);
>=20
>     /*
>      * Real M-profile hardware can be configured with a different =
number of
> diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
> index a4334c81b8..4a247bfcbb 100644
> --- a/hw/arm/aspeed_ast2400.c
> +++ b/hw/arm/aspeed_ast2400.c
> @@ -420,8 +420,7 @@ static void aspeed_ast2400_soc_realize(DeviceState =
*dev, Error **errp)
>=20
>     /* Net */
>     for (i =3D 0; i < sc->macs_num; i++) {
> -        object_property_set_bool(OBJECT(&s->ftgmac100[i]), "aspeed", =
true,
> -                                 &error_abort);
> +        qdev_prop_set_bit(DEVICE(&s->ftgmac100[i]), "aspeed", true);
>         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), errp)) {
>             return;
>         }
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index b965fbab5e..5ec8ad73cd 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -317,10 +317,8 @@ static void =
aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>=20
>         object_property_set_int(OBJECT(&a->cpu[i]), "cntfrq", =
1125000000,
>                                 &error_abort);
> -        object_property_set_bool(OBJECT(&a->cpu[i]), "neon", false,
> -                                &error_abort);
> -        object_property_set_bool(OBJECT(&a->cpu[i]), "vfp-d32", =
false,
> -                                &error_abort);
> +        qdev_prop_set_bit(DEVICE(&a->cpu[i]), "neon", false);
> +        qdev_prop_set_bit(DEVICE(&a->cpu[i]), "vfp-d32", false);
>         object_property_set_link(OBJECT(&a->cpu[i]), "memory",
>                                  OBJECT(s->memory), &error_abort);
>=20
> @@ -500,8 +498,7 @@ static void aspeed_soc_ast2600_realize(DeviceState =
*dev, Error **errp)
>=20
>     /* Net */
>     for (i =3D 0; i < sc->macs_num; i++) {
> -        object_property_set_bool(OBJECT(&s->ftgmac100[i]), "aspeed", =
true,
> -                                 &error_abort);
> +        qdev_prop_set_bit(DEVICE(&s->ftgmac100[i]), "aspeed", true);
>         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), errp)) {
>             return;
>         }
> diff --git a/hw/arm/bcm2835_peripherals.c =
b/hw/arm/bcm2835_peripherals.c
> index 0233038b95..c07ca8817b 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -303,8 +303,7 @@ static void =
bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
>                              &error_abort);
>     object_property_set_uint(OBJECT(&s->sdhci), "capareg",
>                              BCM2835_SDHC_CAPAREG, &error_abort);
> -    object_property_set_bool(OBJECT(&s->sdhci), =
"pending-insert-quirk", true,
> -                             &error_abort);
> +    qdev_prop_set_bit(DEVICE(&s->sdhci), "pending-insert-quirk", =
true);
>     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp)) {
>         return;
>     }
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index b0674a22a6..1fdc3be6bb 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -135,8 +135,8 @@ static void bcm2836_realize(DeviceState *dev, =
Error **errp)
>                                 bc->peri_base, &error_abort);
>=20
>         /* start powered off if not enabled */
> -        object_property_set_bool(OBJECT(&s->cpu[n].core), =
"start-powered-off",
> -                                 n >=3D s->enabled_cpus, =
&error_abort);
> +        qdev_prop_set_bit(DEVICE(&s->cpu[n].core), =
"start-powered-off",
> +                          n >=3D s->enabled_cpus);
>=20
>         if (!qdev_realize(DEVICE(&s->cpu[n].core), NULL, errp)) {
>             return;
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 84ea6a807a..ebed887e5e 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -12,6 +12,7 @@
> #include "qemu/error-report.h"
> #include "qapi/error.h"
> #include <libfdt.h>
> +#include "hw/qdev-properties.h"
> #include "hw/arm/boot.h"
> #include "hw/arm/linux-boot-if.h"
> #include "sysemu/kvm.h"
> @@ -1287,8 +1288,7 @@ void arm_load_kernel(ARMCPU *cpu, MachineState =
*ms, struct arm_boot_info *info)
>              * CPU.
>              */
>             if (cs !=3D first_cpu) {
> -                object_property_set_bool(cpuobj, "start-powered-off", =
true,
> -                                         &error_abort);
> +                qdev_prop_set_bit(DEVICE(cpuobj), =
"start-powered-off", true);
>             }
>         }
>     }
> diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
> index 9aabbf7f58..fc6a7c8a8b 100644
> --- a/hw/arm/fsl-imx25.c
> +++ b/hw/arm/fsl-imx25.c
> @@ -272,8 +272,7 @@ static void fsl_imx25_realize(DeviceState *dev, =
Error **errp)
>     }
>=20
>     /* Watchdog */
> -    object_property_set_bool(OBJECT(&s->wdt), "pretimeout-support", =
true,
> -                             &error_abort);
> +    qdev_prop_set_bit(DEVICE(&s->wdt), "pretimeout-support", true);
>     sysbus_realize(SYS_BUS_DEVICE(&s->wdt), &error_abort);
>     sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt), 0, FSL_IMX25_WDT_ADDR);
>     sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt), 0,
> diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
> index def27bb913..71f50ca802 100644
> --- a/hw/arm/fsl-imx31.c
> +++ b/hw/arm/fsl-imx31.c
> @@ -171,8 +171,7 @@ static void fsl_imx31_realize(DeviceState *dev, =
Error **errp)
>             { FSL_IMX31_GPIO3_ADDR, FSL_IMX31_GPIO3_IRQ }
>         };
>=20
> -        object_property_set_bool(OBJECT(&s->gpio[i]), "has-edge-sel", =
false,
> -                                 &error_abort);
> +        qdev_prop_set_bit(DEVICE(&s->gpio[i]), "has-edge-sel", =
false);
>         if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), errp)) {
>             return;
>         }
> diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
> index 7dc42cbfe6..17c399a37e 100644
> --- a/hw/arm/fsl-imx6.c
> +++ b/hw/arm/fsl-imx6.c
> @@ -128,8 +128,7 @@ static void fsl_imx6_realize(DeviceState *dev, =
Error **errp)
>=20
>         /* All CPU but CPU 0 start in power off mode */
>         if (i) {
> -            object_property_set_bool(OBJECT(&s->cpu[i]), =
"start-powered-off",
> -                                     true, &error_abort);
> +            qdev_prop_set_bit(DEVICE(&s->cpu[i]), =
"start-powered-off", true);
>         }
>=20
>         if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
> @@ -288,10 +287,8 @@ static void fsl_imx6_realize(DeviceState *dev, =
Error **errp)
>             },
>         };
>=20
> -        object_property_set_bool(OBJECT(&s->gpio[i]), "has-edge-sel", =
true,
> -                                 &error_abort);
> -        object_property_set_bool(OBJECT(&s->gpio[i]), =
"has-upper-pin-irq",
> -                                 true, &error_abort);
> +        qdev_prop_set_bit(DEVICE(&s->gpio[i]), "has-edge-sel", true);
> +        qdev_prop_set_bit(DEVICE(&s->gpio[i]), "has-upper-pin-irq", =
true);
>         if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), errp)) {
>             return;
>         }
> @@ -412,8 +409,7 @@ static void fsl_imx6_realize(DeviceState *dev, =
Error **errp)
>             FSL_IMX6_WDOG2_IRQ,
>         };
>=20
> -        object_property_set_bool(OBJECT(&s->wdt[i]), =
"pretimeout-support",
> -                                 true, &error_abort);
> +        qdev_prop_set_bit(DEVICE(&s->wdt[i]), "pretimeout-support", =
true);
>         sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), &error_abort);
>=20
>         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0, =
FSL_IMX6_WDOGn_ADDR[i]);
> diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
> index e37b69a5e1..4f4f2a6f41 100644
> --- a/hw/arm/fsl-imx6ul.c
> +++ b/hw/arm/fsl-imx6ul.c
> @@ -410,8 +410,8 @@ static void fsl_imx6ul_realize(DeviceState *dev, =
Error **errp)
>      * and we have to set all properties before calling =
sysbus_realize().
>      */
>     for (i =3D 0; i < FSL_IMX6UL_NUM_ETHS; i++) {
> -        object_property_set_bool(OBJECT(&s->eth[i]), "phy-connected",
> -                                 s->phy_connected[i], &error_abort);
> +        qdev_prop_set_bit(DEVICE(&s->eth[i]), "phy-connected",
> +                          s->phy_connected[i]);
>         /*
>          * If the MDIO bus on this controller is not connected, assume =
the
>          * other controller provides support for it.
> @@ -542,8 +542,8 @@ static void fsl_imx6ul_realize(DeviceState *dev, =
Error **errp)
>             FSL_IMX6UL_WDOG3_IRQ,
>         };
>=20
> -        object_property_set_bool(OBJECT(&s->wdt[i]), =
"pretimeout-support",
> -                                 true, &error_abort);
> +        qdev_prop_set_bit(DEVICE(&s->wdt[i]), "pretimeout-support",
> +                          true);
>         sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), &error_abort);
>=20
>         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0,
> diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
> index 474cfdc87c..3138ffeb08 100644
> --- a/hw/arm/fsl-imx7.c
> +++ b/hw/arm/fsl-imx7.c
> @@ -192,8 +192,7 @@ static void fsl_imx7_realize(DeviceState *dev, =
Error **errp)
>              * Secondary CPUs start in powered-down state (and can be
>              * powered up via the SRC system reset controller)
>              */
> -            object_property_set_bool(o, "start-powered-off", true,
> -                                     &error_abort);
> +            qdev_prop_set_bit(DEVICE(o), "start-powered-off", true);
>         }
>=20
>         qdev_realize(DEVICE(o), NULL, &error_abort);
> @@ -424,8 +423,8 @@ static void fsl_imx7_realize(DeviceState *dev, =
Error **errp)
>      * and we have to set all properties before calling =
sysbus_realize().
>      */
>     for (i =3D 0; i < FSL_IMX7_NUM_ETHS; i++) {
> -        object_property_set_bool(OBJECT(&s->eth[i]), "phy-connected",
> -                                 s->phy_connected[i], &error_abort);
> +        qdev_prop_set_bit(DEVICE(&s->eth[i]), "phy-connected",
> +                          s->phy_connected[i]);
>         /*
>          * If the MDIO bus on this controller is not connected, assume =
the
>          * other controller provides support for it.
> @@ -513,8 +512,7 @@ static void fsl_imx7_realize(DeviceState *dev, =
Error **errp)
>             FSL_IMX7_WDOG4_IRQ,
>         };
>=20
> -        object_property_set_bool(OBJECT(&s->wdt[i]), =
"pretimeout-support",
> -                                 true, &error_abort);
> +        qdev_prop_set_bit(DEVICE(&s->wdt[i]), "pretimeout-support", =
true);
>         sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), &error_abort);
>=20
>         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0, =
FSL_IMX7_WDOGn_ADDR[i]);
> diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
> index 15ff21d047..7022df3cfa 100644
> --- a/hw/arm/npcm7xx.c
> +++ b/hw/arm/npcm7xx.c
> @@ -478,12 +478,10 @@ static void npcm7xx_realize(DeviceState *dev, =
Error **errp)
>                                 &error_abort);
>         object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
>                                 NPCM7XX_GIC_CPU_IF_ADDR, =
&error_abort);
> -        object_property_set_bool(OBJECT(&s->cpu[i]), "reset-hivecs", =
true,
> -                                 &error_abort);
> +        qdev_prop_set_bit(DEVICE(&s->cpu[i]), "reset-hivecs", true);
>=20
>         /* Disable security extensions. */
> -        object_property_set_bool(OBJECT(&s->cpu[i]), "has_el3", =
false,
> -                                 &error_abort);
> +        qdev_prop_set_bit(DEVICE(&s->cpu[i]), "has_el3", false);
>=20
>         if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
>             return;
> @@ -613,8 +611,7 @@ static void npcm7xx_realize(DeviceState *dev, =
Error **errp)
>     }
>=20
>     /* USB Host */
> -    object_property_set_bool(OBJECT(&s->ehci), "companion-enable", =
true,
> -                             &error_abort);
> +    qdev_prop_set_bit(DEVICE(&s->ehci), "companion-enable", true);
>     sysbus_realize(SYS_BUS_DEVICE(&s->ehci), &error_abort);
>     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci), 0, NPCM7XX_EHCI_BA);
>     sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci), 0,
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 9600551c44..e3b730f5f5 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -48,8 +48,7 @@ static void versal_create_apu_cpus(Versal *s)
>         obj =3D OBJECT(&s->fpd.apu.cpu[i]);
>         if (i) {
>             /* Secondary CPUs start in powered-down state */
> -            object_property_set_bool(obj, "start-powered-off", true,
> -                                     &error_abort);
> +            qdev_prop_set_bit(DEVICE(obj), "start-powered-off", =
true);
>         }
>=20
>         object_property_set_int(obj, "core-count", =
ARRAY_SIZE(s->fpd.apu.cpu),
> @@ -150,8 +149,7 @@ static void versal_create_rpu_cpus(Versal *s)
>                                 "rpu-cpu[*]", &s->lpd.rpu.cpu[i],
>                                 XLNX_VERSAL_RCPU_TYPE);
>         obj =3D OBJECT(&s->lpd.rpu.cpu[i]);
> -        object_property_set_bool(obj, "start-powered-off", true,
> -                                 &error_abort);
> +        qdev_prop_set_bit(DEVICE(obj), "start-powered-off", true);
>=20
>         object_property_set_int(obj, "mp-affinity", 0x100 | i, =
&error_abort);
>         object_property_set_int(obj, "core-count", =
ARRAY_SIZE(s->lpd.rpu.cpu),
> @@ -536,8 +534,7 @@ static void versal_create_ospi(Versal *s, qemu_irq =
*pic)
>                             &s->pmc.iou.ospi.dma_src,
>                             TYPE_XLNX_CSU_DMA);
>=20
> -    object_property_set_bool(OBJECT(&s->pmc.iou.ospi.dma_src), =
"is-dst",
> -                             false, &error_abort);
> +    qdev_prop_set_bit(DEVICE(&s->pmc.iou.ospi.dma_src), "is-dst", =
false);
>=20
>     object_property_set_link(OBJECT(&s->pmc.iou.ospi.dma_src),
>                             "dma", OBJECT(mr_dac), &error_abort);
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 5905a33015..f3ca3a7527 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -237,14 +237,12 @@ static void xlnx_zynqmp_create_rpu(MachineState =
*ms, XlnxZynqMPState *s,
>             /*
>              * Secondary CPUs start in powered-down state.
>              */
> -            object_property_set_bool(OBJECT(&s->rpu_cpu[i]),
> -                                     "start-powered-off", true, =
&error_abort);
> +            qdev_prop_set_bit(DEVICE(&s->rpu_cpu[i]), =
"start-powered-off", true);
>         } else {
>             s->boot_cpu_ptr =3D &s->rpu_cpu[i];
>         }
>=20
> -        object_property_set_bool(OBJECT(&s->rpu_cpu[i]), =
"reset-hivecs", true,
> -                                 &error_abort);
> +        qdev_prop_set_bit(DEVICE(&s->rpu_cpu[i]), "reset-hivecs", =
true);
>         if (!qdev_realize(DEVICE(&s->rpu_cpu[i]), NULL, errp)) {
>             return;
>         }
> @@ -518,8 +516,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, =
Error **errp)
>             /*
>              * Secondary CPUs start in powered-down state.
>              */
> -            object_property_set_bool(OBJECT(&s->apu_cpu[i]),
> -                                     "start-powered-off", true, =
&error_abort);
> +            qdev_prop_set_bit(DEVICE(&s->apu_cpu[i]), =
"start-powered-off", true);
>         } else {
>             s->boot_cpu_ptr =3D &s->apu_cpu[i];
>         }
> diff --git a/hw/core/bus.c b/hw/core/bus.c
> index c7831b5293..a24ebe5886 100644
> --- a/hw/core/bus.c
> +++ b/hw/core/bus.c
> @@ -176,7 +176,7 @@ bool qbus_realize(BusState *bus, Error **errp)
>=20
> void qbus_unrealize(BusState *bus)
> {
> -    object_property_set_bool(OBJECT(bus), "realized", false, =
&error_abort);
> +    qdev_prop_set_bit(DEVICE(bus), "realized", false);
> }
>=20
> static bool bus_get_realized(Object *obj, Error **errp)
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 43d863b0c5..f4aa99ed77 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -303,7 +303,7 @@ bool qdev_realize_and_unref(DeviceState *dev, =
BusState *bus, Error **errp)
>=20
> void qdev_unrealize(DeviceState *dev)
> {
> -    object_property_set_bool(OBJECT(dev), "realized", false, =
&error_abort);
> +    qdev_prop_set_bit(dev, "realized", false);
> }
>=20
> static int qdev_assert_realized_properly_cb(Object *obj, void *opaque)
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index eace854335..6733652120 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -263,20 +263,13 @@ static void pc_init1(MachineState *machine,
>         size_t i;
>=20
>         pci_dev =3D pci_new_multifunction(-1, pcms->south_bridge);
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
>         dev =3D DEVICE(pci_dev);
> +        qdev_prop_set_bit(dev, "has-usb", machine_usb(machine));
> +        qdev_prop_set_bit(dev, "has-acpi", =
x86_machine_is_acpi_enabled(x86ms));
> +        qdev_prop_set_bit(dev, "has-pic", false);
> +        qdev_prop_set_bit(dev, "has-pit", false);
> +        qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
> +        qdev_prop_set_bit(dev, "smm-enabled", =
x86_machine_is_smm_enabled(x86ms));
>         for (i =3D 0; i < ISA_NUM_IRQS; i++) {
>             qdev_connect_gpio_out_named(dev, "isa-irqs", i, =
x86ms->gsi[i]);
>         }
> diff --git a/hw/microblaze/petalogix_ml605_mmu.c =
b/hw/microblaze/petalogix_ml605_mmu.c
> index fb7889cf67..626f9b0b56 100644
> --- a/hw/microblaze/petalogix_ml605_mmu.c
> +++ b/hw/microblaze/petalogix_ml605_mmu.c
> @@ -88,9 +88,8 @@ petalogix_ml605_init(MachineState *machine)
>      * root instructions
>      */
>     object_property_set_int(OBJECT(cpu), "use-fpu", 1, &error_abort);
> -    object_property_set_bool(OBJECT(cpu), "dcache-writeback", true,
> -                             &error_abort);
> -    object_property_set_bool(OBJECT(cpu), "endianness", true, =
&error_abort);
> +    qdev_prop_set_bit(DEVICE(cpu), "dcache-writeback", true);
> +    qdev_prop_set_bit(DEVICE(cpu), "endianness", true);
>     qdev_realize(DEVICE(cpu), NULL, &error_abort);
>=20
>     /* Attach emulated BRAM through the LMB.  */
> diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c =
b/hw/microblaze/xlnx-zynqmp-pmu.c
> index 5a2016672a..19cc5efee3 100644
> --- a/hw/microblaze/xlnx-zynqmp-pmu.c
> +++ b/hw/microblaze/xlnx-zynqmp-pmu.c
> @@ -18,6 +18,7 @@
> #include "qemu/osdep.h"
> #include "qapi/error.h"
> #include "exec/address-spaces.h"
> +#include "hw/qdev-properties.h"
> #include "hw/boards.h"
> #include "cpu.h"
> #include "boot.h"
> @@ -79,19 +80,14 @@ static void =
xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
>=20
>     object_property_set_uint(OBJECT(&s->cpu), "base-vectors",
>                              XLNX_ZYNQMP_PMU_ROM_ADDR, &error_abort);
> -    object_property_set_bool(OBJECT(&s->cpu), "use-stack-protection", =
true,
> -                             &error_abort);
> +    qdev_prop_set_bit(DEVICE(&s->cpu), "use-stack-protection", true);
>     object_property_set_uint(OBJECT(&s->cpu), "use-fpu", 0, =
&error_abort);
>     object_property_set_uint(OBJECT(&s->cpu), "use-hw-mul", 0, =
&error_abort);
> -    object_property_set_bool(OBJECT(&s->cpu), "use-barrel", true,
> -                             &error_abort);
> -    object_property_set_bool(OBJECT(&s->cpu), "use-msr-instr", true,
> -                             &error_abort);
> -    object_property_set_bool(OBJECT(&s->cpu), "use-pcmp-instr", true,
> -                             &error_abort);
> -    object_property_set_bool(OBJECT(&s->cpu), "use-mmu", false, =
&error_abort);
> -    object_property_set_bool(OBJECT(&s->cpu), "endianness", true,
> -                             &error_abort);
> +    qdev_prop_set_bit(DEVICE(&s->cpu), "use-barrel", true);
> +    qdev_prop_set_bit(DEVICE(&s->cpu), "use-msr-instr", true);
> +    qdev_prop_set_bit(DEVICE(&s->cpu), "use-pcmp-instr", true);
> +    qdev_prop_set_bit(DEVICE(&s->cpu), "use-mmu", false);
> +    qdev_prop_set_bit(DEVICE(&s->cpu), "endianness", true);
>     object_property_set_str(OBJECT(&s->cpu), "version", "8.40.b",
>                             &error_abort);
>     object_property_set_uint(OBJECT(&s->cpu), "pvr", 0, &error_abort);
> diff --git a/hw/mips/cps.c b/hw/mips/cps.c
> index 4f12e23ab5..ee2a8d5563 100644
> --- a/hw/mips/cps.c
> +++ b/hw/mips/cps.c
> @@ -78,8 +78,7 @@ static void mips_cps_realize(DeviceState *dev, Error =
**errp)
>         CPUMIPSState *env =3D &cpu->env;
>=20
>         /* All VPs are halted on reset. Leave powering up to CPC. */
> -        object_property_set_bool(OBJECT(cpu), "start-powered-off", =
true,
> -                                 &error_abort);
> +        qdev_prop_set_bit(DEVICE(cpu), "start-powered-off", true);
>=20
>         /* All cores use the same clock tree */
>         qdev_connect_clock_in(DEVICE(cpu), "clk-in", s->clock);
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 566f1200dd..a63d48c512 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -954,8 +954,7 @@ void ppce500_init(MachineState *machine)
>          * Secondary CPU starts in halted state for now. Needs to =
change
>          * when implementing non-kernel boot.
>          */
> -        object_property_set_bool(OBJECT(cs), "start-powered-off", i =
!=3D 0,
> -                                 &error_abort);
> +        qdev_prop_set_bit(DEVICE(cs), "start-powered-off", i !=3D 0);
>         qdev_realize_and_unref(DEVICE(cs), NULL, &error_fatal);
>=20
>         if (!firstenv) {
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 6760823e13..266cf6c9e6 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2490,8 +2490,7 @@ static int spapr_switch_one_vga(DeviceState =
*dev, void *opaque)
>         || object_dynamic_cast(OBJECT(dev), "secondary-vga")
>         || object_dynamic_cast(OBJECT(dev), "bochs-display")
>         || object_dynamic_cast(OBJECT(dev), "virtio-vga")) {
> -        object_property_set_bool(OBJECT(dev), =
"big-endian-framebuffer", be,
> -                                 &error_abort);
> +        qdev_prop_set_bit(dev, "big-endian-framebuffer", be);
>     }
>     return 0;
> }
> diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
> index 47c17026c7..53d3d560c8 100644
> --- a/hw/rx/rx-gdbsim.c
> +++ b/hw/rx/rx-gdbsim.c
> @@ -21,6 +21,7 @@
> #include "qemu/error-report.h"
> #include "qemu/guest-random.h"
> #include "qapi/error.h"
> +#include "hw/qdev-properties.h"
> #include "hw/loader.h"
> #include "hw/rx/rx62n.h"
> #include "sysemu/qtest.h"
> @@ -103,8 +104,7 @@ static void rx_gdbsim_init(MachineState *machine)
>                              &error_abort);
>     object_property_set_uint(OBJECT(&s->mcu), "xtal-frequency-hz",
>                              rxc->xtal_freq_hz, &error_abort);
> -    object_property_set_bool(OBJECT(&s->mcu), "load-kernel",
> -                             kernel_filename !=3D NULL, =
&error_abort);
> +    qdev_prop_set_bit(DEVICE(&s->mcu), "load-kernel", kernel_filename =
!=3D NULL);
>=20
>     if (!kernel_filename) {
>         if (machine->firmware) {
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 64895aebe3..d631d555d8 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -803,8 +803,7 @@ static void cpu_devinit(const char *cpu_type, =
unsigned int id,
>     env =3D &cpu->env;
>=20
>     qemu_register_reset(sun4m_cpu_reset, cpu);
> -    object_property_set_bool(OBJECT(cpu), "start-powered-off", id !=3D =
0,
> -                             &error_abort);
> +    qdev_prop_set_bit(DEVICE(cpu), "start-powered-off", id !=3D 0);
>     qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal);
>     cpu_sparc_set_id(env, id);
>     *cpu_irqs =3D qemu_allocate_irqs(cpu_set_irq, cpu, MAX_PILS);
> --=20
> 2.41.0
>=20


