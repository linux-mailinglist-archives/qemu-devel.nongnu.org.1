Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A80A87D96F2
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 13:51:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwLMo-0001VP-2S; Fri, 27 Oct 2023 07:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qwLMU-0001FP-St
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 07:50:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qwLMR-0007fn-MY
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 07:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698407442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=imlE0ChTRVxTf/MosWm7cza/4oMkroiwEqlZc1w19Xk=;
 b=T69PcPM9tMDliWLG3ahTn2phYB8s0ViFudMvFGQxASNtRH5zSNlJGRQuB1TCs0CRaEF4Vj
 4R12Po8yf4PuXE9ttDJ9XqnDYfzrdwfsuSEh2BM4KmfANpVxnPcfMvCwmDeDC4YSrhY+AX
 fYDwfTAr3BJVTlRt4Bg76mjUn42IS1s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-xW6lJDbmPvuZ7p-Aem74oA-1; Fri, 27 Oct 2023 07:50:36 -0400
X-MC-Unique: xW6lJDbmPvuZ7p-Aem74oA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9a62adedadbso140474066b.1
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 04:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698407435; x=1699012235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=imlE0ChTRVxTf/MosWm7cza/4oMkroiwEqlZc1w19Xk=;
 b=P3Z2xVDlNX4lAogp2nzy8Q3L9xO6ay+6xGpLWPvu1+EokmX0XYWHVRUJt7qtVY0dTh
 H6IZJKXX2i/jQVNEvboXh2i/1lOkmaTa4SaQQyAdO1Y9GN7waTRqYlrNBtZPFlL50MeS
 SmaDRPD/oNfzmMc/r3F2op5Jd8OKQhceqessW086sCdtPk/91VgFImfJjbu1zl9cxCla
 E+imtUFp+h1esJ6sbdjPIcTymrCUYQeB7Y5Bo/rcmC9APTTYw/lKhnoqGrTaGtntPzzD
 dx39YGxo8WxlHMywv5kaqpk5FQVDop4QAFhAYtA6U9azBdXtAg0UfbSWEcJDnUIfJ1eG
 GUew==
X-Gm-Message-State: AOJu0YyzD4Yec/PlWwF8ZBhAK/1fJDMajC4uWRZn2MFJHUGp2+BTbWMM
 mJL/MLBYj8gAVif96vXORKPu/jgYABrDpJrowI44ezH1mC61jofLl18uwzWJFELtMb9sEjJrv1t
 FJxkaTRne7/uC05k=
X-Received: by 2002:a17:907:1004:b0:9be:39a4:b440 with SMTP id
 ox4-20020a170907100400b009be39a4b440mr1757291ejb.76.1698407435193; 
 Fri, 27 Oct 2023 04:50:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC0SjWBSIF60yhVS7YpvdnSPauewkiB3E6enpaY7UMVV0/nKEia5glfj1IpqUGVsmGKaX3iA==
X-Received: by 2002:a17:907:1004:b0:9be:39a4:b440 with SMTP id
 ox4-20020a170907100400b009be39a4b440mr1757268ejb.76.1698407434816; 
 Fri, 27 Oct 2023 04:50:34 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 w17-20020a17090652d100b009c46445fcc7sm1103589ejn.33.2023.10.27.04.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 04:50:34 -0700 (PDT)
Date: Fri, 27 Oct 2023 13:50:33 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@opnsrc.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Peter
 Maydell <peter.maydell@linaro.org>, Bernhard Beschow <shentey@gmail.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>, Ani
 Sinha <anisinha@redhat.com>
Subject: Re: [PULL v2 29/53] hw/i386: Remove now redundant TYPE_ACPI_GED_X86
Message-ID: <20231027135033.07d5b871@imammedo.users.ipa.redhat.com>
In-Reply-To: <15e70616-6abb-63a4-17d0-820f4a254607@opnsrc.net>
References: <cover.1696477105.git.mst@redhat.com>
 <c9c8ba69d5dbe5c1c6370e1f09ebd7531509d075.1696477105.git.mst@redhat.com>
 <15e70616-6abb-63a4-17d0-820f4a254607@opnsrc.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 18 Oct 2023 18:38:33 +0100
Salil Mehta <salil.mehta@opnsrc.net> wrote:

