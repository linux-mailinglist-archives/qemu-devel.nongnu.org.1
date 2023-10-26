Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8737D8809
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 20:08:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw4lJ-0000VG-6m; Thu, 26 Oct 2023 14:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qw4lH-0000Uf-GS
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 14:07:15 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qw4lF-0002z2-GV
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 14:07:15 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 5DE6DCE4215;
 Thu, 26 Oct 2023 18:07:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDA6C433C9;
 Thu, 26 Oct 2023 18:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1698343628;
 bh=f3f9jmqWVvZZp/aY2zAEZunmeqv87nfvnwuev5T7v4I=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=s0ELCCYyoypg9DrN4Ms4PDJrHKY/Q5bic63FDsQW9xPhI2MeHm3D1RlEiMf0mW3U7
 BHQhqmu99ShwmpRwRepKN/dhUoqiKsPOHwLWvp1nO9uPK62jNMQd9l7vSThtVULUO1
 Nv+cULCmCO4NWun9X3JuqMmAYoLm4QH+FUKQmZYfMihan7OqScgaMj9aFD/6WX7BZP
 a9AQMnI612rbWqFVJzXxxAnA+LcxM32247K5TZ54OXL8NjKacJywwB+Wz9ybCYNjSf
 66hKXbesL0uUX7PG+gwCgYEQ8bD/X16Gfqjx/7Mp2nVOEfyodXymynLXVXt6ZkaeS5
 ueavPCKaJsQFg==
Date: Thu, 26 Oct 2023 11:07:06 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: David Woodhouse <dwmw2@infradead.org>
cc: Vikram Garhwal <vikram.garhwal@amd.com>, qemu-devel@nongnu.org, 
 sstabellini@kernel.org, jgross@suse.com
Subject: Re: [QEMU][PATCHv2 0/8] Xen: support grant mappings.
In-Reply-To: <48b53eefdbcd4e61d09acfd2532ea8721376d0de.camel@infradead.org>
Message-ID: <alpine.DEB.2.22.394.2310261107010.271731@ubuntu-linux-20-04-desktop>
References: <20231025212422.30371-1-vikram.garhwal@amd.com>
 <48b53eefdbcd4e61d09acfd2532ea8721376d0de.camel@infradead.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=145.40.73.55; envelope-from=sstabellini@kernel.org;
 helo=sin.source.kernel.org
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

On Thu, 26 Oct 2023, David Woodhouse wrote:
> On Wed, 2023-10-25 at 14:24 -0700, Vikram Garhwal wrote:
> > Hi,
> > This patch series add support for grant mappings as a pseudo RAM region for Xen.
> > 
> > Enabling grant mappings patches(first 6) are written by Juergen in 2021.
> > 
> > QEMU Virtio device provides an emulated backends for Virtio frontned devices
> > in Xen.
> > Please set "iommu_platform=on" option when invoking QEMU. As this will set
> > VIRTIO_F_ACCESS_PLATFORM feature which will be used by virtio frontend in Xen
> > to know whether backend supports grants or not.
> 
> I don't really understand what's going on here. The subject of the
> cover letter certainly doesn't help me, because we *already* support
> grant mappings under Xen, don't we?
> 
> I found
> https://static.linaro.org/connect/lvc21/presentations/lvc21-314.pdf but
> I think it's a bit out of date; the decision about how to handle grant
> mappings for virtio devices is still 'TBD'.

See this presentation:
https://www.youtube.com/watch?v=boRQ8UHc760

The patch series is for the guest (e.g. Linux) to use grants to share
memory with virtio devices. The plumbing was already done in Linux a
couple of years ago, but QEMU support for it is still missing.


> Can you talk me through the process of what happens when a guest wants
> to a virtio device to initiate 'DMA' to one of its pages? I assume it
> starts by creating a grant mapping, and then taking the gntref and...
> then what?

First the guest gets a grant reference for the page, then it uses it as
"dma address" to pass to the virtio device. The top bit (1ULL << 63) is
used to signal that the address in question is a grant address.

See in Linux:
drivers/xen/grant-dma-ops.c grant_to_dma, dma_to_grant,
xen_grant_dma_alloc, etc.


> I don't see any changes to the virtio devices themselves in this
> series; are we doing something that will make it work by magic? If so,
> it might be useful to explain that magic...

Yes something like that :-)
https://marc.info/?l=xen-devel&m=165419780304962&w=2

Vikram, I think it would be a good idea to submit a separate patch to
xen.git to add a document under docs/ to capture this.

