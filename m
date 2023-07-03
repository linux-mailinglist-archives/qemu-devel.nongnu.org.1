Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B1D7454C4
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 07:20:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGBz8-0008CH-6X; Mon, 03 Jul 2023 01:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1qGBz4-0008A5-7O
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 01:20:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1qGBz2-0006z3-8u
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 01:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688361619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OxirhxBzSq1ZOw7AX5lxD+FkYO86/Lm5DuuIePJlDXs=;
 b=RZKeMQTz+0g92Dl/YYu9n0eauTYiIOpwQjqVup5C385nD6Nl5U2+QWDqHalvL1fMelqdmN
 s+Xou9+Swvx5qkvQtEs7S+9fz+F/efY4w6Q7t4hW68ntgiHLQa0QwWUw/cMyUHlAQRj5zn
 GEYRJxA+tjvOwIEEwy3E+EcXPwmAOl8=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-QKDPv3t6NjqOwDLqurEmHQ-1; Mon, 03 Jul 2023 01:20:17 -0400
X-MC-Unique: QKDPv3t6NjqOwDLqurEmHQ-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-1b03ffcf9aaso4372842fac.3
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 22:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688361617; x=1690953617;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OxirhxBzSq1ZOw7AX5lxD+FkYO86/Lm5DuuIePJlDXs=;
 b=fKgNiKQUYX94sggwWcuyMxjYCo6KSR1cSXw7L1dVyhwqcrCefj+xJsGdGaj3HdSLWR
 FkTEOxlnVf6/Zsc4RQ6FW8gATID+hCAlUpzxiszqE+J2OpSokV7J1dm7U7rr/TjD3TQZ
 cDNQQfPnBSbqYwtq9GOZICZRK2AEQeZPTrI61N5gew0tMkGlWpIj3lX1E79Wt3eBPhqR
 +MgnyF4bPAuLmk7rs3ggnRl+ZdL+Vt4RtZxjnDD7ReOcWC4mjWdHhU6h1ORsIdglWcCz
 YVE/GjU9D7v3d9PD02puizsY+Vf6Ub2u8epSThECtyPC5TOdOXMRWooVQyqwJK3m+oIY
 DNqA==
X-Gm-Message-State: ABy/qLa23FomoGCQeW0D7l1lp71r/M/+NDKB/SAGOyZQ2eE2VbEb8NwT
 QEAaW7+eJoG9kKv46VMqtOHpDHDP/lLQjbwXXZRijcH196ODfJD82L2m2Ey704dxkaAEASOCeKX
 StiVUFy5yQ3WREUg=
X-Received: by 2002:a05:6871:548:b0:1b0:5218:ceff with SMTP id
 t8-20020a056871054800b001b05218ceffmr9582841oal.18.1688361617113; 
 Sun, 02 Jul 2023 22:20:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5HwNV1/JQCXtUqN7Koxq7wMTGvTLg2rZgJvs8UEXThx1rk8DpHapigo0lhB6nwhw/ccP56Dw==
X-Received: by 2002:a05:6871:548:b0:1b0:5218:ceff with SMTP id
 t8-20020a056871054800b001b05218ceffmr9582824oal.18.1688361616814; 
 Sun, 02 Jul 2023 22:20:16 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a800:faf8:1d15:affc:4ee8:6427?
 ([2804:1b3:a800:faf8:1d15:affc:4ee8:6427])
 by smtp.gmail.com with ESMTPSA id
 kz10-20020a056871408a00b001b390c6e00bsm1782375oab.56.2023.07.02.22.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 22:20:16 -0700 (PDT)
Message-ID: <ee67338be410a91a03e5514520141404be0e26f5.camel@redhat.com>
Subject: Re: [PATCH 1/1] pcie: Add hotplug detect state register to w1cmask
From: Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To: Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Juan Quintela
 <quintela@redhat.com>, qemu-devel@nongnu.org, Julia Suvorova
 <jusual@redhat.com>,  Igor Mammedov <imammedo@redhat.com>, David Gibson
 <david@gibson.dropbear.id.au>
Date: Mon, 03 Jul 2023 02:20:13 -0300
In-Reply-To: <ZJ3wAPbroS3jUDuQ@x1n>
References: <20230629090500.438976-2-leobras@redhat.com>
 <ZJ25AdfN7AqYkB6z@x1n> <20230629152644-mutt-send-email-mst@kernel.org>
 <ZJ3jJTf+iPwPDuf9@x1n> <20230629160643-mutt-send-email-mst@kernel.org>
 <ZJ3wAPbroS3jUDuQ@x1n>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leobras@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hello Peter and Michael, thanks for reviewing!


