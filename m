Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B744A7D9681
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 13:24:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwKvl-00023E-29; Fri, 27 Oct 2023 07:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qwKvh-000231-Vd
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 07:23:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qwKve-0007WU-4t
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 07:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698405779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XtkO8WZjjyZXrZBboXWbOr7YFljGQLk6lQtL97ynhDY=;
 b=Vld9/37ncdxrYBoZgHEXDWX/z03wWvRiROyzNJUzp2F55H3Gh2mjs5a0kXZIPRBzJz5Ca8
 jmF+JypHTnMYs49jxTQB9IS2I06aRlC5k2bKXkIl7aVKiCoB40yNJbVDhiIaAvNclOfvIB
 Mkiwu/uqE7GUsxmdVyrwNKrQyhuoTTc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-X475vmoSM8qHvvWg5KaxeQ-1; Fri, 27 Oct 2023 07:22:42 -0400
X-MC-Unique: X475vmoSM8qHvvWg5KaxeQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-53e3bfec5bdso1445167a12.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 04:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698405761; x=1699010561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XtkO8WZjjyZXrZBboXWbOr7YFljGQLk6lQtL97ynhDY=;
 b=WFhscPnlGzmAodQ109iiAQPnApyivlnzNc7x7Byq9DzSRIk19Lsc5tSAi4TJZgyEod
 F2Rpl/iXI0X8xi/Gn6SNJ/AJNyF7Y72DE+S2XERHPaouGuEYvVXVczjYwd8wWN0aanS9
 2SaT+NjHpd6yrHEfntQw4J1g2sShvw3KdgPfU0PTDth2sYewgBhffovjtgt9np0+Ru//
 9hyRZyqWwJlyuEk6Kcp2EfmHYtUTQadDjhZOp3969kytSrG+VQa7FzKp+pQRubMykNDv
 nRRcbjrKJmoKGrAwh2JXPWUQcMwgGCt2OJzvmnZFvQQHWny/GI3w+E+Tb05Ni23tHGHp
 G8Hg==
X-Gm-Message-State: AOJu0YzGbAbfC5jzZgWekRWAKQAkJuNQC0KoxZHGDFmZR2Yy6dvMT73j
 +55lC/ynlspA4JDNJYx8i2qaTK8aN5nlmtIVUqGUv0FOmrz44KJgqFPOOgUowSJBj6YzS4NoK+G
 TSA2KK0d8jBqPgNA=
X-Received: by 2002:a50:d7cb:0:b0:53e:46b0:32be with SMTP id
 m11-20020a50d7cb000000b0053e46b032bemr1948867edj.34.1698405761093; 
 Fri, 27 Oct 2023 04:22:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtUtwrWTcRV4iIANNmMz+bZnyYLI9/mPg9MMysZkrjI9Bta8pedphMgyIeH8d+jI5xGUbrag==
X-Received: by 2002:a50:d7cb:0:b0:53e:46b0:32be with SMTP id
 m11-20020a50d7cb000000b0053e46b032bemr1948844edj.34.1698405760704; 
 Fri, 27 Oct 2023 04:22:40 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 eg25-20020a056402289900b0053dab756073sm1061150edb.84.2023.10.27.04.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 04:22:40 -0700 (PDT)
Date: Fri, 27 Oct 2023 13:22:38 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@opnsrc.net>
Cc: Bernhard Beschow <shentey@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-devel@nongnu.org, Peter Maydell
 <peter.maydell@linaro.org>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 Sergio Lopez <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PULL v2 29/53] hw/i386: Remove now redundant TYPE_ACPI_GED_X86
Message-ID: <20231027132238.26e14722@imammedo.users.ipa.redhat.com>
In-Reply-To: <7234ffe0-d617-1b0f-b61a-986724ffd20a@opnsrc.net>
References: <cover.1696477105.git.mst@redhat.com>
 <c9c8ba69d5dbe5c1c6370e1f09ebd7531509d075.1696477105.git.mst@redhat.com>
 <15e70616-6abb-63a4-17d0-820f4a254607@opnsrc.net>
 <BE6564AF-6317-49CB-91AF-C88F1D31DF4E@gmail.com>
 <7234ffe0-d617-1b0f-b61a-986724ffd20a@opnsrc.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, 21 Oct 2023 00:54:56 +0100
