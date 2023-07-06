Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD677494A7
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 06:21:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHGSo-0008Re-F8; Thu, 06 Jul 2023 00:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1qHGSm-0008RI-Gk
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 00:19:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1qHGSj-0002rk-7T
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 00:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688617164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBzrHXI45CK65dwxOq1uXMn3tvD6GiKla1C/ZnvGYI4=;
 b=MUCxLV8VPdTbpDTuUotTst+xRKHRZAAuvMRzPiapQ4PnibeLbYQJcSoU38TO2TNrhQWaNH
 S1AhZ4Bf5kOOTJDRgEIfRCmqgCkTREPlkXtLhgiVLQGcb8CuQvYIDdSlAy26+hR+DkH/EX
 S1Qe7m5SQWPQq+An9MzDZ4fgb4eqwxI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-301dnhfpNOKrPLgBvQP7dQ-1; Thu, 06 Jul 2023 00:19:22 -0400
X-MC-Unique: 301dnhfpNOKrPLgBvQP7dQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-63788123d11so3739026d6.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 21:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688617162; x=1691209162;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kBzrHXI45CK65dwxOq1uXMn3tvD6GiKla1C/ZnvGYI4=;
 b=hk11UqcyApFY3YRjtexRSiwFMrg119bPjITO79kDtWqym8pDv1D/Ugjh5Ih18NeP/H
 Z06HNlD9ywLOCHIdQGYWMokgeQx5Mx9R2VmIrwP8ofCU1+sVDKQjV4u7Nh6TFbxum8Td
 8x0LajM3IdjAueAtNU4NEr66jZSeHBoy2ZzliuFjihuJmPS4PL4kurcQ0L0GzFcdvhru
 RjgFxEbjdWAGqLxg6hs/FTmOwjsT1HuBkMfHIvGtbrnAlMHsWEyIbP6fqTDOtkQOVGVs
 +8MQt1puAW6CJ/pC3013/K+dTW81yZHjBAr+EHvqFVaHOC/znqxa9rAuWfIK01McEB3T
 i1vg==
X-Gm-Message-State: ABy/qLbJ3aKLKpecqTfiDTaohUJYaaYMEw01ymjboM7JUXU/0cYvxcmx
 MGxYw/Wo6kOTsfuZzboi4VWgz5eDMEZxfltdEkHL6+bJoYjhWnnjWfsE0bWWv4kZ9hFEJVloDLD
 d1J70KtyZ+pTdWjhDJunPswiq+g1VUS0=
X-Received: by 2002:ac8:4e91:0:b0:403:36a0:be0 with SMTP id
 17-20020ac84e91000000b0040336a00be0mr1054672qtp.28.1688617162328; 
 Wed, 05 Jul 2023 21:19:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFzjkMyrAXoTrYbwZEILGSOftfIwveZUu/BB75BB4m7mZPWDpSLgiPPvo2AXBgddfElcnRmDPS2iDcPPTLyNcQ=
X-Received: by 2002:ac8:4e91:0:b0:403:36a0:be0 with SMTP id
 17-20020ac84e91000000b0040336a00be0mr1054655qtp.28.1688617161555; Wed, 05 Jul
 2023 21:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230629090500.438976-2-leobras@redhat.com> <ZJ25AdfN7AqYkB6z@x1n>
 <20230629152644-mutt-send-email-mst@kernel.org> <ZJ3jJTf+iPwPDuf9@x1n>
 <20230629160643-mutt-send-email-mst@kernel.org> <ZJ3wAPbroS3jUDuQ@x1n>
 <ee67338be410a91a03e5514520141404be0e26f5.camel@redhat.com>
 <2364a62d0cc278c43dd19da4aceeee70513990e1.camel@redhat.com>
 <20230704024051-mutt-send-email-mst@kernel.org>
 <CAJ6HWG4mSbBFZk=-BK6_F0ppg4f1nM_M_9G-EEE+N4myC7HS5w@mail.gmail.com>
