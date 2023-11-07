Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 821767E3AD3
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 12:13:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Jzw-00076R-Qg; Tue, 07 Nov 2023 06:11:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0Jzs-00071r-34
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 06:11:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0Jzp-0005yw-Ep
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 06:11:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699355507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X5Klj/MS8aQgTJ+oNZtvkYTCw6NiMdnsetpogemoMtE=;
 b=e7swejFrFtilUw6PAyOtlp9ykTdz7XUO8l3vK4ybpPt48CZA2i9UjM2TXUA49KWAQC2+pq
 HJPD70D2Luq1KGJ9S5AMBcmG4dzvQNn7m72tV3QjwAeaE7wTn3wxx+ogLmtRfjij8IqxiV
 nx7Udfxa+Mm1xsqNteH+wj07DsyzATc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-HBppblAoNbOb2KCbzyvCRw-1; Tue,
 07 Nov 2023 06:11:41 -0500
X-MC-Unique: HBppblAoNbOb2KCbzyvCRw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 057C71C294AA;
 Tue,  7 Nov 2023 11:11:41 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D30941121307;
 Tue,  7 Nov 2023 11:11:39 +0000 (UTC)
Date: Tue, 7 Nov 2023 12:11:38 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: jsnow@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 balaton@eik.bme.hu, philmd@linaro.org, shentey@gmail.com
Subject: Re: [PATCH v2 1/3] ide/pci.c: introduce pci_ide_update_mode() function
Message-ID: <ZUobajEv5cZsXa6g@redhat.com>
References: <20231024224056.842607-1-mark.cave-ayland@ilande.co.uk>
 <20231024224056.842607-2-mark.cave-ayland@ilande.co.uk>
 <ZUj0S6GqGhZ6kOp9@redhat.com>
 <9d3142cf-fb35-499a-bd2f-b799bfbfd2c1@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d3142cf-fb35-499a-bd2f-b799bfbfd2c1@ilande.co.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

Am 06.11.2023 um 23:41 hat Mark Cave-Ayland geschrieben:
> On 06/11/2023 14:12, Kevin Wolf wrote:
> 
> Hi Kevin,
> 
> Thanks for taking the time to review this. I'll reply inline below.
> 
> > Am 25.10.2023 um 00:40 hat Mark Cave-Ayland geschrieben:
> > > This function reads the value of the PCI_CLASS_PROG register for PCI IDE
> > > controllers and configures the PCI BARs and/or IDE ioports accordingly.
> > > 
> > > In the case where we switch to legacy mode, the PCI BARs are set to return zero
> > > (as suggested in the "PCI IDE Controller" specification), the legacy IDE ioports
> > > are enabled, and the PCI interrupt pin cleared to indicate legacy IRQ routing.
> > > 
> > > Conversely when we switch to native mode, the legacy IDE ioports are disabled
> > > and the PCI interrupt pin set to indicate native IRQ routing. The contents of
> > > the PCI BARs are unspecified, but this is not an issue since if a PCI IDE
> > > controller has been switched to native mode then its BARs will need to be
> > > programmed.
> > > 
> > > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > > Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
> > > Tested-by: Bernhard Beschow <shentey@gmail.com>
> > > ---
> > >   hw/ide/pci.c         | 90 ++++++++++++++++++++++++++++++++++++++++++++
> > >   include/hw/ide/pci.h |  1 +
> > >   2 files changed, 91 insertions(+)
> > > 
> > > diff --git a/hw/ide/pci.c b/hw/ide/pci.c
> > > index a25b352537..5be643b460 100644
> > > --- a/hw/ide/pci.c
> > > +++ b/hw/ide/pci.c
> > > @@ -104,6 +104,96 @@ const MemoryRegionOps pci_ide_data_le_ops = {
> > >       .endianness = DEVICE_LITTLE_ENDIAN,
> > >   };
> > > +static const MemoryRegionPortio ide_portio_list[] = {
> > > +    { 0, 8, 1, .read = ide_ioport_read, .write = ide_ioport_write },
> > > +    { 0, 1, 2, .read = ide_data_readw, .write = ide_data_writew },
> > > +    { 0, 1, 4, .read = ide_data_readl, .write = ide_data_writel },
> > > +    PORTIO_END_OF_LIST(),
> > > +};
> > > +
> > > +static const MemoryRegionPortio ide_portio2_list[] = {
> > > +    { 0, 1, 1, .read = ide_status_read, .write = ide_ctrl_write },
> > > +    PORTIO_END_OF_LIST(),
> > > +};
> > 
> > This is duplicated from hw/ide/ioport.c. I think it would be better to
> > use the arrays already defined there, ideally by calling ioport.c
> > functions to setup and release the I/O ports.
> 
> The tricky part here is that hw/ide/ioport.c is defined for CONFIG_ISA, and
> so if we did that then all PCI IDE controllers would become dependent upon
> ISA too, regardless of whether they implement compatibility mode or not.
> What do you think is the best solution here? Perhaps moving
> ide_init_ioport() to a more ISA-specific place? I know that both myself and
> Phil have considered whether ide_init_ioport() should be replaced by
> something else further down the line.

Hm, yes, I didn't think about this.

Splitting ioport.c is one option, but even the port lists are really
made for ISA, so the whole file is really ISA related.

