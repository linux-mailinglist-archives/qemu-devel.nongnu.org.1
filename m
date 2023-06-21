Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38586738D08
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 19:25:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC1Zl-0007KF-52; Wed, 21 Jun 2023 13:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qC1Zi-0007IG-6C
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 13:24:58 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qC1Zg-00075K-55
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 13:24:57 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-518b69d5b5dso8314516a12.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 10:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687368294; x=1689960294;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vfYmEv9Y+0GmJHHZYXzB4Y5EMoyMgbwxf9enJrzlZHU=;
 b=eHJNC1O7xnVb1m/+9aP2+km9Ob2rm7Xv1ZJ9y91YlUBw56IL3eYe/Y6bps/XPBrHsR
 aEWuZl0/TZ2zBGbFCIFBX8p9ZMmfAqAjupQlH9Yh6UtHKzIjJ/cnJXj9X0ugZbjeBU+n
 eT6b0/0grRNQUmrhA20peOToIZotMb+JzHDgM5sgsdwizrqBhTBrQW5dkdN1Gwp2QsGK
 cH4b6gDcOxTNwN0dC+LkBa8vKaANqYEDvRxGb/tu84PyIWyR7j0RjyCjbn4IxDxRMLzI
 aLnwiUyYNf24/PbrT0UKvprp6UWcqSak6OQiZUsbCamIa4i0xLFoe8edTiTzEeYeUzie
 VebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687368294; x=1689960294;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vfYmEv9Y+0GmJHHZYXzB4Y5EMoyMgbwxf9enJrzlZHU=;
 b=giFNfln87IrjXKgJmb+HaUwfQhVt+4uWXAWnyKV5FJHDwt0a8WGfwMtNoXZNVSA+70
 zjYWSQthrxjV2unZNB0vC26Nb6ApmAf89q0NpI64rv4LN/xeIUGRDJUxCgun9Fmg9D+v
 xHRrGQqz18/dG0QfEq5ykvIzYEEg7jyaVBu7w4DxbdP9joo2cX94V5BP4hjfQGSsFi8r
 TuPEMCBZLcuY9beLs259Fx/0xC9KOz/BPkslkUu5rHttNlJw+cZoHEFB3eHT3b9R/zUb
 9K7LO0lRBKsZlkHgPq4fTVJv4iz8GbdDJnmLgZkRBhEALcSpVPOIKUta+YEAmtQ0KG38
 HZvw==
X-Gm-Message-State: AC+VfDwVn2kzS/DrXXqN4vLiT6A3m6J9bIcutLAGLqy4H9llQgt1duA4
 dWxfARgb2y6bECVIX2jDfDIOdhP1WJfE31+DshA=
X-Google-Smtp-Source: ACHHUZ64fKhv9mdo34olAFg4mLKHHsi8d/d+NmIj1jm7h9D13OcBA2+W8JLKx6//TfZsec55ebN8ZTgQknPpNwRbG0M=
X-Received: by 2002:aa7:d1d7:0:b0:51b:cd07:d101 with SMTP id
 g23-20020aa7d1d7000000b0051bcd07d101mr4107045edp.7.1687368294211; Wed, 21 Jun
 2023 10:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687278381.git.jupham125@gmail.com>
 <fc1a6594429e549af90037e0ba0a256680a95cf6.1687278381.git.jupham125@gmail.com>
 <20230621132757.2a951cdf@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230621132757.2a951cdf@imammedo.users.ipa.redhat.com>
From: Joel Upham <jupham125@gmail.com>
Date: Wed, 21 Jun 2023 13:24:42 -0400
Message-ID: <CADPhr0=+5Aiu7w5A0FRfrGn+94aMaF5RyhWVSHFMFXysygwBzg@mail.gmail.com>
Subject: Re: [PATCH v1 02/23] pc/q35: Apply PCI bus BSEL property for Xen PCI
 device hotplug
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000c8276a05fea70b06"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=jupham125@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000c8276a05fea70b06
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 7:28=E2=80=AFAM Igor Mammedov <imammedo@redhat.com>=
 wrote:

> On Tue, 20 Jun 2023 13:24:36 -0400
> Joel Upham <jupham125@gmail.com> wrote:
>
> > On Q35 we still need to assign BSEL property to bus(es) for PCI device
> > add/hotplug to work.
> > Extend acpi_set_pci_info() function to support Q35 as well. This patch
> adds new (trivial)
> > function find_q35() which returns root PCIBus object on Q35, in a way
> > similar to what find_i440fx does.
>
> I think patch is mostly obsolete, q35 ACPI PCI hotplug is supported in
> upstream QEMU.
>
> Also see comment below.
>
> I make use of the find_q35() function in later patches, but I agree now a
majority of this patch is a bit different.

