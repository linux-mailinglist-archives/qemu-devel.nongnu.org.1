Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC07C7BEF89
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 02:11:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq0Kr-00085K-JE; Mon, 09 Oct 2023 20:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qq0Kp-000857-LM
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 20:10:51 -0400
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qq0Kn-00027F-O1
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 20:10:51 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id C6260B8185D;
 Tue, 10 Oct 2023 00:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0F0C433C7;
 Tue, 10 Oct 2023 00:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696896647;
 bh=tFUz1xPnvqHJrFSG5XPdbr22H6rsXSRlAt4/kK2V5Lw=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=cYs+F17OsXIZQOm9Ohx+VDuvyjBK48bfJauDUp6fl1yM83XG6gjtkQUpoaYTFPzb+
 PfHqRWwCpDHoH30xeEpXPA/2RusTiyRjYKVEM5JxkVGI7QpdXIvqoy8cYAgVF4uxef
 cCtjcG6RtUYbBba5xhimsHgJbRY9e2EB+U0ny+NNbm6AJ6MhWj5F+zld+5zi4pAoVp
 /mR4XylxQCqUxhjyvuilSst18PLbAWfdj4QsEtT0KUfAUFMZYe/yxrS2XdR0jVSgPK
 qDgAB4rSH3c2NSpuYENJcu9H8lf/OJ7ZK8qdKbVQpb9iks0STM/810TLCRQgk+jaQQ
 xktzrM0+wJLSg==
Date: Mon, 9 Oct 2023 17:10:43 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Vikram Garhwal <vikram.garhwal@amd.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, 
 Juergen Gross <jgross@suse.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [QEMU][PATCH v1 3/7] softmmu: let qemu_map_ram_ptr() use
 qemu_ram_ptr_length()
In-Reply-To: <20231005181629.4046-4-vikram.garhwal@amd.com>
Message-ID: <alpine.DEB.2.22.394.2310091703070.3431292@ubuntu-linux-20-04-desktop>
References: <20231005181629.4046-1-vikram.garhwal@amd.com>
 <20231005181629.4046-4-vikram.garhwal@amd.com>
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
> qemu_map_ram_ptr() and qemu_ram_ptr_length() share quite some code, so
> modify qemu_ram_ptr_length() a little bit and use it for
> qemu_map_ram_ptr(), too.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>

This patch also doesn't apply due to code movement.

Other than that, the patch looks good to me


> ---
>  softmmu/physmem.c | 58 +++++++++++++++++++----------------------------
>  1 file changed, 23 insertions(+), 35 deletions(-)
> 
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index e182a2fa07..6e5e379dd0 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -2163,38 +2163,8 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
>  }
>  #endif /* !_WIN32 */
>  
> -/* Return a host pointer to ram allocated with qemu_ram_alloc.
> - * This should not be used for general purpose DMA.  Use address_space_map
> - * or address_space_rw instead. For local memory (e.g. video ram) that the
> - * device owns, use memory_region_get_ram_ptr.
> - *
> - * Called within RCU critical section.
> - */
> -void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
> -{
> -    RAMBlock *block = ram_block;
> -
> -    if (block == NULL) {
> -        block = qemu_get_ram_block(addr);
> -        addr -= block->offset;
> -    }
> -
> -    if (xen_enabled() && block->host == NULL) {
> -        /* We need to check if the requested address is in the RAM
> -         * because we don't want to map the entire memory in QEMU.
> -         * In that case just map until the end of the page.
> -         */
> -        if (block->offset == 0) {
> -            return xen_map_cache(addr, 0, 0, false);
> -        }
> -
> -        block->host = xen_map_cache(block->offset, block->max_length, 1, false);
> -    }
> -    return ramblock_ptr(block, addr);
> -}
> -
> -/* Return a host pointer to guest's ram. Similar to qemu_map_ram_ptr
> - * but takes a size argument.
> +/*
> + * Return a host pointer to guest's ram.
>   *
>   * Called within RCU critical section.
>   */
> @@ -2202,7 +2172,9 @@ static void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
>                                   hwaddr *size, bool lock)
>  {
>      RAMBlock *block = ram_block;
> -    if (*size == 0) {
> +    hwaddr len = 0;
> +
> +    if (size && *size == 0) {
>          return NULL;
>      }
>  
> @@ -2210,7 +2182,10 @@ static void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
>          block = qemu_get_ram_block(addr);
>          addr -= block->offset;
>      }
> -    *size = MIN(*size, block->max_length - addr);
> +    if (size) {
> +        *size = MIN(*size, block->max_length - addr);
> +        len = *size;
> +    }
>  
>      if (xen_enabled() && block->host == NULL) {
>          /* We need to check if the requested address is in the RAM
> @@ -2218,7 +2193,7 @@ static void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
>           * In that case just map the requested area.
>           */
>          if (block->offset == 0) {
> -            return xen_map_cache(addr, *size, lock, lock);
> +            return xen_map_cache(addr, len, lock, lock);
>          }
>  
>          block->host = xen_map_cache(block->offset, block->max_length, 1, lock);
> @@ -2227,6 +2202,19 @@ static void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
>      return ramblock_ptr(block, addr);
>  }
>  
> +/*
> + * Return a host pointer to ram allocated with qemu_ram_alloc.
> + * This should not be used for general purpose DMA.  Use address_space_map
> + * or address_space_rw instead. For local memory (e.g. video ram) that the
> + * device owns, use memory_region_get_ram_ptr.
> + *
> + * Called within RCU critical section.
> + */
> +void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
> +{
> +    return qemu_ram_ptr_length(ram_block, addr, NULL, false);
> +}
> +
>  /* Return the offset of a hostpointer within a ramblock */
>  ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host)
>  {
> -- 
> 2.17.1
> 