On the other hand, pci_ide_update_mode() isn't really a pure PCI
function, it's at the intersection of PCI and ISA. Can we just #ifdef it
out if ISA isn't built? Devices that don't support compatibility mode
should never try to call pci_ide_update_mode().

> > > +void pci_ide_update_mode(PCIIDEState *s)
> > > +{
> > > +    PCIDevice *d = PCI_DEVICE(s);
> > > +    uint8_t mode = d->config[PCI_CLASS_PROG];
> > > +
> > > +    switch (mode & 0xf) {
> > > +    case 0xa:
> > > +        /* Both channels legacy mode */
> > 
> > Why is it ok to handle only the case where both channels are set to the
> > same mode? The spec describes mixed-mode setups, too, and doesn't seem
> > to allow ignoring a mode change if it's only for one of the channels.
> 
> Certainly that can be done: only both channels were implemented initially
> because that was the test case immediately available using the VIA. I can
> have a look at implementing both channels separately in v2.

I don't think it would make the code more complicated, so it feels like
implementing it right away would be nice.

On the other hand, if you want to see this in 8.2, I'm happy to merge
this part as it is and then we can improve it on top.

> > > +
> > > +        /* Zero BARs */
> > > +        pci_set_long(d->config + PCI_BASE_ADDRESS_0, 0x0);
> > > +        pci_set_long(d->config + PCI_BASE_ADDRESS_1, 0x0);
> > > +        pci_set_long(d->config + PCI_BASE_ADDRESS_2, 0x0);
> > > +        pci_set_long(d->config + PCI_BASE_ADDRESS_3, 0x0);
> > 
> > Here I'm not sure what the spec really implies. Disabling the BAR (i.e.
> > making it read-only and returning 0) while in compatibility mode doesn't
> > necessarily mean that the value of the register is lost. In other words,
> > are we sure that a driver can't expect that the old value is still there
> > when it re-enables native mode?
> 
> The specification is definitely a bit vague on the details here. In the
> testing I've done with the VIA, there is only ever a switch from native to
> legacy mode, and not the other way around. I can see the logic that once
> you've gone from the native to legacy mode, the memory allocated for the
> BARs is already reserved by the OS so in theory it could be possible to
> switch back to native mode again... and that would work if the BARs are
> preserved.
> 
> Would it happen in practice? I'm not really sure, but I can try to implement
> this if you think it makes sense to take a safer approach.

I'm not sure if any driver tries to do something like this. Maybe a
situation where BIOS switches to compatibility mode and then the OS to
native again? But it does feel safer.

The other option would be to not zero out the BAR at all. Doing that is
optional according to the spec. But then we need to make sure that we
ignore any access to the memory region behind the BAR even though its
address is still there.

Come to think of it, don't we need to somehow disable the memory regions
described by the BARs even when we zero them out? I think updating the
config space without calling pci_update_mappings() doesn't actually stop
QEMU from reacting to reads and writes there, does it?

Otherwise, the guest doesn't see the memory region in the BAR any more,
but it would still be active (which is almost the opposite of what we're
supposed to do).

> > > +        /* Clear interrupt pin */
> > > +        pci_config_set_interrupt_pin(d->config, 0);
> > 
> > Unlike for the BARs, I don't see anything in the spec that allows
> > disabling this byte. I doubt it hurts in practice, but did you see any
> > drivers requiring this? According to the spec, we just must not use the
> > PCI interrupt in compatbility mode, but the registers stay accessible.
> 
> The PCI config dumps taken from a real VIA indicate that this byte is
> cleared in legacy mode, and that appears to make sense here. If you imagine
> an early PCI IDE controller, it will always start up in legacy mode and so
> you don't want to indicate to the guest OS that PCI IRQ routing is required
> unless it has been switched to native mode first.

Ok. I assume that with a per-channel control, you would clear it only if
both channels are in compatibility mode, and set it as soon as one
channel is in native mode?

> > As far as I can see, the whole PCI interrupt configuration is currently
> > unused anyway, and nothing in this series seems to change it. So won't
> > we incorrectly continue to use the legacy interrupt even in native mode?
> > (Actually, cmd646 seems to get it wrong the other way around and uses
> > the PCI interrupt even in compatibility mode.)
> > 
> > I think this means that BMDMAState needs to have two irq lines (a legacy
> > and a PCI one) and select the right one in bmdma_irq() depending on
> > which mode we're in currently.
> 
> I need to flesh out the details a bit more (in particular testing with more
> than just the VIA PCI IDE controller), but yes the eventual aim is to
> consolidate the majority of the BMDMA and mode switching code into
> hw/ide/pci.c so the individual controllers don't need to worry about this,
> and everything "just works".

Zoltan's reply for patch 3 actuallys say that it's correct like this for
the VIA controller, in conflict with what the spec says. So it seems
that we can't make it "just work" for everyone, but we still need to
allow devices to intercept it at least.

As I said there, adding a comment in the via emulation should be enough
for now, and we can leave proper generic interrupt handling for another
day (when we want to add switching to a model that's actually consistent
with the spec).

Maybe also leave a TODO comment at the top of this function to remind
other users that interrupt handling needs to be covered by individual
devices for now.

Kevin


