Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD627BEFC5
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 02:29:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq0bX-0003EK-1t; Mon, 09 Oct 2023 20:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qq0bV-0003EC-K3
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 20:28:05 -0400
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qq0bT-0005pu-K7
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 20:28:05 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id C6541B8092E;
 Tue, 10 Oct 2023 00:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EE7C433C7;
 Tue, 10 Oct 2023 00:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696897681;
 bh=n+8+kl0l5qmiaXi9T/lzTbJXS41Rqkh31n8ODesFFDc=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=GkmcLmsW5uOr3PYNV+wFCan7+dD7MB4Ut9rncB7I0ckaliyDuAX/tNZFTCdXJ1SKQ
 4BmEGVBvvyAWIcm4NoGqxN+PDzu+gNPNNsJGXnrVVEyDboTwQ6lXOiSRDHkqao1z4i
 IShMKDdHfoS907mCbXjlNtYH4J7w28xe1RyRedFHr4RcqcTlWLb5uUoQJAH+SZ2I1a
 oiWKi14Dekljh6tJmEJsWXjHd6he4gn1606QVO+Ce8riradu0sTsT30s5qOjnru+b2
 NNWiExLT16h/bShCbpYx6d40b5ntOwgxsb+arnCgfyF33SZdruKeYOCqvjBeC4DlFW
 OGqn8oNVwpgeg==
Date: Mon, 9 Oct 2023 17:27:58 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Vikram Garhwal <vikram.garhwal@amd.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, 
 Juergen Gross <jgross@suse.com>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Subject: Re: [QEMU][PATCH v1 6/7] xen: add map and unmap callbacks for grant
 region
In-Reply-To: <20231005181629.4046-7-vikram.garhwal@amd.com>
Message-ID: <alpine.DEB.2.22.394.2310091727390.3431292@ubuntu-linux-20-04-desktop>
References: <20231005181629.4046-1-vikram.garhwal@amd.com>
 <20231005181629.4046-7-vikram.garhwal@amd.com>
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

On Thu, 5 Oct 2023, Vikram Garhwal wrote:
> From: Juergen Gross <jgross@suse.com>
> 
> Add the callbacks for mapping/unmapping guest memory via grants to the
> special grant memory region.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>

This looks good. We need to add a check to make sure we don't exceed
XEN_MAX_VIRTIO_GRANTS.