> Hello,
> Can we assume that every machine type will have all the features which a=
=20
> GED Device can multiplex present together? like will Memory and CPU=20
> Hotplug makes sense for all the type of machines?
>=20
> If answer is no, then shouldn't every machine type override the base GED=
=20
> type and define it own versions of instance_init() function? AFAICS, GED=
=20
> can multiplex non-hotplug events as well.
>=20
> To support CPU Htoplug on ARM platforms we are using GED but x86/microvm=
=20
> does not supports hot-plugging and while creating TYPE_GED_DEVICE it=20
> will end up initializing CPU Hotplug regions and code as well. This is=20
> far from clean.
>=20
> Beside 'qtest' fails for x86/microvm machine type because=20
> 'possible_cpus_arch_ids' is not defined for x86/microvm so we get errors=
=20
> like below:
>=20
> stderr:
> qemu-system-x86_64: ../hw/acpi/cpu.c:224: cpu_hotplug_hw_init: Assertion=
=20
> `mc->possible_cpu_arch_ids' failed.
> Broken pipe
> ../tests/qtest/libqtest.c:200: kill_qemu() detected QEMU death from=20
> signal 6 (Aborted) (core dumped)
>=20
> Above can be avoided if cpu_hotplug_hw_init() does not gets called for=20
> x86/microvm machine.

cpu_hotplug_hw_init() should not be called at initfn time,
but rather at realize time.

>=20
> ARM can have its own version of generic_event_device_arm64.c with its=20
> own version of instance_init() having a call to cpu_hotplug_hw_init().

lets try to avoid that for now.

>=20
> Maybe I have missed something here?
>=20
>=20
> Many thanks
> Salil.
>=20
>=20
> On 05/10/2023 04:44, Michael S. Tsirkin wrote:
> > From: Bernhard Beschow <shentey@gmail.com>
> >=20
> > Now that TYPE_ACPI_GED_X86 doesn't assign AcpiDeviceIfClass::madt_cpu a=
ny more
> > it is the same as TYPE_ACPI_GED.
> >=20
> > Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Message-Id: <20230908084234.17642-6-shentey@gmail.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   include/hw/acpi/generic_event_device.h |  2 --
> >   hw/i386/generic_event_device_x86.c     | 27 --------------------------
> >   hw/i386/microvm.c                      |  2 +-
> >   hw/i386/meson.build                    |  1 -
> >   4 files changed, 1 insertion(+), 31 deletions(-)
> >   delete mode 100644 hw/i386/generic_event_device_x86.c
> >=20
> > diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/g=
eneric_event_device.h
> > index d831bbd889..ba84ce0214 100644
> > --- a/include/hw/acpi/generic_event_device.h
> > +++ b/include/hw/acpi/generic_event_device.h
> > @@ -69,8 +69,6 @@
> >   #define TYPE_ACPI_GED "acpi-ged"
> >   OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
> >  =20
> > -#define TYPE_ACPI_GED_X86 "acpi-ged-x86"
> > -
> >   #define ACPI_GED_EVT_SEL_OFFSET    0x0
> >   #define ACPI_GED_EVT_SEL_LEN       0x4
> >  =20
> > diff --git a/hw/i386/generic_event_device_x86.c b/hw/i386/generic_event=
_device_x86.c
> > deleted file mode 100644
> > index 8fc233e1f1..0000000000
> > --- a/hw/i386/generic_event_device_x86.c
> > +++ /dev/null
> > @@ -1,27 +0,0 @@
> > -/*
> > - * x86 variant of the generic event device for hw reduced acpi
> > - *
> > - * This program is free software; you can redistribute it and/or modif=
y it
> > - * under the terms and conditions of the GNU General Public License,
> > - * version 2 or later, as published by the Free Software Foundation.
> > - */
> > -
> > -#include "qemu/osdep.h"
> > -#include "hw/acpi/generic_event_device.h"
> > -
> > -static const TypeInfo acpi_ged_x86_info =3D {
> > -    .name          =3D TYPE_ACPI_GED_X86,
> > -    .parent        =3D TYPE_ACPI_GED,
> > -    .interfaces =3D (InterfaceInfo[]) {
> > -        { TYPE_HOTPLUG_HANDLER },
> > -        { TYPE_ACPI_DEVICE_IF },
> > -        { }
> > -    }
> > -};
> > -
> > -static void acpi_ged_x86_register_types(void)
> > -{
> > -    type_register_static(&acpi_ged_x86_info);
> > -}
> > -
> > -type_init(acpi_ged_x86_register_types)
> > diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> > index 8deeb62774..b9c93039e2 100644
> > --- a/hw/i386/microvm.c
> > +++ b/hw/i386/microvm.c
> > @@ -204,7 +204,7 @@ static void microvm_devices_init(MicrovmMachineStat=
e *mms)
> >  =20
> >       /* Optional and legacy devices */
> >       if (x86_machine_is_acpi_enabled(x86ms)) {
> > -        DeviceState *dev =3D qdev_new(TYPE_ACPI_GED_X86);
> > +        DeviceState *dev =3D qdev_new(TYPE_ACPI_GED);
> >           qdev_prop_set_uint32(dev, "ged-event", ACPI_GED_PWR_DOWN_EVT);
> >           sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, GED_MMIO_BASE);
> >           /* sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, GED_MMIO_BASE_MEMH=
P); */
> > diff --git a/hw/i386/meson.build b/hw/i386/meson.build
> > index cfdbfdcbcb..ff879069c9 100644
> > --- a/hw/i386/meson.build
> > +++ b/hw/i386/meson.build
> > @@ -20,7 +20,6 @@ i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-e=
pc.c','sgx.c'),
> >                                   if_false: files('sgx-stub.c'))
> >  =20
> >   i386_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-common.c'))
> > -i386_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('generic_ev=
ent_device_x86.c'))
> >   i386_ss.add(when: 'CONFIG_PC', if_true: files(
> >     'pc.c',
> >     'pc_sysfw.c',
> >  =20
>=20


