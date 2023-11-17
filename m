Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D267EF8C0
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 21:37:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r45Yx-0004lF-2k; Fri, 17 Nov 2023 15:35:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1r45Yu-0004kh-Jp
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 15:35:36 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1r45Yr-0003Ch-MS
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 15:35:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700253334; x=1731789334;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ljCjq1+xc8Fj39kUso8LFL0h1hRR9SHQuzNazVjwe3Q=;
 b=BMLjk9VlVfJy093054SdSjRGcg69E7vRnHgbNtiEBgLNKUgKpY7+WRMl
 W2dH125Rb/5PeRg7FQWxHUnpbCkQv/KEC9GkBi9OYlNoG05vYid/bNsR6
 j6wkWJ5kF4yGKmqlVkSBXHHZuBCFiPbZRJYjo6jSb/Nxbw9HChfRAH96j
 5JAeeDVlsI8tlj43Sf4bu5lHpYk8j+A+04mEzXM9xQIt8rakl6jBvl4Ps
 oIQewaUA3IK2qTCK66eSCVMdjWH2584Xr8BN3vaMMgaozz4JtELmu7knd
 TW7zX4uiduEIToSJnIBlCdUDz0B1wyyvBzLt4ZEl1wUdhzxyQN+ztlKHK A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="4449337"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="4449337"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2023 12:35:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="759258431"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; d="scan'208";a="759258431"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2023 12:35:29 -0800
Date: Fri, 17 Nov 2023 12:35:28 -0800
From: Isaku Yamahata <isaku.yamahata@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Michael Roth <michael.roth@amd.com>,
 Sean Christopherson <seanjc@google.com>,
 Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 isaku.yamahata@linux.intel.com, isaku.yamahata@intel.com
Subject: Re: [PATCH v3 02/70] RAMBlock: Add support of KVM private guest memfd
Message-ID: <20231117203528.GA1645850@ls.amr.corp.intel.com>
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
 <20231115071519.2864957-3-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231115071519.2864957-3-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=isaku.yamahata@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Nov 15, 2023 at 02:14:11AM -0500,
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> diff --git a/system/physmem.c b/system/physmem.c
> index fc2b0fee0188..0af2213cbd9c 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -1841,6 +1841,20 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>          }
>      }
>  
> +#ifdef CONFIG_KVM
> +    if (kvm_enabled() && new_block->flags & RAM_GUEST_MEMFD &&
> +        new_block->guest_memfd < 0) {
> +        /* TODO: to decide if KVM_GUEST_MEMFD_ALLOW_HUGEPAGE is supported */
> +        uint64_t flags = 0;
> +        new_block->guest_memfd = kvm_create_guest_memfd(new_block->max_length,
> +                                                        flags, errp);
> +        if (new_block->guest_memfd < 0) {
> +            qemu_mutex_unlock_ramlist();
> +            return;
> +        }
> +    }
> +#endif
> +

We should define kvm_create_guest_memfd() stub in accel/stub/kvm-stub.c.
We can remove this #ifdef.
-- 
Isaku Yamahata <isaku.yamahata@linux.intel.com>

