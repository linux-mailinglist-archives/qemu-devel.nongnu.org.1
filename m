Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 983D57D89BF
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 22:38:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw75w-000748-2W; Thu, 26 Oct 2023 16:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qw75t-00073b-91
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 16:36:41 -0400
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qw75r-00035h-8c
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 16:36:41 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 2434EB80DE0;
 Thu, 26 Oct 2023 20:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A25C433C7;
 Thu, 26 Oct 2023 20:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1698352596;
 bh=c5rT9dbB2S2Ezvx09F6IRjbhbnnNNr6TiM0MYiPmHmY=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=ruPm5bnHqDtkXwI1l5Ip9O41yI4eogyQ8iKr/2cLUdrXoAUfJTkOHIFWHwwC/FSAC
 PViYnZuzaHJi+pHAmUJQ7Pqpqb8jLtg8DEKs94z3pb7RnEhZDE/rPxrGtfrszERl+T
 alW6Hz/s/L0WeuY5C4qNeu9kYz1kh3XThB1w35ULKivgbC+wlPolqVXkQpCj+W88Rh
 O5OVAR4o9NByIxkiVbXTuJT9HDoEx6odektL0oWZym+q+SbNjMmTl/ufWwuHbF0I5A
 BIMTvFtRQJjdR0bpYv1DqBakxJRV4KqPW2WtdaKCo48y2CB1NN+km8LzBptz7X0RB3
 SzsWCih57FgGA==
Date: Thu, 26 Oct 2023 13:36:34 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: David Woodhouse <dwmw2@infradead.org>
cc: Stefano Stabellini <sstabellini@kernel.org>, 
 Vikram Garhwal <vikram.garhwal@amd.com>, qemu-devel@nongnu.org, 
 jgross@suse.com
Subject: Re: [QEMU][PATCHv2 0/8] Xen: support grant mappings.
In-Reply-To: <60882a8e4d1e9a446034c5d3dda14aed5e0e25cd.camel@infradead.org>
Message-ID: <alpine.DEB.2.22.394.2310261318191.271731@ubuntu-linux-20-04-desktop>
References: <20231025212422.30371-1-vikram.garhwal@amd.com>
 <48b53eefdbcd4e61d09acfd2532ea8721376d0de.camel@infradead.org>
 <alpine.DEB.2.22.394.2310261107010.271731@ubuntu-linux-20-04-desktop>
 <60882a8e4d1e9a446034c5d3dda14aed5e0e25cd.camel@infradead.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1156238612-1698351838=:271731"
Content-ID: <alpine.DEB.2.22.394.2310261324160.271731@ubuntu-linux-20-04-desktop>
Received-SPF: pass client-ip=2604:1380:4601:e00::1;
 envelope-from=sstabellini@kernel.org; helo=ams.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--8323329-1156238612-1698351838=:271731
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2310261324161.271731@ubuntu-linux-20-04-desktop>

On Thu, 26 Oct 2023, David Woodhouse wrote:
> On Thu, 2023-10-26 at 11:07 -0700, Stefano Stabellini wrote:
> > On Thu, 26 Oct 2023, David Woodhouse wrote:
> > > On Wed, 2023-10-25 at 14:24 -0700, Vikram Garhwal wrote:
> > > > Hi,
> > > > This patch series add support for grant mappings as a pseudo RAM region for Xen.
> > > > 
> > > > Enabling grant mappings patches(first 6) are written by Juergen in 2021.
> > > > 
> > > > QEMU Virtio device provides an emulated backends for Virtio frontned devices
> > > > in Xen.
> > > > Please set "iommu_platform=on" option when invoking QEMU. As this will set
> > > > VIRTIO_F_ACCESS_PLATFORM feature which will be used by virtio frontend in Xen
> > > > to know whether backend supports grants or not.
> > > 
> > > I don't really understand what's going on here. The subject of the
> > > cover letter certainly doesn't help me, because we *already* support
> > > grant mappings under Xen, don't we?
> > > 
> > > I found
> > > https://static.linaro.org/connect/lvc21/presentations/lvc21-314.pdf but
> > > I think it's a bit out of date; the decision about how to handle grant
> > > mappings for virtio devices is still 'TBD'.
> > 
> > See this presentation:
> > https://www.youtube.com/watch?v=boRQ8UHc760
> > 
> > The patch series is for the guest (e.g. Linux) to use grants to share
> > memory with virtio devices. The plumbing was already done in Linux a
> > couple of years ago, but QEMU support for it is still missing.
> 
> Thanks.
> 
> > > Can you talk me through the process of what happens when a guest wants
> > > to a virtio device to initiate 'DMA' to one of its pages? I assume it
> > > starts by creating a grant mapping, and then taking the gntref and...
> > > then what?
> > 
> > First the guest gets a grant reference for the page, then it uses it as
> > "dma address" to pass to the virtio device. The top bit (1ULL << 63) is
> > used to signal that the address in question is a grant address.
> 
> OK, so the guest sets the top bit in the DMA address and that indicates
> that this is no longer actually a guest physical address, but instead,
> bits 62-12 are a (starting) grant ref. (And the address *within* the
> page is still bits 0-11, assuming 4KiB pages).
> 
> An alternative way of implementing this on the QEMU side would just be
> to teach the virtio mapping to recognise the "special" format with the
> top bit set, and call qemu_xen_gnttab_map_refs() directly to get the
> mapping?
> 
> This seems like a lot of code to replace that simpler option... is
> there a massive performance win from doing it this way? Would we want
> to use this trick for the Xen PV backends (qdisk, qnic) *too*? Might it
> make sense to introduce the simple version and *then* the optimisation,
> with some clear benchmarking to show the win?

This is not done for performance but for safety (as in safety
certifications, ISO 26262, etc.). This is to enable unprivileged virtio
backends running in a DomU. By unprivileged I mean a virtio backend that
is unable to map arbitrary memory (the xenforeignmemory interface is
prohibited).

The goal is to run Xen on safety-critical systems such as cars,
industrial robots and more. In this configuration there is no
traditional Dom0 in the system at all. If you  would like to know more:
https://www.youtube.com/watch?v=tisljY6Bqv0&list=PLYyw7IQjL-zHtpYtMpFR3KYdRn0rcp5Xn&index=8


> If we're just going to switch to grant mappings, why *aren't* we using
> Xen PV device models on Arm anyway?

I think you mean Xen PV drivers. Yes we have been using them for a
while. Now we would also like to add the option of running virtio
devices but we can only do that if the virtio backend is unprivileged as
we have no Dom0 in the system.
--8323329-1156238612-1698351838=:271731--

