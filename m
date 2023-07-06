Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 826EF74A380
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 19:59:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHTFK-0005jI-7Q; Thu, 06 Jul 2023 13:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1qHTFD-0005ik-8e
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 13:58:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1qHTFA-0000du-Rf
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 13:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688666294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K6vjTDqRH+GV7CGi66XdjlxLwv01u+P9iHXlIShqWmE=;
 b=B0Y+//8koS4o7VRVRofgX7dVyEvhG0tFfS3COkWCRBN7T2hpDwRUd4duS8BkX1d6+toyIo
 nS3s2eq72JKy36kuWsePNcDiAYeWS2BgMtRUnYJi2Mglox/aW2E08M9rZIIfNyjX71iS11
 ad6cJBoCabxrvpjfO0DTUAGIVuGhrfk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-lIdX3m0gPRCdIOVpoOsyAA-1; Thu, 06 Jul 2023 13:58:13 -0400
X-MC-Unique: lIdX3m0gPRCdIOVpoOsyAA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-76783ba6d62so118310685a.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 10:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688666293; x=1691258293;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K6vjTDqRH+GV7CGi66XdjlxLwv01u+P9iHXlIShqWmE=;
 b=K37pmFk+nL3+aNepsyk1moAV7IyXAvHb7s9Zy31IuespNSjN8WqajtJkoBKpAG4t0C
 GTIIApTf4m0oYBfF4XiKyiSUvB7A6B43hUtS/LqRmOqp1B8lQ0+K0N2GrzrGHYZYc1eB
 nhVG14lXfe2pMIskAd6DdrN6ze+CYpaJY8YD4LG5uJ1O1wEtvfJEYF4ZnIAK8Z8inhbF
 SGYW8i2plLWCcPHIhtzcDi3DlhC+xs6vIuvFiXQMS9nIxGvjpAA2ha3EFoKbJE2jxI1/
 RJa6Ui2hfomEo+WDInaLIuyWU62XOZBVgAC5zf+w4a+U0v7WYocr7LtvxYacx7V19STV
 rKpQ==
X-Gm-Message-State: ABy/qLYAtMpdZ3VK9VeWs7WwtNl08hLV7k3JMC8SnR1thVGigB7IAB2p
 uAYjS+PvnUJ0boZL90rVdcnYJAFIBfaqeywcxI1carUVc8E0uzNMEtH6m60lRdaJhyqw6dGCYjJ
 5kZvkZF+58osAkM+iVZ3JVsYptLko8AI=
X-Received: by 2002:ac8:7f54:0:b0:403:691f:5403 with SMTP id
 g20-20020ac87f54000000b00403691f5403mr3197264qtk.67.1688666293162; 
 Thu, 06 Jul 2023 10:58:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHJRlsw6n4ZLZmdv5xdhcJgkc3iSyziDheBTLCiEsWdd4VC1X0tZP0ga6YsP3p50zuYc65TITvWwFv445Ue0RE=
X-Received: by 2002:ac8:7f54:0:b0:403:691f:5403 with SMTP id
 g20-20020ac87f54000000b00403691f5403mr3197248qtk.67.1688666292803; Thu, 06
 Jul 2023 10:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230706045546.593605-3-leobras@redhat.com>
 <87o7kpbid7.fsf@secure.mitica>
In-Reply-To: <87o7kpbid7.fsf@secure.mitica>
From: Leonardo Bras Soares Passos <leobras@redhat.com>
Date: Thu, 6 Jul 2023 14:58:02 -0300
Message-ID: <CAJ6HWG7QHHd=zp5g0KH7uxK9eXEp5CQ6SkFTMpQPUahy0AM5pA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] pcie: Add hotplug detect state register to cmask
To: quintela@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
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

