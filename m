Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E427D89E7
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 22:57:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw7Ot-0003vI-M8; Thu, 26 Oct 2023 16:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qw7Op-0003v4-4W
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 16:56:15 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qw7Oj-0000Zx-61
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 16:56:14 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A0879CE3C6D;
 Thu, 26 Oct 2023 20:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D7DC433C9;
 Thu, 26 Oct 2023 20:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1698353764;
 bh=HYUySSM5BMG1MhexWSXUSR08ukFfOELq0GpRQIm17ak=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=Hi4vC5bDJhn7G0ur5wPj57uitp8978C3hjqe4T4WUGpvAEP2t5tZ0kMnktcadKr0h
 nOND7qcjbb1ZYHXu9CjZAS+oLLU0Dpv0XUW2me3UgTdCO18XGRAyFDqgXP14XSHrsJ
 r/7CPVfatkJvM0T1wRk6CtPZ+5+uUFlZDe4c9M9tumtdk686X1dqEeSHf8NU+nGHE/
 D+F5SXSSjh072txxjVELWJHJ5HrAdbk6NpWALiwUOIgGZJwUwlzFGSmM8L79bIX9bw
 it/GeFBQt6vLFAr+VUJne4F850/Aor6vI0ThxTn3CYG4tFxWgNZyPTRPCs8z/X3Tn/
 GtB2ardKSctcw==
Date: Thu, 26 Oct 2023 13:56:02 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: David Woodhouse <dwmw2@infradead.org>
cc: Stefano Stabellini <sstabellini@kernel.org>, 
 Vikram Garhwal <vikram.garhwal@amd.com>, qemu-devel@nongnu.org, 
 jgross@suse.com
Subject: Re: [QEMU][PATCHv2 0/8] Xen: support grant mappings.
In-Reply-To: <2fb3dfe783bd6226d3addcdccf2e2ef2061b324e.camel@infradead.org>
Message-ID: <alpine.DEB.2.22.394.2310261346370.271731@ubuntu-linux-20-04-desktop>
References: <20231025212422.30371-1-vikram.garhwal@amd.com>
 <48b53eefdbcd4e61d09acfd2532ea8721376d0de.camel@infradead.org>
 <alpine.DEB.2.22.394.2310261107010.271731@ubuntu-linux-20-04-desktop>
 <60882a8e4d1e9a446034c5d3dda14aed5e0e25cd.camel@infradead.org>
 <alpine.DEB.2.22.394.2310261318191.271731@ubuntu-linux-20-04-desktop>
 <2fb3dfe783bd6226d3addcdccf2e2ef2061b324e.camel@infradead.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1285894395-1698353437=:271731"
Content-ID: <alpine.DEB.2.22.394.2310261351000.271731@ubuntu-linux-20-04-desktop>
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=sstabellini@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--8323329-1285894395-1698353437=:271731
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2310261351001.271731@ubuntu-linux-20-04-desktop>

On Thu, 26 Oct 2023, David Woodhouse wrote:
> On Thu, 2023-10-26 at 13:36 -0700, Stefano Stabellini wrote:
> > 
> > > This seems like a lot of code to replace that simpler option... is
> > > there a massive performance win from doing it this way? Would we want
> > > to use this trick for the Xen PV backends (qdisk, qnic) *too*? Might it
> > > make sense to introduce the simple version and *then* the optimisation,
> > > with some clear benchmarking to show the win?
> > 
> > This is not done for performance but for safety (as in safety
> > certifications, ISO 26262, etc.). This is to enable unprivileged virtio
> > backends running in a DomU. By unprivileged I mean a virtio backend that
> > is unable to map arbitrary memory (the xenforeignmemory interface is
> > prohibited).
> > 
> > The goal is to run Xen on safety-critical systems such as cars,
> > industrial robots and more. In this configuration there is no
> > traditional Dom0 in the system at all. If you  would like to know more:
> > https://www.youtube.com/watch?v=tisljY6Bqv0&list=PLYyw7IQjL-zHtpYtMpFR3KYdRn0rcp5Xn&index=8
> 
> Yeah, I understand why we're using grant mappings instead of just
> directly having access via foreignmem mappings. That wasn't what I was
> confused about.
> 
> What I haven't worked out is why we're implementing this through an
> automatically-populated MemoryRegion in QEMU, rather than just using
> grant mapping ops like we always have.
> 
> It seems like a lot of complexity just to avoid calling
> qemu_xen_gnttab_map_refs() from the virtio backend.

I think there are two questions here. One question is "Why do we need
all the new grant mapping code added to xen-mapcache.c in patch #7?
Can't we use qemu_xen_gnttab_map_refs() instead?"

Good question, I'll let Juergen and Vikram comment as original authors.

And the second question is where to call the grant mapping from (whether
the new code or the old qemu_xen_gnttab_map_refs code it doesn't
matter). It could be even simpler than calling it from the virtio
backends: we could just call it from the existing qemu_ram_ptr_length()
hook. See this discussion:
https://marc.info/?l=qemu-devel&m=169828434927778
--8323329-1285894395-1698353437=:271731--