Salil Mehta <salil.mehta@opnsrc.net> wrote:

> Hi Bernhard,
>=20
> On 19/10/2023 11:33, Bernhard Beschow wrote:
> >=20
> >=20
> > Am 18. Oktober 2023 17:38:33 UTC schrieb Salil Mehta <salil.mehta@opnsr=
c.net>: =20
> >> Hello, =20
> >=20
> > Hi Salil,
> >  =20
> >> Can we assume that every machine type will have all the features which=
 a GED Device can multiplex present together? like will Memory and CPU Hotp=
lug makes sense for all the type of machines? =20

user (board) were supposed to opt-in by setting the events property
so only enabled events would be handled. =20

> > I can't really answer these questions -- I'm by no means an ACPI expert=
. My idea about removing TYPE_ACPI_GED_X86 really was not more than the com=
mit message says: To remove unneeded code. =20
>=20
>=20
> Sure, cleanup is not an issue.
>=20
> In fact, question is whether every machine type would be interested in=20
> initializing other code like hot-plug related initialization in the=20
> acpi_get_intfn() especially when that machine type does not supports it.
>=20
> Another question is whether every machine can without breaking other=20
> architecture or features?
>=20
>=20
> Even in your case as well some unnecessary code legs will get=20
> initialized so cleanup is not complete either - isn't it?
>=20
>=20
> For now, I will proceed with changing this for ARM and then if x86 needs=
=20
> it can either revert this patch or re-implement it as also suggested by=20
> Michael?
>=20
>=20
> >=20
> > That said, I wonder myself if the GED device could be uniformly impleme=
nted across architectures and if -- in theory -- it could be used in the pc=
-i440fx machine instead of the Frankenstein hotplug implementation in PIIX4=
. =20
>=20
>=20
> I will leave it up to x86 maintainers to answer that.
>=20
> But superficially, it looks there are some historical reasons (maybe=20
> related to legacy firmware?) because of which the switch from legacy to=20
> modern type of CPU Hotplug interface happens.

x86 can theoretically use GED as well but that will prevent
hotplug working with old guests that don't know about new-ish GED.
Hence it's not likely for pc/q35 to switch to new GED.

>=20
>=20
> Thanks
> Salil.
>=20
> >=20
> > Best regards,
> > Bernhard
> >  =20
> >>
> >> If answer is no, then shouldn't every machine type override the base G=
ED type and define it own versions of instance_init() function? AFAICS, GED=
 can multiplex non-hotplug events as well.