On Thu, Jul 6, 2023 at 4:37=E2=80=AFAM Juan Quintela <quintela@redhat.com> =
wrote:
>
> Leonardo Bras <leobras@redhat.com> wrote:
> > When trying to migrate a machine type pc-q35-6.0 or lower, with this
> > cmdline options,
> >
> > -device driver=3Dpcie-root-port,port=3D18,chassis=3D19,id=3Dpcie-root-p=
ort18,bus=3Dpcie.0,addr=3D0x12 \
> > -device driver=3Dnec-usb-xhci,p2=3D4,p3=3D4,id=3Dnex-usb-xhci0,bus=3Dpc=
ie-root-port18,addr=3D0x12.0x1
> >
> > the following bug happens after all ram pages were sent:
> >
> > qemu-kvm: get_pci_config_device: Bad config data: i=3D0x6e read: 0 devi=
ce: 40 cmask: ff wmask: 0 w1cmask:19
> > qemu-kvm: Failed to load PCIDevice:config
> > qemu-kvm: Failed to load pcie-root-port:parent_obj.parent_obj.parent_ob=
j
> > qemu-kvm: error while loading state for instance 0x0 of device '0000:00=
:12.0/pcie-root-port'
> > qemu-kvm: load of migration failed: Invalid argument
> >
> > This happens on pc-q35-6.0 or lower because of:
> > { "ICH9-LPC", ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, "off" }
> >
> > In this scenario, hotplug_handler_plug() calls pcie_cap_slot_plug_cb(),
> > which sets dev->config byte 0x6e with bit PCI_EXP_SLTSTA_PDS to signal =
PCI
> > hotplug for the guest. After a while the guest will deal with this hotp=
lug
> > and qemu will clear the above bit.
> >
> > Then, during migration, get_pci_config_device() will compare the
> > configs of both the freshly created device and the one that is being
> > received via migration, which will differ due to the PCI_EXP_SLTSTA_PDS=
 bit
> > and cause the bug to reproduce.
> >
> > To avoid this fake incompatibility, there are tree fields in PCIDevice =
that
> > can help:
> >
> > - wmask: Used to implement R/W bytes, and
> > - w1cmask: Used to implement RW1C(Write 1 to Clear) bytes
> > - cmask: Used to enable config checks on load.
> >
> > According to PCI Express=C2=AE Base Specification Revision 5.0 Version =
1.0,
> > table 7-27 (Slot Status Register) bit 6, the "Presence Detect State" is
> > listed as RO (read-only), so it only makes sense to make use of the cma=
sk
> > field.
> >
> > So, clear PCI_EXP_SLTSTA_PDS bit on cmask, so the fake incompatibility =
on
> > get_pci_config_device() does not abort the migration.
> >
> > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D2215819
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
>
>
>
>
> > ---
> >  hw/pci/pcie.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > index b8c24cf45f..cae56bf1c8 100644
> > --- a/hw/pci/pcie.c
> > +++ b/hw/pci/pcie.c
> > @@ -659,6 +659,10 @@ void pcie_cap_slot_init(PCIDevice *dev, PCIESlot *=
s)
> >      pci_word_test_and_set_mask(dev->w1cmask + pos + PCI_EXP_SLTSTA,
> >                                 PCI_EXP_HP_EV_SUPPORTED);
> >
> > +    /* Avoid migration abortion when this device hot-removed by guest
> > */
>
> I would have included here the text in the commit:
>
>  According to PCI Express=C2=AE Base Specification Revision 5.0 Version 1=
.0,
>  table 7-27 (Slot Status Register) bit 6, the "Presence Detect State" is
>  listed as RO (read-only), so it only makes sense to make use of the cmas=
k
>  field.
>
> and
>
> This happens on pc-q35-6.0 or lower because of:
> { "ICH9-LPC", ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, "off" }
>
> so if we ever remove the machine type pc-q35-6.0, we can drop it.

It makes sense adding this to the code.

In the remove machine-type case, IIUC we would have to drop every
machine-type older than pc-q35-6.0.
Also,  we would not support migration to any machine without
ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, right?

>
> Yes, I know that we don't drop machine types, but we should at some point=
.
>
>
> > +    pci_word_test_and_clear_mask(dev->cmask + pos + PCI_EXP_SLTSTA,
> > +                                 PCI_EXP_SLTSTA_PDS);
> > +
> >      dev->exp.hpev_notified =3D false;
> >
> >      qbus_set_hotplug_handler(BUS(pci_bridge_get_sec_bus(PCI_BRIDGE(dev=
))),
>
> I agree that this is (at least) a step on the right direction.
>
> I wmould had expected to have to need some check related to the value
> of:
>
> { "ICH9-LPC", ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, "off" }
>

This bug affects versions older than qemu 6.0. If we add this, we
would have some extra work backporting this to older versions (if
necessary) because the 'property' did not exist back then.

> But I will not claim _any_ understanding of the PCI specification.
>
> So:
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
>
> about that it fixes the migration bug.
>

Thanks Juan!
Leo


