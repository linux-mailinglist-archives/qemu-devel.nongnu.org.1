Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6C4747D39
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 08:42:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGwCL-00062G-1U; Wed, 05 Jul 2023 02:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1qGwCI-000626-NW
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 02:41:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1qGwCG-0003PL-5L
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 02:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688539262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lTWNc0MdzrGICypzvGQteAmE4y45/s0qDPyGlIKec3I=;
 b=FUF83UKKcTqRlwi0lBwOP0/DR8//EXnbTWD1Rn7dQrAwK5NtFf/Xt0JIen1XdkJURDqn6o
 259fXKh1yxyDN9OjB8z7938M0DIFfK3mCl7Kf+hxCuZHsrw+a88qV1+PX8YwStXweUeVbd
 jsXphgIY+fvJWYVRJbs4/GSAUan+HSc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-UvFEomohOv-QPFLGQ2ovPQ-1; Wed, 05 Jul 2023 02:41:01 -0400
X-MC-Unique: UvFEomohOv-QPFLGQ2ovPQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-3f9e616e25dso73774501cf.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 23:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688539261; x=1691131261;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lTWNc0MdzrGICypzvGQteAmE4y45/s0qDPyGlIKec3I=;
 b=lp9d3ApH3H9Hrgca/tSVAql2eNey8GMQ+4G6IZZpQQvS1SEiT9simlfXsG0MVBjYo3
 tK52CIf/jc4eUZsjrf5jQmF3ti4joaTRH59xzTfSr48AM2i8axel29u4uDulEev9ph37
 1+AyRaZEK6Sr8X650i3s9cuC8+C+7CCDrPlJJIrEOKbDKsiDXvlrp6KW3hdutfiwtd1X
 HSuWyotkwZucPoYd4/HdoguLXXVtNqmVRFMLfP17AGA5iT94yOJ9UgcJn4k87OfOGSKi
 2lygB5HWjg+ql/Yg2XmIUnKWW/uf5FPDhHOzRlgdrWnFeH1nmu2x/xlt+y3IkpK1O8+y
 fZ3Q==
X-Gm-Message-State: AC+VfDw55mAazVKb/XRTT5b2KTitSGIqpbmtkBfIY1xHz6D9t5nhuf3i
 aihqih8eAM2I9oeu5thCAnCWQGBh/mfSmWWE18JWufXMseEG/PlGxGjouoCaFkDg4zslE6OGa0n
 0CWOKDQQEmHuaMos4mQfgOdICOMO4QmQ=
X-Received: by 2002:a05:622a:14a:b0:402:7471:17c7 with SMTP id
 v10-20020a05622a014a00b00402747117c7mr22705205qtw.56.1688539261219; 
 Tue, 04 Jul 2023 23:41:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ54s89RmegaEun0a4Q137+xymHytwXCZGzwKa2GY0bc3nfjAgCWiWfUbFdzp6wKn1d1/aD0MZqBRFqY4izhwrA=
X-Received: by 2002:a05:622a:14a:b0:402:7471:17c7 with SMTP id
 v10-20020a05622a014a00b00402747117c7mr22705188qtw.56.1688539260905; Tue, 04
 Jul 2023 23:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230629090500.438976-2-leobras@redhat.com> <ZJ25AdfN7AqYkB6z@x1n>
 <20230629152644-mutt-send-email-mst@kernel.org> <ZJ3jJTf+iPwPDuf9@x1n>
 <20230629160643-mutt-send-email-mst@kernel.org> <ZJ3wAPbroS3jUDuQ@x1n>
 <ee67338be410a91a03e5514520141404be0e26f5.camel@redhat.com>
 <2364a62d0cc278c43dd19da4aceeee70513990e1.camel@redhat.com>
 <20230704024051-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230704024051-mutt-send-email-mst@kernel.org>
