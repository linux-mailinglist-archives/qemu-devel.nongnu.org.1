Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5960A64149
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Mar 2025 07:20:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu3p6-00066u-OW; Mon, 17 Mar 2025 02:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tony.lindgren@linux.intel.com>)
 id 1tu3on-00060P-9g
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 02:19:21 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tony.lindgren@linux.intel.com>)
 id 1tu3ok-0005sO-Ps
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 02:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742192359; x=1773728359;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=h0BsSohuwjOJjBU5oHdhP3ZYhu82D4a41VuNYAddxVI=;
 b=NnzrL6HZgp832cheEeENTVSnXt3KHHZkF1zLaa+bTcKd/LAlXaMNtLXm
 O+gP3kNdgpyuA1aXQ7IUGp2/eJ83f0/XL3/VILu0hI1FnAx51zKqblqCd
 hBfzE2RHP5Qu9Ja4aG1hvXE0QGtT187CR0bJE8QsU72ou9VeHayVdDfN+
 vFxjcP9+jzgKDfwjjMp8NrmpzSuTcLsg8Vjc129TZkIE7eREBSc7fAF0K
 EC9QGWqMlA6QBaDP/Ku1EBLtYiWkBk3fL1krBQlrstyCNOHHNWLbCVcjk
 zVAX4GYB/3b7Laj0LvKBviZEdx/fzdt0yVlyOd7adh0p2Gs8Rg0S5EiWT w==;
X-CSE-ConnectionGUID: PuHWsK8lTQuq9qnzyEJVug==
X-CSE-MsgGUID: 8wsIvlqqRjG6dWXxgT6ALg==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="60664467"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; d="scan'208";a="60664467"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2025 23:19:07 -0700
X-CSE-ConnectionGUID: k0gWf8DHS9GhD4uHidG+4w==
X-CSE-MsgGUID: N//J7haCQVeK8ULxe6wvBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; d="scan'208";a="122590083"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.246.8])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2025 23:19:01 -0700
Date: Mon, 17 Mar 2025 08:18:56 +0200
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: David Hildenbrand <david@redhat.com>,
 Alexey Kardashevskiy <aik@amd.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>,
 "Maloor, Kishen" <kishen.maloor@intel.com>
Subject: Re: [PATCH v3 6/7] memory: Attach MemoryAttributeManager to
 guest_memfd-backed RAMBlocks
Message-ID: <Z9e-0OcFoKpaG796@tlindgre-MOBL1>
References: <20250310081837.13123-1-chenyi.qiang@intel.com>
 <20250310081837.13123-7-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310081837.13123-7-chenyi.qiang@intel.com>
Received-SPF: none client-ip=198.175.65.10;
 envelope-from=tony.lindgren@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.333,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi,

On Mon, Mar 10, 2025 at 04:18:34PM +0800, Chenyi Qiang wrote:
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -1885,6 +1886,16 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>              qemu_mutex_unlock_ramlist();
>              goto out_free;
>          }
> +
> +        new_block->memory_attribute_manager = MEMORY_ATTRIBUTE_MANAGER(object_new(TYPE_MEMORY_ATTRIBUTE_MANAGER));
> +        if (memory_attribute_manager_realize(new_block->memory_attribute_manager, new_block->mr)) {
> +            error_setg(errp, "Failed to realize memory attribute manager");
> +            object_unref(OBJECT(new_block->memory_attribute_manager));
> +            close(new_block->guest_memfd);
> +            ram_block_discard_require(false);
> +            qemu_mutex_unlock_ramlist();
> +            goto out_free;
> +        }
>      }
>  
>      ram_size = (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS;

Might as well put the above into a separate memory manager init function
to start with. It keeps the goto out_free error path unified, and makes
things more future proof if the rest of ram_block_add() ever develops a
need to check for errors.

Regards,

Tony

