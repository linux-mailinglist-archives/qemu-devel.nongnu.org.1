Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0AC7C4427
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 00:32:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqLFC-0000dE-LK; Tue, 10 Oct 2023 18:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qqLFB-0000d4-9t
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 18:30:25 -0400
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qqLF9-000536-5x
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 18:30:24 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 24947B81EC1;
 Tue, 10 Oct 2023 22:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B271BC433C8;
 Tue, 10 Oct 2023 22:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696977019;
 bh=4KQ+fP5Z+CodzlHTsTZqTxQVs/IEOqNvqb0CVWSQekc=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=GmfCVSlzk9e0UsMxOdl0ZvIqU62/6FixIEi5DYFJ6SccekSiUV3pKzTd7wh6mFRgQ
 D+VJlt3Ugakyiv2bZ31JbgDjYzNkDfSyX1UBZKPJNtBqxIoM3u72lMsuEhw/9j3phf
 +zm8W1cD8vIirL4NDWBj3PdH1qyoWjZN294YV0Ttac24bkoujVRv5kb8wqyxH8WuWI
 k+77To7i+CX8yLMmYwC/uuIQy+kSyghoOsm2WbyYjDiRzwAtv66vak8trCe8Ge6tJF
 LsJVCd9EQ4JoPuwD7QxaWmO/8KWGx3nR6NO+R2r3SfsbIkL5OAHFpJzbCqkUWg5QPv
 WdaastnJSLzVQ==
Date: Tue, 10 Oct 2023 15:30:16 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Vikram Garhwal <vikram.garhwal@amd.com>
cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, 
 Juergen Gross <jgross@suse.com>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Subject: Re: [QEMU][PATCH v1 2/7] xen: add pseudo RAM region for grant mappings
In-Reply-To: <ZSXBPlQF1Y2Gx5P1@amd.com>
Message-ID: <alpine.DEB.2.22.394.2310101529280.3431292@ubuntu-linux-20-04-desktop>
References: <20231005181629.4046-1-vikram.garhwal@amd.com>
 <20231005181629.4046-3-vikram.garhwal@amd.com>
 <alpine.DEB.2.22.394.2310091653270.3431292@ubuntu-linux-20-04-desktop>
 <ZSXBPlQF1Y2Gx5P1@amd.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 10 Oct 2023, Vikram Garhwal wrote:
> On Mon, Oct 09, 2023 at 05:02:14PM -0700, Stefano Stabellini wrote:
> > On Thu, 5 Oct 2023, Vikram Garhwal wrote:
> > > From: Juergen Gross <jgross@suse.com>
> > > 
> > > Add a memory region which can be used to automatically map granted
> > > memory. It is starting at 0x8000000000000000ULL in order to be able to
> > > distinguish it from normal RAM.
> > > 
> > > For this reason the xen.ram memory region is expanded, which has no
> > > further impact as it is used just as a container of the real RAM
> > > regions and now the grant region.
> > > 
> > > Signed-off-by: Juergen Gross <jgross@suse.com>
> > > Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
> > 
> > This patch doesn't apply to staging anymore
> Will re-base it. I rebased it against master branch.
> > 
> > 
> > > ---
> > >  hw/i386/xen/xen-hvm.c           |  3 ++
> > >  hw/xen/xen-hvm-common.c         |  4 +--
> > >  hw/xen/xen-mapcache.c           | 27 ++++++++++++++
> > >  include/exec/ram_addr.h         |  1 +
> > >  include/hw/xen/xen-hvm-common.h |  2 ++
> > >  include/hw/xen/xen_pvdev.h      |  3 ++
> > >  include/sysemu/xen-mapcache.h   |  3 ++
> > >  softmmu/physmem.c               | 62 +++++++++++++++++++++------------
> > >  8 files changed, 80 insertions(+), 25 deletions(-)
> > > 
> > > diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> > > index f42621e674..67a55558a6 100644
> > > --- a/hw/i386/xen/xen-hvm.c
> > > +++ b/hw/i386/xen/xen-hvm.c
> > > @@ -172,6 +172,9 @@ static void xen_ram_init(PCMachineState *pcms,
> > >                                   x86ms->above_4g_mem_size);
> > >          memory_region_add_subregion(sysmem, 0x100000000ULL, &ram_hi);
> > >      }
> > > +
> > > +    /* Add grant mappings as a pseudo RAM region. */
> > > +    ram_grants = *xen_init_grant_ram();
> > >  }
> > >  
> > >  static XenPhysmap *get_physmapping(hwaddr start_addr, ram_addr_t size)
> > > diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
> > > index 565dc39c8f..b7255977a5 100644
> > > --- a/hw/xen/xen-hvm-common.c
> > > +++ b/hw/xen/xen-hvm-common.c
> > > @@ -9,7 +9,7 @@
> > >  #include "hw/boards.h"
> > >  #include "hw/xen/arch_hvm.h"
> > >  
> > > -MemoryRegion ram_memory;
> > > +MemoryRegion ram_memory, ram_grants;
> > >  
> > >  void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
> > >                     Error **errp)
> > > @@ -26,7 +26,7 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
> > >          return;
> > >      }
> > >  
> > > -    if (mr == &ram_memory) {
> > > +    if (mr == &ram_memory || mr == &ram_grants) {
> > >          return;
> > >      }
> > >  
> > > diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> > > index f7d974677d..8115c44c00 100644
> > > --- a/hw/xen/xen-mapcache.c
> > > +++ b/hw/xen/xen-mapcache.c
> > > @@ -14,7 +14,9 @@
> > >  
> > >  #include <sys/resource.h>
> > >  
> > > +#include "hw/xen/xen-hvm-common.h"
> > >  #include "hw/xen/xen_native.h"
> > > +#include "hw/xen/xen_pvdev.h"
> > >  #include "qemu/bitmap.h"
> > >  
> > >  #include "sysemu/runstate.h"
> > > @@ -597,3 +599,28 @@ uint8_t *xen_replace_cache_entry(hwaddr old_phys_addr,
> > >      mapcache_unlock();
> > >      return p;
> > >  }
> > > +
> > > +MemoryRegion *xen_init_grant_ram(void)
> > > +{
> > > +    RAMBlock *block;
> > > +
> > > +    memory_region_init(&ram_grants, NULL, "xen.grants",
> > > +                       XEN_MAX_VIRTIO_GRANTS * XC_PAGE_SIZE);
> > > +    block = g_malloc0(sizeof(*block));
> > > +    block->mr = &ram_grants;
> > > +    block->used_length = XEN_MAX_VIRTIO_GRANTS * XC_PAGE_SIZE;
> > > +    block->max_length = XEN_MAX_VIRTIO_GRANTS * XC_PAGE_SIZE;
> > > +    block->fd = -1;
> > > +    block->page_size = XC_PAGE_SIZE;
> > > +    block->host = (void *)XEN_GRANT_ADDR_OFF;
> > > +    block->offset = XEN_GRANT_ADDR_OFF;
> > > +    block->flags = RAM_PREALLOC;
> > > +    ram_grants.ram_block = block;
> > > +    ram_grants.ram = true;
> > > +    ram_grants.terminates = true;
> > > +    ram_block_add_list(block);
> > > +    memory_region_add_subregion(get_system_memory(), XEN_GRANT_ADDR_OFF,
> > > +                                &ram_grants);
> > > +
> > > +    return &ram_grants;
> > 
> > It doesn't look like xen_init_grant_ram has anything to do with the
> > mapcache. It should be in another file. Maybe ./hw/xen/xen-hvm-common.c
> > or ./hw/i386/xen/xen-hvm.c (but this is x86 specific and we need grants
> > on ARM too)
> Do you mean to move all grant related functions? As moving this alone will not
> be sufficient. There are lot of new grant related function added in later patches.
> 
> I am okay with moving all to xen-hvm-common.c
> 
> Following code movement will happen in this case:
> 1. All grant related static function to xen-hvm-common.c.
>     xen_ram_addr_from_grant_cache(), xen_ram_addr_from_mapcache(),
>     xen_map_grant_dyn(), xen_unmap_grant_dyn and xen_init_grant_ram().
> 2. Remove static from xen_ram_addr_from_mapcache_try().
> 
> Does these changes looks good?

After reading all the patches, I think it is also OK to leave the code
here.

