Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DA27EB80A
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 21:59:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r30UY-0004bQ-Jo; Tue, 14 Nov 2023 15:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1r30UX-0004bI-2f
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 15:58:37 -0500
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1r30UV-0007Lt-61
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 15:58:36 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id E211BB8167D;
 Tue, 14 Nov 2023 20:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E72C433C8;
 Tue, 14 Nov 2023 20:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1699995505;
 bh=5ijplms3I2Ewm4uE9vjGzwM21ZFs35Aboi9Meu2JMI0=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=vPqjlLiyY28Zi7bn3A84BaUzYRC6OgIMwMqIf63141sqanKmaTT/O28xCBH+Ez9CG
 KN7hnnqHCEBOWSqK5gKzTz9lEP157xJcNT2OnepOWLrgSoUwTsO6LYauY6bv4hVQ0/
 CG8lVN6VVPkaxIECjp2tw6AhHbDakcrTG6VlPEGFo7o6tRqRsd0+TYUy51AhFE53xT
 KKeHLt/uV/LEHKktyhpanqS+3OX6XUxgvzMuLgJnpKoZRo3ypLagMz1fP17JnUs8/t
 aK1EHADIo9x62KA1xOb8wHcmWLws4G/oiK7xNNhhZ0O2qsmRTorEQhIcjhJkHLmlAt
 +unxIKC6Oxgmg==
Date: Tue, 14 Nov 2023 12:58:22 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Juergen Gross <jgross@suse.com>
cc: David Woodhouse <dwmw2@infradead.org>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Vikram Garhwal <vikram.garhwal@amd.com>, qemu-devel@nongnu.org, 
 paul <paul@xen.org>
Subject: Re: [QEMU][PATCHv2 0/8] Xen: support grant mappings.
In-Reply-To: <d84f794e-44d8-4c92-806f-7fff3fc49486@suse.com>
Message-ID: <alpine.DEB.2.22.394.2311141253430.160649@ubuntu-linux-20-04-desktop>
References: <20231025212422.30371-1-vikram.garhwal@amd.com>
 <48b53eefdbcd4e61d09acfd2532ea8721376d0de.camel@infradead.org>
 <alpine.DEB.2.22.394.2310261107010.271731@ubuntu-linux-20-04-desktop>
 <60882a8e4d1e9a446034c5d3dda14aed5e0e25cd.camel@infradead.org>
 <alpine.DEB.2.22.394.2310261318191.271731@ubuntu-linux-20-04-desktop>
 <2fb3dfe783bd6226d3addcdccf2e2ef2061b324e.camel@infradead.org>
 <alpine.DEB.2.22.394.2310261346370.271731@ubuntu-linux-20-04-desktop>
 <9b9543b1-b1a7-4699-89f5-2e87680d52e8@suse.com>
 <8cc48dd19e33be3c40ef6ff96bf7dd5d492186ae.camel@infradead.org>
 <d84f794e-44d8-4c92-806f-7fff3fc49486@suse.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1577491162-1699995273=:160649"
Content-ID: <alpine.DEB.2.22.394.2311141255080.160649@ubuntu-linux-20-04-desktop>
Received-SPF: pass client-ip=2604:1380:4601:e00::1;
 envelope-from=sstabellini@kernel.org; helo=ams.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1577491162-1699995273=:160649
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2311141255081.160649@ubuntu-linux-20-04-desktop>

On Tue, 14 Nov 2023, Juergen Gross wrote:
> On 13.11.23 21:24, David Woodhouse wrote:
> > On Fri, 2023-10-27 at 07:27 +0200, Juergen Gross wrote:
> > > On 26.10.23 22:56, Stefano Stabellini wrote:
> > > > On Thu, 26 Oct 2023, David Woodhouse wrote:
> > > > > On Thu, 2023-10-26 at 13:36 -0700, Stefano Stabellini wrote:
> > > > > > 
> > > > > > > This seems like a lot of code to replace that simpler option... is
> > > > > > > there a massive performance win from doing it this way? Would we
> > > > > > > want
> > > > > > > to use this trick for the Xen PV backends (qdisk, qnic) *too*?
> > > > > > > Might it
> > > > > > > make sense to introduce the simple version and *then* the
> > > > > > > optimisation,
> > > > > > > with some clear benchmarking to show the win?
> > > > > > 
> > > > > > This is not done for performance but for safety (as in safety
> > > > > > certifications, ISO 26262, etc.). This is to enable unprivileged
> > > > > > virtio
> > > > > > backends running in a DomU. By unprivileged I mean a virtio backend
> > > > > > that
> > > > > > is unable to map arbitrary memory (the xenforeignmemory interface is
> > > > > > prohibited).
> > > > > > 
> > > > > > The goal is to run Xen on safety-critical systems such as cars,
> > > > > > industrial robots and more. In this configuration there is no
> > > > > > traditional Dom0 in the system at all. If you  would like to know
> > > > > > more:
> > > > > > https://www.youtube.com/watch?v=tisljY6Bqv0&list=PLYyw7IQjL-zHtpYtMpFR3KYdRn0rcp5Xn&index=8
> > > > > 
> > > > > Yeah, I understand why we're using grant mappings instead of just
> > > > > directly having access via foreignmem mappings. That wasn't what I was
> > > > > confused about.
> > > > > 
> > > > > What I haven't worked out is why we're implementing this through an
> > > > > automatically-populated MemoryRegion in QEMU, rather than just using
> > > > > grant mapping ops like we always have.
> > > > > 
> > > > > It seems like a lot of complexity just to avoid calling
> > > > > qemu_xen_gnttab_map_refs() from the virtio backend.
> > > > 
> > > > I think there are two questions here. One question is "Why do we need
> > > > all the new grant mapping code added to xen-mapcache.c in patch #7?
> > > > Can't we use qemu_xen_gnttab_map_refs() instead?"
> > > 
> > > The main motivation was to _avoid_ having to change all the backends.
> > > 
> > > My implementation enables _all_ qemu based virtio backends to use grant
> > > mappings. And if a new backend is added to qemu, there will be no change
> > > required to make it work with grants.
> > 
> > I'm not really convinced I buy that. This is a lot of complexity, and
> > don't backends need to call an appropriate mapping function to map via
> > an IOMMU if it's present anyway? Make then call a helper where you can
> > do this in one place directly instead of through a fake MemoryRegion,
> > and you're done, surely?
> 
> That was tested with unmodified block and net backends in qemu.
> 
> Maybe I missed something, but I think the IOMMU accesses are _not_ covering
> accesses to the virtio rings from qemu. And this is something you really
> want for driver domains.

Hi Juergen, David,

I don't think we should use the IOMMU accesses and I don't think we
should change the virtio backends.

My preference would be to either use the patch as is, or (better) to
reuse the original Xen hooks already in place (qemu_ram_ptr_length and
xen_invalidate_map_cache_entry, see
https://marc.info/?l=qemu-devel&m=169828434927778).

Juergen did a good job at adding new hooks in a clean way, but from my
point of view I would still prefer to only have the two existing hooks
instead of having 4 (2 old, 2 new).
--8323329-1577491162-1699995273=:160649--