> ---
>  hw/xen/xen-mapcache.c | 167 +++++++++++++++++++++++++++++++++++++++++-
>  softmmu/physmem.c     |  11 ++-
>  2 files changed, 173 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> index 8a61c7dde6..52844a6a9d 100644
> --- a/hw/xen/xen-mapcache.c
> +++ b/hw/xen/xen-mapcache.c
> @@ -9,6 +9,8 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/queue.h"
> +#include "qemu/thread.h"
>  #include "qemu/units.h"
>  #include "qemu/error-report.h"
>  
> @@ -23,6 +25,8 @@
>  #include "sysemu/xen-mapcache.h"
>  #include "trace.h"
>  
> +#include <xenevtchn.h>
> +#include <xengnttab.h>
>  
>  //#define MAPCACHE_DEBUG
>  
> @@ -385,7 +389,7 @@ uint8_t *xen_map_cache(hwaddr phys_addr, hwaddr size,
>      return p;
>  }
>  
> -ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
> +static ram_addr_t xen_ram_addr_from_mapcache_try(void *ptr)
>  {
>      MapCacheEntry *entry = NULL;
>      MapCacheRev *reventry;
> @@ -594,10 +598,170 @@ uint8_t *xen_replace_cache_entry(hwaddr old_phys_addr,
>      return p;
>  }
>  
> +struct XENMappedGrantRegion {
> +    void *addr;
> +    unsigned int pages;
> +    unsigned int refs;
> +    unsigned int prot;
> +    uint32_t idx;
> +    QLIST_ENTRY(XENMappedGrantRegion) list;
> +};
> +
> +static xengnttab_handle *xen_region_gnttabdev;
> +static QLIST_HEAD(GrantRegionList, XENMappedGrantRegion) xen_grant_mappings =
> +    QLIST_HEAD_INITIALIZER(xen_grant_mappings);
> +static QemuMutex xen_map_mutex;
> +
> +static void *xen_map_grant_dyn(MemoryRegion **mr, hwaddr addr, hwaddr *plen,
> +                               bool is_write, MemTxAttrs attrs)
> +{
> +    unsigned int page_off = addr & (XC_PAGE_SIZE - 1);
> +    unsigned int i;
> +    unsigned int nrefs = (page_off + *plen + XC_PAGE_SIZE - 1) >> XC_PAGE_SHIFT;
> +    uint32_t ref = (addr - XEN_GRANT_ADDR_OFF) >> XC_PAGE_SHIFT;
> +    uint32_t *refs = NULL;
> +    unsigned int prot = PROT_READ;
> +    struct XENMappedGrantRegion *mgr = NULL;
> +
> +    if (is_write) {
> +        prot |= PROT_WRITE;
> +    }
> +
> +    qemu_mutex_lock(&xen_map_mutex);
> +
> +    QLIST_FOREACH(mgr, &xen_grant_mappings, list) {
> +        if (mgr->idx == ref &&
> +            mgr->pages == nrefs &&
> +            (mgr->prot & prot) == prot) {
> +            break;
> +        }
> +    }
> +    if (!mgr) {
> +        mgr = g_new(struct XENMappedGrantRegion, 1);
> +
> +        if (nrefs == 1) {
> +            refs = &ref;
> +        } else {
> +            refs = g_new(uint32_t, nrefs);
> +            for (i = 0; i < nrefs; i++) {
> +                refs[i] = ref + i;
> +            }
> +        }
> +        mgr->addr = xengnttab_map_domain_grant_refs(xen_region_gnttabdev, nrefs,
> +                                                    xen_domid, refs, prot);
> +        if (mgr->addr) {
> +            mgr->pages = nrefs;
> +            mgr->refs = 1;
> +            mgr->prot = prot;
> +            mgr->idx = ref;
> +
> +            QLIST_INSERT_HEAD(&xen_grant_mappings, mgr, list);
> +        } else {
> +            g_free(mgr);
> +            mgr = NULL;
> +        }
> +    } else {
> +        mgr->refs++;
> +    }
> +
> +    qemu_mutex_unlock(&xen_map_mutex);
> +
> +    if (nrefs > 1) {
> +        g_free(refs);
> +    }
> +
> +    return mgr ? mgr->addr + page_off : NULL;
> +}
> +
> +static void xen_unmap_grant_dyn(MemoryRegion *mr, void *buffer, ram_addr_t addr,
> +                                hwaddr len, bool is_write, hwaddr access_len)
> +{
> +    unsigned int page_off = (unsigned long)buffer & (XC_PAGE_SIZE - 1);
> +    unsigned int nrefs = (page_off + len + XC_PAGE_SIZE - 1) >> XC_PAGE_SHIFT;
> +    unsigned int prot = PROT_READ;
> +    struct XENMappedGrantRegion *mgr = NULL;
> +
> +    if (is_write) {
> +        prot |= PROT_WRITE;
> +    }
> +
> +    qemu_mutex_lock(&xen_map_mutex);
> +
> +    QLIST_FOREACH(mgr, &xen_grant_mappings, list) {
> +        if (mgr->addr == buffer - page_off &&
> +            mgr->pages == nrefs &&
> +            (mgr->prot & prot) == prot) {
> +            break;
> +        }
> +    }
> +    if (mgr) {
> +        mgr->refs--;
> +        if (!mgr->refs) {
> +            xengnttab_unmap(xen_region_gnttabdev, mgr->addr, nrefs);
> +
> +            QLIST_REMOVE(mgr, list);
> +            g_free(mgr);
> +        }
> +    } else {
> +        error_report("xen_unmap_grant_dyn() trying to unmap unknown buffer");
> +    }
> +
> +    qemu_mutex_unlock(&xen_map_mutex);
> +}
> +
> +static ram_addr_t xen_ram_addr_from_grant_cache(void *ptr)
> +{
> +    unsigned int page_off = (unsigned long)ptr & (XC_PAGE_SIZE - 1);
> +    struct XENMappedGrantRegion *mgr = NULL;
> +    ram_addr_t raddr = RAM_ADDR_INVALID;
> +
> +    qemu_mutex_lock(&xen_map_mutex);
> +
> +    QLIST_FOREACH(mgr, &xen_grant_mappings, list) {
> +        if (mgr->addr == ptr - page_off) {
> +            break;
> +        }
> +    }
> +
> +    if (mgr) {
> +        raddr = (mgr->idx << XC_PAGE_SHIFT) + page_off + XEN_GRANT_ADDR_OFF;
> +    }
> +
> +    qemu_mutex_unlock(&xen_map_mutex);
> +
> +    return raddr;
> +}
> +
> +ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
> +{
> +    ram_addr_t raddr;
> +
> +    raddr = xen_ram_addr_from_mapcache_try(ptr);
> +    if (raddr == RAM_ADDR_INVALID) {
> +        raddr = xen_ram_addr_from_grant_cache(ptr);
> +    }
> +
> +    return raddr;
> +}
> +
> +static const struct MemoryRegionOps xen_grant_mr_ops = {
> +    .map = xen_map_grant_dyn,
> +    .unmap = xen_unmap_grant_dyn,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
>  MemoryRegion *xen_init_grant_ram(void)
>  {
>      RAMBlock *block;
>  
> +    qemu_mutex_init(&xen_map_mutex);
> +
> +    xen_region_gnttabdev = xengnttab_open(NULL, 0);
> +    if (xen_region_gnttabdev == NULL) {
> +        fprintf(stderr, "can't open gnttab device\n");
> +        return NULL;
> +    }
> +
>      memory_region_init(&ram_grants, NULL, "xen.grants",
>                         XEN_MAX_VIRTIO_GRANTS * XC_PAGE_SIZE);
>      block = g_malloc0(sizeof(*block));
> @@ -612,6 +776,7 @@ MemoryRegion *xen_init_grant_ram(void)
>      ram_grants.ram_block = block;
>      ram_grants.ram = true;
>      ram_grants.terminates = true;
> +    ram_grants.ops = &xen_grant_mr_ops;
>      ram_block_add_list(block);
>      memory_region_add_subregion(get_system_memory(), XEN_GRANT_ADDR_OFF,
>                                  &ram_grants);
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index 5f425bea1c..e5346386db 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -2250,13 +2250,16 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
>  
>      if (xen_enabled()) {
>          ram_addr_t ram_addr;
> +
>          RCU_READ_LOCK_GUARD();
>          ram_addr = xen_ram_addr_from_mapcache(ptr);
> -        block = qemu_get_ram_block(ram_addr);
> -        if (block) {
> -            *offset = ram_addr - block->offset;
> +        if (ram_addr != RAM_ADDR_INVALID) {
> +            block = qemu_get_ram_block(ram_addr);
> +            if (block) {
> +                *offset = ram_addr - block->offset;
> +            }
> +            return block;
>          }
> -        return block;
>      }
>  
>      RCU_READ_LOCK_GUARD();
> -- 
> 2.17.1
> 

