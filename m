Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 132D57D824C
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 14:11:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvzBt-0003v3-Ba; Thu, 26 Oct 2023 08:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qvzBi-0003r1-20
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 08:10:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qvzBS-0002oR-NJ
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 08:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698322190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F6H+3onCfFivBXil4mAPPBWz94PBKcX04SWBm0jkkRs=;
 b=VPDw59Nyu8NOgjUFzqtDd/HcOt7GeAwMFk8J5c2n3+ZY/blcFYepfIMLJrZB5pP7fRBtyY
 mp2/+oB06gAyYKPAbjwP8ggSA2en7t9TXiChm4pomubGPdwHfbOez/UNzwiYJwYNpAPTB8
 ySpUBoUV2eHvTII3pRscrBd9Oj49sJc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-6fiYY0wkOvKBUrKTBaNtqw-1; Thu, 26 Oct 2023 08:09:29 -0400
X-MC-Unique: 6fiYY0wkOvKBUrKTBaNtqw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9ae57d8b502so55769866b.2
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 05:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698322168; x=1698926968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F6H+3onCfFivBXil4mAPPBWz94PBKcX04SWBm0jkkRs=;
 b=VcE/flYcGjxhRoi9J5Uqq+DeSfP1jxsIZY2HmFvooHIeKKbHQ8ySE7D5erjtulJKgb
 4t8tdbhhHZeqUU75gQek9L6D1mzbw43+C9zopLXjJOA/zTME4uZEja0UlUUgx0jnxshX
 3guhsqSABKrEsgSRYyIK62lDXTb5fKU0atXf8MFuVE2W9QY/eM9CEy7Xo5/o10ErDN4T
 /1nBQwuukwak+spLRrLZ+8eI/QkN/qOyZiYcG7bcE5ZJGddI4+fHiSNZnrVdskVk+3S5
 T4CTdSnewx8AuJDOwuBfqPJv1tG6y5JhvcO3vBtbEVdi3gTDeUvd6SD322QwCHBlFgDO
 OZqg==
X-Gm-Message-State: AOJu0Yw58BQQMZD9Cb0WAmURP9Tlf41C10sFj6VSuFhENDzOJhsUdTXJ
 pNg33V0EGJPzxs9quG366FArApL6TT/5c9WlGZM3XedldgYL1ivOkwq5N4+ocmsr4y6orfsdpeb
 XgXQdDHirXRrBITs=
X-Received: by 2002:a17:906:4fd0:b0:9a5:874a:9745 with SMTP id
 i16-20020a1709064fd000b009a5874a9745mr15723083ejw.26.1698322168163; 
 Thu, 26 Oct 2023 05:09:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE3JW1tEa5PTar5AJZzGu8oC8BFBtTxUOjJLh6ZW5GZEOGV1xs4b1uoF8Sx2CuqKVZvgABvA==
X-Received: by 2002:a17:906:4fd0:b0:9a5:874a:9745 with SMTP id
 i16-20020a1709064fd000b009a5874a9745mr15723064ejw.26.1698322167820; 
 Thu, 26 Oct 2023 05:09:27 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 jl24-20020a17090775d800b0099315454e76sm11439457ejc.211.2023.10.26.05.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 05:09:27 -0700 (PDT)
Date: Thu, 26 Oct 2023 14:09:25 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: David Hildenbrand <david@redhat.com>, Salil Mehta
 <salil.mehta@opnsrc.net>, Alex =?UTF-8?B?QmVubsOpZQ==?=
 <alex.bennee@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [Question] x86/microvm: why has_hotpluggable_cpus = false but
 hot(ub)plug APIs exist?
Message-ID: <20231026140925.541e2b45@imammedo.users.ipa.redhat.com>
In-Reply-To: <1358aadeade14623a90284d188fbce31@huawei.com>
References: <78103368-9ea5-167b-5700-7d3d174ff564@opnsrc.net>
 <87o7gw9btp.fsf@linaro.org>
 <cbbf59ba-b7ab-b536-12ab-91a0bfc7f1c6@opnsrc.net>
 <20231024100554.3ef76ebf@imammedo.users.ipa.redhat.com>
 <f8bad7bdf7ea42b08d52970c47ea101f@huawei.com>
 <1055386d-2706-4ce2-b190-106510bee52c@redhat.com>
 <1358aadeade14623a90284d188fbce31@huawei.com>
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, 25 Oct 2023 09:54:07 +0000
Salil Mehta <salil.mehta@huawei.com> wrote:

> > From: David Hildenbrand <david@redhat.com>
> > Sent: Wednesday, October 25, 2023 10:32 AM
> > To: Salil Mehta <salil.mehta@huawei.com>; Igor Mammedov
> > <imammedo@redhat.com>; Salil Mehta <salil.mehta@opnsrc.net>
> >=20
> > On 25.10.23 11:16, Salil Mehta wrote: =20
> > > Hi Igor,
> > > =20
> > >> From: Igor Mammedov <imammedo@redhat.com>
> > >> Sent: Tuesday, October 24, 2023 9:06 AM
> > >> To: Salil Mehta <salil.mehta@opnsrc.net>
> > >>
> > >> On Wed, 18 Oct 2023 17:48:36 +0100
> > >> Salil Mehta <salil.mehta@opnsrc.net> wrote:
> > >> =20
> > >>> Hi Alex,
> > >>>
> > >>> On 18/10/2023 16:41, Alex Benn=C3=A9e wrote: =20
> > >>>>
> > >>>> Salil Mehta <salil.mehta@opnsrc.net> writes:
> > >>>> =20
> > >>>>> Hello,
> > >>>>>
> > >>>>> Came across below code excerpt in x86/microvm code and wanted to =
know
> > >>>>> why 'has_hotpluggable_cpus' flag has been set to 'false' while va=
rious
> > >>>>> hot(un)plug APIs have been defined?
> > >>>>>
> > >>>>> static void microvm_class_init(ObjectClass *oc, void *data)
> > >>>>> {
> > >>>>>       X86MachineClass *x86mc =3D X86_MACHINE_CLASS(oc);
> > >>>>>       MachineClass *mc =3D MACHINE_CLASS(oc);
> > >>>>>       HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
> > >>>>>
> > >>>>>       mc->init =3D microvm_machine_state_init;
> > >>>>>
> > >>>>>       mc->family =3D "microvm_i386";
> > >>>>>       [...]
> > >>>>>       mc->max_cpus =3D 288;
> > >>>>>       mc->has_hotpluggable_cpus =3D false;  --------> This one
> > >>>>>       [...] =20
> > >>>>
> > >>>>   From the original commit that added it:
> > >>>>
> > >>>>     It's a minimalist machine type without PCI nor ACPI support, d=
esigned
> > >>>>     for short-lived guests. microvm also establishes a baseline for
> > >>>>     benchmarking and optimizing both QEMU and guest operating syst=
ems,
> > >>>>     since it is optimized for both boot time and footprint. =20
> > >>>
> > >>>
> > >>> Agreed. It looks like ACPI is supported but neither CPU/Memory Hotp=
lug
> > >>> is supported for this minimalist machine type.
> > >>>
> > >>>
> > >>> static void microvm_devices_init(MicrovmMachineState *mms)
> > >>> {
> > >>>       const char *default_firmware;
> > >>>       X86MachineState *x86ms =3D X86_MACHINE(mms);
> > >>>
> > >>>      [...]
> > >>>
> > >>>       /* Optional and legacy devices */
> > >>>       if (x86_machine_is_acpi_enabled(x86ms)) {
> > >>>           DeviceState *dev =3D qdev_new(TYPE_ACPI_GED_X86);
> > >>>           qdev_prop_set_uint32(dev, "ged-event", ACPI_GED_PWR_DOWN_=
EVT);
> > >>>           sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, GED_MMIO_BASE);
> > >>>        /* sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, GED_MMIO_BASE_MEM=
HP); =20
> > */ =20
> > >>>
> > >>>           [...]
> > >>>
> > >>>           sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
> > >>>           x86ms->acpi_dev =3D HOTPLUG_HANDLER(dev);
> > >>>       }
> > >>>      [...]
> > >>> }
> > >>> =20
> > >>>>
> > >>>> Generally hotplug requires a dance between the VMM and the firmwar=
e to
> > >>>> properly shutdown and restart hotplug devices. The principle
> > >>>> communication mechanism for this is ACPI. =20
> > >>
> > >> firmware part in cpu/mem hoptlug usually provided by QEMU by the way=
 of
> > >> ACPI tables (which may contain AML code that handles dance with QEMU
> > >> while exposing standard interface to guest OS to handle hotplug)
> > >> =20
> > >>>
> > >>> Agreed.
> > >>> =20
> > >>>>>       /* hotplug (for cpu coldplug) */
> > >>>>>       mc->get_hotplug_handler =3D microvm_get_hotplug_handler;
> > >>>>>       hc->pre_plug =3D microvm_device_pre_plug_cb;
> > >>>>>       hc->plug =3D microvm_device_plug_cb;
> > >>>>>       hc->unplug_request =3D microvm_device_unplug_request_cb;
> > >>>>>       hc->unplug =3D microvm_device_unplug_cb; =20
> > >>>
> > >>> sorry, I also missed the definitions of the last 2 functions which =
says
> > >>> that unplug is not supported so perhaps these functions are only
> > >>> required to support cold plugging which corroborates with the comme=
nt as
> > >>> well. =20
> > >>
> > >> this function are usually used for both cold and hotplug of bus-less=
 devices.
> > >> They provide an opt-in way for board to wire up such devices (incl. =
CPU). =20
> > >
> > >
> > > Sure. I understand but microvm does not support hotplug so presence of
> > > unplug{_request} versions brought a doubt in my mind but I realized l=
ater
> > > that their definitions were empty. Cold-plug does not require unplug
> > > versions.
> > >
> > > Was there any plan to support hot-plug with microvm in future? =20
> >=20
> > At least virtio-mem for memory hotplug should be fairly straight-forward
> > to wire-up I guess. The relation to ACPI are minimal: we currently only
> > use ACPI SRAT to expose the maximum GPA range that e.g., Linux requires
> > early during boot to properly prepare for memory hotplug (size the
> > virtual memory space for the kernel accordingly). One could use
> > alternative (paravirtualized) interfaces for that. =20
>=20
> Ok. Light weight VM more in lines of Firecracker to improve boot-up times?
>=20
> Also, presence of unplug versions gives a wrong impression about code?

unplug handlers could be theoretically used to undo what (pre)plug did
during VM deconstruction. (though it's not used this way today unless
hotplug controller requested it).

What is confusing is interface naming (HotplugHandler) which is not
hotplug limited anymore.
=20
> > The question is whether any form of hotplug is "in the spirit" of micro=
vm. =20
>=20
> Understand that. BTW, was it ever made to be used with kata-containers?
>=20
> Thanks
> Salil.


