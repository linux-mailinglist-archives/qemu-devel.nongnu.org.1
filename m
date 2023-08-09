Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5A87763A2
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 17:24:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTl2m-00042X-9l; Wed, 09 Aug 2023 11:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yilun.xu@intel.com>)
 id 1qTkkN-0004Em-Md
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:05:15 -0400
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yilun.xu@intel.com>)
 id 1qTkkL-000718-AI
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691593513; x=1723129513;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=g9pq6B+mSe9PyjCgvZrOnLjd8YP/EmJQp5wp/gLGkHw=;
 b=GiG17GWXfX3z0Pjy60Dwq5GEGr9Flki5Bzca6QeNhJ+IXWQQE71I9nUE
 xL5JMGYAGJaytMwdqoSfD3zO5/nnTiFnncNmhaSpXxyRq8rCfVmv8oA2H
 Ps1LxaLK9Mld1rYRePjV3dR2dSKMe9zLIUld1EE6vWZky14TvwdA3jvMR
 l4RuuN/GUsKhDFpCHAcILG2IVUe5MROpH9zxPTpDZIXZ7Gp4ClB8WUP3X
 cjkkFv+Ly3aFdNEYfTLoaQTH7K56/IkGPrrnVD5V8GZ7Cb/bbCWOvpYBE
 QPouLyBN9ZQZ+s86+nTxTJenzPgdq5kMyr3hK61vYtTtWnRnccW8cbohq Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="373927974"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; d="scan'208";a="373927974"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2023 08:04:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="855568982"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; d="scan'208";a="855568982"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost)
 ([10.239.159.165])
 by orsmga004.jf.intel.com with ESMTP; 09 Aug 2023 08:04:41 -0700
Date: Wed, 9 Aug 2023 23:02:31 +0800
From: Xu Yilun <yilun.xu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC PATCH 15/19] kvm: handle KVM_EXIT_MEMORY_FAULT
Message-ID: <ZNOqhy1NlGzDA6/F@yilunxu-OptiPlex-7050>
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
 <20230731162201.271114-16-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731162201.271114-16-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=134.134.136.24; envelope-from=yilun.xu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 09 Aug 2023 11:24:14 -0400
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

On 2023-07-31 at 12:21:57 -0400, Xiaoyao Li wrote:
> From: Chao Peng <chao.p.peng@linux.intel.com>
> 
> Currently only KVM_MEMORY_EXIT_FLAG_PRIVATE in flags is valid when
> KVM_EXIT_MEMORY_FAULT happens. It indicates userspace needs to do
> the memory conversion on the RAMBlock to turn the memory into desired
> attribute, i.e., private/shared.
> 
> Note, KVM_EXIT_MEMORY_FAULT makes sense only when the RAMBlock has
> gmem memory backend.
> 
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  accel/kvm/kvm-all.c | 52 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index f9b5050b8885..72d50b923bf2 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3040,6 +3040,48 @@ static void kvm_eat_signals(CPUState *cpu)
>      } while (sigismember(&chkset, SIG_IPI));
>  }
>  
> +static int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
> +{
> +    MemoryRegionSection section;
> +    void *addr;
> +    RAMBlock *rb;
> +    ram_addr_t offset;
> +    int ret = -1;
> +
> +    section = memory_region_find(get_system_memory(), start, size);
> +    if (!section.mr) {
> +        return ret;
> +    }
> +
> +    if (memory_region_can_be_private(section.mr)) {
> +        if (to_private) {
> +            ret = kvm_set_memory_attributes_private(start, size);
> +        } else {
> +            ret = kvm_set_memory_attributes_shared(start, size);
> +        }
> +
> +        if (ret) {
> +            return ret;

Should we unref the memory region before return?

Thanks,
Yilun

> +        }
> +
> +        addr = memory_region_get_ram_ptr(section.mr) +
> +               section.offset_within_region;
> +        rb = qemu_ram_block_from_host(addr, false, &offset);
> +        /*
> +         * With KVM_SET_MEMORY_ATTRIBUTES by kvm_set_memory_attributes(),
> +         * operation on underlying file descriptor is only for releasing
> +         * unnecessary pages.
> +         */
> +        ram_block_convert_range(rb, offset, size, to_private);
> +    } else {
> +        warn_report("Convert non guest-memfd backed memory region (0x%"HWADDR_PRIx" ,+ 0x%"HWADDR_PRIx") to %s",
> +                    start, size, to_private ? "private" : "shared");
> +    }
> +
> +    memory_region_unref(section.mr);
> +    return ret;
> +}

