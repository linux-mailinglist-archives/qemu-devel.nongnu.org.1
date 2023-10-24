Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6877D4946
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 10:07:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvCQN-00081u-F2; Tue, 24 Oct 2023 04:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qvCQL-00081j-U1
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:06:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qvCQK-0004T4-70
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698134759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RzCEEPlJxvdB03wt0nw2RqpUrwgp681cbOZkg1Ofq9A=;
 b=Q0sowGBb3yuG/SlOfm8f1g6APqAoH2meocLB1c9txM49NgE4hTrsFUgscwN2uCi1j4Zhsq
 a9ktCLxl99MIIvBKJpQDxVxf9/B96Ojy7hgGyWWiLXwYgUzRfojqVmLcdcfJloHXir+yoi
 TmWZ7W6v5+7WzjpgwS98mzjH3+Bo7h8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-J5dEqkDAPdqqHrDNYYeVkw-1; Tue, 24 Oct 2023 04:05:57 -0400
X-MC-Unique: J5dEqkDAPdqqHrDNYYeVkw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-997c891a88dso251277266b.3
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 01:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698134756; x=1698739556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RzCEEPlJxvdB03wt0nw2RqpUrwgp681cbOZkg1Ofq9A=;
 b=UvQ+Dlp3SoAXclVfVThglpRGHrcWHfCTZI+fkr3FNpst4cz5DtE5fLcuNS2GQVrTK0
 sVaXlymBO/6c2nXrYMmSoh78mhQdvc3hN31MSZILg0xLePjeIAibR1SGT6vST9z8a/Te
 jmtul4MwEKk4qbxTP0p0ISQtGg9c21SvNuFfKJ/wJ6roH4mJd5bbsu1UdszUTHvKjiCT
 3AhXXkVyXkdV0j+IVjyesIX1ExycqBwQMTZHZpgziU1hMMzqenvehFLchcURMlOdrwjS
 JFId5l0CFAFzn5J+rfkC2L2Vzo22W4pWBJizXf0gHEuPz5qbV/Xw2j3f+VXbYTO46oJZ
 MzWw==
X-Gm-Message-State: AOJu0YydYPlGCZlXjHBVRnjjeDfNlcNGt+nxE1C5TanLe5EJ6/G+gNjL
 XVZ4nqN3kBCRw68OYwDHOcrwLLpkYQY6Uz2SYLxFWI5Myu9Asr7ZqBJKhynP0J5/WgZp5PmxpoI
 WvfWJK+dpfSprxIU=
X-Received: by 2002:a17:907:3e21:b0:9c0:eb3e:b070 with SMTP id
 hp33-20020a1709073e2100b009c0eb3eb070mr10226250ejc.69.1698134756297; 
 Tue, 24 Oct 2023 01:05:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSMpYtbjY4UrOJCHiEmjFVT72e+M6X7Cn6vSssvV9eaF6zgomvp8Mmxuh+llPUYs1EnqWEJQ==
X-Received: by 2002:a17:907:3e21:b0:9c0:eb3e:b070 with SMTP id
 hp33-20020a1709073e2100b009c0eb3eb070mr10226226ejc.69.1698134755881; 
 Tue, 24 Oct 2023 01:05:55 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 o24-20020a1709064f9800b0099cc3c7ace2sm7943464eju.140.2023.10.24.01.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 01:05:55 -0700 (PDT)
Date: Tue, 24 Oct 2023 10:05:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@opnsrc.net>
Cc: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, "mst@redhat.com"
 <mst@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "david@redhat.com>> David Hildenbrand" <david@redhat.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
 qemu-devel@nongnu.org
Subject: Re: [Question] x86/microvm: why has_hotpluggable_cpus = false but
 hot(ub)plug APIs exist?
Message-ID: <20231024100554.3ef76ebf@imammedo.users.ipa.redhat.com>
In-Reply-To: <cbbf59ba-b7ab-b536-12ab-91a0bfc7f1c6@opnsrc.net>
References: <78103368-9ea5-167b-5700-7d3d174ff564@opnsrc.net>
 <87o7gw9btp.fsf@linaro.org>
 <cbbf59ba-b7ab-b536-12ab-91a0bfc7f1c6@opnsrc.net>
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