On Thu, 2023-06-29 at 16:56 -0400, Peter Xu wrote:
> On Thu, Jun 29, 2023 at 04:06:53PM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jun 29, 2023 at 04:01:41PM -0400, Peter Xu wrote:
> > > On Thu, Jun 29, 2023 at 03:33:06PM -0400, Michael S. Tsirkin wrote:
> > > > On Thu, Jun 29, 2023 at 01:01:53PM -0400, Peter Xu wrote:
> > > > > Hi, Leo,
> > > > >=20
> > > > > Thanks for figuring this out.  Let me copy a few more potential r=
eviewers
> > > > > from commit 17858a1695 ("hw/acpi/ich9: Set ACPI PCI hot-plug as d=
efault on
> > > > > Q35").
> > > > >=20
> > > > > On Thu, Jun 29, 2023 at 06:05:00AM -0300, Leonardo Bras wrote:
> > > > > > When trying to migrate a machine type pc-q35-6.0 or lower, with=
 this
> > > > > > cmdline options:
> > > > > >=20
> > > > > > -device driver=3Dpcie-root-port,port=3D18,chassis=3D19,id=3Dpci=
e-root-port18,bus=3Dpcie.0,addr=3D0x12 \
> > > > > > -device driver=3Dnec-usb-xhci,p2=3D4,p3=3D4,id=3Dnex-usb-xhci0,=
bus=3Dpcie-root-port18,addr=3D0x12.0x1
> > > > > >=20
> > > > > > the following bug happens after all ram pages were sent:
> > > > > >=20
> > > > > > qemu-kvm: get_pci_config_device: Bad config data: i=3D0x6e read=
: 0 device: 40 cmask: ff wmask: 0 w1cmask:19
> > > > > > qemu-kvm: Failed to load PCIDevice:config
> > > > > > qemu-kvm: Failed to load pcie-root-port:parent_obj.parent_obj.p=
arent_obj
> > > > > > qemu-kvm: error while loading state for instance 0x0 of device =
'0000:00:12.0/pcie-root-port'
> > > > > > qemu-kvm: load of migration failed: Invalid argument
> > > > > >=20
> > > > > > This happens on pc-q35-6.0 or lower because of:
> > > > > > { "ICH9-LPC", ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, "off" }
> > > > > >=20
> > > > > > In this scenario, hotplug_handler_plug() calls pcie_cap_slot_pl=
ug_cb(),
> > > > > > which sets the bus dev->config byte 0x6e with bit PCI_EXP_SLTST=
A_PDS to=20
> > > > > > signal PCI hotplug for the guest. After a while the guest will =
deal with
> > > > > > this hotplug and qemu will clear the above bit.
> > > >=20
> > > > Presence Detect State =E2=80=93 This bit indicates the presence of =
an
> > > > adapter in the slot, reflected by the logical =E2=80=9COR=E2=80=9D =
of the Physical
> > > > Layer in-band presence detect mechanism and, if present, any
> > > > out-of-band presence detect mechanism defined for the slot=E2=80=99=
s
> > > > corresponding form factor. Note that the in-band presence
> > > > detect mechanism requires that power be applied to an adapter
> > > > for its presence to be detected. Consequently, form factors that
> > > > require a power controller for hot-plug must implement a
> > > > physical pin presence detect mechanism.
> > > > RO
> > > > Defined encodings are:
> > > > 0b Slot Empty
> > > > 1b Card Present in slot
> > > > This bit must be implemented on all Downstream Ports that
> > > > implement slots. For Downstream Ports not connected to slots
> > > > (where the Slot Implemented bit of the PCI Express Capabilities
> > > > register is 0b), this bit must be hardwired to 1b.

Thank you for providing this doc!
I am new to PCI stuff, could you please point this doc?

> > > >=20
> > > >=20
> > > > And this seems to match what QEMU is doing: it clears on unplug
> > > > not after guest deals with hotplug.

Oh, that's weird.
It should not unplug the device, so IIUC it should not clear the bit.
Maybe something weird is happening in the guest, I will take a look.

> > > >=20
> > > >=20
> > > > > > Then, during migration, get_pci_config_device() will compare th=
e
> > > > > > configs of both the freshly created device and the one that is =
being
> > > > > > received via migration, which will differ due to the PCI_EXP_SL=
TSTA_PDS bit
> > > > > > and cause the bug to reproduce.
> > > >=20
> > > > So bit is set on source.
> > > > But why is the bit cleared on destination? This is the part I don't=
 get.

No, bit is set when the device is created by qemu.
After some time running (boot process completion) the bit is cleared.

The receiving end of migration will then create the device with the bit set=
, and
then wait for migration. After the source device is received, the compare f=
ails
due to those bits being different.



> > >=20
> > > My understanding is that when ACPI_PM_PROP_ACPI_PCIHP_BRIDGE is off f=
or the
> > > device, we just won't ever PCI_EXP_SLTSTA_PDS bit?
> >=20
> > Why?
>=20
> Never mind, spoke too soon, sorry. :(
>=20
> I thought pcie_cap_slot_plug_cb() can skip the set, but then I just found
> that dev->hotplugged is not what I imagined there.
>=20
> Leo should know better.

There is a difference of which hotplug function is called based on the=20
ACPI_PM_PROP_ACPI_PCIHP_BRIDGE option:

When ACPI_PM_PROP_ACPI_PCIHP_BRIDGE=3D=3D"off", hotplug_handler_plug() call=
s
pcie_cap_slot_plug_cb() which sets the bus dev->config byte 0x6e with bit
PCI_EXP_SLTSTA_PDS.

When ACPI_PM_PROP_ACPI_PCIHP_BRIDGE=3D=3D"on", hotplug_handler_plug() calls
ich9_pm_device_plug_cb(), which does not set this bit.

>=20
> >=20
> >=20
> > > >=20
> > > >=20
> > > > > > To avoid this fake incompatibility, there are two fields in PCI=
Device that
> > > > > > can help:
> > > > > >=20
> > > > > > .wmask: Used to implement R/W bytes, and
> > > > > > .w1cmask: Used to implement RW1C(Write 1 to Clear) bytes
> > > > >=20
> > > > > Is there one more option to clear the bit in cmask?

We could clear the bit for .cmask . I suggested w1cmask because I previousl=
y
understood that bit was guest-writeable.

> > > > >=20
> > > > > IIUC w1cmask means the guest can now write to this bit, but afaiu=
 from the
> > > > > pcie spec it's RO.
> > > >=20
> > > > Yes this bit must be RO.

My bad, I assumed behavior based on how the guest was working, and this gon=
e
wrong. With above documentation provided, I would suggest clearing the .con=
fig
mask related bit so qemu skips checking this one.

What is your opinion on that?

> > > >=20
> > > > > >=20
> > > > > > According to pcie_cap_slot_init() the slot status register
> > > > > > (PCI_EXP_SLTSTA), in which PCI_EXP_SLTSTA_PDS is a flag, seems =
to fall
> > > > > > under w1cmask field, with makes sense due to the way signaling =
the hotplug
> > > > > > works.
> > > > > >=20
> > > > > > So, add PCI_EXP_SLTSTA_PDS bit to w1cmask, so the fake incompat=
ibility on
> > > > > > get_pci_config_device() does not abort the migration.
> > > > > >=20
> > > > > > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D2215819
> > > > > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > > >=20
> > > > > Do we need a Fixes: and also the need to copy stable?
> > > > >=20
> > > > > > ---
> > > > > >  hw/pci/pcie.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >=20
> > > > > > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > > > > > index b8c24cf45f..2def1765a5 100644
> > > > > > --- a/hw/pci/pcie.c
> > > > > > +++ b/hw/pci/pcie.c
> > > > > > @@ -657,7 +657,7 @@ void pcie_cap_slot_init(PCIDevice *dev, PCI=
ESlot *s)
> > > > > >                                 PCI_EXP_SLTCTL_EIC);
> > > > > > =20
> > > > > >      pci_word_test_and_set_mask(dev->w1cmask + pos + PCI_EXP_SL=
TSTA,
> > > > > > -                               PCI_EXP_HP_EV_SUPPORTED);
> > > > > > +                               PCI_EXP_HP_EV_SUPPORTED | PCI_E=
XP_SLTSTA_PDS);
> > > > > > =20
> > > > > >      dev->exp.hpev_notified =3D false;
> > > > > > =20
> > > > > > --=20
> > > > > > 2.41.0
> > > > > >=20
> > > > >=20
> > > > > --=20
> > > > > Peter Xu
> > > >=20
> > >=20
> > > --=20
> > > Peter Xu
> >=20
>=20


