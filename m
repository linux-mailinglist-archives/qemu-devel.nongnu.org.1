Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 444BD742F26
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 22:58:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEyh5-00083g-Mq; Thu, 29 Jun 2023 16:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEyh3-00083Y-D3
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 16:56:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEyh0-00050i-S7
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 16:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688072201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bI8CuEz/HK32gWebRLuNIe7tBrsNxoq/oKyxcW6DbOY=;
 b=hXQnAtYveZKfmhxyb0NCUflPHFJvsjZkqxihyJvznTYwiMXTGrdRdoDZ2TKoCUnGbUGmNv
 QaONRxoWW+9m/d2XHSilKJ4lDxRqDANxcWP9v9eQFOoN2qsUtR1mehOu3pHRdl1M07qeKj
 s4NiNhCzZMKlqZMexcweGWzU7lfAK2o=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-OcR2CmpONcSCi5Ely7YANw-1; Thu, 29 Jun 2023 16:56:39 -0400
X-MC-Unique: OcR2CmpONcSCi5Ely7YANw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-76716078e78so21537385a.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 13:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688072199; x=1690664199;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bI8CuEz/HK32gWebRLuNIe7tBrsNxoq/oKyxcW6DbOY=;
 b=PH1lPie1DKjk7+Aj+Z+brlnV/b2MVh1RVGHpAVEehp3BwdsHR5BZY4yZTJr8mwyMkd
 kJ+yN/dNioXKlpKVp8q5R6aakyS2RVm3dHezou6rD5J/oi5zIZHIneVdruXsNKBw7TGA
 nlRKTGEjUTy1T45zYDerENBLH948E5mHGS/biT1evrHVhYzydM8zAaF8HOoWQoJr3RfK
 8GQQ2pNNemaO26pqRnPqL/DdElWlOu2n435B1ymOLYC8hB/B8NSZeatD/tPufvJhtyfp
 k/vk2JGoC3u9hGkVyDiLcSZ6N9O0VXQY6vEwyAkVieGlj9OM2x2h/PwqxMoVX97fmfMt
 o7Wg==
X-Gm-Message-State: AC+VfDz+rJXoZEAVptgCLFCjvH/iKgJ+ZRSHk2U5IHlrdQHj1MF/zIiH
 gEw/H4m6ryXqCcC6gzyHtyZoX4mOI7qx6RRWi6Hcht/u3cUGb93ZrsJJuZxL6PoeVH235TzT6l5
 pRHhzvB30zKAtYZM=
X-Received: by 2002:a05:620a:4487:b0:765:435c:a4fa with SMTP id
 x7-20020a05620a448700b00765435ca4famr755248qkp.0.1688072198809; 
 Thu, 29 Jun 2023 13:56:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6fO+eKXl+nT4mEDqu2eQu/yKMnqUogaN0Ebi2WP+5KdOXFYsp00s2PqA0veqy0OP4WFDG7pQ==
X-Received: by 2002:a05:620a:4487:b0:765:435c:a4fa with SMTP id
 x7-20020a05620a448700b00765435ca4famr755232qkp.0.1688072198443; 
 Thu, 29 Jun 2023 13:56:38 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 o16-20020a05620a111000b0076548310f04sm6500738qkk.127.2023.06.29.13.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 13:56:38 -0700 (PDT)
Date: Thu, 29 Jun 2023 16:56:32 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 1/1] pcie: Add hotplug detect state register to w1cmask
Message-ID: <ZJ3wAPbroS3jUDuQ@x1n>
References: <20230629090500.438976-2-leobras@redhat.com> <ZJ25AdfN7AqYkB6z@x1n>
 <20230629152644-mutt-send-email-mst@kernel.org>
 <ZJ3jJTf+iPwPDuf9@x1n>
 <20230629160643-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230629160643-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Thu, Jun 29, 2023 at 04:06:53PM -0400, Michael S. Tsirkin wrote:
> On Thu, Jun 29, 2023 at 04:01:41PM -0400, Peter Xu wrote:
> > On Thu, Jun 29, 2023 at 03:33:06PM -0400, Michael S. Tsirkin wrote:
> > > On Thu, Jun 29, 2023 at 01:01:53PM -0400, Peter Xu wrote:
> > > > Hi, Leo,
> > > > 
> > > > Thanks for figuring this out.  Let me copy a few more potential reviewers
> > > > from commit 17858a1695 ("hw/acpi/ich9: Set ACPI PCI hot-plug as default on
> > > > Q35").
> > > > 
> > > > On Thu, Jun 29, 2023 at 06:05:00AM -0300, Leonardo Bras wrote:
> > > > > When trying to migrate a machine type pc-q35-6.0 or lower, with this
> > > > > cmdline options:
> > > > > 
> > > > > -device driver=pcie-root-port,port=18,chassis=19,id=pcie-root-port18,bus=pcie.0,addr=0x12 \
> > > > > -device driver=nec-usb-xhci,p2=4,p3=4,id=nex-usb-xhci0,bus=pcie-root-port18,addr=0x12.0x1
> > > > > 
> > > > > the following bug happens after all ram pages were sent:
> > > > > 
> > > > > qemu-kvm: get_pci_config_device: Bad config data: i=0x6e read: 0 device: 40 cmask: ff wmask: 0 w1cmask:19
> > > > > qemu-kvm: Failed to load PCIDevice:config
> > > > > qemu-kvm: Failed to load pcie-root-port:parent_obj.parent_obj.parent_obj
> > > > > qemu-kvm: error while loading state for instance 0x0 of device '0000:00:12.0/pcie-root-port'
> > > > > qemu-kvm: load of migration failed: Invalid argument
> > > > > 
> > > > > This happens on pc-q35-6.0 or lower because of:
> > > > > { "ICH9-LPC", ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, "off" }
> > > > > 
> > > > > In this scenario, hotplug_handler_plug() calls pcie_cap_slot_plug_cb(),
> > > > > which sets the bus dev->config byte 0x6e with bit PCI_EXP_SLTSTA_PDS to 
> > > > > signal PCI hotplug for the guest. After a while the guest will deal with
> > > > > this hotplug and qemu will clear the above bit.
> > > 
> > > Presence Detect State – This bit indicates the presence of an
> > > adapter in the slot, reflected by the logical “OR” of the Physical
> > > Layer in-band presence detect mechanism and, if present, any
> > > out-of-band presence detect mechanism defined for the slot’s
> > > corresponding form factor. Note that the in-band presence
> > > detect mechanism requires that power be applied to an adapter
> > > for its presence to be detected. Consequently, form factors that
> > > require a power controller for hot-plug must implement a
> > > physical pin presence detect mechanism.
> > > RO
> > > Defined encodings are:
> > > 0b Slot Empty
> > > 1b Card Present in slot
> > > This bit must be implemented on all Downstream Ports that
> > > implement slots. For Downstream Ports not connected to slots
> > > (where the Slot Implemented bit of the PCI Express Capabilities
> > > register is 0b), this bit must be hardwired to 1b.
> > > 
> > > 
> > > And this seems to match what QEMU is doing: it clears on unplug
> > > not after guest deals with hotplug.
> > > 
> > > 
> > > > > Then, during migration, get_pci_config_device() will compare the
> > > > > configs of both the freshly created device and the one that is being
> > > > > received via migration, which will differ due to the PCI_EXP_SLTSTA_PDS bit
> > > > > and cause the bug to reproduce.
> > > 
> > > So bit is set on source.
> > > But why is the bit cleared on destination? This is the part I don't get.
> > 
> > My understanding is that when ACPI_PM_PROP_ACPI_PCIHP_BRIDGE is off for the
> > device, we just won't ever PCI_EXP_SLTSTA_PDS bit?
> 
> Why?

Never mind, spoke too soon, sorry. :(

I thought pcie_cap_slot_plug_cb() can skip the set, but then I just found
that dev->hotplugged is not what I imagined there.

Leo should know better.

> 
> 
> > > 
> > > 
> > > > > To avoid this fake incompatibility, there are two fields in PCIDevice that
> > > > > can help:
> > > > > 
> > > > > .wmask: Used to implement R/W bytes, and
> > > > > .w1cmask: Used to implement RW1C(Write 1 to Clear) bytes
> > > > 
> > > > Is there one more option to clear the bit in cmask?
> > > > 
> > > > IIUC w1cmask means the guest can now write to this bit, but afaiu from the
> > > > pcie spec it's RO.
> > > 
> > > Yes this bit must be RO.
> > > 
> > > > > 
> > > > > According to pcie_cap_slot_init() the slot status register
> > > > > (PCI_EXP_SLTSTA), in which PCI_EXP_SLTSTA_PDS is a flag, seems to fall
> > > > > under w1cmask field, with makes sense due to the way signaling the hotplug
> > > > > works.
> > > > > 
> > > > > So, add PCI_EXP_SLTSTA_PDS bit to w1cmask, so the fake incompatibility on
> > > > > get_pci_config_device() does not abort the migration.
> > > > > 
> > > > > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2215819
> > > > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > > 
> > > > Do we need a Fixes: and also the need to copy stable?
> > > > 
> > > > > ---
> > > > >  hw/pci/pcie.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > > > > index b8c24cf45f..2def1765a5 100644
> > > > > --- a/hw/pci/pcie.c
> > > > > +++ b/hw/pci/pcie.c
> > > > > @@ -657,7 +657,7 @@ void pcie_cap_slot_init(PCIDevice *dev, PCIESlot *s)
> > > > >                                 PCI_EXP_SLTCTL_EIC);
> > > > >  
> > > > >      pci_word_test_and_set_mask(dev->w1cmask + pos + PCI_EXP_SLTSTA,
> > > > > -                               PCI_EXP_HP_EV_SUPPORTED);
> > > > > +                               PCI_EXP_HP_EV_SUPPORTED | PCI_EXP_SLTSTA_PDS);
> > > > >  
> > > > >      dev->exp.hpev_notified = false;
> > > > >  
> > > > > -- 
> > > > > 2.41.0
> > > > > 
> > > > 
> > > > -- 
> > > > Peter Xu
> > > 
> > 
> > -- 
> > Peter Xu
> 

-- 
Peter Xu


