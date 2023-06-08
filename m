Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE8B72763A
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 06:39:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q77Pg-0001lt-8U; Thu, 08 Jun 2023 00:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1q77Pd-0001lb-JB
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 00:38:17 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1q77Pb-00024N-DC
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 00:38:17 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1b026657a6fso875345ad.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 21:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686199093; x=1688791093;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wTSOFzhf2LvbO/f18aHFxbTWWRqmnOPeGB/+V0fARF0=;
 b=Hxdi6NBuMPQ1mGOD4h2MUw/VQWK48IDZeu68Ch1Zw7dMvFBMTi+oerNB09iE7hyLiL
 vZ0JMywmm6m+UsQEI1Czocd7TWBP1GAaxUsFPK+nwoIo68zYSQaicYgA0AVVtdaN3hxC
 ww8s/VI27frfrftXNr26ygj8NnSjeIzcvZ8iaTXQqW3fRxdM/14NiZrIbUqm8cOTy3LW
 L1Sla6wDUf4ttNoARfkL+CJcES8DNVoK1zzkKGqIBe/8c99dd7lJzErerlGCF9oCMXbU
 5ByvqdCsGi9NSNzjxDUbma1aWLio3t2DutLJIIpzM6s13qmPK9V+lg37S0zH1slnHrJ2
 x3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686199093; x=1688791093;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wTSOFzhf2LvbO/f18aHFxbTWWRqmnOPeGB/+V0fARF0=;
 b=JL/33bZbwGeVl3116n4EATEv4nC00iEng91uqIczOz0OTJZnVAEbke+Y1TQOossC7l
 yt8QsHGzQ/CkBRAImoR312hMQNPV9WyxXQHJ/ijZP1liUes2+4CsEa0bM09qXQILbE5j
 f64pr8PUePYvFQyOI59sb5uD/yQDUYFcsfDC1uG+yHUndAvF31NhgBZe84bqBpvLZu32
 cVju2T6Iv97P3m5YPPHqZAcxSIFn7tjnOXmocc4yIUCwBDIwMxz6KijOQn8thbHNnqme
 0eQEPXVvOGkhlIvVj1YKlVLc1UovEUa1h25swTmV7eHfe8dXZeg8x+1ezvGRve2cwTTK
 e+mw==
X-Gm-Message-State: AC+VfDyq7ttXZUGm2bGWhXU/1VJjT0yhE3cKTSnXIlrooVzM9Q285mRh
 xbAP0euF+Ck+hBGAw1Dx/58=
X-Google-Smtp-Source: ACHHUZ4JLtQp1wbJvbBxyqfIUoQ7eVqhYzAImG0w4ZtrnuzeHLvHZOZu0NGlyX0Ex0Nr8vyAtJapgw==
X-Received: by 2002:a17:903:18c:b0:1b1:4801:f516 with SMTP id
 z12-20020a170903018c00b001b14801f516mr8392723plg.68.1686199093206; 
 Wed, 07 Jun 2023 21:38:13 -0700 (PDT)
Received: from localhost ([192.55.54.50]) by smtp.gmail.com with ESMTPSA id
 n10-20020a170902e54a00b001b01448ba72sm323640plf.215.2023.06.07.21.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 21:38:12 -0700 (PDT)
Date: Wed, 7 Jun 2023 21:38:10 -0700
From: Isaku Yamahata <isaku.yamahata@gmail.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: akpm@linux-foundation.org, mike.kravetz@oracle.com,
 muchun.song@linux.dev, pbonzini@redhat.com, seanjc@google.com,
 shuah@kernel.org, willy@infradead.org, brauner@kernel.org,
 chao.p.peng@linux.intel.com, coltonlewis@google.com,
 david@redhat.com, dhildenb@redhat.com, dmatlack@google.com,
 erdemaktas@google.com, hughd@google.com, isaku.yamahata@gmail.com,
 jarkko@kernel.org, jmattson@google.com, joro@8bytes.org,
 jthoughton@google.com, jun.nakajima@intel.com,
 kirill.shutemov@linux.intel.com, liam.merwick@oracle.com,
 mail@maciej.szmigiero.name, mhocko@suse.com, michael.roth@amd.com,
 qperret@google.com, rientjes@google.com, rppt@kernel.org,
 steven.price@arm.com, tabba@google.com, vannapurve@google.com,
 vbabka@suse.cz, vipinsh@google.com, vkuznets@redhat.com,
 wei.w.wang@intel.com, yu.c.zhang@linux.intel.com,
 kvm@vger.kernel.org, linux-api@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 qemu-devel@nongnu.org, x86@kernel.org