In-Reply-To: <CAJ6HWG4mSbBFZk=-BK6_F0ppg4f1nM_M_9G-EEE+N4myC7HS5w@mail.gmail.com>
From: Leonardo Bras Soares Passos <leobras@redhat.com>
Date: Thu, 6 Jul 2023 01:19:10 -0300
Message-ID: <CAJ6HWG5FCc_PVkui_1xu+Fwa60KOLSDSk0GDLp880M727Fo3CA@mail.gmail.com>
Subject: Re: [PATCH 1/1] pcie: Add hotplug detect state register to w1cmask
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, 
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lsoaresp@redhat.com;
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

On Wed, Jul 5, 2023 at 3:40=E2=80=AFAM Leonardo Bras Soares Passos
<leobras@redhat.com> wrote:
>
> On Tue, Jul 4, 2023 at 3:43=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
> >
> > On Tue, Jul 04, 2023 at 03:20:36AM -0300, Leonardo Br=C3=A1s wrote:
> > > Hello Peter and Michael, I have a few updates on this:
> > >
> > > On Mon, 2023-07-03 at 02:20 -0300, Leonardo Br=C3=A1s wrote:
> > > > Hello Peter and Michael, thanks for reviewing!
> > > >
> > > >
> > > > On Thu, 2023-06-29 at 16:56 -0400, Peter Xu wrote:
> > > > > On Thu, Jun 29, 2023 at 04:06:53PM -0400, Michael S. Tsirkin wrot=
e:
> > > > > > On Thu, Jun 29, 2023 at 04:01:41PM -0400, Peter Xu wrote:
> > > > > > > On Thu, Jun 29, 2023 at 03:33:06PM -0400, Michael S. Tsirkin =
wrote:
> > > > > > > > On Thu, Jun 29, 2023 at 01:01:53PM -0400, Peter Xu wrote:
> > > > > > > > > Hi, Leo,
> > > > > > > > >
> > > > > > > > > Thanks for figuring this out.  Let me copy a few more pot=
ential reviewers
> > > > > > > > > from commit 17858a1695 ("hw/acpi/ich9: Set ACPI PCI hot-p=
lug as default on
> > > > > > > > > Q35").
> > > > > > > > >
> > > > > > > > > On Thu, Jun 29, 2023 at 06:05:00AM -0300, Leonardo Bras w=
rote:
> > > > > > > > > > When trying to migrate a machine type pc-q35-6.0 or low=
er, with this
> > > > > > > > > > cmdline options:
> > > > > > > > > >
> > > > > > > > > > -device driver=3Dpcie-root-port,port=3D18,chassis=3D19,=
id=3Dpcie-root-port18,bus=3Dpcie.0,addr=3D0x12 \
> > > > > > > > > > -device driver=3Dnec-usb-xhci,p2=3D4,p3=3D4,id=3Dnex-us=
b-xhci0,bus=3Dpcie-root-port18,addr=3D0x12.0x1
> > > > > > > > > >
> > > > > > > > > > the following bug happens after all ram pages were sent=
:
> > > > > > > > > >
> > > > > > > > > > qemu-kvm: get_pci_config_device: Bad config data: i=3D0=
x6e read: 0 device: 40 cmask: ff wmask: 0 w1cmask:19
> > > > > > > > > > qemu-kvm: Failed to load PCIDevice:config
> > > > > > > > > > qemu-kvm: Failed to load pcie-root-port:parent_obj.pare=
nt_obj.parent_obj
> > > > > > > > > > qemu-kvm: error while loading state for instance 0x0 of=
 device '0000:00:12.0/pcie-root-port'
> > > > > > > > > > qemu-kvm: load of migration failed: Invalid argument
> > > > > > > > > >
> > > > > > > > > > This happens on pc-q35-6.0 or lower because of:
> > > > > > > > > > { "ICH9-LPC", ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, "off" }
> > > > > > > > > >
> > > > > > > > > > In this scenario, hotplug_handler_plug() calls pcie_cap=
_slot_plug_cb(),
> > > > > > > > > > which sets the bus dev->config byte 0x6e with bit PCI_E=
XP_SLTSTA_PDS to
> > > > > > > > > > signal PCI hotplug for the guest. After a while the gue=
st will deal with
> > > > > > > > > > this hotplug and qemu will clear the above bit.
> > > > > > > >
> > > > > > > > Presence Detect State =E2=80=93 This bit indicates the pres=
ence of an
> > > > > > > > adapter in the slot, reflected by the logical =E2=80=9COR=
=E2=80=9D of the Physical
> > > > > > > > Layer in-band presence detect mechanism and, if present, an=
y
> > > > > > > > out-of-band presence detect mechanism defined for the slot=
=E2=80=99s
> > > > > > > > corresponding form factor. Note that the in-band presence
> > > > > > > > detect mechanism requires that power be applied to an adapt=
er
> > > > > > > > for its presence to be detected. Consequently, form factors=
 that
> > > > > > > > require a power controller for hot-plug must implement a
> > > > > > > > physical pin presence detect mechanism.
> > > > > > > > RO
> > > > > > > > Defined encodings are:
> > > > > > > > 0b Slot Empty
> > > > > > > > 1b Card Present in slot
> > > > > > > > This bit must be implemented on all Downstream Ports that
> > > > > > > > implement slots. For Downstream Ports not connected to slot=
s
> > > > > > > > (where the Slot Implemented bit of the PCI Express Capabili=
ties
> > > > > > > > register is 0b), this bit must be hardwired to 1b.
> > > >
> > > > Thank you for providing this doc!
> > > > I am new to PCI stuff, could you please point this doc?
> > >
> > > (I mean, the link to the documentation)
> >
> > The pci specs are all here: https://pcisig.com/
> > Red Hat is a member so just register, it's free.
> >
> > I'd get the 5.0 version of pci express base:
> > https://members.pcisig.com/wg/PCI-SIG/document/13005
> >
> > 6.0 is out but they did something to make it take years to open,
> > and it shouldn't matter for this.
>
> This is great! Thanks for sharing!
>
> >
> > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > And this seems to match what QEMU is doing: it clears on un=
plug
> > > > > > > > not after guest deals with hotplug.
> > > >
> > > > Oh, that's weird.
> > > > It should not unplug the device, so IIUC it should not clear the bi=
t.
> > > > Maybe something weird is happening in the guest, I will take a look=
.
> > >
> > > Updates on this:
> > > You are right! For some reason the guest is hot-unplugging the device=
 under some
> > > conditions, so there is another bug on this for me to look after.
> > >
> > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > > > Then, during migration, get_pci_config_device() will co=
mpare the
> > > > > > > > > > configs of both the freshly created device and the one =
that is being
> > > > > > > > > > received via migration, which will differ due to the PC=
I_EXP_SLTSTA_PDS bit
> > > > > > > > > > and cause the bug to reproduce.
> > > > > > > >
> > > > > > > > So bit is set on source.
> > > > > > > > But why is the bit cleared on destination? This is the part=
 I don't get.
> > > >
> > > > No, bit is set when the device is created by qemu.
> > > > After some time running (boot process completion) the bit is cleare=
d.
> > >
> > > The 'after some time' here is about the guest hot-unplugging the devi=
ce.
> > >
> > > >
> > > > The receiving end of migration will then create the device with the=
 bit set, and
> > > > then wait for migration. After the source device is received, the c=
ompare fails
> > > > due to those bits being different.
> > > >
> > >
> > > But anyway, there is some chance the device will be hot-unplugged by =
the guest
> > > OS for any reason, so we need to cover this scenario so it does not b=
reak
> > > migration.
> > >
> > > >
> > > >
> > > > > > >
> > > > > > > My understanding is that when ACPI_PM_PROP_ACPI_PCIHP_BRIDGE =
is off for the
> > > > > > > device, we just won't ever PCI_EXP_SLTSTA_PDS bit?
> > > > > >
> > > > > > Why?
> > > > >
> > > > > Never mind, spoke too soon, sorry. :(
> > > > >
> > > > > I thought pcie_cap_slot_plug_cb() can skip the set, but then I ju=
st found
> > > > > that dev->hotplugged is not what I imagined there.
> > > > >
> > > > > Leo should know better.
> > > >
> > > > There is a difference of which hotplug function is called based on =
the
> > > > ACPI_PM_PROP_ACPI_PCIHP_BRIDGE option:
> > > >
> > > > When ACPI_PM_PROP_ACPI_PCIHP_BRIDGE=3D=3D"off", hotplug_handler_plu=
g() calls
> > > > pcie_cap_slot_plug_cb() which sets the bus dev->config byte 0x6e wi=
th bit
> > > > PCI_EXP_SLTSTA_PDS.
> > > >
> > > > When ACPI_PM_PROP_ACPI_PCIHP_BRIDGE=3D=3D"on", hotplug_handler_plug=
() calls
> > > > ich9_pm_device_plug_cb(), which does not set this bit.
> > > >
> > > > >
> > > > > >
> > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > > > To avoid this fake incompatibility, there are two field=
s in PCIDevice that
> > > > > > > > > > can help:
> > > > > > > > > >
> > > > > > > > > > .wmask: Used to implement R/W bytes, and
> > > > > > > > > > .w1cmask: Used to implement RW1C(Write 1 to Clear) byte=
s
> > > > > > > > >
> > > > > > > > > Is there one more option to clear the bit in cmask?
> > > >
> > > > We could clear the bit for .cmask . I suggested w1cmask because I p=
reviously
> > > > understood that bit was guest-writeable.
> > >
> > > IIUC, the bit is guest-writeable, so we should use .wmask instead of =
.cmask .
> > > Is this correct?
>
> It was incorrect :/

I was under the impression the guest was writing to this value, but in
fact it was writing to SLTCTL (RW), and qemu was the one detecting
power on -> power off for the device and writing 0 to SLTSTA->
Presence Detect State.

>
> > >
> > > >
> > > > > > > > >
> > > > > > > > > IIUC w1cmask means the guest can now write to this bit, b=
ut afaiu from the
> > > > > > > > > pcie spec it's RO.
> > > > > > > >
> > > > > > > > Yes this bit must be RO.
> > > >
> > > > My bad, I assumed behavior based on how the guest was working, and =
this gone
> > > > wrong. With above documentation provided, I would suggest clearing =
the .config
> > > > mask related bit so qemu skips checking this one.
> > > >
> > > > What is your opinion on that?
>
> Michael,
> Is the above fine?
>
> If so, I will send a v2 on this.
> Any other suggestions?

This v2 is mostly ready, so I will send it, and in any case it's not
the best solution, we can improve that on a possible v3.


> > > >
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > According to pcie_cap_slot_init() the slot status regis=
ter
> > > > > > > > > > (PCI_EXP_SLTSTA), in which PCI_EXP_SLTSTA_PDS is a flag=
, seems to fall
> > > > > > > > > > under w1cmask field, with makes sense due to the way si=
gnaling the hotplug
> > > > > > > > > > works.
> > > > > > > > > >
> > > > > > > > > > So, add PCI_EXP_SLTSTA_PDS bit to w1cmask, so the fake =
incompatibility on
> > > > > > > > > > get_pci_config_device() does not abort the migration.
> > > > > > > > > >
> > > > > > > > > > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D=
2215819
> > > > > > > > > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > > > > > > >
> > > > > > > > > Do we need a Fixes: and also the need to copy stable?
> > > > > > > > >
> > > > > > > > > > ---
> > > > > > > > > >  hw/pci/pcie.c | 2 +-
> > > > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > > > > > > > > > index b8c24cf45f..2def1765a5 100644
> > > > > > > > > > --- a/hw/pci/pcie.c
> > > > > > > > > > +++ b/hw/pci/pcie.c
> > > > > > > > > > @@ -657,7 +657,7 @@ void pcie_cap_slot_init(PCIDevice *=
dev, PCIESlot *s)
> > > > > > > > > >                                 PCI_EXP_SLTCTL_EIC);
> > > > > > > > > >
> > > > > > > > > >      pci_word_test_and_set_mask(dev->w1cmask + pos + PC=
I_EXP_SLTSTA,
> > > > > > > > > > -                               PCI_EXP_HP_EV_SUPPORTED=
);
> > > > > > > > > > +                               PCI_EXP_HP_EV_SUPPORTED=
 | PCI_EXP_SLTSTA_PDS);
> > > > > > > > > >
> > > > > > > > > >      dev->exp.hpev_notified =3D false;
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > 2.41.0
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > Peter Xu
> > > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Peter Xu
> > > > > >
> > > > >
> > > >
> >