From: Leonardo Bras Soares Passos <leobras@redhat.com>
Date: Wed, 5 Jul 2023 03:40:50 -0300
Message-ID: <CAJ6HWG4mSbBFZk=-BK6_F0ppg4f1nM_M_9G-EEE+N4myC7HS5w@mail.gmail.com>
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

On Tue, Jul 4, 2023 at 3:43=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, Jul 04, 2023 at 03:20:36AM -0300, Leonardo Br=C3=A1s wrote:
> > Hello Peter and Michael, I have a few updates on this:
> >
> > On Mon, 2023-07-03 at 02:20 -0300, Leonardo Br=C3=A1s wrote:
> > > Hello Peter and Michael, thanks for reviewing!
> > >
> > >
> > > On Thu, 2023-06-29 at 16:56 -0400, Peter Xu wrote:
> > > > On Thu, Jun 29, 2023 at 04:06:53PM -0400, Michael S. Tsirkin wrote:
> > > > > On Thu, Jun 29, 2023 at 04:01:41PM -0400, Peter Xu wrote:
> > > > > > On Thu, Jun 29, 2023 at 03:33:06PM -0400, Michael S. Tsirkin wr=
ote:
> > > > > > > On Thu, Jun 29, 2023 at 01:01:53PM -0400, Peter Xu wrote:
> > > > > > > > Hi, Leo,
> > > > > > > >
> > > > > > > > Thanks for figuring this out.  Let me copy a few more poten=
tial reviewers
> > > > > > > > from commit 17858a1695 ("hw/acpi/ich9: Set ACPI PCI hot-plu=
g as default on
> > > > > > > > Q35").
> > > > > > > >
> > > > > > > > On Thu, Jun 29, 2023 at 06:05:00AM -0300, Leonardo Bras wro=
te:
> > > > > > > > > When trying to migrate a machine type pc-q35-6.0 or lower=
, with this
> > > > > > > > > cmdline options:
> > > > > > > > >
> > > > > > > > > -device driver=3Dpcie-root-port,port=3D18,chassis=3D19,id=
=3Dpcie-root-port18,bus=3Dpcie.0,addr=3D0x12 \
> > > > > > > > > -device driver=3Dnec-usb-xhci,p2=3D4,p3=3D4,id=3Dnex-usb-=
xhci0,bus=3Dpcie-root-port18,addr=3D0x12.0x1
> > > > > > > > >
> > > > > > > > > the following bug happens after all ram pages were sent:
> > > > > > > > >
> > > > > > > > > qemu-kvm: get_pci_config_device: Bad config data: i=3D0x6=
e read: 0 device: 40 cmask: ff wmask: 0 w1cmask:19
> > > > > > > > > qemu-kvm: Failed to load PCIDevice:config
> > > > > > > > > qemu-kvm: Failed to load pcie-root-port:parent_obj.parent=
_obj.parent_obj
> > > > > > > > > qemu-kvm: error while loading state for instance 0x0 of d=
evice '0000:00:12.0/pcie-root-port'
> > > > > > > > > qemu-kvm: load of migration failed: Invalid argument
> > > > > > > > >
> > > > > > > > > This happens on pc-q35-6.0 or lower because of:
> > > > > > > > > { "ICH9-LPC", ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, "off" }
> > > > > > > > >
> > > > > > > > > In this scenario, hotplug_handler_plug() calls pcie_cap_s=
lot_plug_cb(),
> > > > > > > > > which sets the bus dev->config byte 0x6e with bit PCI_EXP=
_SLTSTA_PDS to
> > > > > > > > > signal PCI hotplug for the guest. After a while the guest=
 will deal with
> > > > > > > > > this hotplug and qemu will clear the above bit.
> > > > > > >
> > > > > > > Presence Detect State =E2=80=93 This bit indicates the presen=
ce of an
> > > > > > > adapter in the slot, reflected by the logical =E2=80=9COR=E2=
=80=9D of the Physical
> > > > > > > Layer in-band presence detect mechanism and, if present, any
> > > > > > > out-of-band presence detect mechanism defined for the slot=E2=
=80=99s
> > > > > > > corresponding form factor. Note that the in-band presence
> > > > > > > detect mechanism requires that power be applied to an adapter
> > > > > > > for its presence to be detected. Consequently, form factors t=
hat
> > > > > > > require a power controller for hot-plug must implement a
> > > > > > > physical pin presence detect mechanism.
> > > > > > > RO
> > > > > > > Defined encodings are:
> > > > > > > 0b Slot Empty
> > > > > > > 1b Card Present in slot
> > > > > > > This bit must be implemented on all Downstream Ports that
> > > > > > > implement slots. For Downstream Ports not connected to slots
> > > > > > > (where the Slot Implemented bit of the PCI Express Capabiliti=
es
> > > > > > > register is 0b), this bit must be hardwired to 1b.
> > >
> > > Thank you for providing this doc!
> > > I am new to PCI stuff, could you please point this doc?
> >
> > (I mean, the link to the documentation)
>
> The pci specs are all here: https://pcisig.com/
> Red Hat is a member so just register, it's free.
>
> I'd get the 5.0 version of pci express base:
> https://members.pcisig.com/wg/PCI-SIG/document/13005
>
> 6.0 is out but they did something to make it take years to open,
> and it shouldn't matter for this.

This is great! Thanks for sharing!

>
> > >
> > > > > > >
> > > > > > >
> > > > > > > And this seems to match what QEMU is doing: it clears on unpl=
ug
> > > > > > > not after guest deals with hotplug.
> > >
> > > Oh, that's weird.
> > > It should not unplug the device, so IIUC it should not clear the bit.
> > > Maybe something weird is happening in the guest, I will take a look.
> >
> > Updates on this:
> > You are right! For some reason the guest is hot-unplugging the device u=
nder some
> > conditions, so there is another bug on this for me to look after.
> >
> > >
> > > > > > >
> > > > > > >
> > > > > > > > > Then, during migration, get_pci_config_device() will comp=
are the
> > > > > > > > > configs of both the freshly created device and the one th=
at is being
> > > > > > > > > received via migration, which will differ due to the PCI_=
EXP_SLTSTA_PDS bit
> > > > > > > > > and cause the bug to reproduce.
> > > > > > >
> > > > > > > So bit is set on source.
> > > > > > > But why is the bit cleared on destination? This is the part I=
 don't get.
> > >
> > > No, bit is set when the device is created by qemu.
> > > After some time running (boot process completion) the bit is cleared.
> >
> > The 'after some time' here is about the guest hot-unplugging the device=
.
> >
> > >
> > > The receiving end of migration will then create the device with the b=
it set, and
> > > then wait for migration. After the source device is received, the com=
pare fails
> > > due to those bits being different.
> > >
> >
> > But anyway, there is some chance the device will be hot-unplugged by th=
e guest
> > OS for any reason, so we need to cover this scenario so it does not bre=
ak
> > migration.
> >
> > >
> > >
> > > > > >
> > > > > > My understanding is that when ACPI_PM_PROP_ACPI_PCIHP_BRIDGE is=
 off for the
> > > > > > device, we just won't ever PCI_EXP_SLTSTA_PDS bit?
> > > > >
> > > > > Why?
> > > >
> > > > Never mind, spoke too soon, sorry. :(
> > > >
> > > > I thought pcie_cap_slot_plug_cb() can skip the set, but then I just=
 found
> > > > that dev->hotplugged is not what I imagined there.
> > > >
> > > > Leo should know better.
> > >
> > > There is a difference of which hotplug function is called based on th=
e
> > > ACPI_PM_PROP_ACPI_PCIHP_BRIDGE option:
> > >
> > > When ACPI_PM_PROP_ACPI_PCIHP_BRIDGE=3D=3D"off", hotplug_handler_plug(=
) calls
> > > pcie_cap_slot_plug_cb() which sets the bus dev->config byte 0x6e with=
 bit
> > > PCI_EXP_SLTSTA_PDS.
> > >
> > > When ACPI_PM_PROP_ACPI_PCIHP_BRIDGE=3D=3D"on", hotplug_handler_plug()=
 calls
> > > ich9_pm_device_plug_cb(), which does not set this bit.
> > >
> > > >
> > > > >
> > > > >
> > > > > > >
> > > > > > >
> > > > > > > > > To avoid this fake incompatibility, there are two fields =
in PCIDevice that
> > > > > > > > > can help:
> > > > > > > > >
> > > > > > > > > .wmask: Used to implement R/W bytes, and
> > > > > > > > > .w1cmask: Used to implement RW1C(Write 1 to Clear) bytes
> > > > > > > >
> > > > > > > > Is there one more option to clear the bit in cmask?
> > >
> > > We could clear the bit for .cmask . I suggested w1cmask because I pre=
viously
> > > understood that bit was guest-writeable.
> >
> > IIUC, the bit is guest-writeable, so we should use .wmask instead of .c=
mask .
> > Is this correct?

It was incorrect :/

> >
> > >
> > > > > > > >
> > > > > > > > IIUC w1cmask means the guest can now write to this bit, but=
 afaiu from the
> > > > > > > > pcie spec it's RO.
> > > > > > >
> > > > > > > Yes this bit must be RO.
> > >
> > > My bad, I assumed behavior based on how the guest was working, and th=
is gone
> > > wrong. With above documentation provided, I would suggest clearing th=
e .config
> > > mask related bit so qemu skips checking this one.
> > >
> > > What is your opinion on that?

Michael,
Is the above fine?

If so, I will send a v2 on this.
Any other suggestions?

> > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > According to pcie_cap_slot_init() the slot status registe=
r
> > > > > > > > > (PCI_EXP_SLTSTA), in which PCI_EXP_SLTSTA_PDS is a flag, =
seems to fall
> > > > > > > > > under w1cmask field, with makes sense due to the way sign=
aling the hotplug
> > > > > > > > > works.
> > > > > > > > >
> > > > > > > > > So, add PCI_EXP_SLTSTA_PDS bit to w1cmask, so the fake in=
compatibility on
> > > > > > > > > get_pci_config_device() does not abort the migration.
> > > > > > > > >
> > > > > > > > > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D22=
15819
> > > > > > > > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > > > > > >
> > > > > > > > Do we need a Fixes: and also the need to copy stable?
> > > > > > > >
> > > > > > > > > ---
> > > > > > > > >  hw/pci/pcie.c | 2 +-
> > > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > >
> > > > > > > > > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > > > > > > > > index b8c24cf45f..2def1765a5 100644
> > > > > > > > > --- a/hw/pci/pcie.c
> > > > > > > > > +++ b/hw/pci/pcie.c
> > > > > > > > > @@ -657,7 +657,7 @@ void pcie_cap_slot_init(PCIDevice *de=
v, PCIESlot *s)
> > > > > > > > >                                 PCI_EXP_SLTCTL_EIC);
> > > > > > > > >
> > > > > > > > >      pci_word_test_and_set_mask(dev->w1cmask + pos + PCI_=
EXP_SLTSTA,
> > > > > > > > > -                               PCI_EXP_HP_EV_SUPPORTED);
> > > > > > > > > +                               PCI_EXP_HP_EV_SUPPORTED |=
 PCI_EXP_SLTSTA_PDS);
> > > > > > > > >
> > > > > > > > >      dev->exp.hpev_notified =3D false;
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > 2.41.0
> > > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Peter Xu
> > > > > > >
> > > > > >
> > > > > > --
> > > > > > Peter Xu
> > > > >
> > > >
> > >
>