Subject: Re: [RFC PATCH 00/19] hugetlb support for KVM guest_mem
Message-ID: <20230608043810.GJ2244082@ls.amr.corp.intel.com>
References: <cover.1686077275.git.ackerleytng@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=isaku.yamahata@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jun 06, 2023 at 07:03:45PM +0000,
Ackerley Tng <ackerleytng@google.com> wrote:

> Hello,
> 
> This patchset builds upon a soon-to-be-published WIP patchset that Sean
> published at https://github.com/sean-jc/linux/tree/x86/kvm_gmem_solo, mentioned
> at [1].
> 
> The tree can be found at:
> https://github.com/googleprodkernel/linux-cc/tree/gmem-hugetlb-rfc-v1
> 
> In this patchset, hugetlb support for KVM's guest_mem (aka gmem) is introduced,
> allowing VM private memory (for confidential computing) to be backed by hugetlb
> pages.
> 
> guest_mem provides userspace with a handle, with which userspace can allocate
> and deallocate memory for confidential VMs without mapping the memory into
> userspace.
> 
> Why use hugetlb instead of introducing a new allocator, like gmem does for 4K
> and transparent hugepages?
> 
> + hugetlb provides the following useful functionality, which would otherwise
>   have to be reimplemented:
>     + Allocation of hugetlb pages at boot time, including
>         + Parsing of kernel boot parameters to configure hugetlb
>         + Tracking of usage in hstate
>         + gmem will share the same system-wide pool of hugetlb pages, so users
>           don't have to have separate pools for hugetlb and gmem
>     + Page accounting with subpools
>         + hugetlb pages are tracked in subpools, which gmem uses to reserve
>           pages from the global hstate
>     + Memory charging
>         + hugetlb provides code that charges memory to cgroups
>     + Reporting: hugetlb usage and availability are available at /proc/meminfo,
>       etc
> 
> The first 11 patches in this patchset is a series of refactoring to decouple
> hugetlb and hugetlbfs.
> 
> The central thread binding the refactoring is that some functions (like
> inode_resv_map(), inode_subpool(), inode_hstate(), etc) rely on a hugetlbfs
> concept, that the resv_map, subpool, hstate, are in a specific field in a
> hugetlb inode.
> 
> Refactoring to parametrize functions by hstate, subpool, resv_map will allow
> hugetlb to be used by gmem and in other places where these data structures
> aren't necessarily stored in the same positions in the inode.
> 
> The refactoring proposed here is just the minimum required to get a
> proof-of-concept working with gmem. I would like to get opinions on this
> approach before doing further refactoring. (See TODOs)
> 
> TODOs:
> 
> + hugetlb/hugetlbfs refactoring
>     + remove_inode_hugepages() no longer needs to be exposed, it is hugetlbfs
>       specific and used only in inode.c
>     + remove_mapping_hugepages(), remove_inode_single_folio(),
>       hugetlb_unreserve_pages() shouldn't need to take inode as a parameter
>         + Updating inode->i_blocks can be refactored to a separate function and
>           called from hugetlbfs and gmem
>     + alloc_hugetlb_folio_from_subpool() shouldn't need to be parametrized by
>       vma
>     + hugetlb_reserve_pages() should be refactored to be symmetric with
>       hugetlb_unreserve_pages()
>         + It should be parametrized by resv_map
>         + alloc_hugetlb_folio_from_subpool() could perhaps use
>           hugetlb_reserve_pages()?
> + gmem
>     + Figure out if resv_map should be used by gmem at all
>         + Probably needs more refactoring to decouple resv_map from hugetlb
>           functions

