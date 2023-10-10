Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCC17BEFA4
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 02:18:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq0RM-0001YD-TS; Mon, 09 Oct 2023 20:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qq0RJ-0001Xc-JO
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 20:17:33 -0400
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qq0RH-0003cu-Lj
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 20:17:33 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 18591B818AD;
 Tue, 10 Oct 2023 00:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E8FC433C9;
 Tue, 10 Oct 2023 00:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696897049;
 bh=XeOLjR+ep3HDZuEAmIfXZEmiAeUyvXLN3gIRiVT2sjA=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=ceveB7JPKXf+E//zMP5JNe8UKwKoxYK81LRXkTXVGmjor5BuXyMaaYu7qXGvj5nay
 3zWGLGhy6643cHfjf1ZTatDNNAkfXWOAnaHQ4RACgoUnz0PZ1ybnoMguw4S4XEevD/
 p5TLaamoeHLVM9VoA8/p5123/msBNfe4JF+8mp/dpgDLivvGeDuYELoPFy806yqYu3
 z8m24VkDXw9AZEJdLyV5wvQiMvpQt1V0l3FyH8RUBeTQ5/CaCHUfQgkzneZ0AafFVC
 kRkccsHvvafzhl9rwC2k1PTtyK6jKmqCXF6PpsYA9gGcBZ8xXCwnKEYq7BqICEC61Y
 IxvsiafWuuAjQ==
Date: Mon, 9 Oct 2023 17:17:26 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Vikram Garhwal <vikram.garhwal@amd.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, 
 Juergen Gross <jgross@suse.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [QEMU][PATCH v1 5/7] memory: add MemoryRegion map and unmap
 callbacks
In-Reply-To: <20231005181629.4046-6-vikram.garhwal@amd.com>
Message-ID: <alpine.DEB.2.22.394.2310091715430.3431292@ubuntu-linux-20-04-desktop>
References: <20231005181629.4046-1-vikram.garhwal@amd.com>
 <20231005181629.4046-6-vikram.garhwal@amd.com>
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
> In order to support mapping and unmapping guest memory dynamically to
> and from qemu during address_space_[un]map() operations add the map()
> and unmap() callbacks to MemoryRegionOps.
> 
> Those will be used e.g. for Xen grant mappings when performing guest
> I/Os.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>

Can't we just use the existing Xen hooks in qemu_ram_ptr_length and
xen_invalidate_map_cache_entry? Do we really need new ones?


> ---
>  include/exec/memory.h | 21 ++++++++++++++++++
>  softmmu/physmem.c     | 50 +++++++++++++++++++++++++++++++++----------
>  2 files changed, 60 insertions(+), 11 deletions(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index c99842d2fc..f3c62d2883 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -280,6 +280,27 @@ struct MemoryRegionOps {
>                                      unsigned size,
>                                      MemTxAttrs attrs);
>  
> +    /*
> +     * Dynamically create mapping. @addr is the guest address to map; @plen
> +     * is the pointer to the usable length of the buffer.
> +     * @mr contents can be changed in case a new memory region is created for
> +     * the mapping.
> +     * Returns the buffer address for accessing the data.
> +     */
> +    void *(*map)(MemoryRegion **mr,
> +                 hwaddr addr,
> +                 hwaddr *plen,
> +                 bool is_write,
> +                 MemTxAttrs attrs);
> +
> +    /* Unmap an area obtained via map() before. */
> +    void (*unmap)(MemoryRegion *mr,
> +                  void *buffer,
> +                  ram_addr_t addr,
> +                  hwaddr len,
> +                  bool is_write,
> +                  hwaddr access_len);
> +
>      enum device_endian endianness;
>      /* Guest-visible constraints: */
>      struct {
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index 6e5e379dd0..5f425bea1c 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -3135,6 +3135,7 @@ void *address_space_map(AddressSpace *as,
>      hwaddr len = *plen;
>      hwaddr l, xlat;
>      MemoryRegion *mr;
> +    void *ptr = NULL;
>      FlatView *fv;
>  
>      if (len == 0) {
> @@ -3168,12 +3169,20 @@ void *address_space_map(AddressSpace *as,
>          return bounce.buffer;
>      }
>  
> -
>      memory_region_ref(mr);
> +
> +    if (mr->ops && mr->ops->map) {
> +        ptr = mr->ops->map(&mr, addr, plen, is_write, attrs);
> +    }
> +
>      *plen = flatview_extend_translation(fv, addr, len, mr, xlat,
>                                          l, is_write, attrs);
>      fuzz_dma_read_cb(addr, *plen, mr);
> -    return qemu_ram_ptr_length(mr->ram_block, xlat, plen, true);
> +    if (ptr == NULL) {
> +        ptr = qemu_ram_ptr_length(mr->ram_block, xlat, plen, true);
> +    }
> +
> +    return ptr;
>  }
>  
>  /* Unmaps a memory region previously mapped by address_space_map().
> @@ -3189,11 +3198,16 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
>  
>          mr = memory_region_from_host(buffer, &addr1);
>          assert(mr != NULL);
> -        if (is_write) {
> -            invalidate_and_set_dirty(mr, addr1, access_len);
> -        }
> -        if (xen_enabled()) {
> -            xen_invalidate_map_cache_entry(buffer);
> +
> +        if (mr->ops && mr->ops->unmap) {
> +            mr->ops->unmap(mr, buffer, addr1, len, is_write, access_len);
> +        } else {
> +            if (is_write) {
> +                invalidate_and_set_dirty(mr, addr1, access_len);
> +            }
> +            if (xen_enabled()) {
> +                xen_invalidate_map_cache_entry(buffer);
> +            }
>          }
>          memory_region_unref(mr);
>          return;
> @@ -3266,10 +3280,18 @@ int64_t address_space_cache_init(MemoryRegionCache *cache,
>           * doing this if we found actual RAM, which behaves the same
>           * regardless of attributes; so UNSPECIFIED is fine.
>           */
> +        if (mr->ops && mr->ops->map) {
> +            cache->ptr = mr->ops->map(&mr, addr, &l, is_write,
> +                                      MEMTXATTRS_UNSPECIFIED);
> +        }
> +
>          l = flatview_extend_translation(cache->fv, addr, len, mr,
>                                          cache->xlat, l, is_write,
>                                          MEMTXATTRS_UNSPECIFIED);
> -        cache->ptr = qemu_ram_ptr_length(mr->ram_block, cache->xlat, &l, true);
> +        if (!cache->ptr) {
> +            cache->ptr = qemu_ram_ptr_length(mr->ram_block, cache->xlat, &l,
> +                                             true);
> +        }
>      } else {
>          cache->ptr = NULL;
>      }
> @@ -3291,14 +3313,20 @@ void address_space_cache_invalidate(MemoryRegionCache *cache,
>  
>  void address_space_cache_destroy(MemoryRegionCache *cache)
>  {
> -    if (!cache->mrs.mr) {
> +    MemoryRegion *mr = cache->mrs.mr;
> +
> +    if (!mr) {
>          return;
>      }
>  
> -    if (xen_enabled()) {
> +    if (mr->ops && mr->ops->unmap) {
> +            mr->ops->unmap(mr, cache->ptr, cache->xlat, cache->len,
> +                           cache->is_write, cache->len);
> +    } else if (xen_enabled()) {
>          xen_invalidate_map_cache_entry(cache->ptr);
>      }
> -    memory_region_unref(cache->mrs.mr);
> +
> +    memory_region_unref(mr);
>      flatview_unref(cache->fv);
>      cache->mrs.mr = NULL;
>      cache->fv = NULL;
> -- 
> 2.17.1
> 

