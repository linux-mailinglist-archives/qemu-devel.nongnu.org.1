Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D012374698A
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 08:22:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGZPV-0005Tx-P5; Tue, 04 Jul 2023 02:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1qGZP4-0005TP-H8
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 02:20:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1qGZP1-0003aq-OF
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 02:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688451642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YXw8cAFt2h29KEwkVLQu/v/geoweJwdAV6/z6kuECLg=;
 b=Pg+B7n4hJjT3mz1pIBMgcVonzW3rO/aiPo9JwiRJqX3J1R/zpJMihRO2fTcv/FSfVF1unb
 Ktwv5vdIdbAQ9Lo8ztxwXVyiXA+GalXbl/4v+ubmVXa3GGnKjKYN50vqmtypdswDYVVQd7
 ux6FY7nSgz6YvY48f/WxNbxq57Z7v5U=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-JfOv8aBUMPKwKCzehJ1ZPg-1; Tue, 04 Jul 2023 02:20:40 -0400
X-MC-Unique: JfOv8aBUMPKwKCzehJ1ZPg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-40327302341so38751791cf.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 23:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688451640; x=1691043640;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YXw8cAFt2h29KEwkVLQu/v/geoweJwdAV6/z6kuECLg=;
 b=XskkayDkI9spyGKaR2EYf4G3tDI6xiVBvk2M7mZXlcv+FxAHAjh7Iyz4KZ0Yrxj1fx
 CgYo3EIj6Sp/fyOr4ugcXsOwXCC5Pgd8um2edd43Hvawq0KG1SAp2lo527NFHG+Knl2l
 eV46jRTvLyKryuF2xuYs0JmdsaQQPC3lRk3byg5O4Em0hLKpgkk+dtNN8/cHt1Rl19hw
 jcfHbsBJvmR7aKQIG9V3UbOMhFBNcbVItRjxKCG12T7jyjHXGuL/xQZbvGvG9CDlGtlr
 dVlPOCOAJZO7u8hVg5oaI5NE4qgcLrhQtLBbb2CJf5IrsOzBmTVhcnmNEdwFKbrHeKqk
 O0YQ==
X-Gm-Message-State: AC+VfDxHugK7kfYdFd3EDy4bybjSXFKS/t7/F5Te1P9/lZrtCsVOdqqf
 6CFjT4HuQgD7tf00KMpBrS1r7YmEBM915wxlqhkLeLFKsLUMQze3lur6ZcioglswshUjNHZljPV
 0UIMV9E7eGyDzW+c=
X-Received: by 2002:a05:622a:3cc:b0:400:8f4b:d9fc with SMTP id
 k12-20020a05622a03cc00b004008f4bd9fcmr14668533qtx.41.1688451640300; 
 Mon, 03 Jul 2023 23:20:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6A8Jt79KLiZNETdxxMMO4gw44wDSeFiQdlpWdXl7RS94aHXN2lijc1d6zB5fsRSQLtvoTOMA==
X-Received: by 2002:a05:622a:3cc:b0:400:8f4b:d9fc with SMTP id
 k12-20020a05622a03cc00b004008f4bd9fcmr14668519qtx.41.1688451640004; 
 Mon, 03 Jul 2023 23:20:40 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a800:faf8:1d15:affc:4ee8:6427?
 ([2804:1b3:a800:faf8:1d15:affc:4ee8:6427])
 by smtp.gmail.com with ESMTPSA id
 fb6-20020a05622a480600b003ff1f891206sm8118655qtb.61.2023.07.03.23.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 23:20:39 -0700 (PDT)
Message-ID: <2364a62d0cc278c43dd19da4aceeee70513990e1.camel@redhat.com>
Subject: Re: [PATCH 1/1] pcie: Add hotplug detect state register to w1cmask
From: Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To: Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Juan Quintela
 <quintela@redhat.com>, qemu-devel@nongnu.org, Julia Suvorova
 <jusual@redhat.com>,  Igor Mammedov <imammedo@redhat.com>, David Gibson
 <david@gibson.dropbear.id.au>
Date: Tue, 04 Jul 2023 03:20:36 -0300
In-Reply-To: <ee67338be410a91a03e5514520141404be0e26f5.camel@redhat.com>
References: <20230629090500.438976-2-leobras@redhat.com>
 <ZJ25AdfN7AqYkB6z@x1n> <20230629152644-mutt-send-email-mst@kernel.org>
 <ZJ3jJTf+iPwPDuf9@x1n> <20230629160643-mutt-send-email-mst@kernel.org>
 <ZJ3wAPbroS3jUDuQ@x1n>
 <ee67338be410a91a03e5514520141404be0e26f5.camel@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Peter and Michael, I have a few updates on this:

On Mon, 2023-07-03 at 02:20 -0300, Leonardo Br=C3=A1s wrote:
> Hello Peter and Michael, thanks for reviewing!
>=20
>=20
> On Thu, 2023-06-29 at 16:56 -0400, Peter Xu wrote:
> > On Thu, Jun 29, 2023 at 04:06:53PM -0400, Michael S. Tsirkin wrote:
> > > On Thu, Jun 29, 2023 at 04:01:41PM -0400, Peter Xu wrote:
> > > > On Thu, Jun 29, 2023 at 03:33:06PM -0400, Michael S. Tsirkin wrote:
> > > > > On Thu, Jun 29, 2023 at 01:01:53PM -0400, Peter Xu wrote:
> > > > > > Hi, Leo,
> > > > > >=20
> > > > > > Thanks for figuring this out.  Let me copy a few more potential=
 reviewers
> > > > > > from commit 17858a1695 ("hw/acpi/ich9: Set ACPI PCI hot-plug as=
 default on
> > > > > > Q35").
> > > > > >=20
> > > > > > On Thu, Jun 29, 2023 at 06:05:00AM -0300, Leonardo Bras wrote:
> > > > > > > When trying to migrate a machine type pc-q35-6.0 or lower, wi=
th this
> > > > > > > cmdline options:
> > > > > > >=20
> > > > > > > -device driver=3Dpcie-root-port,port=3D18,chassis=3D19,id=3Dp=
cie-root-port18,bus=3Dpcie.0,addr=3D0x12 \
> > > > > > > -device driver=3Dnec-usb-xhci,p2=3D4,p3=3D4,id=3Dnex-usb-xhci=
0,bus=3Dpcie-root-port18,addr=3D0x12.0x1
> > > > > > >=20
> > > > > > > the following bug happens after all ram pages were sent:
> > > > > > >=20
> > > > > > > qemu-kvm: get_pci_config_device: Bad config data: i=3D0x6e re=
ad: 0 device: 40 cmask: ff wmask: 0 w1cmask:19
> > > > > > > qemu-kvm: Failed to load PCIDevice:config
> > > > > > > qemu-kvm: Failed to load pcie-root-port:parent_obj.parent_obj=
.parent_obj
> > > > > > > qemu-kvm: error while loading state for instance 0x0 of devic=
e '0000:00:12.0/pcie-root-port'
> > > > > > > qemu-kvm: load of migration failed: Invalid argument
> > > > > > >=20
> > > > > > > This happens on pc-q35-6.0 or lower because of:
> > > > > > > { "ICH9-LPC", ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, "off" }
> > > > > > >=20
> > > > > > > In this scenario, hotplug_handler_plug() calls pcie_cap_slot_=
plug_cb(),
> > > > > > > which sets the bus dev->config byte 0x6e with bit PCI_EXP_SLT=
STA_PDS to=20
> > > > > > > signal PCI hotplug for the guest. After a while the guest wil=
l deal with
> > > > > > > this hotplug and qemu will clear the above bit.
> > > > >=20
> > > > > Presence Detect State =E2=80=93 This bit indicates the presence o=
f an
> > > > > adapter in the slot, reflected by the logical =E2=80=9COR=E2=80=
=9D of the Physical
> > > > > Layer in-band presence detect mechanism and, if present, any
> > > > > out-of-band presence detect mechanism defined for the slot=E2=80=
=99s
> > > > > corresponding form factor. Note that the in-band presence
> > > > > detect mechanism requires that power be applied to an adapter
> > > > > for its presence to be detected. Consequently, form factors that
> > > > > require a power controller for hot-plug must implement a
> > > > > physical pin presence detect mechanism.
> > > > > RO
> > > > > Defined encodings are:
> > > > > 0b Slot Empty
> > > > > 1b Card Present in slot
> > > > > This bit must be implemented on all Downstream Ports that
> > > > > implement slots. For Downstream Ports not connected to slots
> > > > > (where the Slot Implemented bit of the PCI Express Capabilities
> > > > > register is 0b), this bit must be hardwired to 1b.
>=20
> Thank you for providing this doc!
> I am new to PCI stuff, could you please point this doc?

(I mean, the link to the documentation)

>=20
> > > > >=20
> > > > >=20
> > > > > And this seems to match what QEMU is doing: it clears on unplug
> > > > > not after guest deals with hotplug.
>=20
> Oh, that's weird.
> It should not unplug the device, so IIUC it should not clear the bit.
> Maybe something weird is happening in the guest, I will take a look.

Updates on this:
You are right! For some reason the guest is hot-unplugging the device under=
 some
conditions, so there is another bug on this for me to look after.

>=20
> > > > >=20
> > > > >=20
> > > > > > > Then, during migration, get_pci_config_device() will compare =
the
> > > > > > > configs of both the freshly created device and the one that i=
s being
> > > > > > > received via migration, which will differ due to the PCI_EXP_=
SLTSTA_PDS bit
> > > > > > > and cause the bug to reproduce.
> > > > >=20
> > > > > So bit is set on source.
> > > > > But why is the bit cleared on destination? This is the part I don=
't get.
>=20
> No, bit is set when the device is created by qemu.
> After some time running (boot process completion) the bit is cleared.

The 'after some time' here is about the guest hot-unplugging the device.

>=20
> The receiving end of migration will then create the device with the bit s=
et, and
> then wait for migration. After the source device is received, the compare=
 fails
> due to those bits being different.
>=20

But anyway, there is some chance the device will be hot-unplugged by the gu=
est
OS for any reason, so we need to cover this scenario so it does not break
migration.

>=20
>=20
> > > >=20
> > > > My understanding is that when ACPI_PM_PROP_ACPI_PCIHP_BRIDGE is off=
 for the
> > > > device, we just won't ever PCI_EXP_SLTSTA_PDS bit?
> > >=20
> > > Why?
> >=20
> > Never mind, spoke too soon, sorry. :(
> >=20
> > I thought pcie_cap_slot_plug_cb() can skip the set, but then I just fou=
nd
> > that dev->hotplugged is not what I imagined there.
> >=20
> > Leo should know better.
>=20
> There is a difference of which hotplug function is called based on the=
=20
> ACPI_PM_PROP_ACPI_PCIHP_BRIDGE option:
>=20
> When ACPI_PM_PROP_ACPI_PCIHP_BRIDGE=3D=3D"off", hotplug_handler_plug() ca=
lls
> pcie_cap_slot_plug_cb() which sets the bus dev->config byte 0x6e with bit
> PCI_EXP_SLTSTA_PDS.
>=20
> When ACPI_PM_PROP_ACPI_PCIHP_BRIDGE=3D=3D"on", hotplug_handler_plug() cal=
ls
> ich9_pm_device_plug_cb(), which does not set this bit.
>=20
> >=20
> > >=20
> > >=20
> > > > >=20
> > > > >=20
> > > > > > > To avoid this fake incompatibility, there are two fields in P=
CIDevice that
> > > > > > > can help:
> > > > > > >=20
> > > > > > > .wmask: Used to implement R/W bytes, and
> > > > > > > .w1cmask: Used to implement RW1C(Write 1 to Clear) bytes
> > > > > >=20
> > > > > > Is there one more option to clear the bit in cmask?
>=20
> We could clear the bit for .cmask . I suggested w1cmask because I previou=
sly
> understood that bit was guest-writeable.

IIUC, the bit is guest-writeable, so we should use .wmask instead of .cmask=
 .
Is this correct?

>=20
> > > > > >=20
> > > > > > IIUC w1cmask means the guest can now write to this bit, but afa=
iu from the
> > > > > > pcie spec it's RO.
> > > > >=20
> > > > > Yes this bit must be RO.
>=20
> My bad, I assumed behavior based on how the guest was working, and this g=
one
> wrong. With above documentation provided, I would suggest clearing the .c=
onfig
> mask related bit so qemu skips checking this one.
>=20
> What is your opinion on that?
>=20
> > > > >=20
> > > > > > >=20
> > > > > > > According to pcie_cap_slot_init() the slot status register
> > > > > > > (PCI_EXP_SLTSTA), in which PCI_EXP_SLTSTA_PDS is a flag, seem=
s to fall
> > > > > > > under w1cmask field, with makes sense due to the way signalin=
g the hotplug
> > > > > > > works.
> > > > > > >=20
> > > > > > > So, add PCI_EXP_SLTSTA_PDS bit to w1cmask, so the fake incomp=
atibility on
> > > > > > > get_pci_config_device() does not abort the migration.
> > > > > > >=20
> > > > > > > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D221581=
9
> > > > > > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > > > >=20
> > > > > > Do we need a Fixes: and also the need to copy stable?
> > > > > >=20
> > > > > > > ---
> > > > > > >  hw/pci/pcie.c | 2 +-
> > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > >=20
> > > > > > > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > > > > > > index b8c24cf45f..2def1765a5 100644
> > > > > > > --- a/hw/pci/pcie.c
> > > > > > > +++ b/hw/pci/pcie.c
> > > > > > > @@ -657,7 +657,7 @@ void pcie_cap_slot_init(PCIDevice *dev, P=
CIESlot *s)
> > > > > > >                                 PCI_EXP_SLTCTL_EIC);
> > > > > > > =20
> > > > > > >      pci_word_test_and_set_mask(dev->w1cmask + pos + PCI_EXP_=
SLTSTA,
> > > > > > > -                               PCI_EXP_HP_EV_SUPPORTED);
> > > > > > > +                               PCI_EXP_HP_EV_SUPPORTED | PCI=
_EXP_SLTSTA_PDS);
> > > > > > > =20
> > > > > > >      dev->exp.hpev_notified =3D false;
> > > > > > > =20
> > > > > > > --=20
> > > > > > > 2.41.0
> > > > > > >=20
> > > > > >=20
> > > > > > --=20
> > > > > > Peter Xu
> > > > >=20
> > > >=20
> > > > --=20
> > > > Peter Xu
> > >=20
> >=20
>=20