> >
> > Signed-off-by: Alexey Gerasimenko <x1917x@xxxxxxxxx>
> > Signed-off-by: Joel Upham <jupham125@gmail.com>
> > ---
> >  hw/acpi/pcihp.c      | 4 +++-
> >  hw/pci-host/q35.c    | 9 +++++++++
> >  include/hw/i386/pc.h | 3 +++
> >  3 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> > index cdd6f775a1..f4e39d7a9c 100644
> > --- a/hw/acpi/pcihp.c
> > +++ b/hw/acpi/pcihp.c
> > @@ -40,6 +40,7 @@
> >  #include "qapi/error.h"
> >  #include "qom/qom-qobject.h"
> >  #include "trace.h"
> > +#include "sysemu/xen.h"
> >
> >  #define ACPI_PCIHP_SIZE 0x0018
> >  #define PCI_UP_BASE 0x0000
> > @@ -84,7 +85,8 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
> >      bool is_bridge =3D IS_PCI_BRIDGE(br);
> >
> >      /* hotplugged bridges can't be described in ACPI ignore them */
> > -    if (qbus_is_hotpluggable(BUS(bus))) {
>
> > +    /* Xen requires hotplugging to the root device, even on the Q35
> chipset */
> pls explain what 'root device' is.
> Why can't you use root-ports for hotplug?
>
> Wording may have been incorrect.  Root port is correct. This may not be
needed anymore,
and may have been left over for when I was debugging PCIe hotplugging
problems.
I will retest and fix patch once I know more. Xen expects the PCIe device
to be on the root port.

I can move the function to a different patch that uses it.

> > +    if (qbus_is_hotpluggable(BUS(bus)) || xen_enabled()) {
> >          if (!is_bridge || (!br->hotplugged &&
> info->has_bridge_hotplug)) {
> >              bus_bsel =3D g_malloc(sizeof *bus_bsel);
> >
> > diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> > index fd18920e7f..fe5fc0f47c 100644
> > --- a/hw/pci-host/q35.c
> > +++ b/hw/pci-host/q35.c
> > @@ -259,6 +259,15 @@ static void q35_host_initfn(Object *obj)
> >                               qdev_prop_allow_set_link_before_realize,
> 0);
> >  }
> >
> > +PCIBus *find_q35(void)
> > +{
> > +    PCIHostState *s =3D OBJECT_CHECK(PCIHostState,
> > +                                   object_resolve_path("/machine/q35",
> NULL),
> > +                                   TYPE_PCI_HOST_BRIDGE);
> > +    return s ? s->bus : NULL;
> > +}
> > +
> > +
> >  static const TypeInfo q35_host_info =3D {
> >      .name       =3D TYPE_Q35_HOST_DEVICE,
> >      .parent     =3D TYPE_PCIE_HOST_BRIDGE,
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index c661e9cc80..550f8fa221 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -196,6 +196,9 @@ void pc_madt_cpu_entry(int uid, const CPUArchIdList
> *apic_ids,
> >  /* sgx.c */
> >  void pc_machine_init_sgx_epc(PCMachineState *pcms);
> >
> > +/* q35.c */
> > +PCIBus *find_q35(void);
> > +
> >  extern GlobalProperty pc_compat_8_0[];
> >  extern const size_t pc_compat_8_0_len;
> >
>
>

--000000000000c8276a05fea70b06
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 21, 2023 at 7:28=E2=80=AF=
AM Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com">imammedo@redhat=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On Tue, 20 Jun 2023 13:24:36 -0400<br>
Joel Upham &lt;<a href=3D"mailto:jupham125@gmail.com" target=3D"_blank">jup=
ham125@gmail.com</a>&gt; wrote:<br>
<br>
&gt; On Q35 we still need to assign BSEL property to bus(es) for PCI device=
<br>
&gt; add/hotplug to work.<br>
&gt; Extend acpi_set_pci_info() function to support Q35 as well. This patch=
 adds new (trivial)<br>
&gt; function find_q35() which returns root PCIBus object on Q35, in a way<=
br>
&gt; similar to what find_i440fx does.<br>
<br>
I think patch is mostly obsolete, q35 ACPI PCI hotplug is supported in upst=
ream QEMU.<br>
<br>
Also see comment below.<br>
<br></blockquote><div>I make use of the find_q35() function in later patche=
s, but I agree now a majority of this patch is a bit different. <br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt; Signed-off-by: Alexey Gerasimenko &lt;x1917x@xxxxxxxxx&gt;<br>
&gt; Signed-off-by: Joel Upham &lt;<a href=3D"mailto:jupham125@gmail.com" t=
arget=3D"_blank">jupham125@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/acpi/pcihp.c=C2=A0 =C2=A0 =C2=A0 | 4 +++-<br>
&gt;=C2=A0 hw/pci-host/q35.c=C2=A0 =C2=A0 | 9 +++++++++<br>
&gt;=C2=A0 include/hw/i386/pc.h | 3 +++<br>
&gt;=C2=A0 3 files changed, 15 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c<br>
&gt; index cdd6f775a1..f4e39d7a9c 100644<br>
&gt; --- a/hw/acpi/pcihp.c<br>
&gt; +++ b/hw/acpi/pcihp.c<br>
&gt; @@ -40,6 +40,7 @@<br>
&gt;=C2=A0 #include &quot;qapi/error.h&quot;<br>
&gt;=C2=A0 #include &quot;qom/qom-qobject.h&quot;<br>
&gt;=C2=A0 #include &quot;trace.h&quot;<br>
&gt; +#include &quot;sysemu/xen.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define ACPI_PCIHP_SIZE 0x0018<br>
&gt;=C2=A0 #define PCI_UP_BASE 0x0000<br>
&gt; @@ -84,7 +85,8 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool is_bridge =3D IS_PCI_BRIDGE(br);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* hotplugged bridges can&#39;t be described in AC=
PI ignore them */<br>
&gt; -=C2=A0 =C2=A0 if (qbus_is_hotpluggable(BUS(bus))) {<br>
<br>
&gt; +=C2=A0 =C2=A0 /* Xen requires hotplugging to the root device, even on=
 the Q35 chipset */<br>
pls explain what &#39;root device&#39; is.<br>
Why can&#39;t you use root-ports for hotplug?<br>
<br></blockquote><div>Wording may have been incorrect.=C2=A0 Root port is c=
orrect. This may not be needed anymore,</div><div>and may have been left ov=
er for when I was debugging PCIe hotplugging problems. <br></div><div>I wil=
l retest and fix patch once I know more. Xen expects the PCIe device to be =
on the root port.</div><div><br></div><div>I can move the function to a dif=
ferent patch that uses it. <br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
&gt; +=C2=A0 =C2=A0 if (qbus_is_hotpluggable(BUS(bus)) || xen_enabled()) {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!is_bridge || (!br-&gt;hotplugge=
d &amp;&amp; info-&gt;has_bridge_hotplug)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bus_bsel =3D g_malloc(=
sizeof *bus_bsel);<br>
&gt;=C2=A0 <br>
&gt; diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c<br>
&gt; index fd18920e7f..fe5fc0f47c 100644<br>
&gt; --- a/hw/pci-host/q35.c<br>
&gt; +++ b/hw/pci-host/q35.c<br>
&gt; @@ -259,6 +259,15 @@ static void q35_host_initfn(Object *obj)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_prop_allow_set_link_before_re=
alize, 0);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +PCIBus *find_q35(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 PCIHostState *s =3D OBJECT_CHECK(PCIHostState,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_resolve_path=
(&quot;/machine/q35&quot;, NULL),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_PCI_HOST_BRIDG=
E);<br>
&gt; +=C2=A0 =C2=A0 return s ? s-&gt;bus : NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt;=C2=A0 static const TypeInfo q35_host_info =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D TYPE_Q35_HOST_=
DEVICE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0=3D TYPE_PCIE_HOST_BRID=
GE,<br>
&gt; diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h<br>
&gt; index c661e9cc80..550f8fa221 100644<br>
&gt; --- a/include/hw/i386/pc.h<br>
&gt; +++ b/include/hw/i386/pc.h<br>
&gt; @@ -196,6 +196,9 @@ void pc_madt_cpu_entry(int uid, const CPUArchIdLis=
t *apic_ids,<br>
&gt;=C2=A0 /* sgx.c */<br>
&gt;=C2=A0 void pc_machine_init_sgx_epc(PCMachineState *pcms);<br>
&gt;=C2=A0 <br>
&gt; +/* q35.c */<br>
&gt; +PCIBus *find_q35(void);<br>
&gt; +<br>
&gt;=C2=A0 extern GlobalProperty pc_compat_8_0[];<br>
&gt;=C2=A0 extern const size_t pc_compat_8_0_len;<br>
&gt;=C2=A0 <br>
<br>
</blockquote></div></div>

--000000000000c8276a05fea70b06--

