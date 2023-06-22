Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E21E673A78E
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 19:45:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCOMQ-0004u8-Rg; Thu, 22 Jun 2023 13:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1qCNXK-0006B6-QH
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:51:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1qCNXJ-0007Tr-5h
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687452716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RyGUXf2y2npvJIVM+sqNdYVWZoIRbslQEpPOc5iBsw4=;
 b=Qn0HMJ4x1qmRIbTbSY9DfpHX/OXp0MlJHO4UtVux+0Vpd3cyWcGWde0SEDIWXRov3mXXkX
 LQWBqHsmIYCtJ220awg5wQB/CI3EwDUxcXIocKW2lDx1/rt3ndE88c/OV7FZMlvGsTwGqA
 +o+GKt7pMkqPJ32gvvqPkQ/j+PSz6j4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-ClIC02VJOc6dfhNcFCSbfA-1; Thu, 22 Jun 2023 12:51:53 -0400
X-MC-Unique: ClIC02VJOc6dfhNcFCSbfA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4ec817fb123so5205448e87.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 09:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687452711; x=1690044711;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RyGUXf2y2npvJIVM+sqNdYVWZoIRbslQEpPOc5iBsw4=;
 b=Kr1XKnVtjggelU4xo+D4EZw6gVoEzLIOcxYkFYwLyNdS7ipO0H7F7tDKHetzFuJoIv
 /MDojFAO0DDqc79g1Mmz5hbt5auMBtFE0JvGlpXW+lozmgXMKlzAKssDY4kPHQE3VGHg
 lAigpG7CIdC5zSkUlctYu6VPH0RCzu14ejZP/RJ1f3Hj0MlJkifmDwRj6ojmx6S3xh5e
 sbxKu1a/+j1aD3cb8VA5vPc+OpP2UNMSdx6AKweAInKfrlTLA2CxEfafS/IbL4t7Giqe
 h4pUJpT8fA3RLCkAbK6fxCOJ5SLEPqHYW8ZNX+zMQqK3AH/NevFOqKMqCMA4oPFa+K2y
 xwaw==
X-Gm-Message-State: AC+VfDxbXTb2z7S9oH6nrMiYbCXjDlg6Ai0imhsRA3+68ENswvi2gbmc
 a63HaxXgyNaE97B3rlNSw4wyDuX3WiaALRKQSieWABAMtk6vLwJ8pCX+8RdOZD0VZ2k9bOsP4BP
 HVge+TUQwqJx693lUQhg7+lzi//ut4Qc=
X-Received: by 2002:ac2:5bdd:0:b0:4f8:7897:55e6 with SMTP id
 u29-20020ac25bdd000000b004f8789755e6mr6498959lfn.45.1687452711500; 
 Thu, 22 Jun 2023 09:51:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5AjeRSu0VTEZFatqsR7c28GbgJbXksmcIjSEZe+m2xFppC/+C6e9tUoZyNVdiSVfd1eNEnYRBy5EuSVy8kY5c=
X-Received: by 2002:ac2:5bdd:0:b0:4f8:7897:55e6 with SMTP id
 u29-20020ac25bdd000000b004f8789755e6mr6498942lfn.45.1687452711119; Thu, 22
 Jun 2023 09:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687278381.git.jupham125@gmail.com>
 <fc1a6594429e549af90037e0ba0a256680a95cf6.1687278381.git.jupham125@gmail.com>
 <20230621132757.2a951cdf@imammedo.users.ipa.redhat.com>
 <CADPhr0=+5Aiu7w5A0FRfrGn+94aMaF5RyhWVSHFMFXysygwBzg@mail.gmail.com>
 <20230622093552.1c11a46a@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230622093552.1c11a46a@imammedo.users.ipa.redhat.com>
From: Julia Suvorova <jsuvorov@redhat.com>
Date: Thu, 22 Jun 2023 18:51:39 +0200
Message-ID: <CAMDeoFX_m4j1f_r4Jgy=QhUu6Trg6n7kJ_mk_rGNDysTbkkKrg@mail.gmail.com>
Subject: Re: [PATCH v1 02/23] pc/q35: Apply PCI bus BSEL property for Xen PCI
 device hotplug
To: Igor Mammedov <imammedo@redhat.com>
Cc: Joel Upham <jupham125@gmail.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsuvorov@redhat.com;
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
X-Mailman-Approved-At: Thu, 22 Jun 2023 13:44:45 -0400
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

On Thu, Jun 22, 2023 at 9:36=E2=80=AFAM Igor Mammedov <imammedo@redhat.com>=
 wrote:
>
> On Wed, 21 Jun 2023 13:24:42 -0400
> Joel Upham <jupham125@gmail.com> wrote:
>
> > On Wed, Jun 21, 2023 at 7:28=E2=80=AFAM Igor Mammedov <imammedo@redhat.=
com> wrote:
> >
> > > On Tue, 20 Jun 2023 13:24:36 -0400
> > > Joel Upham <jupham125@gmail.com> wrote:
> > >
> > > > On Q35 we still need to assign BSEL property to bus(es) for PCI dev=
ice
> > > > add/hotplug to work.
> > > > Extend acpi_set_pci_info() function to support Q35 as well. This pa=
tch
> > > adds new (trivial)
> > > > function find_q35() which returns root PCIBus object on Q35, in a w=
ay
> > > > similar to what find_i440fx does.
> > >
> > > I think patch is mostly obsolete, q35 ACPI PCI hotplug is supported i=
n
> > > upstream QEMU.
> > >
> > > Also see comment below.
> > >
> > > I make use of the find_q35() function in later patches, but I agree n=
ow a
> > majority of this patch is a bit different.
>
> There is likely an existing alternative already. (probably introduced by =
ACPI PIC hotplug for q35)

There is a similar function acpi_get_i386_pci_host() in hw/i386/acpi-build.=
c

Best regards, Julia Suvorova.

> >
> > > >
> > > > Signed-off-by: Alexey Gerasimenko <x1917x@xxxxxxxxx>
> > > > Signed-off-by: Joel Upham <jupham125@gmail.com>
> > > > ---
> > > >  hw/acpi/pcihp.c      | 4 +++-
> > > >  hw/pci-host/q35.c    | 9 +++++++++
> > > >  include/hw/i386/pc.h | 3 +++
> > > >  3 files changed, 15 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> > > > index cdd6f775a1..f4e39d7a9c 100644
> > > > --- a/hw/acpi/pcihp.c
> > > > +++ b/hw/acpi/pcihp.c
> > > > @@ -40,6 +40,7 @@
> > > >  #include "qapi/error.h"
> > > >  #include "qom/qom-qobject.h"
> > > >  #include "trace.h"
> > > > +#include "sysemu/xen.h"
> > > >
> > > >  #define ACPI_PCIHP_SIZE 0x0018
> > > >  #define PCI_UP_BASE 0x0000
> > > > @@ -84,7 +85,8 @@ static void *acpi_set_bsel(PCIBus *bus, void *opa=
que)
> > > >      bool is_bridge =3D IS_PCI_BRIDGE(br);
> > > >
> > > >      /* hotplugged bridges can't be described in ACPI ignore them *=
/
> > > > -    if (qbus_is_hotpluggable(BUS(bus))) {
> > >
> > > > +    /* Xen requires hotplugging to the root device, even on the Q3=
5
> > > chipset */
> > > pls explain what 'root device' is.
> > > Why can't you use root-ports for hotplug?
> > >
> > > Wording may have been incorrect.  Root port is correct. This may not =
be
> > needed anymore,
> > and may have been left over for when I was debugging PCIe hotplugging
> > problems.
> > I will retest and fix patch once I know more. Xen expects the PCIe devi=
ce
> > to be on the root port.
> >
> > I can move the function to a different patch that uses it.
> >
> > > > +    if (qbus_is_hotpluggable(BUS(bus)) || xen_enabled()) {
> > > >          if (!is_bridge || (!br->hotplugged &&
> > > info->has_bridge_hotplug)) {
> > > >              bus_bsel =3D g_malloc(sizeof *bus_bsel);
> > > >
> > > > diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> > > > index fd18920e7f..fe5fc0f47c 100644
> > > > --- a/hw/pci-host/q35.c
> > > > +++ b/hw/pci-host/q35.c
> > > > @@ -259,6 +259,15 @@ static void q35_host_initfn(Object *obj)
> > > >                               qdev_prop_allow_set_link_before_reali=
ze,
> > > 0);
> > > >  }
> > > >
> > > > +PCIBus *find_q35(void)
> > > > +{
> > > > +    PCIHostState *s =3D OBJECT_CHECK(PCIHostState,
> > > > +                                   object_resolve_path("/machine/q=
35",
> > > NULL),
> > > > +                                   TYPE_PCI_HOST_BRIDGE);
> > > > +    return s ? s->bus : NULL;
> > > > +}
> > > > +
> > > > +
> > > >  static const TypeInfo q35_host_info =3D {
> > > >      .name       =3D TYPE_Q35_HOST_DEVICE,
> > > >      .parent     =3D TYPE_PCIE_HOST_BRIDGE,
> > > > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > > > index c661e9cc80..550f8fa221 100644
> > > > --- a/include/hw/i386/pc.h
> > > > +++ b/include/hw/i386/pc.h
> > > > @@ -196,6 +196,9 @@ void pc_madt_cpu_entry(int uid, const CPUArchId=
List
> > > *apic_ids,
> > > >  /* sgx.c */
> > > >  void pc_machine_init_sgx_epc(PCMachineState *pcms);
> > > >
> > > > +/* q35.c */
> > > > +PCIBus *find_q35(void);
> > > > +
> > > >  extern GlobalProperty pc_compat_8_0[];
> > > >  extern const size_t pc_compat_8_0_len;
> > > >
> > >
> > >
>
>


