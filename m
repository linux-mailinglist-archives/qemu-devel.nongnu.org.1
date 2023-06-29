Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE67F742E16
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 22:08:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qExv0-00087u-B1; Thu, 29 Jun 2023 16:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qExux-00087h-SS
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 16:07:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qExuv-0001jK-Gj
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 16:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688069219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zVgkd1JmN8wFdpC3HS2S5y5po8SoGJ6uqi04H+okG9g=;
 b=NkiPWkBas3lQgh62MA08yEfJj+j6OTVzBWTKwStT9ZsaiRoy+VIPx1ShAFgEHSIWeL58xi
 3aS7lTRlUI/V+daO4/XYlE3dr7w7k1plf3y/aJ3XPZ5JyamCY1obWqGFzZnoIo05XcGLJG
 f4xf9Zk6xlcOxKUfzL2IlkPQgU+2fa0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-KzBkZpfWPP2rzAfGVUBZwA-1; Thu, 29 Jun 2023 16:06:58 -0400
X-MC-Unique: KzBkZpfWPP2rzAfGVUBZwA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31114af5e45so604930f8f.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 13:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688069217; x=1690661217;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zVgkd1JmN8wFdpC3HS2S5y5po8SoGJ6uqi04H+okG9g=;
 b=aksIeYm6rXATedoudbHFBiiXfHLWjRLtADXRV3jLR4fd74t4r7zUtGfIjOTB+jlFZ4
 CiAkoZU8gtGg7OxYRrlfT0r2ydRQXFku5lZ8N5KIjGGrV1dqY0nDZb4Bh47aD5+8J4ws
 IL8BoPRg0wJgz+4mO40ITf5CCEQL9o/7GuHBmZv9rvYKZ2/qnMcGsDPKmGJXWjPjMS/3
 ecGaDDK6oV2oFxPuVS+ODn3Q41YASmzT4E7oJF6E08arobsSekyQBVg1tMrHltFxLmns
 /8lJ8MbDc0Z0NuCel1eX8pp09M2yKzoqJtZPZZl2aEFUv+HTLfs2X5XTEFE8DCrCSIOS
 uJtg==
X-Gm-Message-State: ABy/qLYaSoXbsJVCqRvoLDH/Bi+w/yEOvk/70L2CCwXw+et6DOo353hk
 YexHhvHWPu9NAaMw9yA4U6IB5mIL8E6FOE80hI17k8Br1EU7vmRzwTxBiMLBP80dvPeVUgc02Yc
 1GKf8ozY+QzX3A+A=
X-Received: by 2002:a5d:45d1:0:b0:313:fe1b:f447 with SMTP id
 b17-20020a5d45d1000000b00313fe1bf447mr326953wrs.71.1688069217205; 
 Thu, 29 Jun 2023 13:06:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGwfh72ksWPIMftw0FhuD47DOV0OjFijOCrICElk4TZa5dM/djCj/qAnNZ60NQxudxvcIWgaQ==
X-Received: by 2002:a5d:45d1:0:b0:313:fe1b:f447 with SMTP id
 b17-20020a5d45d1000000b00313fe1bf447mr326941wrs.71.1688069216848; 
 Thu, 29 Jun 2023 13:06:56 -0700 (PDT)
Received: from redhat.com ([2.52.154.169]) by smtp.gmail.com with ESMTPSA id
 p12-20020a5d638c000000b00313f61889e9sm10539136wru.36.2023.06.29.13.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 13:06:56 -0700 (PDT)
Date: Thu, 29 Jun 2023 16:06:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 1/1] pcie: Add hotplug detect state register to w1cmask
Message-ID: <20230629160643-mutt-send-email-mst@kernel.org>
References: <20230629090500.438976-2-leobras@redhat.com> <ZJ25AdfN7AqYkB6z@x1n>
 <20230629152644-mutt-send-email-mst@kernel.org>
 <ZJ3jJTf+iPwPDuf9@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZJ3jJTf+iPwPDuf9@x1n>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Thu, Jun 29, 2023 at 04:01:41PM -0400, Peter Xu wrote:
> On Thu, Jun 29, 2023 at 03:33:06PM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jun 29, 2023 at 01:01:53PM -0400, Peter Xu wrote:
> > > Hi, Leo,
> > > 
> > > Thanks for figuring this out.  Let me copy a few more potential reviewers
> > > from commit 17858a1695 ("hw/acpi/ich9: Set ACPI PCI hot-plug as default on
> > > Q35").
> > > 
> > > On Thu, Jun 29, 2023 at 06:05:00AM -0300, Leonardo Bras wrote:
> > > > When trying to migrate a machine type pc-q35-6.0 or lower, with this
> > > > cmdline options:
> > > > 
> > > > -device driver=pcie-root-port,port=18,chassis=19,id=pcie-root-port18,bus=pcie.0,addr=0x12 \
> > > > -device driver=nec-usb-xhci,p2=4,p3=4,id=nex-usb-xhci0,bus=pcie-root-port18,addr=0x12.0x1
> > > > 
> > > > the following bug happens after all ram pages were sent:
> > > > 
> > > > qemu-kvm: get_pci_config_device: Bad config data: i=0x6e read: 0 device: 40 cmask: ff wmask: 0 w1cmask:19
> > > > qemu-kvm: Failed to load PCIDevice:config
> > > > qemu-kvm: Failed to load pcie-root-port:parent_obj.parent_obj.parent_obj
> > > > qemu-kvm: error while loading state for instance 0x0 of device '0000:00:12.0/pcie-root-port'
> > > > qemu-kvm: load of migration failed: Invalid argument
> > > > 
> > > > This happens on pc-q35-6.0 or lower because of:
> > > > { "ICH9-LPC", ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, "off" }
> > > > 
> > > > In this scenario, hotplug_handler_plug() calls pcie_cap_slot_plug_cb(),
> > > > which sets the bus dev->config byte 0x6e with bit PCI_EXP_SLTSTA_PDS to 
> > > > signal PCI hotplug for the guest. After a while the guest will deal with
> > > > this hotplug and qemu will clear the above bit.
> > 
> > Presence Detect State – This bit indicates the presence of an
> > adapter in the slot, reflected by the logical “OR” of the Physical
> > Layer in-band presence detect mechanism and, if present, any
> > out-of-band presence detect mechanism defined for the slot’s
> > corresponding form factor. Note that the in-band presence
> > detect mechanism requires that power be applied to an adapter
> > for its presence to be detected. Consequently, form factors that
> > require a power controller for hot-plug must implement a
> > physical pin presence detect mechanism.
> > RO
> > Defined encodings are:
> > 0b Slot Empty
> > 1b Card Present in slot
> > This bit must be implemented on all Downstream Ports that
> > implement slots. For Downstream Ports not connected to slots
> > (where the Slot Implemented bit of the PCI Express Capabilities
> > register is 0b), this bit must be hardwired to 1b.
> > 
> > 
> > And this seems to match what QEMU is doing: it clears on unplug
> > not after guest deals with hotplug.
> > 
> > 
> > > > Then, during migration, get_pci_config_device() will compare the
> > > > configs of both the freshly created device and the one that is being
> > > > received via migration, which will differ due to the PCI_EXP_SLTSTA_PDS bit
> > > > and cause the bug to reproduce.
> > 
> > So bit is set on source.
> > But why is the bit cleared on destination? This is the part I don't get.
> 
> My understanding is that when ACPI_PM_PROP_ACPI_PCIHP_BRIDGE is off for the
> device, we just won't ever PCI_EXP_SLTSTA_PDS bit?

Why?


> > 
> > 
> > > > To avoid this fake incompatibility, there are two fields in PCIDevice that
> > > > can help:
> > > > 
> > > > .wmask: Used to implement R/W bytes, and
> > > > .w1cmask: Used to implement RW1C(Write 1 to Clear) bytes
> > > 
> > > Is there one more option to clear the bit in cmask?
> > > 
> > > IIUC w1cmask means the guest can now write to this bit, but afaiu from the
> > > pcie spec it's RO.
> > 
> > Yes this bit must be RO.
> > 
> > > > 
> > > > According to pcie_cap_slot_init() the slot status register
> > > > (PCI_EXP_SLTSTA), in which PCI_EXP_SLTSTA_PDS is a flag, seems to fall
> > > > under w1cmask field, with makes sense due to the way signaling the hotplug
> > > > works.
> > > > 
> > > > So, add PCI_EXP_SLTSTA_PDS bit to w1cmask, so the fake incompatibility on
> > > > get_pci_config_device() does not abort the migration.
> > > > 
> > > > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2215819
> > > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > 
> > > Do we need a Fixes: and also the need to copy stable?
> > > 
> > > > ---
> > > >  hw/pci/pcie.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > > > index b8c24cf45f..2def1765a5 100644
> > > > --- a/hw/pci/pcie.c
> > > > +++ b/hw/pci/pcie.c
> > > > @@ -657,7 +657,7 @@ void pcie_cap_slot_init(PCIDevice *dev, PCIESlot *s)
> > > >                                 PCI_EXP_SLTCTL_EIC);
> > > >  
> > > >      pci_word_test_and_set_mask(dev->w1cmask + pos + PCI_EXP_SLTSTA,
> > > > -                               PCI_EXP_HP_EV_SUPPORTED);
> > > > +                               PCI_EXP_HP_EV_SUPPORTED | PCI_EXP_SLTSTA_PDS);
> > > >  
> > > >      dev->exp.hpev_notified = false;
> > > >  
> > > > -- 
> > > > 2.41.0
> > > > 
> > > 
> > > -- 
> > > Peter Xu
> > 
> 
> -- 
> Peter Xu