> >>
> >> To support CPU Htoplug on ARM platforms we are using GED but x86/micro=
vm does not supports hot-plugging and while creating TYPE_GED_DEVICE it wil=
l end up initializing CPU Hotplug regions and code as well. This is far fro=
m clean.
> >>
> >> Beside 'qtest' fails for x86/microvm machine type because 'possible_cp=
us_arch_ids' is not defined for x86/microvm so we get errors like below:
> >>
> >> stderr:
> >> qemu-system-x86_64: ../hw/acpi/cpu.c:224: cpu_hotplug_hw_init: Asserti=
on `mc->possible_cpu_arch_ids' failed.
> >> Broken pipe
> >> ../tests/qtest/libqtest.c:200: kill_qemu() detected QEMU death from si=
gnal 6 (Aborted) (core dumped)
> >>
> >> Above can be avoided if cpu_hotplug_hw_init() does not gets called for=
 x86/microvm machine.
> >>
> >> ARM can have its own version of generic_event_device_arm64.c with its =
own version of instance_init() having a call to cpu_hotplug_hw_init().
> >>
> >> Maybe I have missed something here?
> >>
> >>
> >> Many thanks
> >> Salil.
> >>
> >>
> >> On 05/10/2023 04:44, Michael S. Tsirkin wrote: =20
> >>> From: Bernhard Beschow <shentey@gmail.com>
> >>>
> >>> Now that TYPE_ACPI_GED_X86 doesn't assign AcpiDeviceIfClass::madt_cpu=
 any more
> >>> it is the same as TYPE_ACPI_GED.
> >>>
> >>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> >>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >>> Message-Id: <20230908084234.17642-6-shentey@gmail.com>
> >>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >>> ---
> >>>    include/hw/acpi/generic_event_device.h |  2 --
> >>>    hw/i386/generic_event_device_x86.c     | 27 ----------------------=
----
> >>>    hw/i386/microvm.c                      |  2 +-
> >>>    hw/i386/meson.build                    |  1 -
> >>>    4 files changed, 1 insertion(+), 31 deletions(-)
> >>>    delete mode 100644 hw/i386/generic_event_device_x86.c
> >>>
> >>> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi=
/generic_event_device.h
> >>> index d831bbd889..ba84ce0214 100644
> >>> --- a/include/hw/acpi/generic_event_device.h
> >>> +++ b/include/hw/acpi/generic_event_device.h
> >>> @@ -69,8 +69,6 @@
> >>>    #define TYPE_ACPI_GED "acpi-ged"
> >>>    OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
> >>>    -#define TYPE_ACPI_GED_X86 "acpi-ged-x86"
> >>> -
> >>>    #define ACPI_GED_EVT_SEL_OFFSET    0x0
> >>>    #define ACPI_GED_EVT_SEL_LEN       0x4
> >>>    diff --git a/hw/i386/generic_event_device_x86.c b/hw/i386/generic_=
event_device_x86.c
> >>> deleted file mode 100644
> >>> index 8fc233e1f1..0000000000
> >>> --- a/hw/i386/generic_event_device_x86.c
> >>> +++ /dev/null
> >>> @@ -1,27 +0,0 @@
> >>> -/*
> >>> - * x86 variant of the generic event device for hw reduced acpi
> >>> - *
> >>> - * This program is free software; you can redistribute it and/or mod=
ify it
> >>> - * under the terms and conditions of the GNU General Public License,
> >>> - * version 2 or later, as published by the Free Software Foundation.
> >>> - */
> >>> -
> >>> -#include "qemu/osdep.h"
> >>> -#include "hw/acpi/generic_event_device.h"
> >>> -
> >>> -static const TypeInfo acpi_ged_x86_info =3D {
> >>> -    .name          =3D TYPE_ACPI_GED_X86,
> >>> -    .parent        =3D TYPE_ACPI_GED,
> >>> -    .interfaces =3D (InterfaceInfo[]) {
> >>> -        { TYPE_HOTPLUG_HANDLER },
> >>> -        { TYPE_ACPI_DEVICE_IF },
> >>> -        { }
> >>> -    }
> >>> -};
> >>> -
> >>> -static void acpi_ged_x86_register_types(void)
> >>> -{
> >>> -    type_register_static(&acpi_ged_x86_info);
> >>> -}
> >>> -
> >>> -type_init(acpi_ged_x86_register_types)
> >>> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> >>> index 8deeb62774..b9c93039e2 100644
> >>> --- a/hw/i386/microvm.c
> >>> +++ b/hw/i386/microvm.c
> >>> @@ -204,7 +204,7 @@ static void microvm_devices_init(MicrovmMachineSt=
ate *mms)
> >>>          /* Optional and legacy devices */
> >>>        if (x86_machine_is_acpi_enabled(x86ms)) {
> >>> -        DeviceState *dev =3D qdev_new(TYPE_ACPI_GED_X86);
> >>> +        DeviceState *dev =3D qdev_new(TYPE_ACPI_GED);
> >>>            qdev_prop_set_uint32(dev, "ged-event", ACPI_GED_PWR_DOWN_E=
VT);
> >>>            sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, GED_MMIO_BASE);
> >>>            /* sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, GED_MMIO_BASE_M=
EMHP); */
> >>> diff --git a/hw/i386/meson.build b/hw/i386/meson.build
> >>> index cfdbfdcbcb..ff879069c9 100644
> >>> --- a/hw/i386/meson.build
> >>> +++ b/hw/i386/meson.build
> >>> @@ -20,7 +20,6 @@ i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx=
-epc.c','sgx.c'),
> >>>                                    if_false: files('sgx-stub.c'))
> >>>      i386_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-common.c'))
> >>> -i386_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('generic_=
event_device_x86.c'))
> >>>    i386_ss.add(when: 'CONFIG_PC', if_true: files(
> >>>      'pc.c',
> >>>      'pc_sysfw.c',
> >>> =20
>=20


