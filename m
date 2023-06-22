Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D13A739837
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:36:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCErL-0007ID-Pl; Thu, 22 Jun 2023 03:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qCErI-0007Hi-0h
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:36:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qCErG-0001wQ-2A
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687419356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z6AUNTHOY5gMv9kP1INxLyw6TYR46sCGap8pyM5dHw8=;
 b=GVgVJp1FEB5QtL90+NB/hyEw1YE4uGD62v3VFpHc9eUoUWdRZxNVhCLFbQ1M2R0fBF8p9T
 /6r0c+SxiW7WBzIk6Du4XA3Dvq6KYpMyVzuQpx6KqKvNaEYLYyssBe0QYTc5y3Tdwv9Zbd
 Y3qoTrZWRUikJeEQIC3kitMGRDATFco=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-qa-oB0I7NXGID0ILYn72NA-1; Thu, 22 Jun 2023 03:35:55 -0400
X-MC-Unique: qa-oB0I7NXGID0ILYn72NA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b466bbc5f9so42889491fa.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 00:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687419353; x=1690011353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z6AUNTHOY5gMv9kP1INxLyw6TYR46sCGap8pyM5dHw8=;
 b=LzsRvZJKiVIAr9u3SRAA4JlhAegidrDpvlyIR8vz/QIKWIerBl7DgKUwes0CF6SUg9
 swYeA55A+WKUv5GwfdJrgX39l8VC1jWQeN44ymV34k3EQoZC0n5kopnmSHa1h+OkXVmn
 kPm8kkSvy280WtUcYwQO+zCbBBrdtLyup/SVSdTkXh9ceExMGDoadcoeKtOuVblQG1Sy
 CHojnQtheop/4f604P6NLZKqNVo5za4t7uAv4pvD7kujhqQSCck1nXETD8hB7Qm/zJtV
 SXdbKijpq+p/iSGI+JDWPOM41RkyvmH8oyTW2sze7BduEBAViIVvkAKSgLF0d1WeNGt+
 zUeg==
X-Gm-Message-State: AC+VfDyKozncx5eGGCAEM1A2e4Wt+6d6dgDHyWc6Zuz4OgCxDH0fM019
 GQ/yi9OmP9M8qKSaqOEvCf7uinnTew10e10q1I4++Pdv/C4lha2PHbI/uE4jl3892FSu6ffLqof
 bs7RUw2TVdWxhTSw=
X-Received: by 2002:a2e:b0d4:0:b0:2b5:7b60:5037 with SMTP id
 g20-20020a2eb0d4000000b002b57b605037mr4994905ljl.3.1687419353772; 
 Thu, 22 Jun 2023 00:35:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4KURJxDCRREwi977sn+sm7Wqx89g80Po212CQK7txH0drKkSDPJK3Uk9IUkjEGULhQlb7Mtg==
X-Received: by 2002:a2e:b0d4:0:b0:2b5:7b60:5037 with SMTP id
 g20-20020a2eb0d4000000b002b57b605037mr4994883ljl.3.1687419353453; 
 Thu, 22 Jun 2023 00:35:53 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 n6-20020a7bcbc6000000b003f7e4d143cfsm6961114wmi.15.2023.06.22.00.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 00:35:52 -0700 (PDT)
Date: Thu, 22 Jun 2023 09:35:52 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Joel Upham <jupham125@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v1 02/23] pc/q35: Apply PCI bus BSEL property for Xen
 PCI device hotplug
Message-ID: <20230622093552.1c11a46a@imammedo.users.ipa.redhat.com>
In-Reply-To: <CADPhr0=+5Aiu7w5A0FRfrGn+94aMaF5RyhWVSHFMFXysygwBzg@mail.gmail.com>
References: <cover.1687278381.git.jupham125@gmail.com>
 <fc1a6594429e549af90037e0ba0a256680a95cf6.1687278381.git.jupham125@gmail.com>
 <20230621132757.2a951cdf@imammedo.users.ipa.redhat.com>
 <CADPhr0=+5Aiu7w5A0FRfrGn+94aMaF5RyhWVSHFMFXysygwBzg@mail.gmail.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, 21 Jun 2023 13:24:42 -0400
Joel Upham <jupham125@gmail.com> wrote:

> On Wed, Jun 21, 2023 at 7:28=E2=80=AFAM Igor Mammedov <imammedo@redhat.co=
m> wrote:
>=20
> > On Tue, 20 Jun 2023 13:24:36 -0400
> > Joel Upham <jupham125@gmail.com> wrote:
> > =20
> > > On Q35 we still need to assign BSEL property to bus(es) for PCI device
> > > add/hotplug to work.
> > > Extend acpi_set_pci_info() function to support Q35 as well. This patc=
h =20
> > adds new (trivial) =20
> > > function find_q35() which returns root PCIBus object on Q35, in a way
> > > similar to what find_i440fx does. =20
> >
> > I think patch is mostly obsolete, q35 ACPI PCI hotplug is supported in
> > upstream QEMU.
> >
> > Also see comment below.
> >
> > I make use of the find_q35() function in later patches, but I agree now=
 a =20
> majority of this patch is a bit different.

There is likely an existing alternative already. (probably introduced by AC=
PI PIC hotplug for q35)
>=20
> > >
> > > Signed-off-by: Alexey Gerasimenko <x1917x@xxxxxxxxx>
> > > Signed-off-by: Joel Upham <jupham125@gmail.com>
> > > ---
> > >  hw/acpi/pcihp.c      | 4 +++-
> > >  hw/pci-host/q35.c    | 9 +++++++++
> > >  include/hw/i386/pc.h | 3 +++
> > >  3 files changed, 15 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> > > index cdd6f775a1..f4e39d7a9c 100644
> > > --- a/hw/acpi/pcihp.c
> > > +++ b/hw/acpi/pcihp.c
> > > @@ -40,6 +40,7 @@
> > >  #include "qapi/error.h"
> > >  #include "qom/qom-qobject.h"
> > >  #include "trace.h"
> > > +#include "sysemu/xen.h"
> > >
> > >  #define ACPI_PCIHP_SIZE 0x0018
> > >  #define PCI_UP_BASE 0x0000
> > > @@ -84,7 +85,8 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaqu=
e)
> > >      bool is_bridge =3D IS_PCI_BRIDGE(br);
> > >
> > >      /* hotplugged bridges can't be described in ACPI ignore them */
> > > -    if (qbus_is_hotpluggable(BUS(bus))) { =20
> > =20
> > > +    /* Xen requires hotplugging to the root device, even on the Q35 =
=20
> > chipset */
> > pls explain what 'root device' is.
> > Why can't you use root-ports for hotplug?
> >
> > Wording may have been incorrect.  Root port is correct. This may not be=
 =20
> needed anymore,
> and may have been left over for when I was debugging PCIe hotplugging
> problems.
> I will retest and fix patch once I know more. Xen expects the PCIe device
> to be on the root port.
>=20
> I can move the function to a different patch that uses it.
>=20
> > > +    if (qbus_is_hotpluggable(BUS(bus)) || xen_enabled()) {
> > >          if (!is_bridge || (!br->hotplugged && =20
> > info->has_bridge_hotplug)) { =20
> > >              bus_bsel =3D g_malloc(sizeof *bus_bsel);
> > >
> > > diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> > > index fd18920e7f..fe5fc0f47c 100644
> > > --- a/hw/pci-host/q35.c
> > > +++ b/hw/pci-host/q35.c
> > > @@ -259,6 +259,15 @@ static void q35_host_initfn(Object *obj)
> > >                               qdev_prop_allow_set_link_before_realize=
, =20
> > 0); =20
> > >  }
> > >
> > > +PCIBus *find_q35(void)
> > > +{
> > > +    PCIHostState *s =3D OBJECT_CHECK(PCIHostState,
> > > +                                   object_resolve_path("/machine/q35=
", =20
> > NULL), =20
> > > +                                   TYPE_PCI_HOST_BRIDGE);
> > > +    return s ? s->bus : NULL;
> > > +}
> > > +
> > > +
> > >  static const TypeInfo q35_host_info =3D {
> > >      .name       =3D TYPE_Q35_HOST_DEVICE,
> > >      .parent     =3D TYPE_PCIE_HOST_BRIDGE,
> > > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > > index c661e9cc80..550f8fa221 100644
> > > --- a/include/hw/i386/pc.h
> > > +++ b/include/hw/i386/pc.h
> > > @@ -196,6 +196,9 @@ void pc_madt_cpu_entry(int uid, const CPUArchIdLi=
st =20
> > *apic_ids, =20
> > >  /* sgx.c */
> > >  void pc_machine_init_sgx_epc(PCMachineState *pcms);
> > >
> > > +/* q35.c */
> > > +PCIBus *find_q35(void);
> > > +
> > >  extern GlobalProperty pc_compat_8_0[];
> > >  extern const size_t pc_compat_8_0_len;
> > > =20
> >
> > =20


