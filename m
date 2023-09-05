Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52724793065
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 22:53:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdd1r-0005Mi-LI; Tue, 05 Sep 2023 16:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qdd1p-0005MN-TG
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 16:52:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qdd1n-0002Yp-ED
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 16:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693947121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XGnAiobMGJLQSeZP5L07JWqXlIsjBFywJcjrqYjcPm0=;
 b=P29dY2BsQG/rzty9M6IuMuXuvy7bFa7AOC2ubgt5pgR06nAr5EI5xIFRCV3vQLMjqAYjAM
 blUoKCUELDIfwuWVKdSKYDom+ixNcNc3bXaLP9YI+zg9jaIIOzfVoUQ8VQzQFEDZohS6cv
 PNa17KjYhKFLmtLbk5RJj3T9GQ/EMw8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-2OEmTbwsO_GI7Arxf_SfZQ-1; Tue, 05 Sep 2023 16:52:00 -0400
X-MC-Unique: 2OEmTbwsO_GI7Arxf_SfZQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-52e3bada3d9so1779953a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 13:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693947119; x=1694551919;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XGnAiobMGJLQSeZP5L07JWqXlIsjBFywJcjrqYjcPm0=;
 b=YEvcWB4ReOouVC8X/tBPP595Pt0zUcMHJqAhyMo2dDapLsTR0d3mwazpiXILFxQmLE
 MVLFszsHSuuzKI+8TMMfWqhZfzX+tVgwjV/9p4fE4AK+2BtEx/59zV4UC9HK5c5WDzc1
 VFbwTZL3cumO0ZqTYm4fDb2uSwH+70/wDo7s/KXtiwrlthMmR/84FCjyFvD2x4P5tmqv
 n2xYYSLbUVixv3UJ0OBMqLXAL3s66F0owgSOrNNYppVM7I9xCl6H5UrPnfhYKd3GvF9S
 osroscLdjFwuXgQgX9zFCxixZntSGU8gNO8RuexZs9Wbi8ZYmy0Yt4+R5W1xgP8EolwY
 TjTw==
X-Gm-Message-State: AOJu0Yyv4i6A3DF2YRou8lCA+XRwfymoDDpfAOW00/ZvOV33QmfUOL37
 iBOOciuYoQUgSaEY+VWjH9sDxxA6IVb8hior08f+srWO1R3CQNBx7o8ElXVp8Q4DkCdR/Egf/8Y
 iz2Txg/myP5VA4r4=
X-Received: by 2002:a17:906:2009:b0:9a1:be50:ae61 with SMTP id
 9-20020a170906200900b009a1be50ae61mr671992ejo.69.1693947119325; 
 Tue, 05 Sep 2023 13:51:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdTzn1srygv5VAWmXV9ruxD3+eXcQbea1dCIHCcrYpC2z1Tst3aTHwZuAWDlg91LPcKZh7eQ==
X-Received: by 2002:a17:906:2009:b0:9a1:be50:ae61 with SMTP id
 9-20020a170906200900b009a1be50ae61mr671984ejo.69.1693947119006; 
 Tue, 05 Sep 2023 13:51:59 -0700 (PDT)
Received: from redhat.com ([2.52.23.134]) by smtp.gmail.com with ESMTPSA id
 pw9-20020a17090720a900b0098884f86e41sm7917963ejb.123.2023.09.05.13.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 13:51:58 -0700 (PDT)
Date: Tue, 5 Sep 2023 16:51:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: andychiu <andychiu@synology.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [Qemu-devel] [PATCH] ahci: enable pci bus master MemoryRegion
 before loading ahci engines
Message-ID: <20230905164647-mutt-send-email-mst@kernel.org>
References: <1568049517-10261-1-git-send-email-andychiu@synology.com>
 <20190910025404-mutt-send-email-mst@kernel.org>
 <9f402933-7256-75da-af77-2e47b656ab27@redhat.com>
 <20190910095329-mutt-send-email-mst@kernel.org>
 <a4a39c82-e5bc-71e9-28e8-25a0c68e2d6e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4a39c82-e5bc-71e9-28e8-25a0c68e2d6e@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 10, 2019 at 10:08:20AM -0400, John Snow wrote:
> 
> 
> On 9/10/19 9:58 AM, Michael S. Tsirkin wrote:
> > On Tue, Sep 10, 2019 at 09:50:41AM -0400, John Snow wrote:
> >>
> >>
> >> On 9/10/19 3:04 AM, Michael S. Tsirkin wrote:
> >>> On Tue, Sep 10, 2019 at 01:18:37AM +0800, andychiu wrote:
> >>>> If Windows 10 guests have enabled 'turn off hard disk after idle'
> >>>> option in power settings, and the guest has a SATA disk plugged in,
> >>>> the SATA disk will be turned off after a specified idle time.
> >>>> If the guest is live migrated or saved/loaded with its SATA disk
> >>>> turned off, the following error will occur:
> >>>>
> >>>> qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS receive buffer address
> >>>> qemu-system-x86_64: Failed to load ich9_ahci:ahci
> >>>> qemu-system-x86_64: error while loading state for instance 0x0 of device '0000:00:1a.0/ich9_ahci'
> >>>> qemu-system-x86_64: load of migration failed: Operation not permitted
> >>>>
> >>>> Observation from trace logs shows that a while after Windows 10 turns off
> >>>> a SATA disk (IDE disks don't have the following behavior),
> >>>> it will disable the PCI_COMMAND_MASTER flag of the pci device containing
> >>>> the ahci device. When the the disk is turning back on,
> >>>> the PCI_COMMAND_MASTER flag will be restored first.
> >>>> But if the guest is migrated or saved/loaded while the disk is off,
> >>>> the post_load callback of ahci device, ahci_state_post_load(), will fail
> >>>> at ahci_cond_start_engines() if the MemoryRegion
> >>>> pci_dev->bus_master_enable_region is not enabled, with pci_dev pointing
> >>>> to the PCIDevice struct containing the ahci device.
> >>>>
> >>>> This patch enables pci_dev->bus_master_enable_region before calling
> >>>> ahci_cond_start_engines() in ahci_state_post_load(), and restore the
> >>>> MemoryRegion to its original state afterwards.
> >>>>
> >>>> Signed-off-by: andychiu <andychiu@synology.com>
> >>>
> >>> Poking at PCI device internals like this seems fragile.  And force
> >>> enabling bus master can lead to unpleasantness like corrupting guest
> >>> memory, unhandled interrupts, etc.  E.g. it's quite reasonable,
> >>> spec-wise, for the guest to move thing in memory around while bus
> >>> mastering is off.
> >>>
> >>> Can you teach ahci that region being disabled
> >>> during migration is ok, and recover from it?
> >>
> >> That's what I'm wondering.
> >>
> >> I could try to just disable the FIS RX engine if the mapping fails, but
> >> that will require a change to guest visible state.
> >>
> >> My hunch, though, is that when windows re-enables the device it will
> >> need to re-program the address registers anyway, so it might cope well
> >> with the FIS RX bit getting switched off.
> >>
> >> (I'm wondering if it isn't a mistake that QEMU is trying to re-map this
> >> address in the first place. Is it legal that the PCI device has pci bus
> >> master disabled but we've held on to a mapping?
> > 
> > If you are poking at guest memory when bus master is off, then most likely yes.
> > 
> >> Should there be some
> >> callback where AHCI knows to invalidate mappings at that point...?)
> > 
> > ATM the callback is the config write, you check
> > proxy->pci_dev.config[PCI_COMMAND] & PCI_COMMAND_MASTER
> > and if disabled invalidate the mapping.
> > 
> > virtio at least has code that pokes at
> > proxy->pci_dev.config[PCI_COMMAND] too, I'm quite
> > open to a function along the lines of
> > pci_is_bus_master_enabled()
> > that will do this.
> > 
> 
> Well, that's not a callback. I don't think it's right to check the
> PCI_COMMAND register *every* time AHCI does anything at all to see if
> its mappings are still valid.
> 
> AHCI makes a mapping *once* when FIS RX is turned on, and it unmaps it
> when it's turned off. It assumes it remains valid that whole time. When
> we migrate, it checks to see if it was running, and performs the
> mappings again to re-boot the state machine.
> 
> What I'm asking is; what are the implications of a guest disabling
> PCI_COMMAND_MASTER? (I don't know PCI as well as you do.)

The implication is that no reads or writes must be initiated by device:
either memory or IO reads, or sending MSI. INT#x is unaffected.
writes into device memory are unaffected. whether reads from
device memory are affected kind of depends, but maybe not.

Whether device caches anything internally has nothing to do
with PCI_COMMAND_MASTER and PCI spec says nothing about it.
Windows uses PCI_COMMAND_MASTER to emulate surprise removal
so there's that.


> What should that mean for the AHCI state machine?
> 
> Does this *necessarily* invalidate the mappings?
> (In which case -- it's an error that AHCI held on to them after Windows
> disabled the card, even if AHCI isn't being engaged by the guest
> anymore. Essentially, we were turned off but didn't clean up a dangling
> pointer, but we need the event that tells us to clean the dangling mapping.)

It does not have to but it must stop memory accesses through the mappings.

-- 
MST


