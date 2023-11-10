Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D157F7E7B82
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 11:53:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1P79-0001lm-RL; Fri, 10 Nov 2023 05:51:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r1P77-0001la-Cl
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 05:51:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r1P75-0005sF-Ad
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 05:51:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699613504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OzgIOGtpcvl3EewkpqelL7NoI4WVG+xRrFthYzZHATQ=;
 b=eUD6OEUE4Hh1XuAcVwf2qeBMuUHK9Ncao19Yrx/rPcD7b9nD3wLnQmmgvTnDdty+UNmthm
 s4Vq+804AttHczRzphTssHuhjSFyLFp93Su/JQh3Tu58bPXz962aoFP/Jr4m0/XI2HWRpT
 lnVwDc5aHQfXouO6ck+2RM3xNLONQy4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-RDqxHutsMpCPqTgrmB8nZQ-1; Fri, 10 Nov 2023 05:51:42 -0500
X-MC-Unique: RDqxHutsMpCPqTgrmB8nZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82B19811E7E;
 Fri, 10 Nov 2023 10:51:42 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.194.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E89A0502A;
 Fri, 10 Nov 2023 10:51:41 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B4CAD1800DF8; Fri, 10 Nov 2023 11:51:40 +0100 (CET)
Date: Fri, 10 Nov 2023 11:51:40 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Claudio Fontana <cfontana@suse.de>
Cc: Kevin O'Connor <kevin@koconnor.net>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 seabios@seabios.org, qemu-devel@nongnu.org
Subject: Re: [SeaBIOS] [PATCH v5] limit physical address space size
Message-ID: <npmimli5x4vcwxb3csaaut3sobuzsex7pgtf4xbrbnfd22hnyz@ixh5tmn4xkpk>
References: <20231107130309.3257776-1-kraxel@redhat.com>
 <ZUvVCHWbU29+eDm7@morn>
 <59437ef3-7b94-2aa4-31b4-012412ce160b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59437ef3-7b94-2aa4-31b4-012412ce160b@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
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

On Fri, Nov 10, 2023 at 09:36:02AM +0100, Claudio Fontana wrote:
> On 11/8/23 19:35, Kevin O'Connor wrote:
> > On Tue, Nov 07, 2023 at 02:03:09PM +0100, Gerd Hoffmann wrote:
> >> For better compatibility with old linux kernels,
> >> see source code comment.
> >>
> >> Related (same problem in ovmf):
> >> https://github.com/tianocore/edk2/commit/c1e853769046
> > 
> > Thanks.  I'll defer to your judgement on this.  It does seem a little
> > odd to alter the CPUPhysBits variable itself instead of adding
> > additional checking to the pciinit.c code that uses CPUPhysBits.
> > (That is, if there are old Linux kernels that can't handle a very high
> > PCI space, then a workaround in the PCI code might make it more clear
> > what is occurring.)
> > 
> > Cheers,
> > -Kevin
> > 
> > 
> >>
> >> Cc: Claudio Fontana <cfontana@suse.de>
> >> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> Hi,
> 
> I thought about this, and I am not sure it's the right call though.
> 
> The change breaking old guests (CentOS7, Ubuntu 18.04 are the known ones, but presumably others as well) in QEMU is:
> 
> commit 784155cdcb02ffaae44afecab93861070e7d652d
> Author: Gerd Hoffmann <kraxel@redhat.com>
> Date:   Mon Sep 11 17:20:26 2023 +0200
> 
>     seabios: update submodule to git snapshot
>     
>     git shortlog
>     ------------
>     
>     Gerd Hoffmann (7):
>           disable array bounds warning
>           better kvm detection
>           detect physical address space size
>           move 64bit pci window to end of address space
>           be less conservative with the 64bit pci io window
>           qemu: log reservations in fw_cfg e820 table
>           check for e820 conflict
> 
> The reasoning for the change is according to:
> 
> https://mail.coreboot.org/hyperkitty/list/seabios@seabios.org/message/BHK67ULKJTLJT676J4D5C2ND53CFEL3Q/
> 
> "It makes seabios follow a common pattern.  real mode address space
> has io resources mapped high (below 1M).  32-bit address space has
> io resources mapped high too (below 4G).  This does the same for
> 64-bit resources."
> 
> So it seems to be an almost aesthetic choice, the way I read the
> "common pattern", one that ends up actually breaking existing
> workloads though.

It's not about aesthetics.  It's about handing out more resources to the
64bit mmio window and also to the pci bridge windows if we have enough
address space for that.  This is important because not only main memory
sizes grow, but also device memory grows.  Especially GPUs and AI
accelerators can have rather big PCI memory bars these days.  If you
want support hotplugging them you need pcie root ports with big enough
bridge windows.

The "common pattern" refers to OVMF doing the same for the same reason.

> Now the correction to that that you propose in SeaBIOS is:
> 
> >> +    if (valid && physbits > 46) {
> >> +        // Old linux kernels have trouble dealing with more than 46
> >> +        // phys-bits, so avoid that for now.  Seems to be a bug in the
> >> +        // virtio-pci driver.  Reported: centos-7, ubuntu-18.04
> >> +        dprintf(1, "%s: using phys-bits=46 (old linux kernel compatibility)\n", __func__);
> >> +        physbits = 46;
> >> +    }

> but to me this is potentially breaking the situation for another set
> of users, those that are passing through 48 physical bits from their
> host cpu to the guest, and expect it to actually happen.

This doesn't change the address space size the guest does see.  seabios
does not have the power to change the information returned by the cpuid
instruction.

This only changes the placement of the PCI bars.  The pci setup code is
the only consumer of that variable, guess it makes sense to move the
quirk to the pci code (as suggested by Kevin) to clarify this.

> Would it not be a better solution to instead either revert the
> original change,

No (see above).

> or to patch it to find a new range that better satisfies code
> consistency/aesthetic requirements, but also does not break any
> running workload?

Upstream OVMF does the same thing for roughly one year, the old linux
kernel issue is the only one which showed up so far.  OVMF wouldn't see
*really* old guests (without UEFI support) though.

The pci setup code already has a bunch of conditions for activating the
64bit mmio window, to avoid breaking really old guests.  It wouldn't
happen on CPUs without long mode.  It also wouldn't happen if guests
don't have memory above 4G.

I'm open to suggestions to refine this.

> Or we could add some extra workarounds in the stack elsewhere in the
> management tools to try to detect older guests (not ideal either), but
> this seems like adding breakage on top of breakage to me.

We already have libosinfo which records guest capabilities, which exists
to solve exactly that problem:  Allow new guests use new features by
default, without breaking old guests.  Extending libosinfo looks like a
perfectly valid approach to me, especially considering that we probably
want make the 46 phys-bits limit conditional some day in the future, to
allow even larger guests.

take care,
  Gerd