On Wed, 18 Oct 2023 17:48:36 +0100
Salil Mehta <salil.mehta@opnsrc.net> wrote:

> Hi Alex,
>=20
> On 18/10/2023 16:41, Alex Benn=C3=A9e wrote:
> >=20
> > Salil Mehta <salil.mehta@opnsrc.net> writes:
> >  =20
> >> Hello,
> >>
> >> Came across below code excerpt in x86/microvm code and wanted to know
> >> why 'has_hotpluggable_cpus' flag has been set to 'false' while various
> >> hot(un)plug APIs have been defined?
> >>
> >> static void microvm_class_init(ObjectClass *oc, void *data)
> >> {
> >>      X86MachineClass *x86mc =3D X86_MACHINE_CLASS(oc);
> >>      MachineClass *mc =3D MACHINE_CLASS(oc);
> >>      HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
> >>
> >>      mc->init =3D microvm_machine_state_init;
> >>
> >>      mc->family =3D "microvm_i386";
> >>      [...]
> >>      mc->max_cpus =3D 288;
> >>      mc->has_hotpluggable_cpus =3D false;  --------> This one
> >>      [...] =20
> >=20
> >  From the original commit that added it:
> >=20
> >    It's a minimalist machine type without PCI nor ACPI support, designed
> >    for short-lived guests. microvm also establishes a baseline for
> >    benchmarking and optimizing both QEMU and guest operating systems,
> >    since it is optimized for both boot time and footprint. =20
>=20
>=20
> Agreed. It looks like ACPI is supported but neither CPU/Memory Hotplug=20
> is supported for this minimalist machine type.
>=20
>=20
> static void microvm_devices_init(MicrovmMachineState *mms)
> {
>      const char *default_firmware;
>      X86MachineState *x86ms =3D X86_MACHINE(mms);
>=20
>     [...]
>=20
>      /* Optional and legacy devices */
>      if (x86_machine_is_acpi_enabled(x86ms)) {
>          DeviceState *dev =3D qdev_new(TYPE_ACPI_GED_X86);
>          qdev_prop_set_uint32(dev, "ged-event", ACPI_GED_PWR_DOWN_EVT);
>          sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, GED_MMIO_BASE);
>       /* sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, GED_MMIO_BASE_MEMHP); */
>=20
>          [...]
>=20
>          sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
>          x86ms->acpi_dev =3D HOTPLUG_HANDLER(dev);
>      }
>     [...]
> }
>=20
>=20
>=20
> >=20
> > Generally hotplug requires a dance between the VMM and the firmware to
> > properly shutdown and restart hotplug devices. The principle
> > communication mechanism for this is ACPI. =20

firmware part in cpu/mem hoptlug usually provided by QEMU by the way of
ACPI tables (which may contain AML code that handles dance with QEMU
while exposing standard interface to guest OS to handle hotplug)

>=20
> Agreed.
>=20
>=20
>=20
> >  =20
> >>
> >>      /* hotplug (for cpu coldplug) */
> >>      mc->get_hotplug_handler =3D microvm_get_hotplug_handler;
> >>      hc->pre_plug =3D microvm_device_pre_plug_cb;
> >>      hc->plug =3D microvm_device_plug_cb;
> >>      hc->unplug_request =3D microvm_device_unplug_request_cb;
> >>      hc->unplug =3D microvm_device_unplug_cb; =20
>=20
> sorry, I also missed the definitions of the last 2 functions which says=20
> that unplug is not supported so perhaps these functions are only=20
> required to support cold plugging which corroborates with the comment as=
=20
> well.

this function are usually used for both cold and hotplug of bus-less device=
s.
They provide an opt-in way for board to wire up such devices (incl. CPU).

>=20
> Thanks
> Salil.
>=20


