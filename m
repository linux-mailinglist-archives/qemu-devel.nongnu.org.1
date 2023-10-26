Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE9E7D7A23
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 03:26:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvp7t-0005sr-KH; Wed, 25 Oct 2023 21:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qvp7p-0005nd-Bj
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 21:25:30 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1qvp7n-0006Mc-4p
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 21:25:29 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 205BACE3C7E;
 Thu, 26 Oct 2023 01:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDDCC433C7;
 Thu, 26 Oct 2023 01:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1698283522;
 bh=jdfrcJhpkrqS9FdZhZFoxKCUgKEap7xhVrmb9u0WZHg=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=mO5FiUFs35JfDyeoyjAheZJNoBFyN5hzg3n1JRAZsC9mEV3NgRvocZEwiycfPPl59
 ln7e1nFAxyYvIAnPTkV1yqR0O9+Ks3t01v+2/rb+enmqP4shGiqFtacZ/xAaZm/hze
 aLDLOqPjXy8rmvXM8uiVCh6BDxsM20YptpZEfVNfPnwTqBx5i0IC1SmIYp7ndtPyGz
 I3XRrcIM19cMnA84H6swTfsUCLCz+Bw1JqLBQQJUm1PlxsVvYH2/PrvXyc5jpv2Dcj
 FLiJEp36eTKlijPnHOHAodgyMjMTmuGK+xqcQoJeHmN994K+yxC/Ww3LUdxcqiUV5W
 AKAQAAz/fywOg==
Date: Wed, 25 Oct 2023 18:25:19 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Vikram Garhwal <vikram.garhwal@amd.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [QEMU][PATCHv2 2/8] softmmu: physmem: Split ram_block_add()
In-Reply-To: <20231025212422.30371-3-vikram.garhwal@amd.com>
Message-ID: <alpine.DEB.2.22.394.2310251825130.271731@ubuntu-linux-20-04-desktop>
References: <20231025212422.30371-1-vikram.garhwal@amd.com>
 <20231025212422.30371-3-vikram.garhwal@amd.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=sstabellini@kernel.org; helo=sin.source.kernel.org
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

On Wed, 25 Oct 2023, Vikram Garhwal wrote:
> Extract ram block list update to a new function ram_block_add_list(). This is
> done to support grant mappings which adds a memory region for granted memory and
> updates the ram_block list.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  include/exec/ram_addr.h |  1 +
>  system/physmem.c        | 62 ++++++++++++++++++++++++++---------------
>  2 files changed, 40 insertions(+), 23 deletions(-)
> 
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 90676093f5..c0b5f9a7d0 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -139,6 +139,7 @@ void qemu_ram_free(RAMBlock *block);
>  int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp);
>  
>  void qemu_ram_msync(RAMBlock *block, ram_addr_t start, ram_addr_t length);
> +void ram_block_add_list(RAMBlock *new_block);
>  
>  /* Clear whole block of mem */
>  static inline void qemu_ram_block_writeback(RAMBlock *block)
> diff --git a/system/physmem.c b/system/physmem.c
> index fc2b0fee01..7a7f95b8b9 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -1803,12 +1803,47 @@ static void dirty_memory_extend(ram_addr_t old_ram_size,
>      }
>  }
>  
> +static void ram_block_add_list_locked(RAMBlock *new_block)
> + {
> +     RAMBlock *block;
> +     RAMBlock *last_block = NULL;
> +
> +    /*
> +     * Keep the list sorted from biggest to smallest block.  Unlike QTAILQ,
> +     * QLIST (which has an RCU-friendly variant) does not have insertion at
> +     * tail, so save the last element in last_block.
> +     */
> +    RAMBLOCK_FOREACH(block) {
> +        last_block = block;
> +        if (block->max_length < new_block->max_length) {
> +            break;
> +        }
> +    }
> +    if (block) {
> +        QLIST_INSERT_BEFORE_RCU(block, new_block, next);
> +    } else if (last_block) {
> +        QLIST_INSERT_AFTER_RCU(last_block, new_block, next);
> +    } else { /* list is empty */
> +        QLIST_INSERT_HEAD_RCU(&ram_list.blocks, new_block, next);
> +    }
> +    ram_list.mru_block = NULL;
> +
> +    /* Write list before version */
> +    smp_wmb();
> +    ram_list.version++;
> +}
> +
> +void ram_block_add_list(RAMBlock *new_block)
> +{
> +    qemu_mutex_lock_ramlist();
> +    ram_block_add_list_locked(new_block);
> +    qemu_mutex_unlock_ramlist();
> +}
> +
>  static void ram_block_add(RAMBlock *new_block, Error **errp)
>  {
>      const bool noreserve = qemu_ram_is_noreserve(new_block);
>      const bool shared = qemu_ram_is_shared(new_block);
> -    RAMBlock *block;
> -    RAMBlock *last_block = NULL;
>      ram_addr_t old_ram_size, new_ram_size;
>      Error *err = NULL;
>  
> @@ -1846,28 +1881,9 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>      if (new_ram_size > old_ram_size) {
>          dirty_memory_extend(old_ram_size, new_ram_size);
>      }
> -    /* Keep the list sorted from biggest to smallest block.  Unlike QTAILQ,
> -     * QLIST (which has an RCU-friendly variant) does not have insertion at
> -     * tail, so save the last element in last_block.
> -     */
> -    RAMBLOCK_FOREACH(block) {
> -        last_block = block;
> -        if (block->max_length < new_block->max_length) {
> -            break;
> -        }
> -    }
> -    if (block) {
> -        QLIST_INSERT_BEFORE_RCU(block, new_block, next);
> -    } else if (last_block) {
> -        QLIST_INSERT_AFTER_RCU(last_block, new_block, next);
> -    } else { /* list is empty */
> -        QLIST_INSERT_HEAD_RCU(&ram_list.blocks, new_block, next);
> -    }
> -    ram_list.mru_block = NULL;
>  
> -    /* Write list before version */
> -    smp_wmb();
> -    ram_list.version++;
> +    ram_block_add_list_locked(new_block);
> +
>      qemu_mutex_unlock_ramlist();
>  
>      cpu_physical_memory_set_dirty_range(new_block->offset,
> -- 
> 2.17.1
> 

