Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C65BF7469CB
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 08:44:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGZlT-0001Ae-VP; Tue, 04 Jul 2023 02:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qGZlS-0001AQ-HP
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 02:43:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qGZlJ-0007oh-Hw
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 02:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688453024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ktGti9wZjksh9AzwFjdaAfAceMrLzpBPYjGKXl9Zjhk=;
 b=GBwGpP/y9AIT49N7kjz87cIt6vtrWxBge6UBSgXyaO8fpWSKBx3L87bz/RR8m56htAapwT
 TzwrrmX98dpWLiqAga8+H8lCzR37igxE9QnOJgsIRPxVPy/VfB3bftPqzY8CViYFD3eXzP
 4CWGorRE+2c8MpHgTNFKdiW3+iWJTwI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-StafzvKbO1muULnV7TgXTg-1; Tue, 04 Jul 2023 02:43:43 -0400
X-MC-Unique: StafzvKbO1muULnV7TgXTg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f84a8b00e3so4962529e87.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 23:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688453021; x=1691045021;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ktGti9wZjksh9AzwFjdaAfAceMrLzpBPYjGKXl9Zjhk=;
 b=D4G8hn1K8A9uWICqQyx70zvcif+dj0/6ttf/zrwpNqXnzPyku1FoWf83BDObjGqe4D
 nxfNSvkpKsgHtv8ZUQ68nEsjqK8NZiDFyFXQvA0Unu8ChNKEMzTodZE+KIII60/8j2MB
 HO1PRO4OnUH0bhMoAbNiHMFBTiYNhcEfOYu4ZmQgpVQWlvkM6L4+mMZKlFIjHBNwZn/M
 Wkx8GfCqANuxjx+L7zqv0YWdtJkcc/qFjYgrVbDabPhkdpB/VHIhUwJDpf1cD3unpJGS
 LXpA2oTtZApyKxEa52b1NEDYQuV16PGtJF28NUPuBTJ7V/bU2Kn3kPRBHjYFIg4C68yB
 6y9Q==
X-Gm-Message-State: ABy/qLbFKzbpFYodQqn0duvYatIOOU3py6GeBjmW8fsxFPicKOTzApa1
 N3nSifVlgw4gzNn9JArrYhQPUPC4myMUzYj4g6zP9miqIDKR+g+vID0WB6YgNgCB4PWRlcLEday
 0DuIdusAXUGC+UIs=
X-Received: by 2002:a05:6512:5cf:b0:4f8:75bb:3301 with SMTP id
 o15-20020a05651205cf00b004f875bb3301mr7605556lfo.20.1688453021610; 
 Mon, 03 Jul 2023 23:43:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEY/hjjM6i20kaEx9mfbaZTdYMNaivhaPta+Yj4GTm4P3uxc3LlV6qEomLvkIk3eVUyvo6OSw==
X-Received: by 2002:a05:6512:5cf:b0:4f8:75bb:3301 with SMTP id
 o15-20020a05651205cf00b004f875bb3301mr7605544lfo.20.1688453021222; 
 Mon, 03 Jul 2023 23:43:41 -0700 (PDT)
Received: from redhat.com ([2.52.13.33]) by smtp.gmail.com with ESMTPSA id
 m16-20020a5d6250000000b003068f5cca8csm27326680wrv.94.2023.07.03.23.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 23:43:40 -0700 (PDT)
Date: Tue, 4 Jul 2023 02:43:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 1/1] pcie: Add hotplug detect state register to w1cmask
Message-ID: <20230704024051-mutt-send-email-mst@kernel.org>
References: <20230629090500.438976-2-leobras@redhat.com> <ZJ25AdfN7AqYkB6z@x1n>
 <20230629152644-mutt-send-email-mst@kernel.org>
 <ZJ3jJTf+iPwPDuf9@x1n>
 <20230629160643-mutt-send-email-mst@kernel.org>
 <ZJ3wAPbroS3jUDuQ@x1n>
 <ee67338be410a91a03e5514520141404be0e26f5.camel@redhat.com>
 <2364a62d0cc278c43dd19da4aceeee70513990e1.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2364a62d0cc278c43dd19da4aceeee70513990e1.camel@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Tue, Jul 04, 2023 at 03:20:36AM -0300, Leonardo Brás wrote:
> Hello Peter and Michael, I have a few updates on this:
> 
> On Mon, 2023-07-03 at 02:20 -0300, Leonardo Brás wrote:
> > Hello Peter and Michael, thanks for reviewing!
> > 
> > 
> > On Thu, 2023-06-29 at 16:56 -0400, Peter Xu wrote:
> > > On Thu, Jun 29, 2023 at 04:06:53PM -0400, Michael S. Tsirkin wrote:
> > > > On Thu, Jun 29, 2023 at 04:01:41PM -0400, Peter Xu wrote:
> > > > > On Thu, Jun 29, 2023 at 03:33:06PM -0400, Michael S. Tsirkin wrote:
> > > > > > On Thu, Jun 29, 2023 at 01:01:53PM -0400, Peter Xu wrote:
> > > > > > > Hi, Leo,
> > > > > > > 
> > > > > > > Thanks for figuring this out.  Let me copy a few more potential reviewers
> > > > > > > from commit 17858a1695 ("hw/acpi/ich9: Set ACPI PCI hot-plug as default on
> > > > > > > Q35").
> > > > > > > 
> > > > > > > On Thu, Jun 29, 2023 at 06:05:00AM -0300, Leonardo Bras wrote:
> > > > > > > > When trying to migrate a machine type pc-q35-6.0 or lower, with this
> > > > > > > > cmdline options:
> > > > > > > > 
> > > > > > > > -device driver=pcie-root-port,port=18,chassis=19,id=pcie-root-port18,bus=pcie.0,addr=0x12 \
> > > > > > > > -device driver=nec-usb-xhci,p2=4,p3=4,id=nex-usb-xhci0,bus=pcie-root-port18,addr=0x12.0x1
> > > > > > > > 
> > > > > > > > the following bug happens after all ram pages were sent:
> > > > > > > > 
> > > > > > > > qemu-kvm: get_pci_config_device: Bad config data: i=0x6e read: 0 device: 40 cmask: ff wmask: 0 w1cmask:19
> > > > > > > > qemu-kvm: Failed to load PCIDevice:config
> > > > > > > > qemu-kvm: Failed to load pcie-root-port:parent_obj.parent_obj.parent_obj
> > > > > > > > qemu-kvm: error while loading state for instance 0x0 of device '0000:00:12.0/pcie-root-port'
> > > > > > > > qemu-kvm: load of migration failed: Invalid argument
> > > > > > > > 
> > > > > > > > This happens on pc-q35-6.0 or lower because of:
> > > > > > > > { "ICH9-LPC", ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, "off" }
> > > > > > > > 
> > > > > > > > In this scenario, hotplug_handler_plug() calls pcie_cap_slot_plug_cb(),
> > > > > > > > which sets the bus dev->config byte 0x6e with bit PCI_EXP_SLTSTA_PDS to 
> > > > > > > > signal PCI hotplug for the guest. After a while the guest will deal with
> > > > > > > > this hotplug and qemu will clear the above bit.
> > > > > > 
> > > > > > Presence Detect State – This bit indicates the presence of an
> > > > > > adapter in the slot, reflected by the logical “OR” of the Physical
> > > > > > Layer in-band presence detect mechanism and, if present, any
> > > > > > out-of-band presence detect mechanism defined for the slot’s
> > > > > > corresponding form factor. Note that the in-band presence
> > > > > > detect mechanism requires that power be applied to an adapter
> > > > > > for its presence to be detected. Consequently, form factors that
> > > > > > require a power controller for hot-plug must implement a
> > > > > > physical pin presence detect mechanism.
> > > > > > RO
> > > > > > Defined encodings are:
> > > > > > 0b Slot Empty
> > > > > > 1b Card Present in slot
> > > > > > This bit must be implemented on all Downstream Ports that
> > > > > > implement slots. For Downstream Ports not connected to slots
> > > > > > (where the Slot Implemented bit of the PCI Express Capabilities
> > > > > > register is 0b), this bit must be hardwired to 1b.
> > 
> > Thank you for providing this doc!
> > I am new to PCI stuff, could you please point this doc?
> 
> (I mean, the link to the documentation)

The pci specs are all here: https://pcisig.com/
Red Hat is a member so just register, it's free.

I'd get the 5.0 version of pci express base:
https://members.pcisig.com/wg/PCI-SIG/document/13005

6.0 is out but they did something to make it take years to open,
and it shouldn't matter for this.

> > 
> > > > > > 
> > > > > > 
> > > > > > And this seems to match what QEMU is doing: it clears on unplug
> > > > > > not after guest deals with hotplug.
> > 
> > Oh, that's weird.
> > It should not unplug the device, so IIUC it should not clear the bit.
> > Maybe something weird is happening in the guest, I will take a look.
> 
> Updates on this:
> You are right! For some reason the guest is hot-unplugging the device under some
> conditions, so there is another bug on this for me to look after.
> 
> > 
> > > > > > 
> > > > > > 
> > > > > > > > Then, during migration, get_pci_config_device() will compare the
> > > > > > > > configs of both the freshly created device and the one that is being
> > > > > > > > received via migration, which will differ due to the PCI_EXP_SLTSTA_PDS bit
> > > > > > > > and cause the bug to reproduce.
> > > > > > 
> > > > > > So bit is set on source.
> > > > > > But why is the bit cleared on destination? This is the part I don't get.
> > 
> > No, bit is set when the device is created by qemu.
> > After some time running (boot process completion) the bit is cleared.
> 
> The 'after some time' here is about the guest hot-unplugging the device.
> 
> > 
> > The receiving end of migration will then create the device with the bit set, and
> > then wait for migration. After the source device is received, the compare fails
> > due to those bits being different.
> > 
> 
> But anyway, there is some chance the device will be hot-unplugged by the guest
> OS for any reason, so we need to cover this scenario so it does not break
> migration.
> 
> > 
> > 
> > > > > 
> > > > > My understanding is that when ACPI_PM_PROP_ACPI_PCIHP_BRIDGE is off for the
> > > > > device, we just won't ever PCI_EXP_SLTSTA_PDS bit?
> > > > 
> > > > Why?
> > > 
> > > Never mind, spoke too soon, sorry. :(
> > > 
> > > I thought pcie_cap_slot_plug_cb() can skip the set, but then I just found
> > > that dev->hotplugged is not what I imagined there.
> > > 
> > > Leo should know better.
> > 
> > There is a difference of which hotplug function is called based on the 
> > ACPI_PM_PROP_ACPI_PCIHP_BRIDGE option:
> > 
> > When ACPI_PM_PROP_ACPI_PCIHP_BRIDGE=="off", hotplug_handler_plug() calls
> > pcie_cap_slot_plug_cb() which sets the bus dev->config byte 0x6e with bit
> > PCI_EXP_SLTSTA_PDS.
> > 
> > When ACPI_PM_PROP_ACPI_PCIHP_BRIDGE=="on", hotplug_handler_plug() calls
> > ich9_pm_device_plug_cb(), which does not set this bit.
> > 
> > > 
> > > > 
> > > > 
> > > > > > 
> > > > > > 
> > > > > > > > To avoid this fake incompatibility, there are two fields in PCIDevice that
> > > > > > > > can help:
> > > > > > > > 
> > > > > > > > .wmask: Used to implement R/W bytes, and
> > > > > > > > .w1cmask: Used to implement RW1C(Write 1 to Clear) bytes
> > > > > > > 
> > > > > > > Is there one more option to clear the bit in cmask?
> > 
> > We could clear the bit for .cmask . I suggested w1cmask because I previously
> > understood that bit was guest-writeable.
> 
> IIUC, the bit is guest-writeable, so we should use .wmask instead of .cmask .
> Is this correct?
> 
> > 
> > > > > > > 
> > > > > > > IIUC w1cmask means the guest can now write to this bit, but afaiu from the
> > > > > > > pcie spec it's RO.
> > > > > > 
> > > > > > Yes this bit must be RO.
> > 
> > My bad, I assumed behavior based on how the guest was working, and this gone
> > wrong. With above documentation provided, I would suggest clearing the .config
> > mask related bit so qemu skips checking this one.
> > 
> > What is your opinion on that?
> > 
> > > > > > 
> > > > > > > > 
> > > > > > > > According to pcie_cap_slot_init() the slot status register
> > > > > > > > (PCI_EXP_SLTSTA), in which PCI_EXP_SLTSTA_PDS is a flag, seems to fall
> > > > > > > > under w1cmask field, with makes sense due to the way signaling the hotplug
> > > > > > > > works.
> > > > > > > > 
> > > > > > > > So, add PCI_EXP_SLTSTA_PDS bit to w1cmask, so the fake incompatibility on
> > > > > > > > get_pci_config_device() does not abort the migration.
> > > > > > > > 
> > > > > > > > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2215819
> > > > > > > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > > > > > 
> > > > > > > Do we need a Fixes: and also the need to copy stable?
> > > > > > > 
> > > > > > > > ---
> > > > > > > >  hw/pci/pcie.c | 2 +-
> > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > 
> > > > > > > > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > > > > > > > index b8c24cf45f..2def1765a5 100644
> > > > > > > > --- a/hw/pci/pcie.c
> > > > > > > > +++ b/hw/pci/pcie.c
> > > > > > > > @@ -657,7 +657,7 @@ void pcie_cap_slot_init(PCIDevice *dev, PCIESlot *s)
> > > > > > > >                                 PCI_EXP_SLTCTL_EIC);
> > > > > > > >  
> > > > > > > >      pci_word_test_and_set_mask(dev->w1cmask + pos + PCI_EXP_SLTSTA,
> > > > > > > > -                               PCI_EXP_HP_EV_SUPPORTED);
> > > > > > > > +                               PCI_EXP_HP_EV_SUPPORTED | PCI_EXP_SLTSTA_PDS);
> > > > > > > >  
> > > > > > > >      dev->exp.hpev_notified = false;
> > > > > > > >  
> > > > > > > > -- 
> > > > > > > > 2.41.0
> > > > > > > > 
> > > > > > > 
> > > > > > > -- 
> > > > > > > Peter Xu
> > > > > > 
> > > > > 
> > > > > -- 
> > > > > Peter Xu
> > > > 
> > > 
> > 