Hi. If kvm gmem is compiled as kernel module, many symbols are failed to link.
You need to add EXPORT_SYMBOL{,_GPL} for exported symbols.
Or compile it to kernel instead of module?

Thanks,

> Questions for the community:
> 
> 1. In this patchset, every gmem file backed with hugetlb is given a new
>    subpool. Is that desirable?
>     + In hugetlbfs, a subpool always belongs to a mount, and hugetlbfs has one
>       mount per hugetlb size (2M, 1G, etc)
>     + memfd_create(MFD_HUGETLB) effectively returns a full hugetlbfs file, so it
>       (rightfully) uses the hugetlbfs kernel mounts and their subpools
>     + I gave each file a subpool mostly to speed up implementation and still be
>       able to reserve hugetlb pages from the global hstate based on the gmem
>       file size.
>     + gmem, unlike hugetlbfs, isn't meant to be a full filesystem, so
>         + Should there be multiple mounts, one for each hugetlb size?
>         + Will the mounts be initialized on boot or on first gmem file creation?
>         + Or is one subpool per gmem file fine?
> 2. Should resv_map be used for gmem at all, since gmem doesn't allow userspace
>    reservations?
> 
> [1] https://lore.kernel.org/lkml/ZEM5Zq8oo+xnApW9@google.com/
> 
> ---
> 
> Ackerley Tng (19):
>   mm: hugetlb: Expose get_hstate_idx()
>   mm: hugetlb: Move and expose hugetlbfs_zero_partial_page
>   mm: hugetlb: Expose remove_inode_hugepages
>   mm: hugetlb: Decouple hstate, subpool from inode
>   mm: hugetlb: Allow alloc_hugetlb_folio() to be parametrized by subpool
>     and hstate
>   mm: hugetlb: Provide hugetlb_filemap_add_folio()
>   mm: hugetlb: Refactor vma_*_reservation functions
>   mm: hugetlb: Refactor restore_reserve_on_error
>   mm: hugetlb: Use restore_reserve_on_error directly in filesystems
>   mm: hugetlb: Parametrize alloc_hugetlb_folio_from_subpool() by
>     resv_map
>   mm: hugetlb: Parametrize hugetlb functions by resv_map
>   mm: truncate: Expose preparation steps for truncate_inode_pages_final
>   KVM: guest_mem: Refactor kvm_gmem fd creation to be in layers
>   KVM: guest_mem: Refactor cleanup to separate inode and file cleanup
>   KVM: guest_mem: hugetlb: initialization and cleanup
>   KVM: guest_mem: hugetlb: allocate and truncate from hugetlb
>   KVM: selftests: Add basic selftests for hugetlbfs-backed guest_mem
>   KVM: selftests: Support various types of backing sources for private
>     memory
>   KVM: selftests: Update test for various private memory backing source
>     types
> 
>  fs/hugetlbfs/inode.c                          | 102 ++--
>  include/linux/hugetlb.h                       |  86 ++-
>  include/linux/mm.h                            |   1 +
>  include/uapi/linux/kvm.h                      |  25 +
>  mm/hugetlb.c                                  | 324 +++++++-----
>  mm/truncate.c                                 |  24 +-
>  .../testing/selftests/kvm/guest_memfd_test.c  |  33 +-
>  .../testing/selftests/kvm/include/test_util.h |  14 +
>  tools/testing/selftests/kvm/lib/test_util.c   |  74 +++
>  .../kvm/x86_64/private_mem_conversions_test.c |  38 +-
>  virt/kvm/guest_mem.c                          | 488 ++++++++++++++----
>  11 files changed, 882 insertions(+), 327 deletions(-)
> 
> --
> 2.41.0.rc0.172.g3f132b7071-goog

-- 
Isaku Yamahata <isaku.yamahata@gmail.com>

